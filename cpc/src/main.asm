;
; Title:		   From the Dead - Amstrad CPC
;
; Description:     From the Dead for the Amstrad CPC
;
; Author:		   Andy McCall, mailme@andymccall.co.uk
;
; Created:		   
; Last Updated:	   
;
; Modinfo:
;

	DEVICE AMSTRADCPC6128
    
    org $1200

    include "src/includes/Screen.inc"
    include "src/includes/SplashScreen.inc"
    include "src/includes/MainMenu.inc"
    
start:
    push af
    push bc
    push de
    push ix
    push iy

    ;setScreenMode SCREENMODE_320x240x64_60HZ
    ;call setScreenScaling

    ;call cursorHide

    call displaySplashScreen

    call displayMainMenu

game_loop:

    jp game_loop

quit:
    ;setScreenMode SCREENMODE_640x480x4_60HZ
    ;call cursorFlash

    pop iy
    pop ix
    pop de
    pop bc
    pop af

    ret

    SAVEAMSDOS "ftd.cpc", start, $-start, start