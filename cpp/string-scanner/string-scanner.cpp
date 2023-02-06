// Parker Conley
// 02.05.23
// This program receives a given c-string and char,
// then outputs the amout of times the char appears in the string.

#include <iostream>
using namespace std;

char input_string[81];
char input_char{};

int ScanChar(char input_string[], char input_char);

int main() {

    // Inputs
    cout << endl << "Enter a string (no tabs or spaces allowed): ";
    cin >> input_string;

    cout << endl << "Enter a char: ";
    cin >> input_char;

    // Output ScanChar()
    cout << "Your char appeared " << ScanChar(input_string, input_char) << " time(s) in the string.";
    
    return 0;
}

// ScanChar scans input_string to see how many times input_char appears.
// It returns char_count—the amount of times input char appears in input_string.

int ScanChar(char input_string[], char input_char) {
    int i{ 0 };
    int char_count{ 0 };

    for (int i{ 0 }; input_string[i] != '\0'; i++) {
        if (input_string[i] == input_char) {
            char_count++;
        }
    }

    return char_count;
}