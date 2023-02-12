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
double GetTimeElapsed();
double GetDirection();
double GetSpeed();

// Engineers
double CalcDistance(double x1, double x2, double y1, double y2);
void ConvertRectToPolar(double x, double y, double &distance, double &angle);
void ConvertPolarToRect(double distance, double angle, double &x, double &y);
double CalcSpeed(double distance1, double distance2, double angle1, double angle2, double time_elapsed);
void CalcDestination(double distance, double angle, double direction, double speed, double time_elapsed, double &destination_distance, double &destination_angle);


int main() {
    ShowMainMenu();

    return 0;
}

// Customer Service Representatives

// Displays the Main Calculations Menu and recieves inputs. 
void ShowMainMenu() {
    int quit = 0;

    while (!quit)
    {
        // Displays menu options.
        cout << endl << "----------- MAIN MENU -----------" << endl;
        cout << "(1) Speed and Destination" << endl;
        cout << "(2) Destination" << endl;
        cout << "(3) Basic Calcuations" << endl;
        cout << "(4) Quit" << endl;
        cout << "---------------------------------" << endl;

        // Asks user to selection an option by typing the option's number.
        int option_number;
        cout << endl << "Select an option by typing the option's number: ";
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

// Runs the input function to get two pairs of polar coordiantes and a time.
// Runs the calculate speed function to get the speed traveled between
// the two pairs of polar coordinates given the time elapsed.
// Outputs the speed.
void ShowSpeedAndDirection() {
    double distance1, distance2, angle1, angle2;

    GetTwoPolarPoints(distance1, distance2, angle1, angle2);

    double time_elapsed = GetTimeElapsed();

    double speed = CalcSpeed(distance1, distance2, angle1, angle2, time_elapsed);

    cout << "The object is traveling at a speed of " << speed << " mph." << endl;
}


void ShowDestination() {
    double distance, angle;
    GetOnePolarPoint(distance, angle);

    double direction = GetDirection();

    double speed = GetSpeed();

    double time_elapsed = GetTimeElapsed();

    double destination_distance, destination_angle;
    CalcDestination(distance, angle, direction, speed, time_elapsed, destination_distance, destination_angle);

    // STOPPED HERE. CREATE OUTPUT AND TEST OUTPUT.
}

// Displays the Basic Calculations Menu and recieves inputs.
void ShowBasicCalculations() {
    int return_to_main_menu = 0;

    while (!return_to_main_menu) {
        // Displays menu options.
        cout << endl << "---- BASIC CALCULATIONS MENU ----" << endl;
        cout << "(1) Distance" << endl;
        cout << "(2) Convert Rectangular to Polar" << endl;
        cout << "(3) Convert Polar to Rectangular" << endl;
        cout << "(4) Return to Main Menu" << endl;
        cout << "---------------------------------" << endl;

        // Asks user to selection an option by typing the option's number.
        int option_number;
        cout << endl << "Select an option by typing the option's number: ";
        cin >> option_number;

        if (option_number == 1) {
            ShowDistance();
        } else if (option_number == 2) {
            ShowRectToPolar();
        } else if (option_number == 3) {
            ShowPolarToRect();
        } else if (option_number == 4) {
            return_to_main_menu = 1;
        } else {
            cout << endl << "The number you entered did not match. Please try again.";
        }    
    }
}

// Runs the input function to get two pairs of rectangular coordaintes.
// Runs the calcuation function to find the distance between
// the two pairs of rectangular coordinates.
// Outputs the distance.
void ShowDistance() {
    double x1, x2, y1, y2;

    GetTwoRectPoints(x1, x2, y1, y2);

    double distance = CalcDistance(x1, x2, y1, y2);

    cout << "The distance between points (" << x1 << ", " << y1 << ") and (" << x2 << ", " << y2 << ") is " << distance << " miles." << endl;
}

// Runs the input function to get one pair of rectangular coordaintes.
// Runs the calcuation function to convert the pair of rectangular coordinates
// into a pair of polar coordinates.
// Outputs the converstion.
void ShowRectToPolar() {
    double x, y, distance, angle;

    GetOneRectPoint(x, y);

    ConvertRectToPolar(x, y, distance, angle);

    cout << "Your pair of rectangular coordinates (" << x << ", " << y << ") is equal to" << endl << "(" << distance << ", " << angle << "\370) as polar coordinates." << endl;
}

// Runs the input function to get one pair of polar coordaintes.
// Runs the calcuation function to convert the pair of polar coordinates
// into a pair of rectangular coordinates.
// Outputs the converstion.
void ShowPolarToRect() {
    double distance, angle, x, y;

    GetOnePolarPoint(distance, angle);

    ConvertPolarToRect(distance, angle, x, y);

    cout << "Your pair of polar coordinates (" << distance << ", " << angle << "\370) is equal to" << endl << "(" << x << ", " << y << ") as rectangular coordinates." << endl;
}

// Inputs

// Asks user for two pairs of polar coordinates.
void GetTwoPolarPoints(double &distance1, double &distance2, double &angle1, double &angle2) {
    cout << endl << "Please enter two pairs of polar coordinates (distance, angle)." << endl << endl;

    cout << "Enter the first distance (in miles): ";
    cin >> distance1;

    while (!(distance1 > 0)) {
        cout << endl << "Answer invalid. Make sure the distance is positive." << endl << endl;
        cout << "Enter the distance (in degrees): ";
        cin >> distance1;
    }

    cout << "Enter the first angle (in degrees): ";
    cin >> angle1;

    while (!(-360 < angle1 < 360)) {
        cout << endl << "Answer invalid." << endl << "Make sure your angle is between -360 and 360 degrees (exclusive)." << endl << endl;
        cout << "Enter the angle (in degrees): ";
        cin >> angle1;
    }

    cout << "Enter the second distance (in miles): ";
    cin >> distance2;

    while (!(distance2 > 0)) {
        cout << endl << "Answer invalid. Make sure the distance is positive." << endl << endl;
        cout << "Enter the distance (in degrees): ";
        cin >> distance2;
    }

    cout << "Enter the second angle (in degrees): ";
    cin >> angle2;

    while (!(-360 < angle2 < 360)) {
        cout << endl << "Answer invalid." << endl << "Make sure your angle is between -360 and 360 degrees (exclusive)." << endl << endl;
        cout << "Enter the angle (in degrees): ";
        cin >> angle2;
    }

    cout << endl;
}

// Asks user for two pairs of rectangular coordinates.
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

// Asks user for one pair of polar coordinates.
void GetOnePolarPoint(double &distance, double &angle) {
    cout << endl << "Please enter one pair of polar coordinates (distance, angle)." << endl << endl;

    cout << "Enter the distance (in miles): ";
    cin >> distance;

    while (!(distance > 0)) {
        cout << endl << "Answer invalid. Make sure the distance is positive." << endl << endl;
        cout << "Enter the distance (in degrees): ";
        cin >> distance;
    }

    cout << "Enter the angle (in degrees): ";
    cin >> angle;

    while (!(-360 < angle < 360)) {
        cout << endl << "Answer invalid." << endl << "Make sure your angle is between -360 and 360 degrees (exclusive)." << endl << endl;
        cout << "Enter the angle (in degrees): ";
        cin >> angle;
    }

    cout << endl;
}

// Asks user for one pair of rectangular coordinates.
void GetOneRectPoint(double &x, double &y) {
    cout << endl << "Please enter one pair rectangular coordinates." << endl << endl;

    cout << "Enter the x coordinate (in miles): ";
    cin >> x;

    cout << "Enter the y coordinate (in miles): ";
    cin >> y;

    cout << endl;
}

// Asks user for time elapsed.
double GetTimeElapsed() {
    double time_elapsed;

    cout << "Enter the amount of time that elapsed (in hours): ";
    cin >> time_elapsed;

    while (time_elapsed < 0) {
        cout << "Invalid response. It is impossible to travel backwards in time." << endl << "Please enter a positive number." << endl << endl;

        cout << "Enter the amount of time that elapsed (in hours): ";
        cin >> time_elapsed;
    }
    
    while (time_elapsed == 0) {
        cout << "Invalid response. Please enter a positive number." << endl << endl;
        
        cout << "Enter the amount of time that elapsed (in hours): ";
        cin >> time_elapsed;
    }

    cout << endl;

    return time_elapsed;
}

// Asks user for a direction.
double GetDirection() {
    double direction;

    cout << "Enter the direction (in degrees): ";
    cin >> direction;

    while (!(-360 < direction < 360)) {
        cout << endl << "Answer invalid." << endl << "Make sure your direction is between -360 and 360 degrees (exclusive)." << endl << endl;
        cout << "Enter the angle (in degrees): ";
        cin >> direction;
    }

    cout << endl;

    return direction;
}

// Asks user for a speed.
double GetSpeed() {
    double speed;

    cout << "Enter the speed (in mph): ";
    cin >> speed;

    while (speed < 0) {
        cout << "Invalid response. Speed cannot be negative." << endl << "Please enter a positive number." << endl << endl;

        cout << "Enter the amount of time that elapsed (in hours): ";
        cin >> speed;
    }

    cout << endl;

    return speed;
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

// Takes one pair of rectangular coordaintes
// and converts them to a pair of polar coordaintes.
void ConvertRectToPolar(double x, double y, double &distance, double &angle) {
    // Calculates distance from (0, 0) to (x, y).
    distance = CalcDistance(0, x, 0, y);

    // Calculates angle: angle (radians) = atan(y / x).
    // The "if" is making sure x isn't 0 (can't divide by zero).
    // If x is equal to zero, it is set equal to 
    // 90 degrees (if y is greater than zero or 0)
    // or -90 degrees (if y is less than 0).
    // The "else" is the normal converstion formula while also
    // checking for if the x is less than zero. If it is, it adds 180 degrees.
    const double PI = 3.142159;

    if (x == 0) {
        if (y >= 0) {
            angle = 90;
        } else {
            angle = -90;
        }
    } else {
        double angle_in_radians = atan(y / x);

        angle = angle_in_radians * (180 / PI);

        if (x < 0) {
            angle = angle + 180;
        }
    }
}

// Takes one pair of polar coordinates
// and converts them to rectangular coordinates
void ConvertPolarToRect(double distance, double angle, double &x, double &y) {
    const double PI = 3.142159;

    // The "angle" variable is angle in degrees (aka direction).
    double angle_in_radians = angle * (PI / 180);

    x = distance * cos(angle_in_radians);
    y = distance * sin(angle_in_radians);
}

// Takes two pairs of polar coordinates and an amount of time elapsed
// and returns the speed that an object had to travel linearly to get to
// the first point to the second in the amount of time elapsed.
double CalcSpeed(double distance1, double distance2, double angle1, double angle2, double time_elapsed) {
    // Converts polar coordinates to rectangular coordinates
    // in order to find the difference.
    double x1, x2, y1, y2;
    ConvertPolarToRect(distance1, angle1, x1, y1);
    ConvertPolarToRect(distance2, angle2, x2, y2);

    // Finds the difference between the x's and the y's.
    double new_x = x2 - x1;
    double new_y = y2 - y1;

    // Converts the new pair of rectangular coordinates back to polar coordinates.
    double new_distance, new_angle;
    ConvertRectToPolar(new_x, new_y, new_distance, new_angle);

    // Speed is calculated using the new distance variable
    // found using the above calcuations.
    double speed = new_distance / time_elapsed;

    return speed;
}

// Takes one pair of polar coordinates, a direction, a speed, and a time
// and finds the final destination (in polar coordinates) of a hypothetical object
// traveling from that point, in that direction, with that speed,
// during that amount of time.
void CalcDestination(double distance, double angle, double direction, double speed, double time_elapsed, double &destination_distance, double &destination_angle) {
    double distance_from_start = speed * time_elapsed;

    // Treating the distance from the starting point and the direction traveled
    // as a pair of polar coordaintes.

    // Converting the intiial starting point pair of polar coordinates
    // to rectangular coordinates.
    double start_x, start_y;
    ConvertPolarToRect(distance, angle, start_x, start_y);

    // Converting the distance from the starting point and the direction traveled
    // to rectangular coordinates.
    double new_x, new_y;
    ConvertPolarToRect(distance_from_start, direction, new_x, new_y);

    // Adding the two pairs of rectangular coordinates
    // to get the object's final destination in rectangular coordinates.
    double destination_x = start_x + new_x;
    double destination_y = start_y + new_y;

    // Converting the final destination in rectangular coordinates
    // to the final destination in polar coordinates.
    ConvertRectToPolar(destination_x, destination_y, destination_distance, destination_angle);
}


