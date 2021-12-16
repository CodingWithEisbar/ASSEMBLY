#include <iostream>
#include <conio.h>
//chuong trinh kiem tra ma ascii co cac chu so gian dan hay khong
//Chuong trinh chay tren microsoft visual studio 2019, trinh hop dich inline: microsoft c/c++ x86 inline assembly, khong the su dung bang cac trinh dich khac
//Nguon https://docs.microsoft.com/en-us/cpp/assembler/inline/inline-assembler?view=msvc-160

int main() {
    int a; char in; int is_desending = 0;
    std::cin >> in; a = in; //cast user input as ascii code
    //cheking ascii code has desending digit or not, input: a, output: is_desending
    __asm {
        mov eax, a; mov user input to eax register
        mov ebx, 10d; ebx register has value 10
        ;setting up for the algorithm
        xor edx, edx
        div ebx
        mov eax, a
        mov ecx, edx; last digit
        desending_check :
        xor edx, edx
            div ebx; get current digit

            cmp edx, ecx; if current digit is larger than last digit, jump to no
            jl no

            cmp eax, 0; if went through all digit jump to yes
            jz yes

            mov ecx, edx; mov current digit to last digit
            jmp desending_check
        no :
            mov eax, 0
            mov is_desending, eax
            jmp extt
        yes :
            mov eax, 1
            mov is_desending, eax
        extt :
            xor edx, edx
            xor ebx, ebx
    }
    std::cout << in << (is_desending ? " ascii code has desending digit" : " ascii code is random order or assending digit") << "(ascii code: " << a << "d)";
    _getch();
    return 0;
}