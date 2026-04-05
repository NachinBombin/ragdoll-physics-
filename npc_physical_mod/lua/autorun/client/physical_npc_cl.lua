
local ZombieModel = {
	["models/zombie/classic.mdl"] = true,
	["models/zombie/classic_torso.mdl"] = true,
	["models/zombie/fast.mdl"] = true,
	["models/zombie/fast_torso.mdl"] = true,
	["models/zombie/poison.mdl"] = true,
	["models/zombie/zombie_soldier.mdl"] = true,
	["models/zombie/classic_torso.mdl"] = true,
	["models/zombie/classic_legs.mdl"] = true,
	["models/gibs/fast_zombie_legs.mdl"] = true,
	["models/gibs/fast_zombie_torso.mdl"] = true,
}

local FingerTb = {
	//"ValveBiped.Bip01_L_Finger0",
	"ValveBiped.Bip01_L_Finger01",
	"ValveBiped.Bip01_L_Finger02",
	"ValveBiped.Bip01_L_Finger4",
	"ValveBiped.Bip01_L_Finger41",
	"ValveBiped.Bip01_L_Finger42",
	"ValveBiped.Bip01_L_Finger3",
	"ValveBiped.Bip01_L_Finger31",
	"ValveBiped.Bip01_L_Finger32",
	"ValveBiped.Bip01_L_Finger2",
	"ValveBiped.Bip01_L_Finger21",
	"ValveBiped.Bip01_L_Finger22",
	"ValveBiped.Bip01_L_Finger1",
	"ValveBiped.Bip01_L_Finger11",
	"ValveBiped.Bip01_L_Finger12",
	//"ValveBiped.Bip01_R_Finger0",
	"ValveBiped.Bip01_R_Finger01",
	"ValveBiped.Bip01_R_Finger02",
	"ValveBiped.Bip01_R_Finger4",
	"ValveBiped.Bip01_R_Finger41",
	"ValveBiped.Bip01_R_Finger42",
	"ValveBiped.Bip01_R_Finger3",
	"ValveBiped.Bip01_R_Finger31",
	"ValveBiped.Bip01_R_Finger32",
	"ValveBiped.Bip01_R_Finger2",
	"ValveBiped.Bip01_R_Finger21",
	"ValveBiped.Bip01_R_Finger22",
	"ValveBiped.Bip01_R_Finger1",
	"ValveBiped.Bip01_R_Finger11",
	"ValveBiped.Bip01_R_Finger12"
}


hook.Add( "CreateClientsideRagdoll", "Ragdollize_CreateClientsideRagdoll", function(ONPC, Orgn_Rag)
	-- FIX: Added IsValid guard for Orgn_Rag before calling Remove, prevents
	-- potential error if the ragdoll was already removed by another hook
	if GetConVar("ragdollize_replacezombies") and GetConVar("ragdollize_replacezombies"):GetBool() and ZombieModel[ONPC:GetModel()] then
		if IsValid(Orgn_Rag) then
			Orgn_Rag:Remove()
		end
	end
end)


net.Receive("Ragdollize_PoseFingerBone_sTc", function()
	local ORag = Entity(net.ReadInt(32))
	local ONPC = Entity(net.ReadInt(32))

	if not IsValid(ORag) or not IsValid(ONPC) then return end
	
	ORag:InvalidateBoneCache()
	ONPC:InvalidateBoneCache()

	for _, bonename in pairs(FingerTb) do
		local boneID_ORag = ORag:LookupBone(bonename)
		local boneID_ONPC = ONPC:LookupBone(bonename)

		if boneID_ORag and boneID_ONPC then
			--得到该Bone与其父级Bone的Matrix
			local boneID_ONPC_P = ONPC:GetBoneParent(boneID_ONPC)
			local matrix = ONPC:GetBoneMatrix(boneID_ONPC)
			local matrix_P = ONPC:GetBoneMatrix(boneID_ONPC_P) 
			--得到该Bone相较于其父级Bone的相对Matrix
			//if bonename == "ValveBiped.Bip01_L_Finger01" then
			//	print(matrix)
			//end
			if matrix and matrix_P then
				local matrix_Relative = matrix_P:GetInverseTR()*matrix
				--用该相对Matrix的角度来改变手指角度
				local ang_Relative = matrix_Relative:GetAngles()
				ORag:ManipulateBoneAngles(boneID_ORag, ang_Relative)
			end
		end
	end
end)