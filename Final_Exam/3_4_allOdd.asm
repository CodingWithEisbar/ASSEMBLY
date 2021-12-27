;CHUONG TRINH KIEM TRA MA KY CUA 1 MANG 10 PHAN TU
;XEM KY TU NAO CO MA LA SO LE
;=======================================================
;NGUOI VIET: NGUYEN TRUNG NGUYEN
;MSSV: 20127404
;=======================================================

.MODEL small
.STACK 100h
.DATA
countPrint db ? 
countEven db ?
user_input db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; Luu tru du lieu nhap vao cua nguoi dung 
             
current_pos dw 0 ;Vi tri dang xet hien tai 
have_char db 0 ; Co danh dau vi tri co ma thoa dieu kien

input_notify db 'Enter 10 characters: $'
notify db 'Characters that have odd ASCII code: $' 
notFound db '<none>$'


.CODE

main proc  
    ;Goi so nhap vao tu ban phim la num   
    xor si, si
    mov ax, @data ;khoi tao DS de co the su dung bien
    mov ds, ax 
    mov ax, ax  
    lea dx, input_notify
    mov ah, 09h ;In thong bao nhap gia tri ra man hinh
	int 21h 
    
    get_user_input: 
    ;Nhap chu cai tu ban phim
    mov ah, 1
    int 21h
    mov user_input[si], al ;Luu cac gia tri nguoi dung nhap vao mang
    inc si
     
    
    cmp si, 10 ;so sanh ma ki tu nhap vao voi ESC
    je print_notify ;Neu co thi thoat chuong trinh 
    jne get_user_input ;Neu chua du 10 ky tu thi tien hanh nhap tiep  
    
    print_notify:
      mov dl, 0Ah  ;Xuong dong
      mov ah, 02h 
      int 21h  
      mov dl,0Dh  ;Tro ve dau dong
      int 21h
    		
      lea dx, notify 
      mov ah, 09h ;In phan thong bao ket qua 
      int 21h 
      
    setup_before_check: 
    mov countEven, 0
    mov countPrint, 0
    xor si, si
    mov si, current_pos
    xor ax, ax
    mov al, user_input[si]  
      
    getASCIICode:
    mov ah, 0d
    xor cx, cx
    mov cl, 10d
    div cl  
    mov cl, ah
    
    push cx	;Nap gia tri thanh ghi cx=ASCII num vao stack  
    add countPrint, 1
                      
    cmp al,0
    jne getASCIICode
    
     
    checkOdd:   
    xor ax,ax
    pop ax
    mov dx, ax 
    mov bx, ax
    add dx, 30h 
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
    mov cl, 1
    mov have_char, cl
    xor ax,ax 
    xor si, si 
    mov si, current_pos
    mov dl, user_input[si] 
    mov ah,2
    int 21h
    mov ah,2
    mov dl,20h ;Chen khoang trang giua cac ket qua
    int 21h
    jmp next_digit
    
    
    notAllOddNumber:  
    jmp next_digit
    
    next_digit:
     xor si, si
     mov si, current_pos
     inc si
    
     cmp si, 10 ; if (i==10) then end program
     je none_char
    
     mov current_pos, si
     jmp setup_before_check ;go to next character to check
    
    
    none_char:
    mov al, have_char
    cmp al, 1
    je end_program
    
    xor dx, dx
    lea dx, notFound
    mov ah, 09h
    int 21h
   
    end_program:
     mov ah, 4Ch ;Tra su kiem soat lai cho he dieu hanh
     int 21h 
    
main endp
end main