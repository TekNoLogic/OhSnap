-- Thank you Tekkub + Engravings GUI
local TestMessage1,TestMessage2,TestMessage3,TestMessage4
local EDGEGAP, ROWHEIGHT, ROWGAP, GAP = 16, 19, 2, 4
local frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
frame.name = "OhSnap!"
frame:Hide()
frame:SetScript("OnShow", function(frame)

    local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("OhSnap! PvP Spell Tracker")

    local subtitle = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    subtitle:SetHeight(35)
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    subtitle:SetPoint("RIGHT", frame, -32, 0)
    subtitle:SetNonSpaceWrap(true)
    subtitle:SetJustifyH("LEFT")
    subtitle:SetJustifyV("TOP")
    subtitle:SetText("Configuration:")

    local rows, anchor = {}

    local lock = CreateFrame("Button",nil,frame)
    lock:SetPoint("TOP", subtitle, "BOTTOM", 0, -16)
    lock:SetPoint("LEFT", EDGEGAP, 0)
    lock:SetPoint("RIGHT", -EDGEGAP*2-8, 0)
    lock:SetHeight(ROWHEIGHT)
    anchor = lock

    local check = CreateFrame("CheckButton", nil, lock)
    check:SetWidth(ROWHEIGHT+4)
    check:SetHeight(ROWHEIGHT+4)
    check:SetPoint("LEFT")
    check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
    check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
    check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
    check:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
    check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
    check:SetScript("OnClick", function(self)
        if self:GetChecked() then 
			OhSnapAnchor:Show()
			TestMessage1 = OhSnap:AddMessage("|TInterface\\Icons\\INV_Misc_Bone_HumanSkull_02:0|t Dangerous spells",1,1,0,0)
			TestMessage2 = OhSnap:AddMessage("|TInterface\\Icons\\INV_Misc_Bone_HumanSkull_02:0|t Noticeable buffs",2,1,1,1)
			TestMessage3 = OhSnap:AddMessage("|TInterface\\Icons\\INV_Misc_Bone_HumanSkull_02:0|t Annoying buffs",3,1,1,0)
			TestMessage4 = OhSnap:AddMessage("|TInterface\\Icons\\INV_Misc_Bone_HumanSkull_02:0|t Profitable debuffs",4,0,1,0)
		else 
			OhSnapAnchor:Hide()
			OhSnap:DelMessage(TestMessage1)
			OhSnap:DelMessage(TestMessage2)
			OhSnap:DelMessage(TestMessage3)
			OhSnap:DelMessage(TestMessage4)
			TestMessage1 = nil
			TestMessage2 = nil
			TestMessage3 = nil
			TestMessage4 = nil
		end
    end)
    lock.check = check

    local title = lock:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
    title:SetPoint("LEFT", check, "RIGHT", 4, 0)
    lock.title = title
    title:SetText("Show OhSnap Anchor")
end)

InterfaceOptions_AddCategory(frame)