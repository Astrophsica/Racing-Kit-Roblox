--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      
  \ \_/ /_ _ _ _| (_) | (_) | | | | | (___ | |_ _   _  __| |_  ___  
   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by the Roblox user Yar890.
	
	Script Name: KartController
	Last Updated: 08/02/2021
	Purpose: Processes events and stores all karts module info in table
--]]


----------------------------------------- Variables -----------------------------------------
-- Folders
local mModulesFolder = script.Parent.Modules;
local mInboundFolder = script.Parent.Inbound;
local mOutboundFolder = script.Parent.Outbound;

-- Modules
local mKartModule = require(mModulesFolder.KartModule);

-- Misc
local mRacingLightConfiguration = script.Parent.Parent:WaitForChild("Configuration"):WaitForChild("SafetyLight");
local mKarts = {};
local mGlobalKartSpeed = mRacingLightConfiguration.LightSpeed.Green.Value;

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: AddKart
	Parameters: Model
	Return: Nil
	
	Purpose: Create new kart and adds to mKarts table
--]]
function AddKart(pKartModel)
	local newKart = mKartModule.new(pKartModel, mGlobalKartSpeed);
	newKart:KartSetUp();
	table.insert(mKarts, newKart);
	mOutboundFolder.KartAdded:Fire(newKart);
end



--[[
	Function Name: UpdateMaxSpeed
	Parameters: Int, Int
	Return: Nil
	
	Purpose: Update pKartId max speed. If nil, update all karts
--]]
function UpdateMaxSpeed(pKartId, pNewMaxSpeed)
	if (pKartId == nil) then
		mGlobalKartSpeed = pNewMaxSpeed;
		for kartId, kart in pairs(mKarts)do
			kart:UpdateMaxSpeed(pNewMaxSpeed)
		end
	else
		-- Nothing (for now)
	end
end



--[[
	Function Name: DeleteKart
	Parameters: Int
	Return: Nil
	
	Purpose: Destroys pKartId kart. If nil, destroy all karts
--]]
function DeleteKart(pKartId)
	if (pKartId == nil) then
		for kartId, kart in ipairs(mKarts)do
			kart:DeleteKart();
		end
		mKarts = {};
	else
		-- Nothing (for now)
	end
end


------------------------------------------ Events ------------------------------------------
mInboundFolder.AddKart.Event:Connect(AddKart);
mInboundFolder.UpdateMaxSpeed.Event:Connect(UpdateMaxSpeed);
mInboundFolder.DeleteKart.Event:Connect(DeleteKart);