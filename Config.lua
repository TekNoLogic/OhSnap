local LibSimpleOptions = LibStub("LibSimpleOptions-1.0")
local anchor
local function Options(self, anchor)
    local title, subText = self:MakeTitleTextAndSubText("OhSnap", "OhSnap Configuration")
   
   	local reset = self:MakeButton(
	    'name', "Reset",
	    'description', "Resets settings to default",
	    'func', function()
			OhSnapDB = {
				[1] = {"Fonts\\FRIZQT__.TTF", 24,"THICKOUTLINE"},
				[2] = {"Fonts\\FRIZQT__.TTF", 18,"OUTLINE"},
				[3] = {"Fonts\\FRIZQT__.TTF", 14,"OUTLINE"},
				[4] = {"Fonts\\FRIZQT__.TTF", 11,"OUTLINE"},
				["ShowAnchor"] = true
			}
			OhSnap:Update()
			self:Refresh()
	end)
	reset:SetPoint("TOPRIGHT", self, "TOPRIGHT", -10, -10)	
	
	local lock = self:MakeToggle(
		'name', 'Show anchor',
		'description', 'Toggle the visibility of text anchor',
		'default', false,
		'getFunc', function() return OhSnapDB["ShowAnchor"] end,
		'setFunc', function(value) OhSnap:ToggleAnchor(value) end
	)
	lock:SetPoint("TOPLEFT", subText, "BOTTOMLEFT", 0, -5)

	local f = CreateFrame("Frame")
    for i=1,4 do
	
    local slider = self:MakeSlider(
        'name', "Size",
        'description', "Size of font",
        'minText', '8',
        'maxText', '24',
        'minValue', 8,
        'maxValue', 24,
        'step', 1,
        'default', OhSnap.Defaults[i][2],
        'getFunc', function(value) value = OhSnapDB[i][2] return OhSnapDB[i][2] end,    
        'setFunc', function(value) OhSnapDB[i][2] = value; OhSnap:Update() end,
        'currentTextFunc', function(value) return value
    end)
    if not anchor then slider:SetPoint("TOPLEFT", subText, "BOTTOMLEFT", 0, -65)
    else slider:SetPoint("TOP", anchor, "BOTTOM", 0, -65) end
    anchor = slider

	local text = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	text:SetPoint("BOTTOMLEFT",anchor,"TOPLEFT",0,15)
	text:SetText("Priority "..i.." Font settings")
	text:SetParent(self)

	local dropdown = self:MakeDropDown(
		'name', "Font",
	    'description', "Select font to be used",
	    'values', {
			'Fonts\\FRIZQT__.TTF', "Frizqt",
			'Fonts\\ARIALN.TTF', "Arialn",
			'Fonts\\skurri.ttf', "Skurri",
			'Fonts\\MORPHEUS.ttf', "Morpheus",
	     },
	    'default', OhSnapDB[i][1],
		'getFunc', function() 
			return OhSnapDB[i][1] 
		end,
	    'setFunc', function(value)
			if value == 'Fonts\\FRIZQT__.TTF' or value == 'Fonts\\ARIALN.TTF' or value == 'Fonts\\skurri.ttf' or value == 'Fonts\\MORPHEUS.ttf' then OhSnapDB[i][1] = value; OhSnap:Update() end
	end)
	dropdown:SetPoint("LEFT", anchor, "RIGHT", -5, -10)	

	local dropdown = self:MakeDropDown(
		'name', "Outline",
	    'description', "Font Outline",
	    'values', {
			'THICKOUTLINE', "Thick",
			'OUTLINE', "Thin",
			'', "None",
	     },
	    'default', OhSnapDB[i][3],
		'getFunc', function() 
			return OhSnapDB[i][3] 
		end,
	    'setFunc', function(value)
			if value == 'THICKOUTLINE' or value == 'OUTLINE' or value == '' then OhSnapDB[i][3] = value; OhSnap:Update() end
	end)
	dropdown:SetPoint("LEFT", anchor, "RIGHT", 110, -10)	

    end

--[[
    local checkbox1 = self:MakeToggle(
        'name', 'Outline',
        'description', 'Enable Outline',
        'default', true,
        'getFunc', function() return OhSnapDB[1]["outline"] end,
        'setFunc', function(value) OhSnapDB[1]["outline"] = value end
    )
    checkbox1:SetPoint("LEFT",OhSnapSlider1,"RIGHT",5,0)

    local checkbox2 = self:MakeToggle(
        'name', 'Thickoutline',
        'description', 'Enable Thickoutline',
        'default', false,
        'getFunc', function() return OhSnapDB[1]["thickoutline"] end,
        'setFunc', function(value) OhSnapDB[1]["thickoutline"] = value end
    )
    checkbox2:SetPoint("LEFT",checkbox1,"RIGHT",50,0)
]]    
end

LibSimpleOptions.AddOptionsPanel("OhSnap", function(self) Options(self, anchor) end)
