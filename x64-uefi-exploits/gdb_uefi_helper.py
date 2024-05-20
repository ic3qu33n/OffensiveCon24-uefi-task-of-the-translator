#!/usr/bin/python3

import os
import sys
import re
#import gdb 
import subprocess

#########################################################################
#
#	Script for automating the process of loading a UEFI app/driver
# 	into GDB for debugging
#	This script does the following:
#	- finds the base address, as well as the
# 	.text section and .data section offsets for a target UEFI app/driver
#	- 
#
#	This script is based on these two other scripts:
# 	"uefi-gdb" by artem-nefedov:
#	https://github.com/artem-nefedov/uefi-gdb/
#	and
# 	"run-gdb" by Kostr:
#	https://github.com/Kostr/UEFI-Lessons/blob/master/scripts/run_gdb.sh
#
#########################################################################


LOGFILE="debug.log"
TARGET_FILE="UEFIQuineAarch64.efi"
TARGET="UEFI_bb_disk/"+TARGET_FILE
SYMBOL_FILE="/Users/nika/uefi_testing/edk2/Build/BareBonesPkg/DEBUG_GCC/Aarch64/UefiQuineAarch64.debug"
UEFI_DEBUG_PATTERN= r"Loading driver at (0x[0-9A-Fa-f]{8,}) EntryPoint=(0x[0-9A-Fa-f]{8,}) (\w+).efi"

def calculate_target_addresses(base_addr, text_section_offset, data_offset):
	target_base = int(base_addr, 16)
	target_text_offset = int(text_offset, 16)
	target_text_addr = hex(target_base + target_text_offset)
	print(f"Final address of .text section in target UEFI app/driver is: {target_text_addr} \n")
	target_data_offset = int(data_offset, 16)
	target_data_addr = hex(target_base + target_data_offset)
	print(f"Final address of .data section in target UEFI app/driver is: {target_data_addr}\n")
	return (target_text_addr, target_data_addr)

def find_addresses(target_file: str):
	find_text_args=["objdump", TARGET, "-h"]
	find_offsets=subprocess.run(find_text_args, check=True, capture_output=True, encoding='utf-8').stdout
	#print(len(find_offsets))
	target_offsets=find_offsets.split('\n')
	for offset in target_offsets:
		if ".text" in offset:
			text_addr = offset.split()[2]
			print(f".text section address offset is: {text_addr}")
			print(f"text section offset is: {offset}")
		if ".data" in offset:
			data_addr = offset.split()[2]
			print(f".data section address offset is: {data_addr}")
			print(f"data section offset is: {offset}")
	if (text_addr is not None) and (data_addr is not None):
		return (text_addr, data_addr)
	return (None, None)

def find_drivers(target_file: str, log_file: str):
	with open(log_file, 'r') as f:
		log_data = f.read()
		driver_entry_points = re.finditer(UEFI_DEBUG_PATTERN, log_data)
		for elem in driver_entry_points:
			print(f"Driver entry point identified: {elem.group()}")
			if TARGET_FILE in elem.group():
					target_driver_base_address=elem.group(2)
					print(f"Target driver entry point identified: {elem.group()} \n Entry point is: {elem.group(2)} \n")
					return target_driver_base_address
	return 0

if __name__ == "__main__":
	target_base_addr=find_drivers(TARGET_FILE, LOGFILE)
	(text_offset, data_offset) = find_addresses(TARGET_FILE)
	print(f"Target driver base address is {target_base_addr} \n")
	print(f"Identified .text section address offset of target file is: {text_offset} \n")
	print(f"Identified .data section address offset of target file is: {data_offset} \n")
	(text_addr, data_addr) = calculate_target_addresses(target_base_addr, text_offset, data_offset)
	print(f"add-symbol-file {SYMBOL_FILE} {text_addr} -s .data {data_addr} \n")

