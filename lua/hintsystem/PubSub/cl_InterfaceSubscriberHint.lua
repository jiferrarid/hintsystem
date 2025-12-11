-- Auxiliary File for OOP
SubscriberHint={}
function SubscriberHint:new()
    local newSubscriberHint={}
    setmetatable(newSubscriberHint,self)
    self.__index=self
    return newSubscriberHint
end