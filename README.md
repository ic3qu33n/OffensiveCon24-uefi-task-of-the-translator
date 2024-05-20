# OffensiveCon24           
# UEFI and the Task of the Translator: Using cross-architecture UEFI quines as a framework for UEFI exploit development           
          
This repo contains the slidedeck and PoCs presented at OffensiveCon 2024 for my talk "UEFI and the Task of the Translator: Using cross-architecture UEFI quines as a framework for UEFI exploit development"             

## OffensiveCon24 slidedeck          
### OffensiveCon24 talk slidededeck is in the [OffensiveCon2024-slides](OffensiveCon2024-slides/) folder.            
          
## PoCs          
## [x64 assembly](x64-uefi-exploits/)           
      
### [x64 assembly source code for BGGP4 entry](x64-uefi-exploits/bggp4/self-rep-golf-final.asm):   
bggp4 winning entry - x64 assembly source code     
### [BGGP4 UEFI Self-replicating app](x64-uefi-exploits/bggp4/self-rep-golf-final.efi):   
bggp4 winning entry - UEFI self-replicating app, compiled from x64 asm source          
#### [x64 UEFI shellcode template](x64-uefi-exploits/x64_shellcode_example.asm):   
source code for basic UEFI app, written in x64, to be used as a template for writing x64 UEFI shellcode    
      
## [arm64 assembly](arm64-uefi-exploits/)          



https://github.com/ic3qu33n/OffensiveCon24-uefi-task-of-the-translator/assets/121086940/5aae6256-dbf4-4ee4-a254-53b3c8bb7311


      
### [quinearm64.S](arm64-uefi-exploits/arm64-uefi-quine/quinearm64.S):     
arm64 assembly source code for self-replicating UEFI application           
#### [QuineArm64.inf](arm64-uefi-exploits/arm64-uefi-quine/QuineArm64.inf):     
INF file for building QuineArm64 UEFI app using edk2 build system      
      
The UEFI apps for both the final arm64 assembly solution and the original cross-compiled C solution are in the directory UEFI_bb_disk:       
[QuineArm64.efi](arm64-uefi-exploits/UEFI_bb_disk/): UEFI app QuineArm64.efi -- built from arm64 asm source code [quinearm64.S](arm64-uefi-exploits/arm64-uefi-quine/quinearm64.S)      
[UEFISelfRep.efi](arm64-uefi-exploits/UEFI_bb_disk/): UEFI app UEFISelfRep.efi -- built from C source code, cross-compiled for aarch64 architecture using edk2 build system      
      
#### [poc_arm64.py](arm64-uefi-exploits/poc_arm64.py):   
Python script to test arm64 self-rep app in QEMU; includes option for running in QEMU with GDB debugging session      
            
---

Hit me up with questions or feedback.             
             
xoxo               
ic3qu33n               
