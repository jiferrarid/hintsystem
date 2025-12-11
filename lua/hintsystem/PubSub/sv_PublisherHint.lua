function PublisherHint:PublisherHint()
    return self
end
function PublisherHint:showHint(title,description,duration,player,showIfAlreadyShown)
    net.Start("HintSystem_showHint")
    net.WriteString(title or "")
    net.WriteString(description  or "")
    net.WriteUInt(duration or 6,8)
    net.WriteBool(showIfAlreadyShown)
    if IsValid(player) then net.Send(player)
    elseif istable(player) then net.Send(player)
    else net.Broadcast() end
end