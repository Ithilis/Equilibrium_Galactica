#**************************************************************************** 
#** 
#** File : Ual0310_script.lua 
#** Author(s): Ebola Soup (modeler / texturing / animation), Resin_Smoker (scripter / effects / weapons)
#** 
#** Summary : Aeon Heavy Mobile Defense Unit
#** 
#** Copyright © 2008, 4th Dimension 
#**************************************************************************** 

### Misc files
local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit 
local CustomAeonWeapons = import('/mods/4th_Dimension_212/hook/lua/aeonweapons.lua')
local EffectUtils = import('/lua/EffectUtilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local DefaultProjectileWeapon = import('/lua/sim/defaultweapons.lua').DefaultProjectileWeapon

### Local weapons 
local AIFMissileArrowWeapon = CustomAeonWeapons.AIFMissileArrowWeapon
local ALaserPhalanxWeapon = CustomAeonWeapons.ALaserPhalanxWeapon

ual0310 = Class(AWalkingLandUnit) { 

   Weapons = {
       HatchMissile = Class(AIFMissileArrowWeapon) {

            OnWeaponFired = function(self) 
                AIFMissileArrowWeapon.OnWeaponFired(self) 
                ### Hides the missile bones after the unit has fired 
                self.unit:HideBone('LargeSAM', false)
            end, 

            PlayFxRackSalvoReloadSequence = function(self)
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'LargeSAM', self.unit:GetArmy(), Effects.WeaponSteam01 )
                ### Unhides the missile bones so the player can see the missile reload 
                self.unit:ShowBone('LargeSAM', false)  
                AIFMissileArrowWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
       },
       MissileSideLeft = Class(DefaultProjectileWeapon) {},
       MissileSideRight = Class(DefaultProjectileWeapon) {},
       LaserPhalanx = Class(ALaserPhalanxWeapon) {},
       LaserPhalanx2 = Class(ALaserPhalanxWeapon) {},
   },
} 

TypeClass = ual0310