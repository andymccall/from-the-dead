;
; Title:	   From the Dead - ZX Spectrum Next
;
; Description:     From the Dead for the ZX Spectrum Next
;
; Author:	   Andy McCall, mailme@andymccall.co.uk
;
; Created:		   
; Last Updated:	   
;
; Modinfo:
;

        DEVICE ZXSPECTRUMNEXT

        CSPECTMAP "ftd.map"

        org  $8000

start:
        jp start


        SAVENEX OPEN "ftd.nex", start, $ff40
        SAVENEX CORE 2,0,0
        SAVENEX CFG 7,0,0,0
        SAVENEX AUTO