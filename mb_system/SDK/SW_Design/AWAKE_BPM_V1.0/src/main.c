/*
 * Communication interface for
 * E-linac in-house IF processing electronics
 * Developers: Victor Verzilov, TRIUMF Diagnostics Group
 * Based on Xilinx echo server example and the code by Freebody Zhang, UBC co-op student
 * Rev. 1.0: 	Xilinx code is modified to remove unnecessary parts.
 * Date: June 8, 2012
 * main.c
 */

#include <stdio.h>
#include "xparameters.h"
#include "netif/xadapter.h"
#include "platform.h"
#include "platform_config.h"
#include "xgpio_l.h"
#include "xio.h"
#include "xuartlite.h"
#include "xuartlite_l.h"
#include <xilflash.h>
#include "eth_server.h"

void print_app_header();		/* defined by each RAW mode application */
int start_eth_server(u8 port);
int uart_callback();

int span_flash_init(XFlash *FlashInstance);
int span_flash_read(XFlash *FlashInstance);
int span_flash_write(XFlash *FlashInstance);

int flash_buffer_2_fpga( );

void lwip_init();				/* missing declaration in lwIP */

void print_ip(char *msg, struct ip_addr *ip)
{
	print(msg);
	xil_printf("%d.%d.%d.%d\n\r", ip4_addr1(ip), ip4_addr2(ip),
			ip4_addr3(ip), ip4_addr4(ip));
}

void print_ip_settings(struct ip_addr *ip, struct ip_addr *mask, struct ip_addr *gw)
{
	print_ip("Board IP: ", ip);
	print_ip("Netmask : ", mask);
	print_ip("Gateway : ", gw);
}

/************************** Variable Definitions *****************************/
//XFlash FlashInstance; /* XFlash Instance. */

XFlash FlashInstance; /* XFlash Instance. */

extern u8 FlashDataBuffer[DATA_LEN]; /* This buffer is defined in sp_flash.c */

int main()
{

	int Status;
	struct netif *netif, server_netif;
	struct ip_addr ipaddr, netmask, gw;

//	XFlash FlashInstance; /* XFlash Instance. */

	struct Flash_Data_Struct *Flash_Data_Ptr = &FlashDataBuffer;

	unsigned char mac_ethernet_address[6];						           /* the mac address of the board */

	Status = span_flash_init(&FlashInstance);
	Status = span_flash_read(&FlashInstance); //read config info from FLASH into FlashDataBuffer, SL

	mac_ethernet_address[0] = Flash_Data_Ptr->boardMac[0];
	mac_ethernet_address[1] = Flash_Data_Ptr->boardMac[1];
	mac_ethernet_address[2] = Flash_Data_Ptr->boardMac[2];
	mac_ethernet_address[3] = Flash_Data_Ptr->boardMac[3];
	mac_ethernet_address[4] = Flash_Data_Ptr->boardMac[4];
	mac_ethernet_address[5] = Flash_Data_Ptr->boardMac[5];

	netif = &server_netif;

	init_platform();

	IP4_ADDR(&ipaddr,  Flash_Data_Ptr->boardIP[0], Flash_Data_Ptr->boardIP[1],  Flash_Data_Ptr->boardIP[2], Flash_Data_Ptr->boardIP[3]);			/* initliaze IP addresses to be used */
    IP4_ADDR(&netmask, Flash_Data_Ptr->boardIP_Mask[0], Flash_Data_Ptr->boardIP_Mask[1], Flash_Data_Ptr->boardIP_Mask[2],  Flash_Data_Ptr->boardIP_Mask[3]);
	IP4_ADDR(&gw,      Flash_Data_Ptr->boardGW[0], Flash_Data_Ptr->boardGW[1],  Flash_Data_Ptr->boardGW[2],  Flash_Data_Ptr->boardGW[3]);

	print_ip_settings(&ipaddr, &netmask, &gw);

	lwip_init();

	if (!xemac_add(netif, &ipaddr, &netmask, &gw, mac_ethernet_address, PLATFORM_EMAC_BASEADDR)) {	  	/* Add network interface to the netif_list */
		xil_printf("Error adding N/W interface\n\r");
		return -1;
	}
	netif_set_default(netif);				/*  set it as default  */

	platform_enable_interrupts();			/* now enable interrupts */

	netif_set_up(netif);					/* specify that the network if is up */

	start_eth_server((unsigned)Flash_Data_Ptr->IPport[0]);	/* start the application (web server, rxtest, txtest, etc..) */

	Status = flash_buffer_2_fpga( );        /* configure FPGA with data stored in flash */

	xil_printf("Firmware version:%s \n\r",Flash_Data_Ptr->boardIDN);
	xil_printf("FPGA version:%d \n\r",XIo_In32(BRAM_BASE_ADDR + FPGA_VER));

	while (1) {								/* receive and process packets */
		xemacif_input(netif);
		if(! XUartLite_IsReceiveEmpty(XPAR_UARTLITE_BASEADDR) ){
			uart_callback( );
		}
	}

	cleanup_platform();						/* never reached */

	return 0;
}
