if (not OhSnap) then
	OhSnap = {}
end
local lib = LibStub("LibDefaults")
local Portfolio = LibStub and LibStub("Portfolio")
if not Portfolio then return end

local Sizex,Sizey = 0,-15
local Headerx,Headery = 0,-25
local Outlinex,Outliney = 135,7
local Stylex,Styley = 15,7

local myCallback = function() OhSnap:Update() end;

local optionTable = {
    id="OhSnap";
    text="OhSnap";
    addon="OhSnap";
    about=true;
    options = {
        {
            id = "Anchor";
            text = "Show Anchor";
            tooltipText = "Show the Alerts anchor of OhSnap";
            type = CONTROLTYPE_CHECKBOX;
            defaultValue = "1";
			callback = function(value) OhSnap:ToggleAnchor(value) end;
        };
		{
			id = "Header1";
			text = "Priority 1";
			type = CONTROLTYPE_HEADER;
			point = {"TOPLEFT", "Anchor", "BOTTOMLEFT", 0, -10};
		};
		{
			id = "Size1";
			text = "Size %s";
			tooltipText = "Size of priority 1.";
			minText = "8";
			maxText = "24";
			minValue = 8;
			maxValue = 24;
			valueStep = 1;
			type = CONTROLTYPE_SLIDER;
			defaultValue = 24;
			callback = myCallback;
			point = {"TOPLEFT", "Header1", "BOTTOMLEFT", sizex, sizey};
		};
		{
			id = "Style1";
			headerText = "Style";
			tooltipText = "You can select which font you want to use";
			type = CONTROLTYPE_DROPDOWN;
			defaultValue = "Fonts\\FRIZQT__.TTF";
			menuList = {
				{
					isTitle = 1;
					text = "Font style";
				};
				{
					text = "FRIZQT";
					value = "Fonts\\FRIZQT__.TTF";
				};
				{
					text = "ARIALN";
					value = "Fonts\\ARIALN.TTF";
				};
				{
					text = "skurri";
					value = "Fonts\\skurri.ttf";
				};
				{
					text = "MORPHEUS";
					value = "Fonts\\MORPHEUS.ttf";
				};
			};
			callback = myCallback;
			point = {"TOPLEFT", "Size1", "TOPRIGHT", Stylex, Styley};
		};
		{
			id = "Outline1";
			headerText = "Outline";
			tooltipText = "You can select which font you want to use";
			type = CONTROLTYPE_DROPDOWN;
			defaultValue = "THICKOUTLINE";
			menuList = {
				{
					isTitle = 1;
					text = "Font outline";
				};
				{
					text = "Thick";
					value = "THICKOUTLINE";
				};
				{
					text = "Thin";
					value = "OUTLINE";
				};
				{
					text = "None";
					value = "";
				};
			};
			callback = myCallback;
			point = {"TOPLEFT", "Size1", "TOPRIGHT", Outlinex, Outliney};
		};

		{
			id = "Header2";
			text = "Priority 2";
			type = CONTROLTYPE_HEADER;
			point = {"TOPLEFT", "Size1", "BOTTOMLEFT", Headerx, Headery};
		};
		{
			id = "Size2";
			text = "Size %s";
			tooltipText = "Size of priority 2.";
			minText = "8";
			maxText = "24";
			minValue = 8;
			maxValue = 24;
			valueStep = 1;
			type = CONTROLTYPE_SLIDER;
			defaultValue = 18;
			callback = myCallback;
			point = {"TOPLEFT", "Header2", "BOTTOMLEFT", Sizex, Sizey};
		};
		{
			id = "Style2";
			headerText = "Style";
			tooltipText = "You can select which font you want to use";
			type = CONTROLTYPE_DROPDOWN;
			defaultValue = "Fonts\\FRIZQT__.TTF";
			menuList = {
				{
					isTitle = 1;
					text = "Font style";
				};
				{
					text = "FRIZQT";
					value = "Fonts\\FRIZQT__.TTF";
				};
				{
					text = "ARIALN";
					value = "Fonts\\ARIALN.TTF";
				};
				{
					text = "skurri";
					value = "Fonts\\skurri.ttf";
				};
				{
					text = "MORPHEUS";
					value = "Fonts\\MORPHEUS.ttf";
				};
			};
			callback = myCallback;
			point = {"TOPLEFT", "Size2", "TOPRIGHT", Stylex, Styley};
		};
		{
			id = "Outline2";
			headerText = "Outline";
			tooltipText = "You can select which font you want to use";
			type = CONTROLTYPE_DROPDOWN;
			defaultValue = "OUTLINE";
			menuList = {
				{
					isTitle = 1;
					text = "Font outline";
				};
				{
					text = "Thick";
					value = "THICKOUTLINE";
				};
				{
					text = "Thin";
					value = "OUTLINE";
				};
				{
					text = "None";
					value = "";
				};
			};
			callback = myCallback;
			point = {"TOPLEFT", "Size2", "TOPRIGHT", Outlinex, Outliney}
		};

		{
			id = "Header3";
			text = "Priority 3";
			type = CONTROLTYPE_HEADER;
			point = {"TOPLEFT", "Size2", "BOTTOMLEFT", Headerx, Headery};
		};
		{
			id = "Size3";
			text = "Size %s";
			tooltipText = "Size of priority 3.";
			minText = "8";
			maxText = "24";
			minValue = 8;
			maxValue = 24;
			valueStep = 1;
			type = CONTROLTYPE_SLIDER;
			defaultValue = 14;
			callback = myCallback;
			point = {"TOPLEFT", "Header3", "BOTTOMLEFT", Sizex, Sizey};
		};
		{
			id = "Style3";
			headerText = "Style";
			tooltipText = "You can select which font you want to use";
			type = CONTROLTYPE_DROPDOWN;
			defaultValue = "Fonts\\FRIZQT__.TTF";
			menuList = {
				{
					isTitle = 1;
					text = "Font style";
				};
				{
					text = "FRIZQT";
					value = "Fonts\\FRIZQT__.TTF";
				};
				{
					text = "ARIALN";
					value = "Fonts\\ARIALN.TTF";
				};
				{
					text = "skurri";
					value = "Fonts\\skurri.ttf";
				};
				{
					text = "MORPHEUS";
					value = "Fonts\\MORPHEUS.ttf";
				};
			};
			callback = myCallback;
			point = {"TOPLEFT", "Size3", "TOPRIGHT", Stylex, Styley};
		};
		{
			id = "Outline3";
			headerText = "Outline";
			tooltipText = "You can select which font you want to use";
			type = CONTROLTYPE_DROPDOWN;
			defaultValue = "OUTLINE";
			menuList = {
				{
					isTitle = 1;
					text = "Font outline";
				};
				{
					text = "Thick";
					value = "THICKOUTLINE";
				};
				{
					text = "Thin";
					value = "OUTLINE";
				};
				{
					text = "None";
					value = "";
				};
			};
			callback = myCallback;
			point = {"TOPLEFT", "Size3", "TOPRIGHT", Outlinex, Outliney}
		};

		{
			id = "Header4";
			text = "Priority 4";
			type = CONTROLTYPE_HEADER;
			point = {"TOPLEFT", "Size3", "BOTTOMLEFT", Headerx, Headery};
		};
		{
			id = "Size4";
			text = "Size %s";
			tooltipText = "Size of priority 4.";
			minText = "8";
			maxText = "24";
			minValue = 8;
			maxValue = 24;
			valueStep = 1;
			type = CONTROLTYPE_SLIDER;
			defaultValue = 11;
			callback = myCallback;
			point = {"TOPLEFT", "Header4", "BOTTOMLEFT", Sizex, Sizey};
		};
		{
			id = "Style4";
			headerText = "Style";
			tooltipText = "You can select which font you want to use";
			type = CONTROLTYPE_DROPDOWN;
			defaultValue = "Fonts\\FRIZQT__.TTF";
			menuList = {
				{
					isTitle = 1;
					text = "Font style";
				};
				{
					text = "FRIZQT";
					value = "Fonts\\FRIZQT__.TTF";
				};
				{
					text = "ARIALN";
					value = "Fonts\\ARIALN.TTF";
				};
				{
					text = "skurri";
					value = "Fonts\\skurri.ttf";
				};
				{
					text = "MORPHEUS";
					value = "Fonts\\MORPHEUS.ttf";
				};
			};
			callback = myCallback;
			point = {"TOPLEFT", "Size4", "TOPRIGHT", Stylex, Styley};
		};
		{
			id = "Outline4";
			headerText = "Outline";
			tooltipText = "You can select which font you want to use";
			type = CONTROLTYPE_DROPDOWN;
			defaultValue = "OUTLINE";
			menuList = {
				{
					isTitle = 1;
					text = "Font outline";
				};
				{
					text = "Thick";
					value = "THICKOUTLINE";
				};
				{
					text = "Thin";
					value = "OUTLINE";
				};
				{
					text = "None";
					value = "";
				};
			};
			callback = myCallback;
			point = {"TOPLEFT", "Size4", "TOPRIGHT", Outlinex, Outliney};
		};
		
	};
    savedVarTable = "OhSnapDB";
}

Portfolio.RegisterOptionSet(optionTable)