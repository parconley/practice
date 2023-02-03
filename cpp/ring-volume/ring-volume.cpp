// Parker Conley
// 2.3.23
// This program calculates the volume of a ring.

#include <iostream>
using namespace std;
#include <math.h>

// declaring and initializing variables
double ring_radius {};
double cross_selection_radius {};

// declaring functions
int IntroductionAndPermissions();
void InputRadiuses(double &ring_radius, double &cross_selection_radius);
double ComputeVolume(double ring_radius, double cross_selection_radius);
void PrintVolume(double Volume);


int main() {

    IntroductionAndPermissions();

    InputRadiuses(ring_radius, cross_selection_radius);

    PrintVolume(ComputeVolume(ring_radius, cross_selection_radius));

    return 0;
}

// (a) 
// Display an introduction: "Compute Ring Volume"
// Then ask the user if they agree to grant permission to use cookies (y/n).
// Return a 1 if they enter a 'y', or a 0 if they enter 'n'.
int IntroductionAndPermissions() {
    cout << endl << "Compute Ring Volume" << endl << endl;

    cout << "Do you agree to grant permission to use cookies? (y/n)" << endl;

    char Cookies {'n'};
    cin >> Cookies;
    cout << endl;

    if (Cookies == 'y') {
        return 0;
    } else {
        return 1;
    }
}

// (b)
// Ask the user to enter ring radius and cross section radius (both in inches),
// and make sure each input is positive.
// (Communicate both inputs to the main program using reference parameters.)
void InputRadiuses(double &ring_radius, double &cross_selection_radius) {
    cout << "Enter the ring radius (in inches): ";
    cin >> ring_radius;
    cout << endl;

    // verify ring_radius is positive
    while (ring_radius < 0) {
        cout << "Input must be positive. Try again." << endl << endl;
        cout << "Enter the ring radius (in inches): ";
        cin >> ring_radius;
        cout << endl;
    }

    cout << "Enter the cross selection radius (in inches): ";
    cin >> cross_selection_radius;
    cout << endl;

    // verify cross_selection_radius is positive
    while (cross_selection_radius < 0) {
        cout << "Input must be positive. Try again." << endl << endl;
        cout << "Enter the cross selection radius (in inches): ";
        cin >> cross_selection_radius;
        cout << endl;
    }

    return;
}

// (c) 
// Given ring radius and cross section radius (input parameters to the subprogram),
// compute the volume.
// (Communicate the result using the return statement.)
double ComputeVolume(double ring_radius, double cross_selection_radius) {
    const double PI = 3.14159;
    double volume {};

    volume = 2 * pow(PI, 2) * ring_radius * pow(cross_selection_radius, 2);

    return volume;
}

// (d)
// Given the volume (an input parameter to the subprogram),
// display it with an appropriate label, including the units.
void PrintVolume(double volume) {
    cout << "Ring Volume (cubic inches): " << volume << endl;

    return;
}