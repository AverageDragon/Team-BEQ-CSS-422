*-----------------------------------------------------------
* Title      :Testx68
* Written by :Omar Nevarez
* Date       :
* Description:Test for Disassembler
*-----------------------------------------------------------
    ORG    $3000
MAIN:                  
NOP:    NOP
RTS:    RTS

ADD:    ADD.B    #$08, D0          ; Dn
        ADD.B    #$65, (A0)        ; (An)
        ADD.B    #$78, (A0)+       ; (An)+
        ADD.B    #$69, -(A0)       ; -(An)
        ADD.B    #$12, $4321       ; (xxx).W
        ADD.B    #$16, $87654321   ; (xxx).L
        
        ADD.W    #$1208, D1         ; Dn
        ADD.W    #$3565, (A1)       ; (An)
        ADD.W    #$1278, (A1)+      ; (An)+
        ADD.W    #$7569, -(A1)      ; -(An)
        ADD.W    #$1212, $4321      ; (xxx).W
        ADD.W    #$8416, $87654321  ; (xxx).L
        
        ADD.L    #$12408, D2        ; Dn
        ADD.L    #$97565, (A2)      ; (An)
        ADD.L    #$67578, (A2)+     ; (An)+
        ADD.L    #$35669, -(A2)     ; -(An)
        ADD.L    #$19952, $4321     ; (xxx).W
        ADD.L    #$16246, $87654321 ; (xxx).L
        
        ADD.B   D2, D3              ; Dn
        ADD.B   #15, D3             ; #<data>
        ADD.B   (A3), D3            ; (An)
        ADD.B   (A3)+, D3           ; (An)+            
        ADD.B   -(A3), D3           ; -(An)
        ADD.B   $D649, D3           ; (xxx).W
        ADD.B   $B4986257, D3       ; (xxx).L
	
        ADD.W   D3, D4              ; Dn
        ADD.W   A4, D4              ; An
        ADD.W   #9786, A4           ; #<data>
        ADD.W   (A4), D4            ; (An)  
        ADD.W   (A4)+, D4           ; (An)+    
        ADD.W   -(A4), D4           ; -(An)
        ADD.W   $1198, D4           ; (xxx).W
        ADD.W   $60054982, D4       ; (xxx).L
    	
        ADD.L   #165401, D5         ; #<data>
        ADD.L   D4, D5              ; Dn   
        ADD.L   A4, D5              ; An     
        ADD.L   (A5), D5            ; (An)
        ADD.L   (A5)+, D5           ; (An)+
        ADD.L   -(A5), D6           ; -(An)
        ADD.L   D5, $1119           ; (xxx).W
        ADD.L   D5, $1971165        ; (xxx).L
        
SUB:    SUB.B    #$08, D0          ; Dn
        SUB.B    #$65, (A0)        ; (An)
        SUB.B    #$78, (A0)+       ; (An)+
        SUB.B    #$69, -(A0)       ; -(An)
        SUB.B    #$12, $4321       ; (xxx).W
        SUB.B    #$16, $87654321   ; (xxx).L
        
        SUB.W    #$1208, D1         ; Dn
        SUB.W    #$3565, (A1)       ; (An)
        SUB.W    #$1278, (A1)+      ; (An)+
        SUB.W    #$7569, -(A1)      ; -(An)
        SUB.W    #$1212, $4321      ; (xxx).W
        SUB.W    #$8416, $87654321  ; (xxx).L
        
        SUB.L    #$12408, D2        ; Dn
        SUB.L    #$97565, (A2)      ; (An)
        SUB.L    #$67578, (A2)+     ; (An)+
        SUB.L    #$35669, -(A2)     ; -(An)
        SUB.L    #$19952, $4321     ; (xxx).W
        SUB.L    #$16246, $87654321 ; (xxx).L
        
        SUB.B   D2, D3              ; Dn
        SUB.B   D3, (A3)            ; (An)
        SUB.B   D3, (A3)+           ; (An)+            
        SUB.B   D3, -(A3)           ; -(An)
        SUB.B   D3, $D649           ; (xxx).W
        SUB.B   D3, $B4986257       ; (xxx).L
	
        SUB.W   #9786, D4           ; #<data>
        SUB.W   (A4), D4            ; (An)  
        SUB.W   (A4)+, D4           ; Dn -> (An)+    
        SUB.W   -(A4), D4           ; Dn -> -(An)
        SUB.W   D4, D5              ; D
        SUB.W   $1198, D4           ; (xxx).W
        SUB.W   $60054982, D4       ; (xxx).L
    	
        SUB.L   #165401, D5         ; #<data>
        SUB.L   D5, D4              ; Dn
        SUB.L   (A5)+, D5           ; (An)+        
        SUB.L   (A5), D5            ; (An)
        SUB.L   -(A5), D6           ; -(An)
        SUB.L   $1119, D5           ; (xxx).W
        SUB.L   $1971165, D5        ; (xxx).L

