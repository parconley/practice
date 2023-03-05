// Name: Parker Conley
// Date: 02.27.23
// Description: This program allows the user to encode and decode text using a cipher.

#include <iostream>
using namespace std;

void ShowMainMenu();

// Functions for each menu option.
void PlainText(char plain_text[]);
void Cipher(char cipher[], char reverse[]);
void CipherText(char cipher_text[]);
void Encode(char plain_text[], char cipher[]);
void Decode(char cipher_text[], char reverse[]);

// Functions for getting user input.
void GetEntry(char text[]);
void GetCipher(char cipher[], char reverse[]);
void BuildReverseCipher(char cipher[], char reverse[]);
void GetLine(char buffer[]);

// Functions for encoding and decoding.
void DoEncode(char plain_text[], char cipher[]);
void DoDecode(char cipher_text[], char reverse[]);
char ConvertUppercaseToLowercase(char text);
char ConvertLowercaseToUppercase(char text);

int main() {
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

    int has_plain_text = 0;
    int has_cipher_text = 0;
    int has_cipher_and_reverse = 0;

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

        if (option_number == 1) { // If user selects option 1, they will be asked to enter plain text.
            PlainText(plain_text);
            has_plain_text = 1;
        } else if (option_number == 2) { // If user selects option 2, they will be asked to enter a cipher.
            Cipher(cipher, reverse);
            has_cipher_and_reverse = 1;
        } else if (option_number == 3) { // If user selects option 3, they will be asked to enter cipher text.
            CipherText(cipher_text);
            has_cipher_text = 1;
        } else if (option_number == 4) { // If user selects option 4, their plain text will be encoded, as long as they have entered plain text and a cipher.
            if (has_plain_text == 0) {
                cout << endl << "You have not entered plain text. Please enter plain text before encoding." << endl;
            } else if (has_cipher_and_reverse == 0) {
                cout << endl << "You have not entered a cipher or cipher reverse. Please enter a cipher and cipher reverse before encoding." << endl;
            } else if (has_plain_text == 1 && has_cipher_and_reverse == 1) {
                Encode(plain_text, cipher);
            }
        } else if (option_number == 5) { // If user selects option 5, their cipher text will be decoded, as long as they have entered cipher text and a cipher.
            if (has_cipher_text == 0) {
                cout << endl << "You have not entered cipher text. Please enter cipher text before decoding." << endl;
            } else if (has_cipher_and_reverse == 0) {
                cout << endl << "You have not entered a cipher or cipher reverse. Please enter a cipher and cipher reverse before decoding." << endl;
            } else if (has_cipher_text == 1 && has_cipher_and_reverse == 1) {
                Decode(cipher_text, reverse);
            }
        } else if (option_number == 6) { // If user selects option 6, the program will end.
            quit = 1;
        } else {
            cout << endl << "The number you entered did not match any of the options. Please try again." << endl;
        }
    }
}

// Gets user input for plain text.
void PlainText(char plain_text[]) {
    cout << endl << "Enter plain text: ";
    GetEntry(plain_text);
    cout << endl << "Plain text: " << plain_text << endl;
}

// Gets user input for cipher and creates a reverse cipher.
void Cipher(char cipher[], char reverse[]) {
    GetCipher(cipher, reverse);
    cout << endl << "Cipher: " << cipher << endl;
}

// Gets user input for cipher text.
void CipherText(char cipher_text[]) {
    cout << endl << "Enter cipher text: ";
    GetEntry(cipher_text);
    cout << endl << "Cipher text: " << cipher_text << endl;
}

// Encodes plain text using the cipher.
void Encode(char plain_text[], char cipher[]) {
    DoEncode(plain_text, cipher);
    cout << endl << "Encoded text: " << plain_text << endl;
}

// Decodes cipher text using the reverse cipher.
void Decode(char cipher_text[], char reverse[]) {
    DoDecode(cipher_text, reverse);
    cout << endl << "Decoded text: " << cipher_text << endl;
}

// Functions for getting user input.
void GetEntry(char text[]) {
    GetLine(text);
}

// Gets user input for a full line of characters.
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

// Gets user input for cipher and creates a reverse cipher.
void GetCipher(char cipher[], char reverse[]) {
    cout << endl << "Enter cipher: ";
    cin >> cipher;

    int is_valid_answer = 0;

    while (!is_valid_answer) {
        int i;
        int repeat_letters = 0;    

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
        } else if (i == 26 && repeat_letters == 0) {
            is_valid_answer = 1;
        } else {
            cout << endl << "The cipher you entered was invalid. Please try again." << endl;
            cout << endl << "Enter cipher: ";
            cin >> cipher;
        }
    }

    // Creating the reverse cipher.
    BuildReverseCipher(cipher, reverse);
}

// Builds the reverse cipher.
void BuildReverseCipher(char cipher[], char reverse[]) {
    int i;

    for (i = 0; cipher[i] != '\0'; ++i) {
        reverse[cipher[i] - 'a'] = i + 'a';
    }
}

// Encodes plain text using the cipher.
void DoEncode(char plain_text[], char cipher[]) {
    int i;

    for (i = 0; plain_text[i] != '\0'; ++i) {
        if (plain_text[i] >= 'a' && plain_text[i] <= 'z') {
            plain_text[i] = cipher[plain_text[i] - 'a'];
        } else if (plain_text[i] >= 'A' && plain_text[i] <= 'Z') {
            plain_text[i] = ConvertUppercaseToLowercase(plain_text[i]);
            plain_text[i] = cipher[plain_text[i] - 'a'];
            plain_text[i] = ConvertLowercaseToUppercase(plain_text[i]);
        } else {
            plain_text[i] = plain_text[i];
        }
    }
}

// Decodes cipher text using the reverse cipher.
void DoDecode(char cipher_text[], char reverse[]) {
    int i;

    for (i = 0; cipher_text[i] != '\0'; ++i) {
        if (cipher_text[i] >= 'a' && cipher_text[i] <= 'z') {
            cipher_text[i] = reverse[cipher_text[i] - 'a'];
        } else if (cipher_text[i] >= 'A' && cipher_text[i] <= 'Z') {
            cipher_text[i] = ConvertUppercaseToLowercase(cipher_text[i]);
            cipher_text[i] = reverse[cipher_text[i] - 'a'];
            cipher_text[i] = ConvertLowercaseToUppercase(cipher_text[i]);
        } else {
            cipher_text[i] = cipher_text[i];
        }
    }
}

// Converts an uppercase letter to a lowercase letter.
char ConvertUppercaseToLowercase(char text) {
    text = text + 32; // 32 is the difference between uppercase and lowercase letters in ACSII.

    return text;
}

// Converts a lowercase letter to an uppercase letter.
char ConvertLowercaseToUppercase(char text) {
    text = text - 32; // 32 is the difference between uppercase and lowercase letters in ACSII.

    return text;
}