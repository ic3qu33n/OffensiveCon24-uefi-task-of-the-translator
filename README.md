# OffensiveCon24       
# UEFI and the Task of the Translator: Using cross-architecture UEFI quines as a framework for UEFI exploit development       
      
This repo contains the slidedeck and PoCs presented at OffensiveCon 2024 for my talk "UEFI and the Task of the Translator: Using cross-architecture UEFI quines as a framework for UEFI exploit development"         
      
OffensiveCon24 talk slidededeck is in the [OffensiveCon2024-slides](OffensiveCon2024-slides/) folder.        
      
PoCs are organized as follows:        
## PoCs      
## [x64 assembly](x64-uefi-exploits/)       
  
bggp4 winning entry - x64 assembly source code and EFI binary      
[gdb helper script](x64-uefi-exploits/gdb_helper.py): helper script for debugging x64 UEFI apps/drivers with gdb and QEMU      
  
## [arm64 assembly](arm64-uefi-exploits/)      
  
### [quinearm64.S](arm64-uefi-exploits/arm64-uefi-quine/quinearm64.S): arm64 assembly source code for self-replicating UEFI application       
### [QuineArm64.inf](arm64-uefi-exploits/arm64-uefi-quine/QuineArm64.inf): INF file for building QuineArm64 UEFI app using edk2 build system  
  
The UEFI apps for both the final arm64 assembly solution and the original cross-compiled C solution are in the directory UEFI_bb_disk:   
### [QuineArm64.efi](arm64-uefi-exploits/UEFI_bb_disk/): UEFI app QuineArm64.efi -- built from arm64 asm source code [quinearm64.S](arm64-uefi-exploits/arm64-uefi-quine/quinearm64.S)  
### [UEFISelfRep.efi](arm64-uefi-exploits/UEFI_bb_disk/): UEFI app UEFISelfRep.efi -- built from C source code, cross-compiled for aarch64 architecture using edk2 build system  
  
### [arm64 debugging guide](arm64-uefi-exploits/arm64-uefi-quine/ARM64-UEFI-Debugging-QEMU-GDB.md): debugging arm64 UEFI apps/drivers with gdb and QEMU      
### [poc_arm64.py](arm64-uefi-exploits/poc_arm64.py): Python script to test arm64 self-rep app in QEMU; includes option for running in QEMU with GDB debugging session  
        
Hit me up with questions or feedback.         
         
xoxo           
ic3qu33n           
