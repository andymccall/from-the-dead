;
; Title:		        From the Dead
; Filename:             titlescreen.asm
;
; Description:          Code to display the title screen
;
; Author:		        Andy McCall, mailme@andymccall.co.uk
;
; Created:		        2024-08-15 @ 16:22
; Last Updated:	        2024-08-12 @ 16:22
;
; Modinfo:
;
;-----------------------------------------------------------    
; Kernal Routines

SCR_SET_MODE            = $BC0E
SCR_SET_BORDER          = $BC38
SCR_SET_INK             = $BC32

;-----------------------------------------------------------
; Constants

GRAPHICS_MODE_0         = 0

;-----------------------------------------------------------

display_title_screen:

set_graphics_mode:
    ld      a,GRAPHICS_MODE_0
    call    SCR_SET_MODE

set_border_color:
    ld      hl,pal_data
    ld      b,(hl)
    ld      c,b
    call    SCR_SET_BORDER
    ld      b,0x10
    ld      hl,pal_data+15

outer_loop:
    push    hl
    push    bc
    ld      a,b
    dec     a
    and     a,0x0f
    ld      b,(hl)
    ld      c,b
    call    SCR_SET_INK
    pop     bc
    pop     hl
    dec     hl
    djnz    outer_loop
    ld	    de,0xc000
    ld	    hl,title_screen_data
    ld 	    bc,0x4000
    ldir
    ret

pal_data:
    db $00,$03,$09,$04,$01,$0A,$0D,$06
    db $0B,$10,$0E,$15,$13,$16,$19,$1A

title_screen_data:
    incbin "../resources/titlescreen.bin"