--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      

   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by AstrophsicaDev
	
	Script Name: SpawnController
	Last Updated: 22/02/2021
	Purpose: Processes events and stores all control panels in a table
--]]


----------------------------------------- Variables -----------------------------------------
-- Folders
local mModulesFolder = script.Parent.Modules;
local mInboundFolder = script.Parent.Inbound;
local mOutboundFolder = script.Parent.Outbound;

-- Modules
local mControlModule = require(mModulesFolder:WaitForChild("TrackChangeControlPanel"));

-- Configurations
local mConfiguration = script.Parent.Parent:WaitForChild("Configuration");
local mTrackChangeConfiguration =  mConfiguration:WaitForChild("TrackChange");
local mTrackStorageFolder = mTrackChangeConfiguration:WaitForChild("TrackStorageFolder").Value;

-- Misc
local mControlPanels = {};
local mTrackChange = require(script.Parent.Modules.TrackChange).new();
local mCurrentTrackIndex = 0;
------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: AddControlPanel
	Parameters: Model
	Return: Nil
	
	Purpose: Create new control panel and adds to mControlPanels table
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



function ToggleTrackChange()
	if (not mTrackStorageFolder) then
		error("Yar890 Studio Racing Kit: No 'TrackStorageFolder' set in config")
	end
	local mTrackStorageSize = #mTrackStorageFolder:GetChildren();
	if (mTrackStorageSize == 0) then
		error("Yar890 Studio Racing Kit: No tracks stored in 'TrackStorage' folder");
	end
	
	if (mCurrentTrackIndex == mTrackStorageSize) then
		mCurrentTrackIndex = 1;
	else
		mCurrentTrackIndex = mCurrentTrackIndex + 1;
	end
	
	mTrackChange:OnToggleTrackChange(mTrackStorageFolder:GetChildren()[mCurrentTrackIndex]);
end

------------------------------------------ Events ------------------------------------------
mInboundFolder.AddControlPanel.Event:Connect(AddControlPanel);
mInboundFolder.DeleteControlPanel.Event:Connect(DeleteControlPanel);
mInboundFolder.ToggleTrackChange.Event:Connect(ToggleTrackChange);