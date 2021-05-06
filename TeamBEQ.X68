*-----------------------------------------------------------
* Title      : 68000 Disassembler (DASM)
* Written by : Team BEQ
*                Jonathan Hendrickson, Guiragos Guiragossian,
*                Dylan Thibault, Omar Nevarez
*
* Class      : CSS 422 A Sp 21 with Jim Hogg
* Description: A disassembler for 68k machine code.
*-----------------------------------------------------------

; Declare variables here

; ========================================================================
; "main" routine
; Dylan, Gary
; 
; TODO: DESCRIPTION OF MAIN ROUTINE FUNCTIONALITY
; ========================================================================
        ORG     $1000


main:   MOVE.B  D7, D6      ; Example instruction and comment
        SIMHALT             ; halt simulator
        
        
; ========================================================================
; "identifyOpcode" subroutine
; Jonathan
; 
; Reads the Word at A2 and determines which opcode it represents.
; When the opcode is identified, the appropriate "decodeX" subroutine
; is invoked.
; ========================================================================
identifyOpcode:
        MOVE.B  D7, D6      ; Example instruction and comment
        RTS                 ; Return from subroutine
        

; ------------------------------------------------------------
; "example" helper function
; Jonathan
; ------------------------------------------------------------
example:
        ; This is an example of a helper function. Use this format for helper
        ; functions, as it will make it easier for us to tell the difference 
        ; between the core routines and smaller helper functions.
        RTS                 ; Return from decodeNOP subroutine

        END    main         ; last line of source
        
        
; ========================================================================
; "decodeX" subroutines
; Gary, Dylan
; 
; Set of subroutines which are invoked by identifyOpcode.
; A decodeX subroutine will read from A2 and use TRAP #15 to output
; the instruction.
;
; For example, the "decodeLEA" subroutine will read A2 (which contains the
; opcode) to record the parameters (such as destination register). If the
; opcode indicates that the next word represents a destination address, then
; decodeLEA will advance A2 to the next word and decode that.
; To finish, decodeLEA will output the decoded instruction with TRAP #15
; ========================================================================
; ------------------------------------------------------------
; 1. "decodeNOP" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeNOP:
        ; Put code here
        RTS                 ; Return from decodeNOP subroutine


; ------------------------------------------------------------
; 2. "decodeMOVE" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeMOVE:
        ; Put code here
        RTS                 ; Return from decodeMOVE subroutine


; ------------------------------------------------------------
; 3. "decodeMOVEM" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeMOVEM:
        ; Put code here
        RTS                 ; Return from decodeMOVEM subroutine


; ------------------------------------------------------------
; 4. "decodeADD" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeADD:
        ; Put code here
        RTS                 ; Return from decodeADD subroutine


; ------------------------------------------------------------
; 5. "decodeSUB" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeSUB:
        ; Put code here
        RTS                 ; Return from decodeSUB subroutine


; ------------------------------------------------------------
; 6. "decodeMULS" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeMULS:
        ; Put code here
        RTS                 ; Return from decodeMULS subroutine


; ------------------------------------------------------------
; 7. "decodeDIVU" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeDIVU:
        ; Put code here
        RTS                 ; Return from decodeDIVU subroutine


; ------------------------------------------------------------
; 8. "decodeLEA" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeLEA:
        ; Put code here
        RTS                 ; Return from decodeLEA subroutine


; ------------------------------------------------------------
; 9. "decodeAND" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeAND:
        ; Put code here
        RTS                 ; Return from decodeAND subroutine


; ------------------------------------------------------------
; 10. "decodeNOT" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeNOT:
        ; Put code here
        RTS                 ; Return from decodeNOT subroutine


; ------------------------------------------------------------
; 11. "decodeLSL_LSR" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeLSL_LSR:
        ; Put code here
        RTS                 ; Return from decodeLSL_LSR subroutine


; ------------------------------------------------------------
; 12. "decodeASL_ASR" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeASL_ASR:
        ; Put code here
        RTS                 ; Return from decodeASL_ASR subroutine


; ------------------------------------------------------------
; 13. "decodeBcc" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeBcc:
        ; Put code here
        RTS                 ; Return from decodeBcc subroutine


; ------------------------------------------------------------
; 14. "decodeJSR" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeJSR:
        ; Put code here
        RTS                 ; Return from decodeJSR subroutine


; ------------------------------------------------------------
; 15. "decodeRTS" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeRTS:
        ; Put code here
        RTS                 ; Return from decodeRTS subroutine


; ------------------------------------------------------------
; 16. "decodeBRA" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeBRA:
        ; Put code here
        RTS                 ; Return from decodeBRA subroutine


; ========================================================================
; Generic Helper Functions
; 
; Set of subroutines which do various tasks which are repeated frequently.
; Each helper function should be commented with input and output.
; If input is required, request through D0, D1, etc
; Return using D0
; ========================================================================
; ------------------------------------------------------------
; example helper function
; Jonathan
;
; Example of what a helper function might look like
; ------------------------------------------------------------
exampleHelp:
        ; Put code here
        RTS                 ; Return from decodeBRA subroutine


        END    main         ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
