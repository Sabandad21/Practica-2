vehicle(audi, q3, suv, 37000, 2023).
vehicle(audi, a6, sedan, 45000, 2022).
vehicle(audi, rs7, sport, 120000, 2024).
vehicle(audi, q2, suv, 33000, 2024).
vehicle(audi, e_tron, electric, 85000, 2023).
vehicle(hyundai, accent, sedan, 19000, 2022).
vehicle(hyundai, santa_fe, suv, 32000, 2023).
vehicle(hyundai, ioniq_5, electric, 44000, 2024).
vehicle(hyundai, kona, suv, 29000, 2022).
vehicle(mazda, cx5, suv, 31000, 2023).
vehicle(mazda, mx5, sport, 35000, 2022).
vehicle(mazda, 6, sedan, 28000, 2023).
vehicle(mazda, cx30, suv, 27000, 2024).
vehicle(mazda, 3, sedan, 25000, 2022).

meet_budget(Reference, BudgetMax):-
    vehicle(_, Reference, _, Price, _),
    Price =< BudgetMax.

vehicles_by_brand(Brand, Refs) :-
    findall(Ref, vehicle(Brand, Ref, _, _, _), Refs).

vehicles_grouped_by_brand(Brand,Grouped):-
    bagof((Type,Refs), bagof(Ref,Price^Year^(vehicle(Brand,Ref,Type,Price,Year)),Refs),Grouped).

sum_prices([], 0).
sum_prices([(_, Price)|T], Total) :-
    sum_prices(T, Rest),
    Total is Price + Rest.

generate_report(Brand, Type, Budget, Result) :-
    findall((Ref, Price),
        (vehicle(Brand, Ref, Type, Price, _), Price =< Budget),
        Vehicles),
    sum_prices(Vehicles, Total),
    Total =< 1000000,
    Result = Vehicles.

test_case1(Refs) :-
    findall(Ref, (vehicle(hyundai, Ref, suv, Price, _), Price < 30000), Refs).

test_case2(Grouped) :-
    bagof((Type, Year, Ref), vehicle(audi, Ref, Type, _, Year), Grouped).

test_case3(Vehicles, Total) :-
    findall((Ref, Price), (vehicle(_, Ref, sedan, Price, _), Price =< 500000), Vehicles),
    sum_prices(Vehicles, Total),
    Total =< 500000.