// Name: Parker Conley

#include <iostream>
using namespace std;

int main() {
    int x{ 1 };
    int *ptr = &x;

    cout << &ptr << endl;
    cout << ptr << endl;
    cout << &x << endl;
    cout << *ptr << endl;
}