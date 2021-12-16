//CHUONG TRING KIEM TRA MA KY TU CO PHAI SO CHINH PHUONG KHONG
//NGUOI VIET: NGUYEN TRUNG NGUYEN
//MSSV: 20127404


#include <iostream>
#include <conio.h>

int main() {
	char input;
	int isPerfectSquare = 0;
	int  i = 2;
	std::cin >> input;
	int integer = input; //Chuyen doi gia tri thanh so nguyen de tinh toan
	
	_asm {
		mov ebx, integer
	
		perfect_check:
		mov eax, i
		mul i
		inc i
		cmp eax, ebx
		je isPerfectSquareNumber;
		jg notPerfectSquareNumber
		jmp perfect_check;

		notPerfectSquareNumber:
		mov eax, 0
		mov isPerfectSquare, eax
		jmp exxit


		isPerfectSquareNumber:
		mov eax, 1
		mov isPerfectSquare, eax


			exxit :
		mov eax, 0
	}

	std::cout << input << ": " << integer << (isPerfectSquare ? "=> is perfect square" : "=> not perfect square");
	_getch();

	return 0;
}