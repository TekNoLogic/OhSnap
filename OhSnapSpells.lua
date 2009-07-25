OhSnap = {}
OhSnap.spells = {}
-- Debuffs tracked
OhSnap.spells[4] = {
	-- Paladin
		-- Forbearance
		[25771] = {msg = "Can't be Shielded"},
	-- Mage
		-- Hypothermia
		[41425] = {msg = "Can't Ice Block"},
	-- Priest
		-- Weakened Soul
		[6788] = {msg = "Can't be Shielded"},
	-- Shaman
		-- Exhaustion
		[57723] = {msg = "Can't use Heroism"},
		-- Sated
		[57724] = {msg = "Can't use Bloodlust"},
}
-- Buffs tracked
OhSnap.spells[3] = {
	-- Death Knight
		-- Army of the Dead
		[42650] = {msg = "Braiiiins!", class = "DEATHKNIGHT"},
		-- Anti-Magic Shell
		[48707] = {msg = "75% Magic Shield", class = "DEATHKNIGHT"},
		-- Hysteria
		[49016] = {msg = "+20% Damage"},
		-- Lichborne
		[49039] = {msg = "Fear Immune, Shackleable", class = "DEATHKNIGHT"},
		-- Deathchill
		[49796] = {msg = "100% Crit", class = "DEATHKNIGHT"},
	-- Hunter
		-- Deterrence
		[19263] = {msg = "100% Parry, 100% Deflect", class = "HUNTER"},
	-- Paladin
		-- Hand of Freedom
		[1044] = {msg = "Snare Immune"},
		-- Aura Mastery
		[31821] = {msg = "Silence Immune"},
		-- Avenging Wrath
		[31884] = {msg = "+20% Damage", class = "PALADIN"},
	-- Priest
		-- Fear Ward
		[6346] = {msg = "Fear Immune"},
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
		[8178] = {msg = "Grounding Totem", multi = true},
	-- Warlock
		-- Metamorphosis
		[47241] = {msg = "+20% Damage, 600% Armor", class = "WARLOCK"},
	-- Warrior
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
		[45438] = {msg = "|cFFFF0000Immune|r, Dispellable", class = "MAGE"},
		-- Blazing Speed
		[31642] = {msg = "+Speed", class = "MAGE"},
	-- Paladin
		-- Divine Shield
		[642] = {msg = "|cFFFF0000Immune|r, Dispellable", class = "PALADIN"},
		-- Hand of Protection
		[10278] = {msg = "Melee Immune, pacified"},
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
		[2825] = {msg = "30% Haste", multi = true},
		-- Heroism
		[32182] = {msg = "30% Haste", multi = true},
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
		[982] = {notarget = true},
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
		[51533] = {notarget = true},
	-- Warlock
		-- Summon Imp
		[688] = {notarget = true},
		-- Summon Felhunter
		[691] = {notarget = true},
		-- Summon Voidwalker
		[697] = {notarget = true},
		-- Summon Succubus
		[712] = {notarget = true},
		-- Drain Mana
		[5138] = {},
		-- Fear
		[6215] = {},
		-- Banish
		[17928] = {},
		-- Drain Life
		[18647] = {},
		-- Summon Felguard
		[30146] = {notarget = true},
		-- Howl of Terror
		[47857] = {notarget = true},
}