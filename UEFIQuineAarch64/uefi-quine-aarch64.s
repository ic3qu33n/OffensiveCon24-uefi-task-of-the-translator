//UEFI quine written in aarch64 assembly
// by ic3qu33n


.text
.globl _start
.globl UefiMain
.align 4

// Registers (initial program state)
//	x0: Image Handle
//	x1: System Table
//	x30: return address
//
// OpenProtocol
//
//	status= gBS->OpenProtocol(
//		ImageHandle,
//		&lip_guid,
//		(void**)&loadedimageprotocol,
//		ImageHandle,
//		NULL,
//		EFI_OPEN_PROTOCOL_BY_HANDLE_PROTOCOL);
//		status= gBS->OpenProtocol(
//			devicehandle,
//			&sfsp_guid,
//			(void**)&sfsp,
//			ImageHandle,
//			NULL,
//			EFI_OPEN_PROTOCOL_BY_HANDLE_PROTOCOL);
//		EFI_FILE_PROTOCOL *rootvolume;
//		status = sfsp->OpenVolume(sfsp, &rootvolume);
//		if (status == EFI_SUCCESS) {
//			EFI_FILE_PROTOCOL *hostfile = NULL;
//			EFI_FILE_PROTOCOL *targetfile = NULL;
//			UINT64 host_attribs = 0x0000000000000000;
//			//set buffer size (destination file img_size) == original img_size	
//			UINTN newfile_buffersize =(UINTN) img_size;
//			VOID *temp_buf;
//			status = rootvolume->Open(rootvolume, &hostfile, L"\\UEFISelfRep.efi",0x0000000000000001, host_attribs);
//			if (status == EFI_SUCCESS){
//				status = gBS->AllocatePool(
//					AllocateAnyPages,
//					newfile_buffersize,
//					(void**)&temp_buf); 
//				status=hostfile->Read(hostfile, &newfile_buffersize, temp_buf);
//				status=hostfile->Read(hostfile, &newfile_buffersize, temp_buf);
//				status  = rootvolume->Open(rootvolume, &targetfile, L"\\4.efi", EFI_FILE_MODE_READ |  EFI_FILE_MODE_WRITE | EFI_FILE_MODE_CREATE, 0);
//				status=targetfile->Write(targetfile, &newfile_buffersize, temp_buf);
//				status=targetfile->Close(targetfile);
//				gBS->FreePool(temp_buf);
//				status=hostfile->Close(hostfile);
//				rootvolume->Close(rootvolume);
//			} else {
//				Print(L" hmm open root volum unsuccessful... something got effed.");
//			}
//		} else {
//			Print(L" hmm something got effed.");
//		}
//	}
//	return status;		
//
//
//	GUIDS:
//	#define EFI_LOADED_IMAGE_PROTOCOL_GUID {0x5B1B31A1,0x9562,0x11d2,{0x8E,0x3F,0x00,0xA0,0xC9,0x69,0x72,0x3B}}
//	#define EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID {0x0964e5b22,0x6459,0x11d2,{0x8e,0x39,0x00,0xa0,0xc9,0x69,0x72,0x3b}}  
// 
//
//
/*		
		Print(L"EFI_SIMPLE_FILE_SYSTEM_PROTOCOL OpenVolume() func address is: %p \n\n", &(sfsp->OpenVolume));	
		Print(L"EFI_FILE_PROTOCOL rootVolume pointer  address is: %p \n\n", &rootvolume);	
//Stack frame:
/* 	[sp]
	[sp, -0x8] 		status
//	[sp, -0x10] 	gBS
//	[sp, -0x18] 	UINT64 host_attributes
//	[sp, -0x20] 	EFI_HANDLE devicehandle (== lip->DeviceHandle)
//  [sp, -0x28] 	UINT64 img_size (== lip->ImageSize) 
//	[sp, -0x30] 	EFI_LOADED_IMAGE_PROTOCOL* lip
//	[sp, -0x38] 	LIP_GUID[3]
//	[sp, -0x3a] 	LIP_GUID[2]
//	[sp, -0x3c] 	LIP_GUID[1]
//	[sp, -0x40] 	LIP_GUID[0]
//	[sp, -0x48] 	EFI_SIMPLE_FILESYSTEM_PROTOCOL* sfsp
//	[sp, -0x50] 	SFSP_GUID[3]	
//	[sp, -0x52] 	SFSP_GUID[2]	
//	[sp, -0x54] 	SFSP_GUID[1]	
//	[sp, -0x58] 	SFSP_GUID[0]	
//	[sp, -0x60] 	EFI_FILE_PROTOCOL* rootVolume
//	[sp, -0x68] 	EFI_FILE_PROTOCOL* hostFile
//	[sp, -0x70] 	EFI_FILE_PROTOCOL* targetFile
//	[sp, -0x78] 	UINTN newfile_buffersize
//	[sp, -0x80] 	void* buffer
//	[sp, -0x88] 	ImageHandle
//	[sp, -0x90] 	gST
//	[sp, -0xa0] 	
*/


_start:
	b UefiMain

