// Name: Parker Conley
// Date: 04.20.2023
// Description: This program organizes and sorts a dataset
// of international airports, then offers users the ability to search
// for specific airport details using the airport code.
// Upon entering a valid code, users receive relevant airport information,
// including name, total seats, country, and geographical coordinates.

#include <iostream>
using namespace std;
#include <fstream>

struct Airport {
    char _orig[4]; // Airport code
    char _name[100]; // Airport name
    double _totalSeats; // Total seats
    char _country[50]; // Country
    double _lat; // Latitude
    double _long; // Longitude
};

void loadAirports(Airport *airports[], int &nAirports);
void sortAirports(Airport *airports[], int nAirports);
Airport* searchAirports(Airport *airports[], int nAirports, char key[]);
int str_compare(char s1[], char s2[]);
void str_copy(char dest[], char src[]);

int main() {
    cout << "Welcome to the International Airport Database!" << endl;
    cout << "This program organizes and sorts a dataset of international airports," << endl;
    cout << "then offers users the ability to search for specific airport details" << endl;
    cout << "using the airport code." << endl << endl;

    // Load data into array
    Airport *airports[100];
    int nAirports = 0;
    loadAirports(airports, nAirports);

    // Sort data
    sortAirports(airports, nAirports);

    // Search data
    char key[4];
    int stay = 1;

    do {
        cout << "Please enter an airport code: ";
        cin >> key;

        Airport *foundAirport = searchAirports(airports, nAirports, key);
        char notFoundOrig[4] = "NOT";

        if (str_compare(foundAirport->_orig, notFoundOrig) == 0) {
            cout << endl;
            cout << "Airport not found." << endl << endl;
        } else {
            cout << endl;
            cout << "Airport found!" << endl << endl;
            cout << "Airport name: " << foundAirport->_name << endl;
            cout << "Total seats: " << foundAirport->_totalSeats << endl;
            cout << "Country: " << foundAirport->_country << endl;
            cout << "Latitude: " << foundAirport->_lat << endl;
            cout << "Longitude: " << foundAirport->_long << endl << endl;
        }

        cout << "Would you like to search for another airport? (1 = yes, 0 = no): ";
        cin >> stay;
        cout << endl;
    } while (stay == 1);
}

// Load data into array
void loadAirports(Airport *airports[], int &nAirports) {
    fstream infile;

    infile.open("airports.txt", ios::in);

    nAirports = 0;
    char end[4] = "END";
    Airport temp;

    infile >> temp._orig;
    while (str_compare(temp._orig, end) != 0) {
        Airport *newAirport = new Airport;
        str_copy(newAirport->_orig, temp._orig);
        infile >> newAirport->_name;
        infile >> newAirport->_totalSeats;
        infile >> newAirport->_country;
        infile >> newAirport->_lat;
        infile >> newAirport->_long;
        airports[nAirports] = newAirport;
        nAirports++;

        infile >> temp._orig;
    }

    infile.close();
}

// Selection sort
void sortAirports(Airport *airports[], int nAirports) {
    int i, j, minIndex;
    Airport *temp;

    for (i = 0; i < nAirports - 1; i++) {
        minIndex = i;
        for (j = i + 1; j < nAirports; j++) {
            if (str_compare(airports[j]->_orig, airports[minIndex]->_orig) < 0) {
                minIndex = j;
            }
        }

        temp = airports[i];
        airports[i] = airports[minIndex];
        airports[minIndex] = temp;
    }
}

// Binary search
Airport* searchAirports(Airport *airports[], int nAirports, char key[]) {
    int low = 0;
    int high = nAirports - 1;
    int mid;

    while (low <= high) {
        mid = (low + high) / 2;
        if (str_compare(airports[mid]->_orig, key) < 0) {
            low = mid + 1;
        } else if (str_compare(airports[mid]->_orig, key) > 0) {
            high = mid - 1;
        } else {
            return airports[mid];
        }
    }

    Airport *notFound = new Airport;
    char notFoundOrig[4] = "NOT";

    str_copy(notFound->_orig, notFoundOrig);
    return notFound;
}

// Compare two strings, return 0 if equal, < 0 if s1 < s2, > 0 if s1 > s2
int str_compare(char s1[], char s2[]) {
    int i = 0;

    while (s1[i] != '\0' && s2[i] != '\0' && s1[i] == s2[i]) {
        i++;
    }
    
    return s1[i] - s2[i];
}

// Copy string s2 to s1
void str_copy(char dest[], char src[]) {
    int i = 0;

    while (src[i] != '\0') {
        dest[i] = src[i];
        i++;
    }

    dest[i] = '\0';
}