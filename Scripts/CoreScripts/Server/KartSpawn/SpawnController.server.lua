--[[

	This script was made by AstrophsicaDev
	
	Script Name: SpawnController
	Purpose: Processes events and stores all control panels in a table
--]]


----------------------------------------- Variables -----------------------------------------
-- Folders
local mModulesFolder = script.Parent.Modules;
local mInboundFolder = script.Parent.Inbound;
local mOutboundFolder = script.Parent.Outbound;

-- Modules
local mControlModule = require(mModulesFolder:WaitForChild("KartSpawnControlPanel"));

-- Misc
local mControlPanels = {};

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


------------------------------------------ Events ------------------------------------------
mInboundFolder.AddControlPanel.Event:Connect(AddControlPanel);
mInboundFolder.DeleteControlPanel.Event:Connect(DeleteControlPanel);