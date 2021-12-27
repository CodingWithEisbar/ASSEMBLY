;program: get 10 character and print out all charaters that's ascii number is prime
;=================================================================================================
;Full-name: LE DANG MINH KHOI
;Student's ID: 20127213
.model small
.stack 100h
.data 
	user_in db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; storing user input
	have_char db 0 ;flag
	string1 db 'Enter 10 character: $'
	string2 db 'all character with ascii value that prime: $'
	string3 db '<none>$'
.code 
main proc
	start:
		xor si, si; index
		mov ax, @data ;alocate data section with ax
		mov ds, ax ;mov to data section regiser
		xor ax, ax
		lea dx, string1 ; add string1 to dx
		mov ah, 09h ;print sting at register dx
		int 21h
	get_user_in:
		mov ah, 01h ; get user input stored in al
		int 21h
		mov user_in[si], al ; stored user input to user_in
		inc si ; increase index
		cmp si, 0Ah ; checking user alread entered 10 times
		je prep1
		
		mov dl, ' ' ;print ' '
		mov ah, 02h
		int 21h
	
		jmp get_user_in ; countinue the loop	
	
	prep1:
		mov dl, 0Ah ; get new line
		mov ah, 02h
		int 21h
		
		lea dx, string2	;add string2 to dx
		mov ah, 09h	;;print string at register dx
		int 21h
				
		xor si, si ; index = 0
	print:			
		xor al, al
		mov al, user_in[si] ; get character to al for checking 
		cmp al, 02h ; if ascii character is 0 or 2 them jump to yprime
		je yprime
		cmp al, 01h
		je yprime
		
		xor bx, bx
		mov bl, al ; get bl ascii value of al 
		dec bl ; decrease bl
		prime_check:
			xor dx, dx  ;clean dx
			mov cl, al  ;temporaly stored al
			
			div bl  ;divide bx, remainder at ah reg
			cmp ah, 0000  ;if remainder is 0 then jump to nprime
			je nprime
			xor ax, ax ;clear ax register
			mov al, cl ;mov original data back to al
			dec bl ;decrease bl
			cmp bl, 01h ;check bl == 0, if yes jump to yprime
			je yprime
			xor cx, cx  ;clean cx
			jmp prime_check ;continue the algorithm
				
		nprime:
			; do nothing
			jmp prep2
		yprime:
			mov al, 1
			mov have_char, 1 ;mark flag that there are character matching the requirement
		
			mov dl, user_in[si] ; print current character
			mov ah, 02h
			int 21h
			
			mov dl, ' ' ; print ' '
			int 21h
			jmp prep2
		prep2:
			inc si ; increase index
			cmp si, 0Ah ; if went through all character jump to none_char to breaking the loop
			je none_char
			jmp print ; check the next character
	none_char:
		mov al, have_char ;checking flag if there are character matching requirement then skip to extt to close .exe
		cmp al, 1
		je extt
		lea dx, string3 ; add string3 to dx
		mov ah, 09h ; print string at register dx
		int 21h
	extt:
		mov ah, 4Ch
		int 21h
			
main endp
end main
