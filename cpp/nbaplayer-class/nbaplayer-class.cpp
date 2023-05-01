// Name: Parker Conley
// Date: 05.01.23
// Description: This program demonstrates the use of classes
// and dynamic memory allocation using the NBAPlayer class.

#include <iostream>
using namespace std;

int strlen(char *s);
void strcpy(char *dest, char *source);

class NBAPlayer {
    char *_name;
    char *_team;
    int _gamesPlayed;
    int _totalPoints;

public:
    NBAPlayer(char *name, char *team);
    ~NBAPlayer();
    void displaySummary();
    char *getName();
    char *getTeam();
    double computeAveragePointsPerGame();
    void updatePoints(int points);
    void setTeam(char *newTeam);
};

// Constructor
NBAPlayer::NBAPlayer(char *name, char *team) {
    _name = new char[strlen(name) + 1];
    strcpy(_name, name);

    _team = new char[strlen(team) + 1];
    strcpy(_team, team);

    _gamesPlayed = 0;
    _totalPoints = 0;
}

// Destructor
NBAPlayer::~NBAPlayer() {
    delete[] _name;
    delete[] _team;
}

// Display player summary
void NBAPlayer::displaySummary() {
    cout << "Name: " << _name << endl;
    cout << "Team: " << _team << endl;
    cout << "Games Played: " << _gamesPlayed << endl;
    cout << "Total Points: " << _totalPoints << endl;
}

// Getters and setters
char *NBAPlayer::getName() {
    char *name = new char[strlen(_name) + 1];
    strcpy(name, _name);
    return name;
}

char *NBAPlayer::getTeam() {
    char *team = new char[strlen(_team) + 1];
    strcpy(team, _team);
    return team;
}

double NBAPlayer::computeAveragePointsPerGame() {
    return _totalPoints / _gamesPlayed;
}

void NBAPlayer::updatePoints(int points) {
    _gamesPlayed++;
    _totalPoints += points;
}

void NBAPlayer::setTeam(char *newTeam) {
    delete[] _team;
    _team = new char[strlen(newTeam) + 1];
    strcpy(_team, newTeam);
}

int main() {
    NBAPlayer lebron("LeBron James", "Cavaliers");
    lebron.displaySummary();
    lebron.updatePoints(42);
    lebron.updatePoints(39);
    cout << "Average points per game: " << lebron.computeAveragePointsPerGame() << endl;
    cout << "Team: " << lebron.getTeam() << endl;
    lebron.setTeam("Lakers");
    lebron.displaySummary();

    NBAPlayer *booker = new NBAPlayer("Devin Booker", "Suns");
    booker->updatePoints(70);
    booker->updatePoints(41);
    cout << "Average points per game: " << booker->computeAveragePointsPerGame() << endl;
    booker->displaySummary();
    delete booker;
}

// strlen - return the length of a string

int strlen(char *s)
{
    char *start;
    start = s;
    while ( *s != '\0' ) ++s;
    return (s - start);
}

// strcpy - copy the source string
// to the destination

void strcpy(char *dest, char *source) {
    while (*source != '\0')
    {
        *dest = *source;
        ++dest; ++source;
    }
    *dest = '\0';
}