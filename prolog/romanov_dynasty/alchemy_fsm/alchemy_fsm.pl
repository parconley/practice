% Name: Parker Conley
% Date: 04.21.23
% Description: This is a text-based adventure game that uses 
% a finite state machine to control the flow of the game.
% The game is a quest to find the ingredients for a potion
% and then to create the potion.

% A paragraph or two describing what the user's task will be:
% The user is a novice alchemist who has been tasked with creating
% a potion to cure the village elder who has fallen gravely ill.
% The user must explore the alchemist's lab to find a recipe and
% three ingredients. Once the user has found the recipe and the
% three ingredients, the user must follow the recipe to create
% the potion. There are also two *GOLD COINS* hidden in the lab
% that the user can find.


% assign the state that will start the program
start_state(exploration).

% Define the edges of the finite state diagram
% Exploration
next_state(exploration, a, bookshelf).
next_state(exploration, b, table).
next_state(exploration, c, painting).

next_state(bookshelf, a, exploration).
next_state(bookshelf, b, recipe_found).

next_state(table, a, exploration).
next_state(painting, a, exploration).
next_state(recipe_found, a, ingredient_gathering).

% Ingredient Gathering
next_state(ingredient_gathering, a, cabinets).
next_state(ingredient_gathering, b, under_table).
next_state(ingredient_gathering, c, chest).
next_state(ingredient_gathering, d, locked_safe).
next_state(ingredient_gathering, e, potion_crafting).

next_state(cabinets, a, ingredient_gathering).

next_state(under_table, a, ingredient_gathering).
next_state(under_table, b, trap_door).
next_state(under_table, c, paper).

next_state(trap_door, a, ingredient_gathering).
next_state(trap_door, b, hole).

next_state(paper, a, ingredient_gathering).

next_state(chest, a, ingredient_gathering).

next_state(locked_safe, a, ingredient_gathering).
next_state(locked_safe, b, lock_1).
next_state(lock_1, _, lock_2).
next_state(lock_2, _, lock_3).
next_state(lock_3, _, ingredient_gathering).

% Potion Crafting
next_state(potion_crafting, a, end).
next_state(potion_crafting, b, end).

% Code to be executed at the beginning...
display_intro :-
    write('Welcome to the Alchemist''s Lab!'), nl,
    write('You are a novice alchemist, tasked with preparing a potion to cure'), nl,
    write('the village elder who has fallen gravely ill.'), nl,
    write('Explore the lab, gather the necessary ingredients,'), nl,
    write('and follow a recipe to create the potion.'), nl.

initialize :-
    asserta(stored_answer(gold_coins, 0)),
    asserta(stored_answer(gold_coin_1, no)),
    asserta(stored_answer(gold_coin_2, no)),
    asserta(stored_answer(ingredient_a, no)),
    asserta(stored_answer(ingredient_b, no)),
    asserta(stored_answer(ingredient_c, no)),
    asserta(stored_answer(lock_answer_1, no)),
    asserta(stored_answer(lock_answer_2, no)),
    asserta(stored_answer(lock_answer_3, no)).

% code to be executed at the end...
goodbye :-
    write('You have acumulated '),
    stored_answer(gold_coins, Amount),
    write(Amount),
    write('/2 *GOLD COINS*. Nice.'), nl,  
    write('Goodbye!'), nl.

% Code to be executed upon reaching each state
% Exploration
show_state(exploration) :-
    write('You are in the alchemist''s lab.'), nl,
    write('You need to find a recipe and three ingredients to make the potion.'), nl,
    write('First, you need to explore the lab to find the recipe.'), nl,
    write('Choose an area to search:'), nl,
    write('(a) Search the bookshelf'), nl,
    write('(b) Examine the table'), nl,
    write('(c) Look behind the painting'), nl,
    write('(q) Quit the program'), nl.

show_state(bookshelf) :-
    write('You found a hidden compartment!'), nl,
    write('Do you want to...'), nl,
    write('(a) Go back to exploring'), nl,
    write('(b) Open the hidden compartment'), nl,
    write('(q) Quit the program'), nl.

show_state(table) :-
    write('Just some alchemy tools.'), nl,
    write('Do you want to...'), nl,
    write('(a) Go back to exploring'), nl,
    write('(q) Quit the program'), nl.

show_state(painting) :-
    write('You found a *GOLD COIN* behind the painting!'), nl,
    write('Do you want to...'), nl,
    write('(a) Go back to exploring'), nl,
    write('(q) Quit the program'), nl.

