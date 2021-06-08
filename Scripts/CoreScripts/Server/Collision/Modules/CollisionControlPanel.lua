--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      
  \ \_/ /_ _ _ _| (_) | (_) | | | | | (___ | |_ _   _  __| |_  ___  
   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by the Roblox user Yar890.
	
	Module Name: ControlModule
	Last Updated: 21/02/2021
	Purpose: Deals with collision groups
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local ControlPanel = require(script.Parent.Parent.Parent.Misc.Modules.ControlPanel);
local CollisionControlPanel = {}

-- OOP Set up
CollisionControlPanel.__index = CollisionControlPanel;
setmetatable(CollisionControlPanel, ControlPanel) -- Inheritence

-- Folders
local mCollisionInbound = script.Parent.Parent.Inbound;

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
function CollisionControlPanel.new(pControlPanelModel)
	local newCollisionControlPanel = ControlPanel.new(pControlPanelModel);
	setmetatable(newCollisionControlPanel, CollisionControlPanel);
	
	return newCollisionControlPanel;
end



--[[
	Function Name: OnButtonClick
	Parameter: Nil 
	Return: Nil
	
	Purpose: Activates toggle collision event on button click.
--]]
function CollisionControlPanel:OnButtonClick(pPlayer)
	if (pPlayer:GetRankInGroup(mGroupID) >= mRankID) then
		mCollisionInbound.ToggleCollision:Fire();
	end
end



return CollisionControlPanel
