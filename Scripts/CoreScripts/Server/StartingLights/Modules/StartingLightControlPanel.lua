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
	Purpose: Create click detectors for the control panel button, and connecting it to a 
	bindable event that will update the lights on the track.
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local ControlPanel = require(script.Parent.Parent.Parent.Misc.Modules.ControlPanel);
local StartingLightControlPanel = {}

-- OOP Set up
StartingLightControlPanel.__index = StartingLightControlPanel;
setmetatable(StartingLightControlPanel, ControlPanel) -- Inheritence

-- Events
local mLightInbound = script.Parent.Parent.Inbound;

-- Group Info
local mConfiguration = script.Parent.Parent.Parent:WaitForChild("Configuration");
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
function StartingLightControlPanel.new(pControlPanelModel)
	local newControlModule = ControlPanel.new(pControlPanelModel);
	setmetatable(newControlModule, StartingLightControlPanel);
	
	return newControlModule;
end



--[[
	Function Name: ControlModule:UpdateLedStatus
	Parameters: Boolean
	Return: Nil
	
	Purpose: Changed LED status based on parameter.
--]]
function StartingLightControlPanel:UpdateLedStatus(pStatus)
	local leds = self.mLedModel;
	-- Red enabled
	if (pStatus == "Red") then
		leds.Red.Material = Enum.Material.Neon;
		leds.Yellow.Material = Enum.Material.Glass;
		leds.Green.Material = Enum.Material.Glass;
	elseif (pStatus == "Blink") then
		leds.Red.Material = Enum.Material.Glass;
		leds.Green.Material = Enum.Material.Glass;
		for i = 1, 5 do
			leds.Yellow.Material = Enum.Material.Neon;
			wait(0.5);
			leds.Yellow.Material = Enum.Material.Glass;
			wait(0.5);
		end
	elseif( pStatus == "Green") then
		leds.Red.Material = Enum.Material.Glass;
		leds.Yellow.Material = Enum.Material.Glass;
		leds.Green.Material = Enum.Material.Neon;
	end
end



--[[
	Function Name: ControlModule:OnStatusChange
	Parameters: String
	Return: Nil
	
	Purpose: Runs on status change. Updates LED Status
--]]
function StartingLightControlPanel:OnStatusChange(pNewStatus)
	self:UpdateLedStatus(pNewStatus);
end



--[[
	Function Name: OnButtonClick
	Parameter: Player
	Return: Nil
	
	Purpose: Activates toggle collision event on button click.
--]]
function StartingLightControlPanel:OnButtonClick(pPlayer)
	if (pPlayer:GetRankInGroup(mGroupID) >= mRankID) then
		mLightInbound.ToggleStatus:Fire();
	end
end


return StartingLightControlPanel