UefiMain:
	//function prologue
	stp	x29, x30, [sp, #-0xa0]
	mov	x29, sp
	str	x0, [sp, #-0x88] //store imageHandle var on stack
	str	x1, [sp, #-0x90] //store efiSystemTable var on stack
	ldr x0, [sp, #-0x90] //load efiSystemTable into x0
	ldr x0, [x0, #0x60] // load x0 =SystemTable + 0x60 == gBS
	str x0, [sp, #-0x10]	//store gBS var on stack
	//load Loaded Image Protocol guid
	mov x0, #0x31a1
	movk x0, #0x5b1b, LSL #16
	str x0, [sp,#-0x40]  //Store final part of LIP GUID at sp-0x40	
	mov x0, #0x9562
	strh x0, [sp, #-0x3c] //Store 2nd part of LIP GUID at sp-0x3c	
	mov x0, #0x11d2
	strh x0, [sp, #-0x3a] //Store 3rd part of LIP GUID at sp-0x3a	
	mov x0, #0x3f8e
	movk x0, #0xa000, LSL #16
	movk x0, #0x69c9, LSL #32
	movk x0, #0x3b72, LSL #48
	str x0, [sp, #-0x38] //Store final part of LIP GUID at sp-0x38	
	ldr x0, [sp, #-0x10] //load x0 = gBS
	ldr x6, [x0, #0x118] // load gBS+0x118 (OpenProtocol) into x6
	add x0, sp, #0x60	//load x0 with address of LIP_GUID var saved on the stack
						// address of LIP GUID into x0 
						// at this point, sp == sp-0xa0 
						// LIP_GUID is at [sp - 0x40] on the stack
						// thus, to point to the correct var on the stack, we use sp with an offset of 0x60
						// so the variable read from the stack is (sp+ 0x60== (sp - 0xa0) + 0x60) == (sp -0x40) into x0
						// repeat this process for loading the correct var from the stack into x1
	add x1, sp, #0x70	// load x1 with address of loadedImageProtocol var saved on stack
						// loadedImageProtocol is at [sp - 0x30] on the stack
						// thus, to point to the correct var on the stack, we use sp with an offset of 0x70
						// so the variable read from the stack is (sp+ 0x70== (sp - 0xa0) + 0x70) == (sp -0x30) into x1
	

	mov w5, #0x1		//Move EFI_OPEN_PROTOCOL_BY_HANDLE_PROTOCOL(0x1) into register w5;
	mov w4, #0x0 		//Move 0x0 into register w4
	ldr x3, [sp, #-0x88] //load ImageHandle from stack into x3 
	mov x2, x1			//Move contents of x1 (LIP guid) into register x2
	mov x1, x0			//
	ldr x1, [sp, #-0x88] //load ImageHandle from stack into x3 
	blr x6
	str x0, [sp, #-0x8]
	str x0, [sp, #-0x8]
	cmp x0, 0x0			//check if EFI_STATUS==EFI_SUCCESS (0x0)
	b.e Print
	b Exit

exit:
	//function epilogue
	

	mov x0, #0x0 //return 0
	ldp x29, x30, [sp], #0xa0 //restore x29 and x30
	ret	

Print:
	ldr x0, [sp, #-0x10] //load x0 = gBS
	ldr x0, [x0, #0x140] // gBS->LocateProtocol
	str x0, [sp, #0x10] //store locateProtocol var on stack
	ldr x1, [sp, #0x20] //load x0 = SystemTable (from stack at sp - #0x20)
	ldr x0, [x1, #0x40] //load x0 = ConOut (SystemTable + 0x40)
	ldr x3, [x0, #0x8] //load x3 =  OutputString = SystemTable->ConOut->OutputString== x0 + 0x8 == ConOut + 0x8 == OutputString
	ldr x0, [sp, #0x20] //load x0 = SystemTable (from stack at sp - #0x20)
	ldr x2, [x0, #0x40] //load x2 = ConOut == x0 + 0x40 = SystemTable + 0x40
	//adrp x1, hellostr
	//add x1, x1, #0x10 //a hacky workaround bc the offset to the string is 0x10 from the start of the hellostr address in the .data section
	//add x1, x1, hellochars
	//add x1, x1, =hellostr
	//ldr x1, =hellostr
	mov x1, #0x0048
	movk x1, #0x0065, lsl #16
	movk x1, #0x006c, lsl #32
	movk x1, #0x006c, lsl #48
	str x1, [sp, #0x58]
	add x1, sp, #0x58
	mov x0, x2 //mov x0 = SystemTable->ConOut == x2
	blr x3	//call SystemTable->ConOut->OutputString(SystemTable->ConOut, L"hello from the other side\n");
	b Exit

.data
.balign 8
hellostr:
	.string16 "Hello from the other side"
	.string16 "\\UEFISelfRep.efi\0"
	.string16 "\\4.efi\0"
	//.word 0x00480065
	//.word 0x48, 0x00, 0x65, 0x00, 0x6C, 0x00, 0x6C, 0x00, 0x6F, 0x00, 0x20, 0x00, 0x66, 0x00, 0x72, 0x00, 0x6F, 0x00, 0x6D, 0x00, 0x20, 0x00, 0x74, 0x00, 0x68, 0x00, 0x65, 0x00, 0x20, 0x00, 0x6F, 0x00, 0x74, 0x00, 0x68, 0x00, 0x65, 0x00, 0x72, 0x00, 0x20, 0x00, 0x73, 0x00, 0x69, 0x00, 0x64, 0x00, 0x65, 0x00
