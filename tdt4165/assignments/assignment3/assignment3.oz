% Task 1)
% a)
declare proc {QuadraticEquation A B C ?RealSol ?X1 ?X2}
    Discr = B*B - (4.0 * A * C)
in
    if (Discr >= 0.0) then
        RealSol = true
        X1 = (~B + {Sqrt Discr})/(2.0 * A) % using '~' instead of '-' 
        X2 = (~B - {Sqrt Discr})/(2.0 * A)
    else
        RealSol = false
        X1 = nil
        X2 = nil
    end
end

% procedure to print the results
declare proc {QuadraticEquation_print A B C}
    local RealSol X1 X2 in
        {QuadraticEquation A B C RealSol X1 X2}
        if RealSol then
            {System.showInfo "X1 = " #X1}
            {System.showInfo "X2 = " #X2}
        else
            {System.show RealSol}
        end
    end
end


% b)
{QuadraticEquation_print 2.0 1.0 ~1.0} % X1 = 1, X2 = -3
{QuadraticEquation_print 2.0 1.0 2.0} % False



% Task 2)
declare fun {Sum List}
    case List of nil then 
        0
    [] Head|Tail then 
        Head + {Sum Tail} % calling the function recursively
    end
end

{System.show {Sum [4 3 2 1]}} % 10
{System.show {Sum [2 3 2 5]}} % 12



% Task 3)
% a)
declare fun {RightFold List Op U}
    case List of Head|Tail then
        {Op Head {RightFold Tail Op U}}
    else
        U
    end
end


% c)
declare fun {Length_ List}
    {RightFold List fun {$ X _} X+1 end 0} 
end

declare fun {Sum_ List}
    {RightFold List fun {$ X Y} X+Y end 0}
end


% copy of Length function from Assignment 1 for testing purposes
declare fun {Length List}
    if List == nil then
        0
    else
        1 + {Length List.2}
    end
end


{System.show {Length [4 3 2 1 3]}}  % 5
{System.show {Length_ [4 3 2 1 3]}} % 5
{System.show {Sum [4 3 2 1]}}       % 10
{System.show {Sum_ [4 3 2 1]}}      % 10



% Task 4)

% f(x) = Ax^2 + Bx + C

declare fun {Quadratic A B C} 
    fun {$ X} 
        A*X*X + B*X + C 
    end
end

{System.show {{Quadratic 3 2 1} 2}} % 17




% Task 5)

% a)
declare fun {LazyNumberGenerator StartValue}
    StartValue|fun {$} 
        {LazyNumberGenerator StartValue + 1} 
    end
end

{System.show {LazyNumberGenerator 0}.1} % 0
{System.show {{LazyNumberGenerator 0}.2}.1} % 1
{System.show {{{{{{LazyNumberGenerator 0}.2}.2}.2}.2}.2}.1} % 5




% Task 6)

% a)
declare fun {Sum_tail_rec List}
    fun {Helper_func List Acc}
        case List of nil then 
            Acc
        [] Head|Tail then 
            {Helper_func Tail Head + Acc}
        end
    end
in  
    {Helper_func List 0}
end

{System.show {Sum_tail_rec [4 3 2 1]}} % 10
{System.show {Sum_tail_rec [2 3 2 5]}} % 12


