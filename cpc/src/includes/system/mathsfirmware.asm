;
; Title:		        Amstrad CPC Maths Firmware
; Filename:             mathsfirmware.asm
;
; Description:          Contains firmware defintions for the
;                       Amstrad CPC maths operations
;
; Author:		        Andy McCall, mailme@andymccall.co.uk
;
; Created:		        2024-08-15 @ 18:37
; Last Updated:	        2024-08-12 @ 18:37
;
; Modinfo:
;
;---------------------------------------------------------------- 

; &BDC1   MOVE REAL (&BD3D for the 464)
;       Action: Copies the five bytes that are  pointed to by DE to the
;               location held in HL
;       Entry:  DE points to the source  real  value,  and HL points to
;               the destination
;       Exit:   HL points to the real  value  in the destination, Carry
;               is true if the move  went  properly,  F is corrupt, and
;               all other registers are preserved
;       Notes:  For the 464 only, A holds the exponent byte of the real
;               value when the routine is exited

; 001   &BD64   INTEGER TO REAL (&BD40 for the 464)
;       Action: Converts an integer value into a real value
;       Entry:  HL holds the integer  value,  DE  points  to the desti-
;               nation for the real value, bit 7 of A holds the sign of
;               the integer value - it is taken to be negative if bit 7
;               is set
;       Exit:   HL points to the real value  in the destination, AF and
;               DE are corrupt, and all others are preserved

; 002   &BD67   BINARY TO REAL (&BD43 for the 464)
;       Action: Converts a four byte binary value  into a real value at
;               the same location
;       Entry:  HL points to the binary  value,  bit  7  of A holds the
;               sign of the binary value - negative if it is set
;       Exit:   HL points to the real  value  in  lieu of the four byte
;               binary  value,  AF  is  corrupt,  and  all  others  are
;               preserved
;       Notes:  A four byte binary value  is  an unsigned integer up to
;               &FFFFFFFF and is stored with the least significant byte
;               first, and with the most significant byte last

; 003   &BD6A   REAL TO INTEGER (&BD46 for the 464)
;       Action: Converts a real  value,  rounding  it  into an unsigned
;               integer value held in HL
;       Entry:  HL points to the real value
;       Exit:   HL holds  the  integer  value,  Carry  is  true  if the
;               conversion worked successfully, the Sign flag holds the
;               sign of the integer (negative if it is set).  A, IX and
;               the other flags are  corrupt,  and  all other registers
;               are preserved

;       Notes:  This rounds the decimal part  down  if  it is less than
;               0.5, but rounds up if it  is  greater than, or equal to
;               0.5

; 004   &BD6D   REAL TO BINARY (&BD49 for the 464)
;       Action: Converts a real value,  rounding  it  into  a four byte
;               binary value at the same location
;       Entry:  HL points to the real value
;       Exit:   HL points to  the  binary  value  in  lieu  of the real
;               value, bit 7 of B holds  the  sign for the binary value
;               (it is negative if bit  7  is  set),  AF,  B and IX are
;               corrupt, and all other registers are preserved
;       Notes:  See REAL TO INTEGER for  details  of how the values are
;               rounded up or down

; 005   &BD70   REAL FIX (&BD4C for the 464)
;       Action: Performs an equivalent  of  BASIC's  FIX  function on a
;               real value, leaving the  result  as  a four byte binary
;               value at the same location
;       Entry:  HL points to the real value
;       Exit:   HL points to  the  binary  value  in  lieu  of the real
;               value, bit 7 of B has the  sign of the binary value (it
;               is negative if bit 7 is set), AF, B and IX are corrupt,
;               and all others are preserved
;       Notes:  FIX removes any  decimal  part  of  the value, rounding
;               down whether  positive  or  negative  -  see  the BASIC
;               handbook for more details on the FIX command

; 006   &BD73   REAL INT (&BD4F for the 464)
;       Action: Performs an equivalent  of  BASIC's  INT  function on a
;               real value, leaving the  result  as  a four byte binary
;               value at the same location
;       Entry:  HL points to the real value
;       Exit:   HL points to  the  binary  value  in  lieu  of the real
;               value, bit 7 of B has the  sign of the binary value (it
;               is negative if bit 7 is set), AF, B and IX are corrupt,
;               and all others are preserved
;       Notes:  INT removes any  decimal  part  of  the value, rounding
;               down if the nurnber is positive,  but rounding up if it
;               is negative

; 007   &BD76   INTERNAL SUBROUTINE - not useful (&BD52 for the 464)

