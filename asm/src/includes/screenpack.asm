;
; Title:		Amstrad CPC Firmware Screen Pack
; Filename:             screenpack.asm
;
; Description:          Contains firmware defintions for the
;                       Amstrad CPC screen pack
;
; Author:		Andy McCall, mailme@andymccall.co.uk
;
; Created:		2024-08-15 @ 16:22
; Last Updated:	        2024-08-12 @ 16:22
;
; Modinfo:
;
;----------------------------------------------------------------   

SCR_INITIALISE                  = $BBFF

; Action: Initialises the Screen Pack to  the default values used
;         when the computer is first switched on
; Entry:  No entry conditions
; Exit:   AF, BC, DE  and  HL  are  corrupt,  and  all others are
;         preserved
; Notes:  All screen indirections are  restored  to their default
;         settings, as are inks and  flashing speeds; the mode is
;         switched to MODE 1 and  the  screen is cleared with PEN
;         0; the screen address is moved  to $C000 and the screen
;         offset is set to zero

SCR_RESET                       = $BC02

; Action: Resets the Screen Packs  indirections, flashing speeds
;         and inks to their default values
; Entry:  No entry conditions
; Exit:   AF, BC, DE r1nd HL are corrupt, and all other registers
;         are preserved

SCR_SET_OFFSET                  = $BC05

; Action: Sets the screen offset to  the  specified values - this
;         can cause the screen to scroll
; Entry:  HL contains the required offset, which should be even
; Exit:   AF and HL are corrupt, and alI others are preserved
; Notes:  The screen offset is reset  to  0  whenever its mode is
;         set, or it is  cleared  by  SCR_ CLEAR (but not BASICs
;         CLS)

SCR_SET_BASE                    = $BC08

; Action: Sets the location in memory of the screen - effectively
;         can only be $C000 or $4000
; Entry:  A contains the  most  significant  byte  of  the screen
;         address required
; Exit:   AF and HL  are  corrupt,  and  all  other registers are
;         preserved
; Notes:  The screen memory can only be  set at 16K intervals (ie
;         $0000, $4000, $8000, $C000)  and  when  the computer is
;         first switched on the 16K  of  screen memory is located
;         at $C000)

SCR_GET_LOCATION                = $BC0B

; Action: Gets the location of  the  screen  memory  and also the
;         screen offset
; Entry:  No entry conditions
; Exit:   A  holds  the  most  significant  byte  of  the  screen
;         address, HL holds the  current  offset,  and all others
;         are preserved

SCR_SET_MODE                    = $BC0E

; Action: Sets the screen mode
; Entry:  A contains the mode number -  it has the same value and
;         characteristics as in BASIC
; Exit:   AF, BC, DE  and  HL  are  corrupt,  and  all others are
;         preserved
; Notes:  The windows are set to  cover  the whole screen and the
;         graphics origin is set to the bottom left corner of the
;         screen; in addition, the current stream is set to zero,
;         and the screen offset is zeroed

SCR_GET_MODE                    = $BC11

; Action: Gets the current screen mode
; Ently:  No entry conditions
; Exit:   If the mode is 0,  then  Carry  is true, Zero is false,
;         and A contains 0;  if  the  mode  is  1,  then Carry is
;         false, Zero is true, and A  contains  1; if the mode is
;         2, then Carry is false,  Zero  is false, and A contains
;         2; in all cases the other flags are corrupt and all the
;         other registers are preserved

SCR_CLEAR                       = $BC14   

; Action: Clears the whole of the screen
; Entry:  No entry conditions
; Exit:   AF, BC, DE  and  HL  are  corrupt,  and  all others are
;         preserved

SCR_CHAR_LIMITS                 = $BC17

; Action: Gets the size  of  the  whole  screen  in  terms of the
;         numbers of characters that can be displayed
; Entry:  No entry conditions
; Exit:   B contains the number of  characters across the screen,
;         C contains the number of characters down the screen, AF
;         is corrupt, and all other registers are preserved

SCR_CHAR_POSITION               = $BC1A

; Action: Gets the memory address  of  the  top  left corner of a
;         specified character position
; Entry:  H contains the character physical column and L contains
;         the character physical row
; Exit:   HL contains the memory address of the top left comer of
;         the  character,  B  holds  the  width  in  bytes  of  a
;         character in the present mode,  AF  is corrupt, and all
;         other registers are preserved

SCR_DOT_POSITION                = $BC1D

; Action: Gets the memory  address  of  a  pixel  at  a specified
;         screen position
; Entry:  DE contains the base X-coordinate  of the pixel, and HL
;         contains the base Y-coordinate
; Exit:   HL contains the memory address of the pixel, C contains
;         the bit mask for this  pixel,  B contains the number of
;         pixels stored in a byte minus 1, AF and DE are corrupt,
;         and all others are preserved

SCR_NEXT_BYTE                   = $BC20

