/*
 * eth_server.h
 *
 *  Created on: Jun 14, 2012
 *      Author: verzilov
 */

#define BRAM_BASE_ADDR (Xuint32*)0x41710000
#define SR (Xuint32)0x0
#define CR (Xuint32)0x1
#define FPGA_VER (Xuint32)0x2

#define POWER_A (Xuint32)0x4
#define POWER_B (Xuint32)0x5
#define POWER_C (Xuint32)0x6
#define POWER_D (Xuint32)0x7

#define X_INS (Xuint32)0x8
#define Y_INS (Xuint32)0x9
#define S_INS (Xuint32)0xA
#define X_AVE (Xuint32)0xB
#define Y_AVE (Xuint32)0xC
#define S_AVE (Xuint32)0xD
#define S_RAW (Xuint32)0xE

//defined for AWAKE, SL, 20160309
#define TRIG_DL (Xuint32)0x16
#define BPM_DIA (Xuint32)0x17
#define TRIG_TH (Xuint32)0x18
#define TRIG_DT (Xuint32)0x19
#define EVT_LEN (Xuint32)0x1A
#define EVT_TAIL_LEN (Xuint32)0x1B
#define BL_LEN       (Xuint32)0x1C
#define AB_FIFO_WD (Xuint32)0x1D
#define CD_FIFO_WD (Xuint32)0x1E

#define S_FIFO_ADDR (Xuint32)0x20
#define S_FIFO_WD_ADDR (Xuint32)0x21

#define ABF_FIFO (Xuint32)0x28
#define CDF_FIFO (Xuint32)0x2A

#define CHA_3DB (Xuint32)0x40
#define CHA_6DB (Xuint32)0x41
#define CHA_9DB (Xuint32)0x42
#define CHA_12DB (Xuint32)0x43

#define CHB_3DB (Xuint32)0x44
#define CHB_6DB (Xuint32)0x45
#define CHB_9DB (Xuint32)0x46
#define CHB_12DB (Xuint32)0x47

#define CHC_3DB (Xuint32)0x48
#define CHC_6DB (Xuint32)0x49
#define CHC_9DB (Xuint32)0x4A
#define CHC_12DB (Xuint32)0x4B

#define CHD_3DB (Xuint32)0x4C
#define CHD_6DB (Xuint32)0x4D
#define CHD_9DB (Xuint32)0x4E
#define CHD_12DB (Xuint32)0x4F

#define AFE_CTRL (Xuint32)0x58  //SL, 20160310

// calibration gain, channel gain and temperature drifting gain Angela Zhou, 2016-4-21

#define CH_GAIN_A (Xuint32)0x60
#define CH_GAIN_B (Xuint32)0x61
#define CH_GAIN_C (Xuint32)0x62
#define CH_GAIN_D (Xuint32)0x63

#define CAL_GAIN_A (Xuint32)0x65
#define CAL_GAIN_B (Xuint32)0x66
#define CAL_GAIN_C (Xuint32)0x67
#define CAL_GAIN_D (Xuint32)0x68

#define CAL_K (Xuint32)0x6A
#define CAL_NFX (Xuint32)0x6B
#define CAL_NFY (Xuint32)0x6C

/////////////////////////////////////////////////////////////////////////////

#define XPAR_UARTLITE_BASEADDR XPAR_UARTLITE_1_BASEADDR          // RS232   Defined in xparamaters.h
//#define XPAR_UARTLITE_BASEADDR XPAR_UARTLITE_2_BASEADDR		    //RS232_USB   Defined in xparamaters.h

#define FLASH_BASE_ADDRESS	XPAR_LINEAR_FLASH_S_AXI_MEM0_BASEADDR
#define FLASH_MEM_WIDTH		2
#define START_ADDRESS		0x100000
#define BLOCK_OFFSET_ADDR	0x068000
#define DATA_LEN 256

#define BUFF_LEN 64

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
