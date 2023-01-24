% -------------------------------------------------------------
%
% Find connected stations and routes in a Metro Stations Dataset.
% In this example we assume we use a basic description of London Metro.
% Check provided README.md for usage examples.
%
% Author: Aggelos Stamatiou, May 2017
%
% This source code is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This software is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this source code. If not, see <http://www.gnu.org/licenses/>.
% --------------------------------------------------------------------------

% Station data. Format: station(Name,Lines)
station(acton_town,[piccadilly,district]).
station(aldgate,[circle]).
station(aldgate_east,[district,metropolitan]).
station(aldwych,[piccadilly_aldwych_branch]).
station(angel,[northern_west]).
station(baker_street,[metropolitan,circle,bakerloo,jubilee,metropolitan_amersham_branch]).
station(bank,[central,northern_city,subway_between_bank_and_monument]).
station(barbican,[circle,metropolitan]).
station(barons_court,[district,piccadilly]).
station(bayswater,[circle]).
station(bethnal_green,[central]).
station(blackfriars,[circle,district]).
station(bond_street,[central,jubilee]).
station(borough,[northern_west]).
station(camden_town,[northern_city,northern_west]).
station(cannon_street,[circle,district]).
station(chancery_lane,[central]).
station(charing_cross,[bakerloo,jubilee,northern_city]).
station(chiswick_park,[district]).
station(covent_garden,[piccadilly]).
station(ealing_broadway,[central,district]).
station(ealing_common,[piccadilly,district]).
station(earls_court,[district,district_exhibition_branch,piccadilly]).
station(east_acton,[central]).
station(edgware_road_bakerloo,[bakerloo]).
station(edgware_road_circle,[circle,metropolitan]).
station(elephant_and_castle,[bakerloo,northern_west]).
station(embankment,[bakerloo,circle,district,northern_city]).
station(euston,[northern_city,northern_west,victoria]).
station(euston_square,[circle,metropolitan]).
station(farringdon,[circle,metropolitan]).
station(finchley_road,[jubilee,metropolitan_amersham_branch]).
station(finsbury_park,[piccadilly,victoria]).
station(gloucester_road,[circle,district]).
station(goldhawk_road,[metropolitan]).
station(goodge_street,[northern_city]).
station(great_portland_street,[circle,metropolitan]).
station(green_park,[jubilee,piccadilly,victoria]).
station(hammersmith,[district,metropolitan,piccadilly]).
station(heathrow_terminal_4,[piccadilly]).
station(heathrow_terminals_1_2_3,[piccadilly]).
station(high_street_kensington,[circle]).
station(highbury_and_islington,[victoria]).
station(holborn,[central,piccadilly,piccadilly_aldwych_branch]).
station(holland_park,[central]).
station(hyde_park_corner,[piccadilly]).
station(kennington,[northern_city,northern_west]).
station(kensington_olympia,[district_exhibition_branch]).
station(kings_cross,[piccadilly,metropolitan,circle, northern_city,victoria]).
station(knightsbridge,[piccadilly]).
station(ladbroke_grove,[metropolitan]).
station(lambeth_north,[bakerloo]).
station(lancaster_gate,[central]).
station(latimer_road,[metropolitan]).
station(leicester_square,[northern_city,piccadilly]).
station(liverpool_street,[central,circle,metropolitan]).
station(london_bridge,[northern_west]).
station(mansion_house,[circle,district]).
station(marble_arch,[central]).
station(marylebone,[bakerloo]).
station(mile_end,[central,district]).
station(monument,[circle,district,subway_between_bank_and_monument]).
station(moorgate,[circle,metropolitan,northern_west]).
station(mornington_crescent,[northern_city]).
station(neasden,[jubilee]).
station(north_acton,[central]).
station(notting_hill_gate,[central,circle]).
station(old_street,[northern_west]).
station(oval,[northern_city]).
station(oxford_circus,[bakerloo,central,victoria]).
station(paddington,[bakerloo,circle,metropolitan]).
station(piccadilly_circus,[bakerloo,piccadilly]).
station(pimlico,[victoria]).
station(queens_park,[bakerloo]).
station(queensway,[central]).
station(ravenscourt_park,[district]).
station(regents_park,[bakerloo]).
station(royal_oak,[metropolitan]).
station(russell_square,[piccadilly]).
station(shepherds_bush_central,[central]).
station(shepherds_bush_met,[metropolitan]).
station(sloane_square,[circle,district]).
station(south_kensington,[circle,district,piccadilly]).
station(st_james_park,[circle,district]).
station(st_pauls,[central]).
station(stamford_brook,[district]).
station(stockwell,[northern_city,victoria]).
station(stratford,[central]).
station(temple,[circle,district]).
station(tottenham_court_road,[central,northern_city]).
station(tower_hill,[circle,district]).
station(turnham_green,[piccadilly,district]).
station(vauxhall,[victoria]).
station(victoria,[circle,district,victoria]).
station(warren_street,[northern_city,victoria]).
station(waterloo,[bakerloo,northern_city,waterloo_and_city]).
station(west_acton,[central]).
station(west_kensington,[district]).
station(westbourne_park,[metropolitan]).
station(westminster,[circle,district]).
station(white_city,[central]).
station(whitechapel,[district,metropolitan]).

