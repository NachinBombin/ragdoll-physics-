
file.CreateDir("npc_physical_mod")
include("autorun/client/physical_npc_menu.lua")

concommand.Add("ragdollize_update_menu", function()

	local window = vgui.Create("DFrame")
	window:SetSize(800, 800)
	window:Center()
	window:SetTitle("")
	window:SetDraggable(true)
	window:MakePopup()
	window.Paint = function(self, w, h)
		draw.RoundedBox(20, 0, 0, w, h, Color(10, 10, 10, 235))
		draw.RoundedBox(20, 0, 0, w-6, h-6, Color(235, 235, 235, 235))
		draw.SimpleText("NPC Physical Mod", "DermaLarge", 400, 20, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	function window:OnClose()
		RunConsoleCommand("ragdollize_panel")
	end

	local SubTitle = vgui.Create("DLabel", window)
	SubTitle:SetPos(330, 65)
	SubTitle:SetFont("CreditsOutroText")
	SubTitle:SetText("Something Newwwwww!")
	SubTitle:SetColor(Color(100, 100, 100, 100))
	SubTitle:SizeToContents()

	local Red_panel = vgui.Create("DPanel", window)
	Red_panel:SetPos(70, 105)
	Red_panel:SetSize(660, 35)
	Red_panel:SetBackgroundColor( Color(255, 51, 51, 255) )

	---------------------------
	surface.CreateFont("UpdateFont", {
		font = "Louis George Cafe",
		size = 16,
		weight = 1000,
		antialias = true,
	})


	local label_1= vgui.Create("RichText", window)
	label_1:SetPos(70, 120)
	label_1:SetSize(800, 800)
	label_1:InsertColorChange(235, 235, 235, 255)
	function label_1:PerformLayout()
		self:SetFontInternal("UpdateFont")
	end


	label_1:AppendText(" Sorry for interruption but there have been some HUUUGE Updates! ")
	
	
	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\n\n\n01 -------------------------------------------------------------------------------------------------------01")
	
	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\nCrazy Optimization")
	
	label_1:InsertColorChange(10, 10, 10, 200)
	label_1:AppendText("\n\nIt took a huge effort to optimize this mod for better performance")
	label_1:AppendText("\n\nIn short, if you are playing campaign maps with many NPCs, but they are scattered across the map,")
	label_1:AppendText("\nnot dozens of them gathered together. Then performance will be fine.")
	label_1:AppendText("\nHowever, if there are dozens of NPCs gathering in the same place in the map")
	label_1:AppendText("\nThen you may lag the sh*t out.")
	
	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\n\n\n02 -------------------------------------------------------------------------------------------------------02")
	
	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\nZombie Replacement Improvement")
	
	label_1:InsertColorChange(10, 10, 10, 200)
	label_1:AppendText("\n\nIf you are using [Zombies Model Replacement], And with a dismember addon like [Zippy's Gore Mod],")
	label_1:AppendText("\nAnd with [Physics Simulation Method] set to \"1\", (Which enables you to gib NPCs when they are alive)")
	label_1:AppendText("\nThen when you dismember a Zombie's leg, It will fall to the ground and become a Torso Zombie.")
	
	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\n\n\n03 -------------------------------------------------------------------------------------------------------03")
	
	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\nAddon Compatibility")
	
	label_1:InsertColorChange(10, 10, 10, 200)
	label_1:AppendText("\n\nStable compatibility with [Enhanced Death Animations] because I wrote it")
	label_1:AppendText("\nNo longer supports [Reagdoll] or [Fedhoria] because I can't change their code")

	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\n\n\n04 -------------------------------------------------------------------------------------------------------04")
	
	label_1:InsertColorChange(10, 10, 10, 255)
	label_1:AppendText("\nExpected Problems")
	
	label_1:InsertColorChange(10, 10, 10, 200)
	label_1:AppendText("\n\n1：NPCs will shake a little when they first appear in your view (Worry not all good)")
	label_1:AppendText("\n2：It feels like sometimes NPCs can't see you (Just set [Physics Simulation Method] to \"0\")")
	label_1:AppendText("\n3：NPCs' weapons don't follow their hands（Still all good）")
	label_1:AppendText("\n4：Console will show errors like \"Crazy origin on entity\"（All good all good ignore it）")
	label_1:AppendText("\n5：If using death addons other than [Enhanced Death Animation]，console will spit errors（Bear it）")



	local Language_Button = vgui.Create("DButton", window)
	Language_Button:SetPos(70, 60)
	Language_Button:SetSize(110, 30)
	Language_Button:SetText( "" )
	Language_Button:SetIcon("flags16/cn.png")
	Language_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(255, 51, 51, 235))
		draw.RoundedBox(5, 0, 0, w-4, h-4, Color(225, 225, 225, 255))
	end
	Language_Button.DoClick = function()
		Ragdollize_language_switch = 1 - Ragdollize_language_switch
		Ragdollize_Switch_Language_Update()
	end

	local Language_Button_txt_L = vgui.Create("DLabel", window)
	Language_Button_txt_L:SetPos(100, 65)
	Language_Button_txt_L:SetFont("Trebuchet18")
	Language_Button_txt_L:SetText("切换中文")
	Language_Button_txt_L:SetColor(Color(100, 100, 100, 255))
	Language_Button_txt_L:SizeToContents()


	function Ragdollize_Switch_Language_Update()
		if Ragdollize_language_switch == 1 then
			label_1:Remove()
			label_1= vgui.Create("RichText", window)
			label_1:SetPos(70, 120)
			label_1:SetSize(800, 800)
			label_1:InsertColorChange(235, 235, 235, 255)
			function label_1:PerformLayout()
				self:SetFontInternal("UpdateFont")
			end


			label_1:AppendText(" Sorry for interruption but there have been some HUUUGE Updates! ")
			
			
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\n\n\n01 -------------------------------------------------------------------------------------------------------01")
			
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\nCrazy Optimization")
			
			label_1:InsertColorChange(10, 10, 10, 200)
			label_1:AppendText("\n\nIt took a huge effort to optimize this mod for better performance")
			label_1:AppendText("\n\nIn short, if you are playing campaign maps with many NPCs, but they are scattered across the map,")
			label_1:AppendText("\nnot dozens of them gathered together. Then performance will be fine.")
			label_1:AppendText("\nHowever, if there are dozens of NPCs gathering in the same place in the map")
			label_1:AppendText("\nThen you may lag the sh*t out.")
			
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\n\n\n02 -------------------------------------------------------------------------------------------------------02")
			
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\nZombie Replacement Improvement")
			
			label_1:InsertColorChange(10, 10, 10, 200)
			label_1:AppendText("\n\nIf you are using [Zombies Model Replacement], And with a dismember addon like [Zippy's Gore Mod],")
			label_1:AppendText("\nAnd with [Physics Simulation Method] set to \"1\", (Which enables you to gib NPCs when they are alive)")
			label_1:AppendText("\nThen when you dismember a Zombie's leg, It will fall to the ground and become a Torso Zombie.")
			
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\n\n\n03 -------------------------------------------------------------------------------------------------------03")
			
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\nAddon Compatibility")
			
			label_1:InsertColorChange(10, 10, 10, 200)
			label_1:AppendText("\n\nStable compatibility with [Enhanced Death Animations] because I wrote it")
			label_1:AppendText("\nNo longer supports [Reagdoll] or [Fedhoria] because I can't change their code")

			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\n\n\n04 -------------------------------------------------------------------------------------------------------04")
		
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\nExpected Problems")
		
			label_1:InsertColorChange(10, 10, 10, 200)
			label_1:AppendText("\n\n1：NPCs will shake a little when they first appear in your view (Worry not all good)")
			label_1:AppendText("\n2：It feels like sometimes NPCs can't see you (Just set [Physics Simulation Method] to \"0\")")
			label_1:AppendText("\n3：NPCs' weapons don't follow their hands（Still all good）")
			label_1:AppendText("\n4：Console will show errors like \"Crazy origin on entity\"（All good all good ignore it）")
			label_1:AppendText("\n5：If using death addons other than [Enhanced Death Animation]，console will spit errors（Bear it）")
		
		else
			label_1:Remove()
			label_1= vgui.Create("RichText", window)
			label_1:SetPos(70, 120)
			label_1:SetSize(800, 800)
			label_1:InsertColorChange(235, 235, 235, 255)
			function label_1:PerformLayout()
				self:SetFontInternal("UpdateFont")
			end


			label_1:AppendText(" 有趣的更新，走过路过不要错过 ")
		
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\n\n\n01 -------------------------------------------------------------------------------------------------------01")
		
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\n大量的性能优化")
			
			label_1:InsertColorChange(10, 10, 10, 200)
			label_1:AppendText("\n\n真的很费很费功夫")
			label_1:AppendText("\n总而言之，要是你在玩一个战役类的地图，虽然有很多NPC，但他们都分散在地图各处，")
			label_1:AppendText("\n没有几十个扎堆，那游戏一般不会卡，如果卡，那基本是地图的问题.")
			label_1:AppendText("\n但要是地图里有几十个NPC在同一个地方扎堆的话")
			label_1:AppendText("\n电脑就该爆了")
		
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\n\n\n02 -------------------------------------------------------------------------------------------------------02")
		
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\n僵尸模型替换 功能增强")
		
			label_1:InsertColorChange(10, 10, 10, 200)
			label_1:AppendText("\n\n如果你使用了[僵尸模型替换]功能，并且开启了例如 [Zippy's Gore Mod] 之类的肢解模组")
			label_1:AppendText("\n并且将 [如何将NPC物理化] 这一选项设为了 \"1\" (设为 1 会让NPC能够在还活着的时候就被肢解)")
			label_1:AppendText("\n那么当你肢解一个僵尸的腿时,它就会倒在地上，然后变成一个爬着的半身僵尸")
		
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\n\n\n03 -------------------------------------------------------------------------------------------------------03")
		
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\n模组兼容性")
		
			label_1:InsertColorChange(10, 10, 10, 200)
			label_1:AppendText("\n\n美妙地兼容了 [Enhanced Death Animations] 因为是我写的")
			label_1:AppendText("\n不再支持 [Reagdoll] 或 [Fedhoria] 因为我改不了它们的代码")

			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\n\n\n04 -------------------------------------------------------------------------------------------------------04")
		
			label_1:InsertColorChange(10, 10, 10, 255)
			label_1:AppendText("\n预计会出现的问题/现象")
		
			label_1:InsertColorChange(10, 10, 10, 200)
			label_1:AppendText("\n\n1：当NPC刚出现在视野内的一瞬间会鬼畜一下（别怕一切正常）")
			label_1:AppendText("\n2：NPC有时候感觉像看不到你一样（把 [如何将NPC物理化] 这一选项设为 \"0\" 就好）")
			label_1:AppendText("\n3：NPC手里的武器不太跟手，有时会悬空（依旧一切正常）")
			label_1:AppendText("\n4：控制台会显示\"Crazy origin on entity\"一类的错误（还是一切正常，忽略它即可）")
			label_1:AppendText("\n5：要是用了除了[Enhanced Death Animation]之外的别的类似的死亡模组的话，\n控制台会吐错误（没办法的事）")
		end
	end

	Ragdollize_Switch_Language_Update()
end)


local function Ragdollize_Update_Detect()

	local update_file = file.Open("npc_physical_mod/UpdateInfo2.txt", "r", "DATA")

	if not update_file then
		file.Write("npc_physical_mod/UpdateInfo2.txt", "0")
		RunConsoleCommand("ragdollize_update_menu")
	end
end

Ragdollize_Update_Detect()