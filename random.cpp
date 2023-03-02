// Name: Parker Conley

#include <iostream>
using namespace std;

void intcopy(int dest[], int source[], int size);

int main() {
    int array1[5] = { 1, 2, 3, 4, 5 };
    //int array2[5] = { 6, 7, 8, 9, 10 };
    int array3[5];

    intcopy(array3, array1, 5);

    for (int i = 0; i < 5; i++) {
        cout << array3[i] << endl;
    }

    return 0;
}

void intcopy(int dest[], int source[], int size) {
    for (int i = 0; i < size; i++) {
        dest[i] = source[i];
    }
}