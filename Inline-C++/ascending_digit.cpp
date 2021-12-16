#include <iostream>
#include <conio.h>
//chuong trinh kiem tra ma ascii co cac chu so tang dan hay khong
//Chuong trinh chay tren microsoft visual studio 2019, trinh hop dich inline: microsoft c/c++ x86 inline assembly, khong the su dung bang cac trinh dich khac
//Nguon https://docs.microsoft.com/en-us/cpp/assembler/inline/inline-assembler?view=msvc-160

int main() {
    int a; char in; int is_assending = 0; //result
    std::cin >> in; a = in; //cast user input as ascii code
    //cheking ascii code has assending digit or not, input: a, output: is_assending
    __asm {
        mov eax, a; mov user input to eax register
        mov ebx, 10d; ebx register has value 10
        ; setting up for the algorithm
        xor edx, edx
        div ebx
        mov eax, a
        mov ecx, edx; last digit
        assending_check :
            xor edx, edx
            div ebx

            cmp edx, ecx; if current digit is smaller than last digit, jump to no
            jg no

            cmp eax, 0; if went through all digit jump to yes
            jz yes

            mov ecx, edx; mov current digit to last digit
            jmp assending_check
        no :
            mov eax, 0
            mov is_assending, eax
            jmp extt
        yes :
            mov eax, 1
            mov is_assending, eax
        extt :
        xor edx, edx
            xor ebx, ebx
    }
    std::cout << in << (is_assending ? " ascii code has assending digit " : " ascii code has random order or desending digit ") << "(ascii code: " << a << "d)";
    _getch();
    return 0;
}