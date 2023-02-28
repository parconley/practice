// Name: Parker Conley
// Date: 02.27.23
// Description: 

#include <iostream>
using namespace std;

void ShowMainMenu();

void PlainText();
void Cipher();
void CipherText();
void Encode();
void Decode();

void GetEntry(char text[]);
void GetCipher(char cipher[], char reverse[]);
void GetLine(char buffer[]);

void ScanAndSubstitute(char text[], char cipher[]);
void ConvertUppercaseToLowercase();

int Main() {
    ShowMainMenu();

    return 0;
}

void ShowMainMenu() {
    int quit = 0;
    int option_number;

    //Define plain text, cipher, and cipher text here?

    while (!quit)
    {
        // Displays menu options.
        cout << endl << "----------- MAIN MENU -----------" << endl;
        cout << "(1) Enter plain text" << endl;
        cout << "(2) Enter cipher" << endl;
        cout << "(3) Enter cipher text" << endl;
        cout << "(4) Encode" << endl;
        cout << "(5) Decode" << endl;
        cout << "(6) Quit" << endl;
        cout << "---------------------------------" << endl;

        // Asks user to selection an option by typing the option's number.
        cout << endl << "Select an option by typing the option's number: ";
        cin >> option_number;

        if (option_number == 1) {
            PlainText();
        } else if (option_number == 2) {
            Cipher();
        } else if (option_number == 3) {
            CipherText();
        } else if (option_number == 4) {
            Encode();
        } else if (option_number == 5) {
            Decode();
        } else if (option_number == 6) {
            quit = 1;
        } else {
            cout << endl << "The number you entered did not match any of the options. Please try again." << endl;
        }
    }
}

// Functions for each menu option.
void PlainText() {
    char plain_text[81];

    cout << endl << "Enter plain text: ";
    GetEntry(plain_text);
    cout << endl << "Plain text: " << plain_text << endl;
}

void Cipher() {
    char cipher[26];
    char reverse[26];

    cout << endl << "Enter cipher: ";
    GetCipher(cipher, reverse);
    cout << endl << "Cipher: " << cipher << endl;
    cout << endl << "Reverse: " << reverse << endl;
}

void CipherText() {
    char cipher_text[81];

    cout << endl << "Enter cipher text: ";
    GetEntry(cipher_text);
    cout << endl << "Cipher text: " << cipher_text << endl;
}

void Encode() {
    
}

void Decode() {

}

// Functions for getting user input.
void GetEntry(char text[]) {
    GetLine(text);
}

void GetCipher(char cipher[], char reverse[]) {
    cout << endl << "Enter cipher: ";
    cin >> cipher;

    // Checking to see if there are 26 letters.
    int repeat_letters = 1;

    while (!repeat_letters) {
        int i;
        repeat_letters = 0;


        // STOPPED HERE. NEED TO CHECK IF THERE ARE 26 LETTERS AND IF THERE ARE NO REPEAT LETTERS.
        for (i = 0; cipher[i] != '\0'; ++i) {
            int j;
            for (j = i + 1; cipher[j] != '\0'; ++j) {
                if (cipher[i] == cipher[j]) {
                    ++repeat_letters;
                }
            }
        }

        if (i == 26) {
            repeat_letters = 0;
        } else {
            cout << endl << "The cipher you entered did not have 26 letters. Please try again." << endl;
            cout << endl << "Enter cipher: ";
            cin >> cipher;
        }
    }    
}

void GetLine(char buffer[]) {
    int ix;
    char c;

    cin.ignore();

    ix = 0;
    c = cin.get();

    while (c != '\n') {
        buffer[ix] = c;
        ++ix;
        c = cin.get();
    }
    
    buffer[ix] = '\0';
}

void ScanAndSubstitute(char text[], char cipher[]) {

}