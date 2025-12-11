SubscriberHint.view=nil
SubscriberHint.alreadyShownHint=nil
local function setUpReceptionOfServerMessages(this)
    net.Receive("HintSystem_showHint", function() this:setHint(net.ReadString(),net.ReadString(),net.ReadUInt(8),net.ReadBool()); end)
end
function SubscriberHint:SubscriberHint()
    self.alreadyShownHint={}
    self.views={}
    setUpReceptionOfServerMessages(self)
    return self
end
function SubscriberHint:setHint(title,description,duration,showIfAlreadyShown)
    local descriptionAsCRC=util.CRC(description)
    if showIfAlreadyShown or not(self.alreadyShownHint[descriptionAsCRC]) then
        local canDelete=#self.views>0 
        for index=1,#self.views do
            if self.views[index].isValid then
                canDelete=false
                break 
            end
        end
        if canDelete then
            for index=1,#self.views do self.views[index]=nil end
        end
        self.views[#self.views+1]=ViewHint:new():ViewHint(title,description,duration,#self.views+1)
        self.alreadyShownHint[descriptionAsCRC]=true
    end
end