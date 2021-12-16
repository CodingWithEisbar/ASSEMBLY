;CHUONG TRINH XAC DINH MA KI TU CO PHAI SO CHINH PHUONG
;NGUOI VIET: NGUYEN TRUNG NGUYEN
;MSSV: 20127404
;------------------------------------------------------------------

.MODEL small
.STACK 100h      
.DATA
asciiCode db ?
i db ?  
countPrint db 0
colon db ': $'
confirm db '=> is perfect square $'
denine db '=> not perfect square $'
.CODE
main proc
    mov ax, @data
    mov ds, ax  
    ;Goi gia tri nhap vao tu ban phim la num
    for:  
    ;Nhap gia tri num tu ban phim
    mov ah, 1
    mov i, 2
    int 21h
    
               
    
    cmp al, 27 ;so sanh ma ki tu nhap vao voi ESC
    je terminateProgram ;Neu co thi thoat chuong trinh     
    
   
                                
     mov bl,al
     mov ah, 0 
     
     
      getASCII:
      mov ah, 0 
      mov cl,10
      div cl
            
      mov cl,ah
      push cx	;Nap gia tri thanh ghi cx=ASCII num vao stack
      add countPrint, 1 ;countPrint++
                      
      cmp al,0
      jne getASCII
      
     
      ;In dau 2 cham
      xor ax,ax 
      lea dx, colon
      mov ah, 09h   
      int 21h 
      
      printToScreen:
      ;In ma Ascii cua num   
      mov dx, 0
      pop dx
      add dx,30h
      mov ah,2
      int 21h
      sub countPrint, 1 ;countPrint--   
      
      cmp countPrint, 0h
      jne printToScreen  
     
     
      
      
    checkPerfectSquare:
    mov al, i 
    mul i 
    inc i  
    cmp ax, bx ;Xet dieu kien dung, neu nho hon bang thi la so chinh phuong, khong thi thoi
    je isPerfectSquare ;Neu la so chinh phuong
    jg notPerfectSquare ;Neu i lon hon thi ket luan khong phai la so chinh phuong 
    jne checkPerfectSquare ;Neu i nho hon thi lap lai vong lap  
    
    
       notPerfectSquare:
       xor ax,ax
       lea dx, denine
       mov ah, 09h   
       int 21h
       
                mov ah,2
                mov dl,0Ah ;Thao tac xuong dong
                int 21h
                mov dl,0Dh
                int 21h
               
       jmp for
    
     
    
       isPerfectSquare: 
       xor ax,ax
       lea dx, confirm
       mov ah, 09h
       int 21h   
                mov ah,2
                mov dl,0Ah ;Thao tac xuong dong
                int 21h
                mov dl,0Dh
                int 21h
       
        jmp for
   
  
      
   terminateProgram:
   mov ah, 4Ch ;Tra su kiem soat lai cho he dieu hanh
   int 21h 
    
main endp
end main
