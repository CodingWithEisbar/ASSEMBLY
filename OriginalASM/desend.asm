;MSSV 20127213 - Tên: Lê Đặng Minh Khôi
;CT kiểm tra mã số của kí tự có giảm dần hay không
;hướng dẫn in chuỗi https://www.geeksforgeeks.org/8086-program-to-print-a-string/
;hướng dẫn cấp pháp mảng: https://jbwyatt.com/253/emu/asm_tutorial_03.html
;cách in các giá trị ascii theo số thập phân: https://coderedirect.com/questions/117563/assembly-printing-ascii-number
;bảng mã các dos interrupts: http://spike.scu.edu.au/~barry/interrupts.html
;chỉ dẫn div, mul:https://www.csie.ntu.edu.tw/~acpang/course/asm_2004/slides/chapt_07_PartIISolve.pdf
.model small
.stack 100H
.data
    digits db 0, 0, 0, 0, 0 ;digit handler
    str_size dw ? ;total digit
    last db 0 ;nearest digit
	;output strings
	string1 db ' => $'
	string2 db 'has desending digits$'
	string3 db 'has random order or assending digits$'
	string4 db '(ascii value: $' 
	string5 db 'd)$'
.code
main proc
user_input:
    mov ah, 1 ;input
    int 21h ;dos interupt
    mov cl,al ;temporaly stored user input
	; print "=>"
	xor ax, ax
	mov ax, @data ;alocate data section with ax
	mov ds, ax ;mov to data section regiser
	lea dx, string1	;add string1 to dx
	mov ah, 09h	;;print string at reg dx
	int 21h
	;setting up for next algorithm
	xor dx, dx	;free dx reg
    xor ax, ax ; clear ax register
	mov al, cl ; get user input back for operationx
	xor cx, cx
	xor bx, bx ; clear bx register
	mov bx, 10 ; bx register will have value 10
	xor si, si ;index using si register, si have value 0

get_ascii_digit: ; get ascii digit and stored to "digits" memory
	xor dx, dx ; clear dx
	div bx	; divide ax with bx
	add dx, 48d	; add 48 character
	and dx, 0ffh ; clear dh regiseter
	mov digits[si], dl ; add too array
	inc si ; increase index
	cmp AX, 0 ; if ax == 0 then jump to setup
	jz setup 
	jmp get_ascii_digit	; else continue the algorithm


setup: ;setting up register for the next algorithm
    mov str_size, si ;setup number total digits
    xor si, si
    xor ax, ax
	;setting up for nearest digit
    mov dl, digits[si] 
    mov last, dl 
    xor dl, dl

desending_check: ;checking if ascii code is in desending order 
    mov al, digits[si] ;move digit to al reg

    cmp al, last ;comparing with last digit
    jl No_out ;if it larger than last digit jump to not out

    mov last, al ;add current digit to last

    inc si ;increase index

    cmp si, str_size ;check if algorithm went through all digits, if yes then jump to Yes_out
    jz Yes_out

    jmp desending_check ;continue the algorithm

Yes_out: ; output 
    xor dx, dx
	xor ax, ax
	mov ax, @data ;alocate data section with dx
	mov ds, ax ;mov to data section to dx
	lea dx, string2 ;add string2 to dx
    mov ah, 09h ;print string at register dx
    int 21h
    jmp print_ascii

No_out: ; output
    xor dx, dx
	xor ax, ax
	mov ax, @data ;alocate data section with ax
	mov ds, ax ;mov to data section register
	lea dx, string3 ;add string3 to dx
    mov ah, 09h ;print string at reg dx
    int 21h
    jmp print_ascii

print_ascii:
	inc si
	xor dx, dx
	xor ax, ax
	mov ax, @data ;alocate data section with ax
	mov ds, ax ;mov to data section register
	lea dx, string4 ;add string4 to dx
	mov ah, 09h
	int 21h
	xor dx, dx
	print_value:
		dec si ; decrease index
		mov dl, digits[si] ; move value to dl register to print out
		mov ah,2 ;print valut at register dl
		int 21h
		cmp si, 0 ;check if algorithm went through all digits
		jz extt	; if si == 0 then jump to extt
		jmp print_value	
	
extt:
	xor dx, dx
	xor ax, ax
	mov ax, @data ;alocate data section with ax
	mov ds, ax ;mov to data section registry
	lea dx, string5 ;add string5 to dx
	mov ah, 09h
	int 21h
    mov ah, 4ch ;close .exe
    int 21h ;dos interupt
main endp
end main
