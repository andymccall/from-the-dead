;
; Title:		        From the Dead
;
; Description:          A 2D console game where a player fights
;                       their way through a viral outbreak
; Author:		        Andy McCall, mailme@andymccall.co.uk
;
; Created:		        2024-08-15 @ 16:22
; Last Updated:	        2024-08-12 @ 16:22
;
; Modinfo:
;
;-----------------------------------------------------------

    include "includes/amsdosbiosfirmware.asm"
    include "includes/screenpack.asm"
    include "includes/soundmanager.asm"

	DEVICE AMSTRADCPC6128
    
    org $1200

start:

main_loop:
    jp main_loop


    SAVEAMSDOS "ftd.cpc", start, $-start, start