#****************************************************************************
#**
#**  Author(s):  Mikko Tyster
#**
#**  Summary  :  Aeon T3 Anti-Air
#**
#**  Copyright © 2008 Blade Braver!
#****************************************************************************

local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local ACruiseMissileWeapon = import('/lua/aeonweapons.lua').ACruiseMissileWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')

DALK003 = Class(AWalkingLandUnit) {    
    Weapons = {
		CruiseMissile = Class(ACruiseMissileWeapon){},
    },
    
}

TypeClass = DALK003
