;XAC DINH MA KY TU CO CHUA TOAN CHU SO LE KHONG
;NGUOI VIET: NGUYEN TRUNG NGUYEN
;MSSV: 20127404
;------------------------------------------------------------------

.MODEL small
.STACK 100h
.DATA
countPrint db ? 
countEven db ?
colon db ': $'   
allOdd db '=> all odd number $'
notAllOdd db '=> not all odd number $'
.CODE

main proc  
    ;Goi so nhap vao tu ban phim la num
    mov ax, @data ;khoi tao DS de co the su dung bien
    mov ds, ax
    for: 
    mov countEven, 0
    mov countPrint, 0
    ;Nhap chu cai tu ban phim
    mov ah, 1
    int 21h 
    
    cmp al, 27 ;so sanh ma ki tu nhap vao voi ESC
    je terminateProgram ;Neu co thi thoat chuong trinh   
    
    
    getASCIICode:
    mov ah, 0
    mov cl, 10
    div cl  
    mov cl, ah
    
    push cx	;Nap gia tri thanh ghi cx=ASCII num vao stack  
    add countPrint, 1
                      
    cmp al,0
    jne getASCIICode
    
    
    ;In dau 2 cham
      xor ax,ax 
      lea dx, colon
      mov ah, 09h   
      int 21h 
      
                   
    checkOdd:   
    xor ax,ax
    pop ax
    mov dx, ax 
    mov bx, ax
    add dx, 30h 
    mov ah,2
    int 21h
    mov ax, bx
    xor bx, bx
    mov bl, 2
    div bl
    
    sub countPrint, 1 
    ; if((num%10)%2!=0)  
    cmp ah, 0
    je countEvenNumber
    jne checkCountPrint

    checkCountPrint:
    cmp countPrint, 0
    jne checkOdd
    je checkEvenNumber
    
    countEvenNumber:
    add countEven, 1
    cmp countPrint, 0
    jne checkOdd
    je checkEvenNumber 
    
    
    checkEvenNumber:
    cmp countEven,0
    jne notAllOddNumber
    je allOddNumber
    
    
    
    allOddNumber:
    xor ax,ax
    lea dx, allOdd
    mov ah, 09h
    int 21h   
    mov ah,2
    mov dl,0Ah ;Thao tac xuong dong
    int 21h
    mov dl,0Dh
    int 21h
       
    jmp for
    
    notAllOddNumber:
    xor ax,ax
    lea dx, notAllOdd
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