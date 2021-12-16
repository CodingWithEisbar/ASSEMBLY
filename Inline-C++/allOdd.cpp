//CHUONG TRINH KIEM TRA MA KY TU CHUA TOAN SO LE
//NGUOI VIET: NGUYEN TRUNG NGUYEN
//MSSV: 20127404

#include <iostream>
#include <conio.h>

int main()
{
	char input;
	std::cin >> input;
	int countEven = 0;
	int i = 2;
	int temp;
	int integer = input;

	_asm {
		mov eax, integer


		checkOdd :
		cmp eax, 0
			je exxit
			xor edx, edx; So du se duoc luu vao thanh edx
			mov ebx, 10d
			div ebx
			mov eax, edx
			xor edx, edx
			div i
			cmp edx, 0
			mov temp, eax
			je countEvenNumber
			jne checkOdd


			countEvenNumber :
			add countEven, 1

			exxit :

	}

	std::cout << input << ": " << integer << (countEven == 0 ? "=> all odd number" : "=> not all odd number");
	_getch();
	return 0;
}