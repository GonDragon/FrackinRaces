require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"

function init()
--*************************************    
-- FU/FR ADDONS
 if self.blockCount == nil then 
   self.blockCount = 0 
 end
          if world.entitySpecies(activeItem.ownerEntityId()) == "peglaci" then      
            self.blockCount = self.blockCount + 0.05
            status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
          end  
          if world.entitySpecies(activeItem.ownerEntityId()) == "vulpes" then     
            self.blockCount = self.blockCount + 0.08
            status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
          end        
          
          -- Novakid get bonus with Pistols and Sniper Rifles
          if world.entitySpecies(activeItem.ownerEntityId()) == "novakid" then      
		local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isPistol(heldItem) then
                          self.blockCount = self.blockCount + 0.125
                          status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end
			if isSniperRifle(heldItem) then
                          self.blockCount = self.blockCount + 0.25
                          status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end			
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if isPistol(heldItem) then
                          self.blockCount = self.blockCount + 0.125
                          status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end
			if isSniperRifle(heldItem) then
                          self.blockCount = self.blockCount + 0.25
                          status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end			
		end          
          end   
          
          -- Apex get a bonus with Grenade Launchers
          if world.entitySpecies(activeItem.ownerEntityId()) == "apex" then      
		local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isGrenadeLauncher(heldItem) then
                          self.blockCount = self.blockCount + 0.19
                          status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end			
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if isGrenadeLauncher(heldItem) then
                          self.blockCount = self.blockCount + 0.19
                          status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end		
		end          
          end   
          
          -- Humans rock the Assault Rifle
          if world.entitySpecies(activeItem.ownerEntityId()) == "human" then      
		local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isAssaultRifle(heldItem) or isMachinePistol(heldItem) then
                          self.blockCount = self.blockCount + 0.15
                          status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end			
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if isAssaultRifle(heldItem) or isMachinePistol(heldItem) then
                          self.blockCount = self.blockCount + 0.15
                          status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end		
		end 
		
          end   

          
--************************************** 
-- END FR BONUSES
-- *************************************


  activeItem.setCursor("/cursors/reticle0.cursor")
  animator.setGlobalTag("paletteSwaps", config.getParameter("paletteSwaps", ""))

  self.weapon = Weapon:new()

  self.weapon:addTransformationGroup("weapon", {0,0}, 0)
  self.weapon:addTransformationGroup("muzzle", self.weapon.muzzleOffset, 0)

  local primaryAbility = getPrimaryAbility()
  self.weapon:addAbility(primaryAbility)

  local secondaryAbility = getAltAbility(self.weapon.elementalType)
  if secondaryAbility then
    self.weapon:addAbility(secondaryAbility)
  end

  self.weapon:init()
end

function update(dt, fireMode, shiftHeld)
  self.weapon:update(dt, fireMode, shiftHeld)
end





-- ****************************************************************
-- FrackinRaces weapon specialization
-- ****************************************************************

function isPistol(name)
	if root.itemHasTag(name, "pistol") then
		return true
	end
	return false
end

function isAssaultRifle(name)
	if root.itemHasTag(name, "assaultrifle") then
		return true
	end
	return false
end

function isMachinePistol(name)
	if root.itemHasTag(name, "machinepistol") then
		return true
	end
	return false
end

function isRocketLauncher(name)
	if root.itemHasTag(name, "rocketlauncher") then
		return true
	end
	return false
end

function isGrenadeLauncher(name)
	if root.itemHasTag(name, "grenadelauncher") then
		return true
	end
	return false
end

function isShotgun(name)
	if root.itemHasTag(name, "shotgun") then
		return true
	end
	return false
end

function isSniperRifle(name)
	if root.itemHasTag(name, "sniperrifle") then
		return true
	end
	return false
end

-- ***********************************************************************************************
-- END specialization
-- ***********************************************************************************************


function uninit()
  status.clearPersistentEffects("novakidbonusdmg")
  self.blockCount = 0
  self.weapon:uninit()
end
