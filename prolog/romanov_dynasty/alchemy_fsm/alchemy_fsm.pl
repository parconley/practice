% Name: Parker Conley
% Date: 04.21.23
% Description: This is a text-based adventure game that uses 
% a finite state machine to control the flow of the game.
% The game is a quest to find the ingredients for a potion
% and then to create the potion.

% assign the state that will start the program
start_state(lab_empty_hands).

% define the edges of the finite state diagram
next_state(lab_empty_hands, a, lab_empty_hands).
next_state(lab_empty_hands, b, painting).
next_state(lab_empty_hands, c, lab_empty_hands).
next_state(lab_empty_hands, d, lab_empty_hands).
next_state(painting, a, lab_empty_hands).
next_state(painting, b, lab_ingredient1).
next_state(lab_ingredient1, a, lab_ingredient1).
next_state(lab_ingredient1, b, potion_table).

% code to be executed at the beginning...
display_intro :-
    write('Welcome to the Alchemist\'s Lab'), nl, nl,
    write('Your task is to create a powerful potion.'), nl,
    write('You need to gather ingredients and then craft the potion.'), nl, nl.

% code to be executed at the end...
goodbye :-
    write('Thank you for playing. Goodbye!'), nl.

% code to be executed upon reaching each state
show_state(lab_empty_hands) :-
    write('You are in the lab with empty hands.'), nl,
    write('What do you want to do?'), nl,
    write('(a) Look around'), nl,
    write('(b) Check behind the painting'), nl,
    write('(c) Try to create a potion without ingredients'), nl,
    write('(d) Leave the lab'), nl,
    write('(q) Quit the program'), nl.
show_state(painting) :-
    write('You find a shelf behind the painting.'), nl,
    write('Do you want to...'), nl,
    write('(a) Put the painting back'), nl,
    write('(b) Take the ingredient from the shelf'), nl,
    write('(q) Quit the program'), nl.
show_state(lab_ingredient1) :-
    write('You are in the lab with the first ingredient.'), nl,
    write('Do you want to...'), nl,
    write('(a) Keep looking for more ingredients'), nl,
    write('(b) Go to the potion table to start crafting'), nl,
    write('(q) Quit the program'), nl.
show_state(potion_table) :-
    write('You successfully crafted the potion!'), nl.

% final states do not display a menu
% - they automatically quit ('q')
get_choice(potion_table, q).

% code to be executed for each choice of action from each state...
show_transition(lab_empty_hands, a) :-
    write('You look around but find nothing of interest.'), nl.
show_transition(lab_empty_hands, b) :-
    write('You approach the painting and lift it off the wall.'), nl.
show_transition(lab_empty_hands, c) :-
    write('You cannot create a potion without ingredients!'), nl.
show_transition(lab_empty_hands, d) :-
    write('You cannot leave the lab until you create the potion.'), nl.
show_transition(painting, a) :-
    write('You put the painting back.'), nl.
show_transition(painting, b) :-
    write('You take the ingredient from the shelf.'), nl.
show_transition(lab_ingredient1, a) :-
    write('You keep looking but find no more ingredients.'), nl.
show_transition(lab_ingredient1, b) :-
    write('You go to the potion table and start craftingthe potion.'), nl.

% basic finite state machine engine
go :-
    intro,
    start_state(X),
    show_state(X),
    get_choice(X,Y),
    go_to_next_state(X,Y).

intro :-
    display_intro,
    clear_stored_answers,
    asserta(stored_answer(moves,0)).

go_to_next_state(_,q) :-
    stored_answer(moves,Count),
    write('You made this many moves...'),
    write(Count), nl,
    goodbye,!.

go_to_next_state(S1,Cin) :-
    next_state(S1,Cin,S2),
    show_transition(S1,Cin),
    show_state(S2),
    stored_answer(moves,K),
    OneMoreMove is K + 1,
    retract(stored_answer(moves,_)),
    asserta(stored_answer(moves,OneMoreMove)),
    get_choice(S2,Cnew),
    go_to_next_state(S2,Cnew).

go_to_next_state(S1,Cin) :-
    + next_state(S1,Cin,_),
    show_transition(S1,fail),
    get_choice(S1,Cnew),
    go_to_next_state(S1,Cnew).

get_choice(_,C) :-
    write('Next entry (letter followed by a period)? '),
    read(C).

% case knowledge base - user responses
:- dynamic(stored_answer/2).

% procedure to get rid of previous responses
% without abolishing the dynamic declaration
clear_stored_answers :-
    retract(stored_answer(,)), fail.
    clear_stored_answers.