;MSSV 20127213 - Tên: Lê Đặng Minh Khôi
;CT kiểm tra mã số của kí tự có là số nguyên tố hay không
;hướng dẫn in chuỗi https://www.geeksforgeeks.org/8086-program-to-print-a-string/
;hướng dẫn cấp pháp mảng: https://jbwyatt.com/253/emu/asm_tutorial_03.html
;cách in các giá trị ascii theo số thập phân: https://coderedirect.com/questions/117563/assembly-printing-ascii-number
;bảng mã các dos interrupts: http://spike.scu.edu.au/~barry/interrupts.html
;chỉ dẫn div, mul:https://www.csie.ntu.edu.tw/~acpang/course/asm_2004/slides/chapt_07_PartIISolve.pdf
.model small
.stack 100h
.data 
	;ouput string
	string1 db ' => $'
	string2 db 'is a prime number$'
	string3 db 'is not a prime number$'
.code
main proc
start:
	mov ah, 1 ;get user input
	int 21h
    mov cl, al ;temporaly stored user input
	; print "=>"
	xor ax, ax
	xor dx, dx
	mov ax, @data ;alocate data section with ax
	mov ds, ax ;mov to data section registry
	lea dx, string1	;add string1 to dx
	mov ah, 09h	;print string at reg dx
	int 21h
	;get user input back
	xor ax, ax ;clear ax register
	mov al, cl ;mov user input to al regisiter
	;setting up for next algorithm
	xor cl, cl 
	xor dl, dl
	xor bx, bx
	mov bl, al  ;initualizing bl = al
    dec bx ;decrease bl
	
prime_check:
    xor dx, dx  ;clean dx
    mov cl, al  ;temporaly stored al
    div bl  ;divide bx, remainder at ah reg
    cmp ah, 0000  ;if remainder is 0 then jump to nprime
    jz nprime
    xor ax, ax ;clear ax register
    mov al, cl ;mov original data back to al
    dec bl ;decrease bl
    cmp bl, 1 ;check bl == 0, if yes jump to yprime
    jz yprime
    xor cx, cx  ;clean cx
    jmp prime_check ;continue the algorithm

nprime: ;print result
    xor dx, dx
	xor ax, ax
	mov ax, @data ;alocate data section with ax
	mov ds, ax ;mov to data section register
	lea dx, string3 ;add string1 to dx
    mov ah, 09h ;print string at reg dx
    int 21h ;dos interrupts
    jmp extt

yprime: ;print result
    xor dx, dx
	xor ax, ax
	mov ax, @data ;alocate data section with ax
	mov ds, ax ;mov to data section register
	lea dx, string2 ;add string1 to dx
    mov ah, 09h ;print string at register dx
    int 21h ;dos interrupts
    jmp extt

extt:
	mov ah, 4Ch ;close .exe
	int 21h ;dos interrupts
main endp
end main