; 008   &BD79   REAL *10^A (&BD55 for the 464)
;       Action: Multiplies a real value by 10 to the power of the value
;               in the A  register,  leaving  the  result  at  the same
;               location
;       Entry:  HL points to the real value,  and  A holds the power of
;               10
;       Exit:   HL points to the  result,  AF,  BC,  DE,  IX and IY are
;               corrupt

; 009   &BD7C   REAL ADDITION (&BD58 for the 464)
;       Action: Adds two real values, and leaves  the result in lieu of
;               the first real number
;       Entry:  HL points to the first real value, and DE points to the
;               second real value
;       Exit:   HL points to the  result,  AF,  BC,  DE,  IX and IY are
;               corrupt

; 010   &BD82   REAL REVERSE SUBTRACTION (&BD5E for the 464)
;       Action: Subtracts the first  real  value  from  the second real
;               value, and leaves  the  result  in  lieu  of  the first
;               number
;       Entry:  HL points to the first real value, and DE points to the
;               second real value
;       Exit:   HL points to the  result  in  place  of  the first real
;               value, AF, BC, DE, IX and IY are corrupt

; 011   &BD85   REAL MULTIPLICATION (&BD61 for the 464)
;       Action: Multiplies two real  values  together,  and  leaves the
;               result in lieu of the first number
;       Entry:  HL points to the first real value, and DE points to the
;               second real value
;       Exit:   HL points to the  result  in  place  of  the first real
;               value, AF, BC, DE, IX and IY are corrupt

; 012   &BD88   REAL DIVISION (&BD64 for the 464)
;       Action: Divides the first real value  by the second real value,
;               and leaves the result in lieu of the first number
;       Entry:  HL points to the first real value, and DE points to the
;               second real value
;       Exit:   HL points to the  result  in  place  of  the first real
;               value, AF, BC, DE, IX and IY are corrupt

; 013   &BD8E   REAL COMPARISON (&BD6A for the 464)
;       Action: Compares two real values
;       Entry:  HL points to the first real value, and DE points to the
;               second real value
;       Exit:   A holds the result of  the  comparison process, IX, IY,
;               and the other flags  are  corrupt,  and  all others are
;               preserved
;       Notes:  After this routine  has  been  called,  the  value in A
;               depends on the result of the comparison as follows:
;               if the first real  number  is  greater  than the second
;               real number, then A holds &01
;               if the first real number is the same as the second real
;               number, then A holds &00  if  the second real number is
;               greater than the first real number, then A holds &FF

; 014   &BD91   REAL UNARY MINUS (&BD6D for the 464)
;       Action: Reverses the sign of a real value
;       Entry:  HL points to the real value
;       Exit:   HL points to the new value of the real number (which is
;               stored in place of  the  original  number),  bit 7 of A
;               holds the sign of the result  (it  is negative if bit 7
;               is set), AF and IX are corrupt, and all other registers
;               are preserved

; 015   &BD94   REAL SIGNUM/SGN (&BD70 for the 464)
;       Action: Tests a real value, and compares it with zero
;       Entry:  HL points to the real value
;       Exit:   A holds the result of  this  comparison process, IX and
;               the  other  ¡lags  are  corrupt,  and  all  others  are
;               preserved
;       Notes:  After this routine  has  been  called,  the  value in A
;               depends on the result of the comparison as follows:
;               if the real number is greater than 0, then A holds &01,
;               Carry is false, and Zero is false
;               if the real number is the same  as 0, then A holds &00,
;               Carry is false, and Zero is true
;               if the real number is smaller than 0, then A holds &FF,
;               Carry is true, and Zero is false

; 016   &BD97   SET ANGLE MODE (&BD73 for the 464)
;       Action: Sets the angular  calculation  mode  to  either degrees
;               (DEG) or radians (RAD)
;       Entry:  A holds the mode setting  -  0  for  RAD, and any other
;               value for DEG
;       Exit:   All registers are preserved

; 017   &BD9A   REAL PI (&BD76 for the 464)
;       Action: Places the real value of pi at a given memory location
;       Entry:  HL holds the address at which the  value of pi is to be
;               placed
;       Exit:   AF and DE  are  corrupt,  and  all  other registers are
;               preserved

; 018   &BD9D   REAL SQR (&BD79 for the 464)

;       Action: Calculates the square root of a real value, leaving the
;               result in lieu of the real value
;       Entry:  HL points to the real value
;       Exit:   HL points to the result of the calculation, AF, BC, DE,
;               IX and IY are corrupt

