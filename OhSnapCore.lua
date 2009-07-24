local messages = {}
local targetMsgs = {}
local rows = {}
local guidmap = {}
local uidcount = 0
OhSnap.Defaults = {
    [1] = {"Fonts\\FRIZQT__.TTF", 24,"OUTLINE, THICKOUTLINE"},
    [2] = {"Fonts\\FRIZQT__.TTF", 18,"OUTLINE"},
    [3] = {"Fonts\\FRIZQT__.TTF", 14,"OUTLINE"},
    [4] = {"Fonts\\FRIZQT__.TTF", 11,"OUTLINE"},
	["ShowAnchor"] = true,	
	["TestMode"] = false,
}

if not OhSnapDB then OhSnapDB = OhSnap.Defaults end

-- Automatically create the sub-tables for GUID
local done = setmetatable({}, {__index = function(t,k)
    local new = {}
    rawset(t, k, new)
    return new
end})

-- Create the anchor frame early
local anchor = CreateFrame("Frame", "OhSnapAnchor", UIParent)

-- Frame we use to SetScript the OnEvent and OnUpdate
local EventFrame = CreateFrame("Frame")

function OhSnap:Initialize()
    anchor:SetFrameStrata("HIGH")
    anchor:SetHeight(30)
    anchor:SetWidth(150)
    anchor:SetBackdrop(GameTooltip:GetBackdrop())
    anchor:SetBackdropColor(0.3, 0.3, 0.3)
    anchor.text = anchor:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
    anchor.text:SetAllPoints(true)
    anchor.text:SetText("OhSnap Anchor")
    anchor:SetPoint("CENTER", 0, 300)
    anchor:EnableMouse(true)
    anchor:SetMovable(true)
    anchor:Hide()
    anchor:SetScript("OnMouseDown", function(self, button)
        self:StartMoving()
    end)
    anchor:SetScript("OnMouseUp", function(self, button)
        self:StopMovingOrSizing()
		OhSnap:SavePosition()
    end)

end

-- Adds a message to the alert frame, returns a uid
function OhSnap:AddMessage(msg, priority, r, g, b, a, duration, lenght)
    local entry = {
        msg = msg or "Empty message", 
        pri = priority or 1,
        count = uidcount,
        r = r or 1,
        g = g or 1,
        b = b or 1,
        a = a or 1,
        dura = duration or 0,
        len = lenght or 0,
    }
    uidcount = uidcount + 1
    table.insert(messages, entry)
    self:Update()
    return entry
end

-- Removes a message from the alert frame
function OhSnap:DelMessage(uid)
    for i=1,#messages do
        if messages[i] == uid then
            table.remove(messages, i)
            self:Update()
            return
        end
    end
end

function OhSnap:Clear()
    table.wipe(messages)
    table.wipe(done)
    table.wipe(targetMsgs)
    EventFrame:SetScript("OnUpdate",nil)
    self:Update()
end

local function sortFunc(a, b)
    if a.pri == b.pri then
        return a.count < b.count
    else
        return a.pri < b.pri
    end
end

-- Updates the frame to display
function OhSnap:Update()
    -- Create enough frames, if necessary
    for i=#rows + 1, #messages, 1 do
        local row = CreateFrame("Frame")
        row:SetFrameStrata("HIGH")
        row.text = row:CreateFontString(nil, "OVERLAY")
        row.text:SetPoint("CENTER", 0, 0)
        row.text:SetJustifyH("CENTER")
        rows[i] = row
    end
    -- Sort the frames
    table.sort(messages, sortFunc)
    -- Anchor the frames in order
    for idx,entry in ipairs(messages) do
        local row = rows[idx]
        if idx == 1 then
            row:ClearAllPoints()
            row:SetPoint("TOP", anchor, "BOTTOM", 0, 0)
        else
            row:ClearAllPoints()
            row:SetPoint("TOP", rows[idx-1], "BOTTOM", 0, 0)
        end
        row:SetHeight(20)
        row:SetWidth(250)
		row.text:SetFont(unpack(OhSnapDB[entry.pri]))
        local duration = floor(entry.dura-GetTime())
        local message
        -- Coloring the time
        local r,g,b = 0,1,0
        local lenght = entry.len
        local percent = duration / lenght
        if ( percent > 0.5 ) then r,g,b = 2 * (1 - percent), 1, 0
        else r,g,b = 1, 2 * percent, 0 end
        local color = string.format("|cff%02x%02x%02x", r*255, g*255, b*255)
        if duration >= 0 then
            message = entry.msg.." ("..color..duration.."|rs)"
        else
            message = entry.msg
        end
        row.text:SetText(message)
        row.text:SetTextColor(entry.r, entry.g, entry.b, entry.a)
        row:Show()
    end
    -- Hide any extra frames
    for i=#rows, #messages + 1, -1 do
        rows[i]:Hide()
    end   
