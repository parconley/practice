// Nmae: Parker Conley
// Date: 04.20.2023
// Description: This program organizes and sorts a dataset
// of international airports, then offers users the ability to search
// for specific airport details using the airport code.
// Upon entering a valid code, users receive relevant airport information,
// including name, total seats, country, and geographical coordinates.

// Key Points:
//
// - Select a subject for data (e.g., states, chemical elements, movies)
// - Create a data file with at least 20 records, each with at least 4 fields (1 key field, 2 numeric fields, 2 string fields)
// - Program provides search capability for users to find records based on key field
// - Use array of records, declare fixed size array (e.g., 100)
// - Load data into array only once at beginning
// - Sort data using selection or bubble sort
// - Implement binary search for finding records
// - No global variables allowed
// - Use subprograms for loading data, sorting, and searching
// - Turn in: Data description (topic, fields, data types) via email for comments
// - Code submission: Include all phases in one version

#include <iostream>
using namespace std;

struct Airport {
    string _orig; // XXX: CHANGE THIS TO A CHAR ARRAY
    string _name; // XXX: CHANGE THIS TO A CHAR ARRAY
    int _totalSeats;
    string _country; // XXX: CHANGE THIS TO A CHAR ARRAY
    double _lat;
    double _long;
};

int main() {
    cout << "Welcome to the International Airport Database!" << endl;
    cout << "This program organizes and sorts a dataset of international airports," << endl;
    cout << "then offers users the ability to search for specific airport details" << endl;
    cout << "using the airport code." << endl << endl;
    cout << "Please enter the name of the data file: ";
    string fileName;
    cin >> fileName;
    cout << endl;

    // Load data into array
    Airport airports[100];
    int numAirports = 0;


    return 0;
}