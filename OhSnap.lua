--OhSnap = {}

local messages = {}
local rows = {}
local uidcount = 0
local fonts = {
	[1] = "GameFontNormal",
	[2] = "GameFontNormalLarge",
	[3] = "WorldMapTextFont",
--	[3] = "BossEmoteNormalHuge",
}

-- Set up default priority fonts
setmetatable(fonts, {__index = function(t,k) return rawget(t, 0) end})

-- Create the anchor frame early
local anchor = CreateFrame("Frame", "OhSnapAnchor", UIParent)

function OhSnap:Initialize()
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
    anchor:SetScript("OnMouseDown", function(self, button)
        self:StartMoving()
    end)

    anchor:SetScript("OnMouseUp", function(self, button)
        self:StopMovingOrSizing()
    end)
end

-- Adds a message to the alert frame, returns a uid
function OhSnap:AddMessage(msg, priority, r, g, b, a)
    local entry = {
        msg = msg or "Empty message", 
        pri = priority or 1,
        count = uidcount,
        r = r or 1,
        g = g or 1,
        b = b or 1,
        a = a or 1,
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
    self:Update()
end

local function sortFunc(a, b)
    if a.pri == b.pri then
        return a.count < b.count
    else
        return a.pri >= b.pri
    end
end

-- Updates the frame to display
function OhSnap:Update()
    -- Create enough frames, if necessary
    for i=#rows + 1, #messages, 1 do
        local row = CreateFrame("Frame")
        row.text = row:CreateFontString(nil, "HIGHLIGHT") -- "OVERLAY"
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
        row.text:SetFontObject(fonts[entry.pri])
        row.text:SetText(entry.msg)
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

-- Automatically create the sub-tables for GUID
local done = setmetatable({}, {__index = function(t,k)
    local new = {}
    rawset(t, k, new)
    return new
end})
local targetMsgs = {}

anchor:RegisterEvent("PLAYER_TARGET_CHANGED")
anchor:RegisterEvent("UNIT_AURA")
anchor:RegisterEvent("PLAYER_ENTERING_WORLD")
anchor:SetScript("OnEvent", function(self, event, ...)
    if self[event] then return self[event](self, event, ...) end
end)

local function unitscan(unit)
	for i=1,2 do
		for k,v in pairs(OhSnap.spells[i]) do
			local spellname = GetSpellInfo(k)
			local guid = UnitGUID(unit)

			-- If the spell is on the given unit, and its not already done
			if not UnitIsFriend("player", unit) and UnitAura(unit, spellname) then
				if not done[guid][spellname] then
					local classcolor = RAID_CLASS_COLORS[select(2,UnitClass(unit))]
					local r,g,b = classcolor.r,classcolor.g,classcolor.b
					local uid = OhSnap:AddMessage(UnitName(unit).. ": |T"..select(3,UnitAura(unit, spellname))..":0|t".." "..UnitAura(unit, spellname).." ("..v..")",i,r,g,b)
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

local targetFOO
function anchor:PLAYER_TARGET_CHANGED(event)
    for idx,uid in ipairs(targetMsgs) do
        OhSnap:DelMessage(uid)
    end
    table.wipe(targetMsgs)

    if UnitExists("target") and not UnitIsFriend("player", "target") then
        unitscan("target")
		targetFOO = UnitGUID("target")
    end
end

function anchor:UNIT_AURA(event, unit)
    if unit == "target" or unit:match("^arena") then
        unitscan(unit)
    end
end

function anchor:PLAYER_ENTERING_WORLD()
--[[
	if IsActiveBattlefieldArena() then 
		InstantVictoryCheat()
	else 
		ActiveGMLasers()
	end
]]
	if not UnitExists("target") then OhSnap:Clear() end
end

local function checktarget(guid)
	-- needs arena-unit check
    if guid == targetFOO then return true end
end

local player = UnitGUID("player")
anchor:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	
function anchor:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, minievent, guidsource, source, sourceflags, guidtarget, target, targetflags, ...)
    if minievent == "SPELL_CAST_START" and guidtarget == player then
        if checktarget(guidsource) then
            local spellID,spellName = ...
            print(spellName.. " on you!")
        end
    end
end

print("OhSnap! PvP spell tracker loaded!")
