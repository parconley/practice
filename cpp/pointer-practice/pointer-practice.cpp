// Name: Parker Conley
// Date: 02.20.23
// Description: This program plays around with C++ pointers.

#include <iostream>
using namespace std;

int main() {
    int var;
    var = 1;
    int *pvar;
    pvar = &var;

    cout << "Value of Variable = " << var << endl;
    cout << "Value of Pointer Variable = " << pvar << endl;
    cout << "Address of Variable = " << &var << endl;
    cout << "Address of Pointer Variable = " << &pvar << endl;
    cout << "Value of Dereferenced Pointer Variable = " << *pvar << endl;

    return 0;
}

/*
Results:
Value of Variable = 1
Value of Pointer Variable = 0x72f9dff94c  
Address of Variable = 0x72f9dff94c        
Address of Pointer Variable = 0x72f9dff940
Value of Dereferenced Pointer Variable = 1
*/