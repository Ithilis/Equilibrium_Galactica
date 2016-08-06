#**************************************************************************** 
#** 
#** Author(s): Ebola Soup, Resin_Smoker 
#** 
#** Summary : Seraphim assault unit 
#** 
#** Copyright © 2007, 4th Dimension 
#**************************************************************************** 

local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local SDFUltraChromaticBeamGenerator = import('/lua/seraphimweapons.lua').SDFUltraChromaticBeamGenerator

xsl0302 = Class(SWalkingLandUnit) { 
    Weapons = { 
        MainGun = Class(SDFUltraChromaticBeamGenerator) {
            OnWeaponFired = function(self, target)
				SDFUltraChromaticBeamGenerator.OnWeaponFired(self, target)
				ChangeState( self.unit, self.unit.VisibleState )
			end,
			
			OnLostTarget = function(self)
				SDFUltraChromaticBeamGenerator.OnLostTarget(self)
				if self.unit:IsIdleState() then
				    ChangeState( self.unit, self.unit.InvisState )
				end
			end,
        }, 
    },

    OnStopBeingBuilt = function(self, builder, layer)
        SWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
        self:DisableUnitIntel('RadarStealth')
		self:DisableUnitIntel('Cloak')
		self.Cloaked = false
        ChangeState( self, self.InvisState ) 
    end,
    
    InvisState = State() {
        Main = function(self)
            self.Cloaked = false
            local bp = self:GetBlueprint()
            if bp.Intel.StealthWaitTime then
                WaitSeconds( bp.Intel.StealthWaitTime )
            end
			self:EnableUnitIntel('RadarStealth')
			self:EnableUnitIntel('Cloak')
			self.Cloaked = true
        end,
        
        OnMotionHorzEventChange = function(self, new, old)
            if new != 'Stopped' then
                ChangeState( self, self.VisibleState )
            end
            SWalkingLandUnit.OnMotionHorzEventChange(self, new, old)
        end,
    },
    
    VisibleState = State() {
        Main = function(self)
            if self.Cloaked then
                self:DisableUnitIntel('RadarStealth')
			    self:DisableUnitIntel('Cloak')
			end
        end,
        
        OnMotionHorzEventChange = function(self, new, old)
            if new == 'Stopped' then
                ChangeState( self, self.InvisState )
            end
            SWalkingLandUnit.OnMotionHorzEventChange(self, new, old)
        end,
    },
  
} 

TypeClass = xsl0302