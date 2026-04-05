file.CreateDir("npc_physical_mod")

util.AddNetworkString( "Ragdollize_ChangeReplacementList_cTs" )
util.AddNetworkString( "Ragdollize_CreateHeadCrab_sTc" )
util.AddNetworkString( "Ragdollize_EndAnimation_sTc" )
util.AddNetworkString( "Ragdollize_EndAnimation_cTs" )
util.AddNetworkString( "Ragdollize_PoseFingerBone_sTc" )

local CVAR_Ragdollize_Enable 	= CreateConVar("ragdollize_enable", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable", 0, 1)

local CVAR_Ragdollize_Detail 	= CreateConVar("ragdollize_detail", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable2", 0, 1)
local CVAR_Ragdollize_NoOpti 	= CreateConVar("ragdollize_noopti", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable3", 0, 1)

local CVAR_Ragdollize_AltDmg 	= CreateConVar("ragdollize_altdmg", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable4", 0, 1)
local CVAR_Ragdollize_DmgReal 	= CreateConVar("ragdollize_dmgreal", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable5", 0, 1)
local CVAR_Ragdollize_DmgMulti 	= CreateConVar("ragdollize_dmgmulti", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable6", 0, 10)
local CVAR_Ragdollize_FingerPose 		= CreateConVar("ragdollize_fingerpose", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable10", 0, 1)

local CVAR_Ragdollize_ReplaceCombine 	= CreateConVar("ragdollize_replacecombine", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable7", 0, 1)
local CVAR_Ragdollize_ReplaceCitizen 	= CreateConVar("ragdollize_replacecitizen", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable8", 0, 1)
local CVAR_Ragdollize_ReplaceZombies 	= CreateConVar("ragdollize_replacezombies", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable9", 0, 1)
local CVAR_Ragdollize_EnableHeadcrab 	= CreateConVar("ragdollize_enableheadcrab", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable9", 0, 1)
local CVAR_Ragdollize_ScaleModel 		= CreateConVar("ragdollize_scalemodel", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable10", 0, 1)

local CVAR_Ragdollize_SlowLoad 			= CreateConVar("ragdollize_slowload", 1, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable10", 0, 1)
local CVAR_Ragdollize_MaxNumber 		= CreateConVar("ragdollize_maxnumber", 10, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable10")
local CVAR_Ragdollize_ReduceNPCNumber 	= CreateConVar("ragdollize_reducenpcnumber", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable10", 0, 1)

local CVAR_Ragdollize_NoCollidePly		= CreateConVar("ragdollize_nocollide_ply", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable10", 0, 1)
local CVAR_Ragdollize_NoCollideAll		= CreateConVar("ragdollize_nocollide_all", 0, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "enable10", 0, 1)


--这样为了方便调试模组
if not Ragdollize_Tb then
	Ragdollize_Tb = {}				--最核心的表格，所有Ragdollized的NRag都在里边
end

if not Ragdollize_LoadingTb then
	Ragdollize_LoadingTb = {} 		--用于SlowLoad功能的表格，存储着所有等待着Ragdollized的NPC，并依次放他们Ragdollized，防止扎堆一起Ragdollized导致游戏崩溃
end

if not Ragdollize_LastLoadingTime then
	Ragdollize_LastLoadingTime = 0	--用于SlowLoad功能，记录了上一次Ragdollized的时间，于是下一个NPC排队进行Ragdollized的时刻就为该时间+0.5s
end

local NrmTb = {
	["ValveBiped.Bip01_Pelvis"] 	= true,
	["ValveBiped.Bip01_Spine1"] 	= true,
	["ValveBiped.Bip01_Spine2"] 	= true,
	["ValveBiped.Bip01_Spine4"] 	= true,
	["ValveBiped.Bip01_R_Thigh"] 	= true,
	["ValveBiped.Bip01_R_Calf"] 	= true,
	["ValveBiped.Bip01_R_Foot"] 	= true,
	["ValveBiped.Bip01_L_Thigh"] 	= true,
	["ValveBiped.Bip01_L_Calf"] 	= true,
	["ValveBiped.Bip01_L_Foot"] 	= true,
	["ValveBiped.Bip01_R_Clavicle"] = true,
	["ValveBiped.Bip01_R_UpperArm"] = true,
	["ValveBiped.Bip01_R_Forearm"] 	= true,
	["ValveBiped.Bip01_R_Hand"] 	= true,
	["ValveBiped.Bip01_L_Clavicle"] = true,
	["ValveBiped.Bip01_L_UpperArm"] = true,
	["ValveBiped.Bip01_L_Forearm"] 	= true,
	["ValveBiped.Bip01_L_Hand"] 	= true,
	["ValveBiped.Bip01_Head1"] 		= true
}

local Hitbox_Tb = {
								 --HitGroup  --DamgeFactor
	["ValveBiped.Bip01_Pelvis"] 	= {"BD", 1.00},
	["ValveBiped.Bip01_Spine"] 		= {"BD", 1.00},
	["ValveBiped.Bip01_Spine1"] 	= {"BD", 1.00},
	["ValveBiped.Bip01_Spine2"] 	= {"BD", 1.00},
	["ValveBiped.Bip01_Spine3"] 	= {"BD", 1.00},
	["ValveBiped.Bip01_Spine4"] 	= {"BD", 1.00},

	["ValveBiped.Bip01_R_Thigh"] 	= {"RL", 0.8},
	["ValveBiped.Bip01_L_Thigh"] 	= {"LL", 0.8},
	["ValveBiped.Bip01_R_Clavicle"] = {"RA", 0.8},
	["ValveBiped.Bip01_L_Clavicle"] = {"LA", 0.8},
	["ValveBiped.Bip01_R_UpperArm"] = {"RA", 0.8},
	["ValveBiped.Bip01_L_UpperArm"] = {"LA", 0.8},

	["ValveBiped.Bip01_R_Calf"] 	= {"RL", 0.6},
	["ValveBiped.Bip01_L_Calf"] 	= {"LL", 0.6},
	["ValveBiped.Bip01_R_Forearm"] 	= {"RA", 0.6},
	["ValveBiped.Bip01_L_Forearm"] 	= {"LA", 0.6},

	["ValveBiped.Bip01_R_Foot"] 	= {"RL", 0.3},
	["ValveBiped.Bip01_L_Foot"] 	= {"LL", 0.3},
	["ValveBiped.Bip01_R_Hand"] 	= {"RA", 0.3},
	["ValveBiped.Bip01_L_Hand"] 	= {"LA", 0.3},

	["ValveBiped.Bip01_Head1"] 		= {"HD", 5.00}
}

local Gib_Tb = {
	["ValveBiped.Bip01_Pelvis"] 	= 1,
	["ValveBiped.Bip01_Spine1"] 	= 1,
	["ValveBiped.Bip01_Spine4"] 	= 1,
	["ValveBiped.Bip01_R_Thigh"] 	= 2.1,
	["ValveBiped.Bip01_R_Calf"] 	= 2.1,
	["ValveBiped.Bip01_R_Foot"] 	= 2.1,
	["ValveBiped.Bip01_L_Thigh"] 	= 2.2,
	["ValveBiped.Bip01_L_Calf"] 	= 2.2,
	["ValveBiped.Bip01_L_Foot"] 	= 2.2,
	["ValveBiped.Bip01_R_Clavicle"] = 2.3,
	["ValveBiped.Bip01_R_UpperArm"] = 2.3,
	["ValveBiped.Bip01_R_Forearm"] 	= 2.3,
	["ValveBiped.Bip01_R_Hand"] 	= 2.3,
	["ValveBiped.Bip01_L_Clavicle"] = 2.4,
	["ValveBiped.Bip01_L_UpperArm"] = 2.4,
	["ValveBiped.Bip01_L_Forearm"] 	= 2.4,
	["ValveBiped.Bip01_L_Hand"] 	= 2.4,
	["ValveBiped.Bip01_Head1"] 		= 3	
}

local ColiTb1 = {
	"ValveBiped.Bip01_R_Foot",
	"ValveBiped.Bip01_L_Foot",
	"ValveBiped.Bip01_R_Hand",
	"ValveBiped.Bip01_L_Hand",
}

local ColiTb2 = {
	"ValveBiped.Bip01_R_Hand",
	"ValveBiped.Bip01_L_Hand",
}

local ZombieClass = {
	["npc_zombie"] = true,
	["npc_zombine"] = true,
	["npc_zombie_torso"] = true,
	["npc_poisonzombie"] = true,
	["npc_fastzombie_torso"] = true,
	["npc_fastzombie"] = true,
}

local ZombieClass_Torso = {
	["npc_zombie_torso"] = true,
	["npc_fastzombie_torso"] = true,
}

local ZombieClass_Normal = {
	["npc_zombie"] = true,
	["npc_zombine"] = true,
	["npc_zombie_torso"] = true,
}

local ZombieClass_Fast = {
	["npc_fastzombie_torso"] = true,
	["npc_fastzombie"] = true,
}

local ZombieClass_Poison = {
	["npc_poisonzombie"] = true,
}

local ZombieClass_Headcrab = {
	["npc_headcrab"] = true,
	["npc_headcrab_fast"] = true,
	["npc_headcrab_poison"] = true,
	["npc_headcrab_black"] = true,
}

local ZombieClass_HeadcrabCheck = {
	["npc_zombie"] = "models/headcrabclassic.mdl",
	["npc_zombine"] = "models/headcrabclassic.mdl",
	["npc_zombie_torso"] = "models/headcrabclassic.mdl",
	["npc_poisonzombie"] = "models/headcrabblack.mdl",
	["npc_fastzombie_torso"] = "models/headcrab.mdl",
	["npc_fastzombie"] = "models/headcrab.mdl",
}

local ZombieModel = {
	["models/zombie/classic.mdl"] = true,
	["models/zombie/classic_torso.mdl"] = true,
	["models/zombie/zombie_soldier.mdl"] = true,
	["models/zombie/fast.mdl"] = true,
	["models/zombie/fast_torso.mdl"] = true,
	["models/zombie/poison.mdl"] = true,
}

local ZombieModel_SwitchTorso = {
	["models/zombie/classic.mdl"] = {
										["Class"] = "npc_zombie_torso",
										["Model"] = "models/zombie/classic_torso.mdl",
									},
	["models/zombie/fast.mdl"] = 	{
										["Class"] = "npc_fastzombie_torso",
										["Model"] = "models/zombie/fast_torso.mdl",
									},
	["models/zombie/poison.mdl"] = {
										["Class"] = "npc_zombie_torso",
										["Model"] = "models/zombie/classic_torso.mdl",
									},									
}

local HeadcrabCorpse_AllowCreation = true --若为true，则当替换僵尸时，在僵尸死亡后生成一个猎头蟹尸体。可如果同时（0.1秒内）在附近位置还生成了一个活的猎头蟹，则说明这个活猎头蟹是由该僵尸生成的，于是该值变为false（持续0.1秒），不生成猎头蟹尸体
local HeadcrabAlive_AllowCreation = true  --若为true，则当僵尸死亡时，允许其正常生成活的猎头蟹；若为false，则僵尸死亡时不生成活的猎头蟹
local HeadcrabCorpse_Pos = nil

local CombineModel = {
	["models/combine_soldier.mdl"] = true,
	["models/combine_soldier_prisonguard.mdl"] = true,
	["models/combine_super_soldier.mdl"] = true,
	["models/police.mdl"] = true,
	["models/police_cheaple.mdl"] = true,
	["models/po1ic3.mdl"] = true,
	["models/leet_police2.mdl"] = true,
}

local PoliceModel = {
	["models/police.mdl"] = true,
	["models/police_cheaple.mdl"] = true,
	["models/po1ic3.mdl"] = true,
	["models/leet_police2.mdl"] = true,
}

local NPCHeight = {
	["combine"] 		= 63.9,
	["police"] 			= 62.7,
	["citizen_female"] 	= 60.2,
	["citizen_male"] 	= 63.6,
	["zombies"] 		= 61.9,
}

--[[-------------------------------------------------------------------------
与Enhanced Death Animations的兼容，在开启Ragdollize NPC时，修改ComputeShadowControl的参数，让死亡衔接更自然
---------------------------------------------------------------------------]]
local IsEDAInstalled = false
timer.Simple(1, function()
	if hook.GetTable()["OnEntityCreated"]["Animrag_OnEntityCreated"] then
		IsEDAInstalled = true
	end
end)

Animrag_CSC_1 = {		
	secondstoarrive = 0.01,
	pos = Vector(0, 0, 0),
	angle = Angle(0, 0, 0),
	maxangular = 400,
	maxangulardamp = 200,
	maxspeed = 400,
	maxspeeddamp = 300,
	teleportdistance = 0
}

Animrag_CSC_2 = {		
	secondstoarrive = 0.01,
	pos = Vector(0, 0, 0),
	angle = Angle(0, 0, 0),
	maxangular = 40,
	maxangulardamp = 20,
	maxspeed = 40,
	maxspeeddamp = 30,
	teleportdistance = 0
}

if CVAR_Ragdollize_Enable:GetBool() or CVAR_Ragdollize_ReplaceCombine:GetBool() or CVAR_Ragdollize_ReplaceCitizen:GetBool() or CVAR_Ragdollize_ReplaceZombies:GetBool() then
	Animrag_CSC = Animrag_CSC_2
else
	Animrag_CSC = Animrag_CSC_1
end

cvars.AddChangeCallback("ragdollize_enable", function(convar_name, value_old, value_new)
	if CVAR_Ragdollize_Enable:GetBool() then
		Animrag_CSC = Animrag_CSC_2
	else
		Animrag_CSC = Animrag_CSC_1
	end
end)

--[[-------------------------------------------------------------------------
初始化 combineTb 和 citizenTb 和 zombiesTb
---------------------------------------------------------------------------]]
local combineTb = {}
local citizenTb = {}
local zombiesTb = {}

function Ragdollize_ReloadReplaceTable()
	local combineTb_file = file.Open("npc_physical_mod/combine_table.txt", "r", "DATA")
	local citizenTb_file = file.Open("npc_physical_mod/citizen_table.txt", "r", "DATA")
	local zombiesTb_file = file.Open("npc_physical_mod/zombies_table.txt", "r", "DATA")
	
	if combineTb_file then
		combineTb = util.JSONToTable( file.Read("npc_physical_mod/combine_table.txt", "DATA") )
	else
		combineTb = {}
		file.Write("npc_physical_mod/combine_table.txt", "[]")
	end
	
	if citizenTb_file then
		citizenTb = util.JSONToTable( file.Read("npc_physical_mod/citizen_table.txt", "DATA") )
	else
		citizenTb = {}
		file.Write("npc_physical_mod/citizen_table.txt", "[]")
	end
	
	if zombiesTb_file then
		zombiesTb = util.JSONToTable( file.Read("npc_physical_mod/zombies_table.txt", "DATA") )
	else
		zombiesTb = {}
		file.Write("npc_physical_mod/zombies_table.txt", "[]")
	end
end

Ragdollize_ReloadReplaceTable()

local ShuffleIndex_Combine = math.random(1, #combineTb)
local ShuffleIndex_Citizen = math.random(1, #citizenTb)
local ShuffleIndex_Zombies = math.random(1, #zombiesTb)

function Ragdollize_ShuffleTable(tb)
	for i = #tb, 2, -1 do
		local j = math.random(1, i)
		tb[i], tb[j] = tb[j], tb[i]
	end

	local validModels = {}
	for _, data in pairs(tb) do
		if util.IsValidModel(data.Model) then
			table.insert(validModels, data)
		end
	end

	return validModels
end

combineTb = Ragdollize_ShuffleTable(combineTb)
citizenTb = Ragdollize_ShuffleTable(citizenTb)
zombiesTb = Ragdollize_ShuffleTable(zombiesTb)

net.Receive("Ragdollize_ChangeReplacementList_cTs", function()
	Ragdollize_ReloadReplaceTable()
	ShuffleIndex_Combine = 1
	ShuffleIndex_Citizen = 1
	ShuffleIndex_Zombies = 1
	combineTb = Ragdollize_ShuffleTable(combineTb)
	citizenTb = Ragdollize_ShuffleTable(citizenTb)
	zombiesTb = Ragdollize_ShuffleTable(zombiesTb)
end)

--[[-------------------------------------------------------------------------
结束函数，用于停止当前播放的动画（NPC死亡时，Ragdoll坠落时）
---------------------------------------------------------------------------]]
function Ragdollize_EndAnimation(NRag)
	if not NRag or not IsValid(NRag) then return end

	NRag:SetNoDraw(false)
	NRag:SetSolid(SOLID_VPHYSICS)
	NRag.IsRagdollizedRagdoll2 = false
	NRag:SetNWBool("IsRagdollizedRagdoll2", false)
	Ragdollize_ClearOptimize(NRag)

	if GetConVar("BldOverlay_enable") then
		if GetConVar("BldOverlay_enable"):GetBool() then 
			net.Start("Bld_StartDrawOverlay_Kill")
			net.WriteEntity(NRag)
			net.Broadcast()
		end
	end

	for k, v in pairs(Ragdollize_Tb) do
		if v == NRag then
			table.remove(Ragdollize_Tb, k)
		end
	end

	if IsValid(NRag.ONPC) and IsValid(NRag) and NRag != NULL and NRag.ONPC != NULL then
		if (NRag.isReplacedZB and CVAR_Ragdollize_EnableHeadcrab:GetBool() and not ZombieClass_Fast[NRag.ONPC:GetClass()]) or ZombieClass_Poison[NRag.ONPC:GetClass()] then
			local NRag_headID = NRag:LookupBone("ValveBiped.Bip01_Head1") or NRag:LookupBone("ValveBiped.HC_Body_Bone") or NRag:LookupBone("ValveBiped.Headcrab_Cube1")
			if NRag:GetManipulateBoneScale(NRag_headID) == Vector(0.01, 0.01, 0.01) then
				NRag:ManipulateBoneScale(NRag_headID, Vector(1, 1, 1))
			end
			
			local mdl = ZombieClass_HeadcrabCheck[NRag.ONPC:GetClass()]
			local NRagPos = NRag:GetPos()
			local corpsePos = NRag:GetBonePosition(NRag_headID)
			timer.Simple(FrameTime()*2, function()
				HeadcrabCorpse_AllowCreation = true
	
				if HeadcrabCorpse_Pos then
					local pos1 = NRagPos
					local pos2 = HeadcrabCorpse_Pos
					local dx = math.abs(pos1.x-pos2.x)
					local dy = math.abs(pos1.y-pos2.y)
					if dx <= 25 and dy <= 25 then
						HeadcrabCorpse_AllowCreation = false
					end
				end
			
				if HeadcrabCorpse_AllowCreation then
					local HeadcrabCorpse = ents.Create("prop_ragdoll")
					HeadcrabCorpse:SetModel(mdl)
					HeadcrabCorpse:SetPos(corpsePos)
					HeadcrabCorpse:Spawn()
				end
			end)
	
			NRag.isReplacedZB = false
		end

		NRag.ONPC:SetHealth(0)
		NRag.ONPC:Remove()
		NRag.ONPC = nil
	end

	for i = 0, NRag:GetPhysicsObjectCount()-1 do
		local phyObj = NRag:GetPhysicsObjectNum(i)
		if phyObj then
			phyObj:SetVelocity(Vector(0, 0, 0))
			phyObj:SetAngleVelocity(Vector(0, 0, 0))
			phyObj:EnableCollisions(true)
			phyObj:EnableMotion(true)
			phyObj:Wake()
		end
	end

	for i=0, NRag:GetPhysicsObjectCount()-1 do
		if NRag:GetManipulateBoneScale(NRag:TranslatePhysBoneToBone(i)) == Vector(0, 0, 0) then
			local phyObj = NRag:GetPhysicsObjectNum(i)
			if phyObj then
				phyObj:EnableCollisions(false)
			end
		end
	end
	
end

function Ragdollize_GetDamagedBone(NRag, HitPos)
	local MinDist = nil
	NRag.ClosestHitPos = HitPos
	
	for i = 0, NRag:GetPhysicsObjectCount() - 1 do
		if NRag.ZippyGoreMod3_PhysBoneHPs && NRag.ZippyGoreMod3_PhysBoneHPs[i] == -1 then continue end

		local phyObj = NRag:GetPhysicsObjectNum(i)
		if IsValid(phyObj) then
			local boneName = NRag:GetBoneName(NRag:TranslatePhysBoneToBone(i))
			local Dist = phyObj:GetPos():DistToSqr(HitPos)
		
			if (!MinDist or Dist < MinDist) and Hitbox_Tb[boneName] and NRag:GetManipulateBoneScale(NRag:TranslatePhysBoneToBone(i)) != Vector(0, 0, 0) then
				MinDist = Dist
				NRag.ClosestBoneName = boneName
				NRag.ClosestPhyID = i
			end
		end
	end
end

function Ragdollize_SetNPCRun_RUN(Target)
	Target.ShouldCower = false
	Target:SetSchedule(SCHED_RUN_FROM_ENEMY)

	timer.Simple(2, function()
		if IsValid(Target.NRag) and IsValid(Target) then
			if math.Rand(0, 1) < 0.5 then
				Ragdollize_SetNPCRun_RUN(Target)
			else
				Ragdollize_SetNPCRun_FEAR(Target)
			end
		end
	end)
end

function Ragdollize_SetNPCRun_FEAR_1_loop(Target)
	if Target.ShouldCower and IsValid(Target) then
		Target:SetSchedule(SCHED_RUN_FROM_ENEMY)
		Target:PlayScene("scenes/Ragdollize_cower1_loop.vcd")
		timer.Simple(0.05, function()
			if IsValid(Target) then
				Ragdollize_SetNPCRun_FEAR_1_loop(Target)
			end
		end)
	end
end

function Ragdollize_SetNPCRun_FEAR_2_loop(Target)
	if Target.ShouldCower and IsValid(Target) then
		Target:SetSchedule(SCHED_RUN_FROM_ENEMY)
		Target:PlayScene("scenes/Ragdollize_cower2.vcd")
		timer.Simple(0.05, function()
			if IsValid(Target) then
				Ragdollize_SetNPCRun_FEAR_2_loop(Target)
			end
		end)
	end
end

function Ragdollize_SetNPCRun_FEAR_3_loop(Target)
	if Target.ShouldCower and IsValid(Target) then
		Target:SetSchedule(SCHED_RUN_FROM_ENEMY)
		Target:PlayScene("scenes/Ragdollize_cower3_loop.vcd")
		timer.Simple(0.05, function()
			if IsValid(Target) then
				Ragdollize_SetNPCRun_FEAR_3_loop(Target)
			end
		end)
	end
end

function Ragdollize_SetNPCRun_FEAR(Target)
	Target.ShouldCower = true

	if Target.NRag.FearSeq_Rand == "Seq_1" then
		if Target:GetSequenceName(Target:GetSequence()) != "cower_Idle" then
			Target:PlayScene("scenes/Ragdollize_cower1.vcd")
			timer.Simple(1, function()
				Ragdollize_SetNPCRun_FEAR_1_loop(Target)
			end)
		else
			Ragdollize_SetNPCRun_FEAR_1_loop(Target)
		end

	elseif Target.NRag.FearSeq_Rand == "Seq_2" then
		Ragdollize_SetNPCRun_FEAR_2_loop(Target)

	elseif Target.NRag.FearSeq_Rand == "Seq_3" then
		if Target:GetSequenceName(Target:GetSequence()) != "Fear_Reaction_Idle" then
			Target:PlayScene("scenes/Ragdollize_cower3.vcd")
			timer.Simple(1, function()
				Ragdollize_SetNPCRun_FEAR_3_loop(Target)
			end)
		else
			Ragdollize_SetNPCRun_FEAR_3_loop(Target)
		end
	else
		Target.ShouldCower = false
		Ragdollize_SetNPCRun_RUN(Target)
	end

	timer.Simple(math.Rand(3, 10), function()
		if IsValid(Target.NRag) and IsValid(Target) then
			Ragdollize_SetNPCRun_RUN(Target)
		end
	end)
end

function Ragdollize_StartCrawl(NRag, ONPC)
	NRag.Hp_d = ONPC:GetMaxHealth()*0.8
	local Hostile1 = {}
	local Hostile2 = {}
	local Hostile  = {}
	local Friends  = {}

	for _, other_npc in pairs(ents.GetAll()) do
		if other_npc:IsNPC() then
			local D = other_npc:Disposition(ONPC)
			local avoid_e = GetConVar("ARag_avoid_e")
			if (D == D_HT or D == D_FR) and avoid_e and avoid_e:GetBool() then
				table.insert(Hostile1, other_npc)
			elseif D == D_LI then
				table.insert(Friends, other_npc)
			else
				if other_npc:GetClass() == ONPC:GetClass() then
					table.insert(Friends, other_npc)
				end
			end
		elseif other_npc:IsPlayer() and ONPC:IsNPC() then
			local D = ONPC:Disposition(other_npc)
			local avoid_e = GetConVar("ARag_avoid_e")
			if (D == D_HT or D == D_FR) and avoid_e and avoid_e:GetBool() then
				table.insert(Hostile1, other_npc)
			elseif D == D_LI then
				table.insert(Friends, other_npc)
			else
				if other_npc:GetClass() == ONPC:GetClass() then
					table.insert(Friends, other_npc)
				end
			end
		end
	end

	local avoid_p = GetConVar("ARag_avoid_p")
	if avoid_p and avoid_p:GetBool() then
		for _, PLY in pairs(player.GetAll()) do
			table.insert(Hostile1, PLY)
		end
	end

	for _, v in pairs(Hostile1) do
		Hostile2[v] = true
	end

	for k, _ in pairs(Hostile2) do
		table.insert(Hostile, k)
	end
	
	NRag.arNPCHp   = ONPC:GetMaxHealth()
	NRag.arHostile = Hostile
	NRag.arFriends = Friends
	NRag.arSpClass = ONPC:GetClass()
	if ONPC:IsNPC() then
		if ONPC:GetWeapons() then
			ONPC.arWeapons = {}
			for k, wep in pairs(ONPC:GetWeapons()) do
				table.insert(ONPC.arWeapons, wep:GetClass())
			end
		end
	end
	NRag.arWeapons = ONPC.arWeapons

	AnimRag_Death_T_Crawl(NRag, true)
end

function Ragdollize_LimbGib(NRag, ONPC)
	local armsGibbed = 0
	local legsGibbed = 0
	local headGibbed = 0

	if NRag.nrMoveBone["ValveBiped.Bip01_R_Forearm"]["Gibbed"] and NRag.nrMoveBone["ValveBiped.Bip01_L_Forearm"]["Gibbed"] then
		armsGibbed = 2
	elseif NRag.nrMoveBone["ValveBiped.Bip01_R_Forearm"]["Gibbed"] or NRag.nrMoveBone["ValveBiped.Bip01_L_Forearm"]["Gibbed"] then
		armsGibbed = 1
	end

	if NRag.nrMoveBone["ValveBiped.Bip01_R_Thigh"]["Gibbed"] and NRag.nrMoveBone["ValveBiped.Bip01_L_Thigh"]["Gibbed"] then
		legsGibbed = 2
	elseif NRag.nrMoveBone["ValveBiped.Bip01_R_Thigh"]["Gibbed"] or NRag.nrMoveBone["ValveBiped.Bip01_L_Thigh"]["Gibbed"] then
		legsGibbed = 1
	end

	if NRag.nrMoveBone["ValveBiped.Bip01_Head1"]["Gibbed"] then
		headGibbed = 1
	end

	if armsGibbed == 2 and legsGibbed >= 1 and ZombieClass_Torso[ONPC:GetClass()] then
		NRag:SetNoDraw(false)
		ONPC:SetNoDraw(true)
		Ragdollize_ClearOptimize(NRag)
		Ragdollize_EndAnimation(NRag)
	return end

	if armsGibbed == 2 then
		ONPC.isTwoArmsGibbed = true
		if ZombieClass_Torso[ONPC:GetClass()] then
			ONPC:SetMoveVelocity(Vector(5, 5, 5))
		end

		local delay = math.Rand(0, 10)
		if headGibbed == 1 then delay = 0 end

		timer.Simple(delay, function()
			if IsValid(NRag) then
				Ragdollize_EndAnimation(NRag)
			end
		end)
	
	elseif armsGibbed == 1 then
		if ONPC:IsNPC() and not NRag.isReplacedZB then
			if not NRag.isRunning then
				NRag.isRunning = true
				local wep = ONPC:GetActiveWeapon()
				if wep != NULL and IsValid(wep) then
					wep:Remove()
				end
				
				NRag.ArmGibbed = true
				Ragdollize_SetNPCRun_RUN(ONPC)
				Ragdollize_ClearOptimize(NRag)
			end
		elseif ZombieClass_Torso[ONPC:GetClass()] then
			if ONPC:GetClass() == "npc_fastzombie_torso" then
				ONPC:SetMoveVelocity(Vector(30, 30, 30))
			else
				ONPC:SetMoveVelocity(Vector(15, 15, 15))
			end
		end
	end

	if legsGibbed == 2 then
		NRag:SetNoDraw(false)
		ONPC:SetNoDraw(true)
		Ragdollize_ClearOptimize(NRag)
		if IsEDAInstalled then 
			Ragdollize_StartCrawl(NRag, ONPC) 
		end
		Ragdollize_EndAnimation(NRag)
	elseif legsGibbed == 1 then
		if ZombieClass_Torso[ONPC:GetClass()] then return end 

		if NRag.isReplacedZB and ZombieModel_SwitchTorso[NRag.ONPC_Mdl] then
			Ragdollize_ZombieSwitchToTorso(NRag, armsGibbed, headGibbed)
		else
			NRag:SetNoDraw(false)
			ONPC:SetNoDraw(true)
			Ragdollize_ClearOptimize(NRag)
			if IsEDAInstalled then
				Ragdollize_StartCrawl(NRag, ONPC) 
			end
			Ragdollize_EndAnimation(NRag)
		end
	return end
end

function Ragdollize_ZombieSwitchToTorso(NRag, armsGibbed, headGibbed)
	local zombiePos = NRag.ONPC:GetPos()
	local zombieAng = NRag.ONPC:GetAngles()
	local zombieMdl = NRag.ONPC_Mdl

	NRag:SetNoDraw(false)
	NRag:SetSolid(SOLID_VPHYSICS)
	NRag.IsRagdollizedRagdoll2 = false
	NRag:SetNWBool("IsRagdollizedRagdoll2", false)
	Ragdollize_ClearOptimize(NRag)
	for k, v in pairs(Ragdollize_Tb) do
		if v == NRag then
			table.remove(Ragdollize_Tb, k)
		end
	end

	NRag.ONPC:Remove()
	NRag.ONPC = nil

	timer.Simple(math.Rand(2, 3), function()
		local body_index = NRag:LookupBone("ValveBiped.Bip01_Spine4") or NRag:LookupBone("ValveBiped.Bip01_Spine2") or NRag:LookupBone("ValveBiped.Bip01_Spine1") or NRag:LookupBone("ValveBiped.Bip01_Spine")
		
		if body_index then
			local body_ang = NRag:GetBoneMatrix(body_index):GetAngles():Forward():Angle()
			local body_pos = NRag:GetBoneMatrix(body_index):GetTranslation()
			zombieAng = Angle(0, body_ang.y, 0)
			zombiePos.x = body_pos.x
			zombiePos.y = body_pos.y
		else
			zombieAng = NRag:GetAngles()
		end

		local zombieTorso = ents.Create(ZombieModel_SwitchTorso[zombieMdl]["Class"])
		zombieTorso:SetModel(ZombieModel_SwitchTorso[zombieMdl]["Model"])
		zombieTorso:SetPos(zombiePos)
		zombieTorso:SetAngles(zombieAng)
		zombieTorso:Spawn()
		zombieTorso.NRag = NRag

		Ragdollize_CreatePreRagdoll(zombieTorso, true, nil, nil)
		Ragdollize_NPC(zombieTorso)
	end)

	armsGibbed = armsGibbed or 0
	headGibbed = headGibbed or 0
	if math.Rand(0, 1) > 0.5 or armsGibbed == 2 or headGibbed == 1 then
		timer.Simple(math.Rand(2, 10), function()
			if IsValid(NRag) then
				Ragdollize_EndAnimation(NRag)
			end
		end)
	end
end

function Ragdollize_CopyTable(ORag, NRag)
	if IsValid(ORag) then
		for k, v in pairs(ORag:GetTable()) do
			if type(v) == "table" then
				NRag[k] = {}
				Ragdollize_CopyTable(v, NRag[k])
			else
				NRag[k] = v
			end
		end
	end	
end

function Ragdollize_SwitchRagdoll(ONPC)
	if ( not ONPC.NRag.Opti_1 and not ONPC.NRag.Opti_2 ) or ONPC.NRag.isReplacedCC then
		Ragdollize_CopyTable(ONPC.ORag, ONPC.NRag)
		Ragdollize_ClearOptimize(ONPC.NRag)
		ONPC.ORag:Remove()
		return ONPC.NRag
	else
		ONPC.ORag:SetNoDraw(false)
		ONPC.NRag:Remove()
		return ONPC.ORag
	end
end

function Ragdollize_CheckLOS(NRag)
	local Target = NRag.ONPC or NRag

	NRag.ClosestPLY = player.GetAll()[1]
	NRag.DistToPLY = math.huge
	NRag.DistToPLY_Z = math.huge
	
	if player.GetCount() == 1 then
		NRag.DistToPLY = Target:GetPos():DistToSqr(NRag.ClosestPLY:GetPos())
		NRag.DistToPLY_Z = math.abs(Target:GetPos().z - NRag.ClosestPLY:GetPos().z)
	else
		for k, ply in pairs(player.GetAll()) do
			local DistToPLY = Target:GetPos():DistToSqr(ply:GetPos())
			local DistToPLY_Z = math.abs(Target:GetPos().z - ply:GetPos().z)

			if DistToPLY < NRag.DistToPLY then
				NRag.ClosestPLY = ply
				NRag.DistToPLY = DistToPLY
				NRag.DistToPLY_Z = DistToPLY_Z
			end
		end
	end

	NRag.VisibleToPLY = false
	local DirToPLY = (Target:GetPos() - NRag.ClosestPLY:EyePos()):GetNormalized()
	local PLYViewDir = NRag.ClosestPLY:GetAimVector()
	NRag.FovToPLY = DirToPLY:Dot(PLYViewDir)

	if NRag.FovToPLY > 0.25 then
		local coliBoxTb = {}
		local min, max = NRag:GetCollisionBounds()
		min = NRag:GetPos() + min
		max = NRag:GetPos() + max
		
		coliBoxTb = {
			Vector(min.x, min.y, min.z),
			Vector(min.x, min.y, max.z),
			Vector(min.x, max.y, min.z),
			Vector(min.x, max.y, max.z),
			Vector(max.x, min.y, min.z),
			Vector(max.x, min.y, max.z),
			Vector(max.x, max.y, min.z),
			Vector(max.x, max.y, max.z),
			Vector(min.x, min.y, (max.z+min.z)/2),
			Vector(min.x, max.y, (max.z+min.z)/2),
			Vector(max.x, min.y, (max.z+min.z)/2),
			Vector(max.x, max.y, (max.z+min.z)/2),
			Vector((max.x+min.x)/2, (max.y+min.y)/2, (max.z+min.z)/2),
		}
	
		for k, vertex in pairs(coliBoxTb) do
			local hit = not util.TraceLine({
				start = vertex,
				endpos = NRag.ClosestPLY:EyePos(),
				mask = MASK_SOLID,
				filter = {NRag, Target, NRag.ClosestPLY}
			}).HitWorld
	
			if hit then
				NRag.VisibleToPLY = true
				break
			end
		end
	end

	return NRag.VisibleToPLY
end

function Ragdollize_SortLoadingTb()
	local function CombinedScore(ent)
		local fixedFov = math.ease.InCubic(math.max(ent.FovToPLY, 0.01))
		return ent.DistToPLY / (fixedFov*fixedFov*fixedFov*fixedFov)
	end

	if not table.IsEmpty(Ragdollize_LoadingTb) then
		local frontTb = {}
		local backTb = {}
		local Ragdollize_LoadingTb_fix = {}

		for k, ONPC in pairs(Ragdollize_LoadingTb) do
			if ONPC.VisibleToPLY then
				table.insert(frontTb, ONPC)
			else
				table.insert(backTb, ONPC)
			end
		end

		table.sort(frontTb, function(a, b) return CombinedScore(a) < CombinedScore(b) end)

		for k, ONPC in ipairs(frontTb) do
			Ragdollize_LoadingTb_fix[k] = ONPC
		end
	
		for k, ONPC in ipairs(backTb) do
			Ragdollize_LoadingTb_fix[#frontTb + k] = ONPC
		end

		Ragdollize_LoadingTb = Ragdollize_LoadingTb_fix
	end

	for k, ONPC in pairs(Ragdollize_LoadingTb) do
		if not IsValid(ONPC) then
			table.remove(Ragdollize_LoadingTb, k)
		end
	end
end

function Ragdollize_CreateTimers()
	timer.Remove("Ragdollize_CheckReplaceableTimer")
	timer.Remove("Ragdollize_ReplaceTimer")
	timer.Remove("Ragdollize_CheckBugTimer")
	timer.Remove("Ragdollize_CheckBarnacleGrab")
	
	timer.Create("Ragdollize_CheckReplaceableTimer", 0.2, 0, function()
		for _, ent in pairs(ents.GetAll()) do
			if ent.WaitingForReplace then
				Ragdollize_CheckLOS(ent)
				if not CVAR_Ragdollize_SlowLoad:GetBool() and IsValid(ent) then
					local currentNRagNum = 0
					for k, rag in pairs(Ragdollize_Tb) do
						currentNRagNum = currentNRagNum + 1
					end
					if (ent.VisibleToPLY or ent.DistToPLY < 2500000) and (currentNRagNum < CVAR_Ragdollize_MaxNumber:GetInt()) then
						Ragdollize_NPC(ent)
					end
				end
			end
		end
		Ragdollize_SortLoadingTb()
	end)
	
	timer.Create("Ragdollize_ReplaceTimer", 0.2, 0, function()
		local firstNPC = Ragdollize_LoadingTb[1]
		if IsValid(firstNPC) then
			local currentNRagNum = 0
			for k, rag in pairs(Ragdollize_Tb) do
				currentNRagNum = currentNRagNum + 1
			end

			local tooManyNRags = currentNRagNum >= CVAR_Ragdollize_MaxNumber:GetInt()
			local tooClose = firstNPC.VisibleToPLY or (firstNPC.DistToPLY < 40000 and firstNPC.DistToPLY_Z < 100)

			if not CVAR_Ragdollize_ReduceNPCNumber:GetBool() then
				if (not tooManyNRags) or tooClose then
					table.remove(Ragdollize_LoadingTb, 1)
					Ragdollize_NPC(firstNPC)
				end
			else
				if tooManyNRags and tooClose then
					table.remove(Ragdollize_LoadingTb, 1)
					firstNPC:Remove()
				elseif (not tooManyNRags) then
					table.remove(Ragdollize_LoadingTb, 1)
					Ragdollize_NPC(firstNPC)
				end
			end
		else
			table.remove(Ragdollize_LoadingTb, 1)
		end
	end)

	timer.Create("Ragdollize_CheckBugTimer", 2, 0, function()
		for _, ent in pairs(ents.GetAll()) do
			if ent and IsValid(ent) and ent:GetClass() != "entity_blocker" then
				if ent:IsNPC() then
					if not IsValid(ent.NRag) and ent:GetNWBool("IsRagdollizedONPC") then
						ent.NRag = nil
						ent:SetNWBool("IsRagdollizedONPC", false)
						Ragdollize_ReplaceNPC(ent)
					end
					if IsValid(ent.NRag) and not IsValid(ent.NRag.ONPC) then
						ent:Remove()
						ent.NRag:Remove()
					end
				elseif ent:IsRagdoll() then
					if (ent.ONPC and ent.ONPC:EntIndex() == 0) or (ent.IsRagdollizedRagdoll2 and not ent.ONPC) then
						Ragdollize_EndAnimation(ent)
					end
				end
			end
		end
	end)

	timer.Create("Ragdollize_CheckBarnacleGrab", 1, 0, function()
		for _, barnacle in ipairs(ents.FindByClass("npc_barnacle")) do
			if not IsValid(barnacle) then return end
			local victim = barnacle:GetEnemy()
			
			if victim and not barnacle.BarnacleGrabbed then
				barnacle.BarnacleGrabbed = true
				if victim.IsRagdollizedRagdoll2 and victim.ONPC then
					for k, rag in pairs(Ragdollize_Tb) do
						if rag == victim then
							table.remove(Ragdollize_Tb, k)
						end
					end
					victim.ONPC:Remove()
				end
			elseif not victim and barnacle.BarnacleGrabbed then
				barnacle.BarnacleGrabbed = false
			end
		end
	end)
end

timer.Simple(5, function() Ragdollize_CreateTimers() mapInitizeFinish = true end)
timer.Simple(10, function() Ragdollize_CreateTimers() mapInitizeFinish = true end)
timer.Simple(20, function() Ragdollize_CreateTimers() mapInitizeFinish = true end)

function Ragdollize_DistOptimize(NRag)
	if CVAR_Ragdollize_NoOpti:GetBool() then return end
	if not IsValid(NRag) or not IsValid(NRag.ONPC) then return end
	local ONPC = NRag.ONPC

	Ragdollize_CheckLOS(NRag)

	if NRag.VisibleToPLY then
		if NRag.DistToPLY <= 2500000 then
			NRag.Should_Opti_1 = false
			NRag.Should_Opti_2 = false
		else
			NRag.Should_Opti_1 = true
			NRag.Should_Opti_2 = false
		end
	else
		if NRag.DistToPLY <= 2500000 then
			NRag.Should_Opti_1 = true
			NRag.Should_Opti_2 = false
		else
			NRag.Should_Opti_1 = true
			NRag.Should_Opti_2 = true
		end	
	end

	if NRag.Should_Opti_1 and not NRag.Opti_1_StartTracking then
		NRag.Opti_1_StartTracking = true
		NRag.Opti_1_StartTime = CurTime()
	elseif not NRag.Should_Opti_1 and NRag.Opti_1_StartTracking then
		NRag.Opti_1_StartTracking = false
		NRag.Opti_1 = false
	elseif NRag.Should_Opti_1 and NRag.Opti_1_StartTracking and CurTime()-NRag.Opti_1_StartTime >= 2 then
		NRag.Opti_1_StartTracking = false
		NRag.Opti_1 = true
	end

	if NRag.Should_Opti_2 and not NRag.Opti_2_StartTracking then
		NRag.Opti_2_StartTracking = true
		NRag.Opti_2_StartTime = CurTime()
	elseif not NRag.Should_Opti_2 and NRag.Opti_2_StartTracking then
		NRag.Opti_2_StartTracking = false
		NRag.Opti_2 = false
	elseif NRag.Should_Opti_2 and NRag.Opti_2_StartTracking and CurTime()-NRag.Opti_2_StartTime >= 2 then
		NRag.Opti_2_StartTracking = false
		NRag.Opti_2 = true
	end

	if NRag.Opti_1 and not NRag.Opti_1_Enabled then
		NRag.Opti_1_Enabled = true
		for i=0, NRag:GetPhysicsObjectCount()-1 do
			local phyObj = NRag:GetPhysicsObjectNum(i)
			if phyObj then
				phyObj:EnableMotion(false)
				phyObj:Sleep()
			end
		end
	end

	if not NRag.Opti_1 and NRag.Opti_1_Enabled then
		NRag.Opti_1_Enabled = false
		NRag:SetPos(ONPC:GetPos())
		for i=0, NRag:GetPhysicsObjectCount()-1 do
			local phyObj = NRag:GetPhysicsObjectNum(i)
			if phyObj then
				phyObj:EnableMotion(true)
				phyObj:Wake()
			end
		end
	end

	if NRag.Opti_2 and not NRag.Opti_2_Enabled then
		NRag.Opti_2_Enabled = true
		NRag:SetNoDraw(true)
		NRag:SetSolid(SOLID_NONE)
		ONPC:SetNoDraw(false)
		ONPC:SetSolid(ONPC.Orgn_Solid)
	end

	if not NRag.Opti_2 and NRag.Opti_2_Enabled then
		NRag.Opti_2_Enabled = false
		NRag.PhysObj:SetPos(ONPC:GetBonePosition(ONPC:LookupBone("ValveBiped.Bip01_Pelvis") or 0))
		if IsValid(NRag) and IsValid(ONPC) then
			NRag:SetNoDraw(false)
			ONPC:SetNoDraw(true)

			if NRag.AltDmg then
				ONPC:SetSolid(SOLID_NONE)
				NRag:SetSolid(SOLID_VPHYSICS)
			else
				ONPC:SetSolid(ONPC.Orgn_Solid)
				NRag:SetSolid(SOLID_NONE)
			end

			local pos, ang = ONPC:GetBonePosition(ONPC:LookupBone("ValveBiped.Bip01_Pelvis") or 0)
			NRag.PhysObj:SetPos(pos)
			NRag.PhysObj:SetAngles(ang)
			NRag.PhysObj:SetVelocity(Vector(0, 0, 0))
			NRag.PhysObj:Wake()
			
			for i=0, NRag:GetPhysicsObjectCount()-1 do
				local phyObj = NRag:GetPhysicsObjectNum(i)
				if phyObj then
					phyObj:SetPos(pos + VectorRand() * 2)
					phyObj:SetVelocity(Vector(0, 0, 0))
					phyObj:EnableMotion(true)
					phyObj:Wake()
				end
			end
		end
	end
end

function Ragdollize_ClearOptimize(NRag)
	NRag.Opti_1 = false
	NRag.Opti_2 = false
	NRag.DisableOpti = true
	NRag:SetNoDraw(false)
	NRag:SetSolid(SOLID_VPHYSICS)
	if NRag.ONPC and NRag.ONPC:EntIndex() != 0 and IsValid(NRag.PhysObj) then
		NRag.PhysObj:SetPos(NRag.ONPC:GetPos())
	end

	for i=0, NRag:GetPhysicsObjectCount()-1 do
		local phyObj = NRag:GetPhysicsObjectNum(i)
		if phyObj then
			phyObj:EnableMotion(true)
			phyObj:Wake()
		end
	end
end

function Ragdollize_ReplaceMapCorpse(Orgn_Rag, NPCType)
	local Orgn_pos = Orgn_Rag:GetPos()
	local Orgn_ang = Orgn_Rag:GetAngles()
	local Orgn_collision = Orgn_Rag:GetCollisionGroup()
	local Orgn_Rag_Bone = {}
	for i = 0, Orgn_Rag:GetPhysicsObjectCount() - 1 do
		local phyObj = Orgn_Rag:GetPhysicsObjectNum(i)
		if phyObj then
			local boneID = Orgn_Rag:TranslatePhysBoneToBone(i)
			local boneName = Orgn_Rag:GetBoneName(boneID)
			Orgn_Rag_Bone[boneName] = {}
			Orgn_Rag_Bone[boneName]["pos"] = phyObj:GetPos()
			Orgn_Rag_Bone[boneName]["ang"] = phyObj:GetAngles()
		end
	end
	Orgn_Rag:Remove()

	local id, mdl, bodygroup = nil
	if NPCType == "combine" then
		id = math.random(1, table.Count(combineTb))
		mdl = combineTb[id].Model
		bodygroup = combineTb[id].validBodygroups
	elseif NPCType == "citizen" then
		id = math.random(1, table.Count(citizenTb))
		mdl = citizenTb[math.random(1, table.Count(citizenTb))].Model
		bodygroup = citizenTb[id].validBodygroups
	elseif NPCType == "zombies" then
		id = math.random(1, table.Count(zombiesTb))
		mdl = zombiesTb[math.random(1, table.Count(zombiesTb))].Model
		bodygroup = zombiesTb[id].validBodygroups
	end

	local New_Rag = ents.Create("prop_ragdoll")
	New_Rag:SetModel(mdl)
	New_Rag:SetPos(Orgn_pos)
	New_Rag:SetAngles(Orgn_ang)
	New_Rag:SetCollisionGroup(Orgn_collision)
	New_Rag:Spawn()
	for bgName, bgValue in pairs(bodygroup) do
		New_Rag:SetBodygroup(New_Rag:FindBodygroupByName(bgName), bgValue)
	end
	
	for boneName, v in pairs(Orgn_Rag_Bone) do
		local boneID = New_Rag:LookupBone(boneName)
		if boneID then
			local phyID = New_Rag:TranslateBoneToPhysBone(boneID)
			local phyObj = New_Rag:GetPhysicsObjectNum(phyID)
			if phyObj then
				phyObj:SetPos(v["pos"])
				phyObj:SetAngles(v["ang"])
				phyObj:EnableMotion(false)
			end
		end
	end
	
	timer.Simple(0.5, function()
		if not New_Rag then return end
		if not IsValid(New_Rag) or not New_Rag:IsSolid() then return end
		for i = 0, New_Rag:GetPhysicsObjectCount() - 1 do
			local phyObj = New_Rag:GetPhysicsObjectNum(i)
			if phyObj then
				local OrgnDamp1, OrgnDamp2 = phyObj:GetDamping()
				phyObj:SetDamping(100, 100)
				phyObj:EnableMotion(true)
				timer.Simple(0.5, function()
					phyObj:SetDamping(OrgnDamp1, OrgnDamp2)
				end)
			end
		end
	end)
end

function Ragdollize_ScaleNPC(ONPC, NRag, NPCType)
	if not CVAR_Ragdollize_ScaleModel:GetBool() then return end

	local ONPC_Height, NRag_Height = nil
	if ONPC:LookupAttachment('eyes') > 0 and NRag:LookupAttachment('eyes') > 0 then
		if NPCHeight[NPCType] then
			ONPC_Height = NPCHeight[NPCType]
		elseif ONPC:LookupBone("ValveBiped.Bip01_L_Foot") then
			local host_eyes_height = ONPC:GetAttachment(ONPC:LookupAttachment('eyes')).Pos.z
			local host_pelv_height = ONPC:GetBonePosition(ONPC:LookupBone("ValveBiped.Bip01_L_Foot")).z
			ONPC_Height = math.abs(host_eyes_height-host_pelv_height)
		end
		
		if NRag:LookupBone("ValveBiped.Bip01_L_Foot") then
			local rag_eyes_height = NRag:GetAttachment(NRag:LookupAttachment('eyes')).Pos.z
			local rag_pelv_origin = NRag:GetBonePosition(NRag:LookupBone("ValveBiped.Bip01_L_Foot")).z
			NRag_Height = math.abs(rag_eyes_height-rag_pelv_origin) + 5
		end
	else
		if NPCHeight[NPCType] then
			ONPC_Height = NPCHeight[NPCType]
		elseif ONPC:LookupBone("ValveBiped.Bip01_L_Foot") then
			local headID = ONPC:LookupBone("ValveBiped.Bip01_Head1") or ONPC:LookupBone("ValveBiped.HC_Body_Bone") or ONPC:LookupBone("ValveBiped.Headcrab_Cube1") or ONPC:LookupBone("ValveBiped.Bip01_Spine1") or ONPC:LookupBone("ValveBiped.Bip01_Spine2")
			local host_eyes_height = ONPC:GetBonePosition(headID).z
			local host_pelv_height = ONPC:GetBonePosition(ONPC:LookupBone("ValveBiped.Bip01_L_Foot")).z
			ONPC_Height = math.abs(host_eyes_height-host_pelv_height)
		end

		if NRag:LookupBone("ValveBiped.Bip01_L_Foot") then
			local headID = NRag:LookupBone("ValveBiped.Bip01_Head1") or NRag:LookupBone("ValveBiped.HC_Body_Bone") or NRag:LookupBone("ValveBiped.Headcrab_Cube1") or NRag:LookupBone("ValveBiped.Bip01_Spine1") or NRag:LookupBone("ValveBiped.Bip01_Spine2")
			local rag_eyes_height = NRag:GetBonePosition(headID).z
			local rag_pelv_origin = NRag:GetBonePosition(NRag:LookupBone("ValveBiped.Bip01_L_Foot")).z
			NRag_Height = math.abs(rag_eyes_height-rag_pelv_origin)
		end
	end	
	
	if ONPC_Height and NRag_Height then
		ONPC:SetModelScale(NRag_Height/ONPC_Height, 0)
	end
end

local spawnNRagInitially = false
function Ragdollize_CreatePreRagdoll(ONPC, isReplacedCC, mdl, bodygroup)
	local Npcs_Rag

	if IsValid(ONPC.NRag) then
		Npcs_Rag = ONPC.NRag
	else
		Npcs_Rag = ents.Create("prop_ragdoll")
		Npcs_Rag:SetModel(mdl)
		Npcs_Rag:SetPos(ONPC:GetPos())
		Npcs_Rag:SetAngles(ONPC:GetAngles())

		if not isReplacedCC then
			Npcs_Rag:SetSkin(ONPC:GetSkin())
			Npcs_Rag.StoredValidBodygroups = {}
			for i = 0, ONPC:GetNumBodyGroups()-1 do
				local bgName = ONPC:GetBodygroupName(i)
				Npcs_Rag.StoredValidBodygroups[bgName] = ONPC:GetBodygroup(i)
			end
		elseif isReplacedCC and bodygroup then
			Npcs_Rag.StoredValidBodygroups = bodygroup
		end
	end

	if IsValid(ONPC) and IsValid(Npcs_Rag) then
		for i=0, ONPC:GetFlexNum()-1 do
			ONPC:SetFlexWeight(i, 0)
		end
		for i=0, Npcs_Rag:GetFlexNum()-1 do
			Npcs_Rag:SetFlexWeight(i, 0)
		end
	end

	Npcs_Rag.ONPC = ONPC
	Npcs_Rag.ONPC_Mdl = ONPC:GetModel()
	Npcs_Rag.Hp_n = ONPC:GetMaxHealth()
	Npcs_Rag.IsRagdollizedRagdoll = true
	Npcs_Rag.IsRagdollizedRagdoll2 = true
	Npcs_Rag:SetNWBool("IsRagdollizedRagdoll2", true)
	Npcs_Rag.nrMoveTb = NrmTb
	Npcs_Rag.nrMoveBone = {}
	for boneName, _ in pairs(Npcs_Rag.nrMoveTb) do
		Npcs_Rag.nrMoveBone[boneName] = {}
		Npcs_Rag.nrMoveBone[boneName]["HitWall"] = false
		Npcs_Rag.nrMoveBone[boneName]["Gibbed"] = false
		Npcs_Rag.nrMoveBone[boneName]["ShouldMove"] = true
	end
	Npcs_Rag.nrHitWall = 0
	Npcs_Rag.DistToPLY = math.huge
	Npcs_Rag.Next = CurTime()
	Npcs_Rag.NextOpti = CurTime()
	Npcs_Rag.Opti_1 = false
	Npcs_Rag.Opti_1_Enabled = false
	Npcs_Rag.Opti_2 = false
	Npcs_Rag.Opti_2_Enabled = false
	Npcs_Rag.FearType = math.random(1, 3)
	Npcs_Rag.FearSeq = {}
	Npcs_Rag.FearSeq["Seq_1"] = ONPC:LookupSequence("cower_Idle")
	Npcs_Rag.FearSeq["Seq_2"] = ONPC:LookupSequence("crouch_panicked")
	Npcs_Rag.FearSeq["Seq_3"] = ONPC:LookupSequence("Fear_Reaction_Idle")
	Npcs_Rag.FearSeq_Available = {}
	for k, v in pairs(Npcs_Rag.FearSeq) do
		if v and v > 0 then
			table.insert(Npcs_Rag.FearSeq_Available, k)
		end
	end
	if #Npcs_Rag.FearSeq_Available > 0 then
		Npcs_Rag.FearSeq_Rand = Npcs_Rag.FearSeq_Available[math.random(#Npcs_Rag.FearSeq_Available)]
	else
		Npcs_Rag.FearSeq_Rand = nil
	end
	if ONPC:LookupAttachment('eyes') > 0 then
		local eye_height = ONPC:GetAttachment(ONPC:LookupAttachment('eyes')).Pos.z
		local npc_origin = ONPC:GetPos().z
		Npcs_Rag.BodyHeight = math.abs(eye_height-npc_origin)
	end

	if spawnNRagInitially then
		Npcs_Rag:Spawn()
		Npcs_Rag.PhysObj = Npcs_Rag:GetPhysicsObject()
		Npcs_Rag.PhysObj:SetPos(ONPC:GetBonePosition(ONPC:LookupBone("ValveBiped.Bip01_Pelvis") or 0))
		
		Npcs_Rag:SetNoDraw(true)
		Npcs_Rag:SetSolid(SOLID_NONE)
		for i=0, Npcs_Rag:GetPhysicsObjectCount()-1 do
			local phyObj = Npcs_Rag:GetPhysicsObjectNum(i)
			if phyObj then
				phyObj:EnableMotion(false)
				phyObj:Sleep()
			end
		end

		Npcs_Rag.UpdatePosTimerName = "Ragdollize_UpdatePosTimer_" .. CurTime() .. Npcs_Rag:EntIndex()
		timer.Create(Npcs_Rag.UpdatePosTimerName, 0.2, 0, function()
			if IsValid(Npcs_Rag.PhysObj) then
				Npcs_Rag.PhysObj:SetPos(ONPC:GetBonePosition(ONPC:LookupBone("ValveBiped.Bip01_Pelvis") or 0))
			end
		end)
	end

	ONPC.PreNRag = Npcs_Rag

	return Npcs_Rag
end

function Ragdollize_NPC(ONPC)
	if not IsValid(ONPC.PreNRag) then return end

	local Npcs_Rag = ONPC.PreNRag
	ONPC.PreNRag = nil

	if spawnNRagInitially or IsValid(ONPC.NRag) then
		if Npcs_Rag.UpdatePosTimerName then
			timer.Remove(Npcs_Rag.UpdatePosTimerName)
		end

		local pos, ang = ONPC:GetBonePosition(ONPC:LookupBone("ValveBiped.Bip01_Pelvis") or 0)
		Npcs_Rag.PhysObj:SetPos(pos)
		Npcs_Rag.PhysObj:SetAngles(ang)
		Npcs_Rag.PhysObj:SetVelocity(Vector(0, 0, 0))
		Npcs_Rag.PhysObj:Wake()
		
		for i=0, Npcs_Rag:GetPhysicsObjectCount()-1 do
			local phyObj = Npcs_Rag:GetPhysicsObjectNum(i)
			if phyObj then
				phyObj:SetPos(pos + VectorRand() * 2)
				phyObj:SetVelocity(Vector(0, 0, 0))
				phyObj:EnableMotion(true)
				phyObj:Wake()
			end
		end
	else
		Npcs_Rag:SetPos(ONPC:GetPos())
		Npcs_Rag:SetAngles(ONPC:GetAngles())
		
		if ZombieClass_Torso[ONPC:GetClass()] then
			local ang = ONPC:GetAngles()
			ang:RotateAroundAxis(ang:Right(), -90)
			Npcs_Rag:SetPos(ONPC:GetPos() + Vector(0, 0, 20))
			Npcs_Rag:SetAngles(ang)
		end

		Npcs_Rag:Spawn()

		if Npcs_Rag.ZippyGoreMod3_BecomeGibbableRagdoll then
			Npcs_Rag:ZippyGoreMod3_BecomeGibbableRagdoll( false )
		end
	end

	Npcs_Rag:SetNoDraw(false)
	if not ONPC.DrawZombieHead then
		ONPC:SetNoDraw(true)
	end

	ONPC.NRag = Npcs_Rag
	ONPC.Orgn_Solid = ONPC:GetSolid()
	ONPC:SetNWBool("IsRagdollizedONPC", true)
	ONPC.WaitingForReplace = false
	
	if CVAR_Ragdollize_AltDmg:GetBool() then
		Npcs_Rag.AltDmg = true
	else
		if Npcs_Rag.isReplacedZB and CVAR_Ragdollize_EnableHeadcrab:GetBool() then
			Npcs_Rag.AltDmg = true
		end
	end

	if Npcs_Rag.AltDmg then
		ONPC:SetSolid(SOLID_NONE)
		Npcs_Rag:SetSolid(SOLID_VPHYSICS)
	else
		ONPC:SetSolid(ONPC.Orgn_Solid)
		Npcs_Rag:SetSolid(SOLID_NONE)
	end

	Npcs_Rag.PhysObj = Npcs_Rag:GetPhysicsObject()
	Npcs_Rag.Bone_n_phyObj = {}
	for i=0, Npcs_Rag:GetPhysicsObjectCount()-1 do
		local boneName = Npcs_Rag:GetBoneName(Npcs_Rag:TranslatePhysBoneToBone(i))
		local phyObj = Npcs_Rag:GetPhysicsObjectNum(i)
		Npcs_Rag.Bone_n_phyObj[i] = {}
		Npcs_Rag.Bone_n_phyObj[i]["boneName"] = boneName
		Npcs_Rag.Bone_n_phyObj[i]["phyObj"] = phyObj
	end

	if Npcs_Rag.StoredValidBodygroups then
		for bgName, bgValue in pairs(Npcs_Rag.StoredValidBodygroups) do
			Npcs_Rag:SetBodygroup(Npcs_Rag:FindBodygroupByName(bgName), bgValue)
		end
	end

	if ONPC.RagdollizeType == "combine" then
		if PoliceModel[ONPC:GetModel()] then
			Ragdollize_ScaleNPC(ONPC, Npcs_Rag, "police")
		else
			Ragdollize_ScaleNPC(ONPC, Npcs_Rag, "combine")
		end
	elseif ONPC.RagdollizeType == "citizen" then
		if string.match(ONPC:GetModel(), "female") then
			Ragdollize_ScaleNPC(ONPC, Npcs_Rag, "citizen_female")
		else
			Ragdollize_ScaleNPC(ONPC, Npcs_Rag, "citizen_male")
		end
	elseif ONPC.RagdollizeType == "zombies" and not ZombieClass_Torso[ONPC:GetClass()] then
		Ragdollize_ScaleNPC(ONPC, Npcs_Rag, "zombies")
	end

	timer.Simple(1, function()
		if not Npcs_Rag.Opti_2 and not Npcs_Rag.isReplacedZB then
			if IsValid(ONPC) then
				ONPC:SetNoDraw(true)
			end
		end
	end)
	
	for _, boneName in pairs(ColiTb2) do
		local boneID = Npcs_Rag:LookupBone(boneName)
		if boneID then
			local phyid = Npcs_Rag:TranslateBoneToPhysBone(boneID)
			local phyObj = Npcs_Rag:GetPhysicsObjectNum(phyid)
			if phyObj then
				phyObj:EnableCollisions(false)
			end
		end
	end

	if CVAR_Ragdollize_NoCollideAll:GetBool() then
		Npcs_Rag:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	elseif CVAR_Ragdollize_NoCollidePly:GetBool() then
		Npcs_Rag:SetCollisionGroup(COLLISION_GROUP_NPC_ACTOR)
	end
	
	Npcs_Rag.CollisionEnt_NRag = ONPC
	ONPC.CollisionEnt_NRag = Npcs_Rag
	Npcs_Rag:SetCustomCollisionCheck(true)
	ONPC:SetCustomCollisionCheck(true)
	
	table.insert(Ragdollize_Tb, Npcs_Rag)

	return Npcs_Rag
end

function Ragdollize_GetRagdollizeType(ent)
	ent.RagdollizeType = nil
	if CVAR_Ragdollize_ReplaceCombine:GetBool() and CombineModel[ent:GetModel()] and combineTb and table.Count(combineTb) != 0 then
		ent.RagdollizeType = "combine"
	elseif CVAR_Ragdollize_ReplaceCitizen:GetBool() and string.match(ent:GetModel(), "models/humans/group") and citizenTb and table.Count(citizenTb) != 0 then
		ent.RagdollizeType = "citizen"
	elseif CVAR_Ragdollize_ReplaceZombies:GetBool() and ZombieClass[ent:GetClass()] and zombiesTb and table.Count(zombiesTb) != 0 then
		ent.RagdollizeType = "zombies"
	elseif CVAR_Ragdollize_Enable:GetBool() and not ZombieClass[ent:GetClass()] then
		ent.RagdollizeType = "npc"
	else
		ent.RagdollizeType = nil
	end
end

function Ragdollize_ReplaceNPC(ent)
	if not IsValid(ent) or not ent:GetModel() then return end
	
	Ragdollize_GetRagdollizeType(ent)
	if not ent.RagdollizeType then return end

	if ent.RagdollizeType == "combine" then

		local id = ShuffleIndex_Combine
		if not combineTb[ShuffleIndex_Combine] then
			id = math.random(1, #combineTb)
		end

		local mdl = combineTb[id].Model
		local bodygroup = combineTb[id].validBodygroups
		local NRag = Ragdollize_CreatePreRagdoll(ent, true, mdl, bodygroup)
		NRag.isReplacedCC = true

		ShuffleIndex_Combine = ShuffleIndex_Combine + 1
		if ShuffleIndex_Combine > #combineTb then
			ShuffleIndex_Combine = 1
		end

	elseif ent.RagdollizeType == "citizen" then
		
		local id = ShuffleIndex_Citizen
		if not citizenTb[ShuffleIndex_Citizen] then
			id = math.random(1, #citizenTb)
		end

		local mdl = citizenTb[id].Model
		local bodygroup = citizenTb[id].validBodygroups
		local NRag = Ragdollize_CreatePreRagdoll(ent, true, mdl, bodygroup)
		NRag.isReplacedCC = true
		
		ShuffleIndex_Citizen = ShuffleIndex_Citizen + 1
		if ShuffleIndex_Citizen > #citizenTb then
			ShuffleIndex_Citizen = 1
		end

	elseif ent.RagdollizeType == "zombies" then
		
		local id = ShuffleIndex_Zombies
		if not zombiesTb[ShuffleIndex_Zombies] then
			id = math.random(1, #zombiesTb)
		end

		local mdl = zombiesTb[id].Model
		local bodygroup = zombiesTb[id].validBodygroups
		local NRag = Ragdollize_CreatePreRagdoll(ent, true, mdl, bodygroup)
		NRag.isReplacedCC = true
		NRag.isReplacedZB = true
		NRag.ZBHeadshot_EndAnimationChance = math.Rand(0, 1)
		NRag.DisableOpti = true
		NRag:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

		ShuffleIndex_Zombies = ShuffleIndex_Zombies + 1
		if ShuffleIndex_Zombies > #zombiesTb then
			ShuffleIndex_Zombies = 1
		end

		if (CVAR_Ragdollize_EnableHeadcrab:GetBool() and not ZombieClass_Fast[ent:GetClass()]) or ZombieClass_Poison[ent:GetClass()] then
			
			ent.DrawZombieHead = true 

			if ZombieClass_Normal[ent:GetClass()] then
				for i=0, ent:GetBoneCount()-1 do
					local boneName = ent:GetBoneName(i)
					if not string.find(boneName, "ValveBiped.HC") then
						ent:ManipulateBoneScale(i, Vector(0.01, 0.01, 0.01))
					end
				end

			else
				for i=0, ent:GetBoneCount()-1 do
					local boneName = ent:GetBoneName(i)
					if not (string.find(boneName, "ValveBiped.bone") or string.find(boneName, "ValveBiped.Headcrab") or string.find(boneName, "ValveBiped.Bip01_Spine")) then
						ent:ManipulateBoneScale(i, Vector(0.01, 0.01, 0.01))
					end
				end						
			end
			
			local NRag_headID = NRag:LookupBone("ValveBiped.Bip01_Head1") or NRag:LookupBone("ValveBiped.HC_Body_Bone") or NRag:LookupBone("ValveBiped.Headcrab_Cube1")
			if NRag_headID then
				NRag:ManipulateBoneScale(NRag_headID, Vector(0.01, 0.01, 0.01))
			end
		end

	elseif ent.RagdollizeType == "npc" then
		Ragdollize_CreatePreRagdoll(ent, false, ent:GetModel(), nil)
	end

	ent.WaitingForReplace = true
	table.insert(Ragdollize_LoadingTb, ent)
end


local mapInitizeFinish = false
hook.Add("PlayerInitialSpawn", "Ragdollize_PlayerSpawn", function()
	timer.Simple(2, function()
		mapInitizeFinish = true
		Ragdollize_LastLoadingTime = CurTime() + 4
		Ragdollize_CreateTimers()

		if hook.GetTable()["EntityTakeDamage"]["Animrag_Damage_D"] then
			IsEDAInstalled = true
		end
	end)
end)

hook.Add("OnEntityCreated", "Ragdollize_OnEntityCreated", function(ent)
	timer.Simple(FrameTime(), function()

		if not ent then return end
		if not IsValid(ent) or not ent:IsSolid() or ent:GetClass() == "entity_blocker" or not ent:IsNPC() then return end

		if ZombieClass_Headcrab[ent:GetClass()] and not CVAR_Ragdollize_EnableHeadcrab:GetBool() and ent:GetClass() != "npc_headcrab_poison" then
			
			if ent:GetOwner() != NULL and ZombieClass[ent:GetOwner():GetClass()] then
				HeadcrabAlive_AllowCreation = false
			end

			for _, rag in ipairs(ents.FindInSphere(ent:GetPos(), 10)) do
				if rag.ONPC_Mdl and ZombieModel[string.lower(rag.ONPC_Mdl)] then
					HeadcrabAlive_AllowCreation = false
					break
				end
			end

			if not HeadcrabAlive_AllowCreation then
				ent:Remove()
				timer.Simple(FrameTime()*4, function()
					HeadcrabAlive_AllowCreation = true
				end)
			end

		elseif ZombieClass_Headcrab[ent:GetClass()] and CVAR_Ragdollize_EnableHeadcrab:GetBool() then
			HeadcrabCorpse_Pos = ent:GetPos()
			timer.Simple(FrameTime()*4, function()
				HeadcrabCorpse_Pos = nil
			end)
		return end

		if (ent:LookupBone("ValveBiped.Bip01_Pelvis") or ZombieClass[ent:GetClass()]) and not ent.NRag then
			Ragdollize_ReplaceNPC(ent)
		end
	end)
end)

hook.Add("CreateEntityRagdoll", "Ragdollize_CreateEntityRagdoll", function(ONPC, Orgn_Rag)
	if IsValid(ONPC.NRag) and not IsEDAInstalled then
		Orgn_Rag:Remove()
	end
end)

hook.Add("Tick", "Ragdollize_MainTick", function()
	if table.IsEmpty(Ragdollize_Tb) then return end

	for k, NRag in pairs(Ragdollize_Tb) do
		if IsValid(NRag) and IsValid(NRag.ONPC) and NRag.ONPC != NULL then

			local Target = NRag.ONPC
			if player.GetAll()[1] then
				local visible = Target:Visible(player.GetAll()[1])
			end

			if CurTime() >= NRag.NextOpti and NRag.IsRagdollizedRagdoll2 then
				Ragdollize_DistOptimize(NRag)
				NRag.NextOpti = CurTime() + 0.1

				if CVAR_Ragdollize_FingerPose:GetBool() then
					net.Start("Ragdollize_PoseFingerBone_sTc")
						net.WriteInt(NRag:EntIndex(), 32)
						net.WriteInt(NRag.ONPC:EntIndex(), 32)
					net.Broadcast()
				end

				if NRag.ONPC:WaterLevel() >= 3 then
					Ragdollize_EndAnimation(NRag)
				return end
			end

			if CurTime() >= NRag.Next then 
				
				if NRag.Opti_1 then
					NRag.Next = CurTime() + 0.1
				end

				if not NRag:GetNoDraw() and not Target:GetNoDraw() then
					if (not NRag.isReplacedZB) or ZombieClass_Fast[Target:GetClass()] or (NRag.isReplacedZB and not ZombieClass_Poison[Target:GetClass()] and not CVAR_Ragdollize_EnableHeadcrab:GetBool()) then
						Target:SetNoDraw(true)
					end
				end

				if NRag.ONPC.kmModel then
					NRag.ONPC.kmModel:SetNoDraw(true)
					if Target:IsNPC() then 
						local wep = Target:GetActiveWeapon()
						if wep != NULL then
							wep:Remove()
						end
					end
					Target = NRag.ONPC.kmModel
				end
		
				if NRag.nrHitWall >= table.Count(NRag.nrMoveTb) then 
					Ragdollize_EndAnimation(NRag)
				end

				if NRag.ArmGibbed and Target:GetSequence() == 0 and Target:IsNPC() and not NRag.isReplacedZB then
					Ragdollize_SetNPCRun_RUN(Target)
				end

				Ragdollize_LimbGib(NRag, Target)

				if not NRag.Opti_2 then

					for i=0, NRag:GetPhysicsObjectCount()-1 do
						local boneName = NRag.Bone_n_phyObj[i]["boneName"]

						if NRag.nrMoveTb[boneName] then

							local phyObj = NRag.Bone_n_phyObj[i]["phyObj"]
							
							if NRag:GetManipulateBoneScale(NRag:TranslatePhysBoneToBone(i)) == Vector(0, 0, 0) and Gib_Tb[boneName] and not NRag.nrMoveBone[boneName]["Gibbed"] then
								if Gib_Tb[boneName] == 1 then
									Ragdollize_EndAnimation(NRag)
								elseif Gib_Tb[boneName] == 3 then
									NRag.nrMoveBone["ValveBiped.Bip01_Head1"]["Gibbed"] = true
									Ragdollize_EndAnimation(NRag)
								elseif Gib_Tb[boneName] == 2.1 then
									NRag.nrMoveBone["ValveBiped.Bip01_R_Thigh"]["Gibbed"] = true
									NRag.nrMoveBone["ValveBiped.Bip01_R_Calf"]["Gibbed"]  = true
									NRag.nrMoveBone["ValveBiped.Bip01_R_Foot"]["Gibbed"]  = true
								elseif Gib_Tb[boneName] == 2.2 then
									NRag.nrMoveBone["ValveBiped.Bip01_L_Thigh"]["Gibbed"] = true
									NRag.nrMoveBone["ValveBiped.Bip01_L_Calf"]["Gibbed"]  = true
									NRag.nrMoveBone["ValveBiped.Bip01_L_Foot"]["Gibbed"]  = true
								elseif Gib_Tb[boneName] == 2.3 then
									NRag.nrMoveBone["ValveBiped.Bip01_R_Clavicle"]["Gibbed"] = true
									NRag.nrMoveBone["ValveBiped.Bip01_R_UpperArm"]["Gibbed"] = true
									NRag.nrMoveBone["ValveBiped.Bip01_R_Forearm"]["Gibbed"]  = true
									NRag.nrMoveBone["ValveBiped.Bip01_R_Hand"]["Gibbed"]     = true
								elseif Gib_Tb[boneName] == 2.4 then
									NRag.nrMoveBone["ValveBiped.Bip01_L_Clavicle"]["Gibbed"] = true
									NRag.nrMoveBone["ValveBiped.Bip01_L_UpperArm"]["Gibbed"] = true
									NRag.nrMoveBone["ValveBiped.Bip01_L_Forearm"]["Gibbed"]  = true
									NRag.nrMoveBone["ValveBiped.Bip01_L_Hand"]["Gibbed"]     = true
								end

								if IsValid(phyObj) then
									phyObj:EnableCollisions(false)
								end
							end
							
							if phyObj and not NRag.nrMoveBone[boneName]["Gibbed"] then			
								
								local bone_pos, bone_ang = nil

								if Target:LookupBone(boneName) then
									bone_pos, bone_ang = Target:GetBonePosition(Target:LookupBone(boneName)) 	
								elseif not Target:LookupBone(boneName) and NRag.isReplacedZB and boneName == "ValveBiped.Bip01_Head1" then
									local boneID = Target:LookupBone("ValveBiped.Bip01_Head1") or Target:LookupBone("ValveBiped.HC_Body_Bone") or Target:LookupBone("ValveBiped.Headcrab_Cube1")
									bone_pos, bone_ang = Target:GetBonePosition(boneID)
								end

								if bone_pos and bone_ang then

									NRag.nrMoveBone[boneName]["ShouldMove"] = false

									if CVAR_Ragdollize_Detail:GetBool() and not NRag.isReplacedZB then
										local tr2 = util.TraceLine( {
											start = phyObj:GetPos(),
											endpos = bone_pos,
											mask = MASK_ALL,
											filter = {NRag, Target}
										})

										if tr2.Hit then
											if not NRag.nrMoveBone[boneName]["HitWall"] then
												NRag.nrHitWall = NRag.nrHitWall + 1
												NRag.nrMoveBone[boneName]["HitWall"] = true
											end
										else
											NRag.nrMoveBone[boneName]["ShouldMove"] = true
										end
									else
										NRag.nrMoveBone[boneName]["ShouldMove"] = true
									end
									
									if NRag.nrMoveBone[boneName]["ShouldMove"] then
										Animrag_CSC_1.pos = bone_pos
										Animrag_CSC_1.angle = bone_ang
										
										phyObj:Wake()
										phyObj:ComputeShadowControl(Animrag_CSC_1)
									end
								end
							end
						end

					end
				end

				if not NRag.isReplacedCC and IsValid(NRag.ONPC) then
					for i=0, NRag.ONPC:GetFlexNum() - 1 do
						NRag:SetFlexWeight(i, NRag.ONPC:GetFlexWeight(i))
					end
				end

				if IsValid(NRag.ONPC) then
					if NRag.ONPC:Health() <= 0 then
						Ragdollize_EndAnimation(NRag)
					end
				end
			end
		end
	end
end)

hook.Add("PostEntityTakeDamage", "Ragdollize_PostNRagHit", function(NRag, dmg)

	if NRag.AltDmg and NRag:IsRagdoll() and NRag.ONPC and IsValid(NRag.ONPC) then

		local fixdmg = dmg:GetDamage()
		local hitgrp = 0
		local ONPC = NRag.ONPC

		if not IsEDAInstalled then
			Ragdollize_GetDamagedBone(NRag, dmg:GetDamagePosition())

		elseif IsEDAInstalled and not NRag.ClosestBoneName then
			Ragdollize_GetDamagedBone(NRag, dmg:GetDamagePosition())
		end

		if Hitbox_Tb[NRag.ClosestBoneName] then
		
			local mult = CVAR_Ragdollize_DmgMulti:GetFloat()
			if Hitbox_Tb[NRag.ClosestBoneName][2] == 5.00 then
	
				if CVAR_Ragdollize_DmgReal:GetBool() then
					fixdmg = dmg:GetDamage()*mult*Hitbox_Tb[NRag.ClosestBoneName][2]
				else
					fixdmg = dmg:GetDamage()*mult*2
				end
				hitgrp = 1
			elseif Hitbox_Tb[NRag.ClosestBoneName][2] < 1.00 then
				
				if CVAR_Ragdollize_DmgReal:GetBool() then
					fixdmg = dmg:GetDamage()*mult*Hitbox_Tb[NRag.ClosestBoneName][2]
				else
					fixdmg = dmg:GetDamage()*mult*0.25
				end
	
				if Hitbox_Tb[NRag.ClosestBoneName][1] == "RL" then
					hitgrp = 7
				elseif Hitbox_Tb[NRag.ClosestBoneName][1] == "LL" then
					hitgrp = 6
				elseif Hitbox_Tb[NRag.ClosestBoneName][1] == "RA" then
					hitgrp = 5
				elseif Hitbox_Tb[NRag.ClosestBoneName][1] == "LA" then
					hitgrp = 4
				end
			else
	
				if CVAR_Ragdollize_DmgReal:GetBool() then
					fixdmg = dmg:GetDamage()*mult*Hitbox_Tb[NRag.ClosestBoneName][2]
				else
					fixdmg = dmg:GetDamage()*mult*1
				end
				hitgrp = 2
			end
		else
	
			if CVAR_Ragdollize_DmgReal:GetBool() then
				fixdmg = dmg:GetDamage()*mult*0.5
			else
				fixdmg = dmg:GetDamage()*mult*1
			end
			hitgrp = 2
		end

		if IsEDAInstalled then

			ONPC.arHit = hitgrp
			ONPC.arDmgInfo = dmg
	
			if dmg:GetDamageType() == DMG_BURN or ONPC:IsOnFire() then
				ONPC.arDmg = "Fire"
			elseif dmg:IsExplosionDamage() or dmg:GetDamageType() == DMG_BLAST then
				ONPC.arDmg = "Explosion"
			elseif ONPC:IsOnGround() and (ONPC:IsNPC() and ONPC:GetIdealMoveSpeed() > 150) then
				ONPC.arDmg = "Moving"
			elseif (dmg:GetDamageType() == DMG_CLUB or dmg:GetDamageType() == DMG_CRUSH) then
				ONPC.arDmg = "Club"
			else
				ONPC.arDmg = "Bullet"
			end
	
			local attacker = dmg:GetAttacker()
			if attacker:IsNPC() or attacker:IsPlayer() then 
				local awep = attacker:GetActiveWeapon()
				if weaponlist and IsValid(awep) then
					for k, v in pairs(weaponlist) do
						if v.wep == awep:GetPrintName() then
							ONPC.arDmg = v.typ
						end
					end
				end
			end
		
			local dmgpos = dmg:GetDamagePosition()
		
			ONPC.arNeckshot = false
			ONPC.arShotshot = false
			ONPC.arBackshot = false
			ONPC.arPelvshot = false
			ONPC.arShotDecided = false
		
			if ONPC.arDmg == "Shotgun" then
				ONPC.arDmg = "Bullet"
				ONPC.arShotshot = true
			end
		
			if not ONPC.arShotDecided and NRag.ClosestBoneName =="ValveBiped.Bip01_Pelvis" then
				ONPC.arPelvshot = true
				ONPC.arShotDecided = true
			end

			if not ONPC.arShotDecided and (dmg:IsDamageType(DMG_BUCKSHOT) or dmg:GetAmmoType() == 7) then
				ONPC.arShotshot = true
				ONPC.arShotDecided = true
			end

			if not ONPC.arShotDecided and ONPC:LookupBone("ValveBiped.Bip01_Head1") and (ONPC.arHit == 1 and dmgpos.z < ONPC:GetBonePosition(ONPC:LookupBone("ValveBiped.Bip01_Head1")).z) then
				ONPC.arNeckshot = true
				ONPC.arShotDecided = true
			end
			
			if not ONPC.arShotDecided and GetConVar("ARag_nobackshot") and not GetConVar("ARag_nobackshot"):GetBool() and ONPC:GetForward():Dot((dmgpos - ONPC:GetPos()):GetNormalized()) < 0 then
				ONPC.arBackshot = true
				ONPC.arShotDecided = true
			end
		end

		if IsValid(dmg:GetAttacker()) and dmg:GetAttacker() == NRag.ONPC then
			fixdmg = 0
		end

		if not IsValid(dmg:GetAttacker()) or dmg:GetAttacker():IsWorld() then
			fixdmg = 0
		end

		if IsValid(dmg:GetAttacker()) and dmg:GetAttacker() == NRag then
			fixdmg = 0
		end

		if bit.band(dmg:GetDamageType(), DMG_CRUSH) ~= 0 then
			local attacker = dmg:GetAttacker()
			if IsValid(attacker) and attacker:GetClass() and string.match(attacker:GetClass(), "vehicle") then
			else
				fixdmg = 0
			end
		end

		if fixdmg < 1 then
			fixdmg = 0
		end

		NRag.Hp_n = NRag.Hp_n - fixdmg
		NRag.Dmg_Attacker = dmg:GetAttacker()
		NRag.Dmg_Inflictor = dmg:GetInflictor()
		NRag.Dmg_Dmgtype = dmg:GetDamageType()
		ONPC:SetHealth(NRag.Hp_n)
		if NRag.Hp_n <= 0 then
			ONPC:SetHealth(0)
		end
	end
end)

hook.Add("PlayerShouldTakeDamage", "Ragdollize_PlayerHit", function(ply, attacker)
	if attacker.isTwoArmsGibbed then
		return false
	end
end)

hook.Add("EntityTakeDamage", "Ragdollize_BlockONPCSelfDamage", function(ONPC, dmg)
	if not IsValid(ONPC.NRag) then return end
	if not ONPC:IsNPC() then return end

	if bit.band(dmg:GetDamageType(), DMG_CRUSH) ~= 0 then
		local attacker = dmg:GetAttacker()

		if not IsValid(attacker) or attacker:IsWorld() then
			dmg:SetDamage(0)
			return
		end

		if attacker == ONPC.NRag or attacker == ONPC then
			dmg:SetDamage(0)
			return
		end

		if attacker:GetClass() and string.match(attacker:GetClass(), "vehicle") then return end

		dmg:SetDamage(0)
	end
end)

hook.Add("ScaleNPCDamage", "Ragdollize_ONPCHit", function(ONPC, hitgrp, dmg)
	if IsValid(ONPC.NRag) then
		local NRag = ONPC.NRag
		NRag.Dmg_Attacker = dmg:GetAttacker()
		NRag.Dmg_Inflictor = dmg:GetInflictor()
		NRag.Dmg_Dmgtype = dmg:GetDamageType()
	end
end)

hook.Add("PlayerInitialSpawn", "Ragdollize_ReplaceMapCorpse_InitialSpawn" , function( ply )
	timer.Simple(1, function()
		for _, ent in pairs(ents.GetAll()) do
			if IsValid(ent) then
				if ent:GetClass() == "prop_ragdoll" then
					if CVAR_Ragdollize_ReplaceCombine:GetBool() and CombineModel[ent:GetModel()] and combineTb and table.Count(combineTb) != 0 then
						Ragdollize_ReplaceMapCorpse(ent, "combine")
					elseif CVAR_Ragdollize_ReplaceCitizen:GetBool() and string.match(ent:GetModel(), "models/humans") and citizenTb and table.Count(citizenTb) != 0 then
						Ragdollize_ReplaceMapCorpse(ent, "citizen")
					elseif CVAR_Ragdollize_ReplaceZombies:GetBool() and ZombieModel[ent:GetModel()] and zombiesTb and table.Count(zombiesTb) != 0 then
						Ragdollize_ReplaceMapCorpse(ent, "zombies")
					end
				end
			end
		end
	end)
end)

hook.Add("PostCleanupMap", "Ragdollize_ReplaceMapCorpse_PostCleanupMap" , function( ply )
	for _, ent in pairs(ents.GetAll()) do
		if IsValid(ent) then
			if ent:GetClass() == "prop_ragdoll" then
				if CVAR_Ragdollize_ReplaceCombine:GetBool() and CombineModel[ent:GetModel()] and combineTb and table.Count(combineTb) != 0 then
					Ragdollize_ReplaceMapCorpse(ent, "combine")
				elseif CVAR_Ragdollize_ReplaceCitizen:GetBool() and string.match(ent:GetModel(), "models/humans") and citizenTb and table.Count(citizenTb) != 0 then
					Ragdollize_ReplaceMapCorpse(ent, "citizen")
				elseif CVAR_Ragdollize_ReplaceZombies:GetBool() and ZombieModel[ent:GetModel()] and zombiesTb and table.Count(zombiesTb) != 0 then
					Ragdollize_ReplaceMapCorpse(ent, "zombies")
				end
			end
		end
	end

	ShuffleIndex_Combine = 1
	ShuffleIndex_Citizen = 1
	ShuffleIndex_Zombies = 1
	combineTb = Ragdollize_ShuffleTable(combineTb)
	citizenTb = Ragdollize_ShuffleTable(citizenTb)
	zombiesTb = Ragdollize_ShuffleTable(zombiesTb)

	Ragdollize_Tb = {}
end)

hook.Add("PreCleanupMap", "Ragdollize_ReplaceMapCorpse_PreCleanupMap" , function( ply )
	mapInitizeFinish = false
	timer.Simple(1, function()
		mapInitizeFinish = true
		Ragdollize_LastLoadingTime = CurTime() + 4
		Ragdollize_CreateTimers()

		if hook.GetTable()["EntityTakeDamage"]["Animrag_OnEntityCreated"] then
			IsEDAInstalled = true
		end
	end)
end)

hook.Add("PostUndo", "Ragdollize_Undo", function(undo)
	for _, ONPC in pairs(undo.Entities) do
		if IsValid(ONPC) and ONPC:IsNPC() and IsValid(ONPC.NRag) then
			for k, rag in pairs(Ragdollize_Tb) do
				if rag == ONPC.NRag then
					Ragdollize_EndAnimation(ONPC.NRag)
					ONPC.NRag:Remove()
				end
			end
		end
	end
end)

hook.Add("ShouldCollide", "Ragdollize_Collision", function(ent1, ent2)
	if ent1.CollisionEnt_NRag == ent2 then
		return false
	end
	if ent2.CollisionEnt_NRag == ent1 then
		return false
	end
end)

concommand.Add("ragdollize_print_table", function()
	print("Ragdollize_Tb: ------------")
	for k, rag in pairs(Ragdollize_Tb) do
		if IsValid(rag) then
			print(tostring(rag) .. " MDL: " .. tostring(rag:GetModel()) .. " ONPC: " .. tostring(rag.ONPC) .. "  opti_1:" .. tostring(rag.Opti_1) .. "  opti_2:" .. tostring(rag.Opti_2))
		end
	end
	print("Ragdollize_LoadingTb: ------------")
	PrintTable(Ragdollize_LoadingTb)
end)

concommand.Add("ragdollize_print_los", function(ply)
	local ent = ply:GetEyeTrace().Entity
	print(ent)
	print("mapInitize: " .. tostring(mapInitizeFinish))
	print("Is waiting for replace: " .. tostring(ent.WaitingForReplace))

	local currentNRagNum = 0
	for k, rag in pairs(Ragdollize_Tb) do
		currentNRagNum = currentNRagNum + 1
	end

	local firstNPC = Ragdollize_LoadingTb[1]
	local tooManyNRags = currentNRagNum >= CVAR_Ragdollize_MaxNumber:GetInt()

	print("TooManyNRags: " .. tostring(tooManyNRags))
	print("VisibleToPLY: " .. tostring(firstNPC.VisibleToPLY))
end)

concommand.Add("ragdollize_print_opti", function(ply)
	local ent = ply:GetEyeTrace().Entity
	if ent:IsNPC() and ent.NRag then
		ent = ent.NRag
	end
	print(ent)
	print("opti 1: " .. tostring(ent.Opti_1))
	print("opti 2: " .. tostring(ent.Opti_2))
end)

concommand.Add("ragdollize_reload", function(ply)
	Ragdollize_LoadingTb = {}
	for _, ent in pairs(ents.GetAll()) do
		if IsValid(ent) and ent:IsSolid() and ent:GetModel() and ent:GetClass() != "entity_blocker" and ent:IsNPC() and not ent.NRag then
			if Ragdollize_GetRagdollizeType(ent) then
				ent.WaitingForReplace = true
				table.insert(Ragdollize_LoadingTb, ent)
			end
		end
	end
	Ragdollize_CreateTimers()

	for _, ent in pairs(ents.GetAll()) do
		if IsValid(ent) then
			if ent:GetClass() == "prop_ragdoll" and not ent.IsRagdollizedRagdoll then
				if CVAR_Ragdollize_ReplaceCombine:GetBool() and CombineModel[ent:GetModel()] and combineTb and table.Count(combineTb) != 0 then
					Ragdollize_ReplaceMapCorpse(ent, "combine")
				elseif CVAR_Ragdollize_ReplaceCitizen:GetBool() and string.match(ent:GetModel(), "models/humans") and citizenTb and table.Count(citizenTb) != 0 then
					Ragdollize_ReplaceMapCorpse(ent, "citizen")
				elseif CVAR_Ragdollize_ReplaceZombies:GetBool() and ZombieModel[ent:GetModel()] and zombiesTb and table.Count(zombiesTb) != 0 then
					Ragdollize_ReplaceMapCorpse(ent, "zombies")
				end
			end
		end
	end
end)

hook.Add("EntityRemoved", "Ragdollize_NRagAutoRemoved", function(ent)
	if not ent.IsRagdollizedRagdoll2 then return end
	if not IsValid(ent.ONPC) then return end

	local ONPC = ent.ONPC

	ent.IsRagdollizedRagdoll2 = false

	for k, v in pairs(Ragdollize_Tb) do
		if v == ent then
			table.remove(Ragdollize_Tb, k)
			break
		end
	end

	ONPC:SetNoDraw(false)
	ONPC:SetSolid(ONPC.Orgn_Solid or SOLID_BBOX)
	ONPC:SetNWBool("IsRagdollizedONPC", false)
	ONPC.NRag = nil
	ent.ONPC = nil
end)

concommand.Add("ragdollize_remove_bugged", function(ply)
	for _, ent in pairs(ents.GetAll()) do
		if ent and IsValid(ent) and ent:GetClass() != "entity_blocker" then
			if ent:IsNPC() then
				if not IsValid(ent.NRag) and ent:GetNWBool("IsRagdollizedONPC") then
					print("This NPC is bugged (01), Removing: " .. tostring(ent))
					ent:Remove()
				end

				if ent:GetNWBool("IsRagdollizedONPC") then
					local boneID = ent:LookupBone("ValveBiped.Bip01_Pelvis") or 0
					local pelvPos = ent:GetBonePosition(boneID)
					if ent.NRag:GetPos():DistToSqr(pelvPos) >= 10000 then
						print("This NPC is bugged (02), Removing: " .. tostring(ent))
						ent:Remove()
					end
				end

				if ent.NRag and ent:GetNoDraw() and ent.NRag:GetNoDraw() then
					print("This NPC is bugged (03), Removing: " .. tostring(ent))
					ent:Remove()
					ent.NRag:Remove()
				end

				if IsValid(ent.NRag) and not IsValid(ent.NRag.ONPC) then
					print("This NPC is bugged (04), Removing: " .. tostring(ent))
					ent:Remove()
					ent.NRag:Remove()
				end

			elseif ent:IsRagdoll() then
				if (ent.ONPC and ent.ONPC:EntIndex() == 0) or (ent.IsRagdollizedRagdoll2 and not ent.ONPC) then
					print("This NPC is bugged (05), Removing: " .. tostring(ent))
					Ragdollize_EndAnimation(ent)
				end
			end
		end
	end
end)

timer.Simple(1, function()
	local ply = player.GetAll()[1]
	if ply and IsValid(ply) and ply:Alive() then
		mapInitizeFinish = true
	end
end)

hook.Add("CreateEntityRagdoll","handledeathcustombonemerge_WTF", function(owner,ragdoll)
end)

hook.Add("CreateEntityRagdoll","makeserverragdollnocollide_WTF", function(owner,ragdoll)
end)

hook.Add("CreateEntityRagdoll","tttheadcrabtakeoverdatatransfer_WTF", function(owner,ragdoll)
end)