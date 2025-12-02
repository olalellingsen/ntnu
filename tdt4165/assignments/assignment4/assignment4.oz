% Task 1

% a)
local A=10 B=20 C=30 in
    {System.show C}

    thread
        {System.show A}
        {Delay 100}
        {System.show A * 10}
    end

    thread
        {System.show B}
        {Delay 100}
        {System.show B * 10}
    end

    {System.show C * 100}
end


% c)

local A B C in
    thread
        A = 2
        {System.show A}
    end
    thread
        B = A * 10
        {System.show B}
    end

    C = A + B
    {System.show C}
end




% Task 2

% a)
declare fun {Enumerate_Help_Fun Start End}
    if Start > End then nil
    else 
        Start | {Enumerate_Help_Fun Start + 1 End}
    end
end

declare fun {Enumerate Start End}
    thread
        {Enumerate_Help_Fun Start End}
    end
end

{Browse {Enumerate 1 5}} % [1 2 3 4 5]



% b)
declare fun {GenerateOdd Start End}
    local Numbers OddNumbers in
        thread Numbers = {Enumerate Start End} end
        thread OddNumbers = {Filter Numbers IsOdd} end
        OddNumbers
    end
end

{Browse {GenerateOdd 1 5}} % [1 3 5]
{Browse {GenerateOdd 1 8}} % [1 3 5 7]
{Browse {GenerateOdd 4 4}} % nil



% c) 
{Show {Enumerate 1 5}}
{Show {GenerateOdd 1 5}}



% Task 3

% a)
declare fun {ListDivisorsOf Number}
    {Filter {Enumerate 1 Number}
        fun {$ X}
            thread
                Number mod X == 0
            end
        end}
end


{Browse {ListDivisorsOf 10}} % [1 2 5 10]
{Browse {ListDivisorsOf 30}} % [1 2 3 5 6 10 15 30]


% b)
declare fun {ListPrimesUntil N}
    {Filter {Enumerate 2 N}
        fun {$ X}
            thread
                {ListDivisorsOf X} == [1 X]
            end
        end}
end

{Browse {ListPrimesUntil 10}} % [2 3 5 7]
{Browse {ListPrimesUntil 30}} % [2 3 5 7 11 13 17 19 23 29]



% Task 4

% a)
declare fun lazy {Enumerate_Lazy_Helper N}
    N | {Enumerate_Lazy_Helper N+1}
end

declare fun lazy {Enumerate}
    {Enumerate_Lazy_Helper 1}
end

{Browse {List.take {Enumerate} 10}}  % [1 2 3 4 5 6 7 8 9 10]


% b)
declare fun lazy {Primes}
    {Filter {Enumerate}
        fun {$ X}
            thread
                {ListDivisorsOf X} == [1 X]
            end
        end}
end 

{Browse {List.take {Primes} 10}} % [2 3 5 7 11 13 17 19 23 29]

