--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      
  \ \_/ /_ _ _ _| (_) | (_) | | | | | (___ | |_ _   _  __| |_  ___  
   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by the Roblox user Yar890.
	
	Module Name: ControlModule
	Last Updated: 22/02/2021
	Purpose: To update the start lights and barrier that are on the track.
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local LightModule = {}

-- OOP Set up
LightModule.__index = LightModule;

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: LightModule.New
	Parameter: Object (Model)
	Return: Nil
	
	Purpose: To get all the lights from the model and sets up variables.
--]]
function LightModule.new(pStartingLightModel)
	local newLightModule = {};
	setmetatable(newLightModule, LightModule);
	
	newLightModule.mStartingLightModel = pStartingLightModel;
	newLightModule.mLightsModel = pStartingLightModel.Lights:GetChildren();
	newLightModule.mBarrier = pStartingLightModel.Barrier;
	
	-- Sort table based on light name
	table.sort(newLightModule.mLightsModel, 
		function (a, b) 
			return a.Name < b.Name;
		end);
	
	newLightModule.mBarrier.Transparency = 1;
	newLightModule.mBarrier.CanCollide = true;
	
	return newLightModule;
end



--[[
	Function Name: LightModule:Delete
	Parameter: Object
	Return: Nil
	
	Purpose: Deletes instance data and connections
--]]
function LightModule:Delete()
	if (self.mStartingLightModel) then
		self.mStartingLightModel:Destroy();
	end

	self.mStartingLightModel = nil;
	self.mLightsModel = nil;
	self.mBarrier = nil;

	self = nil;
end



--[[
Function Name: LightModule:SetAllLights
	Parameter: Color3, Boolean
	Return: Nil
	
	Purpose: Sets all lights to specified color and enabled status
--]]
function LightModule:SetAllLights(pColor, pEnabled)
	-- Loop through all lights
	for _, light in ipairs(self.mLightsModel) do
		self:SetIndividualLight(light, pColor, pEnabled);
	end
end



--[[
Function Name: LightModule:SetIndividualLight
	Parameter: Object, Color3, Boolean
	Return: Nil
	
	Purpose: Set individual light color and enabled status
--]]
function LightModule:SetIndividualLight(pLight, pColor, pEnabled)
	local surfaceLight = pLight:FindFirstChildOfClass("SurfaceLight");
	
	pLight.Color = pColor;
	surfaceLight.Color = pColor;
	surfaceLight.Enabled = pEnabled;
end



--[[
Function Name: LightModule:OnRedStatus
	Parameter: Nil
	Return: Nil
	
	Purpose: Runs on red status. Sets all lights to red
--]]
function LightModule:OnRedStatus()
	self:SetAllLights(Color3.fromRGB(255, 0, 0), true);
	self.mBarrier.CanCollide = true;
end



--[[
Function Name: LightModule:OnBlinkStatus
	Parameter: Nil
	Return: Nil
	
	Purpose: Runs on blink status. Runs countdown lights
--]]
function LightModule:OnBlinkStatus()
	-- Set all lights to black
	self:SetAllLights(Color3.fromRGB(0, 0, 0), false);
		
	-- Set individual lights (1 second wait per iteration)
	for _, light in ipairs(self.mLightsModel) do
		self:SetIndividualLight(light, Color3.fromRGB(255, 0, 0), true);
		wait(1);
	end
		
	-- Set all lights to green
	self:SetAllLights(Color3.fromRGB(0, 255, 0), true);
end



--[[
	Function Name: LightModule:OnGreenStatus
	Parameter: Nil
	Return: Nil
	
	Purpose: Runs on green status. Sets all lights to green
--]]
function LightModule:OnGreenStatus()
	self:SetAllLights(Color3.fromRGB(255, 0, 0), true);
	self.mBarrier.CanCollide = false;
end



--[[
	Function Name: LightModule:OnStatusChange
	Parameter: Nil
	Return: Nil

	Purpose: Runs on status change. Runs method for specified status
]]--
function LightModule:OnStatusChange(pNewStatus)
	if (pNewStatus == "Red") then
		self:OnRedStatus();
	elseif (pNewStatus == "Blink") then
		self:OnBlinkStatus();
	elseif (pNewStatus == "Green") then
		self:OnGreenStatus();
	end
end

return LightModule