local Lib = {}

function Lib.clone(tab)
    local new = {}
    for i, v in pairs(tab) do
        if type(v) == "table" then
            new[i] = Lib.clone(v)
        else
            new[i] = v
        end
    end
    return new
end

return Lib