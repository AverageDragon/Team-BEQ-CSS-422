*-----------------------------------------------------------
* Title      : 68000 Disassembler (DASM)
* Written by : Team BEQ
*                Jonathan Hendrickson, Guiragos Guiragossian,
*                Dylan Thibault, Omar Nevarez
*
* Class      : CSS 422 A Sp 21 with Jim Hogg
* Description: A disassembler for 68k machine code.
*-----------------------------------------------------------

; ========================================================================
; Variables
; ========================================================================

; ------------------------------------------------------------
; "Output" Variables
; Gary
; 
; Set of strings to be used with I/O of given instruction
; ------------------------------------------------------------
oNOP:   DC.B    'NOP',0
oMOVE:  DC.B    'MOVE',0
oMOVEM: DC.B    'MOVEM',0
oADD:   DC.B    'ADD',0
oSUB:   DC.B    'SUB',0
oMULS:  DC.B    'MULS',0
oDIVU:  DC.B    'DIVU',0
oLEA:   DC.B    'LEA',0
oAND:   DC.B    'AND',0
oNOT:   DC.B    'NOT',0
oLSx_M: DC.B    'LSX',0
oLSx_R: DC.B    'LS',0
oASx_M: DC.B    'LS',0
oASx_R: DC.B    'AS',0
oBEQ:   DC.B    'AS',0
oBGE:   DC.B    'BGE',0
oBLT:   DC.B    'BLT',0
oJSR:   DC.B    'JSR',0
oRTS:   DC.B    'RTS',0
oBRA:   DC.B    'BRA',0
oBSize  DC.B    '.B ',0
oWSize  DC.B    '.W ',0
oLSize  DC.B    '.L ',0

; ------------------------------------------------------------
; "Pattern" Variables
; Jonathan
; 
; Set of strings to be used with verifyOpcode to check that the patterns match
; and the opcode isn't actually data
; ------------------------------------------------------------
pNOP:   DC.B    '0100111001110001',0
pMOVE:  DC.B    '00..............',0
pMOVEM: DC.B    '01001.001.......',0
pADD:   DC.B    '1101............',0
pSUB:   DC.B    '1001............',0
pMULS:  DC.B    '1100...111......',0
pDIVU:  DC.B    '1000...011......',0
pLEA:   DC.B    '0100...111......',0
pAND:   DC.B    '1100............',0
pNOT:   DC.B    '01000110........',0
pLSx_M: DC.B    '1110001.11......',0
pLSx_R: DC.B    '1110.......01...',0
pASx_M: DC.B    '1110000.11......',0
pASx_R: DC.B    '1110.......00...',0
pBEQ:   DC.B    '01100111........',0
pBGE:   DC.B    '01101100........',0
pBLT:   DC.B    '01101101........',0
pJSR:   DC.B    '0100111010......',0
pRTS:   DC.B    '0100111001110101',0
pBRA:   DC.B    '01100000........',0


; ========================================================================
; Macros
; ========================================================================

; ------------------------------------------------------------
; "verifyOpcode" Helper
; Jonathan
;
; 1st argument is a template string (e.g. "0100...111......" for LEA)
; 2nd argument is a data register to check against the template
;
; Verifies that the opcode passed through \2 matches the pattern of \1
; If they do not match, branches to outputData
; ------------------------------------------------------------
verifyOpcode:  MACRO
        LEA     \1, A1      ; Input pattern string
        MOVE.W  \2, D0      ; input value
        MOVE.B  #15, D1     ; Counter tracking the bit position of D0
        
loop\@: 
        CMP.B   #$30, (A1)  ; Check if the template wants a 0
        BEQ     checkFor0\@
        CMP.B   #$31, (A1)  ; Check if the template wants a 1
        BEQ     checkFor1\@
        BRA     next\@      ; Template has a wildcard, go to next iteration
        
checkFor0\@: 
        BTST    D1, D0      ; Check if contains 0
        BNE     outputData  ; Missing a 0 -> Not a valid opcode
        BRA     next\@

checkFor1\@:
        BTST    D1, D0      ; Check if contains 1
        BEQ     outputData  ; Missing a 1 -> Not a valid opcode

next\@: 
        CMP.B   #0, D1      ; Compare bit counter to 0
        BEQ     complete\@  ; Branch to complete if bit counter reached 0
        SUB.B   #1, D1      ; Continuing loop -> Decrement bit counter
        MOVE.B  (A1)+, D3   ; Move A1 to the next pointer (D3 irrelevant)
        BRA     loop\@      ; Begin loop again

complete\@:  ; Opcode has been verified
        ENDM
        
; ------------------------------------------------------------
; "printSize" Helper
; Gary
;
; 1st argument is a data argument to check against three possible sizes
;
; Uses no TRAP #15 without CR,LF (no new line) to add on size to opcode.
; This is done by bit (13 and 12) checking /1 and appending the size to already 
; printed opcode.  This is only called by opcodes that need size (only MOVE).
; D4 has value added representing the amount of subsequent words to be scanned.
; NOTE: POSSIBLY NEED TO INSERT SOME ERROR CHECKING?
; NOTE: MODULARIZE SO OPMODE CHECKING IS CLEANED UP
; ------------------------------------------------------------
printSize:  MACRO
        MOVE.W  \1, D0      ; input value      