end

-- Actually initialize the code
OhSnap:Initialize()

anchor:RegisterEvent("PLAYER_TARGET_CHANGED")
anchor:RegisterEvent("UNIT_AURA")
anchor:RegisterEvent("PLAYER_ENTERING_WORLD")
anchor:RegisterEvent("PLAYER_ALIVE")
anchor:RegisterEvent("PLAYER_LOGIN")
anchor:RegisterEvent("UNIT_SPELLCAST_START")
anchor:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
anchor:SetScript("OnEvent", function(self, event, ...)
    if self[event] then return self[event](self, event, ...) end
end)

local function unitscan(unit)
    -- Debuffs
    local guid = UnitGUID(unit)
    do
        local prio = 4
        for k,v in pairs(OhSnap.spells[prio]) do
            local spellname = GetSpellInfo(k)
            local targetclass = select(2,UnitClass(unit))
            if (v.class and targetclass == v.class) or not v.class then
                -- If the spell is on the given unit, and its not already done
				if ((UnitIsPlayer(unit) and not UnitIsFriend("player", unit)) or OhSnapDB.TestMode) and UnitDebuff(unit, spellname) then
					if not done[guid][spellname] then
                        local message = UnitName(unit):match("[^-]+").. ": |T"..select(3,UnitDebuff(unit, spellname))..":0|t "..v.msg
                        local duration = select(7,UnitDebuff(unit,spellname))
                        local lenght = select(6,UnitDebuff(unit,spellname))
                        local uid = OhSnap:AddMessage(message,prio,0,1,0,1,duration,lenght)
                        done[guid][spellname] = uid
                        if UnitIsUnit(unit, "target") then
                            table.insert(targetMsgs, uid)
                        end
                    end
                elseif done[guid][spellname] then
                    local uid = done[guid][spellname]
                    OhSnap:DelMessage(uid)
                    done[guid][spellname] = nil
                end
            end
        end
    end
    -- Buffs
    for prio=2,3 do
        for k,v in pairs(OhSnap.spells[prio]) do
            local spellname = GetSpellInfo(k)
            local targetclass = select(2,UnitClass(unit))
            -- Mages have Spellsteal. Let's imagine they can have all the buffs listed :)
            if (v.class and (targetclass == v.class or targetclass == "MAGE")) or not v.class then
                -- If the spell is on the given unit, and its not already done
                if ((UnitIsPlayer(unit) and not UnitIsFriend("player", unit)) or OhSnapDB.TestMode) and UnitAura(unit, spellname) then
                    if not done[guid][spellname] then
                        local classcolor = RAID_CLASS_COLORS[select(2,UnitClass(unit))]
                        local r,g,b = classcolor.r,classcolor.g,classcolor.b
                        local message = UnitName(unit):match("[^-]+").. ": |T"..select(3,UnitAura(unit, spellname))..":0|t "..v.msg
                        local duration = select(7,UnitAura(unit,spellname))
                        local lenght = select(6,UnitAura(unit,spellname))
                        local uid = OhSnap:AddMessage(message,prio,r,g,b,1,duration,lenght)
                        done[guid][spellname] = uid
                        if UnitIsUnit(unit, "target") then
                            table.insert(targetMsgs, uid)
                        end
                    end
                elseif done[guid][spellname] then
                    local uid = done[guid][spellname]
                    OhSnap:DelMessage(uid)
                    done[guid][spellname] = nil
                end
            end
        end
    end
    if done[guid] and not next(done[guid]) then
        done[guid] = nil
    end
    if next(done) then
        if not EventFrame:GetScript("OnUpdate") then
            EventFrame:SetScript("OnUpdate", OhSnap.Update)
        end
    else
        if EventFrame:GetScript("OnUpdate") then
            EventFrame:SetScript("OnUpdate",nil)
        end
    end
