--[[

	This script was made by AstrophsicaDev
	
	Script Name: StartingLightController
	Purpose: Processes events and stores all control panels and starting lights in a table
--]]


----------------------------------------- Variables -----------------------------------------
-- Folders
local mModulesFolder = script.Parent.Modules;
local mInboundFolder = script.Parent.Inbound;
local mOutboundFolder = script.Parent.Outbound;

-- Modules
local mControlModule = require(mModulesFolder:WaitForChild("StartingLightControlPanel"));
local mLightModule = require(mModulesFolder:WaitForChild("StartingLight"));

-- Misc
local mControlPanels = {};
local mStartingLights = {};
local mStatus = "Red";
local mBlinkTime = 5;

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
	Function Name: AddStartingLight
	Parameters: Model
	Return: Nil
	
	Purpose: Create new starting light and add to mStartingLights table
--]]
function AddStartingLight(pStartingLight)
	local newStartingLight = mLightModule.new(pStartingLight);
	table.insert(mStartingLights, newStartingLight);
end



--[[
	Function Name: DeleteStartingLight
	Parameters: Model
	Return: Nil
	
	Purpose: Remove starting lights from mStartingLights table
--]]
function DeleteStartingLight(pStartingLightModel)
	for index, startingLight in pairs(mStartingLights) do
		if (startingLight.mStartingLightModel == pStartingLightModel) then
			startingLight:Delete();
			startingLight = nil;
			table.remove(mStartingLights, index);
		elseif (pStartingLightModel == nil) then
			startingLight:Delete();
			startingLight = nil;
			table.remove(mStartingLights, index)
		end
	end
end



--[[
	Function Name: ChangeStatus
	Parameters: String, Boolean
	Return: Nil
	
	Purpose: Changes status and updates starting light and control panels
--]]
function ChangeStatus(pNewStatus, pNewTreadBool)
	mStatus = pNewStatus;
	-- If new thread, then run with spawn().
	if (pNewTreadBool) then
		-- Loop through starting lights
		for _, startingLight in ipairs(mStartingLights) do
			spawn(function()
				startingLight:OnStatusChange(pNewStatus);
			end)
		end
		-- Loop through control panels
		for _, controlPanel in ipairs(mControlPanels) do
			spawn(function()
				controlPanel:OnStatusChange(pNewStatus);
			end)
		end
	-- Run on normal thread
	else
		-- Loop through starting lights
		for _, startingLight in ipairs(mStartingLights) do
			startingLight:OnStatusChange(pNewStatus);
		end
		-- Loop through control panels
		for _, controlPanel in ipairs(mControlPanels) do
			controlPanel:OnStatusChange(pNewStatus);
		end
	end
	mOutboundFolder.StatusToggled:Fire(mStatus);
end


--[[
	Function Name: ToggleStatus
	Parameters: Nil
	Return: Nil
	
	Purpose: Toggle status and switch lights
--]]
function ToggleStatus()
	-- Red to blink to green
	if (mStatus == "Red") then
		-- Begin blink
		ChangeStatus("Blink", true);
		
		-- Wait till mBlinkTime
		wait(mBlinkTime);
		
		-- Begin green
		ChangeStatus("Green", false);
		
	-- Green to red
	elseif (mStatus == "Green") then
		-- Begin red
		ChangeStatus("Red", false);
	end
end


------------------------------------------ Events ------------------------------------------
mInboundFolder.AddControlPanel.Event:Connect(AddControlPanel);
mInboundFolder.DeleteControlPanel.Event:Connect(DeleteControlPanel);
mInboundFolder.AddStartingLight.Event:Connect(AddStartingLight);
mInboundFolder.DeleteStartingLight.Event:Connect(DeleteStartingLight);
mInboundFolder.ToggleStatus.Event:Connect(ToggleStatus);