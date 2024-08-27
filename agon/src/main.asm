;
; Title:		   From the Dead - Agon Light 2
;
; Description:     From the Dead for the Agon Light 2
;
; Author:		   Andy McCall, mailme@andymccall.co.uk
;
; Created:		   
; Last Updated:	   
;
; Modinfo:
;

.assume adl=1
.org $040000

    jp start

; MOS header
.align 64
.db "MOS",0,1

    include "src/includes/system/mos_api.inc"
    include "src/includes/Screen.inc"
    include "src/includes/Cursor.inc"
    include "src/includes/SplashScreen.inc"
    include "src/includes/MainMenu.inc"
    
start:
    push af
    push bc
    push de
    push ix
    push iy

    setScreenMode SCREENMODE_320x240x64_60HZ
    call setScreenScaling

    call cursorHide

    call displaySplashScreen

    call displayMainMenu

game_loop:

    ld a, mos_getkbmap
	rst.lil $08

    ; If the Escape key is pressed
    ld a, (ix + $0E)    
    bit 0, a
    jp nz, quit

    jp game_loop

quit:
    setScreenMode SCREENMODE_640x480x4_60HZ
    call cursorFlash

    pop iy
    pop ix
    pop de
    pop bc
    pop af
    ld hl,0

    ret