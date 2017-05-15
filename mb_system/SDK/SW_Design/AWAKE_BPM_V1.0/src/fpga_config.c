/*
 * fpga.c
 *
 *  Created on: Jul 23, 2012
 *      Author: verzilov
 * Modified: add calibration gain, drift gain, removed offset, Angela zhou, April 21,2016
 * Modified: add CR, CAL_K,NFX,NFY (Normalization Factor X,Y, may not be used), SL, Apr. 7,2017
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "platform.h"
#include "xparameters.h"
#include "xio.h"
#include <xilflash.h>
#include "eth_server.h"

extern u8 FlashDataBuffer[DATA_LEN];



int flash_buffer_2_fpga( )
{
    struct Flash_Data_Struct *Flash_Data_Ptr = &FlashDataBuffer;

	XIo_Out32(BRAM_BASE_ADDR + TRIG_TH,Flash_Data_Ptr->boardTRIG_TH);
	XIo_Out32(BRAM_BASE_ADDR + TRIG_DT,Flash_Data_Ptr->boardTRIG_DT);
	XIo_Out32(BRAM_BASE_ADDR + TRIG_DL,Flash_Data_Ptr->boardTRIG_DL);
	XIo_Out32(BRAM_BASE_ADDR + EVT_LEN,Flash_Data_Ptr->boardEVT_LEN);
	XIo_Out32(BRAM_BASE_ADDR + EVT_TAIL_LEN,Flash_Data_Ptr->boardEVT_TAIL_LEN);
	XIo_Out32(BRAM_BASE_ADDR + BL_LEN,Flash_Data_Ptr->boardBL_LEN);

	XIo_Out32(BRAM_BASE_ADDR + BPM_DIA,Flash_Data_Ptr->boardBPM_DIA);

	XIo_Out32(BRAM_BASE_ADDR + CH_GAIN_A,Flash_Data_Ptr->boardCH_GAIN[0]);
	XIo_Out32(BRAM_BASE_ADDR + CH_GAIN_B,Flash_Data_Ptr->boardCH_GAIN[1]);
	XIo_Out32(BRAM_BASE_ADDR + CH_GAIN_C,Flash_Data_Ptr->boardCH_GAIN[2]);
	XIo_Out32(BRAM_BASE_ADDR + CH_GAIN_D,Flash_Data_Ptr->boardCH_GAIN[3]);

	XIo_Out32(BRAM_BASE_ADDR + CAL_GAIN_A,Flash_Data_Ptr->boardCAL_GAIN[0]);
	XIo_Out32(BRAM_BASE_ADDR + CAL_GAIN_B,Flash_Data_Ptr->boardCAL_GAIN[1]);
	XIo_Out32(BRAM_BASE_ADDR + CAL_GAIN_C,Flash_Data_Ptr->boardCAL_GAIN[2]);
	XIo_Out32(BRAM_BASE_ADDR + CAL_GAIN_D,Flash_Data_Ptr->boardCAL_GAIN[3]);

	XIo_Out32(BRAM_BASE_ADDR + AFE_CTRL,Flash_Data_Ptr->boardAFE);

	//added by SL, Apr.7,2017
	XIo_Out32(BRAM_BASE_ADDR + CR,Flash_Data_Ptr->boardCR);
	XIo_Out32(BRAM_BASE_ADDR + CAL_K,Flash_Data_Ptr->boardCAL_K);
	XIo_Out32(BRAM_BASE_ADDR + CAL_NFX,Flash_Data_Ptr->boardCAL_NFX);
	XIo_Out32(BRAM_BASE_ADDR + CAL_NFY,Flash_Data_Ptr->boardCAL_NFY);

	//XIo_Out32(BRAM_BASE_ADDR + TRIG_MASK,Flash_Data_Ptr->boardMASK);

	return 0;
}

int fpga_2_flash_buffer( )
{

	struct Flash_Data_Struct *Flash_Data_Ptr = &FlashDataBuffer;

	Flash_Data_Ptr->boardTRIG_TH = XIo_In32(BRAM_BASE_ADDR + TRIG_TH);
	Flash_Data_Ptr->boardTRIG_DT = XIo_In32(BRAM_BASE_ADDR + TRIG_DT);
	Flash_Data_Ptr->boardTRIG_DL = XIo_In32(BRAM_BASE_ADDR + TRIG_DL);
	Flash_Data_Ptr->boardEVT_LEN = XIo_In32(BRAM_BASE_ADDR + EVT_LEN);
	Flash_Data_Ptr->boardEVT_TAIL_LEN = XIo_In32(BRAM_BASE_ADDR + EVT_TAIL_LEN);
	Flash_Data_Ptr->boardBL_LEN = XIo_In32(BRAM_BASE_ADDR + BL_LEN);
	Flash_Data_Ptr->boardBPM_DIA = XIo_In32(BRAM_BASE_ADDR + BPM_DIA);

	Flash_Data_Ptr->boardCH_GAIN[0] = XIo_In32(BRAM_BASE_ADDR + CH_GAIN_A);
	Flash_Data_Ptr->boardCH_GAIN[1] = XIo_In32(BRAM_BASE_ADDR + CH_GAIN_B);
	Flash_Data_Ptr->boardCH_GAIN[2] = XIo_In32(BRAM_BASE_ADDR + CH_GAIN_C);
	Flash_Data_Ptr->boardCH_GAIN[3] = XIo_In32(BRAM_BASE_ADDR + CH_GAIN_D);

	Flash_Data_Ptr->boardCAL_GAIN[0] = XIo_In32(BRAM_BASE_ADDR + CAL_GAIN_A);
	Flash_Data_Ptr->boardCAL_GAIN[1] = XIo_In32(BRAM_BASE_ADDR + CAL_GAIN_B);
	Flash_Data_Ptr->boardCAL_GAIN[2] = XIo_In32(BRAM_BASE_ADDR + CAL_GAIN_C);
	Flash_Data_Ptr->boardCAL_GAIN[3] = XIo_In32(BRAM_BASE_ADDR + CAL_GAIN_D);

	Flash_Data_Ptr->boardAFE = XIo_In32(BRAM_BASE_ADDR + AFE_CTRL);

	//added by SL, Apr. 7,2017
	Flash_Data_Ptr->boardCR = XIo_In32(BRAM_BASE_ADDR + CR);
	Flash_Data_Ptr->boardCAL_K = XIo_In32(BRAM_BASE_ADDR + CAL_K);
	Flash_Data_Ptr->boardCAL_NFX = XIo_In32(BRAM_BASE_ADDR + CAL_NFX);
	Flash_Data_Ptr->boardCAL_NFY = XIo_In32(BRAM_BASE_ADDR + CAL_NFY);


//	Flash_Data_Ptr->boardMASK = XIo_In32(BRAM_BASE_ADDR + TRIG_MASK);

return 0;
}
