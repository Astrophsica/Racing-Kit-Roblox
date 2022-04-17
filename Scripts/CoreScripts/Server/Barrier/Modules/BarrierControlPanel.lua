--[[

	This script was made by AstrophsicaDev
	
	Module Name: ControlModule
	Purpose: Create click detectors for the control panel button, and connecting it to a 
	bindable event that will update the lights on the track.
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local ControlPanel = require(script.Parent.Parent.Parent.Misc.Modules.ControlPanel);
local BarrierControlPanel = {}


-- OOP Set up
BarrierControlPanel.__index = BarrierControlPanel;
setmetatable(BarrierControlPanel, ControlPanel) -- Inheritence

-- Folders
local mInbound = script.Parent.Parent.Inbound;
local mConfiguration = script.Parent.Parent.Parent:WaitForChild("Configuration");

-- Group Info
local mGroupConfiguration = mConfiguration:WaitForChild("Group");
local mGroupID = mGroupConfiguration:WaitForChild("GroupID").Value;
local mRankID = mGroupConfiguration:WaitForChild("RankID").Value;

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: BarrierControlPanel.new
	Parameters: Model
	Return: Array (ControlModule Object)
	
	Purpose: Create new instance of ControlModel and stores Control Module info.
--]]
function BarrierControlPanel.new(pControlPanelModel)
	local newBarrierControlModule = ControlPanel.new(pControlPanelModel);
	setmetatable(newBarrierControlModule, BarrierControlPanel);
	
	local controlConfiguration = newBarrierControlModule.mControlPanelModel.Configuration;
	newBarrierControlModule.mClassId = controlConfiguration.ClassID.Value;
	
	controlConfiguration:Destroy();
	
	return newBarrierControlModule;
end



--[[
	Function Name: BarrierControlPanel:Delete
	Parameters: Nil
	Return: Nil
	
	Purpose: Deletes instance data and connections
--]]
function BarrierControlPanel:Delete()
	if (self.mControlPanelModel) then
		self.mControlPanelModel:Destroy();
	end

	self.mControlPanelModel = nil;
	self.mLedModel = nil;
	self.mButtonsModel = nil;
	self.mClassId = nil;
	self.mSign = nil;
	
	for _, connection in pairs(self.mConnections) do
		connection:Disconnect();
		connection = nil;
	end
	
	self.mConnections = nil;
	
	self = nil;
end



--[[
	Function Name: BarrierControlPanel:OnButtonClick
	Parameter: Nil 
	Return: Nil
	
	Purpose: Activates event on button click.
--]]
function BarrierControlPanel:OnButtonClick(pPlayer)
	if (pPlayer:GetRankInGroup(mGroupID) >= mRankID) then
		mInbound.ToggleBarrier:Fire(self.mClassId);
	end
end

return BarrierControlPanel
