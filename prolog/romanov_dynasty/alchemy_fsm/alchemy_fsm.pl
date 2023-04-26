% Name: Parker Conley
% Date: 04.21.23
% Description: This is a text-based adventure game that uses 
% a finite state machine to control the flow of the game.
% The game is a quest to find the ingredients for a potion
% and then to create the potion.

% assign the state that will start the program
start_state(exploration).

% Define the edges of the finite state diagram
next_state(exploration, a, bookshelf).
next_state(exploration, b, table).
next_state(exploration, c, painting).

next_state(bookshelf, a, exploration).
next_state(bookshelf, b, recipe_found).

next_state(table, a, exploration).
next_state(painting, a, exploration).
next_state(recipe_found, a, ingredient_gathering).

next_state(ingredient_gathering, a, cabinets).
next_state(ingredient_gathering, b, under_table).
next_state(ingredient_gathering, c, hidden_compartment).
next_state(ingredient_gathering, d, optional_puzzle).

next_state(cabinets, a, ingredient_gathering).
next_state(cabinets, b, ingredient_a_found).
next_state(under_table, a, ingredient_gathering).
next_state(hidden_compartment, a, ingredient_gathering).
next_state(hidden_compartment, b, ingredient_b_found).
next_state(optional_puzzle, a, ingredient_gathering).
next_state(optional_puzzle, b, sovle_puzzle).

next_state(ingredient_a_found, a, potion_crafting).
next_state(ingredient_a_found, b, ingredient_gathering)

next_state(ingredient_b_found, a, potion_crafting).
next_state(ingredient_b_found, b, ingredient_gathering).

next_state(ingredient_c_found, a, potion_crafting).
next_state(ingredient_c_found, b, ingredient_gathering).

next_state(potion_crafting, a, correct_order).
next_state(potion_crafting, b, incorrect_order).
next_state(correct_order, a, success).
next_state(correct_order, b, failure).
next_state(incorrect_order, a, potion_crafting).
next_state(incorrect_order, b, failure).
next_state(success, a, positive_outcome).
next_state(failure, a, negative_outcome).

% Code to be executed at the beginning...
display_intro :-
    write('Welcome to the Alchemist''s Lab!'), nl,
    write('You are a novice alchemist, tasked with preparing a potion to cure'), nl,
    write('the village elder who has fallen gravely ill.'), nl,
    write('Explore the lab, gather the necessary ingredients,'), nl,
    write('and follow a recipe to create the potion.'), nl.

initialize :-
    asserta(stored_answer(ingredient_a, no)),
    asserta(stored_answer(ingredient_b, no)),
    asserta(stored_answer(ingredient_c, no)),
    asserta(total_ingredients(0)).

% code to be executed at the end...
goodbye :-
    write('Thank you for playing. Goodbye!'), nl.

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
    write('Nothing behind the painting.'), nl,
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
    write('(c) Check the hidden compartment in the bookshelf'), nl,
    write('(d) Solve the optional puzzle to open the safe'), nl,
    write('(q) Quit the program'), nl.

show_state(cabinets) :-
    write('Found ingredient A!'), nl,
    write('Do you want to...'), nl,
    write('(a) Go back to Ingredient Gathering'), nl.
    write('(q) Quit the program'), nl.

show_state(under_table) :-
    write('Just some dust.'), nl,
    write('Go back to Ingredient Gathering...'), nl.

show_state(hidden_compartment) :-
    write('Found ingredient B!'), nl,
    write('Go back to Ingredient Gathering...'), nl.

show_state(optional_puzzle) :-
    write('You found a safe!'), nl,
    write('Do you want to...'), nl,
    write('(a) Go back to Ingredient Gathering'), nl,
    write('(b) Solve the optional puzzle'), nl,
    write('(q) Quit the program'), nl.
    
show_state(ingredient_a_found) :-
    write('You found ingredient A! Proceed to Potion Crafting'), nl,
    write('Do you want to...'), nl,
    write('(a) Proceed to Potion Crafting'), nl,
    write('(b) Continue searching for ingredients'), nl,
    write('(q) Quit the program'), nl.
show_state(ingredient_b_found) :-
    write('You found ingredient B! Proceed to Potion Crafting'), nl,
    write('Do you want to...'), nl,
    write('(a) Proceed to Potion Crafting'), nl,
    write('(b) Continue searching for ingredients'), nl,
    write('(q) Quit the program'), nl.
show_state(ingredient_c_found) :-
    write('You found ingredient C! Proceed to Potion Crafting'), nl,
    write('Do you want to...'), nl,
    write('(a) Proceed to Potion Crafting'), nl,
    write('(b) Continue searching for ingredients'), nl,
    write('(q) Quit the program'), nl.

