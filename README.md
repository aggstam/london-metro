# london-metro

Find connected stations and routes in a Metro Stations Dataset.
<br>
In this example we assume we use a basic description of London Metro.
<br>
Implementation requires *prolog* to be installed.

## Execution example
```shell
$ swipl -s london_metro.pl

?- connected(cannon_street, monument, Line).
Line = circle ;
Line = district ;
false.

?- connected(camden_town, monument, Line).
false.

?- number_of_stations(N).
N = 102.

?- number_of_lines(N).
N = 15.

?- find_route(cannon_street, monument, Path).
Path = [cannon_street, get_line(circle), monument] .

?- find_route(camden_town, monument, Path).
Path = [camden_town, get_line(northern_city), bank, get_line(subway_between_bank_and_monument), monument] .

?- routes_3(List).
List = [(aldwych, angel), (aldwych, borough), (aldwych, london_bridge), (aldwych, old_street), (angel, aldwych), (angel, kensington_olympia), (borough, aldwych), (borough, kensington_olympia), (..., ...)|...].
```