checkForB\@: 
        BTST    #13, D0      ; Check if contains 0
        BNE     checkForW\@  ; If not go to word size
        LEA     oBSize, A1     
        MOVE.B  #14,D0          
        TRAP    #15
        BRA     complete\@      
checkForW\@: 
        BTST    #12, D0      ; Check if contains 0
        BEQ     checkForL\@
        LEA     oWSize, A1     
        MOVE.B  #14,D0          
        TRAP    #15
        BRA     complete\@  
checkForL\@:
        LEA     oLSize, A1     
        MOVE.B  #14,D0          
        TRAP    #15
complete\@:  ; Size has been printed
        ENDM
        
; ------------------------------------------------------------
; "printOpMode" Helper
; Gary
;
; 1st argument is a data argument to check against six possible modes
;
; Uses no TRAP #15 without CR,LF (no new line) to add on opMode to opcode.
; This is done by bit (6 to 8) checking /1 and appending the size to already 
; printed opcode.  This is only called by opcodes that need opMode.
; D4 has value added representing the amount of subsequent words to be scanned.
; NOTE: FIX COMMENT BLOCKS
; NOTE: POSSIBLY NEED TO INSERT SOME ERROR CHECKING?
; ------------------------------------------------------------
printOpMode:  MACRO
        MOVE.W  \1, D0      ; input value
        MOVE.B  #8, D1     ; Counter tracking the bit position of D0      
        
checkForDestDn\@: 
        BTST    D1, D0      ; Check if contains 0
        BNE     checkForSrcDn\@
        JSR     next\@
        BTST    D1, D0      ; Check if contains 0
        BEQ     DestDnW\@
DestDnL\@:        
        LEA     oLSize, A1     
        MOVE.B  #14,D0          
        TRAP    #15
        BRA     complete\@ 
DestDnW\@: 
        JSR     next\@
        BTST    D1, D0      ; Check if contains 0
        BEQ     DestDnB\@
        LEA     oWSize, A1     
        MOVE.B  #14,D0          
        TRAP    #15
        BRA     complete\@ 
DestDnB\@: 
        LEA     oBSize, A1     
        MOVE.B  #14,D0          
        TRAP    #15
        BRA     complete\@ 
checkForSrcDn\@: 
        JSR     next\@
        BTST    D1, D0      ; Check if contains 0
        BEQ     SrcDnW\@
SrcDnL\@:        
        LEA     oLSize, A1     
        MOVE.B  #14,D0          
        TRAP    #15
        BRA     complete\@ 
SrcDnW\@:
        JSR     next\@
        BTST    D1, D0      ; Check if contains 0
        BEQ     SrcDnB\@
        LEA     oWSize, A1     
        MOVE.B  #14,D0          
        TRAP    #15
        BRA     complete\@ 
SrcDnB\@: 
        LEA     oBSize, A1     
        MOVE.B  #14,D0          
        TRAP    #15
        BRA     complete\@ 

next\@:
        SUB.B   #1, D1      ; Continuing loop -> Decrement bit counter
        RTS                 ; HONESTLY KIND OF NOT NEEDED CAN BE TOSSED INTO BODY
complete\@:  ; Opcode has been verified
        ENDM
; ------------------------------------------------------------
; "decodeAdrMode" Helper
; Gary
; 3 to 8
; ------------------------------------------------------------
decodeAdrMode:  MACRO
        MOVE.B  #11, D1     ; Counter tracking the bit position of D0
        

next\@:
        SUB.B   #2, D1      ; Continuing loop -> Decrement bit counter
        RTS      

complete\@:  ; Opcode has been verified
        ENDM


; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; "main" routine
; Dylan, Gary
; 
; TODO: DESCRIPTION OF MAIN ROUTINE FUNCTIONALITY
; ========================================================================
        ORG     $1000


main:   LEA     $6000, A2      ; Testing identifyOpcode
        MOVE.W  #$D353, (A2)
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
        BEQ     decodeDIVU  ; DIVU follows 1000+
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
        BRA     decodeMULS  ; All 3 positions (8, 9, 10) were set

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
        verifyOpcode    pNOP, (A2)
        LEA     oNOP, A1     ; Loads byteVAR
        MOVE.B  #14,D0          
        TRAP    #15
        RTS                 ; Return from decodeNOP subroutine


; ------------------------------------------------------------
; 2. "decodeMOVE" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeMOVE:
        verifyOpcode    pMOVE, (A2)
        LEA     oMOVE, A1     
        MOVE.B  #14,D0          
        TRAP    #15
        printSize       (A2)
        RTS                 ; Return from decodeMOVE subroutine


; ------------------------------------------------------------
; 3. "decodeMOVEM" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeMOVEM:
        verifyOpcode    pMOVEM, (A2)
        ; put code here
        RTS                 ; Return from decodeMOVEM subroutine


