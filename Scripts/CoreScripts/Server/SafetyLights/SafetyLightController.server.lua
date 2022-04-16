--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      
  \ \_/ /_ _ _ _| (_) | (_) | | | | | (___ | |_ _   _  __| |_  ___  
   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by the Roblox user Yar890.
	
	Script Name: SafetyLightController
	Last Updated: 222/02/2021
	Purpose: Processes events and stores all control panels and racing lights in a table
--]]


----------------------------------------- Variables -----------------------------------------
-- Folders
local mModulesFolder = script.Parent.Modules;
local mInboundFolder = script.Parent.Inbound;

-- Modules
local mControlModule = require(mModulesFolder:WaitForChild("SafetyControlPanel"));
local mLightModule = require(mModulesFolder:WaitForChild("SafetyLight"));

-- Misc
local mControlPanels = {};
local mSafetyLights = {};
local mStatus = "Green";

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
	Function Name: AddSafetyLight
	Parameters: Model
	Return: Nil
	
	Purpose: Create new racing light and add to mSafetyLights table
--]]
function AddSafetyLight(pSafetyLight)
	local newSafetyLight = mLightModule.new(pSafetyLight);
	table.insert(mSafetyLights, newSafetyLight);
end



--[[
	Function Name: DeleteSafetyLight
	Parameters: Model
	Return: Nil
	
	Purpose: Remove safety lights from mSafetyLights table
--]]
function DeleteSafetyLight(pSafetyLightModel)
	for index, safetyLight in pairs(mSafetyLights) do
		if (safetyLight.mSafetyLightModel == pSafetyLightModel) then
			safetyLight:Delete();
			safetyLight = nil;
			table.remove(mSafetyLights, index);
		elseif (pSafetyLightModel == nil) then
			safetyLight:Delete();
			safetyLight = nil;
			table.remove(mSafetyLights, index)
		end
	end
end




--[[
	Function Name: UpdateLights
	Parameters: String
	Return: Nil
	
	Purpose: Create new racing light and add to mSafetyLights table
--]]
function UpdateLights(pLightColor)	
	mStatus = pLightColor;
	
	for lightId, light in pairs(mSafetyLights)do
		light:OnStatusChange(mStatus);
	end
	
	for controlPanelId, controlPanel in ipairs(mControlPanels) do
		controlPanel:OnStatusChange(mStatus);
	end
end


------------------------------------------ Events ------------------------------------------
mInboundFolder.AddControlPanel.Event:Connect(AddControlPanel);
mInboundFolder.DeleteControlPanel.Event:Connect(DeleteControlPanel);
mInboundFolder.AddSafetyLight.Event:Connect(AddSafetyLight);
mInboundFolder.DeleteSafetyLight.Event:Connect(DeleteSafetyLight);
mInboundFolder.UpdateLight.Event:Connect(UpdateLights);