end

function anchor:PLAYER_TARGET_CHANGED(event)
    -- Wipe the table clean when out of arena
    local arena = IsActiveBattlefieldArena()
    if not arena then table.wipe(done) end
    for idx,uid in ipairs(targetMsgs) do
        OhSnap:DelMessage(uid)
    end
    table.wipe(targetMsgs)
    if UnitExists("target") and ((UnitIsPlayer("target") and not UnitIsFriend("player", "target")) or OhSnapDB.TestMode) then
        unitscan("target")
    end
end

function anchor:UNIT_AURA(event, unit)
    if unit == "target" or unit:match("^arena") then
        unitscan(unit)
    end
end

function anchor:PLAYER_ENTERING_WORLD()
    if not OhSnapAnchor:IsVisible() then OhSnap:Clear() end
	OhSnap:ToggleAnchor(OhSnapDB["ShowAnchor"])
	--OhSnap:RestorePosition()
end

function anchor:PLAYER_ALIVE()
	if not OhSnapAnchor:IsVisible() then OhSnap:Clear() end
end

function anchor:PLAYER_LOGIN(event,addon)
	OhSnap:RestorePosition()
end


function anchor:INCOMING_SPELLCAST(event, ...)
    local arena = IsActiveBattlefieldArena()
    -- When we get a unit casting event, store the GUID
    if event == "UNIT_SPELLCAST_START" then
        local unit, spell = ...
        local guid = UnitGUID(unit)
        guidmap[guid] = unit
        return
    end
    -- Use COMBAT_LOG_EVENT_UNFILTERED to actually catch the spellcasts from our non-targets
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local timestamp, cevent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = ...
        if cevent == "SPELL_CAST_START" then
            local unit = guidmap[sourceGUID]
            if unit and UnitGUID(unit) == sourceGUID and UnitIsEnemy("player", unit) then
                -- This is a unit we have an ID for at the moment so grab the target information
                local destName = UnitName(unit .. "target")
                local isUnit = destName and UnitName(destName)
                local spellId, spellName = select(9, ...)
                local spellTexture = select(3, GetSpellInfo(spellId))
                local srcName = sourceName
                local guid = sourceGUID
                if arena and not destName and UnitIsEnemy("player", unit) then
                    -- This is here to ensure we don't skip it
                    destName = "Unknown"
                elseif arena and isUnit and (not UnitPlayerOrPetInParty(destName)) and (not UnitIsUnit(destName, "player")) then
                    -- They are casting on someone we don't care about
                    return
                elseif not arena and isUnit and not UnitIsUnit(destName, "player") then
                    -- Ignore anything that isn't targeting us
                    return
                end
                do
                    local prio = 1
                    for k,v in pairs(OhSnap.spells[prio]) do
                        local spellname = GetSpellInfo(k)
                        if spellname == spellName then
                            if not done[guid][spellname] then
								local class = select(2, UnitClass(unit)) or "PRIEST"
                                local classcolor = RAID_CLASS_COLORS[class]
                                local r,g,b = classcolor.r, classcolor.g, classcolor.b
                                local msg = string.format("%s: |T%s:0|t %s -> %s", srcName:match("[^-]+"), spellTexture, spellName, destName)
                                local uid = OhSnap:AddMessage(msg, prio, r, g, b)
                                done[guid][spellname] = uid
                                if targetMsg then 
                                    table.insert(targetMsgs, uid)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

anchor.UNIT_SPELLCAST_START = anchor.INCOMING_SPELLCAST
anchor.COMBAT_LOG_EVENT_UNFILTERED = anchor.INCOMING_SPELLCAST