MOVE:   MOVE.B    #$08, D0          ; Dn
        MOVE.B    #$65, (A0)        ; (An)
        MOVE.B    #$78, (A0)+       ; (An)+
        MOVE.B    #$69, -(A0)       ; -(An)
        MOVE.B    #$12, $4321       ; (xxx).W
        MOVE.B    #$16, $87654321   ; (xxx).L 

        MOVE.W    #$1208, D1         ; Dn
        MOVE.W    #$3565, (A1)       ; (An)
        MOVE.W    #$1278, (A1)+      ; (An)+
        MOVE.W    #$7569, -(A1)      ; -(An)
        MOVE.W    #$1212, $4321      ; (xxx).W
        MOVE.W    #$8416, $87654321  ; (xxx).L
        
        MOVE.L    #$12408, D2        ; Dn
        MOVE.L    #$97565, (A2)      ; (An)
        MOVE.L    #$67578, (A2)+     ; (An)+
        MOVE.L    #$35669, -(A2)     ; -(An)
        MOVE.L    #$19952, $4321     ; (xxx).W
        MOVE.L    #$16246, $87654321 ; (xxx).L  

        MOVE.B   D2, D3              ; Dn
        MOVE.B   D3, (A3)            ; (An)
        MOVE.B   D3, (A3)+           ; (An)+            
        MOVE.B   D3, -(A3)           ; -(An)
        MOVE.B   D3, $D649           ; (xxx).W
        MOVE.B   D3, $B4986257       ; (xxx).L
	
        MOVE.W   #9786, D4           ; #<data>
        MOVE.W   (A4), D4            ; (An)  
        MOVE.W   (A4)+, D4           ; Dn -> (An)+    
        MOVE.W   -(A4), D4           ; Dn -> -(An)
        MOVE.W   D4, D5              ; Dn
        MOVE.W   $1198, D4           ; (xxx).W
        MOVE.W   $60054982, D4       ; (xxx).L
    	
        MOVE.L   #164955401, D5      ; #<data>
        MOVE.L   D5, D4              ; Dn
        MOVE.L   (A5)+, D5           ; (An)+        
        MOVE.L   (A5), D5            ; (An)
        MOVE.L   -(A5), D6           ; -(An)
        MOVE.L   $1119, D5           ; (xxx).W
        MOVE.L   $1971165, D5        ; (xxx).L
        
MULS:   MULS.W   #9786, D0          ; #<data>
        MULS.W   (A0), D0           ; (An)  
        MULS.W   (A0)+, D0          ; Dn -> (An)+    
        MULS.W   -(A0), D0          ; Dn -> -(An)
        MULS.W   D0, D0             ; Dn
        MULS.W   $1198, D0          ; (xxx).W
        MULS.W   $60054982, D0      ; (xxx).L
        
