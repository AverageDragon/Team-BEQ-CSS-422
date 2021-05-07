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
        
        ADD.B   $21, D3             ; Dn
        ADD.B   D3, (A3)            ; (An)
        ADD.B   D3, (A3)+           ; (An)+            
        ADD.B   D3, -(A3)           ; -(An)
        ADD.B   D3, $D649           ; (xxx).W
        ADD.B   D3, $B4986257       ; (xxx).L
	
        ADD.W   $94, D4             ; Dn
        ADD.W   #9786, A4           ; An
        ADD.W   D4, (A4)            ; Dn -> (An)  
        ADD.W   D4, (A4)+           ; Dn -> (An)+    
        ADD.W   D4, -(A4)           ; Dn -> -(An)
        ADD.W   (A4), A4            ; (An) -> An
        ADD.W   (A4)+, A4           ; (An)+ -> An
        ADD.W   -(A4), A4           ; -(An) -> An
        ADD.W   D4, A4              ; Dn -> An
        ADD.W   D4, $1198           ; (xxx).W
        ADD.W   D4, $60054982       ; (xxx).L
    	
        ADD.L   #165401, A5         ; An
        ADD.L   $48, D5             ; Dn
        ADD.L   D5, (A5)            ; Dn -> (An)
        ADD.L   D5, (A5)+           ; Dn -> (An)+        
        ADD.L   D5, -(A5)           ; Dn -> -(An)
        ADD.L   (A5), A5            ; (An) -> An
        ADD.L   (A5)+, A5           ; (An)+ -> An
        ADD.L   -(A5), A6           ; -(An) -> An
        ADD.L   D5, A5              ; Dn -> An
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
        
        SUB.B   $21, D3             ; Dn
        SUB.B   D3, (A3)            ; (An)
        SUB.B   D3, (A3)+           ; (An)+            
        SUB.B   D3, -(A3)           ; -(An)
        SUB.B   D3, $D649           ; (xxx).W
        SUB.B   D3, $B4986257       ; (xxx).L
	
        SUB.W   $94, D4             ; Dn
        SUB.W   #9786, A4           ; An
        SUB.W   D4, (A4)            ; Dn -> (An)  
        SUB.W   D4, (A4)+           ; Dn -> (An)+    
        SUB.W   D4, -(A4)           ; Dn -> -(An)
        SUB.W   (A4), A4            ; (An) -> An
        SUB.W   (A4)+, A4           ; (An)+ -> An
        SUB.W   -(A4), A4           ; -(An) -> An
        SUB.W   D4, A4              ; Dn -> An
        SUB.W   D4, $1198           ; (xxx).W
        SUB.W   D4, $60054982       ; (xxx).L
    	
        SUB.L   #165401, A5         ; An
        SUB.L   $48, D5             ; Dn
        SUB.L   D5, (A5)            ; Dn -> (An)
        SUB.L   D5, (A5)+           ; Dn -> (An)+        
        SUB.L   D5, -(A5)           ; Dn -> -(An)
        SUB.L   (A5), A5            ; (An) -> An
        SUB.L   (A5)+, A5           ; (An)+ -> An
        SUB.L   -(A5), A6           ; -(An) -> An
        SUB.L   D5, A5              ; Dn -> An
        SUB.L   D5, $1119           ; (xxx).W
        SUB.L   D5, $1971165        ; (xxx).L

MOVE:   MOVE.B    #$08, D0          ; Dn
        MOVE.B    #$65, (A0)        ; (An)
        MOVE.B    #$78, (A0)+       ; (An)+
        MOVE.B    #$69, -(A0)       ; -(An)
        MOVE.B    #$12, $4321       ; (xxx).W
        MOVE.B    #$16, $87654321   ; (xxx).L         
        
    
	SIMHALT				  ; Halt simulator
CR:		EQU		$0D		  ; ASCII code for Carriage Return
LF:		EQU		$0A		  ; ASCII code for Line Feed
     



    END    MAIN        ; Last line of source
    

*~Font name~Courier New~
*~Font size~16~
*~Tab type~1~
*~Tab size~4~