; 019   &BDA0   REAL POWER (&BD7C for the 464)
;       Action: Raises the first real value to  the power of the second
;               real value, leaving the  result  in  lieu  of the ¡irst
;               real value
;       Entry:  HL points to the first real value, and DE points to the
;               second real value
;       Exit:   HL points to the result of the calculation, AF, BC, DE,
;               IX and IY are corrupt

; 020   &BDA3   REAL LOG (&BD7F for the 464)
;       Action: Returns the naperian logarithm  (to  base  e) of a real
;               value, leaving the result in lieu of the real value
;       Entry:  HL points to the real value
;       Exit:   HL points to the  logarithrn  that has been calculated,
;               AF, BC, DE, LY and IY are corrupt

; 021   &BDA6   REAL LOG 10 (&BD82 for the 464)
;       Action: Returns the logarithm (to  base  10)  of  a real value,
;               leaving the result in lieu of the real value
;       Entry:  HL points to the real value
;       Exit:   HL points to the  logarithrn  that has been calculated,
;               AF, BC, DE, IX and IY are corrupt

; 022   &BDA9   REAL EXP (&BD85 for the 464)
;       Action: Returns the antilogarithm  (base  e)  of  a real value,
;               leaving the result in lieu of the real value
;       Entry:  HL points to the real value
;       Exit:   HL points  to  the  antilogarithm  that  has  been cal-
;               culated, AF, BC, DE, IX and IY are corrupt
;       Notes:  See the BASIC handbook for details of EXP

; 023   &BDAC   REAL SINE (&BD88 for the 464)
;       Action: Returns the sine of a real value, leaving the result in
;               lieu of the real value
;       Entry:  HL points to the real value (ie all angle)
;       Exit:   HL points to the sine  value  that has been calculated,
;               AF, BC, DE, IX and IY are corrupt

; 024   &BDAF   REAL COSINE (&BD8B for the 464)
;       Action: Returns the cosine  of  a  real  value,  leaving  a the
;               result in lieu of the real value
;       Entry:  HL points to the real value (ie an angle)
;       Exit:   HL points to the cosine value that has been calculated,
;               AF, BC, DE, IX and IY are corrupt

; 025   &BDB2   REAL TANGENT (&BD8E for the 464)
;       Action: Returns the tangent of a real value, leaving the result
;               in lieu of the real value
;       Entry:  HL points to the real value (ie an angle)
;       Exit:   HL points to  the  tangent  value  that  has  been cal-
;               culated, AF, BC, DE, IX and IY are corrupt

; 026   &BDB5   REAL ARCTANGENT (&BD91 for the 464)
;       Action: Returns the arctangent  of  a  real  value, leaving the
;               result in lieu of the real value
;       Entry:  HL points to the real value (ie an angle)
;       Exit:   HL  points  to  the  arctangent  value  that  has  been
;               calculated, AF, BC, DE, IX and IY are corrupt

;          All of the above routines to calculate sine, cosine, tangent
;               and
;                         arctangent are slightly inaccuarate

; 027   &BDB8   INTERNAL SUBROUTINE - not useful (&BD94 for the 464)

; 028   &BDBB   INTERNAL SUBROUTINE - not useful (&BD97 for the 464)

; 029   &BDBE   INTERNAL SUBROUTINE - not useful (&BD9A for the 464)



; Maths Subroutines for the 664 and 6128 only

;       &BD5E   TEXT INPUT
;       Action: Allows  upto  255  characters  to  be  input  from  the
;               keyboard into a buffer
;       Entry:  HL points to the start of  the buffer - a NUL character
;               must be placed after any characters already present, or
;               at the start of the buffer if there is no text
;       Exit:   A has the last key pressed,  HL  points to the start of
;               the buffer, the flags are  corrupt,  and all others are
;               preserved
;       Notes:  This routine prints any existing contents of the buffer
;               (upto the NUL character) and then echoes any keys used;
;               it allows full line  editing  with  the cursor keys and
;               DEL, etc; it is exited only by use of ENTER or ESC

;       &BD7F   REAL RND
;       Action: Creates a new RND real  value  at a location pointed to
;               by HL
;       Entry:  HL points to the destination for the result
;       Exit:   HL points to the RND value, AF, BC, DE and IX registers
;               are corrupt; and all others are preserved

;       &BD8B   REAL RND(0)
;       Action: Returns the last RND value  created,  and  puts it in a
;               location pointed to by HL
;       Entry:  HL points  to  the  place  where  the  value  is  to be
;               returned to
;       Exit:   HL points to  the  value  created,  AF,  DE  and IX are
;               corrupt, and all other registers are preserved
;       Notes:  See the BASIC handbook for more details on RND(0)