;CHUONG TRINH DEMO NHAP XUAT TRUC TIEP
;NGUOI VIET: NGUYEN TRUNG NGUYEN
;MSSV: 20127404   

;Nhap mot ky tu roi in ra man hinh, nhan ESC de thoat man hinh      

.MODEL small
.STACK 100h   
.DATA   
conclusion db '=>$'

.CODE
main proc
    mov ax, @data
    mov ds, ax  
    
    enterValue: 
    mov dl, 0Ah  
    mov ah, 02h 
    int 21h  
    mov dl,0Dh 
    int 21h
    
    mov ah, 01h
    int 21h
    
    ;Check ESC
    cmp al, 27    
    je endProgram  
      
    mov bl, al
    printToScreen:
    mov dl, 0Ah  
    mov ah, 02h 
    int 21h  
    mov dl,0Dh 
    int 21h
    
    xor dx, dx
      
    lea dx, conclusion
    mov ah, 09h
    int 21h
    
    xor dx, dx
    mov dl, bl 
    mov ah, 02h
    int 21h
   
  
    jmp enterValue      
    
    
    endProgram:
    mov ah, 4ch
    int 21h
main endp
END main
    
        

