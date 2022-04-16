--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      
  \ \_/ /_ _ _ _| (_) | (_) | | | | | (___ | |_ _   _  __| |_  ___  
   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by the Roblox user Yar890.
	
	Module Name: ControlModule
	Last Updated: 20/02/2021
	Purpose: Manages barrier
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local BarrierModule = {}

-- OOP Set up
BarrierModule.__index = BarrierModule;

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: BarrierModule.New
	Parameter: Object
	Return: Array (BarrierModule Object)
	
	Purpose: To set barrier model and class ID member variables
--]]
function BarrierModule.new(pBarrierModel)
	local newBarrierModule = {};
	setmetatable(newBarrierModule, BarrierModule);
	
	newBarrierModule.mBarrierModel = pBarrierModel;
	
	local barrierConfiguration = newBarrierModule.mBarrierModel.Configuration;
	newBarrierModule.mClassId = barrierConfiguration.ClassID.Value;
	newBarrierModule.mPartBoolTransparency = {
		[true] = barrierConfiguration.BarrierOnTransparency.Value,
		[false] = barrierConfiguration.BarrierOffTransparency.Value
	};
	
	barrierConfiguration:Destroy();
	
	return newBarrierModule;
end



--[[
	Function Name: BarrierModule:Delete
	Parameter: Object
	Return: Nil
	
	Purpose: Deletes instance data and connections
--]]
function BarrierModule:Delete()
	if (self.mBarrierModel) then
		self.mBarrierModel:Destroy();
	end
	
	self.mBarrierModel = nil;
	self.mClassId = nil;
	self.mPartBoolTransparency = nil;
	
	self = nil;
end



--[[
	Function Name: BarrierModule:UpdateBarrier
	Parameter: Object, String
	Return: Nil
	
	Purpose: Update barrier transparency and can collide.
--]]
function BarrierModule:UpdateBarrier(pObject, pStatus)
	local barrierDecendants = self.mBarrierModel:GetDescendants();
	
	for _, object in pairs(barrierDecendants) do
		if (object:IsA("BasePart")) then
			object.CanCollide = pStatus;
			object.Transparency = self.mPartBoolTransparency[pStatus];
		end
	end
end



--[[
	Function Name: BarrierModule:OnStatusChange
	Parameter: Bool
	Return: Nil
	
	Purpose: To enable the light that had been activated, while disabling all other lights.
--]]
function BarrierModule:OnStatusChange(pStatus)
	self:UpdateBarrier(self.mBarrierModel, pStatus);
end


return BarrierModule