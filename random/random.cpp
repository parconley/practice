// Name: Parker Conley

#include <iostream>
using namespace std;

void processCString(char source[]);
void printFibonacci(int n);

int main() {
    char source[5] = {'h', 'e', 'l', 'l', 'i'};
    processCString(source);
}

void processCString(char source[]) {
    for (int i = 0; source[i] != '\0'; ++i) {
        cout << source[i];
    }
    
    cout << endl;
}