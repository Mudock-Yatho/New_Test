--[[
	The LocalScript that handles Guis and equipping/unequipping tools.
	Last updated: 8/4/2018
]]--
game:GetService'StarterGui':SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
game:GetService'StarterGui':SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
local LP,UIS=game:GetService'Players'.LocalPlayer,game:GetService'UserInputService'
local BP,Ch,Con,Par=LP:WaitForChild'Backpack',LP.Character,UIS.InputBegan.Connect,script.Parent
getfenv().script=Ch:WaitForChild'Animate'
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
	if Key.UserInputType==Enum.UserInputType.Keyboard then
		if Key.KeyCode==Enum.KeyCode.One then
			if not Ch:FindFirstChildOfClass'Tool'then
				if Ch:WaitForChild'Humanoid':GetState()==Enum.HumanoidStateType.Swimming then
					return
				end
				Ch:WaitForChild'Humanoid':EquipTool(BP:WaitForChild'Sword')
			else
				Ch:WaitForChild'Humanoid':UnequipTools()
			end
		end
	end
end)
Con(Par:WaitForChild'OC'.MouseButton1Click,function()
	Par:WaitForChild'Frame'.Visible=not Par:WaitForChild'Frame'.Visible
end)
Con(Par:WaitForChild'Stats':WaitForChild'Close'.MouseButton1Click,function()
	Par:WaitForChild'Stats'.Visible=false
end)
Con(Par:WaitForChild'Settings':WaitForChild'Close'.MouseButton1Click,function()
	Par:WaitForChild'Settings'.Visible=false
end)
Con(Par:WaitForChild'Frame':WaitForChild'Stats'.MouseButton1Click,function()
	Par:WaitForChild'Stats'.Visible=not Par:WaitForChild'Stats'.Visible
	Par:WaitForChild'Frame'.Visible=false
end)
Con(Par:WaitForChild'Frame':WaitForChild'Settings'.MouseButton1Click,function()
	Par:WaitForChild'Settings'.Visible=not Par:WaitForChild'Settings'.Visible
	Par:WaitForChild'Frame'.Visible=false
end)
local MV=LP:FindFirstChild'MV'
if not MV then
	MV=Instance.new'NumberValue'
	MV.Name='MV'
	MV.Value=1
	MV.Parent=LP
end
local GameMusic=workspace.CurrentCamera:FindFirstChild'Sound'
if not GameMusic then
	GameMusic=Instance.new'Sound'
	GameMusic.SoundId='rbxassetid://1082285059'
	GameMusic.Volume=MV.Value
	GameMusic.Looped=true
	GameMusic.Parent=workspace.CurrentCamera
end
wait()
GameMusic:Play()
Par:WaitForChild'Settings':WaitForChild'Frame':WaitForChild'MV'.Text='Music Volume: '..tostring(GameMusic.Volume)
Con(Par:WaitForChild'Settings':WaitForChild'Frame':WaitForChild'Add'.MouseButton1Click,function()
	MV.Value=MV.Value+.25
	GameMusic.Volume=MV.Value
	Par:WaitForChild'Settings':WaitForChild'Frame':WaitForChild'MV'.Text='Music Volume: '..tostring(GameMusic.Volume)
end)
Con(Par:WaitForChild'Settings':WaitForChild'Frame':WaitForChild'Sub'.MouseButton1Click,function()
	MV.Value=MV.Value-.25
	GameMusic.Volume=MV.Value
	Par:WaitForChild'Settings':WaitForChild'Frame':WaitForChild'MV'.Text='Music Volume: '..tostring(GameMusic.Volume)
end)
local dragging,dragInput,dragStart,startPos
local draggings2,dragStart2,startPos2
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
Con(Par:WaitForChild'Settings'.InputBegan,function(Input)
	if Input.UserInputType==Enum.UserInputType.MouseButton1 or Input.UserInputType==Enum.UserInputType.Touch then
		dragging2=true
		dragStart2=Input.Position
		startPos2=Par:WaitForChild'Settings'.Position
		Con(Input.Changed,function()
			if Input.UserInputState==Enum.UserInputState.End then
				dragging2=false
			end
		end)
	end
end)
Con(Par:WaitForChild'Settings'.InputChanged,function(input)
	if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
		dragInput=input
	end
end)
Con(UIS.InputChanged,function(input)
	if input==dragInput and dragging then
		local delta = input.Position - dragStart
		Par:WaitForChild'Stats'.Position=UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	elseif input==dragInput and dragging2 then
		local delta = input.Position-dragStart2
		Par:WaitForChild'Settings'.Position=UDim2.new(startPos2.X.Scale, startPos2.X.Offset + delta.X, startPos2.Y.Scale, startPos2.Y.Offset + delta.Y)
	end
end)