show_state(recipe_found) :-
    write('You found the recipe!'), nl,
    write('Do you want to...'), nl,
    write('(a) Proceed to Ingredient Gathering'), nl,
    write('(q) Quit the program'), nl.

% Ingredient Gathering
show_state(ingredient_gathering) :-
    write('You have the recipe. You need to find the following ingredients: A, B, and C.'), nl,
    write('Choose a location:'), nl,
    write('(a) Search the cabinets'), nl,
    write('(b) Look under the table'), nl,
    write('(c) Check the chest at the end of the bed'), nl,
    write('(d) Open the safe'), nl,
    write('(e) Proceed to Potion Crafting'), nl,
    write('(q) Quit the program'), nl.

show_state(cabinets) :-
    write('Found ingredient A!'), nl,
    write('Do you want to...'), nl,
    write('(a) Go back to Ingredient Gathering'), nl,
    write('(q) Quit the program'), nl.

show_state(under_table) :-
    write('There is a trap door and a piece of paper.'), nl,
    write('Do you want to...'), nl,
    write('(a) Go back to Ingredient Gathering'), nl,
    write('(b) Open the trap door'), nl,
    write('(c) Read the piece of paper'), nl,
    write('(q) Quit the program'), nl.

show_state(trap_door) :-
    write('Under the trap door is a deep deep hole. It smells like dead bodies.'), nl,
    write('Do you want to...'), nl,
    write('(a) Go back to Ingredient Gathering'), nl,
    write('(b) Jump into the hole'), nl,
    write('(q) Quit the program'), nl.

show_state(paper) :-
    write('The paper says:'), nl,
    write('The first number is 2.'), nl,
    write('The second number is 7.'), nl,
    write('The third number is 4.'), nl,
    write('Do you want to...'), nl,
    write('(a) Go back to Ingredient Gathering'), nl,
    write('(q) Quit the program'), nl.

show_state(chest) :-
    write('Found ingredient B and a *GOLD COIN* in the chest!'), nl,
    write('Do you want to...'), nl,
    write('(a) Go back to Ingredient Gathering'), nl,
    write('(q) Quit the program'), nl.

show_state(locked_safe) :-
    write('You found a safe! Unfortunately, it''s locked.'), nl,
    write('Do you want to...'), nl,
    write('(a) Go back to Ingredient Gathering'), nl,
    write('(b) Unlock the safe'), nl,
    write('(q) Quit the program'), nl.

show_state(lock_1) :-
    write('The lock has three dials, each with the numbers 0-9.'), nl,
    write('Choose a number for the first dial:'), nl,
    write('(a) 0'), nl,
    write('(b) 1'), nl,
    write('(c) 2'), nl,
    write('(d) 3'), nl,
    write('(e) 4'), nl,
    write('(f) 5'), nl,
    write('(g) 6'), nl,
    write('(h) 7'), nl,
    write('(i) 8'), nl,
    write('(j) 9'), nl.

show_state(lock_2) :-
    write('Choose a number for the second dial:'), nl,
    write('(a) 0'), nl,
    write('(b) 1'), nl,
    write('(c) 2'), nl,
    write('(d) 3'), nl,
    write('(e) 4'), nl,
    write('(f) 5'), nl,
    write('(g) 6'), nl,
    write('(h) 7'), nl,
    write('(i) 8'), nl,
    write('(j) 9'), nl.

show_state(lock_3) :-
    write('Choose a number for the third dial:'), nl,
    write('(a) 0'), nl,
    write('(b) 1'), nl,
    write('(c) 2'), nl,
    write('(d) 3'), nl,
    write('(e) 4'), nl,
    write('(f) 5'), nl,
    write('(g) 6'), nl,
    write('(h) 7'), nl,
    write('(i) 8'), nl,
    write('(j) 9'), nl.

% Potion Crafting
show_state(potion_crafting) :-
    write('To craft the potion, you need to mix the ingredients in the correct order.'), nl,
    write('Choose an action:'), nl,
    write('(a) Mix ingredients in the correct order'), nl,
    write('(b) Mix ingredients in the wrong order'), nl,
    write('(q) Quit the program'), nl.

show_state(end) :-
    write('Choose an action:'), nl,
    write('(q) Receive final score'), nl.

