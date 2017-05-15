/*
 * Communication interface for
 * E-linac in-house IF processing electronics
 * Developers: Victor Verzilov, TRIUMF Diagnostics Group
 * Based on Xilinx echo server exemaple and the code by Freebody Zhang, UBC co-op student
 * Rev. 1.0: 	Xilinx code is modified to remove unnecessary parts. Freebody code was essentially revised
 * Date: June 8, 2012
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "lwip/err.h"
#include "lwip/tcp.h"

//int cmd_proc(char *cmdString_in , int *value_back, char **string_back);
int cmd_proc(char *cmdString_in , int *value_back, char **string_back, int **array_Ptr, int *array_Dim);

char cmdString[50];									/**/
int eth_busy;
extern int uart_busy;

//------------- Callback function for received packets ----------------//
err_t recv_callback(void *arg, struct tcp_pcb *tpcb,
                               struct pbuf *p, err_t err)
{

	int value,sendTrue,strLength;
	int *array_Ptr,array_Dim,array_Index;
	char valueString[50], *string_back;

	if (!p) {											/* do not read the packet if we are not in ESTABLISHED state */
		tcp_close(tpcb);
		tcp_recv(tpcb, NULL);
		return ERR_OK;
	}

	tcp_recved(tpcb, p->len);							/* indicate that the packet has been received */

strcat(cmdString,p->payload);

if (strchr(cmdString, '\r') != NULL || strchr(cmdString, '\r') != NULL){     /* a termination character is found */
//	xil_printf("\n\r cmdString: %s \n\r", cmdString);
	while(uart_busy){}
	eth_busy = 1;
//	sendTrue = cmd_proc(cmdString,&value, &string_back);									 /* process the command */
	sendTrue = cmd_proc(cmdString,&value, &string_back, &array_Ptr, &array_Dim);
	eth_busy = 0;


	if (sendTrue != 0 ){
		if (sendTrue == 1){
			sprintf(valueString,"%d\n\r",value);
			strLength = strlen(valueString);
			if (tcp_sndbuf(tpcb) > strLength) {					/* echo back the payload */
				err = tcp_write(tpcb, valueString, strLength, 1);	/* in this case, we assume that the payload is < TCP_SND_BUF */
				//xil_printf("\n\r readback: %s \n\r", valueString);
			} else
				xil_printf("no space in tcp_sndbuf\n\r");
		}
		if (sendTrue == 2){
			//xil_printf("\n\r  string: %s , %x \n\r", string_back);
			sprintf(valueString,"%s\n\r",string_back);
			strLength = strlen(valueString);
			if (tcp_sndbuf(tpcb) > strLength) {					/* echo back the payload */
				err = tcp_write(tpcb, valueString, strLength, 1);	/* in this case, we assume that the payload is < TCP_SND_BUF */
			} else
				xil_printf("no space in tcp_sndbuf\n\r");
		}
		if (sendTrue == 3){
			//xil_printf("dim = %d\n\r",array_Dim);
			for (array_Index=0; array_Index<array_Dim; array_Index++){
				//xil_printf("Index = %d   Value = %x \n\r",array_Index, *(array_Ptr +array_Index));
				if(array_Index == array_Dim - 1)
					sprintf(valueString,"%d\n\r",*(array_Ptr +array_Index));
				else
					sprintf(valueString,"%d,",*(array_Ptr +array_Index));
				strLength = strlen(valueString);
				if (tcp_sndbuf(tpcb) > strLength) {					/* echo back the payload */
					err = tcp_write(tpcb, valueString, strLength, 1);	/* in this case, we assume that the payload is < TCP_SND_BUF */
				} else
					xil_printf("no space in tcp_sndbuf\n\r");
			}

		}
	}
	cmdString[0]= '\0';															/* Clear the command string */
}

	pbuf_free(p);										/* free the received pbuf */

	return ERR_OK;
}
//------------- Callback function for accepted connections ----------------//
err_t accept_callback(void *arg, struct tcp_pcb *newpcb, err_t err)
{
	static int connection = 1;

	tcp_recv(newpcb, recv_callback);					/* set the receive callback for this connection */

	tcp_arg(newpcb, (void*)connection);					/* just use an integer number indicating the connection id as the
														   callback argument */

	connection++;										/* increment for subsequent accepted connections */

	return ERR_OK;
}
//-------------------------- Setup TCP part ------------------------------//
int start_eth_server(unsigned portIP)
{
	struct tcp_pcb *pcb;
	err_t err;
	unsigned port;

	port = portIP;

	pcb = tcp_new();									/* create new TCP PCB structure */
	if (!pcb) {
		xil_printf("Error creating PCB. Out of Memory\n\r");
		return -1;
	}
	
	err = tcp_bind(pcb, IP_ADDR_ANY, port);				/* bind to specified @port */
	if (err != ERR_OK) {
		xil_printf("Unable to bind to port %d: err = %d\n\r", port, err);
		return -2;
	}

	tcp_arg(pcb, NULL);									/* we do not need any arguments to callback functions */

	pcb = tcp_listen(pcb);								/* listen for connections */
	if (!pcb) {
		xil_printf("Out of memory while tcp_listen\n\r");
		return -3;
	}

	tcp_accept(pcb, accept_callback);					/* specify callback to use for incoming connections */

	cmdString[0]= '\0';									/* Clear the command string */

	return 0;
}
