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
        SUB.W   D4, D5              ; Dn
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
    	     
    
	SIMHALT				  ; Halt simulator
CR:		EQU		$0D		  ; ASCII code for Carriage Return
LF:		EQU		$0A		  ; ASCII code for Line Feed
     



    END    MAIN        ; Last line of source
    

