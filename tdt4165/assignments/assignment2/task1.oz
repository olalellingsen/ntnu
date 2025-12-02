functor
import 
    System

define

    \insert './List.oz'


    % A function that prints a break between tasks, making the output in the terminal more readable
    proc {TaskBreak}
        {System.showInfo '_______________________________________________________'}
        {System.showInfo ' '}
    end
    

    % Task 1a)
    {System.showInfo 'Task 1a)'}


    fun {Lex Input}
        {String.tokens Input & }
    end


    {System.show {Lex "1 2 + 3 *"}} % [[49] [50] [43] [51] [42]]

    {TaskBreak}


    % Task 1b)   
    {System.showInfo 'Task 1b)'}

    fun {Tokenize Lexemes}
        case Lexemes of Head|Tail then
            case Head of
               "+" then
                  operator(type:plus) | {Tokenize Tail}
               [] "-" then
                  operator(type:minus) | {Tokenize Tail}
               [] "*" then
                  operator(type:multiply) | {Tokenize Tail}
               [] "/" then
                  operator(type:divide) | {Tokenize Tail}
               [] "p" then % Print command implemented in task 1d)
                    command(type:print) | {Tokenize Tail}
               [] "d" then % Duplicate command implemented in task 1e)
                    command(type:duplicate) | {Tokenize Tail}
               [] "i" then % invert/flip command implemented in task 1f)
                    command(type:invert) | {Tokenize Tail}
               [] "c" then % clear command implemented in task 1g)
                    command(type:clear) | {Tokenize Tail}
               [] _ then
                  number({String.toFloat Head}) | {Tokenize Tail} % Convert string to float
            end
        else
            nil
        end
    end


    {System.show {Tokenize ["1" "2" "+" "3" "*"]}} % [number(1) number(2) operator(type:plus) number(3) operator(type:multiply)]
    

    {TaskBreak}


    % Task 1c)
    {System.showInfo 'Task 1c)'}

    fun {Interpret Tokens}

        fun {Interpreter Tokens Stack} % Recursive function to interpret the tokens and update the stack
            case Tokens of Head|Tail then
                case Head of
                    % If the token is a number, push it to the stack
                    number(N) then
                        {Interpreter Tail {Push_ Stack N}}
        
                    % If the token is an operator, pop the top two elements from the stack, apply the operator and push the result back to the stack
                    [] operator(type:Op) then
                        local N1 N2 Rest in
                            N1 = {Peek_ Stack} % Get the top element
                            N2 = {Peek_ {Pop_ Stack}} % Get the second top element
                            Rest = {Drop_ Stack 2} % Remove the top two elements from the stack

                            case Op of plus then
                                {Interpreter Tail {Push_ Rest N1 + N2}} % Push the result back to the stack
                                [] minus then
                                {Interpreter Tail {Push_ Rest N1 - N2}}
                                [] multiply then
                                {Interpreter Tail {Push_ Rest N1 * N2}}
                                [] divide then
                                {Interpreter Tail {Push_ Rest N1 / N2}}
                            end
                        end

                     % If token is a command (implemented in task d, e, f, g)
                     [] command(type:Cmd) then
                        case Cmd of print then
                            {System.show Stack} % Print the stack
                            {Interpreter Tail Stack}
                        [] duplicate then
                            {Interpreter Tail {Push_ Stack {Peek_ Stack}}} % Duplicate the top element
                        [] invert then
                            {Interpreter Tail {Push_ {Pop_ Stack} ~{Peek_ Stack}}} % Using '~' instead of '-'
                        [] clear then
                            {Interpreter Tail nil} % Clear the stack
                        end
                end
            else
                Stack % Return the stack as the result
            end
        end
    in
        {Interpreter Tokens nil} % Start with an empty stack
    end

    
    {System.show {Interpret [number(1) number(2) number(3) operator(type:plus)]}} % [5 1]
    {System.show {Interpret {Tokenize {Lex "1 2 3 +"}}}} % [5 1]

    % Some other test cases
    {System.show {Interpret [number(3) number(2) operator(type:multiply)]}} % [6]
    {System.show {Interpret [number(3) number(1) number(7) operator(type:minus)]}} % [6 3]
    
    {TaskBreak}



    % Task 1d)
    {System.showInfo 'Task 1d)'}
    
    {System.show {Interpret {Tokenize {Lex "1 2 p 3 +"}}}} % [2 1] [5 1]

    {TaskBreak}
    
    
    % Task 1e)
    {System.showInfo 'Task 1e)'}

    {System.show {Interpret {Tokenize {Lex "1 2 3 + d"}}}} % [5 5 1]

    {TaskBreak}


    % Task 1f)
    {System.showInfo 'Task 1f)'}

    {System.show {Interpret {Tokenize {Lex "1 2 3 + d i"}}}} % [-5 5 1]
    
    {TaskBreak}
    
    
    % Task 1g)
    {System.showInfo 'Task 1g)'}
    
    {System.show {Interpret {Tokenize {Lex "1 2 3 + c 2 3 4 *"}}}} % [12 2]

    {TaskBreak}


    /* 
    DESCRIPTION (also provided in the pdf):

    The function takes a string as input and splits the string (on whitespace) into a list of tokens, 
    this is done using the String.tokens function. In order to convert each Lexeme into a corresponding record, 
    the Tokenize function was implemented. The following records were used: operator(type:plus), 
    operator(type:minus), operator(type:multiply), operator(type:divide), number(N) where N is any number, 
    command(type:print), command(type:duplicate), command(type:invert) and command(type:clear).

    In order to take in postfix expressions and compute the result, the Interpret function was implemented. 
    In this function we're using a recursive function 'Interpreter' to check weather a token is a number, 
    an operator or a command. An empty stack is used to recursively add the computed numbers.

    If the token is a number, it will be pushed onto the stack. If the token is an operator, the top two elements 
    of the stack will be popped and the type of operator will be applied (plus, minus, multiply or divide). 
    The function calls itself (recursively) and the result of the operation is pushed back on the stack. 

    If the token is a command (print, duplicate, invert or clear), the function call itself (recursively) 
    using a combination of functions (Push, Peek, Pop and Print) to update the stack. The function returns 
    the stack of computed numbers after all the tokens has been interpreted.
    
    */


end



