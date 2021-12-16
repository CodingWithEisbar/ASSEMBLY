#include <iostream>
#include <conio.h>
//chuong tring kiem tra ma ascci co phai la so nguyen to hay khong
//Chuong trinh chay tren microsoft visual studio 2019, trinh hop dich inline: microsoft c/c++ x86 inline assembly, khong the su dung bang cac trinh dich khac
//Nguon https://docs.microsoft.com/en-us/cpp/assembler/inline/inline-assembler?view=msvc-160

int main()
{
    char in; int is_prime = 0;//result
    std::cin >> in; int a = in;//cast user input as ascii value
    //checking ascii code is prime or not, input: a, outout: is_prime
    __asm {
        mov eax, a; mov user input to eax register
        ; checking input from 1 to 10
        cmp eax, 0
        jz no
        cmp eax, 1
        jz yes
        cmp eax, 2
        jz yes
        ; setting up for the algorithm
        xor ebx, ebx
        mov ebx, a
        dec ebx;ebx = user input - 1
        prime_check :
        xor edx, edx
            div ebx
            cmp edx, 0; if ebx is a divisor of eax jump to no
            jz no
            dec ebx
            cmp ebx, 1; if ebx == 1 jump to yes
            jz yes
            mov eax, a; get user input back for next checking
            jmp prime_check; countinue the algorithm
        no :
            mov eax, 0
            mov is_prime, eax
            jmp extt
        yes :
            mov eax, 1
            mov is_prime, eax
        extt :
            xor edx, edx
            xor ebx, ebx
    }
    std::cout << in << (is_prime ? " ascii code is a prime number" : " ascii code is not a prime number") << "(ascii: " << a << "d)";
    _getch();
    return 0;
}