DIVU:   DIVU.W   #9786, D1          ; #<data>
        DIVU.W   (A1), D1           ; (An)  
        DIVU.W   (A1)+, D1          ; Dn -> (An)+    
        DIVU.W   -(A1), D1          ; Dn -> -(An)
        DIVU.W   D1, D2             ; Dn
        DIVU.W   $1198, D1          ; (xxx).W
        DIVU.W   $60054982, D1      ; (xxx).L
        
LEA:    LEA      TESTMSG, A2        ; An
        LEA      $06498216, A2      ; (xxx).L
        LEA      $1234, A2          ; (xxx).W
        LEA      (A3),A2            ; (An)
        
AND:    AND.B    #$C8, D0           ; Dn
        AND.B    #$35, (A0)         ; (An)
        AND.B    #$68, (A0)+        ; (An)+
        AND.B    #$59, -(A0)        ; -(An)
        AND.B    #$32, $4321        ; (xxx).W
        AND.B    #$46, $87654321    ; (xxx).L
        
        AND.W    #$1528, D1         ; Dn
        AND.W    #$3565, (A1)       ; (An)
        AND.W    #$1278, (A1)+      ; (An)+
        AND.W    #$7569, -(A1)      ; -(An)
        AND.W    #$1212, $4321      ; (xxx).W
        AND.W    #$8416, $87654321  ; (xxx).L
        
        AND.L    #$12408, D2        ; Dn
        AND.L    #$97565, (A2)      ; (An)
        AND.L    #$67578, (A2)+     ; (An)+
        AND.L    #$35669, -(A2)     ; -(An)
        AND.L    #$19952, $4321     ; (xxx).W
        AND.L    #$16246, $87654321 ; (xxx).L
        
        AND.B   D2, D3              ; Dn
        AND.B   D3, (A3)            ; (An)
        AND.B   D3, (A3)+           ; (An)+            
        AND.B   D3, -(A3)           ; -(An)
        AND.B   D3, $D649           ; (xxx).W
        AND.B   D3, $B1234257       ; (xxx).L
	
        AND.W   #9786, D4           ; #<data>
        AND.W   (A4), D4            ; (An)  
        AND.W   (A4)+, D4           ; Dn -> (An)+    
        AND.W   -(A4), D4           ; Dn -> -(An)
        AND.W   D4, D5              ; Dn
        AND.W   $1198, D4           ; (xxx).W
        AND.W   $65783982, D4       ; (xxx).L
    	
        AND.L   #165401, D6         ; #<data>
        AND.L   D6, D4              ; Dn
        AND.L   (A6)+, D6           ; (An)+        
        AND.L   (A6), D6            ; (An)
        AND.L   -(A6), D6           ; -(An)
        AND.L   $6819, D6           ; (xxx).W
        AND.L   $0451165, D6        ; (xxx).L

NOT:    NOT.B    D0                 ; Dn
        NOT.B   (A3)                ; (An)
        NOT.B   (A3)+               ; (An)+            
        NOT.B   -(A3)               ; -(An)
        NOT.B   $D649               ; (xxx).W
        NOT.B   $B4986257           ; (xxx).L
	
	NOT.W   D1                  ; Dn
        NOT.W   (A4)                ; (An)  
        NOT.W   (A4)+               ; Dn -> (An)+    
        NOT.W   -(A4)               ; Dn -> -(An)
        NOT.W   $1198               ; (xxx).W
        NOT.W   $60054982           ; (xxx).L
    	    
    	NOT.L    D2                 ; Dn
        NOT.L   (A5)+               ; (An)+        
        NOT.L   (A5)                ; (An)
        NOT.L   -(A5)               ; -(An)
        NOT.L   $1119               ; (xxx).W
        NOT.L   $1971165            ; (xxx).L
      
