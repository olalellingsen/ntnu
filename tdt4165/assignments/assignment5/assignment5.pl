% Task 1

payment(0, []).
payment(Sum, [coin(AmountNeeded, ValueOfCoin, AmountAvailable) | Tail]) :-
    AmountNeeded in 0..AmountAvailable,
    Sum #= ValueOfCoin * AmountNeeded + Rest,
    payment(Rest, Tail).


% ?- payment(25, [coin(Ones,1,11),coin(Fives,5,4),coin(Tens,10,3),coin(Twenties,20,2)]), label([Ones, Fives, Tens, Twenties]).



% Task 2.1

plan(Cabin1, Cabin2, Path, TotalDistance):-
    plan_helper(Cabin1, Cabin2, [Cabin1], Path, 0, TotalDistance).

plan_helper(Cabin2, Cabin2, VisitedCabins, Path, Dist, Dist):-
    reverse(VisitedCabins, Path).

plan_helper(Cabin1, Cabin2, VisitedCabins, Path, AccDist, TotalDist):-
    distance(Cabin1, NextCabin, Dist, 1),         
    NextCabin \= Cabin1,                       
    \+ member(NextCabin, VisitedCabins),                 
    NewDist is AccDist + Dist,
    plan_helper(NextCabin, Cabin2, [NextCabin|VisitedCabins], Path, NewDist, TotalDist).



/* 
?- plan(c1, c2, Path, TotalDistance). Return:

Path = [c1, c2],
TotalDistance = 10
Path = [c1, c4, c2],
TotalDistance = 19
Path = [c1, c5, c2],
TotalDistance = 25

*/



% Task 2.2
bestplan(Cabin1, Cabin2, Path, Dist):-
	findall([Path, TotalDist], plan(Cabin1, Cabin2, Path, TotalDist), Paths),
    find_shortest_path(Paths, [Path, Dist]). 


find_shortest_path([[Path, Dist]], [Path, Dist]).

find_shortest_path([[Path, Dist]|Rest], [BestPath, ShortestDist]) :-
    find_shortest_path(Rest, [CurrentBestPath, CurrentShortestDist]),
    (Dist < CurrentShortestDist ->
        BestPath = Path, ShortestDist = Dist
    ; 
        BestPath = CurrentBestPath, ShortestDist = CurrentShortestDist).


/* 
?- plan(c3, c4, Path, TotalDistance). Return:

Path = [c3, c2, c4],
TotalDistance = 16
Path = [c3, c2, c5, c1, c4],
TotalDistance = 36
Path = [c3, c2, c1, c4],
TotalDistance = 21


?- bestplan(c3, c4, Path, TotalDistance). Return:

Path = [c3, c2, c4],
TotalDistance = 16
*/

