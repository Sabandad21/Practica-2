vehiculo(audi, q3, suv, 37000, 2023).
vehiculo(audi, a6, sedan, 45000, 2022).
vehiculo(audi, rs7, sport, 120000, 2024).
vehiculo(audi, q2, suv, 33000, 2024).
vehiculo(audi, e_tron, electric, 85000, 2023).
vehiculo(hyundai, accent, sedan, 19000, 2022).
vehiculo(hyundai, santa_fe, suv, 32000, 2023).
vehiculo(hyundai, ioniq_5, electric, 44000, 2024).
vehiculo(hyundai, kona, suv, 29000, 2022).
vehiculo(mazda, cx5, suv, 31000, 2023).
vehiculo(mazda, mx5, sport, 35000, 2022).
vehiculo(mazda, 6, sedan, 28000, 2023).
vehiculo(mazda, cx30, suv, 27000, 2024).
vehiculo(mazda, 3, sedan, 25000, 2022).

imprimir_vehiculos([H|T]) :-
    H = vehiculo(M,Mo,Ti,P,A),
    format('Marca: ~w | Modelo: ~w | Tipo: ~w | Precio: ~d | Anno: ~d~n', [M,Mo,Ti,P,A]),
    (T == [] -> true ; imprimir_vehiculos(T)).

datos :-
    write('Ingrese marca (audi/hyundai/mazda): '), read(Marca),
    write('Ingrese tipo (suv/sedan/sport/electric): '), read(Tipo),
    write('Ingrese presupuesto maximo: '), read(Presupuesto),
    (   findall(vehiculo(Marca,Modelo,Tipo,Precio,Ano),
        (vehiculo(Marca,Modelo,Tipo,Precio,Ano), Precio =< Presupuesto),
        Resultado),
        Resultado \= [] ->
            imprimir_vehiculos(Resultado)
    ;   write('No se encontraron vehiculos con esos criterios'), nl
    ).

filtrar_vehiculos(Marca, Tipo, Presupuesto, Resultado) :-
    findall(vehiculo(Marca, Modelo, Tipo, Precio, Ano),
        (
            vehiculo(Marca, Modelo, Tipo, Precio, Ano),
            Precio =< Presupuesto
        ),
        Resultado).

filtrar_por_categoria :-
    write('Categoria: '), read(Categoria),
    write('Precio max: '), read(PrecioMax),
    findall(vehiculo(M,Mo,C,P,A), (vehiculo(M,Mo,C,P,A), C == Categoria, P =< PrecioMax), R),
    imprimir_vehiculos(R).

% caso 1: findall(vehiculo(hyundai,Mo,suv,P,_), (vehiculo(hyundai,Mo,suv,P,_), P < 30000), R).
% caso 2: bagof(vehiculo(audi,Mo,C,P,A), vehiculo(audi,Mo,C,P,A), R).
% total_sedan_value_under_limit(Total).
referencias_por_marca(Marca, L) :- findall(Mo, vehiculo(Marca,Mo,_,_,_), L).

sedan_prices(Prices) :-
    findall(Precio, (vehiculo(_, _, sedan, Precio, _), Precio =< 500000), Prices).

total_sedan_value_under_limit(Total) :-
    sedan_prices(Prices),
    sum_list(Prices, Total),
    Total =< 500000.