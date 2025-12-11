local screenWidth=ScrW()
local screenHeight=ScrH()
local backgroundColor=Color(20,20,20,225)
local titleColor=Color(255,205,0)
local descriptionColor=Color(235,235,235)
local barBackgroundColor=Color(80,200,80,230)
local barColor=Color(60,60,60,230)
local textAlignLeft=TEXT_ALIGN_LEFT
local textAlignTop=TEXT_ALIGN_TOP
local mathClamp=math.Clamp
local function createHint(this,position)
    local panel=vgui.Create("Panel")
    local widthOfHint=math.Clamp(screenWidth*0.28,280,480)
    local widthOfBarAtMaxLength=widthOfHint-24
    surface.SetFont("DermaDefaultBold")
    local descriptionHeight=select(2,surface.GetTextSize(this.description))
    local descriptionLines=separateMessageInLines(this.description,widthOfHint-24,"DermaDefaultBold")
    local heightOfHint=math.Clamp(#descriptionLines*descriptionHeight+72,90,200)
    local heightOfBar=heightOfHint-16
    panel:SetSize(widthOfHint,heightOfHint)
    panel:SetPos(screenWidth-widthOfHint-40,screenWidth*0.4-heightOfHint*0.5-(40+heightOfHint)*(position-1))
    local title=this.title
    local widthOfBar
    panel.Paint=function()
        draw.RoundedBox(10,0,0,widthOfHint,heightOfHint,backgroundColor);
        draw.SimpleText(title,"DermaLarge",12,8,titleColor,textAlignLeft,textAlignTop);
        for lineNumber,line in ipairs(descriptionLines) do draw.DrawText(line,"DermaDefaultBold",12,40+(lineNumber-1)*descriptionHeight,descriptionColor,textAlignLeft); end;
        widthOfBar=widthOfBarAtMaxLength*mathClamp(1-((CurTime()-this.start)/this.duration),0,1);
        draw.RoundedBox(4,12,heightOfBar,widthOfBarAtMaxLength,6,barColor);
        draw.RoundedBox(4,12,heightOfBar,widthOfBar,6,barBackgroundColor);
    end
    local timeToFade=this.start+this.duration
    panel:SetAlpha(255)
    local fadeStep=5
    panel.Think=function()
        if CurTime()>timeToFade then
            panel:SetAlpha(panel:GetAlpha()-fadeStep);
            this.isValid=false
        end
    end
    timer.Create("hintRemove",this.duration+1.05,0,function() panel:Remove(); end)
    return panel
end
function ViewHint:ViewHint(title,description,duration,position)
    self.title=title or ""
    self.description=description or ""
    self.duration=duration or 6
    self.start=CurTime()
    self.panel=createHint(self,position)
    self.isValid=true
    return self
end
function ViewHint:Remove()
    self.panel:Remove()
    if timer.Exists("hintRemove") then timer.Remove("hintRemove") end
    self.isValid=false
end