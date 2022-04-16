--[[

	This script was made by AstrophsicaDev
	
	Module Name: KartModule
	Last Updated: 20/02/2021
	Purpose: Allows karts max speed to change and delete kart
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local KartModule = {}

-- OOP Set up
KartModule.__index = KartModule

-- Folders
local mOutboundFolder = script.Parent.Parent.Outbound;
local mMiscFolder = script.Parent.Parent.Misc;

-- Configuration
local mConfiguration = script.Parent.Parent.Parent:WaitForChild("Configuration");

-- Anti cheat config
local mKartAntiCheatConfiguration = mConfiguration:WaitForChild("Kart").AntiCheat;
local mAntiCheatEnabled = mKartAntiCheatConfiguration.AntiCheatEnabled;
local mLightOverspeedTimeValue = mKartAntiCheatConfiguration.LightOverspeedTime;
local mHardLimitOffsetValue = mKartAntiCheatConfiguration.HardLimitOffset;
local mLightLimitOffsetValue = mKartAntiCheatConfiguration.LightLimitOffset;

-- Racing light config (Used for anti cheat)
local mRacingLightConfiguration = mConfiguration:WaitForChild("SafetyLight");

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: KartModule.new
	Parameters: Model
	Return: Array (KartModule Object)
	
	Purpose: Create new instance of kart and stores kart info.
--]]
function KartModule.new(pKartModel, pMaxSpeed)
	local newKartModule = {};
	setmetatable(newKartModule, KartModule);
	
	newKartModule.KartModel = pKartModel;
	newKartModule.MaxSpeed = pMaxSpeed;
	newKartModule.Player = nil;
	newKartModule.mConnections = {};
	
	return newKartModule
end



--[[
	Function Name: KartSetUp
	Parameter: KartModel
	Return: Nil
	
	Purpose: Set up other type of karts (A Chasis 6.52S2) to be compatible
--]]
function KartModule:KartSetUp()
	-- A Chassis script swap
	local aChassisTune = self.KartModel:FindFirstChild("A-Chassis Tune");

	if (aChassisTune) then
		local readMe = aChassisTune:FindFirstChild("README");
		if (readMe) then
			local buildVersion = require(readMe);
			if (buildVersion == "6.52S2") then
				local interface = aChassisTune:FindFirstChild("A-Chassis Interface");
				if (interface) then
					local drive = interface:FindFirstChild("Drive");
					if (drive) then
						drive:Destroy();
						local newDrive = mMiscFolder.Drive:Clone();
						newDrive.Parent = interface;
						newDrive.Disabled = false;
						
						local initialize = aChassisTune:FindFirstChild("Initialize");
						if (initialize) then
							initialize.Disabled = false;
						end
					end
				end
			end
		end
	end
	
	-- Vehicle seat events
	local vehicleSeat = self.KartModel:FindFirstChildOfClass("VehicleSeat");
	local OnVehicleSeatChangedEvent = vehicleSeat.Changed:Connect(function(pProperty)
		if pProperty == "Occupant" then
			local humanoid = vehicleSeat.Occupant
			if humanoid then
				local player = game:GetService("Players"):GetPlayerFromCharacter(humanoid.Parent)
				if player then
					-- Occupant added
					self:OnOccupantAdded(player); 
				end
			else
				-- Occupant removed
				self:OnOccupantRemoved();
			end
		end
	end);
	
	table.insert(self.mConnections, OnVehicleSeatChangedEvent);
	
	-- Max speed
	self:UpdateMaxSpeed(self.MaxSpeed);
	
	-- Script activation
	local kartServerScript = self.KartModel:FindFirstChild("Yar890Kart");
	if (kartServerScript) then
		kartServerScript.Disabled = false;
	end
end



--[[
	Function Name: KartModule:OnOccupantAdded
	Parameter: Object (Weld)
	Return: Nil
	
	Purpose: If player added, set kart player and fire outbound event. Start anti cheat loop check.
--]]
function KartModule:OnOccupantAdded(pPlayer)
	-- Set player and run added to kart outbound event
	self.Player = pPlayer;
	mOutboundFolder.PlayerAddedToKart:Fire(pPlayer, self);
	
	-- Get humanoid and vehicle seat
	local vehicleSeat = self.KartModel:FindFirstChildOfClass("VehicleSeat");
	local playerHumanoid = pPlayer.Character:WaitForChild("Humanoid");
	
	-- Get anti cheat variables
	local antiCheatCurrentLives = mLightOverspeedTimeValue.Value;
	local antiCheatHardLimit = mRacingLightConfiguration.LightSpeed.Green.Value + mHardLimitOffsetValue.Value;
	local prevPosition = vehicleSeat.Position;
	
	-- Run anti cheat loop if enabled
	if (mAntiCheatEnabled.Value == true) then
		-- Run on seperate thread
		spawn(function()
			-- Loop until humanoid leaves seat
			while (vehicleSeat.Occupant == playerHumanoid) do
				-- Get current position and distance from last position
				local currentPosition = vehicleSeat.Position
				local distance = (prevPosition - currentPosition).magnitude;
				
				-- If distance exists
				if (distance) then
					if (distance > math.floor(self.MaxSpeed + mLightLimitOffsetValue.Value)) then
						-- When kart goes over light speed + offset, remove 1 time
						antiCheatCurrentLives -= 1;
					else
						-- Reset lives as no longer speeding
						antiCheatCurrentLives = mLightOverspeedTimeValue.Value;
					end
					
					if (antiCheatCurrentLives <= 0) then
						-- Lives reached 0, kick player
						print("Kart Anti Cheat: "..pPlayer.Name.."has been kick for speeding kart over light limit");
						pPlayer:Kick("Kart Anti Cheat: Speeding kart over light limit");
					end
					
					if (distance > antiCheatHardLimit) then
						-- Kick player when passing over hard limit (Green light + offset)
						print("Kart Anti Cheat: "..pPlayer.Name.."has been kick for speeding kart over hard limit");
						pPlayer:Kick("Kart Anti Cheat: Speeding kart over max possible limit");
					end
					
					-- Set prevoius location to current location
					prevPosition = currentPosition;
					
					-- Wait 1 second till next check
					wait(1);
				end
			end
		end)
	end
	
end



--[[
	Function Name: KartModule:OnOccupantRemoved
	Parameter: Object (Weld)
	Return: Nil
	
	Purpose: If player removed, fire outbound event and set kart player to nil.
--]]
function KartModule:OnOccupantRemoved(pPlayer)
	if(self.Player ~= nil) then
		mOutboundFolder.PlayerRemovedFromKart:Fire(self.Player, self);
		self.Player = nil;
	end
end



--[[
	Function Name: KartModule:UpdateMaxSpeed
	Parameter: Object, Int
	Return: nil
	
	Purpose: Updates the kart max speed via Vehicle Seat
--]]
function KartModule:UpdateMaxSpeed(pNewMaxSpeed)
	self.MaxSpeed = pNewMaxSpeed;
	self.KartModel:FindFirstChildOfClass("VehicleSeat").MaxSpeed = pNewMaxSpeed;
end



--[[
	Function Name: KartModule:DeleteKart
	Parameter: Object
	Return: nil
	
	Purpose: Deletes the kart via Destroy()
--]]
function KartModule:DeleteKart()
	if (self.KartModel) then
		self.KartModel:Destroy();
	end
	self.KartModel = nil;
	
	for _, connection in pairs(self.mConnections) do
		connection:Disconnect();
		connection = nil;
	end

	self.mConnections = nil;

	self = nil;
end

return KartModule