EventFrame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
EventFrame:RegisterEvent("UNIT_SPELLCAST_FAILED")
EventFrame:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
EventFrame:RegisterEvent("UNIT_SPELLCAST_STOP")
EventFrame:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

EventFrame:SetScript("OnEvent",function(self, event, ...)
    local guid, spellname
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local cevent, srcGUID = ...
        if cevent == "SPELL_CAST_SUCCESS" or cevent == "SPELL_CAST_FAILED" then
            spellname = select(10, ...)
            guid = srcGUID
        else
            return
        end
    else
        local unit, name = ...
        if unit == "target" and UnitExists("targettarget") and UnitIsUnit("targettarget", "player") then
            guid = UnitGUID(unit)
            spellname = name
        else
            return
        end
    end
    if done[guid] and done[guid][spellname] then
        local uid = done[guid][spellname]
        OhSnap:DelMessage(uid)
        done[guid][spellname] = nil
    end
end)

function OhSnap:SavePosition()
    local f = OhSnapAnchor
    local x,y = f:GetLeft(), f:GetTop()
    local s = f:GetEffectiveScale()
    
    x,y = x*s,y*s
    
	local opt = OhSnapDB.Position
	if not opt then 
		OhSnapDB.Position = {}
		opt = OhSnapDB.Position
	end
    opt.PosX = x
    opt.PosY = y
end

function OhSnap:RestorePosition()
	local f = OhSnapAnchor
	local opt = OhSnapDB.Position
	if not opt then 
		OhSnapDB.Position = {}
		opt = OhSnapDB.Position
	end

	local x = opt.PosX
	local y = opt.PosY

    local s = f:GetEffectiveScale()
        
    if not x or not y then
        f:ClearAllPoints()
        f:SetPoint("CENTER", 0, 300)
        return 
    end

    x,y = x/s,y/s

    f:ClearAllPoints()
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
end

function OhSnap:ToggleAnchor(value)
	if value then
		if OhSnapAnchor:IsVisible() then return end
		OhSnapAnchor:Show()
		OhSnapDB["ShowAnchor"] = value
		TestMessage1 = OhSnap:AddMessage("|TInterface\\Icons\\INV_Misc_Bone_HumanSkull_02:0|t Dangerous spells",1,1,0,0)
		TestMessage2 = OhSnap:AddMessage("|TInterface\\Icons\\INV_Misc_Bone_HumanSkull_02:0|t Noticeable buffs",2,1,1,1)
		TestMessage3 = OhSnap:AddMessage("|TInterface\\Icons\\INV_Misc_Bone_HumanSkull_02:0|t Annoying buffs",3,1,1,0)
		TestMessage4 = OhSnap:AddMessage("|TInterface\\Icons\\INV_Misc_Bone_HumanSkull_02:0|t Profitable debuffs",4,0,1,0)
	else
		OhSnapAnchor:Hide()
		OhSnapDB["ShowAnchor"] = value
		OhSnap:DelMessage(TestMessage1)
		OhSnap:DelMessage(TestMessage2)
		OhSnap:DelMessage(TestMessage3)
		OhSnap:DelMessage(TestMessage4)
		TestMessage1 = nil
		TestMessage2 = nil
		TestMessage3 = nil
		TestMessage4 = nil
	end
end

local TestMessage1,TestMessage2,TestMessage3,TestMessage4
SLASH_OhSnap1 = "/ohsnap"
SlashCmdList["OhSnap"] = function(name)
	if name == "hide" then
		OhSnap:ToggleAnchor(false)
	elseif name == "show" then
		OhSnap:ToggleAnchor(true)
	elseif name == "gui" then
		InterfaceOptionsFrame_OpenToCategory(OhSnap_Panel)
	elseif not name or name == "" then
		ChatFrame1:AddMessage("OhSnap slashcommand:")
		ChatFrame1:AddMessage(" /ohsnap show - will show the anchor")
		ChatFrame1:AddMessage(" /ohsnap hide - will hide the anchor")
		ChatFrame1:AddMessage(" /ohsnap gui - will open the GUI")
	end
end