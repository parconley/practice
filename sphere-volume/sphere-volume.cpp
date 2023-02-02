// Parker Conley
// This program calculates the volume of N spheres.

#include <iostream>
using namespace std;
#include <math.h>

int main() {
    // Defining variables.
    double sphereAmount;
    double radius;
    double volume;
    double totalVolume;
    const double PI = 3.142159;

    // Title
    cout << endl << "Compute the Volume of N Spheres" << endl << endl;

    // Asking for inputs
    cout << "Enter the amount spheres: ";

    cin >> sphereAmount;
    cout << endl;

    // Loop that gets the radius of each sphere, calculates each sphere volume,
    // and adds each volume to totalVolume
    for (int i = 1; i <= sphereAmount; ++i) {
        cout << "Enter the radius of sphere #" << i << " (in inches): ";
        cin >> radius;

        // Make sure user gave a positive number for the radius. Loop until they do.
        while (radius < 0) {
            cout << endl << "ERROR: The radius must be a positive number. Try again." << endl << endl;
            cout << "Enter the radius of sphere #" << i << " (in inches): ";
            cin >> radius;
        }

        cout << endl;
        volume = (4.0/3.0) * PI * pow(radius, 3);
        totalVolume = totalVolume + volume;
    }

    // Printing results
    cout << "Total Volume of All Spheres = " << totalVolume << " cubic inches" << endl;
    cout << endl;

    return 0;
}