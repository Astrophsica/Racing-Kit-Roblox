--[[

	This script was made by AstrophsicaDev
	
	Script Name: RaingLightController
	Purpose: Processes events and stores all control panels and racing lights in a table
--]]


----------------------------------------- Variables -----------------------------------------
-- Folders
local mModulesFolder = script.Parent.Modules;
local mInboundFolder = script.Parent.Inbound;
local mOutboundFolder = script.Parent.Outbound;

-- Modules
local mBarrierControlModule = require(mModulesFolder:WaitForChild("BarrierControlPanel"));
local mBarrierModule = require(mModulesFolder:WaitForChild("Barrier"));

-- Misc
local mClassIdStatus = {};
local mControlPanels = {};
local mBarriers = {};

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: AddControlPanel
	Parameters: Model
	Return: Nil
	
	Purpose: Create new control panel and add to mControlPanels table
--]]
function AddControlPanel(pControlModel)
	local newControlPanel = mBarrierControlModule.new(pControlModel);
	newControlPanel:ControlPanelSetUp();
	
	if (mClassIdStatus[newControlPanel.mClassId] == nil) then
		mClassIdStatus[newControlPanel.mClassId] = true;
	end
	
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
	Function Name: AddBarrier
	Parameters: Model
	Return: Nil
	
	Purpose: Create new barrier and add to mBarriers table
--]]
function AddBarrier(pBarrierModel)
	local newBarrier = mBarrierModule.new(pBarrierModel);
	table.insert(mBarriers, newBarrier);
end



--[[
	Function Name: DeleteBarrier
	Parameters: Model
	Return: Nil
	
	Purpose: Remove barrier from mBarriers table
--]]
function DeleteBarrier(pBarrierModel)
	for index, barrier in pairs(mBarriers) do
		if (barrier.mBarrierModel == pBarrierModel) then
			barrier:Delete();
			barrier = nil;
			table.remove(mBarriers, index);
		elseif (pBarrierModel == nil) then
			barrier:Delete();
			barrier = nil;
			table.remove(mBarriers, index)
		end
	end
end



--[[
	Function Name: ToggleBarrier
	Parameters: String 
	Return: Nil
	
Purpose: Toggle status and update status of barriers anc control panels.
--]]
function ToggleBarrier(pBarrierClassId)
	if (pBarrierClassId ~= nil) then
		local status = mClassIdStatus[pBarrierClassId];
		
		if (status ~= nil) then
			status = not status;
			
			for barrierId, barrier in ipairs(mBarriers) do
				if (barrier.mClassId == pBarrierClassId) then
					barrier:OnStatusChange(status);
				end
			end
			
			for controlId, controlPanel in ipairs(mControlPanels) do
				if (controlPanel.mClassId == pBarrierClassId) then
					controlPanel:OnStatusChange(status);
				end
			end
			
			mClassIdStatus[pBarrierClassId] = status;
			mOutboundFolder.BarrierToggled:Fire(pBarrierClassId, status);
		end
		
	end
end


------------------------------------------ Events ------------------------------------------
mInboundFolder.AddControlPanel.Event:Connect(AddControlPanel);
mInboundFolder.DeleteControlPanel.Event:Connect(DeleteControlPanel);
mInboundFolder.AddBarrier.Event:Connect(AddBarrier);
mInboundFolder.DeleteBarrier.Event:Connect(DeleteBarrier);
mInboundFolder.ToggleBarrier.Event:Connect(ToggleBarrier);