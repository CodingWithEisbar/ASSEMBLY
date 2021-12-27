;program: get 10 character and print out all charaters that's ascii number has all even digits
;=================================================================================================
;Full-name: LE DANG MINH KHOI
;Student's ID: 20127213
.model small
.stack 100h
.data 
	digits db 0, 0, 0, 0;digit handler
	user_in db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;storing user input
	digit_size dw ? ;total digit
	curr_index dw 0 ; save current index
	have_char db 0 ; flag 
	string1 db 'Enter 10 character: $'
	string2 db 'all character with ascii value that all evens: $'
	string3 db '<none>$'
.code 
main proc
	start:
		xor si, si; index
		mov ax, @data ;alocate data segment to ds register for string print
		mov ds, ax
		
		lea dx, string1 ; add string1 to dx
		mov ah, 09h ; print string at register dx
		int 21h
		xor ax, ax ; clear
	get_user_in:
		mov ah, 01h ; user input stored at al regiseter
		int 21h
		mov user_in[si], al ; transfer user input to user_in
		inc si	; increase index
		cmp si, 0Ah ; checking user alread entered 10 times
		jz prep1
		
		mov dl, ' ' ; print ' '
		mov ah, 02h
		int 21h
		
		jmp get_user_in ; continue loop
		
	prep1:
		mov dl, 0Ah ; get to new line 
		mov ah, 02h ; print character at al
		int 21h
		
		lea dx, string2 ; assign string2 in data segment to dx regiseter
		mov ah, 09h ; print string that stored in dx register
		int 21h
		
		print:
			xor si, si ;clear idex
			mov si, curr_index ;applied current index of user_in
			xor ax, ax
			mov al, user_in[si] ; applied user_in at index si to al for operation
			xor si, si
			xor bx, bx
			mov bx, 10d ; assign bxw with 10
			
			get_ascii_digit: ; get ascii digit and stored to "digits" memory
				xor dx, dx ; clear dx
				div bx	; divide ax with bx ax / 10
				add dx, 48d	; add 48 character
				and dx, 0ffh ; clear dh regiseter
				mov digits[si], dl ; add too array
				inc si ; increase index
				cmp AX, 0d ; if ax == 0 then jump to prep2 for checking requirment
				je prep2 
				jmp get_ascii_digit	; else continue the algorithm
			
			prep2:
				mov digit_size, si ;string ascii total digit
				xor si, si ; si = 0
				xor bx, bx
				mov bl, 02d ; assign bl with 02d
				xor ax, ax
				checker:
					mov al, digits[si] ; move current digit to al
					div bl ; al / bl (al / 2)
					cmp ah, 0d
					jg no_even ; if greater than 0 jump to no_even
					
					inc si ; increase index
					cmp si, digit_size ; if index == total digit then jump to yes_even 
					je yes_even
					
					jmp checker
					
				no_even:
					;do nothing
					jmp prep3
				yes_even:
					mov al, 1 
					mov have_char, al ;mark flag that there are character matching the requirement
				
					;print current character that meets the requirment
					xor si, si
					mov si, curr_index ; get current character index back  
					mov dl, user_in[si] ; get the character to dl register
					mov ah, 02h
					int 21h
					
					mov dl, ' ' ; print ' '
					int 21h
					
					jmp prep3
					
			prep3:
				xor si, si
				mov si, curr_index 
				inc si ; increase current character index
					
				cmp si, 0Ah ; went through all character jump to none_char
				je none_char
					
				mov curr_index, si ; stored new current index
				jmp print ; next character check
				
	none_char:
		mov al, have_char ;checking flag if there are character matching requirement then skip to extt to close .exe
		cmp al, 1
		je extt
		lea dx, string3
		mov ah, 09h
		int 21h
	extt:
		mov ah, 4Ch ; close .exe 
		int 21h
main endp
end main 