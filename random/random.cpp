// Name: Parker Conley

#include <iostream>
using namespace std;

int main() {
    int array[5] = {1, 2, 3, 4, 5};

    int new_array[5];

    for (int i = 0; i < 5; i++) {
        new_array[i] = array[i];
    }

    cout << "Array: " << endl;
    for (int i = 0; i < 5; i++) {
        cout << array[i] << endl;
    }

    cout << "New Array: " << endl;
    for (int i = 0; i < 5; i++) {
        cout << new_array[i] << endl;
    }
    
    return 0;
}