LSR:    LSR.B   #01, D2             ; Dn
        LSR.B   D2, D3              ; Dn
	
        LSR.W   #06, D1             ; Dn	
	LSR.W   D2, D3              ; Dn
        LSR.W   (A4)                ; (An)  
        LSR.W   (A4)+               ; Dn -> (An)+    
        LSR.W   -(A4)               ; Dn -> -(An)
        LSR.W   $1198               ; (xxx).W
        LSR.W   $65783982           ; (xxx).L
    
        LSR.L   #06, D1             ; Dn    	
        LSR.L   D6, D4              ; Dn
       
LSL:    LSL.B   #01, D2             ; Dn
        LSL.B   D2, D3              ; Dn
	
        LSL.W   #06, D1             ; Dn	
	LSL.W   D2, D3              ; Dn
        LSL.W   (A4)                ; (An)  
        LSL.W   (A4)+               ; Dn -> (An)+    
        LSL.W   -(A4)               ; Dn -> -(An)
        LSL.W   $1198               ; (xxx).W
        LSL.W   $65783982           ; (xxx).L
    
        LSL.L   #06, D1             ; Dn    	
        LSL.L   D6, D4              ; Dn
	
ASL:    ASL.B   #01, D2             ; Dn
        ASL.B   D2, D3              ; Dn
	
        ASL.W   #06, D1             ; Dn	
	ASL.W   D2, D3              ; Dn
        ASL.W   (A4)                ; (An)  
        ASL.W   (A4)+               ; Dn -> (An)+    
        ASL.W   -(A4)               ; Dn -> -(An)
        ASL.W   $1198               ; (xxx).W
        ASL.W   $65783982           ; (xxx).L
    
        ASL.L   #06, D1             ; Dn    	
        ASL.L   D6, D4              ; Dn
    	  
ASR:    ASL.B   #01, D2             ; Dn
        ASL.B   D2, D3              ; Dn
	
        ASR.W   #06, D2             ; Dn	
	ASR.W   D3, D4              ; Dn
        ASR.W   (A3)                ; (An)  
        ASR.W   (A3)+               ; Dn -> (An)+    
        ASR.W   -(A3)               ; Dn -> -(An)
        ASR.W   $1008               ; (xxx).W
        ASR.W   $55000982           ; (xxx).L
    
        ASR.L   #06, D3             ; Dn    	
        ASR.L   D4, D2              ; Dn
        
MOVEM:  MOVEM.W   D0-D4/A0-A4, (A5)      ; (An)
        MOVEM.W   D3-D6/A1-A3, -(A4)     ; (An)-
        MOVEM.W   D4-D5/A2-A6, $1234     ; (xxx).W
        MOVEM.W   D1-D4/A0-A2, $12345678 ; (xxx).L
        
        MOVEM.L   D0-D4/A0-A4, (A5)      ; (An)
        MOVEM.L   D3-D6/A1-A3, -(A4)     ; (An)-
        MOVEM.L   D4-D5/A2-A6, $1234     ; (xxx).W
        MOVEM.L   D1-D4/A0-A2, $12345678 ; (xxx).L
        
        MOVEM.W   (A5), D0-D4/A0-A4      ; (An)
        MOVEM.W   (A4)+, D3-D6/A1-A3     ; +(An)
        MOVEM.W   $1234, D4-D5/A2-A6     ; (xxx).W
        MOVEM.W   $12345678, D1-D4/A0-A2 ; (xxx).L
        
        MOVEM.L   (A5), D0-D4/A0-A4      ; (An)
        MOVEM.L   (A4)+, D3-D6/A1-A3     ; +(An)
        MOVEM.L   $1234, D4-D5/A2-A6     ; (xxx).W
        MOVEM.L   $12345678, D1-D4/A0-A2 ; (xxx).L
        
JMP1:   JMP     BRA1
BRA1:   BRA     CONT

CONT:   BLT     CONT2
CONT2:  BGT     CONT3
CONT3:  BEQ     CONT4
CONT4:  RTS     

    
	SIMHALT				  ; Halt simulator
TESTMSG: DC.B   'TEST MESSAGE',CR,LF,0
     
    END    MAIN        ; Last line of source
