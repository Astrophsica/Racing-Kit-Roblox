--[[

	This script was made by AstrophsicaDev
	
	Module Name: ControlModule
	Purpose: To update the safety lights that are on the track.
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local LightModule = {}

-- OOP Set up
LightModule.__index = LightModule;
------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: LightModule.New
	Parameter: Object
	Return: Nil
	
	Purpose: To get all the lights from the model and connect the update light event to the 
	update lights function.
--]]
function LightModule.new(pSafetyLightModel)
	local newLightModule = {};
	setmetatable(newLightModule, LightModule);
	
	newLightModule.mSafetyLightModel = pSafetyLightModel;
	newLightModule.mLightsModel = pSafetyLightModel.Lights:GetChildren();
	
	return newLightModule;
end



--[[
	Function Name: LightModule:Delete
	Parameter: Object
	Return: Nil
	
	Purpose: Deletes instance data and connections
--]]
function LightModule:Delete()
	if (self.mSafetyLightModel) then
		self.mSafetyLightModel:Destroy();
	end

	self.mSafetyLightModel = nil;
	self.mLightsModel = nil;

	self = nil;
end



--[[
	Function Name: LightModule:UpdateLights
	Parameter: String
	Return: Nil
	
	Purpose: To enable the light that had been activated, while disabling all other lights.
--]]
function LightModule:UpdateLight(lightColour)
	for _, light in pairs(self.mLightsModel) do
		if light.Name == lightColour then
			-- Activated light
			light.SurfaceLight.Enabled = true
			light.Color = light.SurfaceLight.Color
		else
			-- All other lights
			light.SurfaceLight.Enabled = false
			light.BrickColor = BrickColor.Black()
		end
	end
end



--[[
	Function Name: LightModule:OnStatusChange
	Parameter: String
	Return: Nil
	
	Purpose: Run on status change
--]]
function LightModule:OnStatusChange(pStatus)
	self:UpdateLight(pStatus);
end


return LightModule