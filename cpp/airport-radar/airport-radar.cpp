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
void GetTwoPolarPoints(double &distance1, double &distance2, double &angle1, double &angle2);
void GetTwoRectPoints(double &x1, double &x2, double &y1, double &y2);
void GetOnePolarPoint(double &distance, double &angle);
void GetOneRectPoint(double &x, double &y);

// Engineers
double CalcDistance(double x1, double x2, double y1, double y2);


void ConvertRectToPolar(double x, double y, double &distance, double &angle);
void ConvertPolarToRect(double distance, double angle, double &x, double &y);



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
    int go_back = 0;

    while (!go_back) {
        // Displays menu options.
        cout << endl << "Here are your options:" << endl;
        cout << "(1) Distance" << endl;
        cout << "(2) Convert Rectangular to Polar" << endl;
        cout << "(3) Convert Polar to Rectangular" << endl;
        cout << "(4) Go Back to Main Menu" << endl;

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
            go_back = 1;
        } else {
            cout << endl << "The number you entered did not match. Please try again.";
        }    
    }
}

void ShowDistance() {
    double x1, x2, y1, y2;

    GetTwoRectPoints(x1, x2, y1, y2);

    double distance = CalcDistance(x1, x2, y1, y2);

    cout << "The distance between points (" << x1 << ", " << y1 << ") and (" << x2 << ", " << y2 << ") is " << distance << " miles." << endl;
}

void ShowRectToPolar() {
    double x, y, angle, distance;

    GetOneRectPoint(x, y);

    ConvertRectToPolar(x, y, angle, distance);

    cout << "Your pair of rectangular coordinates (" << x << ", " << y << ") is equal to" << endl << "(" << distance << ", " << angle << "°) as polar coordinates.";
}

void ShowPolarToRect() {
    cout << "ShowPolarToRect()" << endl;
}

// Inputs

/* NOT DONE YET
// Takes two pairs of polar coordinates and
// converts them to rectangular coordinates.
void GetTwoPolarPoints(double &distance1, double &distance2, double &angle1, double &angle2) {

}
*/

// Takes two pairs of rectangular coordinates and
// converts them to polar coordinates.
void GetTwoRectPoints(double &x1, double &x2, double &y1, double &y2) {
    cout << endl << "Please enter two pairs of rectangular coordinates." << endl << endl;

    cout << "Enter the x coordinate of the first point (in miles): ";
    cin >> x1;

    cout << "Enter the y coordinate of the first point (in miles): ";
    cin >> y1;

    cout << "Enter the x coordinate of the second point (in miles): ";
    cin >> x2;

    cout << "Enter the y coordinate of the second point (in miles): ";
    cin >> y2;

    cout << endl;
}

// Takes one pair of polar coordinates and
// converts them to rectangular coordinates coordinates.
void GetOnePolarPoint(double &distance, double &angle) {
    cout << endl << "Please enter one pair of polar coordinates." << endl << endl;

    cout << "Enter the distance (in miles): ";
    cin >> distance;

    while (!(distance > 0)) {
        cout << endl << "Answer invalid. Make sure the distance is positive." << endl;
        cout << "Enter the angle (in degrees): ";
        cin >> distance;
    }

    cout << "Enter the angle (in degrees): ";
    cin >> angle;

    while (!(-360 < angle < 360)) {
        cout << endl << "Answer invalid. Make sure your angle is between -360 and 360 degrees (exclusive)." << endl;
        cout << "Enter the angle (in degrees): ";
        cin >> angle;
    }
}

// Takes one pair of rectangular coordinates and
// converts them to polar coordinates.
void GetOneRectPoint(double &x, double &y) {
    cout << endl << "Please enter one pair rectangular coordinates." << endl << endl;

    cout << "Enter the x coordinate (in miles): ";
    cin >> x;

    cout << "Enter the y coordinate (in miles): ";
    cin >> y;

    cout << endl;
}


// Engineers

// Takes two pairs of rectangular coordinates
// and returns the distance between them.
double CalcDistance(double x1, double x2, double y1, double y2) {
    double distance;

    // Formula for finding the distance between two rectangular coordinates.
    distance = sqrt(pow((x2 - x1), 2) + pow((y2 - y1), 2));

    return distance;
}

void ConvertRectToPolar(double x, double y, double &distance, double &angle) {
    // Calculates distance from (0, 0) to (x, y).
    distance = CalcDistance(0, x, 0, y);

    // Calculates angle: angle (radians) = atan( y/x ).
    const double PI = 3.142159;
    
    double angle_in_radians = atan(y / x);

    if (x < 0) {
        
    } 

    // STOPPED HERE. WAS TRYING TO FIGURE OUT WHAT THE EXCEPTIONS WERE.


}

void ConvertPolarToRect(double distance, double angle, double &x, double &y) {

}