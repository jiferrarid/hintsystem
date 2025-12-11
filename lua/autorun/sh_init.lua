if SERVER then
    util.AddNetworkString("HintSystem_showHint")
    AddCSLuaFile("hintsystem/PubSub/cl_InterfaceSubscriberHint.lua")
    AddCSLuaFile("hintsystem/View/cl_InterfaceViewHint.lua")
    AddCSLuaFile("hintsystem/PubSub/cl_SubscriberHint.lua")
    AddCSLuaFile("hintsystem/View/cl_ViewHint.lua")
    include("hintsystem/PubSub/sv_InterfacePublisherHint.lua")
    include("hintsystem/PubSub/sv_PublisherHint.lua")
    include("hintsystem/sh_util.lua")
    HINTSYSTEM_PUBLISHER=PublisherHint:new():PublisherHint()
else -- CLIENT
    include("hintsystem/PubSub/cl_InterfaceSubscriberHint.lua")
    include("hintsystem/View/cl_InterfaceViewHint.lua")
    include("hintsystem/PubSub/cl_SubscriberHint.lua")
    include("hintsystem/View/cl_ViewHint.lua")
    include("hintsystem/sh_util.lua")
    HINTSYSTEM_SUBSCRIBER=SubscriberHint:new():SubscriberHint()
end