//Simple test hello world UEFI app written in aarch64 assembly

.text
.globl _start
.globl UefiMain
.align 4
//x0 : Image Handle
//x1: System Table
//x30: return address

//Stack frame:
/* 	[sp]
	[sp, -0x8] 		gBS
	[sp, -0x10] 	gBS->LocateProtocol
	[sp, -0x18] 	gBS
	[sp, -0x20] 	gBS
*/


_start:
	b UefiMain

UefiMain:
	//function prologue
	stp	x29, x30, [sp, #0x30]
	mov	x29, sp
	str	x0, [sp, #0x18] //store imageHandle var on stack
	str	x1, [sp, #0x20] //store efiSystemTable var on stack
	ldr x0, [sp, #0x20] //load efiSystemTable into x0
	ldr x0, [x0, #0x60] // load x0 =SystemTable + 0x60 == gBS
	str x0, [sp, #0x8]	//store gBS var on stack
	ldr x0, [sp, #0x8] //load x0 = gBS
	ldr x0, [x0, #0x140] // gBS->LocateProtocol
	str x0, [sp, #0x10] //store locateProtocol var on stack
	ldr x1, [sp, #0x20] //load x0 = SystemTable (from stack at sp - #0x20)
	ldr x0, [x1, #0x40] //load x0 = ConOut (SystemTable + 0x40)
	ldr x3, [x0, #0x8] //load x3 =  OutputString = SystemTable->ConOut->OutputString== x0 + 0x8 == ConOut + 0x8 == OutputString
	ldr x0, [sp, #0x20] //load x0 = SystemTable (from stack at sp - #0x20)
	ldr x2, [x0, #0x40] //load x2 = ConOut == x0 + 0x40 = SystemTable + 0x40
	adrp x0, hellostr
	add x1, x0, hellostr
	//ldr x1, =hellostr
	mov x0, x2 //mov x0 = SystemTable->ConOut == x2
	blr x3	//call SystemTable->ConOut->OutputString(SystemTable->ConOut, L"hello from the other side\n");
	//function epilogue
	mov x0, #0x0 //return 0
	ldp x29, x30, [sp], #0x30 //restore x29 and x30
	ret	

.data
.align 4
hellostr:
	.asciz "Hello from the other side\n"
