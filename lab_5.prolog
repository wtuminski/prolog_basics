/*
13)
    Proszę zdefiniować predykat route(Place1,Place2,Day,Route), który zrealizuje planowanie lotów na podstawie rozkładu jazdy.
    Rozkład jazdy jest podane przez predykat timetable(Place1,Place2,List_of_flights), gdzie List_of_Flights jest listą lotów od Place1 do Place2. Każdy lot jest listą [Departure_time,Arrival_time,Flight_number,List_of_days].
    Przykład:

        timetable( london, edinburgh,
                    [ [ 9:40, 10:50, ba4733, alldays],
                    [19:40, 20:50, ba4833, [mo,tu,we,th,fr]] ]).
        

    Plan lotów Route jest listą lotów PlaceA-PlaceB:Flight_number:Departure_time, taka że

        PlaceA w pierwszym elemencie w liście, to Place1.
        PlaceB w ostatnim elemencie w liście, to Place2.
        wszystkie loty odbędą się w tym samym dniu.
        między lotami jest wystarczający czas na transfer. 


    Przykład:

        ?- route(ljubljana,edinburgh,th,R).
        R = [ljubljana-zurich:yu322:11:30, zurich-london:sr806:16:10, london-edinburgh:ba4822:18:40].
*/

timetable(edinburgh, london,
    [ 
        [ 9:40, 10:50, ba4733, alldays],
        [13:40, 14:50, ba4773, alldays],
        [19:40, 20:50, ba4833, [mo, tu, we, th, fr, su]] 
    ]
).
timetable(london, edinburgh,
    [ 
        [ 9:40, 10:50, ba4732, alldays],
        [13:40, 14:50, ba4752, alldays],
        [18:40, 19:50, ba4822, [mo, tu, we, th, fr]] 
    ]
).
timetable(london, ljubljana,
    [ 
        [13:20, 16:20, ju201, [fr]],
        [13:20, 16:20, ju213, [su]] 
    ]
).
timetable(ljubljana, zurich,
    [ 
        [11:30, 12:40, ju322, [tu, th]] 
    ]
).
timetable(zurich, london,
    [ 
        [ 9:10, 9:40, ba613, [mo, tu,we, th, fr,sa]],
        [16:10, 16:55, sr806, [mo, th,we,th, fr, su]] 
    ]
).

deptime([_-_:_:Dep|_],Dep).

transfer(H1:M1,H2:M2) :- 60 * (H2-H1) + M2 - M1 >= 40.

flyday(Day,Daylist) :- member(Day,Daylist).
flyday(Day,alldays) :- member(Day,[mo,tu,we,th,fr,sa,su]).

flight(DeparturePlace,ArrivalPlace,Day,FlightNumber,Deptime,Arrtime) :-
   timetable(DeparturePlace,ArrivalPlace,Flightlist),
   member([Deptime,Arrtime,FlightNumber,Daylist],Flightlist),
   flyday(Day,Daylist).

route(DeparturePlace,ArrivalPlace,Day,[DeparturePlace-ArrivalPlace:FlightNumber:Deptime]) :-
   flight(DeparturePlace,ArrivalPlace,Day,FlightNumber,Deptime,_).
   
route(DeparturePlace,ArrivalPlace,Day,[DeparturePlace-TransferPlace:FlightNumber1:DepTime1|Route]) :-
   route(TransferPlace,ArrivalPlace,Day,Route),
   flight(DeparturePlace,TransferPlace,Day,FlightNumber1,DepTime1,Arr1),
   deptime(Route,DepTime2),
   transfer(Arr1,DepTime2).
