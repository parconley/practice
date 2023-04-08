// Name: Parker Conley
// Date: 04.08.2023
// Description: This program to computes the dimensions (width and height)
// of a screen given the diagonal and the aspect ratio.

#include <iostream>
using namespace std;
#include <math.h>

struct screen_dimensions {
    double width;
    double height;
}; 

screen_dimensions* ComputeDimensions(double diagonal, double aspect_ratio);

int main() {

    cout << "This program computes the dimensions (width and height) of a screen" << endl << "given the diagonal and the aspect ratio." << endl;

    double diagonal, aspect_ratio;

    cout << endl << "Enter the diagonal of the screen (in inches): ";
    cin >> diagonal;
    cout << "Enter the aspect ratio of the screen (width/height in inches): ";
    cin >> aspect_ratio;

    screen_dimensions* dimensions = ComputeDimensions(diagonal, aspect_ratio);

    cout << endl << "The width of the screen is " << dimensions->width << " inches.";
    cout << endl << "The height of the screen is " << dimensions->height << " inches." << endl;
    
    delete dimensions;

    return 0;
}

// This function computes the dimensions of a screen given the diagonal and the aspect ratio.
screen_dimensions* ComputeDimensions(double diagonal, double aspect_ratio) {
    screen_dimensions* dimensions = new screen_dimensions;

    dimensions->height = sqrt(pow(diagonal, 2) / (1 + pow(aspect_ratio, 2)));

    dimensions->width = dimensions->height * aspect_ratio;

    return dimensions;
}