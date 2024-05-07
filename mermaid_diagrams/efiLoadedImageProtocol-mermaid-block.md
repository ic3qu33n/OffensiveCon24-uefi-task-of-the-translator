---
title:  "EFI_LOADED_IMAGE_PROTOCOL"
---
flowchart LR 
    direction LR
    subgraph EFI_LOADED_IMAGE_PROTOCOL[""EFI_LOADED_IMAGE_PROTOCOL""]
        direction TB
        Revision["UINT32 Revision"];
        ParentHandle["EFI_HANDLE ParentHandle"];
        gST["EFI_System_Table *SystemTable"];
        DeviceHandle["EFI_HANDLE DeviceHandle"];
        filepath["EFI_DEVICE_PATH_PROTOCOL *FilePath"];
        reserved["VOID *Reserved"];
        LoadOptionsSize["UINT32 LoadOptionsSize"];
        LoadOptions["VOID *LoadOptions"];
        ImageBase["VOID *ImageBase"];
        ImageSize["UINT64 ImageSize"];
        ImageCodeType["EFI_MEMORY_TYPE ImageCodeType"];
        ImageDataType["EFI_MEMORY_TYPE ImageDataType"];
        Unload["EFI_IMAGE_UNLOAD Unload"];
    end
    Unload-->EFI_IMAGE_UNLOAD
    subgraph EFI_IMAGE_UNLOAD["EFIAPI *EFI_IMAGE_UNLOAD"]
        direction TB
        ImageHandle["EFI_HANDLE ImageHandle"]
    end


 
