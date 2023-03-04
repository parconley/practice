// Name: Parker Conley
// Date: 02.27.23
// Description: 

#include <iostream>
using namespace std;

void ShowMainMenu();

void PlainText(char plain_text[]);
void Cipher(char cipher[], char reverse[]);
void CipherText(char cipher_text[]);
void Encode(char plain_text[], char cipher[]);
void Decode(char cipher_text[], char reverse[]);

void GetEntry(char text[]);
void GetCipher(char cipher[], char reverse[]);
void GetLine(char buffer[]);

void ScanAndSubstitute(char text[], char cipher[]);
void ConvertUppercaseToLowercase(char text[]);

int Main() {
    ShowMainMenu();

    return 0;
}

void ShowMainMenu() {
    int quit = 0;
    int option_number;

    char plain_text[81];
    char cipher_text[81];
    char cipher[26];
    char reverse[26];

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
            PlainText(plain_text);
        } else if (option_number == 2) {
            Cipher(cipher, reverse);
        } else if (option_number == 3) {
            CipherText(cipher_text);
        } else if (option_number == 4) {
            Encode(plain_text, cipher);
        } else if (option_number == 5) {
            Decode(cipher_text, reverse);
        } else if (option_number == 6) {
            quit = 1;
        } else {
            cout << endl << "The number you entered did not match any of the options. Please try again." << endl;
        }
    }
}

// Functions for each menu option.
void PlainText(char plain_text[]) {
    cout << endl << "Enter plain text: ";
    GetEntry(plain_text);
    cout << endl << "Plain text: " << plain_text << endl;
}

void Cipher(char cipher[], char reverse[]) {
    cout << endl << "Enter cipher: ";
    GetCipher(cipher, reverse);
    cout << endl << "Cipher: " << cipher << endl;
    cout << endl << "Reverse: " << reverse << endl;
}

void CipherText(char cipher_text[]) {
    cout << endl << "Enter cipher text: ";
    GetEntry(cipher_text);
    cout << endl << "Cipher text: " << cipher_text << endl;
}

void Encode(char plain_text[], char cipher[]) {

}

void Decode(char cipher_text[], char reverse[]) {

}

// Functions for getting user input.
void GetEntry(char text[]) {
    GetLine(text);
}

void GetCipher(char cipher[], char reverse[]) {
    cout << endl << "Enter cipher: ";
    cin >> cipher;

    // Checking to see if there are 26 letters.
    int is_valid_answer = 0;
    int repeat_letters = 0;

    while (is_valid_answer) {
        int i;

        for (i = 0; cipher[i] != '\0'; ++i) {
            int j;
            for (j = i + 1; cipher[j] != '\0'; ++j) {
                if (cipher[i] == cipher[j]) {
                    ++repeat_letters;
                }
            }
        }

        if (i != 26) {
            cout << endl << "The cipher you entered did not have 26 letters. Please try again." << endl;
            cout << endl << "Enter cipher: ";
            cin >> cipher;
        } else if (repeat_letters > 0) {
            cout << endl << "The cipher you entered had repeat letters. Please try again." << endl;
            cout << endl << "Enter cipher: ";
            cin >> cipher;
        } else {
            is_valid_answer = 1;
        }
    }

    // Creating the reverse cipher. THIS IS NOT COMPLETE.
    int i;

    for (i = 0; cipher[i] != '\0'; ++i) {
        reverse[i] = cipher[i];
    }
}

void GetLine(char buffer[]) {
    int ix;
    char c;

    cin.ignore();
    // OR cin.get();

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

void ConvertUppercaseToLowercase(char text[]) {
    cout << endl << "Converting uppercase letters to lowercase..." << endl;

    int i;

    for (i = 0; text[i] != '\0'; ++i) {
        if (text[i] >= 'A' && text[i] <= 'Z') {
            text[i] = text[i] + 32; // 32 is the difference between uppercase and lowercase letters in ACSII.
        }
    }
}