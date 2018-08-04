--[[
	The server's main script that handles stats and remotes.
	Last updated: 8/3/2018
	
	Quite a few things are localized here that you may notice aren't used, this is because I've removed **1** part of the
	script that isn't open-sourced.
]]--
local wfc=game.WaitForChild
local mc,Con,wa,war,bj,ts=math.ceil,game.ChildAdded.Connect,wait,warn,wfc(workspace,'Spawns').BreakJoints,tostring
Con(game:GetService'Players'.PlayerAdded,function(Player)
	local Stats=Instance.new'Folder'
	Stats.Name='Stats'
	local Level=Instance.new'NumberValue'
	Level.Name='Level'
	local Experience=Instance.new'NumberValue'
	Experience.Name='Experience'
	local Strength=Instance.new'NumberValue'
	Strength.Name='Strength'
	local Endurance=Instance.new'NumberValue'
	Endurance.Name='Endurance'
	local Agility=Instance.new'NumberValue'
	Agility.Name='Agility'
	local Perception=Instance.new'NumberValue'
	Perception.Name='Perception'
	Stats.Parent=Player
	-- Snipped non-open-sourced code.
end)
local Deb={}
Con(wfc(game:GetService'ReplicatedStorage','Obj').OnServerEvent,function(Player,Damage)
	if not Damage or type(Damage)~='number'or Damage<=0 or Deb[Player.UserId]then
		warn('['..Player.Name..'|'..Player.UserId..'] Tried to fire `Obj` incorrectly!')
		Player:Kick'Stop.'
		return
	end
	Deb[Player.UserId]=true
	if Player.Character and Player.Character:FindFirstChild'Humanoid'then
		if Player.Character:FindFirstChild'Head'then
			local zZ=Instance.new'BillboardGui'
			zZ.Adornee=Player.Character:FindFirstChild'Head'
			zZ.Active = true
			zZ.StudsOffset = Vector3.new(0,4,0)
			zZ.Size = UDim2.new(0, 200, 0, 50)
			local xX = Instance.new'TextLabel'
			xX.Text = '-'..Damage
			xX.Active = true
			xX.BackgroundTransparency = 1
			xX.ClipsDescendants = true
			xX.TextColor3 = BrickColor.Red().Color
			xX.Font = Enum.Font.Fantasy
			xX.TextScaled = true
			xX.Size = UDim2.new(0, 200, 0, 50)
			xX.Parent=zZ
			zZ.Parent=Player.Character:FindFirstChild'Head'
			game:GetService'Debris':AddItem(zZ,1.5)
		end
		Player.Character:FindFirstChild'Humanoid':TakeDamage(Damage)
	end
	wa(.15)
	Deb[Player.UserId]=nil
end)
while wa(.25)do
	game:GetService'Lighting'.ClockTime=game:GetService'Lighting'.ClockTime+.025
end
