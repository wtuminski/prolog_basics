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



matchingFlightDay([_,_,_,alldays],_).
matchingFlightDay([_,_,_,Days],Day) :-
    member(Day,Days).

findMatchingFlight(
    [Flight|OtherFlights],
    Day,
    MatchingFlight
) :-
  matchingFlightDay(Flight,Day),
  append([],Flight,MatchingFlight);
  findMatchingFlight(OtherFlights, Day, MatchingFlight).

getRouteString(
    DeparturePlace,
    ArrivalPlace,
    [HH:MM,_,FlightNumber|_],
    RouteString
) :-
    atomic_list_concat([DeparturePlace,-,ArrivalPlace,:,FlightNumber,:,HH,:,MM],RouteString).

route(DeparturePlace,ArrivalPlace,Day,Route) :-
    timetable(
        DeparturePlace,
        ArrivalPlace,
        Flights
    ),
    findMatchingFlight(Flights,Day,MatchingFlight),
    getRouteString(DeparturePlace,ArrivalPlace,MatchingFlight,Route).
