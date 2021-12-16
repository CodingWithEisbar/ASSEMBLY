//CHUONG TRINH KIEM TRA MA KY TU CHUA TOAN SO CHAN
//NGUOI VIET: NGUYEN TRUNG NGUYEN
//MSSV: 20127404

#include <iostream>
#include <conio.h>
using namespace std;

int main()
{
	char input;
	cin >> input;
	int countOdd = 0;
	int i = 2;
	int temp;
	int integer = input;

	_asm {
		mov eax, integer
		

		checkEven:
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
		jne countOddNumber
		je checkEven


		countOddNumber:
		add countOdd, 1

		exxit:

	}
	
	cout << input << ": " << integer << (countOdd == 0 ? "=> all even number" : "=> not all even number");
	_getch();
	return 0;
}