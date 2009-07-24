local LibSimpleOptions = LibStub("LibSimpleOptions-1.0")
local anchor
local function Options(self, anchor)
    local title, subText = self:MakeTitleTextAndSubText("OhSnap", "OhSnap Configuration")
   
	local lock = self:MakeToggle(
		'name', 'Show anchor',
		'description', 'Visibility of text anchor',
		'default', true,
		'getFunc', function() return OhSnapDB["ShowAnchor"] end,
		'setFunc', function(value) OhSnap:ToggleAnchor(value) end
	)
	lock:SetPoint("TOPLEFT", subText, "BOTTOMLEFT", 0, -5)

	local test= self:MakeToggle(
		'name', 'Test mode',
		'description', 'Show messages on friendly targets (ie. Target Dummies)',
		'default', false,
		'getFunc', function() return OhSnapDB["TestMode"] end,
		'setFunc', function(value) OhSnapDB["TestMode"] = value; OhSnap:Update() end
	)
	test:SetPoint("LEFT", lock, "RIGHT", 250, 0)

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
				'OUTLINE, THICKOUTLINE', "Thick",
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
end

LibSimpleOptions.AddOptionsPanel("OhSnap", function(self) Options(self, anchor) end)