% connected/3: find a direct connection line between two stations.
connected(St1,St2,Line):-
	station(St1,St1Lines),
	station(St2,St2Lines),
	St1 \= St2,
	member(Line,St1Lines),
	member(Line,St2Lines).

% number_of_stations/1: retrieve all stations count.
number_of_stations(N):-
	findall(Station,station(Station,_),ListOfStations),
	length(ListOfStations,N).

% number_of_lines/1: retrieve all lines count.
number_of_lines(N):-
	findall(Line,(station(_,StationLines),member(Line,StationLines)),ListOfLines),
	setof(Line,member(Line,ListOfLines),FilteredListOfLines),
	length(FilteredListOfLines,N).

% route/5: find a route between two stations by using a line and visit a station max once.
route(Station,FinalStation,VisitedStations,VisitedLines,[Station,get_line(Line),FinalStation]):-
	connected(Station,FinalStation,Line),
	not(member(FinalStation,VisitedStations)),
	not(member(Line,VisitedLines)).

route(Station,FinalStation,VisitedStations,VisitedLines,[Station,get_line(Line)|RestRoute]):-
	connected(Station,NextStation,Line),
	not(member(NextStation,VisitedStations)),
	not(member(Line,VisitedLines)),
	route(NextStation,FinalStation,[NextStation|VisitedStations],[Line|VisitedLines],RestRoute).

% find_route/3: find a route between two stations by using a line and visit a station max once.
find_route(InitialStation,FinalStation,Route):-
	route(InitialStation,FinalStation,[InitialStation],[],Route).

% check/2: find a route of specific size between two stations.
check(Station1,Station2):-
	length(Route,3),
	find_route(Station1,Station2,Route).

check(Station1,Station2):-
	length(Route,5),
	find_route(Station1,Station2,Route).

check(Station1,Station2):-
	length(Route,7),
	find_route(Station1,Station2,Route).

% routes_3/1: check if stations exist where we need to change more than 3 lines.
routes_3(List):-
	findall(Station,station(Station,_),ListOfStations),
	setof((Station1,Station2),
	      (member(Station1,ListOfStations),
	      member(Station2,ListOfStations),
	      Station1\=Station2,
	      not(check(Station1,Station2))),
	      UnfilteredList),
	cleanse_list(UnfilteredList,List).

% cleanse_list/2: Remove duplicates from list.
cleanse_list([],[]).

cleanse_list([(Station1,Station2)|T],[(Station1,Station2)|Rest]):-
	member((Station2,Station1),T),
	delete((Station2,Station1),T,Filtered),!,
	cleanse_list(Filtered,Rest).

cleanse_list([(Station1,Station2)|T],[(Station1,Station2)|Rest]):-
	cleanse_list(T,Rest).
