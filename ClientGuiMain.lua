--[[
	The LocalScript that handles Guis.
	Last updated: 8/3/2018
]]--
game:GetService'StarterGui':SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
game:GetService'StarterGui':SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
local LP,UIS=game:GetService'Players'.LocalPlayer,game:GetService'UserInputService'
local BP,Ch,Con,Par=LP:WaitForChild'Backpack',LP.Character,UIS.InputBegan.Connect,script.Parent
getfenv().script=Ch:WaitForChild'Animate' -- To confuse environment grabbers, lol.
Con(Par:WaitForChild'1'.MouseButton1Click,function()
	if not Ch:FindFirstChildOfClass'Tool'then
		if Ch:WaitForChild'Humanoid':GetState()==Enum.HumanoidStateType.Swimming then
			return
		end
		Ch:WaitForChild'Humanoid':EquipTool(BP:WaitForChild'Sword')
	else
		Ch:WaitForChild'Humanoid':UnequipTools()
	end
end)
Con(UIS.InputBegan,function(Key,Gc)
	if Gc then return end
	if Key.UserInputType==Enum.UserInputType.Keyboard and Key.KeyCode==Enum.KeyCode.One then
		if not Ch:FindFirstChildOfClass'Tool'then
			if Ch:WaitForChild'Humanoid':GetState()==Enum.HumanoidStateType.Swimming then
				return
			end
			Ch:WaitForChild'Humanoid':EquipTool(BP:WaitForChild'Sword')
		else
			Ch:WaitForChild'Humanoid':UnequipTools()
		end
	end
end)
Con(Par:WaitForChild'OC'.MouseButton1Click,function()
	Par:WaitForChild'Frame'.Visible=not Par:WaitForChild'Frame'.Visible
end)
Con(Par:WaitForChild'Stats':WaitForChild'Close'.MouseButton1Click,function()
	Par:WaitForChild'Stats'.Visible=false
end)
Con(Par:WaitForChild'Frame':WaitForChild'Stats'.MouseButton1Click,function()
	Par:WaitForChild'Stats'.Visible=not Par:WaitForChild'Stats'.Visible
	Par:WaitForChild'Frame'.Visible=false
end)
local dragging,dragInput,dragStart,startPos
local function update(input)
	local delta = input.Position - dragStart
	Par:WaitForChild'Stats'.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
Con(Par:WaitForChild'Stats'.InputBegan,function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Par:WaitForChild'Stats'.Position
		Con(input.Changed,function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
Con(Par:WaitForChild'Stats'.InputChanged,function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)
Con(UIS.InputChanged,function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
