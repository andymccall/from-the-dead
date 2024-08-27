;
; Title:	          From the Dead - Commander X16
;
; Description:     From the Dead for the Commander X16
;
; Author:	       Andy McCall, mailme@andymccall.co.uk
;
; Created:		   
; Last Updated:	   
;
; Modinfo:
;

.segment "STARTUP"
.segment "INIT"
.segment "ONCE"

.segment "ZEROPAGE"
ptr: .res 2

.segment "CODE"

start:
   jmp start
