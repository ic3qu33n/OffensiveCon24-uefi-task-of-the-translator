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

***
---
title: LoadedImageProtocol
---
block-beta
    block
    LoadedImageProtocol["LoadedImageProtocol"]
    columns 1
        block
            Revision["UINT32 Revision"]:1
        end
        block
            ParentHandle["EFI_HANDLE ParentHandle"]:1
        end
        block
            gST["EFI_System_Table *SystemTable"]:1
        end
        block
            DeviceHandle["EFI_HANDLE DeviceHandle"]:1
        end
        block
            filepath["EFI_DEVICE_PATH_PROTOCOL *FilePath"]:1
        end
        block
            reserved["VOID *Reserved"]:1
        end
        block
            LoadOptionsSize["UINT32 LoadOptionsSize"]:1
        end
        block
            LoadOptions["VOID *LoadOptions"]:1
        end
        block
            ImageBase["VOID *ImageBase"]:1
        end
        block
            ImageSize["UINT64 ImageSize"]:1
        end
        block
            ImageCodeType["EFI_MEMORY_TYPE ImageCodeType"]:1
        end
        block
            ImageDataType["EFI_MEMORY_TYPE ImageDataType"]:1
        end
        block
            Unload["EFI_IMAGE_UNLOAD Unload"]:1
        end
    end
    space 
    block
    EFI_IMAGE_UNLOAD["EFIAPI *EFI_IMAGE_UNLOAD"]
    columns 1
        space:12
        block
            ImageHandle["EFI_HANDLE ImageHandle"]:1
        end
    end
    Unload-->ImageHandle
    
    style LoadedImageProtocol fill:#d6d,stroke:#333,stroke-width:4px,columns:3;
    
***

Final working mermaid code:

---
title: LoadedImageProtocol
---
block-beta

    block
    LoadedImageProtocol["LoadedImageProtocol"]:1
    columns 1
        block
            Revision["UINT32 Revision"]:1
        end
        block
            ParentHandle["EFI_HANDLE ParentHandle"]:1
        end
        block
            gST["EFI_System_Table *SystemTable"]:1
        end
        block
            DeviceHandle["EFI_HANDLE DeviceHandle"]:1
        end
        block
            filepath["EFI_DEVICE_PATH_PROTOCOL *FilePath"]:1
        end
        block
            reserved["VOID *Reserved"]:1
        end
        block
            LoadOptionsSize["UINT32 LoadOptionsSize"]:1
        end
        block
            LoadOptions["VOID *LoadOptions"]:1
        end
        block
            ImageBase["VOID *ImageBase"]:1
        end
        block
            ImageSize["UINT64 ImageSize"]:1
        end
        block
            ImageCodeType["EFI_MEMORY_TYPE ImageCodeType"]:1
        end
        block
            ImageDataType["EFI_MEMORY_TYPE ImageDataType"]:1
        end
        block
            Unload["EFI_IMAGE_UNLOAD Unload"]:1
        end
    end
    space
    block:unload
    space:12
    EFI_IMAGE_UNLOAD["EFIAPI *EFI_IMAGE_UNLOAD"]
    columns 1
        block
            ImageHandle["LoadedImageProtocol.Unload(ImageHandle)"]:1
        end
    end
    Unload-->ImageHandle
    
    style LoadedImageProtocol fill:#d6d,stroke:#333,stroke-width:4px,columns:3;
    style unload fill:none,stroke:#333 
