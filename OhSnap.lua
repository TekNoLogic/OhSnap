OhSnap = {}

local messages = {}
local rows = {}
local uidcount = 0
local fonts = {
    [0] = "GameFontNormal",
    [1] = "BossEmoteNormalHuge",
	[2] = "GameFontHighlight",
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
        pri = priority or 0,
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

OhSnap.spells = {
    -- Icebound Fortitude, Anti-Magic Shell, Dancing Rune Weapon, Avenging Wrath, Hand of Protection, 
    -- Divine Shield, Hand of Freedom, Divine Protection, Hand of Sacrifice, Aura Mastery, 
    -- Divine Sacrifice, Shield Reflect, Recklessness, Berserker Rage, Shield Wall,
    -- Retaliation, Nature's Grasp, Dispersion, Guardian Spirit, Pain Suppression,
    -- Metamorphosis, Heroism, Bloodlust, Feral Spirit, Shamanistic Rage,
    -- Bestial Wrath, Deterrence, Presence of Mind, Invisibility, Killing Spree, 
    -- Blade Furry, Cold Blood, Cloak of Shadows, Sprint, Evasion,
    -- Bladestorm, Honorless Target, Honorless Target, Power Word: Shield, Ice Barrier,
    -- Ice Block, Mana Shield, Divine Aegis, Sacred Shield, Nether Protection

    48792,48707,49028,31884,10278,
    642,1044,498,6940,31821,
    64205,23920,1719,18499,871,
    20230,53312,47585,47788,33206,
    47241,32182,2825,51533,30823,
    19574,19263,12043,66,51690,
    13877,14177,31224,11305,26669,
    46924,2479,46705,48066,43039,
    45438,43020,47515,53601,30302,
    8178,

    -- TEST SPELLS
    -- 61574,      -- Banner of the Horde
}

-- Automatically create the sub-tables for GUID
local done = setmetatable({}, {__index = function(t,k)
    local new = {}
    rawset(t, k, new)
    return new
end})
local targetMsgs = {}

anchor:RegisterEvent("PLAYER_TARGET_CHANGED")
anchor:RegisterEvent("UNIT_AURA")
anchor:SetScript("OnEvent", function(self, event, ...)
    if self[event] then return self[event](self, event, ...) end
end)

local function unitscan(unit)
    for k,v in pairs(OhSnap.spells) do
        local spellname = GetSpellInfo(v)
        local guid = UnitGUID(unit)

        -- If the spell is on the given unit, and its not already done
        if UnitAura(unit, spellname) then
            if not done[guid][spellname] then
                local classcolor = RAID_CLASS_COLORS[select(2,UnitClass(unit))]
                local r,g,b = classcolor.r,classcolor.g,classcolor.b
                local uid = OhSnap:AddMessage(UnitName(unit).. ": |T"..select(3,GetSpellInfo(v))..":0|t".." "..GetSpellInfo(v),0,r,g,b)
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

function anchor:PLAYER_TARGET_CHANGED(event)
    for idx,uid in ipairs(targetMsgs) do
        OhSnap:DelMessage(uid)
    end
    table.wipe(targetMsgs)

    if UnitExists("target") and not UnitIsFriend("player", "target") then
        unitscan("target")
    end
end

function anchor:UNIT_AURA(event, unit)
    if unit == "target" or unit:match("^arena") then
        unitscan(unit)
    end
end

print("OhSnap! PvP spell tracker loaded!")
