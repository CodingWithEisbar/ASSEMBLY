;CT chuyen doi ki tu nhap vao thanh ma ASCII tuong ung
;Nguoi viet: Nguyen Trung Nguyen
;MSSV: 20127404
;--------------------------------------------------------------------

.MODEL small
.STACK 100h
.DATA
countPrint db ? 
result db '=>$'
.CODE
main proc
	whileLoop:
        mov ah,1
        int 21h   
         
        mov countPrint,0
        
        cmp al, 27
        je ketThucThuatToan

        chia:
	mov ah,0
	mov bl,10
	div bl
            
            mov bl,ah
            push bx	;Nap gia tri thanh ghi bx vao stack
            inc countPrint
            
            cmp al,0
            jne chia
        
        inRaManHinh:
            pop dx
            add dx,30h
            dec countPrint  
            mov dh, result
            mov ah, 2
            int 21h

            cmp countPrint,0
            jne inRaManHinh  
            
            mov dl,0Ah ;Thao tac xuong dong
            int 21h 
            mov dl,0Dh
            int 21h
            

    jmp whileLoop
    ketThucThuatToan:
    mov ah,4ch  ;Tra su kiem soat ve cho he dieu hanh
    int 21h
	
main endp
END main
