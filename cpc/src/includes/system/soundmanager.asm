;
; Title:		        Amstrad CPC Sound Manager
; Filename:             soundmanager.asm
;
; Description:          Contains firmware defintions for the
;                       Amstrad CPC sound manager
;
; Author:		        Andy McCall, mailme@andymccall.co.uk
;
; Created:		        2024-08-15 @ 18:25
; Last Updated:	        2024-08-12 @ 18:25
;
; Modinfo:
;
;----------------------------------------------------------------  
 
SOUND_RESET                 = $BCA7

; Action: Resets the sound manager  by  clearing the sound queues
;         and abandoning any current sounds
; Entry:  No entry conditions
; Exit:   AF, BC, DE  and  HL  are  corrupt,  and  all others are
;         preserved

SOUND_QUEUE                 = $BCAA

; Action: Adds a sound to the sound queue of a channel
; Entry:  HL contains the  address  of  a  series  of bytes which
;         define the sound and are  stored  in the central 32K of
;         RAM
; Exit:   If the sound was successfully  added to the queue, then
;         Carry is true and HL  is  corrupt;  if one of the sound
;         queues  was  full,  then  Carry  is  false  and  HL  is
;         preserved; in either case, A, BC,  DE, IX and the other
;         flags are corrupt, and all others are preserved
; Notes:  The bytes required to define  the sound are as follows:
;         byte 0 - channel status byte
;         byte 1 - volume envelope to use
;         byte 2 - tone envelope to use
;         bytes 3$4 - tone period
;         byte 5 - noise period
;         byte 6 - start volume
;         bytes 7$8 - duration of  the  sound, or envelope repeat
;         count

SOUND_CHECK                 = $BCAD
; Action: Gets the status of a sound channel
; Entry:  A contains the channel to test  -  for channel A, bit 0
;         set; for channel B, bit 1 set; for channel C, bit 2 set
; Exit:   A contains the channel status, BC, DE, HL and flags are
;         corrupt, and all others are preserved
; Notes:  The channel  status  returned  is  bit  significant, as
;         follows:
;         bits 0 to 2  - the  number  of free spaces in the sound
;         queue
;         bit 3 - trying to rendezvous with channel A
;         bit 4 - trying to rendezvous with channel B
;         bit 5 - trying to rendezvous with channel C
;         bit 6 - holding the channel
;         bit 7 - producing a sound

SOUND_ARM_EVENT              = $BCB0
; Action: Sets up an event which  will  be activated when a space
;         occurs in a sound queue
; Entry:  A contains the channel  to  set  the  event up for (see
;         SOUND CHECK for the bit  values  this can take), and HL
;         holds the address of the event block
; Exit:   AF, BC, DE and HL are  corrupt, and all other registers
;         are preserved
; Notes:  The event block must  be  initialised  by KL INIT EVENT
;         and is disarmed when the event itself is run

SOUND_RELEASE                   = $BCB3
; Action: Allows the playing of sounds  on specific channels that
;         had been stopped by SOUND HOLD
; Entry:  A contains the sound channels to be released (see SOUND
;         CHECK for the bit values this can take)
; Exit:   AF, BC, DE, HL and IX  are  corrupt, and all others are
;         preserved

SOUND_HOLD                  = $BCB6
; Action: Immediately stops all sound output (on all channels)
; Entry:  No entry conditions
; Exit:   If a sound was being  made,  then  Carry is true; if no
;         sound was being  made,  then  Carry  is  false;  in all
;         cases, A, BC, HL and  other  flags are corrupt, and all
;         others are preserved
; Notes:  When the sounds  are  restarted,  they  will begin from
;         exactly the same place that they were stopped

SOUND_CONTINUE                  = $BCB9
; Action: Restarts all sound output (on all channels)
; Entry:  No entry conditions
; Exit:   AF, BC, DE  and  IX  are  corrupt,  and  all others are
;         preserved

SOUND_AMPL_ENVELOPE             = $BCBC
; Action: Sets up avolume envelope
; Entry:  A holds an envelope number (from 1 to 15), HL holds the
;         address of a block of data for the envelope
; Exit:   If it was set up properly,  Carry is true, HL holds the
;         data block address + 16, A  and  BC are corrupt; if the
;         envelope number is invalid, then Carry is false, and A,
;         B and HL are  preserved;  in  either  case,  DE and the
;         other flags are corrupt,  and  all  other registers are
;         preserved
; Notes:  All the rules of  enevelopes  in  BASIC also apply; the
;         block of  the  data  for  the  envelope  is  set  up as
;         follows:
;         byte 0 - number of sections in the envelope
;         bytes 1 to 3 - first section of the envelope
;         bytes 4 to 6 - second section of the envelope
;         bytes 7 to 9 - third section of the envelope
;         bytes 10 to 12 - fourth section of the envelope
;         bytes 13 to 15 - fifth section of the envelope
;         Each section of the envelope has three bytes set out as
;         follows:
;         byte 0 - step count (with bit 7 set)
;         byte 1 - step size
;         byte 2 - pause time
;         or if it  is  a  hardware  envelope,  then each section
;         takes the following form:
;         byte 0 - envelope shape (with bit 7 not set)
;         bytes 1 and 2 - envelope period
;         See also SOUND TONE ENVELOPE below

SOUND_TONE_ENVELOPE         = $BCBF

; Action: Sets up a tone envelope
; Entry:  A holds an envelope number (from 1 to 15), HL holds the
;         address of a block of data for the envelope
; Exit:   If it was set up properly,  Carry is true, HL holds the
;         data block address + 16, A and BC are corrupt; ¡ if the
;         envelope number is invalid, then Carry is false, and A,
;         B and HL are  preserved;  in  either  case,  DE and the
;         other flags are corrupt,  and  all  other registers are
;         preserved
; Notes:  All the rules of  envelopes  in  BASIC  also apply; the
;         block of  the  data  for  the  envelope  is  set  up as
;         follows:
;         byte 0 - number of sections in the envelope
;         bytes 1 to 3 - first section of the envelope
;         bytes 4 to 6 - second section of the envelope
;         bytes 7 to 9 - third section of the envelope
;         bytes 10 to 12 - fourth section of the envelope
;         bytes 13 to 15 - fifth section of the envelope
;         Each section of the envelope has three bytes set out as
;         follows:
;         byte 0 - step count
;         byte 1 - step size
;         byte 2 - pause time
;         See also SOUND AMPL ENVELOPE above

SOUND_A_ADDRESS             = $BCC2

; Action: Gets the address of  the  data  block associated with a
;         volume envelope
; Entry:  A contains an envelope number (from 1 to 15)
; Exit:   If it was found, then Carry  is true, HL holds the data
;         block's address,  and  BC  holds  its  length;  if  the
;         envelope number is invalid, then  Carry is false, HL is
;         corrupt and BC is preserved;  in  both cases, A and the
;         other flags are corrupt, and all others are preserved

SOUND_T_ADDRESS             = $BCC5

; Action: Gets the address of  the  data  block associated with a
;         tone envelope
; Entry:  A contains an envelope number (from 1 to 15)
; Exit:   If it was found, then Carry  is true, HL holds the data
;         block's address,  and  BC  holds  its  length;  if  the
;         envelope number is invalid, then  Carry is false, HL is
;         corrupt and BC is preserved;  in  both cases, A and the
;         other flags are corrupt, and all others are preserved