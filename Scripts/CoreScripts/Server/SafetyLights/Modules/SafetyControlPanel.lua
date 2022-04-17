--[[

	This script was made by AstrophsicaDev
	
	Module Name: ControlModule
	Purpose: Create click detectors for the control panel button, and connecting it to a 
	bindable event that will update the lights on the track.
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local ControlPanel = require(script.Parent.Parent.Parent.Misc.Modules.ControlPanel);
local SafetyControlPanel = {}

-- OOP Set up
SafetyControlPanel.__index = SafetyControlPanel;
setmetatable(SafetyControlPanel, ControlPanel) -- Inheritence

-- Folders
local mLightOutbound = script.Parent.Parent.Outbound;
local mLightInbound = script.Parent.Parent.Inbound;
local mKartInbound = script.Parent.Parent.Parent.Kart.Inbound;
local mConfiguration = script.Parent.Parent.Parent:WaitForChild("Configuration");
local SafetyLightConfiguration = mConfiguration.SafetyLight;

-- Group Info
local mGroupConfiguration = mConfiguration:WaitForChild("Group");
local mGroupID = mGroupConfiguration:WaitForChild("GroupID").Value;
local mRankID = mGroupConfiguration:WaitForChild("RankID").Value;
------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: ControlModule.new
	Parameters: Model
	Return: Array (ControlModule Object)
	
	Purpose: Create new instance of ControlModel and stores Control Module info.
--]]
function SafetyControlPanel.new(pControlPanelModel)
	local newControlModule = ControlPanel.new(pControlPanelModel);
	setmetatable(newControlModule, SafetyControlPanel);
	
	return newControlModule;
end



--[[
	Function Name: ControlModule:UpdateLights
	Parameter: Object, Object 
	Return: nil
	
	Purpose: Updates lights, max speed and control panel LEDs
--]]
function SafetyControlPanel:UpdateLights(pPlayer, pLight)
	-- Update lights
	mLightInbound.UpdateLight:Fire(pLight)
				
	-- Update kart speed based on configuration
	local newSpeedValue = SafetyLightConfiguration.LightSpeed:FindFirstChild(pLight).Value;
	mKartInbound.UpdateMaxSpeed:Fire(nil, newSpeedValue);
	mLightOutbound.LightChanged:Fire(pPlayer, pLight, newSpeedValue);
end



--[[
	Function Name: ControlModule:OnButtonClick
	Parameter: Nil 
	Return: Nil
	
	Purpose: Activates update light event on button click.
--]]
function SafetyControlPanel:OnButtonClick(pPlayer, pLight)
	if (pPlayer:GetRankInGroup(mGroupID) >= mRankID) then
		self:UpdateLights(pPlayer, pLight);
	end
end

return SafetyControlPanel