% final states do not display a menu
% - they automatically quit ('q')
show_state(hole) :-
    write('You fell into the hole and died. RIP.'), nl,
    write('Without your help, the village elder passed away.'), nl,
    write('The village is now in ruins.'), nl,
    write('Sucks to suck.'), nl,
    write('Thank you for playing the Alchemist''s Lab quest!'), nl.

show_state(positive_outcome) :-
    write('Congratulations! You successfully created the potion and saved the village elder.'), nl,
    write('Your alchemy skills have brought you fame and respect in the village.'), nl,
    write('Thank you for playing the Alchemist''s Lab quest!'), nl.

show_state(negative_outcome) :-
    write('Unfortunately, you failed to create the potion, and the village elder has passed away.'), nl,
    write('You are devastated, but you vow to continue your studies and become a better alchemist.'), nl,
    write('Thank you for playing the Alchemist''s Lab quest!'), nl.

get_choice(hole, q).
get_choice(positive_outcome, q).
get_choice(negative_outcome, q).

% Code to be executed for each choice of action from each state...
% Exploration
show_transition(exploration, a) :-
    write('You decide to search the bookshelf.'), nl.

show_transition(exploration, b) :-
    write('You decide to examine the table.'), nl.

show_transition(exploration, c) :-
    stored_answer(gold_coin_1, no),
    stored_answer(gold_coins, Amount),
    NewAmount is Amount + 1,
    retract(stored_answer(gold_coins, _)),
    asserta(stored_answer(gold_coins, NewAmount)),
    retract(stored_answer(gold_coin_1, no)),
    asserta(stored_answer(gold_coin_1, yes)),
    write('You decide to look behind the painting.'), nl.

show_transition(exploration, c) :-
    stored_answer(gold_coin_1, yes),
    write('You decide to look behind the painting.'), nl.

show_transition(bookshelf, a) :-
    write('You decide to go back to exploring.'), nl.

show_transition(bookshelf, b) :-
    write('You decide to open the hidden compartment.'), nl.

show_transition(table, a) :-
    write('You decide to go back to exploring.'), nl.

show_transition(painting, a) :-
    write('You decide to go back to exploring.'), nl.

show_transition(recipe_found, a) :-
    write('You proceed to the Ingredient Gathering stage.'), nl.

% Ingredient Gathering
show_transition(ingredient_gathering, a) :-
    retract(stored_answer(ingredient_a, _)),
    asserta(stored_answer(ingredient_a, yes)),
    write('You decide to search the cabinets.'), nl.

show_transition(ingredient_gathering, b) :-
    write('You decide to look under the table.'), nl.

show_transition(ingredient_gathering, c) :-
    stored_answer(gold_coin_2, no),
    stored_answer(gold_coins, Amount),
    NewAmount is Amount + 1,
    retract(stored_answer(gold_coins, _)),
    asserta(stored_answer(gold_coins, NewAmount)),
    retract(stored_answer(gold_coin_2, no)),
    asserta(stored_answer(gold_coin_2, yes)),
    retract(stored_answer(ingredient_b, _)),
    asserta(stored_answer(ingredient_b, yes)),
    write('You decide to open the chest.'), nl.

show_transition(ingredient_gathering, c) :-
    stored_answer(gold_coin_2, yes),
    retract(stored_answer(ingredient_b, _)),
    asserta(stored_answer(ingredient_b, yes)),
    write('You decide to open the chest.'), nl.

show_transition(ingredient_gathering, d) :-
    write('You decide to look at the safe.'), nl,
    retract(stored_answer(lock_answer_1, _)),
    asserta(stored_answer(lock_answer_1, no)),
    retract(stored_answer(lock_answer_2, _)),
    asserta(stored_answer(lock_answer_2, no)),
    retract(stored_answer(lock_answer_3, _)),
    asserta(stored_answer(lock_answer_3, no)).

show_transition(ingredient_gathering, e) :-
    stored_answer(ingredient_a, yes),
    stored_answer(ingredient_b, yes),
    stored_answer(ingredient_c, yes),
    write('You decide to procede to Potion Crafting.'), nl.

show_transition(ingredient_gathering, e) :-
    (stored_answer(ingredient_a, no); stored_answer(ingredient_b, no); stored_answer(ingredient_c, no)),
    write('Unfortunately, you are missing some ingredients!'), nl,
    write('You decide to procede to Potion Crafting anyway.'), nl,
    write('There''s no going back now.'), nl.

show_transition(cabinets, a) :-
    write('You decide to go back to Ingredient Gathering.'), nl.

