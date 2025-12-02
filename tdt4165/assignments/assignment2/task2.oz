functor
import 
    System

define

    \insert './List.oz'

    %Task 2a)
    {System.showInfo 'Task 2a)'}

    fun {ExpressionTreeInternal Tokens ExpressionStack}
        case Tokens of Head|Tail then
            case Head of number(N) then
                {ExpressionTreeInternal Tail {Push_ ExpressionStack N}} % Push the number to the stack and call the function recursively
            [] operator(type:Op) then
                local EXP1 EXP2 Rest in
                    EXP1 = {Peek_ ExpressionStack} % Get the top expression
                    EXP2 = {Peek_ {Pop_ ExpressionStack}} % Get the second top expression
                    Rest = {Drop_ ExpressionStack 2} % Remove the top two expressions from the stack

                    case Op of plus then
                        {ExpressionTreeInternal Tail plus(EXP1 EXP2)|Rest}
                    [] minus then
                        {ExpressionTreeInternal Tail minus(EXP1 EXP2)|Rest}
                    [] multiply then
                        {ExpressionTreeInternal Tail multiply(EXP1 EXP2)|Rest}
                    [] divide then
                        {ExpressionTreeInternal Tail divide(EXP1 EXP2)|Rest}
                    [] _ then
                        {System.showInfo "ERROR: Not a valid operator"}
                    end
                end
            end
        else
            {Peek_ ExpressionStack} % Return the top expression as the result
        end
    end

    {System.show {ExpressionTreeInternal [number(2) number(3) operator(type:plus) number(5) operator(type:divide)] nil}} % divide(5 plus(3 2))


    %Task 2b)
    {System.showInfo 'Task 2b)'}

    fun {ExpressionTree Tokens}
        {ExpressionTreeInternal Tokens nil} % Start with an empty stack
    end

    {System.show {ExpressionTree [number(3) number(10) number(9) operator(type:multiply)
    operator(type:minus) number(7) operator(type:plus)]}} % plus(7 minus(multiply(9 10) 3))
    
    
    /* 
    DESCRIPTION (also provided in the pdf):
        
    In the function ExpressionTree, we take in a list of Tokens with postfix notation, and we 
    initialize an empty stack that will be used to build the expression tree. 

    Using the function ExpressionTreeInternal, we recursively iterate through the list of Tokens, 
    and for each token we check wheather it's a number or an operator. If it's a number, we push it to the stack.

    If it's an operator, we pop the top two elements from the stack and apply them in the expression 
    along with the operator. We then push this expression back to the stack.

    We continue this process until we have processed all tokens in the list, and the top element of the 
    stack will be the final expression tree. We return this as the result.

    */


end