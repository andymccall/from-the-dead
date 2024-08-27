;
; Title:		   From the Dead - Neo6502
;
; Description:     From the Dead for the Neo6502
;
; Author:		   Andy McCall, mailme@andymccall.co.uk
;
; Created:		   
; Last Updated:	   
;
; Modinfo:
;

.include "includes/system/neo6502.asm"

.org $800
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

start:

game_loop:

    jmp game_loop