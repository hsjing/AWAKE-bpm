
/***************************** Include Files *********************************/
#include <xilflash.h>
#include <stdio.h>
#include <xil_types.h>
#include  <stdlib.h>
#include  <string.h>
/************************** Constant Definitions *****************************/



/*
 * The following constants define the base address and width the flash memory.
 * These constants map to the XPAR parameters created in the xparameters.h file.
 * They are defined here such that a user can easily change all the needed
 * parameters in one place.
 */
#define FLASH_BASE_ADDRESS	XPAR_LINEAR_FLASH_S_AXI_MEM0_BASEADDR    //XPAR_EMC_0_MEM0_BASEADDR
//#define FLASH_BASE_ADDRESS	XPAR_EMC_0_S_AXI_MEM0_BASEADDR    //XPAR_EMC_0_MEM0_BASEADDR


/*
 * The following constant defines the total byte width of the flash memory. The
 * user needs to update this width based on the flash width in the design/board.
 * The total flash width on some of the Xilinx boards is listed below.
 * -------------------------------
 * Board		Width
 * -------------------------------
 * ML403		4 (32 bit)
 * ML5xx		2 (16 bit)
 * Spartan3S 1600E	2 (16 bit)
 * Spartan-3A DSP	2 (16 bit)
 * Spartan-3A		2 (16 bit)
 * Spartan-3AN		2 (16 bit)
 * ML605		2 (16 bit)
 * SP605		2 (16 bit)
 * SP601		1 (8 bit)
 */
#define FLASH_MEM_WIDTH		2

#define FLASH_TEST_SIZE		256
#define START_ADDRESS		0x100000
#define BLOCK_OFFSET_ADDR	0x068000
#define DATA_LEN 256


/************************** Function Prototypes ******************************/
int FlashReadWriteExample(void);
/************************** Variable Definitions *****************************/
XFlash FlashInstance; /* XFlash Instance. */

u8 ReadBuffer[FLASH_TEST_SIZE]; /* Buffer used to store the data read. */
u8 WriteBuffer[FLASH_TEST_SIZE]; /* Write buffer. */
//u8 FlashDataBuffer[FLASH_TEST_SIZE];

int main(void)
{
	int Status;
	Status = FlashReadWriteExample();
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}


