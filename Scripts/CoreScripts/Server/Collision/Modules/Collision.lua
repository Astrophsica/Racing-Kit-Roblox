--[[

	This script was made by AstrophsicaDev
	
	Module Name: CollisionModule
	Purpose: Deals with collision groups
--]]



----------------------------------------- Variables -----------------------------------------
-- Module
local CollisionModule = {}

-- OOP Set up
CollisionModule.__index = CollisionModule;

-- Services
local PhysicsService = game:GetService("PhysicsService");
local Players = game:GetService("Players");
 
-- Collision group names
local mPlayerCollisionGroupName = "KartPlayers";
local mKartCollisionGroupName = "Karts";

-- Stores players prevoius object collision groups (Used for hats, items etc)
local mPreviousCollisionGroups = {}

-- Stores current collision status
local mCollisionStatus = true;

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: CollisionModule.new
	Parameters: Nil
	Return: Nil
	
	Purpose: Initialises collision class. Sets up new collision groups.
--]]
function CollisionModule.new()
	local newCollisionModule = {};
	setmetatable(newCollisionModule, CollisionModule);
	
	-- Create collision groups
	PhysicsService:CreateCollisionGroup(mPlayerCollisionGroupName)
	PhysicsService:CreateCollisionGroup(mKartCollisionGroupName)
	
	-- Set collidable properties
	PhysicsService:CollisionGroupSetCollidable(mPlayerCollisionGroupName, mPlayerCollisionGroupName, mCollisionStatus)
	PhysicsService:CollisionGroupSetCollidable(mKartCollisionGroupName, mKartCollisionGroupName, mCollisionStatus)
	PhysicsService:CollisionGroupSetCollidable(mPlayerCollisionGroupName, mKartCollisionGroupName, mCollisionStatus)
	
	return newCollisionModule;
end



--[[
	Function Name: CollisionModule.OnToggleCollision
	Parameters: Nil
	Return: Nil
	
	Purpose: Toggles mCollisionStatus and updates collision group collidable status.
--]]
function CollisionModule:OnToggleCollision()
	-- Update collision status
	mCollisionStatus = not mCollisionStatus;
	
	-- Set collidable properties
	PhysicsService:CollisionGroupSetCollidable(mPlayerCollisionGroupName, mPlayerCollisionGroupName, mCollisionStatus)
	PhysicsService:CollisionGroupSetCollidable(mKartCollisionGroupName, mKartCollisionGroupName, mCollisionStatus)
	PhysicsService:CollisionGroupSetCollidable(mPlayerCollisionGroupName, mKartCollisionGroupName, mCollisionStatus)
	
	return mCollisionStatus;
end



--[[
	Function Name: SetCollisionGroup
	Parameters: Object, String
	Return: Nil
	
	Purpose: Assigns object to a collision group if it is a "BasePart".
--]]
local function SetCollisionGroup(pObject, pCollisionGroupName)
	if pObject:IsA("BasePart") then
		mPreviousCollisionGroups[pObject] = pObject.CollisionGroupId;
		PhysicsService:SetPartCollisionGroup(pObject, pCollisionGroupName);
	end
end
 


--[[
	Function Name: SetCollisionGroupRecursive
	Parameters: Object, String
	Return: Nil
	
	Purpose: Runs SetCollisionGroup for object and all its decendants.
--]]
local function SetCollisionGroupRecursive(pObject, pCollisionGroupName)
	SetCollisionGroup(pObject, pCollisionGroupName);
 
	for _, child in ipairs(pObject:GetChildren()) do
		SetCollisionGroupRecursive(child, pCollisionGroupName);
	end
end
 


--[[
	Function Name: ResetCollisionGroup
	Parameters: Object
	Return: Nil
	
	Purpose: Returns object back to its previous collision group.
--]]
local function ResetCollisionGroup(pObject)
	if pObject:IsA("BasePart") then
		local previousCollisionGroupId = mPreviousCollisionGroups[pObject];
		if not previousCollisionGroupId then return end	
	 
		local previousCollisionGroupName = PhysicsService:GetCollisionGroupName(previousCollisionGroupId)
		if not previousCollisionGroupName then return end
	 
		PhysicsService:SetPartCollisionGroup(pObject, previousCollisionGroupName);
		mPreviousCollisionGroups[pObject] = nil;
	end
end
 


--[[
	Function Name: ResetCollisionGroupRecursive
	Parameters: Object
	Return: Nil
	
	Purpose:  Runs ResetCollisionGroup for object and all its decendants.
--]]
local function ResetCollisionGroupRecursive(pObject)
	ResetCollisionGroup(pObject);
 
	for _, child in ipairs(pObject:GetChildren()) do
		ResetCollisionGroupRecursive(child);
	end
end



--[[
	Function Name: OnCharacterAdded
	Parameters: Model (Player Character)
	Return: Nil
	
	Purpose: Runs when character sits in kart. Assign collision group including for all
	future decendants add. Also resets collision group for decendants removed.
--]]
local function OnCharacterAdded(character)
	SetCollisionGroupRecursive(character, mPlayerCollisionGroupName)
 
	character.DescendantAdded:Connect(function(pObject) 
		SetCollisionGroup(pObject, mPlayerCollisionGroupName);
	end)
	
	character.DescendantRemoving:Connect(function(pObject)
		ResetCollisionGroup(pObject);
	end)
end



--[[
	Function Name: OnKartAdded
	Parameters: Object
	Return: Nil
	
	Purpose: On kart added, add the kart to kart collision group
--]]
function CollisionModule:OnKartAdded(pKart)
	SetCollisionGroupRecursive(pKart.KartModel, mKartCollisionGroupName);
end



--[[
	Function Name: OnPlayerAddedToKart
	Parameters: Player, KartModule
	Return: Nil
	
	Purpose: On player added to kart, add the player to player collision group
--]]
function CollisionModule:OnPlayerAddedToKart(pPlayer, pKart)
	local character = pPlayer.Character;
	if (character) then
		OnCharacterAdded(character);
	end
end



--[[
	Function Name: OnPlayerRemovedFromKart
	Parameters: Player, KartModule
	Return: Nil
	
	Purpose: On player removed from kart, remove collisions for player
--]]
function CollisionModule:OnPlayerRemovedFromKart(pPlayer, pKart)
	local character = pPlayer.Character;
	if (character) then
		ResetCollisionGroupRecursive(character);
	end
end

return CollisionModule
