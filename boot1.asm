; Boot 1

bits 16 ; 16 bit real mode
org 0x7c00 ; Need to be aligned here

start:
	jmp main ; Get out of my way bPb!

; The Boot Parameter Block (or bPb)
bPbOEM: db "An OS   " ; 8 character long "OEM Identifier"
bPbBytesPerSector: dw 512 ; The size of a sector
bPbSectorsPerCluster: db 1
bPbReservedSectors: dw 1 ; Only one?!
bPbNumberOfFats: db 2 ; Huh. Only two fats. (a bit wrong to say but ya know)
bPbRootEntries: dw 224
bPbTotalEntries: dw 2880 ; Man FAT12 is bad.
bPbMedia: db 0xf8 ; I dont even understand half of the magic numbers here.
bPbSectorsPerFat: dw 9 ; Well, there is your legs, arms...
bPbSectorsPerTrack: dw 18 ; Ah yes. Tracks. A HDD specific thing.
bPbHeadsPerCylinder: dw 2 ; Don't bring cylinders into this!
bPbHiddenSectors: dd 0
bPbTotalSectorsBig: dd 0
bsDriveNumber: db 0 ; Wha-?
bsUnused: db 0 ; Huh?
bsExtBootSignature: db 0x29 ; How the-?
bsSerialNumber: dd 0xa0a1a2a3 ; Why in the-?
bsVolumeLabel: db "FLOPPY DISK" ; Uh-
bsFileSystem: db "FAT12   " ; Finnaly, something I know!

main:
	cli ; Disable interrupts
	hlt ; Halt system

times 510-($-$$) db 0 ; Pad the sector so that it's 512 bytes (510 but still)
dw 0xaa55 ; The boot signature.