

----------------------------------------------------------------------------------------
--拦截并修改BSMOD Killmove的参数，以适配该模组
if file.Exists("autorun/bsmod_killmove.lua", "LUA") then

	include("autorun/bsmod_killmove.lua")

	--修改BSMOD中的KMCheck函数
	function KMCheck(ply)

		if ply.inKillMove then return false end
	
		local tr = util.TraceLine( {
			start = ply:EyePos(),
			endpos = ply:EyePos() + ply:EyeAngles():Forward() * 100,
			filter = ply
		} )
		
		if !IsValid(tr.Entity) then
			tr = util.TraceHull( {
				start = ply:EyePos(),
				endpos = ply:EyePos() + ply:EyeAngles():Forward() * 100,
				filter = ply,
				mins = Vector( -1, -1, -1 ),
				maxs = Vector( 1, 1, 1 ),
			} )
		end
		
		if !IsValid(tr.Entity) then return false end
		
		local target = tr.Entity
	
		--改的是这里
		if tr.Entity.ONPC then
			target = tr.Entity.ONPC
		end
		--改的是这里
		
		if !target:IsPlayer() and !target:IsNPC() and !target:IsNextBot() then return false end
		
		if ply.inKillMove or ply:Health() <= 0 or target.inKillMove or target == ply then return false end
		
		if target:IsPlayer() then
			if GetConVar( "bsmod_killmove_enable_players" ):GetInt() == 0 or target:HasGodMode() then return false end 
			if engine.ActiveGamemode() != "sandbox" and GetConVar( "bsmod_killmove_enable_teammates" ):GetInt() == 0 then if target:Team() == ply:Team() then return false end end
		end
		
		if target:IsNPC() or target:IsNextBot() then if GetConVar( "bsmod_killmove_enable_npcs" ):GetInt() == 0 then return false end end
		
		--end of return false checks
		
		--Direction check for killmoves
		
		local vec = ( ply:GetPos() - target:GetPos() ):GetNormal():Angle().y
		local targetAngle = target:EyeAngles().y
		
		if targetAngle > 360 then
			targetAngle = targetAngle - 360
		end
		if targetAngle < 0 then
			targetAngle = targetAngle + 360
		end
		
		local angleAround = vec - targetAngle
		
		if angleAround > 360 then
			angleAround = angleAround - 360
		end
		if angleAround < 0 then
			angleAround = angleAround + 360
		end
		
		if GetConVar( "bsmod_killmove_anytime" ):GetInt() == 0 then
			if GetConVar( "bsmod_killmove_anytime_behind" ):GetInt() == 0 then 
				if !target.killMovable then
					return false 
				end
			elseif !target.killMovable and !(angleAround > 135 and angleAround <= 225) then
				return false
			end
		end
		
		--print ("target eye angles", targetAngle, "angle to target", vec, "the sum thing", angleAround)
		
		--Setup killmove values
		
		local plyKMModel = ""
		local targetKMModel = ""
		local animName = ""
		local plyKMPosition = nil
		local plyKMAngle = nil
		local plyKMTime = nil
		local targetKMTime = nil
		local moveTarget = false
		
		--Custom killmove hook
		local customKMData = hook.Run("CustomKillMoves", ply, target, angleAround)
		
		if customKMData then
			if customKMData[1] != nil then plyKMModel = customKMData[1] end
			if customKMData[2] != nil then targetKMModel = customKMData[2] end
			if customKMData[3] != nil then animName = customKMData[3] end
			if customKMData[4] != nil then plyKMPosition = customKMData[4] end
			if customKMData[5] != nil then plyKMAngle = customKMData[5] end
			if customKMData[6] != nil then plyKMTime = customKMData[6] end
			if customKMData[7] != nil then targetKMTime = customKMData[7] end
			if customKMData[8] != nil then moveTarget = customKMData[8] end
		end
		
		--Default killmoves
		if animName == "" and GetConVar( "bsmod_killmove_disable_defaults" ):GetInt() == 0 then
			plyKMModel = "models/weapons/c_limbs.mdl"
			
			if target:LookupBone("ValveBiped.Bip01_Spine") then
				targetKMModel = "models/bsmodimations_human.mdl"
				
				if angleAround <= 45 or angleAround > 315 then
					if ply:OnGround() then
						--if ply:EyeAngles().x <= 30 then]]
							animName = "killmove_front_" .. math.random(1, 2)
						--end
						
						if animName == "killmove_front_1" then targetKMTime = 1.15 end
					else
						animName = "killmove_front_air_1"
					end
				end
				
				if angleAround > 45 and angleAround <= 135 then
					animName = "killmove_left_1"
				end
				
				if angleAround > 135 and angleAround <= 225 then
					animName = "killmove_back_1"
				end
				
				if angleAround > 225 and angleAround <= 315 then
					animName = "killmove_right_1"
				end
			elseif target:LookupBone("MiniStrider.body_joint") then
				targetKMModel = "models/bsmodimations_hunter.mdl"
				
				animName = "killmove_hunter_front_1"
			end
			
			if animName == "killmove_left_1" then
				plyKMPosition = target:GetPos() + (-target:GetRight() * 31.5 )
			elseif animName == "killmove_right_1" then
				plyKMPosition = target:GetPos() + (target:GetRight() * 95) + (target:GetForward() * 10)
				plyKMAngle = (-target:GetRight()):Angle()
			elseif animName == "killmove_back_1" then
				plyKMPosition = target:GetPos() + (-target:GetForward() * 30 )
			elseif animName == "killmove_front_1" then
				plyKMPosition = target:GetPos() + (target:GetForward() * 31.5 )
			elseif animName == "killmove_front_2" then
				plyKMPosition = target:GetPos() + (target:GetForward() * 29 )
			elseif animName == "killmove_front_air_1" then
				plyKMPosition = target:GetPos() + (target:GetForward() * 39 )
			elseif animName == "killmove_hunter_front_1" then
				plyKMPosition = target:GetPos() + (target:GetForward() * 31.5 )
			end
		end
		
		ply:KillMove(target, animName, plyKMModel, targetKMModel, plyKMPosition, plyKMAngle, plyKMTime, targetKMTime, moveTarget)
		
		return true
	end
	
	concommand.Add("bsmod_killmove", KMCheck)