; Action: Calculates the screen address of  the byte to the right
;         of the specified screen  address  (may  be  on the next
;         line)
; Entry:  HL contains the screen address
; Exit:   HL holds the screen address of the byte to the right of
;         the original screen address, AF  is corrupt, all others
;         are preserved

SCR_PREV_BYTE                   = $BC23

; Action: Calculates the screen address of  the  byte to the left
;         of the  specified  screen  address  (this  address  may
;         actually be on the previous line)
; Entry:  HL contains the screen address
; Exit:   HL holds the screen address of  the byte to the left of
;         the original address,  AF  is  corrupt,  all others are
;         preserved

SCR_NEXT_LINE                   = $BC26

; Action: Calculates the screen  address  of  the  byte below the
;         specified screen address Ently:  HL contains the screen
;         address
; Exit:   HL contains the screen  address  of  the byte below the
;         original screen address,  AF  is  corrupt,  and all the
;         other registers are preserved

SCR_PREV_LINE                   = $BC29

; Action: Calculates the screen  address  of  the  byte above the
;         specified screen address
; Entry:  HL contains the screen address
; Exit:   HL holds the  screen  address  of  the  byte  above the
;         original address, AF  is  corrupt,  and  all others are
;         preserved

SCR_INK_ENCODE                = $BC2C

; Action: Converts a PEN to provide a mask which, if applied to a
;         screen byte, will convert all of the pixels in the byte
;         to the appropriate PEN
; Entry:  A contains a PEN number
; Exit:   A contains the encoded value of  the PEN, the flags are
;         corrupt, and all other registers are preserved
; Notes:  The mask returned is  different  in  each of the screen
;         modes

SCR_INK_DECODE                  = $BC2F

; Action: Converts a PEN mask into  the  PEN  number (see SCR_INK
;         ENCODE for the re~ erse process)
; Entry:  A contains the encoded value of the PEN
; Exit:   A contains the PEN number,  the  flags are corrupt, and
;         all others are preserved

SCR_SET_INK                     = $BC32

; Action: Sets the colours of a PEN  - if the two values supplied
;         are different then the colours will alternate (flash)
; Entry:  A contains the PEN number,  B  contains the first colour,
;         and C holds the second colour
; Exit:   AF, BC, DE  and  HL  are  corrupt,  and  all others are
;         preserved

SCR_GET_INK                     = $BC35

; Action: Gets the colours of a PEN
; Entry:  A contains the PEN nurnber
; Exit:   B contains the first colour, C holds the second colour,
;         and AF, DE  and  HL  are  corrupt,  and  all others are
;         preserved

SCR_SET_BORDER                  = $BC38

; Action: Sets the colours of the border - again if two different
;         values are supplied, the border will flash
; Entry:  B contains the first colour,  and C contains the second
;         colour
; Exit:   AF, BC, DE  and  HL  are  corrupt,  and  all others are
;         preserved

SCR_GET_BORDER                  = $BC3B

; Action: Gets the colours of the border
; Entry:  No entry conditions
; Exit:   B contains the first colour, C holds the second colour,
;         and AF, DE  and  HL  are  corrupt,  and  all others are
;         preserved

SCR_SET_FLASHING                = $BC3E

; Action: Sets the  speed  with  which  the  border's  and  PENs'
;         colours flash
; Entry:  H holds the time that the  first colour is displayed, L
;         holds the time the second colour is displayed for
; Exit:   AF and HL  are  corrupt,  and  all  other registers are
;         preserved
; Notes:  The length  of  time  that  each  colour  is  shown  is
;         measured in 1/5Oths of a  second,  and  a value of 0 is
;         taken to mean 256 * 1/50 seconds - the default value is
;         10 * 1/50 seconds

SCR_GET_FLASHING                = $BC41

; Action: Gets the periods with which  the  colours of the border
;         and PENs flash
; Entry:  No entry conditions
; Exit:   H holds the duration of  the  first colour, L holds the
;         duration of the second colour,  AF  is corrupt, and all
;         other registers are preserved  -  see  SCR_SET_FLASHING
;         for the units of time used

SCR_FILL_BOX                    = $BC44

; Action: Fills an area of the  screen  with  an  ink - this only
;         works for 'character-sized' blocks of screen
; Entry:  A contains the mask for the  ink  that is to be used, H
;         contains the left hand colurnn  of  the area to fill, D
;         contains the right hand column,  L  holds the top line,
;         and E holds the bottom line of the area (using physical
;         coordinates)
; Exit:   AF, BC, DE  and  HL  are  corrupt,  and  all others are
;         preserved

SCR_FLOOD_BOX                   = $BC17

; Action: Fills an area of the  screen  with  an  ink - this only
;         works for 'byte-sized' blocks of screen
; Entry:  C contains the  encoded  PEN  that  is  to  be used, HL
;         contains the screen address of the top left hand corner
;         of the area to fill, D  contains  the width of the area
;         to be filled in bytes, and E contains the height of the
;         area to be filled in screen lines
; Exit:   AF, BC, DE and HL are  corrupt, and all other registers
;         are preserved
; Notes:  The whole of the  area  to  be  filled  must lie on the
;         screen otherwise unpredictable results may occur