% Potion Crafting
show_state(potion_crafting) :-
    write('Follow the recipe to create the potion.'), nl,
    write('You need to mix the ingredients in the right order and measure the right amounts.'), nl,
    write('Choose an action:'), nl,
    write('(a) Mix ingredients in the correct order'), nl,
    write('(b) Mix ingredients in the wrong order'), nl,
    write('(q) Quit the program'), nl.
show_state(correct_order) :-
    write('Success!'), nl,
    write('Do you want to...'), nl,
    write('(a) Measure and input the correct amounts for each ingredient'), nl,
    write('(b) Measure and input the wrong amounts for each ingredient'), nl,
    write('(q) Quit the program'), nl.
show_state(incorrect_order) :-
    write('Failure!'), nl,
    write('Do you want to...'), nl,
    write('(a) Try mixing the ingredients again'), nl,
    write('(b) Measure and input the wrong amounts for each ingredient'), nl,
    write('(q) Quit the program'), nl.
show_state(success) :-
    write('You successfully created the potion!'), nl,
    write('Do you want to...'), nl,
    write('(a) Proceed to the Positive Outcome'), nl,
    write('(q) Quit the program'), nl.
show_state(failure) :-
    write('You failed to create the potion!'), nl,
    write('Do you want to...'), nl,
    write('(a) Proceed to the Negative Outcome'), nl,
    write('(q) Quit the program'), nl.
show_state(positive_outcome) :-
    write('Congratulations! You successfully created the potion and saved the village elder.'), nl,
    write('Your alchemy skills have brought you fame and respect in the village.'), nl,
    write('Thank you for playing the Alchemist''s Lab quest!'), nl.
show_state(negative_outcome) :-
    write('Unfortunately, you failed to create the potion in time, and the village elder has passed away.'), nl,
    write('You are devastated, but you vow to continue your studies and become a better alchemist.'), nl,
    write('Thank you for playing the Alchemist''s Lab quest!'), nl.

% final states do not display a menu
% - they automatically quit ('q')
get_choice(positive_outcome, q).
get_choice(negative_outcome, q).

% Code to be executed for each choice of action from each state...
% Exploration
show_transition(exploration, a) :-
    write('You decide to search the bookshelf.'), nl.

show_transition(exploration, b) :-
    write('You decide to examine the table.'), nl.

show_transition(exploration, c) :-
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
    write('You proceed to the Ingredient Gathering stage.'), nl,

% Ingredient Gathering
show_transition(ingredient_gathering, a) :-
    write('You decide to search the cabinets.'), nl.

show_transition(ingredient_gathering, b) :-
    write('You decide to look under the table.'), nl.

show_transition(ingredient_gathering, c) :-
    write('You decide to check the hidden compartment in the bookshelf.'), nl.

show_transition(ingredient_gathering, d) :-
    write('You decide to solve the optional puzzle to open the safe.'), nl.

show_transition(cabinets, a) :-
    write('You decide to go back to Ingredient Gathering.'), nl.

show_transition(under_table, a) :-
    write('You decide to go back to Ingredient Gathering.'), nl.

show_transition(hidden_compartment, a) :-
    write('You decide to go back to Ingredient Gathering.'), nl.

show_transition(optional_puzzle, a) :-
    write('You decide to go back to Ingredient Gathering.'), nl.

show_transition(ingredient_a_found, a) :-
    write('You proceed to the Potion Crafting stage.'), nl.

show_transition(ingredient_b_found, a) :-
    write('You proceed to the Potion Crafting stage.'), nl.

show_transition(ingredient_c_found, a) :-
    write('You proceed to the Potion Crafting stage.'), nl.

% Potion Crafting
show_transition(potion_crafting, a) :-
    write('You decide to mix the ingredients in the correct order.'), nl.
show_transition(potion_crafting, b) :-
    write('You decide to mix the ingredients in the wrong order.'), nl.
show_transition(correct_order, a) :-
    write('You measure and input the correct amounts for each ingredient.'), nl.
show_transition(correct_order, b) :-
    write('You measure and input the wrong amounts for each ingredient.'), nl.
show_transition(incorrect_order, a) :-
    write('You decide to try mixing the ingredients again.'), nl.
show_transition(incorrect_order, b) :-
    write('You decide to measure and input the wrong amounts for each ingredient.'), nl.
show_transition(success, a) :-
    write('You proceed to the Positive Outcome.'), nl.
show_transition(failure, a) :-
    write('You proceed to the Negative Outcome.'), nl.
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
    write('followed by a period )? '),
    read(C).

% case knowledge base - user responses
:- dynamic(stored_answer/2).

% procedure to get rid of previous responses
% without abolishing the dynamic declaration
clear_stored_answers
    :- retract(stored_answer(_,_)),fail.
clear_stored_answers.
