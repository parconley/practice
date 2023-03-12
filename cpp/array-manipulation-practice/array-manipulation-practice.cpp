// Name: Parker Conley
// Date: 03/11/23
// Description: This program includes two subprograms that manipulate arrays of numbers.

#include <iostream>
using namespace std;

// Function prototypes
int FindGreaterWithIndexing(double array[], double number);
int FindGreaterWithPointers(double *array, double number);
void AddNumberWithIndexing(double array[], double number, int length);
void AddNumberWithPointers(double *array, double number, int length);

int main() {
    return 0;
}

int FindGreaterWithIndexing(double array[], double number) {
    int greater = 0;

    for (int i = 0; array[i] != '\0'; ++i) {
        if (array[i] > number) {
            ++greater;
        }
    }

    return greater;
}

int FindGreaterWithPointers(double *array, double number) {
    int greater = 0;

    for (int i = 0; *array != '\0'; ++i, ++array) {
        if (*array > number) {
            ++greater;
        }
    }

    return greater;
}

void AddNumberWithIndexing(double array[], double number, int length) {
    for (int i = 0; i < length; ++i) {
        array[i] = array[i] + number;
    }
}

void AddNumberWithPointers(double *array, double number, int length) {
    for (int i = 0; i < length; ++i, ++array) {
        *array = *array + number;
    }
}