// Parker Conley
// 02.06.23
// This program simulates an airport radar installation.

#include <iostream>
using namespace std;
#include <math.h>

// Customer Service Representatives
void ShowMainMenu();

void ShowSpeedAndDirection();
void ShowDestination();
void ShowBasicCalculations();

void ShowDistance();
void ShowRectToPolar();
void ShowPolarToRect();

// Inputs
void GetTwoPolarPoints();
void GetTwoRectPoints();
void GetOnePolarPoint();
void GetOneRectPoint();

// Engineers

/* COMMENTED OUT B/C CAUSING ERROR
void CalcDistance(int x1, int x2, int y1, int y2);
void ConvertRectToPolar(int x, int y, int &distance, int &angle);
void ConvertPolarToRect(int distance, int angle, int &x, int &y);
*/


int main() {
    ShowMainMenu();


    return 0;
}

// Customer Service Representatives

void ShowMainMenu() {
    int quit = 0;

    while (!quit)
    {
        // Displays menu options.
        cout << endl << "Here are your options:" << endl;
        cout << "(1) Speed and Destination" << endl;
        cout << "(2) Destination" << endl;
        cout << "(3) Basic Calcuations" << endl;
        cout << "(4) Quit" << endl;

        // Asks user to selection an option by typing the option's number.
        int option_number;
        cout << endl << "Select an option by typing the options number: ";
        cin >> option_number;

        if (option_number == 1) {
            ShowSpeedAndDirection();
        } else if (option_number == 2) {
            ShowDestination();
        } else if (option_number == 3) {
            ShowBasicCalculations();
        } else if (option_number == 4) {
            quit = 1;
        } else {
            cout << endl << "The number you entered did not match. Please try again.";
        }
    }
}

void ShowSpeedAndDirection() {
    cout << "ShowSpeedAndDirection()" << endl;
}

void ShowDestination() {
    cout << "ShowDestination()" << endl;
}

void ShowBasicCalculations() {
    int quit = 0;

    while (!quit) {
        // Displays menu options.
        cout << endl << "Here are your options:" << endl;
        cout << "(1) Distance" << endl;
        cout << "(2) Convert Rectangular to Polar" << endl;
        cout << "(3) Convert Polar to Rectangular" << endl;
        cout << "(4) Quit" << endl;

        // Asks user to selection an option by typing the option's number.
        int option_number;
        cout << endl << "Select an option by typing the options number: ";
        cin >> option_number;

        if (option_number == 1) {
            ShowDistance();
        } else if (option_number == 2) {
            ShowRectToPolar();
        } else if (option_number == 3) {
            ShowPolarToRect();
        } else if (option_number == 4) {
            quit = 1;
        } else {
            cout << endl << "The number you entered did not match. Please try again.";
        }    
    }
}

void ShowDistance() {
    cout << "ShowDistance()" << endl;
}

void ShowRectToPolar() {
    cout << "ShowRectToPolar()" << endl;
}

void ShowPolarToRect() {
    cout << "ShowPolarToRect()" << endl;
}

// Inputs


// Engineers

/* CAUSING ERROR B/C PARAMETERS ARE NOT USED.
void CalcDistance(int x1, int x2, int y1, int y2) {
    int distance;

}
*/