SCR_CHAR_INVERT                 = $BC4A

; Action: Inverts a character's colours; all  pixels in one PEN's
;         colour are printed in  another  PEN's  colour, and vice
;         versa
; Entry:  B contains  one  encoded  PEN,  C  contains  the  other
;         encoded PEN, H contains the physical column number, and
;         L contains the physical  line  number  of the character
;         that is to be inverted
; Exit:   AF, BC, DE  and  HL  are  corrupt,  and  alI  the other
;         registers are preserved

SCR_HW_ROLL                     = $BC4D

; Action: Scrolls the entire screen  up  or  down  by eight pixel
;         rows (ie one character line)
; Entry:  B holds the  direction  that  the  screen  will roll, A
;         holds the encoded PAPER which  the new line will appear
;         in
; Exit:   AF, BC, DE  and  HL  are  corrupt,  and  all others are
;         preserved
; Notes:  This alters the screen  offset;  to  roll  down, B must
;         hold zero, and to roll upwards B must be non-zero

SCR_SW_ROLL                     = $BC50

; Action: Scrolls part of the screen  up  or  down by eight pixel
;         lines - only for 'character-sized' blocks of the screen
; Entry:  B holds the direction to  roll  the screen, A holds the
;         encoded PAPER which  the  new  line  will  appear in, H
;         holds the left column of  the  area  to scroll, D holds
;         the right colurnn, L holds  the  top  line, E holds the
;         bottom line
; Exit:   AF, BC, DE and HL are  corrupt, and all other registers
;         are preserved
; Notes:  The area of the screen is  moved by copying it; to roll
;         down, B must hold zero, and  to  roll upwards B must be
;         non-zero; this routine uses physical roordinates

SCR_UNPACK                      = $BC53

; Action: Changes a character matrix from its eight byte standard
;         form into a set of  pixel  masks which are suitable for
;         the current mode - four *8  bytes are needed in mode 0,
;         two *8 bytes in mode l, and 8 bytes in mode 2
; Entry:  HL contains the address of  the matrix, and DE contains
;         the address where the masks are to be stored
; Exit:   AF. BC, DE and HL are  corrupt, and all other registers
;         are preserved

SCR_REPACK                      = $BC56

; Action: Changes a set of  pixel  masks  (for  the current mode)
;         into a standard eight byte character matrix
; Entry:  A contains the  encoded  foreground  PEN  to be matched
;         against (ie the PEN that is to be regarded as being set
;         in the character), H holds  the  physical column of the
;         character to be `repacked',  L  holds the physical line

;         of the character, and  DE  contains  the address of the
;         area where the character matrix will be built
; Exit:   AF, BC, DE amd HL are  corrupt,  and all the others are
;         preserved

SCR_ACCESS                      = $BC59

; Action: Sets the screen write mode for graphics
; Entry:  A contains the write mode (0=Fill, 1=XOR, 2=AND, 3=OR)
; Exit:   AF. BC, DE and HL are  corrupt, amd all other registers
;         are preserved
; Notes:  The fill mode  means  that  the  ink  that plotting was
;         requested in is the ink that  appears on the screen; in
;         XOR mode, the specified ink  is  XORed with ink that is
;         at that point on the  screen already before plotting; a
;         simiIar situation occurs with the AND and OR modes

SCR_PIXELS                      = $BC5C

; Action: Puts a pixel or pixels on  the screen regardless of the
;         write mode specified by SCR_ACCESS above
; Entry:  B contains the mask  of  the  PEN  to  be drawn with, C
;         contains the  pixel  mask,  and  HL  holds  the  screen
;         address of the pixel
; Exit:   AF is corrupt, amd all others are preserved

SCR_HORIZONTAL                  = $BC5F

; Action: Draws a honzontal line on  the screen using the current
;         graphics write mode
; Entry:  A contains  the  encoded  PEN  to  be  drawn  with,  DE
;         contains the base  X-coordinate  of  the  start  of the
;         line, BC contains  the  end  base  X-coordinate, and HL
;         contains the base Y-coordinate
; Exit:   AF, BC, DE and HL  are  conupt, and all other registers
;         are preserved
; Notes:  The start X-coordinate must  be  less  than  the end X-
;         coordmate

SCR_VERTICAL                    = $BC62

; Action: Draws a vertical line on  the  screen using the current
;         graphics write mode
; Entry:  A contains  the  encoded  PEN  to  be  drawn  with,  DE
;         contains the base X-coordinate  of  the  line, HL holds
;         the start base Y-coordinate,  and  BC  contains the end
;         base Y-coordinate - the  start  coordinate must be less
;         than the end coordinate
; Exit:   AF, BC, DE  and  HL  are  corrupt,  and  all  the other
;         registers are preserved