end


--去你妈的ReAgdoll
//----------------------------------------------------------------------------------------
//--拦截并修改Reagdoll的参数，以适配该模组
//if file.Exists("responses/output_manager.lua", "LUA") and file.Exists("autorun/server/reaction_selector.lua", "LUA") then
//
//	if not GetConVar("ragdollize_enable"):GetBool() then return end
//
//	include("responses/output_manager.lua")
//	include("autorun/server/reaction_selector.lua")
//
//	timer.Simple(2, function()
//	
//		--必要的前置内容
//		local combinetbl = {
//		"models/police.mdl",
//		"models/combine_soldier.mdl",
//		"models/combine_soldier_prisonguard.mdl",
//		"models/combine_super_soldier.mdl",
//		"models/player/combine_soldier.mdl",
//		"models/player/combine_super_soldier.mdl",
//		"models/player/combine_soldier_prisonguard.mdl",
//		"models/player/police.mdl",
//		"models/player/police_fem.mdl",
//		"models/player/combine_soldier_prisonguard.mdl"
//		}
//		
//		local zombietbl = {
//		"models/zombie/classic.mdl",
//		"models/headcrabclassic.mdl",
//		"models/zombie/classic_torso.mdl",
//		"models/gibs/fast_zombie_torso.mdl",
//		"models/zombie/fast.mdl",
//		"models/zombie/poison.mdl",
//		"models/zombie/zombie_soldier.mdl"
//		}
//	
//		local IsRagdollFlying = function(ragdoll)
//			if ragdoll == nil then return end
//			local ragphys = ragdoll:GetPhysicsObjectNum(0)
//			rd_debug("ragdoll speed is "..ragdoll:GetVelocity():LengthSqr())
//			
//			if ragdoll:GetVelocity():LengthSqr() >=  5054856 then
//		
//				RDragdollstats[ragdoll].State = bit.bor(RDragdollstats[ragdoll].State, RD_RAGDOLL_STATE.FLYING)
//				return true
//			else
//				return false
//			end
//			
//		end
//	
//	
//		------------------------------------------------------
//		--死亡效果相关
//		function RD_ragdollphysics (ragdoll)
//
//			if !rdcvar_enabled:GetBool() then return end
//			if !ragdoll:IsValid() then return end
//			
//			timer.Simple(FrameTime(), function()
//				
//				if not ragdoll.IsRagdollizedNew1 and ragdoll.IsRagdollizedRagdoll2 then
//					ragdoll.IsRagdollizedNew1 = true
//				return end
//			
//				if ragdoll.ReplaceRag then
//					ragdoll = ragdoll.ReplaceRag
//				end
//
//
//				local model = ragdoll:GetModel()
//				
//				if (rdcvar_nocollide:GetBool()) then ragdoll:SetCollisionGroup( 11) end
//				if (rdcvar_nocollide_all:GetBool()) then ragdoll:SetCollisionGroup( 1) end
//				
//				if !table.HasValue(RD_ModelsToIgnore , string.lower(model) ) then
//					for index, bone in pairs( RD_PhysTable ) do	--Here we are applying a preset of mass and inertia values to our bones, this is so our ragdolls will act consistently dont matter the model given
//						
//						if !string.match( ragdoll:GetBoneName( 0 ), "ValveBiped" ) then return end	
//						
//						if ragdoll:LookupBone( index ) == nil then	 return end
//						
//						local  boneid = ragdoll:TranslateBoneToPhysBone(ragdoll:LookupBone( index ))	
//						
//						local ragphys = ragdoll:GetPhysicsObjectNum( boneid )		
//						if IsValid( ragphys )then
//							ragphys:SetMass(bone.mass)
//							ragphys:SetInertia(bone.inertia)
//							
//							if(rdcvar_realfloat:GetBool())then
//								if boneid != 1 or boneid !=0 then
//									ragphys:SetBuoyancyRatio(.7)
//								end
//								if boneid == 1 or boneid == 0 then
//									ragphys:SetBuoyancyRatio(2) 
//								end
//							end
//						end
//					
//					end
//				else
//					rd_debug(model.." caught! ignoring...") 		
//				end
//				RDragdollstats[ragdoll] = { --Assigning table values to nil is the same as if that value didnt exist to begin with, BUT this is usefull for keeping track of the values i want available
//					NextAnim = nil,
//					AnimEntity = nil,
//					TargetEnt = nil,
//					Health = rdcvar_death_health:GetFloat(),
//					NextDieTime = nil,
//					Master = nil,
//					State = 0,
//					Time_Snapshot = CurTime(),
//					Time_On_Air = 0,
//				
//				  --[8]  = { broken = false, parent = 0 , offset = Vector(0,0,0)}, --Thighs
//				  --[11] = { broken = false, parent = 0 , offset = Vector(0,0,0)},
//					["ValveBiped.Bip01_R_Forearm"]	= { broken = false, parent = "ValveBiped.Bip01_R_UpperArm" , offset = Vector(10,0,0)},
//					["ValveBiped.Bip01_L_Forearm"]	= { broken = false, parent = "ValveBiped.Bip01_L_UpperArm"	 , offset = Vector(10,0,0)},
//					["ValveBiped.Bip01_L_Calf"]= { broken = false, parent = "ValveBiped.Bip01_L_Thigh", offset = Vector(16,0,0)},
//					["ValveBiped.Bip01_R_Calf"]	= { broken = false, parent = "ValveBiped.Bip01_R_Thigh" , offset = Vector(16,0,0)},
//				  --[2]	= { broken = false, parent = 1 , offset = Vector(10,-0,-5.5)}, --Shoulders
//				  --[3]	= { broken = false, parent = 1 , offset = Vector(10,-0,5.5)}
//					
//				}
//			end)
//		end
//
//
//		function RD_onDeath( ent, ragdoll, dmg, dmgpos, dmgtype, rd_hitgrp )
//			timer.Simple(FrameTime(), function()
//				if !rdcvar_enabled:GetBool() then return end
//
//				if not ragdoll.IsRagdollizedNew2 and ragdoll.IsRagdollizedRagdoll2 then
//					ragdoll.IsRagdollizedNew2 = true
//				return end
//			
//				if ragdoll.ReplaceRag then
//					ragdoll = ragdoll.ReplaceRag
//				end
//
//				RD_keepcount (ragdoll)
//				if !string.match( ragdoll:GetBoneName( 0 ), "ValveBiped" ) then return end
//				
//				local _,hitgroup = RD_PhysDamagePos( dmgpos,ragdoll)
//			
//				if !table.HasValue(RD_ModelsToIgnore , string.lower(ragdoll:GetModel()) ) then 	RDSelector.Activate(dmgtype,hitgroup,ragdoll,dmgpos,ent) end	
//			
//				
//				if (rdcvar_cleanup_timer:GetBool()) then SafeRemoveEntityDelayed( ragdoll, rdcvar_cleanup_timer_ammount:GetFloat()) end
//			end)
//		end
//	
//		------------------------------------------------------
//		--SFX相关
//		RDSelector.SoundReaction = function(dmgtype,hitgroup,ent,ragdoll)
//			
//			timer.Simple(FrameTime(), function()
//			
//				if not ragdoll.IsRagdollizedNew3 and ragdoll.IsRagdollizedRagdoll2 then
//					ragdoll.IsRagdollizedNew3 = true
//				return end
//			
//				if ragdoll.ReplaceRag then
//					ragdoll = ragdoll.ReplaceRag
//				end
//			
//				local isflying = IsRagdollFlying(ragdoll)
//				if (!rdcvar_sfx:GetBool()) then return end
//				if ent != nil then 
//					if ent:IsNPC() then 
//						if table.HasValue(combinetbl, string.lower(ragdoll:GetModel())) then 
//							if (rdcvar_sfx_combine:GetBool()) and ent:SentenceStop() != nil then  ent:SentenceStop()end
//						elseif table.HasValue(zombietbl, string.lower(ragdoll:GetModel())) then 
//							if (rdcvar_sfx_zombies:GetBool()) and ent:SentenceStop() != nil then  ent:SentenceStop()end
//						else
//							if (rdcvar_sfx_npcs:GetBool()) and ent:SentenceStop() != nil  then  ent:SentenceStop() end
//						end
//					end
//				
//			
//			
//					if ragdoll == nil or !ent:GetShouldServerRagdoll() then ragdoll = ent end
//				end
//				if dmgtype == nil then dmgtype = DMG_GENERIC end
//				if ( bit.band( dmgtype, DMG_BULLET ) == DMG_BULLET ) then
//				
//					if  hitgroup == 10 or rd_hitgrp ==10 then			
//						if (rdcvar_sfx:GetBool()) and (rdcvar_sfx_gorehs:GetBool()) then RDreactionsound.headshot(ragdoll) end			
//						if (rdcvar_sfx:GetBool()) and (rdcvar_sfx_headshot:GetBool()) then RDreactionsound.bullet(ragdoll) end	
//						elseif ( bit.band( dmgtype, DMG_BUCKSHOT ) == DMG_BUCKSHOT ) then	
//						RDreactionsound.blunt(ragdoll)
//						else
//						RDreactionsound.bullet(ragdoll)
//					end
//					
//				elseif ( bit.band( dmgtype, DMG_CRUSH ) == DMG_CRUSH ) then-- BLUNT DEATH
//					RDreactionsound.blunt(ragdoll)
//				elseif ( bit.band( dmgtype, DMG_BLAST ) == DMG_BLAST ) then-- EXPLODE DEATH
//					RDreactionsound.explode(ragdoll)
//				elseif ( bit.band( dmgtype, DMG_BURN ) == DMG_BURN ) then-- BURN DEATH
//					if !rdcvar_npcs:GetBool()then
//						RDreactionsound.fire(ragdoll)
//					end
//				else
//					if (math.random(0, 1) >= .5) then
//						RDreactionsound.bullet(ragdoll)
//					else
//						RDreactionsound.blunt(ragdoll)
//					end
//				end	
//	
//				if ent != nil then 
//					if !rdcvar_sfx_players:GetBool() and ent:IsPlayer() then RDreactionsound.kill(ragdoll,true)  end
//					if !rdcvar_sfx_npcs:GetBool() and ent:IsNPC() then RDreactionsound.kill(ragdoll,true)  end
//				end
//				if isflying then
//					RDreactionsound.kill(ragdoll,true) 
//					RDreactionsound.fly(ragdoll)
//				end 
//			end)
//		end
//
//	end)
//end