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
#include "xparameters.h"
#include "xuartlite.h"
#include "xuartlite_l.h"
#include  "eth_server.h"

//int cmd_proc(char *cmdString_in , int *value_back, char **string_back);
int cmd_proc(char *cmdString_in , int *value_back, char **string_back, int **array_Ptr, int *array_Dim);

char cmdString_u[50];									/**/
int cmdString_i;
int uart_busy;
extern int eth_busy;


//------------- Callback function for received characters ----------------//
int uart_callback( )
{

	int value,sendTrue;
	int *array_Ptr,array_Dim,array_Index;
	char valueString[50],*crChar,*string_back;

	    	cmdString_u[cmdString_i] = XUartLite_ReadReg(XPAR_UARTLITE_BASEADDR, XUL_RX_FIFO_OFFSET);

	          cmdString_i++;


if ((crChar = strchr(cmdString_u, '\r')) != NULL || strchr(cmdString_u, '\r') != NULL){     /* a termination character is found */
//	xil_printf("\n\r there is cr in cmdString: %s  \n\r", cmdString_u);
	while(eth_busy){}
	uart_busy = 1;
//	sendTrue = cmd_proc(cmdString_u,&value, &string_back );									 /* process the command */
	sendTrue = cmd_proc(cmdString_u , &value, &string_back, &array_Ptr, &array_Dim);
	uart_busy = 0;
	*crChar= '\0';	/* Replace CR */
	cmdString_i = 0;

	if (sendTrue != 0 ){
		if (sendTrue == 1){
			sprintf(valueString,"%d\n\r",value);
			xil_printf("%s", valueString);
		}
		if (sendTrue == 2){
//			xil_printf("\n\r  string: %s , %x \n\r", string_back);
			sprintf(valueString,"%s\n\r",string_back);
			xil_printf("%s", valueString);
		}
		if (sendTrue == 3){
//			xil_printf("dim = %d\n\r",array_Dim);
			for (array_Index=0; array_Index<array_Dim; array_Index++){
//				xil_printf("Index = %d   Value = %d \n\r",array_Index, *(array_Ptr +array_Index));
				if(array_Index == array_Dim - 1)
					sprintf(valueString,"%d\n\r",*(array_Ptr +array_Index));
				else
					sprintf(valueString,"%d,",*(array_Ptr +array_Index));
				xil_printf("%s", valueString);
			}

		}
	}

}

return 0;
}

