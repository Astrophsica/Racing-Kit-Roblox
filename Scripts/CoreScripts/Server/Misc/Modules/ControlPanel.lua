--[[

	This script was made by AstrophsicaDev
	
	Module Name: ControlModule
	Last Updated: 27/08/2020
	Purpose: Create click detectors for the control panel button, and connecting it to a 
	bindable event that will update the lights on the track.
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local ControlPanelModule = {}

-- OOP Set up
ControlPanelModule.__index = ControlPanelModule;

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: ControlModule.new
	Parameters: Model
	Return: Array (ControlModule Object)
	
	Purpose: Create new instance of ControlModel and stores Control Module info.
--]]
function ControlPanelModule.new(pControlPanelModel)
	local newControlModule = {};
	setmetatable(newControlModule, ControlPanelModule);

	newControlModule.mControlPanelModel = pControlPanelModel;
	newControlModule.mButtonsModel = newControlModule.mControlPanelModel.Buttons;
	
	local LEDsModel = newControlModule.mControlPanelModel:FindFirstChild("LEDs");
	if (LEDsModel) then
		newControlModule.mLedModel = LEDsModel;
	end
	
	
	newControlModule.mConnections = {};

	return newControlModule;
end



--[[
	Function Name: ControlModule:Delete
	Parameters: Nil
	Return: Nil
	
	Purpose: Deletes instance data and connections
--]]
function ControlPanelModule:Delete()
	if (self.mControlPanelModel) then
		self.mControlPanelModel:Destroy();
	end

	self.mControlPanelModel = nil;
	self.mLedModel = nil;
	self.mButtonsModel = nil;
	
	for _, connection in pairs(self.mConnections) do
		connection:Disconnect();
		connection = nil;
	end

	self.mConnections = nil;

	self = nil;
end


--[[
	Function Name: ControlModule:UpdateLedStatus
	Parameters: Boolean/String
	Return: Nil
	
	Purpose: Changed LED status based on parameter.
--]]
function ControlPanelModule:UpdateLedStatus(pStatus)
	if (not self.mLedModel) then
		return;
	end
	
	local ledsModel = self.mLedModel;
	local ledsChildren = ledsModel:GetChildren();
	
	-- Reset LEDs
	for _, led in pairs(ledsChildren) do
		if (led:IsA("BasePart")) then
			led.Material = Enum.Material.Glass;
		end
	end
	
	-- Red/Green bool light setup
	if (ledsModel:FindFirstChild("Red") and ledsModel:FindFirstChild("Green") and #ledsChildren == 2) then
		-- Enable green LED
		if (pStatus == true) then
			ledsModel.Green.Material = Enum.Material.Neon;
		-- Enable red LED
		else
			ledsModel.Red.Material = Enum.Material.Neon;
		end
		return;
	end
	
	-- Custom status setup
	local led = ledsModel:FindFirstChild(pStatus);
	if (led) then
		led.Material = Enum.Material.Neon;
		return;
	end
	
end



--[[
	Function Name: ControlModule:OnStatusChange
	Parameter: Bool
	Return: Nil
	
	Purpose: Runs methods on status change
--]]
function ControlPanelModule:OnStatusChange(pStatus)
	self:UpdateLedStatus(pStatus);
end



--[[
	Function Name: ControlModule:OnButtonClick
	Parameter: Nil
	Return: Nil
	
	Purpose: Activates event on button click.
--]]
function ControlPanelModule:OnButtonClick(pPlayer)
	-- Expect override
end



--[[
	Function Name: ControlPanelSetUp
	Parameter: Object 
	Return: nil
	
	Purpose: Set up control panel buttons
--]]
function ControlPanelModule:ControlPanelSetUp()
	 -- Loop through buttons
	for _, button in ipairs(self.mButtonsModel:GetChildren()) do
		if button:IsA("BasePart") then
			local clickDetector = Instance.new("ClickDetector", button)
			local OnButtonClickEvent = clickDetector.MouseClick:Connect(function(pPlayer)
				self:OnButtonClick(pPlayer, button.Name) 
			end);
			table.insert(self.mConnections, OnButtonClickEvent);
		end
	end
end

return ControlPanelModule
