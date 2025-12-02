fun {Length_ List}
    if List == nil then
        0
    else
        1 + {Length_ List.2}
    end
end

fun {Take_ List Count}
    if Count > {Length_ List} then
        List
    elseif Count == 0 then
        nil
    else
        '|'(List.1 {Take_ List.2 (Count-1)})
    end
end

fun {Drop_ List Count}
    if Count > {Length_ List} then
        nil
    elseif Count == 0 then
        List
    else
        {Drop_ List.2 (Count-1)}
    end
end

fun {Append_ List1 List2}
    if List1 == nil then
        List2
    else
        '|'(List1.1 {Append_ List1.2 List2})
    end
end

fun {Member_ List Element}
    if List == nil then
        false
    elseif List.1 == Element then
        true
    else
        {Member_ List.2 Element}
    end
end

fun {Position_ List Element}
    % Assuming the element is in the list
    if List.1 == Element then
        0 % Using 0-based index
    else
        {Position_ List.2 Element} + 1
    end
end

fun {Push_ List Element}
    '|'(Element List)
end

fun {Peek_ List}
    if List == nil then
        nil
    else
        List.1
    end
end

fun {Pop_ List}
    if List == nil then
        nil
    else
        List.2
    end
end