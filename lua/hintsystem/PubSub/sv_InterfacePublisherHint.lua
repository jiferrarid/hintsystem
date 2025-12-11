-- Auxiliary File for OOP
PublisherHint={}
function PublisherHint:new()
    local newPublisherHint={}
    setmetatable(newPublisherHint,self)
    self.__index=self
    return newPublisherHint
end