OhSnap = {}
OhSnap.spells = {}
-- Debuffs tracked
OhSnap.spells[4] = {
	-- Paladin
		[25771] = {msg = "Can't Bubble"},
	-- Mage
		[41425] = {msg = "Can't Ice Block"},
}
-- Buffs tracked
OhSnap.spells[3] = {
	-- Death Knight
		-- Army of the Dead
		[42650] = {msg = "Braiiiins!", class = "DEATHKNIGHT"},
		-- Anti-Magic Shell
		[48707] = {msg = "75% Magic Shield", class = "DEATHKNIGHT"},
		-- Icebound Fortitude
		[48792] = {msg = "20%+ Shield", class = "DEATHKNIGHT"},
		-- Hysteria
		[49016] = {msg = "20% Damage"},
		-- Dancing Rune Weapon
		[49028] = {class = "DEATHKNIGHT"},
		-- Lichborne
		[49039] = {msg = "Fear Immune, |cFF00FF00Shackleable|r", class = "DEATHKNIGHT"},
		-- Deathchill
		[49796] = {msg = "100% Crit", class = "DEATHKNIGHT"},
	-- Hunter
		-- Deterrence
		[19263] = {msg = "100% Parry, 100% Deflect", class = "HUNTER"},
	-- Mage
		-- Mana Shield
		[43020] = {msg = "Absorbs damage", class = "MAGE"},
		-- Ice Barrier
		[43039] = {msg = "Absorbs damage", class = "MAGE"},
	-- Paladin
		-- Divine Protection
		[498] = {msg = "50% Shield"},
		-- Hand of Freedom
		[1044] = {msg = "Snare Immune"},
		-- Hand of Sacrifice
		[6940] = {msg = "30% Shield"},
		-- Aura Mastery
		[31821] = {msg = "Silence Immune"},
		-- Avenging Wrath
		[31884] = {msg = "+20% Damage, |cFF00FF00Stealable|r", class = "PALADIN"},
		-- Divine Aegis
		[47515] = {msg = "Absorbs damage"},
		-- Sacred Shield
		[53601] = {msg = "Absorbs damage"},
		-- Divine Sacrifice
		[64205] = {msg = "30% Shield"},
	-- Priest
		-- Fear Ward
		[6346] = {msg = "Fear Immune"},
		-- Pain Suppression
		[33206] = {msg = "40% Shield"},
		-- Dispersion
		[47585] = {msg = "90% Shield", class = "PRIEST"},
		-- Power Word: Shield
		[48066] = {msg = "Absorbs damage"},
	-- Rogue
		-- Killing Spree
		[13877] = {msg = "AoE, +20% Haste", class = "ROGUE"},
		-- Blade Flurry
		[14177] = {msg = "100% Crit", class = "ROGUE"},
		-- Evasion
		[26669] = {msg = "+50% Dodge, -25% Ranged", class = "ROGUE"},
		-- Cold Blood
		[51690] = {msg = "+20% Damage", class = "ROGUE"},
	-- Shaman
		-- Grounding Totem Effect
		[8178] = {msg = "Grounded"},
		-- Shamanistic Rage
		[30823] = {msg = "30% Shield", class = "SHAMAN"},
	-- Warlock
		-- Nether Protection
		[30302] = {msg = "30% Magic Shield", class = "WARLOCK"},
		-- Metamorphosis
		[47241] = {msg = "+20% Damage, 600% Armor", class = "WARLOCK"},
		-- Sacrifice
		[47986] = {msg = "Absorbs damage", class = "WARLOCK"},
	-- Warrior
		-- Shield Wall
		[871] = {msg = "60% Shield", class = "WARRIOR"},
		-- Recklessness
		[1719] = {msg = "100% Crit", class = "WARRIOR"},
		-- Enrage
		[13048] = {msg = "+10% Damage", class = "WARRIOR"},
		-- Berserker Rage
		[18499] = {msg = "CC Immune", class = "WARRIOR"},

	-- Misc
		-- Honorless Target
		[2479] = {msg = "Do it."},
		-- Honorless Target
		[46705] = {msg = "Do it."},
}
OhSnap.spells[2] = {
	-- Druid
		-- Dash
		[33357] = {msg = "+Speed", class = "DRUID"},
		-- Nature's Grasp
		[53312] = {msg = "|cFFFF0000Hit roots you|r", class = "DRUID"},
	-- Hunter
		-- Bestial Wrath
		[19574] = {msg = "Unstoppable"},
	-- Mage
		-- Invisibility
		[66] = {msg = "|cFFFF0000Disappearing|r", class = "MAGE"},
		-- Presence of Mind
		[12043] = {msg = "|cFFFF0000Instant cast|r", class = "MAGE"},
		-- Ice Block
		[45438] = {msg = "|cFFFF0000Immune|r, |cFF00FF00Dispellable|r", class = "MAGE"},
		-- Blazing Speed
		[31642] = {msg = "+Speed", class = "MAGE"},
	-- Paladin
		-- Divine Shield
		[642] = {msg = "|cFFFF0000Immune|r, |cFF00FF00Dispellable|r", class = "PALADIN"},
		-- Hand of Protection
		[10278] = {msg = "Melee Immune, |cFF00FF00pacified|r"},
	-- Priest
		-- Guardian Spirit
		[47788] = {msg = "|cFFFF0000Unkillable|r", class = "PRIEST"},
	-- Rogue
		-- Sprint
		[11305] = {msg = "+Speed", class = "ROGUE"},
		-- Cloak of Shadows
		[31224] = {msg = "90% Resist", class = "ROGUE"},
	-- Shaman
		-- Bloodlust
		[2825] = {msg = "30% Haste"},
		-- Heroism
		[32182] = {msg = "30% Haste"},
	-- Warrior
		-- Retaliation
		[20230] = {msg = "Returns damage", class = "WARRIOR"},
		-- Spell Reflection
		[23920] = {msg = "|cFFFF0000No spells!|r", class = "WARRIOR"},
		-- Bladestorm
		[46924] = {msg = "AoE, Unstoppable", class = "WARRIOR"},
		
	-- Misc
		-- Drink
		[43706] = {msg = "|cFFFF0000Resting|r"},
		
	-- TEST SPELLS
		-- Banner of the Horde
		[61574] = {msg = "|cFF00AEEFFor Gnomeregan!|r"},
		-- Banner of the Alliance
		[61573] = {msg = "|cFFFF0000For the Horde!|r"},
}
-- Spells tracked
OhSnap.spells[1] = {
	-- Druid
		-- Hibernate
		[18658] = {},
		-- Cyclone
		[33786] = {},
		-- Revive
		[50763] = {},
		-- Entangling Roots
		[53308] = {},
	-- Hunter
		-- Revive Pet
		[982] = {},
		-- Scare Beast
		[14327] = {},
	-- Mage
		-- Polymorph
		[12825] = {},
		-- Polymorph: Turtle
		[28271] = {},
		-- Polymorph: Pig
		[28272] = {},
		-- Polymorph: Serpent
		[61025] = {},
		-- Polymorph: Black Cat
		[61305] = {},
		-- Polymorph: Rabbit
		[61721] = {},
		-- Polymorph: Turkey
		[61780] = {},
	-- Paladin
		-- Redemption
		[48950] = {},
	-- Priest
		-- Mind Control
		[605] = {},
		-- Mana Burn
		[8129] = {},
		-- Resurrection
		[48171] = {},
	-- Shaman
		-- Hex
		[51514] = {},
		-- Feral Spirit
		[51533] = {},
	-- Warlock
		-- Summon Imp
		[688] = {},
		-- Summon Felhunter
		[691] = {},
		-- Summon Voidwalker
		[697] = {},
		-- Summon Succubus
		[712] = {},
		-- Drain Mana
		[5138] = {},
		-- Fear
		[6215] = {},
		-- Banish
		[17928] = {},
		-- Drain Life
		[18647] = {},
		-- Summon Felguard
		[30146] = {},
		-- Howl of Terror
		[47857] = {},

    -- DIRECT DAMAGE FOR TESTING ONLY
        [49238] = {},
        [48461] = {},
        [47809] = {},
}
