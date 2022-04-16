--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      
  \ \_/ /_ _ _ _| (_) | (_) | | | | | (___ | |_ _   _  __| |_  ___  
   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by the Roblox user Yar890.
	
	Script Name: CollisionController
	Last Updated: 20/02/2021
	Purpose: Deals with collision groups
--]]


----------------------------------------- Variables -----------------------------------------
-- Folders
local mModulesFolder = script.Parent.Modules;
local mInboundFolder = script.Parent.Inbound;
local mOutboundFolder = script.Parent.Outbound;
local mKartOutbound = script.Parent.Parent.Kart.Outbound;

-- Modules
local mControlModule = require(mModulesFolder:WaitForChild("CollisionControlPanel"));
local mCollisionModule = require(mModulesFolder:WaitForChild("Collision"));

-- Misc
local mControlPanels = {};
local mCollision = mCollisionModule.new();

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: AddControlPanel
	Parameters: Model
	Return: Nil
	
	Purpose: Create new control panel and add to mControlPanels table
--]]
function AddControlPanel(pControlModel)
	local newControlPanel = mControlModule.new(pControlModel);
	newControlPanel:ControlPanelSetUp();
	table.insert(mControlPanels, newControlPanel);
end



--[[
	Function Name: DeleteControlPanel
	Parameters: Model
	Return: Nil
	
	Purpose: Remove control panel from mControlPanels table
--]]
function DeleteControlPanel(pControlModel)
	for index, controlPanel in pairs(mControlPanels) do
		if (controlPanel.mControlPanelModel == pControlModel) then
			controlPanel:Delete();
			controlPanel = nil;
			table.remove(mControlPanels, index);
		elseif (pControlModel == nil) then
			controlPanel:Delete();
			controlPanel = nil;
			table.remove(mControlPanels, index)
		end
	end
end



--[[
	Function Name: OnToggleCollision
	Parameters: Nil
	Return: Nil
	
	Purpose: Toggles collision status and updates control panel LEDs
--]]
function OnToggleCollision()
	local status = mCollision:OnToggleCollision();
	
	for _, controlPanel in ipairs(mControlPanels) do
		controlPanel:UpdateLedStatus(status);
	end
	
	mOutboundFolder.CollisionToggled:Fire(status);
end



--[[
	Function Name: OnKartAdded
	Parameters: Model
	Return: Nil
	
	Purpose: Runs when kart has been added. Adds kart to kart collision group.
--]]
function OnKartAdded(pKart)
	mCollision:OnKartAdded(pKart);
end



--[[
	Function Name: OnPlayerAddedToKart
	Parameters: Player, Model
	Return: Nil
	
	Purpose: Runs when player sits in a kart. Adds player to player collision group.
--]]
function OnPlayerAddedToKart(pPlayer, pKart)
	mCollision:OnPlayerAddedToKart(pPlayer, pKart);
end



--[[
	Function Name: OnPlayerRemovedFromKart
	Parameters: Player, Model
	Return: Nil
	
	Purpose: Runs when player jumps out of kart seat. Removes player from player 
	collision group.
--]]
function OnPlayerRemovedFromKart(pPlayer, pKart)
	mCollision:OnPlayerRemovedFromKart(pPlayer, pKart);
end

------------------------------------------ Events ------------------------------------------
mInboundFolder.ToggleCollision.Event:Connect(OnToggleCollision);
mInboundFolder.AddControlPanel.Event:Connect(AddControlPanel);
mInboundFolder.DeleteControlPanel.Event:Connect(DeleteControlPanel);

mKartOutbound.KartAdded.Event:Connect(OnKartAdded);
mKartOutbound.PlayerAddedToKart.Event:Connect(OnPlayerAddedToKart);
mKartOutbound.PlayerRemovedFromKart.Event:Connect(OnPlayerRemovedFromKart);