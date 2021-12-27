; CHUONG TRINH NHAP VAO 10 KY TU TU BAN PHIM 
; VA XET XEM KY TU NAO CO MA LA SO CHINH PHUONG        
; =========================================================
; NGUOI VIET: NGUYEN TRUNG NGUYEN
; MSSV: 20127404                                          
; =========================================================

.MODEL small
.STACK 1000h
.DATA     
    i db ?  
    countPrint db 0 
    
    current_pos dw 0 ;Vi tri dang xet hien tai 
    have_char db 0 ; Co danh dau vi tri co ma thoa dieu kien
    
    user_input db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; Store user input 
    
    input_notify db 'Enter 10 characters: $'
    notify db 'all character that have perfect squares ASCII code: $' 
    notFound db '<none>$'
    
.CODE
main proc 
    ;Goi so nhap vao tu ban phim la num   
    xor si, si
    mov ax, @data ;khoi tao DS de co the su dung bien
    mov ds, ax 
    xor ax, ax
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
    		
      lea dx, notify ;In phan thong bao ket qua 
      mov ah, 09h 
      int 21h 
      
    setup_before_check: 
    mov countPrint, 0 
    mov i, 2d
    xor si, si
    mov si, current_pos
    xor ax, ax
    mov al, user_input[si]
    xor bx, bx
    mov bl, user_input[si]
      
 
    checkPerfectSquare:
    xor ax, ax
    mov al, i 
    mul i 
    inc i  
    cmp ax, bx ;Xet dieu kien dung, neu nho hon bang thi la so chinh phuong, khong thi thoi
    je isPerfectSquare ;Neu la so chinh phuong
    jg notPerfectSquare ;Neu i lon hon thi ket luan khong phai la so chinh phuong 
    jne checkPerfectSquare ;Neu i nho hon thi lap lai vong lap 
    
    
    notPerfectSquare:
    jmp next_digit
    
     
    isPerfectSquare: 
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
    