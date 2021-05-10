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


main:   LEA     $6000, A2      ; Testing identifyOpcode
        MOVE.W  #$E540, (A2)
        JSR     identifyOpcode
        
        SIMHALT             ; halt simulator
        
        
; ========================================================================
; "identifyOpcode" subroutine
; Jonathan
; 
; Reads the Word at A2 and determines which opcode it represents.
; When the opcode is identified, the appropriate "decodeX" subroutine
; is invoked.
;
; Uses a generated Trie structure to determine where to split on which bits
; in order to efficiently identify the exact opcode
; ========================================================================
identifyOpcode:
        MOVE.W  (A2), D0    ; Move the value at A2 into D0 for bit testing
        BTST    #$F, D0     ; Check the 1st bit (from the left)
        BEQ     split0      ; Split based on the first bit
        BRA     split1

split0: 
        BTST    #$E, D0     ; Check the 2nd bit
        BEQ     decodeMOVE  ; MOVE follows 00+
        BRA     split01
        
split01:
        BTST    #$D, D0     ; Check the 3rd bit
        BEQ     split0100   ; Code is 010, but all subcodes are 0100
        BRA     split0110   ; Code is 011, but all subcodes are 0110        

split0100:
        BTST    #$8, D0     ; Check the 8th bit for LEA
        BNE     decodeLEA   ; LEA follows 0100XXX1+
        BTST    #$B, D0     ; Check the 5th bit for NOT
        BEQ     decodeNOT   ; NOT follows 01000+
        BTST    #$9, D0     ; Check the 7th bit
        BEQ     decodeMOVEM ; MOVEM follows 01001x0+
        BRA     split0100111

split0100111:
        BTST    #$7, D0     ; Check the 9th bit for JSR
        BNE     decodeJSR   ; JSR follows 010011101+
        BTST    #$2, D0     ; Check the 14th bit
        BEQ     decodeNOP   ; NOP follows 01001110011100+
        BRA     decodeRTS   ; RTS follows 01001110011101+

split0110:
        BTST    #$B, D0     ; Check the 5th bit
        BEQ     split01100
        BRA     split01101

split01100:
        BTST    #$A, D0     ; Check the 6th bit
        BEQ     decodeBRA   ; BRA starts with 011000
        BRA     decodeBEQ   ; BEQ starts with 011001
        
split01101:
        BTST    #$8, D0     ; Check the 8th bit
        BEQ     decodeBGE   ; BGE starts with 01101100
        BRA     decodeBLT   ; BLT starts with 01101101
        
split1: 
        BTST    #$E, D0     ; Check the 2nd bit
        BEQ     split10
        BRA     split11

split10:
        BTST    #$C, D0     ; Check the 4th bit
        BEQ     decodeDIVUW ; DIVU.W follows 1000+
        BRA     decodeSUB   ; SUB follows 1001+

split11:
        BTST    #$D, D0     ; Check the 3rd bit
        BEQ     split110
        BRA     split111

split110:
        BTST    #$C, D0     ; Check the 4th bit for ADD
        BNE     decodeADD   ; ADD follows 1101+
        BTST    #$8, D0     ; MULS.W has all 3 bits at 8, 9, and 10 set
        BEQ     decodeAND   ; If any of these BTSTs show a 0, opcode is AND
        BTST    #$7, D0
        BEQ     decodeAND
        BTST    #$6, D0
        BEQ     decodeAND
        BRA     decodeMULSW ; All 3 positions (8, 9, 10) were set

split111:
        BTST    #$7, D0     ; The 9th and 10th bit are set for Memory Shifts
        BEQ     regShift    ; If 9 or 10 are cleared, this is a register shift
        BTST    #$6, D0
        BEQ     regShift
        BTST    #$9, D0     ; Check 7th bit
        BEQ     decodeASx_M ; ASL_ASR Memory Shift follows 1110000x11+
        BRA     decodeLSx_M ; LSL_LSR Memory Shift follows 1110001x11+

regShift: ; Special split specifically for ASx/LSx Register Shifts
        BTST    #$4, D0     ; Check the 12th bit
        BEQ     decodeASx_R ; ASL_ASR Register Shift follows 1110xxxxxxx01+
        BEQ     decodeLSx_M ; LSL_LSR Register Shift follows 1110xxxxxxx00+
        
        
        
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
; 6a. "decodeMULSW" subroutine
; AUTHOR
;
; TODO: DESCRIPTION MULS.W
; ------------------------------------------------------------
decodeMULSW:
        ; Put code here
        RTS                 ; Return from decodeMULSW subroutine
        
        
; ------------------------------------------------------------
; 7a. "decodeDIVUW" subroutine
; AUTHOR
;
; TODO: DESCRIPTION DIVU.W
; ------------------------------------------------------------
decodeDIVUW:
        ; Put code here
        RTS                 ; Return from decodeDIVUW subroutine


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
; 11a. "decodeLSx_M" subroutine
; AUTHOR
;
; TODO: DESCRIPTION - LSL or LSR Memory Shift
; ------------------------------------------------------------
decodeLSx_M:
        ; Put code here
        RTS                 ; Return from decodeLSx_M subroutine


; ------------------------------------------------------------
; 11b. "decodeLSx_R" subroutine
; AUTHOR
;
; TODO: DESCRIPTION - LSL or LSR Register Shift
; ------------------------------------------------------------
decodeLSx_R:
        ; Put code here
        RTS                 ; Return from ddecodeLSx_R subroutine


; ------------------------------------------------------------
; 12a. "decodeASx_M" subroutine
; AUTHOR
;
; TODO: DESCRIPTION - ASL or ASR Memory Shift
; ------------------------------------------------------------
decodeASx_M:
        ; Put code here
        RTS                 ; Return from decodeASx_M subroutine


; ------------------------------------------------------------
; 12b. "decodeASx_R" subroutine
; AUTHOR
;
; TODO: DESCRIPTION - ASL or ASR Register Shift
; ------------------------------------------------------------
decodeASx_R:
        ; Put code here
        RTS                 ; Return from decodeASx_R subroutine


; ------------------------------------------------------------
; 13a. "decodeBEQ" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeBEQ:
        ; Put code here
        RTS                 ; Return from decodeBEQ subroutine


; ------------------------------------------------------------
; 13b. "decodeBGE" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeBGE:
        ; Put code here
        RTS                 ; Return from decodeBGE subroutine


; ------------------------------------------------------------
; 13c. "decodeBLT" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeBLT:
        ; Put code here
        RTS                 ; Return from decodeBLT subroutine


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
; Each helper function should be commented with required input and output.
; 
; If input is required, request through D0, D1, etc
; Return using D0
; ========================================================================
; ------------------------------------------------------------
; example helper function
; NAMEHERE
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
