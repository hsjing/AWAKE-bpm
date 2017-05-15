/*
 * sp_flash.c
 *
 *  Created on: Jun 29, 2012
 *      Author: verzilov
 */


#include <xilflash.h>
#include <stdio.h>
#include <xil_types.h>
#include <stdlib.h>
#include "eth_server.h"

u8 FlashDataBuffer[DATA_LEN];

//struct Flash_Data_Struct *Flash_Data_Ptr = &FlashDataBuffer;

int span_flash_init(XFlash *FlashInstance)
{

	int Status;

	/* Initialize the Flash Library.*/

	Status = XFlash_Initialize(FlashInstance, FLASH_BASE_ADDRESS,
				   FLASH_MEM_WIDTH, 0);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
//	print("Init. successful!\r\n");
	/* Reset the Flash Device. This clears the Status registers and puts
	 * the device in Read mode.*/

	Status = XFlash_Reset(FlashInstance);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
//	print("Reset successful!\r\n");
	return XST_SUCCESS;
}
/********************************************************************/
int span_flash_read(XFlash *FlashInstance)
{
	int Status;
	Status = XFlash_Read(FlashInstance, START_ADDRESS, DATA_LEN, FlashDataBuffer);
		if(Status != XST_SUCCESS) {
			return XST_FAILURE;
	}
		return XST_SUCCESS;
}
/********************************************************************/
int span_flash_write(XFlash *FlashInstance)
{
	int Status;

	/* Perform the Erase operation.*/

	Status = XFlash_Erase(FlashInstance, START_ADDRESS, DATA_LEN);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	/* Perform the Write operation. */

	Status = XFlash_Write(FlashInstance, START_ADDRESS, DATA_LEN, FlashDataBuffer);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	return XST_SUCCESS;
}