int FlashReadWriteExample(void)
{
	int Status;
	u32 Index;

	struct Flash_Data_Struct //this is so called flash buffer, it's 172 byte long now. Apr.7,2017
	{
		char boardMac[8];
		u8 boardIP[4];
		u8 boardIP_Mask[4];
		u8 boardGW[4];
		u8 IPport[4];
		u16 boardTRIG_TH;
		u16 boardTRIG_DT;
		u16 boardTRIG_DL;
		u16 boardEVT_LEN;
		u16 boardEVT_TAIL_LEN;
		u16 boardBL_LEN;
		u16 boardBPM_DIA;

		u32 boardCH_GAIN[4];
		u32 boardCAL_GAIN[4]; //added calibration gain and drift gain, removed adc offset, Angela Zhou, April,21,2016

		u16 boardMASK;
		u16 boardAFE;
		u16 boardCR;

		u32 boardCAL_K;
		u32 boardCAL_NFX;
		u32 boardCAL_NFY;

		char boardIDN[64];
	};

	struct Flash_Data_Struct *Flash_Data_Ptr;
	struct Flash_Data_Struct *Flash_Data_Ptr1;

	Flash_Data_Ptr = &WriteBuffer;

	Flash_Data_Ptr1 = &ReadBuffer;

	/*
	 * Initialize the Flash Library.
	 */
	Status = XFlash_Initialize(&FlashInstance, FLASH_BASE_ADDRESS,
				   FLASH_MEM_WIDTH, 0);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
//	print("Init. successful!\r\n");

	/*
	 * Reset the Flash Device. This clears the Status registers and puts
	 * the device in Read mode.
	 */
	Status = XFlash_Reset(&FlashInstance);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

//	print("Reset successful!\r\n");
	/*
	 * Perform an unlock operation before the erase operation for the Intel
	 * Flash. The erase operation will result in an error if the block is
	 * locked.
	 */
//	if ((FlashInstance.CommandSet == XFL_CMDSET_INTEL_STANDARD) ||
//	    (FlashInstance.CommandSet == XFL_CMDSET_INTEL_EXTENDED)) {
//		Status = XFlash_Unlock(&FlashInstance, BLOCK_OFFSET_ADDR, 0);
//		if(Status != XST_SUCCESS) {
//			return XST_FAILURE;
//		}
//	}

	/*
	 * Perform the Erase operation.
	 */
	Status = XFlash_Erase(&FlashInstance, START_ADDRESS, DATA_LEN);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Prepare the write buffer. Fill in the data need to be written into
	 * Flash Device.
	 */
//	for(Index = 0; Index < DATA_LEN; Index++) {
//		WriteBuffer[Index] = Index + 3;
//	}

	Flash_Data_Ptr->boardMac[0] = 0x00;
	Flash_Data_Ptr->boardMac[1] = 0x0a;
	Flash_Data_Ptr->boardMac[2] = 0x35;
	Flash_Data_Ptr->boardMac[3] = 0x00;
	Flash_Data_Ptr->boardMac[4] = 0x01;
	Flash_Data_Ptr->boardMac[5] = 0x26;
	Flash_Data_Ptr->boardIP[0] = 192;
	Flash_Data_Ptr->boardIP[1] = 168;
	Flash_Data_Ptr->boardIP[2] = 13;
	Flash_Data_Ptr->boardIP[3] = 26;
	Flash_Data_Ptr->boardIP_Mask[0] = 255;
	Flash_Data_Ptr->boardIP_Mask[1] = 255;
	Flash_Data_Ptr->boardIP_Mask[2] = 255;
	Flash_Data_Ptr->boardIP_Mask[3] = 0;
	Flash_Data_Ptr->boardGW[0] = 192;
	Flash_Data_Ptr->boardGW[1] = 168;
	Flash_Data_Ptr->boardGW[2] = 13;
	Flash_Data_Ptr->boardGW[3] = 1;
	Flash_Data_Ptr->IPport[0] = 23;
	Flash_Data_Ptr->IPport[1] = 0;
	Flash_Data_Ptr->IPport[2] = 0;
	Flash_Data_Ptr->IPport[3] = 0;

	Flash_Data_Ptr->boardTRIG_TH = 1000;
	Flash_Data_Ptr->boardTRIG_DT = 0;
	Flash_Data_Ptr->boardTRIG_DL = 0;
	Flash_Data_Ptr->boardEVT_LEN = 1024;
	Flash_Data_Ptr->boardEVT_TAIL_LEN = 800;
	Flash_Data_Ptr->boardBL_LEN = 40;
	Flash_Data_Ptr->boardBPM_DIA = 60;

	Flash_Data_Ptr->boardCH_GAIN[0] = 0x3f800000; //this is 1.0 in SF32 format
	Flash_Data_Ptr->boardCH_GAIN[1] = 0x3f800000;
	Flash_Data_Ptr->boardCH_GAIN[2] = 0x3f800000;
	Flash_Data_Ptr->boardCH_GAIN[3] = 0x3f800000;

	Flash_Data_Ptr->boardCAL_GAIN[0] = 0x3f800000;
	Flash_Data_Ptr->boardCAL_GAIN[1] = 0x3f800000;
	Flash_Data_Ptr->boardCAL_GAIN[2] = 0x3f800000;
	Flash_Data_Ptr->boardCAL_GAIN[3] = 0x3f800000;

	Flash_Data_Ptr->boardAFE = 0x3E1F;
	//Flash_Data_Ptr->boardMASK = 0x0;

	Flash_Data_Ptr->boardCR = 0x0100; //Ex trig + BLR readout
	Flash_Data_Ptr->boardCAL_K = 0x3f800000;
	Flash_Data_Ptr->boardCAL_NFX = 0x3f800000;
	Flash_Data_Ptr->boardCAL_NFY = 0x3f800000;

	strcpy(Flash_Data_Ptr->boardIDN,"TRIUMF-AWAKE,BPM404,FMRev20170421");

	/*
	 * Perform the Write operation.
	 */
	Status = XFlash_Write(&FlashInstance, START_ADDRESS, DATA_LEN,
								WriteBuffer);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}



	Status = XFlash_Read(&FlashInstance, START_ADDRESS, DATA_LEN,
								ReadBuffer);
		if(Status != XST_SUCCESS) {
			return XST_FAILURE;
	}
		xil_printf ("\n\n\n\r");