show_transition(under_table, a) :-
    write('You decide to go back to Ingredient Gathering.'), nl.

show_transition(under_table, b) :-
    write('You decide to open the trapdoor.'), nl.

show_transition(under_table, c) :-
    write('You decide to look at the paper.'), nl.

show_transition(trap_door, a) :-
    write('You decide to go back to Ingredient Gathering.'), nl.

show_transition(trap_door, b) :-
    write('You decide to jump down the trapdoor.'), nl.

show_transition(paper, a) :-
    write('You decide to go back to Ingredient Gathering.'), nl.

show_transition(chest, a) :-
    write('You decide to go back to Ingredient Gathering.'), nl,
    retract(stored_answer(ingredient_b, _)),
    asserta(stored_answer(ingredient_b, yes)).

show_transition(locked_safe, a) :-
    write('You decide to go back to Ingredient Gathering.'), nl.

show_transition(locked_safe, b) :-
    write('You decide to try to open the safe.'), nl.

show_transition(lock_1, c) :-
    write('You enter the first number correctly.'), nl,
    retract(stored_answer(lock_answer_1, no)),
    asserta(stored_answer(lock_answer_1, yes)).

show_transition(lock_1, _) :-
    stored_answer(lock_answer_1, no),
    write('You enter the first number incorrectly.'), nl.

show_transition(lock_2, h) :-
    write('You enter the second number correctly.'), nl,
    retract(stored_answer(lock_answer_2, no)),
    asserta(stored_answer(lock_answer_2, yes)).

show_transition(lock_2, _) :-
    stored_answer(lock_answer_2, no),
    write('You enter the second number incorrectly.'), nl.

show_transition(lock_3, e) :-
    stored_answer(lock_answer_1, yes),
    stored_answer(lock_answer_2, yes),
    write('You entered all three numbers correctly!'), nl,
    write('You open the safe and find ingredient C!'), nl,
    write('You return to Ingredient Gathering.'), nl,
    retract(stored_answer(ingredient_c, _)),
    asserta(stored_answer(ingredient_c, yes)),
    retract(stored_answer(lock_answer_3, no)),
    asserta(stored_answer(lock_answer_3, yes)).

show_transition(lock_3, e) :-
    (stored_answer(lock_answer_1, no); stored_answer(lock_answer_2, no)),
    write('You enter the third number correctly,'), nl,
    write('but you missed one of the previous numbers.'), nl,
    write('You return to Ingredient Gathering.'), nl.
    retract(stored_answer(lock_answer_3, no)),
    asserta(stored_answer(lock_answer_3, yes)).

show_transition(lock_3, _) :-
    (stored_answer(lock_answer_1, no); stored_answer(lock_answer_2, no)),
    stored_answer(lock_answer_3, no),
    write('You enter the third number incorrectly.'), nl,
    write('You return to Ingredient Gathering.'), nl.

% Potion Crafting
show_transition(potion_crafting, a) :-
    stored_answer(ingredient_a, yes),
    stored_answer(ingredient_b, yes),
    stored_answer(ingredient_c, yes),
    write('You decide to mix the ingredients in the correct order.'), nl,
    show_state(positive_outcome).

show_transition(potion_crafting, a) :-
    (stored_answer(ingredient_a, no); stored_answer(ingredient_b, no); stored_answer(ingredient_c, no)),
    write('You decide to mix the ingredients in the correct order.'), nl,
    write('You are missing some ingredients!'), nl,
    show_state(negative_outcome).

show_transition(potion_crafting, b) :-
    write('You decide to mix the ingredients in the wrong order.'), nl,
    show_state(negative_outcome).

show_transition(_, fail) :-
    write('Invalid choice. Please try again.'), nl.

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
    initialize,
    asserta(stored_answer(moves,0)).

go_to_next_state(_,q) :-
    stored_answer(moves,Count),
    write( 'You made this many moves...' ),
    write( Count ), nl,
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
    \+ next_state(S1,Cin,_),
    show_transition(S1,fail),
    get_choice(S1,Cnew),
    go_to_next_state(S1,Cnew).

get_choice(_,C) :-
    write('Next entry (letter '),
    write('followed by a period)? '),
    read(C).

% case knowledge base - user responses
:- dynamic(stored_answer/2).

% procedure to get rid of previous responses
% without abolishing the dynamic declaration
clear_stored_answers
    :- retract(stored_answer(_,_)),fail.
clear_stored_answers.