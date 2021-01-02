% ================================================================================================================
%
%+---------------------------------+
%| CS 4337.502 __ Fall 2020        |
%| Professor Davis                 |
%| Project 2 _ prolog              |
%|---------------------------------|
%| Name(Last, First): ZIAEI, ARMIN |
%| netid: AXZ172330                |
%| Date: 11/19/2020                |
%+---------------------------------+
%
% ================================================================================================================
% ================================================================================================================
% 1) Odd Multiple of 3 

% Predicate to check number is odd or not.
checkodd(Q):-
    R is Q mod 2,  % Calculate the remainder.
    R is 1 -> true % If the remainder is 0, return true.
    ;false.        % Otherwise, return false.

% Predicate to check N is a multiple of 3 or not.
checkmultiple(N):-
    R is N mod 3,                   % Calculate the remainder.
    R is 0 -> Q is N/3, checkodd(Q) % If the remainder is 0, check if the quotient is odd or not.
    ;false.                         % Otherwise, return false.

% Predicate to check multiple of 3.
oddMultOf3(N):-
    not(integer(N)) -> 
    print("ERROR: The given parameter is not an integer") % Print the error message if N is not an integer.
    ;checkmultiple(N).

% ================================================================================================================
% 2) List Product

list_prod(list,integer). %predicate
list_prod([],0).         %empty list
list_prod([H],H).        %single element list
list_prod([H|T], Product) :- 
    list_prod(T, Rest), Product is Rest * H. %logic to multiply the elements
  
% ================================================================================================================
% 3) Palindrome

palindrome(L):- 
    palindrome(L,L). % check if reverse is equal then palindrome

palindrome(L,R):- 
    myrev(L,R,[]).   % reverse in R

myrev([],R,R).
myrev([X|L],R,Acc):- 
    myrev(L,R,[X|Acc]).

% ================================================================================================================
% 4) Second Minimum

% Predicate to find length of a list.
len([],0).
len([_|L],R):-
    len(L,R1),
    R is R1+1.

% Predicate to check the list.
checklist([]):-
    true. 

checklist([H|L]):-
    not(number(H))-> print("Error: "),print(H),print(" is not a number."),false % Print error the element is not a number.
    ;checklist(L).

% Predicate to find to find minimum of first 2 numbers of the list.
findmin([],[]).
findmin([_,H2|_],M2):-
    M2 is H2.          % Set the second minimum value.

% Predicate to find the second minimum.
secondMin(List, M2):-
    sort(List,List2),  % Sort the list and remove duplicates.
    len(List2,L),      % Calculate the size of the list.
    L < 2 -> print("ERROR: List has fewer than two unique elements.") % Print error if the size of the list is less than 2.
    ;checklist(List)-> % Otherwise, check the elements of the list.
    sort(List,List2),  % Sort the list and find the minimum.
    findmin(List2,M2),!;!.

% ================================================================================================================
% 5) Classify

classify([], [], []). %if input list empty then predicate return empty list.
classify(List, Even, Odd) :-
    [X|Xs]=List,
    0 is X mod 2,(Even=[X|Even1],
    classify(Xs, Even1, Odd)).

classify(List, Even, Odd) :-
    [X|Xs]=List,
    1 is X mod 2,(Odd=[X|Odd1],
    classify(Xs, Even, Odd1)).

% ================================================================================================================
% 6) Bookends 

bookends(Prefix,Suffix,AList):- 
    prefix(Prefix,AList), suffix(Suffix,AList).

prefix([],_):- !.
prefix([AP|BP],[AL|BL]):- 
    AP == AL,prefix(BP,BL).

suffix(L,L):- !.
suffix(S,[_|B1]):- 
    suffix(S,B1),!.

% ================================================================================================================
% 7) Subslice 

subslice([],_):- !.
subslice(Sub,[H|T]):- 
    prefix(Sub,[H|T]),!
    ;subslice(Sub,T).

% ================================================================================================================
% 8) Shift

% Predicate to find the reverse of a list.
rev([],L2,L2).
rev([H|T],L2,R):-
    rev(T,[H|L2],R).

% Predicate to find the reverse of a list.
rev(L,R):-
    rev(L,[],R).

% Predicate to find length of a list.
lensh([],0).
lensh([_|T],R):-
    lensh(T,R1),
    R is R1+1.

% Predicate to concatenate 2 lists.
conc([],L2,L2).
conc([H1|T1],L2,[H1|T3]):-
    conc(T1,L2,T3).

% Predicate to create a sublist of size N.
sublist(L,0,L).
sublist([_|T],N,X):-
    N2 is N-1,
    sublist(T,N2,X),!.

% Predicate to shift the N places to left.
shiftleft(List,N,Shifted):-
    lensh(List,L),                 % Calculate the length of the list.
    rev(List,First),               % Reverse the list.
    sublist(First,L-N,First_rev),  % Create a sublist of first L-N elements of the list.
    sublist(List,N,Second),        % Create a sublist of last N elements of the list.
    rev(Second,Second_rev),        % Reverse the second part of the list.
    conc(First_rev,Second_rev,R1), % Concatenate the first and second part of the list.
    rev(R1,Shifted).               % Reverse the list and store as the result.

% Predicate to shift the N places to right.
shiftright(List,N,Shifted):-
    lensh(List,L),                 % Calculate the length of the list.
    rev(List,First),               % Reverse the list.
    sublist(First,N,First_rev),    % Create a sublist of first N elements of the list.
    sublist(List,L-N,Second),      % Create a sublist of last L-N elements of the list.
    rev(Second,Second_rev),        % Reverse the second part of the list.
    conc(First_rev,Second_rev,R1), % Concatenate the first and second part of the list.
    rev(R1,Shifted).               % Reverse the list and store in R.

% Predicate to shift the list.
shift(List,N,Shifted):-
    N < 0-> N1 is (-1*N),shiftright(List,N1,Shifted) % Call shiftleft() if N is negative.
    ;shiftleft(List,N,Shifted).                      % Otherwise, call shiftright().

% ================================================================================================================
% 9) Luhn Algorithm 

sum2(Num,Result):-
    N1 is mod(Num,10),
    N2 is div(Num,10),
    Result is N1+N2,!.

sum(Num,Result):-
    N1 is mod(Num,10),
    N2 is div(Num,10),
    N3 is N2*2,
    N3>9 -> sum2(N3,X),Result is X+N1,!;
    N1 is mod(Num,10),
    N2 is div(Num,10),
    N3 is N2*2,
    Result is N1+N3,!.

digitsum(0,Sum,Result):-
    Result is Sum,!.

digitsum(N,Sum,Result):-
    Rem is mod(N,100),
    Ques is div(N,100),
    sum(Rem,S2),
    NewSum is Sum+S2,
    digitsum(Ques,NewSum,Result),!.

luhn(Num):-
    digitsum(Num,0,Result),
    Rem is mod(Result,10),
    Rem = 0.

% ================================================================================================================
% 10) Graph

edge(a,b).
edge(b,c).
edge(c,d).
edge(d,e).
edge(d,a).

path(Z,Z).
path(Node1,Node2):-
    edge(Node1,A),path(A,Node2),!.

cycle(Node):- 
    edge(Node,X),path(X,Node),!.

% ================================================================================================================