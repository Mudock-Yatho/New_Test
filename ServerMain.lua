--[[
	The server's main script.
]]--
local wfc,dss=game.WaitForChild,game:GetService'DataStoreService':GetDataStore'Stats1'
local mc,Con,wa,war,bj,ts=math.ceil,game.ChildAdded.Connect,wait,warn,wfc(workspace,'Spawns').BreakJoints,tostring
Con(game:GetService'Players'.PlayerAdded,function(Player)
	local Stats=Instance.new'Folder'
	Stats.Name='Stats'
	local Level=Instance.new'NumberValue'
	Level.Name='Level'
	local Exp=Instance.new'NumberValue'
	Exp.Name='Exp'
	local Str=Instance.new'NumberValue'
	Str.Name='Strength'
	local End=Instance.new'NumberValue'
	End.Name='Endurance'
	local Agi=Instance.new'NumberValue'
	Agi.Name='Agility'
	local Per=Instance.new'NumberValue'
	Per.Name='Perception'
	for Idx=1,3 do
		local a,b=pcall(dss.GetAsync,dss,Player.UserId)
		if a and b then
			Level.Value=b[1]or 1
			Exp.Value=b[2]or 0
			Str.Value=b[3]or 0
			End.Value=b[4]or 0
			Agi.Value=b[5]or 0
			Per.Value=b[6]or 0
			break
		elseif not a then
			warn('['..tostring(Idx)..'] Player: '..Player.Name..' failed to load stats: '..tostring(b))
		end
		wait(.5)
	end
	Stats.Parent=Player
	-- Snipped a part that isn't open-sourced.
end)
Con(game:GetService'Players'.PlayerRemoving,function(Player)
	local Stats=Player:WaitForChild'Stats'
	for Idx=1,3 do
		local a,b=pcall(dss.SetAsync,dss,Player.UserId,{Stats.Level.Value,Stats.Exp.Value,Stats.Strength.Value,Stats.Endurance.Value,Stats.Agility.Value,Stats.Perception.Value})
		if a then
			break
		else
			warn('['..tostring(Idx)..'] Player: '..Player.Name..' failed to save stats: '..tostring(b))
		end
		wait(.5)
	end
	wait(.125)
	if Stats and Stats.Parent then
		Stats:Destroy()
	end
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
	wait(.15)
	Deb[Player.UserId]=nil
end)