//for (Index=0; Index  <DATA_LEN; Index++)
//printf (" value: 0x%X\n\r", ReadBuffer[Index]);

xil_printf (" MAC: 0x%X 0x%X 0x%X 0x%X 0x%X 0x%X \n\r", Flash_Data_Ptr1->boardMac[0],Flash_Data_Ptr1->boardMac[1],Flash_Data_Ptr1->boardMac[2],Flash_Data_Ptr1->boardMac[3],Flash_Data_Ptr1->boardMac[4],Flash_Data_Ptr1->boardMac[5]);
xil_printf (" IP: %d.%d.%d.%d\n\r", Flash_Data_Ptr1->boardIP[0],Flash_Data_Ptr1->boardIP[1],Flash_Data_Ptr1->boardIP[2],Flash_Data_Ptr1->boardIP[3]);
xil_printf (" MASK: %d.%d.%d.%d\n\r", Flash_Data_Ptr1->boardIP_Mask[0],Flash_Data_Ptr1->boardIP_Mask[1],Flash_Data_Ptr1->boardIP_Mask[2],Flash_Data_Ptr1->boardIP_Mask[3]);
xil_printf (" GW: %d.%d.%d.%d\n\r", Flash_Data_Ptr1->boardGW[0],Flash_Data_Ptr1->boardGW[1],Flash_Data_Ptr1->boardGW[2],Flash_Data_Ptr1->boardGW[3]);
xil_printf (" Port: %d.%d.%d.%d\n\r", Flash_Data_Ptr1->IPport[0],Flash_Data_Ptr1->IPport[1],Flash_Data_Ptr1->IPport[2],Flash_Data_Ptr1->IPport[3]);

xil_printf (" TRIG_TH: %d\n\r", Flash_Data_Ptr1->boardTRIG_TH);
xil_printf (" TRIG_DT: %d\n\r", Flash_Data_Ptr1->boardTRIG_DT);
xil_printf (" TRIG_DL: %d\n\r", Flash_Data_Ptr1->boardTRIG_DL);
xil_printf (" EVT_LEN %d\n\r", Flash_Data_Ptr1->boardEVT_LEN);
xil_printf (" EVT_TAIL_LEN: %d\n\r", Flash_Data_Ptr1->boardEVT_TAIL_LEN);
xil_printf (" BL_LEN: %d\n\r", Flash_Data_Ptr1->boardBL_LEN);
xil_printf (" BPM_DIA: %d\n\r", Flash_Data_Ptr1->boardBPM_DIA);
xil_printf (" CH_Gain: %d.%d.%d.%d\n\r", Flash_Data_Ptr1->boardCH_GAIN[0],Flash_Data_Ptr1->boardCH_GAIN[1],Flash_Data_Ptr1->boardCH_GAIN[2],Flash_Data_Ptr1->boardCH_GAIN[3]);
xil_printf (" CAL_Gain: %d.%d.%d.%d\n\r", Flash_Data_Ptr1->boardCAL_GAIN[0],Flash_Data_Ptr1->boardCAL_GAIN[1],Flash_Data_Ptr1->boardCAL_GAIN[2],Flash_Data_Ptr1->boardCAL_GAIN[3]);

xil_printf (" MASK: 0x%x\n\r", Flash_Data_Ptr1->boardMASK);
xil_printf (" AFE: 0x%x\n\r", Flash_Data_Ptr1->boardAFE);
xil_printf (" IDN: %s \n\r", Flash_Data_Ptr1->boardIDN);
xil_printf ("\n\r");

do{} while(1);
	/*
	 * Compare the data read against the data Written.
	 */
//	for(Index = 0; Index < FLASH_TEST_SIZE; Index++) {
//		if(ReadBuffer[Index] != WriteBuffer[Index]) {
//			return XST_FAILURE;
//	}
//	}

	return XST_SUCCESS;
}