; ------------------------------------------------------------
; 4. "decodeADD" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeADD:
        ;verifyOpcode    pADD, (A2)
        LEA     oADD, A1     
        MOVE.B  #14,D0          
        TRAP    #15
        printOpMode     (A2)
        RTS                 ; Return from decodeADD subroutine


; ------------------------------------------------------------
; 5. "decodeSUB" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeSUB:
        verifyOpcode    pSUB, (A2)
        ; put code here
        RTS                 ; Return from decodeSUB subroutine


; ------------------------------------------------------------
; 6. "decodeMULS" subroutine
; AUTHOR
;
; TODO: DESCRIPTION MULS
; ------------------------------------------------------------
decodeMULS:
        verifyOpcode    pMULS, (A2)
        ; put code here
        RTS                 ; Return from decodeMULS subroutine
        
        
; ------------------------------------------------------------
; 7. "decodeDIVU" subroutine
; AUTHOR
;
; TODO: DESCRIPTION DIVU
; ------------------------------------------------------------
decodeDIVU:
        verifyOpcode    pDIVU, (A2)
        ; put code here
        RTS                 ; Return from decodeDIVU subroutine


; ------------------------------------------------------------
; 8. "decodeLEA" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeLEA:
        verifyOpcode    pLEA, (A2)
        ; put code here
        RTS                 ; Return from decodeLEA subroutine


; ------------------------------------------------------------
; 9. "decodeAND" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeAND:
        verifyOpcode    pAND, (A2)
        ; put code here
        RTS                 ; Return from decodeAND subroutine


; ------------------------------------------------------------
; 10. "decodeNOT" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeNOT:
        verifyOpcode    pNOT, (A2)
        ; put code here
        RTS                 ; Return from decodeNOT subroutine


; ------------------------------------------------------------
; 11a. "decodeLSx_M" subroutine
; AUTHOR
;
; TODO: DESCRIPTION - LSL or LSR Memory Shift
; ------------------------------------------------------------
decodeLSx_M:
        verifyOpcode    pLSx_M, (A2)
        ; put code here
        RTS                 ; Return from decodeLSx_M subroutine


; ------------------------------------------------------------
; 11b. "decodeLSx_R" subroutine
; AUTHOR
;
; TODO: DESCRIPTION - LSL or LSR Register Shift
; ------------------------------------------------------------
decodeLSx_R:
        verifyOpcode    pLSx_R, (A2)
        ; put code here
        RTS                 ; Return from ddecodeLSx_R subroutine


; ------------------------------------------------------------
; 12a. "decodeASx_M" subroutine
; AUTHOR
;
; TODO: DESCRIPTION - ASL or ASR Memory Shift
; ------------------------------------------------------------
decodeASx_M:
        verifyOpcode    pASx_M, (A2)
        ; put code here
        RTS                 ; Return from decodeASx_M subroutine


; ------------------------------------------------------------
; 12b. "decodeASx_R" subroutine
; AUTHOR
;
; TODO: DESCRIPTION - ASL or ASR Register Shift
; ------------------------------------------------------------
decodeASx_R:
        verifyOpcode    pASx_R, (A2)
        ; put code here
        RTS                 ; Return from decodeASx_R subroutine


; ------------------------------------------------------------
; 13a. "decodeBEQ" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeBEQ:
        verifyOpcode    pBEQ, (A2)
        ; put code here
        RTS                 ; Return from decodeBEQ subroutine


; ------------------------------------------------------------
; 13b. "decodeBGE" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeBGE:
        verifyOpcode    pBGE, (A2)
        ; put code here
        RTS                 ; Return from decodeBGE subroutine


; ------------------------------------------------------------
; 13c. "decodeBLT" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeBLT:
        verifyOpcode    pBLT, (A2)
        ; put code here
        RTS                 ; Return from decodeBLT subroutine


; ------------------------------------------------------------
; 14. "decodeJSR" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeJSR:
        verifyOpcode    pJSR, (A2)
        ; put code here
        RTS                 ; Return from decodeJSR subroutine


; ------------------------------------------------------------
; 15. "decodeRTS" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeRTS:
        verifyOpcode    pRTS, (A2)
        LEA     oRTS, A1     
        MOVE.B  #14,D0          
        TRAP    #15
        RTS                 ; Return from decodeRTS subroutine


; ------------------------------------------------------------
; 16. "decodeBRA" subroutine
; AUTHOR
;
; TODO: DESCRIPTION
; ------------------------------------------------------------
decodeBRA:
        verifyOpcode    pBRA, (A2)
        ; put code here
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
; outputData
; Jonathan
;
; When an invalid opcode is found, outputs it as data
; ------------------------------------------------------------
outputData:
        MOVEA    A2, A1     
        MOVE.B  #$d, (A2) 
        MOVE.B  #14,D0          
        TRAP    #15
        RTS                 ; Return from decodeBRA subroutine





; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            ; End of Code
        END    main         ; last line of source









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
