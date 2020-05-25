#include <stdio.h>
#include "platform.h"
#include "xil_io.h"
#include "xparameters.h"
#include "xbram.h"
#include <unistd.h>

#define BRAM_DEVICE_ID		XPAR_BRAM_0_DEVICE_ID
static void InitializeECC(XBram_Config *ConfigPtr, u32 EffectiveAddr);
XBram Bram;

int main(void)
{
	int word[20];
    init_platform();
    int Status;
	XBram_Config *ConfigPtr;

	xil_printf("1\n");
	ConfigPtr = XBram_LookupConfig(BRAM_DEVICE_ID);
	if (ConfigPtr == (XBram_Config *) NULL) {
		return XST_FAILURE;
	}

	xil_printf("2\n");
	Status = XBram_CfgInitialize(&Bram, ConfigPtr,
					 ConfigPtr->CtrlBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	InitializeECC(ConfigPtr, ConfigPtr->CtrlBaseAddress);

	Status = XBram_SelfTest(&Bram, 0);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	xil_printf("3\n");

    while(1){

		print("Hello World\n\r");
		for(int i = 0; i < 10; i++){
			word[i] = Xil_In32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + 4*i);
		}


		for(int i = 0; i < 10; i++){
			xil_printf("add = %x, Word[%d] = %x\n\r", XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR + 4*i, i, word[i]);

		sleep(1);
    }
    return 0;

}

void InitializeECC(XBram_Config *ConfigPtr, u32 EffectiveAddr)
{
	u32 Addr;
	volatile u32 Data;

	if (ConfigPtr->EccPresent &&
	    ConfigPtr->EccOnOffRegister &&
	    ConfigPtr->EccOnOffResetValue == 0 &&
	    ConfigPtr->WriteAccess != 0) {
		for (Addr = ConfigPtr->MemBaseAddress;
		     Addr < ConfigPtr->MemHighAddress; Addr+=4) {
			Data = XBram_In32(Addr);
			XBram_Out32(Addr, Data);
		}
		XBram_WriteReg(EffectiveAddr, XBRAM_ECC_ON_OFF_OFFSET, 1);
	}
}

