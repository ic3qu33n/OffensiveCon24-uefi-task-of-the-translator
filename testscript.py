#!/usr/bin/python3

import sys, os
import subprocess
import re



########################################################################################
#	A simple Python script for copying EFI binaries built with EDK2 and OVMF
#   copying the resultant .efi binary to the target root disk for QEMU
#   and launching a qemu-system-x86_64 session for testing
#
#	There isn't anything *wild* or super interesting about this script
#	tbh I just didn't want to keep typing these really long qemu commands over and over
########################################################################################

edk2_dir="/Users/nika/uefi_testing/edk2/"
uefi_testingdir_cmd=["cd", edk2_dir, "&&", ". ./edksetup.sh"]

uefi_app_build_cmd= ["build",  "--platform=BareBonesPkg/BareBonesPkg.dsc",  "--arch=X64", "--buildtarget=RELEASE", "--tagname=GCC"]

##target_pkg="Build/BareBonesPkg/RELEASE_GCC/X64/"
target_pkg="Build/BareBonesPkg/DEBUG_GCC/X64/"
#uefi_app_name="ImageOffTheHandle.efi"
#uefi_app_name="UEFISelfRep.efi"
##uefi_driver_name="GOPComplex.efi"
uefi_driver_name="SmmCalloutDriver.efi"
#uefi_app_name="self-rep-golf.efi"
target_uefi_driver= edk2_dir + target_pkg + uefi_driver_name
target_disk="/Users/nika/uefi-task-of-the-translator/UEFI_bb_disk"
uefi_copy_app_cmd=["cp", target_uefi_driver, target_disk]

##qemu UEFI run command with no graphics output
uefi_app_run_cmd=["/opt/homebrew/bin/qemu-system-x86_64", "-drive", "if=pflash,format=raw,file=/Users/nika/uefi_testing/edk2/Build/OvmfX64/RELEASE_GCC/FV/OVMF.fd", "-drive", "format=raw,file=fat:rw:UEFI_bb_disk", "-nographic","-net","none"]

#uefi_app_run_aarch64_cmd=["/opt/homebrew/bin/qemu-system-aarch64", "-M", "virt,highmem=off", "-cpu", "cortex-a72", "-m", "1G", "-drive", "if=pflash,format=raw,file=/Users/nika/uefi-task-of-the-translator/DEBUG_BUILD_AARCH64_FD/FVP_AARCH64_EFI.fd", "-drive", "format=raw,file=fat:rw:UEFI_bb_disk", "-nographic","-net","none"]

uefi_app_run_aarch64_cmd=["/opt/homebrew/bin/qemu-system-aarch64", "-M", "virt,highmem=off", "-cpu", "cortex-a72", "-m", "1G", "-drive", "if=pflash,format=raw,file=/Users/nika/uefi-task-of-the-translator/edk2-aarch64-code.fd", "-drive", "format=raw,file=fat:rw:UEFI_bb_disk", "-nographic","-net","none"]
##qemu UEFI run command with graphics output
uefi_app_graphics_run_cmd=["/opt/homebrew/bin/qemu-system-x86_64", "-drive", "if=pflash,format=raw,file=/Users/nika/uefi-task-of-the-translator/DEBUG_BUILD_AARCH64_FD/FVP_AARCH64_EFI.fd", "-drive", "format=raw,file=fat:rw:UEFI_bb_disk","-net","none","-device","virtio-rng-pci", "-machine","q35,smm=on", "-smp","4", "-m","256M","-vga","std"]

##uefi_app_run_debug_cmd=["/opt/homebrew/bin/qemu-system-x86_64", "-drive", "if=pflash,format=raw,file=/Users/nika/uefi_testing/edk2/Build/OvmfX64/DEBUG_GCC/FV/OVMF.fd", "-drive", "format=raw,file=fat:rw:UEFI_bb_disk", "-device", "virtio-rng-pci", "-machine","q35,smm=on", "-smp","4", "-m","256M","-vga","std","-net","none","-global","isa-debugcon.iobase=0x402","-debugcon","file:debug.log", "-s"]

##uefi_app_run_debug_cmd=["/opt/homebrew/bin/qemu-system-x86_64", "-drive", "if=pflash,format=raw,file=/Users/nika/uefi_testing/edk2/Build/OvmfX64/DEBUG_GCC/FV/OVMF.fd", "-drive", "format=raw,file=fat:rw:UEFI_bb_disk", "-machine","q35,smm=on", "-smp","4", "-m","2048M","-vga","none", "-nographic","-net","none", "-global","isa-debugcon.iobase=0x402","-debugcon","file:debug.log", "-s"]
uefi_app_run_debug_cmd=["/opt/homebrew/bin/qemu-system-x86_64", "-drive", "if=pflash,format=raw,file=/Users/nika/uefi-task-of-the-translator/DEBUG_BUILD_AARCH64_FD/FVP_AARCH64_EFI.fd", "-drive", "format=raw,file=fat:rw:UEFI_bb_disk", "-machine","q35,smm=on", "-smp", "4", "-m","256M","-nographic","-net","none", "-global","isa-debugcon.iobase=0x402","-debugcon","file:debug.log", "-s", "-S"]


if __name__ == '__main__':

	try:
		#subprocess.run(uefi_copy_app_cmd)
		#subprocess.run(uefi_app_run_cmd)
		subprocess.run(uefi_app_run_aarch64_cmd)
		#subprocess.run(uefi_app_graphics_run_cmd)
		#subprocess.run(uefi_app_run_debug_cmd)
	
	except (RuntimeError, TypeError) as e:
		print("oh no. error error: {0}".format(e))
	
