-- Auxiliary File for OOP
ViewHint={}
function ViewHint:new()
    local newViewHint={}
    setmetatable(newViewHint,self)
    self.__index=self
    return newViewHint
end