functor
import 
   System

define

    % Task 1
    {System.showInfo 'Hello World!'}




    % Task 3

    % a)
    {System.showInfo 'Task 3a)'}
    local X Y Z in
        Y = 300
        Z = 30
        X = Y * Z
        {System.show X}
    end


    % b)
    {System.showInfo 'Task 3b)'}
    X = "This is a string (from task 3b)"
    thread {System.showInfo Y} end
    Y = X

    /* 
    - showInfo is not acutally printing Y before it is assigned. The call is placed within a thread that starts immediately, but is not completed because the value Y is not yet bounded.
    The system is not showing an error because the thread is suspended until Y is bounded, therefore it will print the value of Y after it's bounded.

    - This is called dataflow, and it is useful as calculations can work independently between threads and execute in parallel at its own pace. This is called concurrency.
        
    - 'Y = X' is therefore assigning the value of X to Y, and the system will print the value of Y after it is assigned.
    */




    % Task 4

    {System.showInfo 'Task 4a)'}
    % a)
    fun {Max Number1 Number2}
        if Number1 > Number2 then
            Number1
        else
            Number2
        end
    end

    {System.show {Max 10 20}}

    % b)
    {System.showInfo 'Task 4b)'}

    proc {PrintGreater Number1 Number2}
        if Number1 > Number2 then
            {System.show Number1}
        else
            {System.show Number2}
        end
    end

    {PrintGreater 10 20}




    % Task 5
    {System.showInfo 'Task 5)'}

    proc {Circle R} Pi A D C in

        Pi = 355.0 / 113.0

        A = Pi * R * R
        D = 2.0 * R
        C = 2.0 * Pi * R

        {System.showInfo 'Area: '#A}
        {System.showInfo 'Diameter: '#D}
        {System.showInfo 'Circumference: '#C}
    end

    {Circle 10.0} % R must be a float




    % Task 6a)
    {System.showInfo 'Task 6a)'}

    fun {Factorial N}
        % NB: I tried to handle negative input, but I got some unexpected errors.
        if N == 0 then
           1  % Base case: factorial of 0 is 1
        else
           N * {Factorial N - 1}  % Recursive case
        end
     end
     
     {System.showInfo '5! = ' #{Factorial 5}}
    


    % Task 7a)
    {System.showInfo 'Task 7a)'}

    List1 = '|'(1 '|'(2 '|'(3 '|'(4 '|'(5 nil)))))

    
    fun {Length List}
        if List == nil then
            0
        else
            1 + {Length List.2}
        end
    end
    {System.showInfo 'Count: ' #{Length List1}}


    % Task 7b)
    {System.showInfo 'Task 7b)'}

    fun {Take List Count}
        if Count > {Length List} then
            List
         elseif Count == 0 then
            nil
         else
            '|'(List.1 {Take List.2 (Count-1)})
         end
    end
    {System.show {Take List1 2}}

    
    % Task 7c)
    {System.showInfo 'Task 7c)'}

    fun {Drop List Count}
        if Count > {Length List} then
            nil
        elseif Count == 0 then
            List
        else
            {Drop List.2 (Count-1)}
        end
    end
    {System.show {Drop List1 2}}


    % Task 7d)
    {System.showInfo 'Task 7d)'}

    fun {Append List1 List2}
        if List1 == nil then
            List2
        else
            '|'(List1.1 {Append List1.2 List2})
        end
    end

    List2 = '|'(6 '|'(7 '|'(8 nil)))
    {System.show {Append List1 List2}}


    % Task 7e)
    {System.showInfo 'Task 7e)'}

    fun {Member List Element}
        if List == nil then
            false
        elseif List.1 == Element then
            true
        else
            {Member List.2 Element}
        end
    end

    {System.show {Member List1 9}} % false
    {System.show {Member List1 4}} % true


    % Task 7f)
    {System.showInfo 'Task 7f)'}

    fun {Position List Element}
        % Assuming the element is in the list
        if List.1 == Element then
            0 % Using 0-based index
        else
            {Position List.2 Element} + 1
        end
    end
    
    {System.show {Position List1 3}}


    \insert '/Users/olalomoellingsen/koding/informatikk/tdt4165/assignments/List.oz'
    % Using the Length_ function from List.oz, not Length from this file
    {System.show {Length_ [1 2 3]}}
    {System.show {Member_ [1 2 3] 3}} % true
    {System.show {Position_ [1 2 3] 3}} % 2


    % In task 8 we use functions from List.oz
    
    % Task 8a)
    {System.showInfo 'Task 8a)'}
    List_8 = {Push_ List1 10} % add 10 to the start of List1
    {System.show List_8}

    % Task 8b)
    {System.showInfo 'Task 8b)'}
    {System.show {Peek_ List_8}} % 10

    % Task 8c)
    {System.showInfo 'Task 8c)'}
    {System.show {Pop_ List_8}}

end