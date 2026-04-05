
local Title_Tb_ENG = {
	["A1"] = "Enable Physical NPC",
	["B1"] = "Extra Physics Functions",
	["B2"] = "Disable Physics Optimization",
	["C1"] = "Physics Simulation Method",
	["C2"] = "Realistic Damage",
	["C3"] = "Scale Damage",
	["C4"] = "Disable Ragdoll's Collision With Player",	
	["C5"] = "Disable Ragdoll's Collision With Everything",	
}

local Title_Tb_CHN = {
	["A1"] = "启用模组",
	["B1"] = "启用额外物理效果",
	["B2"] = "禁用物理系统优化",
	["C1"] = "如何将NPC物理化",
	["C2"] = "启用真实伤害系数",
	["C3"] = "伤害缩放",
	["C4"] = "禁用布娃娃与玩家的碰撞",
	["C5"] = "完全禁用布娃娃与所有物体的碰撞",
}


local Description_Tb_ENG = {
	["A1"] = "Enable the addon, Every newly spawned NPCs will be fully physical" ..
			 "\nThis option won't affect the function of [Combine/Citizen/Zombies Replacer], you can totally disable this option.",

	["B1"] = "Enable NPC's Falling detection (NPC will fall like a ragdoll when thrown off platform edge)" ..
			 "\nComes with a slightly performance cost" ..
			 "\nIf disabled, NPC won't have Falling detection, When they are thrown off a platform edge" .. 
			 "\nThey won't be able to fall like a ragdoll any more",

	["B2"] = "When there are too many Physical NPCs in one map, the game will lag like hell" ..
			 "\nSo this addon comes with a default physics optimization which will save your PC," ..
			 "\nBUT this optimization comes at some cost of physics simulation quality" ..
			 "\n\nIf there aren't too many NPCs in your map, then you can turn this on to disable optimization" ..
			 "\nThat will give you the best physics simulation quality",

	["C1"] = "There are two methods to make NPCs physical, each one has its unique feature" ..
			 "\n\nMethod 0 : " ..
			 "\nIt is for most scenarios, It only conflicts with Dismember addons like Zippy's Gore Mod" ..
			 "\n\nMethod 1: " ..
			 "\nA special method specially design for Dismember addons like Zippy's Gore Mod" ..
			 "\nIt allows you to Dismember NPCs even when they are alive" ..
			 "\ne.g -- If you Dismember a living NPC's arm, he will drop the weapon and try to escape." ..
			 "\nHowever, NPCs will sometimes can't see you from far" ..
			 "\n\nIn general, If you want to use Dismember addons, Switch this to \"1\", otherwise, leave it \"0\"",

	["C2"] = "Only works when \"Physics Simulation Method\" is set to \"1\" !!!!!!" ..
			 "\n\nWhen enabled, NPCs will hardly be killed if you just shoot them in the arms or legs" ..
			 "\nYou need to shoot them in the head or body in order to kill them" ..
			 "\nThis function works very satisfying with Dismember addons (Zippy's Gore Mod)",

	["C3"] = "Only works when \"Physics Simulation Method\" is set to \"1\" !!!!!!" ..
			 "\n\nJust multiply the damage the NPC receieve",

	["C4"] = "Disable ragdoll's collision with player",

	["C5"] = "Totally disable ragdoll's collision with anything, good for performance",

	["MR1"] = "This addon allows you to replace Combines/Citizens/Zombies with your own NPC model, or even, PM model !!" .. 
			 "\n\nHow to Use:" ..
			 "\n\nFirst, Click an icon to select a model (You can also change the BodyGroup, the NPCs will spawn with that BodyGroup setting)," .. 
			 "\nThen, Click \"ADD this model To Combine Replacement List\", then that model will be used to replace Combines when you spawn them " ..
			 "\nAfter this, spawn a Combine and it should work. Citizen/Zombies are also the same" ..
			 "\n\nAlso, you can click \"Save current Replacement Preset\" to save your preset, and Apply it by clicking \"Apply the chosen Replacement Preset\"",

	["MR2"] = "ADD       this model To Combine Replacement List",

	["MR3"] = "Remove  this model from Combine Replacement List",

	["MR4"] = "ADD       this model To Citizen Replacement List",

	["MR5"] = "Remove  this model from Citizen Replacement List",

	["MR6"] = "Enable Combine Model Replacement",

	["MR7"] = "Enable Citizen Model Replacement",

	["MR8"] = "Scale Skeleton to Fit Different NPC/PM Sizes",

	["MR9"] = "Apply the chosen Replacement Preset",

	["MR10"] = "Save current Replacement Preset",

	["MR11"] = "Delete the selected Preset",

	["MR12"] = "Type here to search for NPC/PM model by name ...",

	["MR13"] = "Enable Zombies Model Replacement",

	["MR14"] = "ADD       this model To Zombies Replacement List",

	["MR15"] = "Remove  this model from Zombies Replacement List",	

	["MR16"] = "Enable Headcrabs on head when spawn Zombies",
}

local Description_Tb_CHN = {
	["A1"] = "启用该模组，以后新刷出的每个NPC都将是物理化的NPC" .. 
			 "\n该选项不会影响该模组的 市民/联合军/僵尸 替换功能，你完全可以把这项关了",

	["B1"] = "启用NPC的坠落检测功能等（当NPC被扔出高台边缘时，其会像布娃娃一样坠落）" ..
			 "\n而代价是降低些许的游戏性能" ..
			 "\n如果禁用，则NPC将不再有坠落检测等功能，当其被推出高台边缘时，" ..
			 "\n不能再像布娃娃一样从边缘坠落",

	["B2"] = "当地图里的物理化NPC数量过多时，游戏会卡爆" ..
			 "\n因此，该模组自带了一个复杂的物理优化系统，大概能留你电脑一条命" ..
			 "\n但是该优化是以牺牲物理模拟的质量为代价的" ..
			 "\n\n如果地图里的NPC数量不算太多，你可以勾选这个框，以禁用优化系统" ..
			 "\n那样NPC就能拥有满血的物理模拟效果了",

	["C1"] = "编写了两种模式来让NPC物理化，两种模式各有神通" ..
			 "\n\n模式 0 : " ..
			 "\n适用于大多数情况，只不过不能和Zippy's Gore Mod之类的肢解模组兼容" ..
			 "\n\n模式 1: " ..
			 "\n专为Zippy's Gore Mod之类的肢解模组而编写的，" ..
			 "\n你甚至能在NPC还活着的时候肢解他们（真变态啊）" ..
			 "\n例如 -- 如果打断了一个NPC的手，ta便会丢下武器，尝试逃跑" ..
			 "\n代价是，NPC有时候会变瞎，不是很能看见你" ..
			 "\n\n总而言之言而总之，如果想用肢解模组，就将其设为 \"1\", 否则，设为 \"0\"",

	["C2"] = "在启用前必须将 \"如何将NPC物理化\" 一值设为 \"1\" !!!!!!" ..
			 "\n\n当启用时，如果只是射击手和腿的话，NPC将很难被杀死" ..
			 "\n你得向头和身体射击，才能有效杀死NPC" ..
			 "\n最佳食用方式是和 Zippy's Gore Mod 一类的肢解模组一起食用",

	["C3"] = "在启用前必须将 \"如何将NPC物理化\" 一值设为 \"1\" !!!!!!" ..
			 "\n\n就是缩放一下NPC受到的伤害而已",

	["C4"] = "禁用掉布娃娃与玩家间的碰撞",

	["C5"] = "完全禁用掉布娃娃与所有物体之间的碰撞，有助于优化性能",

	["MR1"] = "该模组还能让你用自己的NPC甚至是PM模型来替换 联合军/市民/僵尸 的模型，而不会出现其它替换模组中经常出现的肢体拉伸、摆T字等问题" ..
			 "\n\n如何使用：" ..
			 "\n\n很简单，点击图标选择一个NPC/玩家模型（你还可以预设该模型的身体组件，这样 NPC 在刷出来时各个身体组件就会使用该预设）" ..
			 "\n接着，点击\"将此模型加入 [联合军] 的模型替换列表\"按钮，那么当你刷出联合军时，其模型就将被替换为该模型，同时各种动画、AI保持不变" ..
			 "\n接着你就可以刷一个联合军出来看看效果了。 市民/僵尸同理" ..
			 "\n\n此外，通过点击\"保存当前的替换预设\"，你还可以保存当前的替换列表为一个预设。而要应用一个预设，则选中它，点击\"应用当前选中的预设\"按钮", 

	["MR2"] = "将此模型加入 [联合军] 的模型替换列表",

	["MR3"] = "将此模型移出 [联合军] 的模型替换列表",

	["MR4"] = "将此模型加入  [市民]  的模型替换列表",

	["MR5"] = "将此模型移出  [市民]  的模型替换列表",

	["MR6"] = "启用 联合军模型替换",

	["MR7"] = "启用 市民模型替换",

	["MR8"] = "缩放骨骼以适应各种不同尺寸的 NPC/PM 模型",

	["MR9"] = "应用当前选中的预设",

	["MR10"] = "保存当前的替换预设",

	["MR11"] = "删除选中的预设",

	["MR12"] = "输入PM/NPC模型的名称来筛选",

	["MR13"] = "启用 僵尸模型替换",

	["MR14"] = "将此模型加入  [僵尸]  的模型替换列表",

	["MR15"] = "将此模型移出  [僵尸]  的模型替换列表",

	["MR16"] = "刷出僵尸模型时，开启其头上的猎头蟹",
}

Ragdollize_language_switch = 1
if string.lower(GetConVarString("gmod_language")) == "zh-cn" then
	Ragdollize_language_switch = 0
end

local Title_Tb = Title_Tb_ENG
local Description_Tb = Description_Tb_ENG
local Model_Combien_List = {}
local Model_Citizen_List = {}


local function Ragdollize_Menu_Frame(window, x, y, size_x, size_y)
	---------------------------
	local frame = vgui.Create("DPanel", window)
	frame:SetPos(x, y)
	frame:SetSize(size_x, size_y)
	frame.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(150, 150, 150, 255))
		draw.RoundedBox(10, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
	end

	return frame
end


local function Ragdollize_Menu_Checkbox(window, Title, Description, Convar, x, y)
	---------------------------
	local Check = vgui.Create("DCheckBox", window)
	Check:SetPos(x+216, y)
	Check:SetConVar(Convar)

	local Check_txt_L = vgui.Create("DLabel", window)
	Check_txt_L:SetPos(x, y)
	if Title_Tb == Title_Tb_ENG then
		Check_txt_L:SetFont("TargetIDSmall")
	else
		Check_txt_L:SetFont("Trebuchet18")
	end
	Check_txt_L:SetText(Title)
	Check_txt_L:SetColor(Color(100, 100, 100, 255))
	Check_txt_L:SizeToContents()

	local Check_txt_S = vgui.Create("DLabel", window)
	Check_txt_S:SetPos(x, y+25)
	Check_txt_S:SetFont("DefaultSmall")
	Check_txt_S:SetText(Description)
	Check_txt_S:SetColor(Color(100, 100, 100, 200))
	Check_txt_S:SizeToContents()

	return Check, Check_txt_L, Check_txt_S
end


local function Ragdollize_Menu_Checkbox_Far(window, Title, Description, Convar, x, y)
	---------------------------
	local Check = vgui.Create("DCheckBox", window)
	Check:SetPos(x+300, y)
	Check:SetConVar(Convar)

	local Check_txt_L = vgui.Create("DLabel", window)
	Check_txt_L:SetPos(x, y)
	if Title_Tb == Title_Tb_ENG then
		Check_txt_L:SetFont("TargetIDSmall")
	else
		Check_txt_L:SetFont("Trebuchet18")
	end
	Check_txt_L:SetText(Title)
	Check_txt_L:SetColor(Color(100, 100, 100, 255))
	Check_txt_L:SizeToContents()

	local Check_txt_S = vgui.Create("DLabel", window)
	Check_txt_S:SetPos(x, y+25)
	Check_txt_S:SetFont("DefaultSmall")
	Check_txt_S:SetText(Description)
	Check_txt_S:SetColor(Color(100, 100, 100, 200))
	Check_txt_S:SizeToContents()

	return Check, Check_txt_L, Check_txt_S
end


local function Ragdollize_Menu_Slider(window, Title, Description, Convar, x, y, round, min, max, Decimal)
	---------------------------
	local Slider_back = vgui.Create("DPanel", window)
	Slider_back:SetPos(x+216, y)
	Slider_back:SetSize(250, 15)
	Slider_back:SetBackgroundColor(Color(100, 100, 100, 150))

	local Slider_Num = vgui.Create("DNumSlider", window)
	Slider_Num:SetPos(x+101, y-3)
	Slider_Num:SetSize(365, 20)
	Slider_Num:SetMin(min)
	Slider_Num:SetMax(max)
	Slider_Num:SetDecimals(Decimal)
	Slider_Num:SetConVar(Convar)
	Slider_Num.OnValueChanged = function(self, value)
		if round then
			self:SetValue(math.Round(value))
		end
	end

	local Slider_txt_L = vgui.Create("DLabel", window)
	Slider_txt_L:SetPos(x, y)
	if Title_Tb == Title_Tb_ENG then
		Slider_txt_L:SetFont("TargetIDSmall")
	else
		Slider_txt_L:SetFont("Trebuchet18")
	end
	Slider_txt_L:SetText(Title)
	Slider_txt_L:SetColor(Color(100, 100, 100, 255))
	Slider_txt_L:SizeToContents()

	local Slider_txt_S = vgui.Create("DLabel", window)
	Slider_txt_S:SetPos(x, y+25)
	Slider_txt_S:SetFont("DefaultSmall")
	Slider_txt_S:SetText(Description)
	Slider_txt_S:SetColor(Color(100, 100, 100, 200))
	Slider_txt_S:SizeToContents()

	return Slider_Num, Slider_txt_L, Slider_txt_S
end


concommand.Add( "ragdollize_panel", function()

	local window = vgui.Create("DFrame")
	window:SetSize(1300, 800)
	window:Center()
	window:SetTitle("")
	window:SetDraggable(true)
	window:MakePopup()

	window.Paint = function(self, w, h)
		draw.RoundedBox(20, 0, 0, w, h, Color(10, 10, 10, 255))
		draw.RoundedBox(20, 0, 0, w-6, h-6, Color(235, 235, 235, 255))
		draw.SimpleText("ControL", "DermaLarge", 625, 5, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end

	local label_1 = vgui.Create("DLabel", window)
	label_1:SetPos(525, 50)
	label_1:SetFont("CreditsOutroText")
	label_1:SetText("Below are wired commands availablE")
	label_1:SetColor(Color(100, 100, 100, 100))
	label_1:SizeToContents()	


	local frame_1 = Ragdollize_Menu_Frame(window, 60, 85, 580*2+20, 100)
	local frame_2 = Ragdollize_Menu_Frame(window, 60, 185, 580*2+20, 150)
	local frame_3 = Ragdollize_Menu_Frame(window, 60, 335, 580*2+20, 425)
	
	local x_left = 45
	local x_right = x_left+580-45

	local A1, A1_txt_L, A1_txt_S = Ragdollize_Menu_Checkbox(frame_1, Title_Tb["A1"], Description_Tb["A1"], "ragdollize_enable", x_left, 15)
	
	local B1, B1_txt_L, B1_txt_S = Ragdollize_Menu_Checkbox(frame_2, Title_Tb["B1"], Description_Tb["B1"], "ragdollize_detail", x_left, 15)
	local B2, B2_txt_L, B2_txt_S = Ragdollize_Menu_Checkbox(frame_2, Title_Tb["B2"], Description_Tb["B2"], "ragdollize_noopti", x_right, 15)

	local C1, C1_txt_L, C1_txt_S =   Ragdollize_Menu_Slider(frame_3, Title_Tb["C1"], Description_Tb["C1"], "ragdollize_altdmg", x_left, 15, true, 0, 1, 0)
	local C2, C2_txt_L, C2_txt_S = Ragdollize_Menu_Checkbox(frame_3, Title_Tb["C2"], Description_Tb["C2"], "ragdollize_dmgreal", x_left, 225)
	local C3, C3_txt_L, C3_txt_S =   Ragdollize_Menu_Slider(frame_3, Title_Tb["C3"], Description_Tb["C3"], "ragdollize_dmgmulti", x_left, 340, false, 0, 10, 2)
	local C4, C4_txt_L, C4_txt_S = Ragdollize_Menu_Checkbox_Far(frame_3, Title_Tb["C4"], Description_Tb["C4"], "ragdollize_nocollide_ply", x_right, 15)
	local C5, C5_txt_L, C5_txt_S = Ragdollize_Menu_Checkbox_Far(frame_3, Title_Tb["C5"], Description_Tb["C5"], "ragdollize_nocollide_all", x_right, 80)


	local Language_Button = vgui.Create("DButton", window)
	Language_Button:SetPos(60, 55)
	Language_Button:SetSize(60, 30)
	Language_Button:SetText( "" )
	Language_Button:SetIcon("flags16/gb.png")
	Language_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(255, 51, 51, 235))
		draw.RoundedBox(5, 0, 0, w-10, h-4, Color(225, 225, 225, 255))
	end
	Language_Button.DoClick = function()
		Ragdollize_language_switch = 1 - Ragdollize_language_switch
		Ragdollize_Switch_Language_1()
	end

	local Language_Button_txt_L = vgui.Create("DLabel", window)
	Language_Button_txt_L:SetPos(90, 60)
	Language_Button_txt_L:SetFont("Trebuchet18")
	Language_Button_txt_L:SetText("文")
	Language_Button_txt_L:SetColor(Color(100, 100, 100, 255))
	Language_Button_txt_L:SizeToContents()


	function Ragdollize_Switch_Language_1()
		if Ragdollize_language_switch == 1 then

			Title_Tb = Title_Tb_ENG
			Description_Tb = Description_Tb_ENG
			Language_Button:SetIcon("flags16/gb.png")

			label_1:SetText("Below are wired commands availablE")
			label_1:SizeToContents()

			A1_txt_L:SetText(Title_Tb["A1"])
			B1_txt_L:SetText(Title_Tb["B1"])
			B2_txt_L:SetText(Title_Tb["B2"])
			C1_txt_L:SetText(Title_Tb["C1"])
			C2_txt_L:SetText(Title_Tb["C2"])
			C3_txt_L:SetText(Title_Tb["C3"])
			C4_txt_L:SetText(Title_Tb["C4"])
			C5_txt_L:SetText(Title_Tb["C5"])

			A1_txt_S:SetText(Description_Tb["A1"])
			B1_txt_S:SetText(Description_Tb["B1"])
			B2_txt_S:SetText(Description_Tb["B2"])
			C1_txt_S:SetText(Description_Tb["C1"])
			C2_txt_S:SetText(Description_Tb["C2"])
			C3_txt_S:SetText(Description_Tb["C3"])
			C4_txt_S:SetText(Description_Tb["C4"])
			C5_txt_S:SetText(Description_Tb["C5"])

			A1_txt_L:SetFont("TargetIDSmall")
			B1_txt_L:SetFont("TargetIDSmall")
			B2_txt_L:SetFont("TargetIDSmall")
			C1_txt_L:SetFont("TargetIDSmall")
			C2_txt_L:SetFont("TargetIDSmall")
			C3_txt_L:SetFont("TargetIDSmall")
			C4_txt_L:SetFont("TargetIDSmall")
			C5_txt_L:SetFont("TargetIDSmall")

			A1_txt_L:SizeToContents()
			A1_txt_S:SizeToContents()
			B1_txt_L:SizeToContents()
			B1_txt_S:SizeToContents()
			B2_txt_L:SizeToContents()
			B2_txt_S:SizeToContents()
			C1_txt_L:SizeToContents()
			C1_txt_S:SizeToContents()
			C2_txt_L:SizeToContents()
			C2_txt_S:SizeToContents()
			C3_txt_L:SizeToContents()
			C3_txt_S:SizeToContents()
			C4_txt_L:SizeToContents()
			C4_txt_S:SizeToContents()
			C5_txt_L:SizeToContents()
			C5_txt_S:SizeToContents()

		else

			Title_Tb = Title_Tb_CHN
			Description_Tb = Description_Tb_CHN
			Language_Button:SetIcon("flags16/cn.png")

			label_1:SetText("以下是一些可能有用的乱七八糟的东西")
			label_1:SizeToContents()

			A1_txt_L:SetText(Title_Tb["A1"])
			B1_txt_L:SetText(Title_Tb["B1"])
			B2_txt_L:SetText(Title_Tb["B2"])
			C1_txt_L:SetText(Title_Tb["C1"])
			C2_txt_L:SetText(Title_Tb["C2"])
			C3_txt_L:SetText(Title_Tb["C3"])
			C4_txt_L:SetText(Title_Tb["C4"])
			C5_txt_L:SetText(Title_Tb["C5"])

			A1_txt_S:SetText(Description_Tb["A1"])
			B1_txt_S:SetText(Description_Tb["B1"])
			B2_txt_S:SetText(Description_Tb["B2"])
			C1_txt_S:SetText(Description_Tb["C1"])
			C2_txt_S:SetText(Description_Tb["C2"])
			C3_txt_S:SetText(Description_Tb["C3"])
			C4_txt_S:SetText(Description_Tb["C4"])
			C5_txt_S:SetText(Description_Tb["C5"])

			A1_txt_L:SetFont("Trebuchet18")
			B1_txt_L:SetFont("Trebuchet18")
			B2_txt_L:SetFont("Trebuchet18")
			C1_txt_L:SetFont("Trebuchet18")
			C2_txt_L:SetFont("Trebuchet18")
			C3_txt_L:SetFont("Trebuchet18")
			C4_txt_L:SetFont("Trebuchet18")
			C5_txt_L:SetFont("Trebuchet18")

			A1_txt_L:SizeToContents()
			A1_txt_S:SizeToContents()
			B1_txt_L:SizeToContents()
			B1_txt_S:SizeToContents()
			B2_txt_L:SizeToContents()
			B2_txt_S:SizeToContents()
			C1_txt_L:SizeToContents()
			C1_txt_S:SizeToContents()
			C2_txt_L:SizeToContents()
			C2_txt_S:SizeToContents()
			C3_txt_L:SizeToContents()
			C3_txt_S:SizeToContents()
			C4_txt_L:SizeToContents()
			C4_txt_S:SizeToContents()
			C5_txt_L:SizeToContents()
			C5_txt_S:SizeToContents()
		end
	end

	Ragdollize_Switch_Language_1()
end)



----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
--初始化文件
file.CreateDir("npc_physical_mod")

local combineTb_file = file.Open("npc_physical_mod/combine_table.txt", "r", "DATA")
local citizenTb_file = file.Open("npc_physical_mod/citizen_table.txt", "r", "DATA")
local zombiesTb_file = file.Open("npc_physical_mod/zombies_table.txt", "r", "DATA")
local presetsTb_file = file.Open("npc_physical_mod/presets_table.txt", "r", "DATA")

local combineTb = {}
local citizenTb = {}
local zombiesTb = {}
local presetsTb = {}
local chosenPreset = nil --在Presets of Replacement List一栏中当前选中的预设，为了方便操作我直接把这个chosenPreset放这了

--初始化 combineTb, citizenTb, zombiesTb, presetsTb
if combineTb_file then
	combineTb = util.JSONToTable( file.Read("npc_physical_mod/combine_table.txt", "DATA") )
	if not combineTb then
		combineTb = {}
	end
else
	combineTb = {}
	file.Write("npc_physical_mod/combine_table.txt", "[]")
end

if citizenTb_file then
	citizenTb = util.JSONToTable( file.Read("npc_physical_mod/citizen_table.txt", "DATA") )
	if not citizenTb then
		citizenTb = {}
	end
else
	citizenTb = {}
	file.Write("npc_physical_mod/citizen_table.txt", "[]")
end

if zombiesTb_file then
	zombiesTb = util.JSONToTable( file.Read("npc_physical_mod/zombies_table.txt", "DATA") )
	if not zombiesTb then
		zombiesTb = {}
	end
else
	zombiesTb = {}
	file.Write("npc_physical_mod/zombies_table.txt", "[]")
end

if presetsTb_file then
	presetsTb = util.JSONToTable( file.Read("npc_physical_mod/presets_table.txt", "DATA") )
	if not presetsTb then
		presetsTb = {}
	end
else
	presetsTb = {}
	file.Write("npc_physical_mod/presets_table.txt", "[]")
end


----------------------------------------------------------------------------------------
--在Model Preview里随机播放动画
local function Random_Sequence(mdl)
	local seq = nil
	local ACT = {
		ACT_IDLE,
		ACT_WALK,
		ACT_RUN,
		ACT_RELOAD,
	}

	-- Fisher-Yates 洗牌算法
	for i = #ACT, 2, -1 do
		local j = math.random(i)
		ACT[i], ACT[j] = ACT[j], ACT[i]
	end

	for seqID, _ in pairs(mdl:GetSequenceList()) do
		if mdl:GetSequenceInfo(seqID).activity == ACT[1] then
			seq = seqID
			break
		end
	end

	if seq then
		mdl:SetSequence(seq)
	else
		mdl:SetSequence("walk_all")
	end
end


----------------------------------------------------------------------------------------
--更新模型的BodyGroups列表与滑块
local function Rebuild_BodyGroup(ScrollPanel, Selected_Model)
	ScrollPanel:Clear()

	--得到有效的bg，从而显示出来，同时将这些bg值全归零
	--这个函数只在两个地方被调用：在左侧的模型图标栏里选择模型时；在右侧的 combineTb/citizenTb/zombiesTb 列表里选择模型时
	--前者在SetModel后需要让bg值全为0，而后者在让bg值全归零后，还要再根据 combineTb/citizenTb/zombiesTb 中的数据重新设置bg值
	local validBodygroups = {}
	for k, bodygroup in pairs(Selected_Model:GetBodyGroups()) do
		if bodygroup.num > 1 then
			table.insert(validBodygroups, bodygroup)
			Selected_Model:SetBodygroup(bodygroup.id, 0)
		end
	end

	--创建bodygroup列表
	for k, bodygroup in pairs(validBodygroups) do
		--创建左侧的 bodygroup 名称标签
		local label = ScrollPanel:Add("DLabel")
		label:SetPos(5, (k-1)*40+15)
		label:SetFont("CreditsOutroText")
		label:SetText(bodygroup.name)
		label:SetColor(Color(50, 50, 50, 255))
		label:SizeToContents()
		
		--创建右侧的 DNumSlider
		local slider = ScrollPanel:Add("DNumSlider")
		slider:SetPos(-110, (k-1)*40+35)
		slider:SetSize(270, 10)
		slider:SetDark(true)
		slider:SetMin(0)
		slider:SetMax(bodygroup.num-1)
		slider:SetDecimals(0)
		slider:SetValue(0)
		--间隔0.1秒后，根据bg值重设各滑块值（因为在Chanage_Model函数中，会先调用该函数，再根据 combineTb/citizenTb/zombiesTb 中的数据重新设置bg值，因此在Chanage_Model重设bg值后，要将slider中的各bg值也一起更新一下）
		timer.Simple(0.1, function()
			if Selected_Model:GetBodygroup(bodygroup.id) > 0 then
				slider:SetValue(Selected_Model:GetBodygroup(bodygroup.id))
			end
		end)
		
		--当滑块值改变时，更新 bodygroup 的值
		slider.OnValueChanged = function(self, value)
			self:SetValue(math.Round(value))
		    Selected_Model:SetBodygroup(bodygroup.id, math.Round(value))
		end
	end
end


----------------------------------------------------------------------------------------
--重建Model Preview
local function Chanage_Model(data, Elements)
	Elements.Selected_Model:SetModel(data.Model)
	Rebuild_BodyGroup(Elements.Model_BodyGroup_ScrollPanel, Elements.Selected_Model)
	if data.validBodygroups then
		for bgName, bgValue in pairs(data.validBodygroups) do
			local bgID = Elements.Selected_Model:FindBodygroupByName(bgName)
			Elements.Selected_Model:SetBodygroup(bgID, bgValue)
		end
	end
	Random_Sequence(Elements.Selected_Model)
	Elements.Selected_Model.label = data.Name
	Elements.Model_Preview_txt:SetText(Elements.Selected_Model.label)
	Elements.Model_Preview_txt:SizeToContents()
end


----------------------------------------------------------------------------------------
--重建DListView
local function Rebuild_List(List, Tb, Elements)

	--删除所有行
	for k, v in pairs(List:GetLines()) do
		List:RemoveLine(k)
	end

	--整理Tb中的内容
	table.sort(Tb, function(a, b) 
		return string.lower(a.Name) < string.lower(b.Name)
	end)

	--根据Tb（combineTb/citizenTb/zombiesTb）中的内容重建所有行
	for _, data in pairs(Tb) do
		local line = List:AddLine(data.Name)

		--选中line时，设置模型
		line.OnSelect = function()
			Chanage_Model(data, Elements)
		end
	end
end


----------------------------------------------------------------------------------------
--重建DListView（Preset专用）
local function Rebuild_List_Preset(List)

	--删除所有行
	for k, v in pairs(List:GetLines()) do
		List:RemoveLine(k)
	end

	--整理Tb中的内容
	table.sort(presetsTb, function(a, b) 
		return string.lower(a.PresetName) < string.lower(b.PresetName)
	end)

	--根据Tb中的内容重建所有行
	for _, preset in pairs(presetsTb) do
		local line = List:AddLine(preset.PresetName)

		--选中line时，设置模型
		line.OnSelect = function()

			--有个小bug，这里需要从文件重置一下presetsTb
			local presetsTb_file = file.Open("npc_physical_mod/presets_table.txt", "r", "DATA")
			if presetsTb_file then
				presetsTb = util.JSONToTable( file.Read("npc_physical_mod/presets_table.txt", "DATA") )
				if not presetsTb then
					presetsTb = {}
				end
			else
				presetsTb = {}
				file.Write("npc_physical_mod/presets_table.txt", "")
			end

			--在重置后的presetsTb里找到对应的数据，写入chosenPreset
			for _, preset2 in pairs(presetsTb) do
				if preset.PresetName == preset2.PresetName then
					chosenPreset = preset2
					break
				end
			end
		end
	end
end


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
concommand.Add( "ragdollize_replace_panel", function()

	local window = vgui.Create("DFrame")
	window:SetSize(1400, 850)
	window:Center()
	window:SetTitle("")
	window:SetDraggable(true)
	window:MakePopup()

	window.Paint = function(self, w, h)
		draw.RoundedBox(20, 0, 0, w, h, Color(10, 10, 10, 255))
		draw.RoundedBox(20, 0, 0, w-6, h-6, Color(235, 235, 235, 255))
		draw.SimpleText("Combine/Citizen/Zombie Replacer", "DermaLarge", 700, 5, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end


	local all_model_list_NPC = {}
	local all_model_list_PM = {}

	for _, npcData in pairs(list.Get("NPC")) do
		if npcData.Model then
			table.insert(all_model_list_NPC, npcData)
		end
	end

	for pmName, pmModel in pairs(player_manager.AllValidModels()) do
		local pmData = {}
		pmData.Model = pmModel
		pmData.Name = pmName
		table.insert(all_model_list_PM, pmData) 
	end

	table.sort(all_model_list_NPC, function(a, b) 
		if a.Name and b.Name then
			return string.lower(a.Name) < string.lower(b.Name)
		end
	end)

	table.sort(all_model_list_PM, function(a, b) 
		if a.Name and b.Name then
			return string.lower(a.Name) < string.lower(b.Name) 
		end
	end)


	local label_1 = vgui.Create("DLabel", window)
	label_1:SetPos(460, 50)
	label_1:SetFont("CreditsOutroText")
	label_1:SetText("You can use your own NPC or even PM models to replace Combines/Citizens/Zombies")
	label_1:SetColor(Color(100, 100, 100, 100))
	label_1:SizeToContents()	


	local frame_1 = Ragdollize_Menu_Frame(window, 45, 85, 1280, 150)
	local frame_2 = Ragdollize_Menu_Frame(window, 45, 235, 1280, 570)


	local Description_txt_S = vgui.Create("DLabel", frame_1)
	Description_txt_S:SetPos(35, 10)
	Description_txt_S:SetFont("DefaultSmall")
	Description_txt_S:SetText(Description_Tb["MR1"])
	Description_txt_S:SetColor(Color(100, 100, 100, 250))
	Description_txt_S:SizeToContents()


	---------------------------
	--启用联合军替换功能
	local Replace_Combine_Check = vgui.Create("DCheckBox", frame_1)
	Replace_Combine_Check:SetPos(820, 10)
	Replace_Combine_Check:SetConVar("ragdollize_replacecombine")

	local Replace_Combine_Check_txt_L = vgui.Create("DLabel", frame_1)
	Replace_Combine_Check_txt_L:SetPos(845, 10)
	if Title_Tb == Title_Tb_ENG then
		Replace_Combine_Check_txt_L:SetFont("TargetIDSmall")
	else
		Replace_Combine_Check_txt_L:SetFont("Trebuchet18")
	end
	Replace_Combine_Check_txt_L:SetText(Description_Tb["MR6"])
	Replace_Combine_Check_txt_L:SetColor(Color(100, 100, 100, 255))
	Replace_Combine_Check_txt_L:SizeToContents()


	---------------------------
	--启用市民替换功能
	local Replace_Citizen_Check = vgui.Create("DCheckBox", frame_1)
	Replace_Citizen_Check:SetPos(820, 30)
	Replace_Citizen_Check:SetConVar("ragdollize_replacecitizen")

	local Replace_Citizen_Check_txt_L = vgui.Create("DLabel", frame_1)
	Replace_Citizen_Check_txt_L:SetPos(845, 30)
	if Title_Tb == Title_Tb_ENG then
		Replace_Citizen_Check_txt_L:SetFont("TargetIDSmall")
	else
		Replace_Citizen_Check_txt_L:SetFont("Trebuchet18")
	end
	Replace_Citizen_Check_txt_L:SetText(Description_Tb["MR7"])
	Replace_Citizen_Check_txt_L:SetColor(Color(100, 100, 100, 255))
	Replace_Citizen_Check_txt_L:SizeToContents()


	---------------------------
	--启用僵尸替换功能
	local Replace_Zombies_Check = vgui.Create("DCheckBox", frame_1)
	Replace_Zombies_Check:SetPos(820, 50)
	Replace_Zombies_Check:SetConVar("ragdollize_replacezombies")

	local Replace_Zombies_Check_txt_L = vgui.Create("DLabel", frame_1)
	Replace_Zombies_Check_txt_L:SetPos(845, 50)
	if Title_Tb == Title_Tb_ENG then
		Replace_Zombies_Check_txt_L:SetFont("TargetIDSmall")
	else
		Replace_Zombies_Check_txt_L:SetFont("Trebuchet18")
	end
	Replace_Zombies_Check_txt_L:SetText(Description_Tb["MR13"])
	Replace_Zombies_Check_txt_L:SetColor(Color(100, 100, 100, 255))
	Replace_Zombies_Check_txt_L:SizeToContents()

	---------------------------
	--启用僵尸猎头蟹功能
	local Replace_Headcrab_Check = vgui.Create("DCheckBox", frame_1)
	Replace_Headcrab_Check:SetPos(820, 70)
	Replace_Headcrab_Check:SetConVar("ragdollize_enableheadcrab")
	function Replace_Headcrab_Check:OnChange(bVal)
		if Replace_Headcrab_Check:IsEditing() and (bVal) then
			local window2 = vgui.Create("DFrame")
			window2:SetSize(800, 100)
			window2:Center()
			window2:SetTitle("")
			window2:SetDraggable(true)
			window2:MakePopup()
	
			local label_2 = vgui.Create("DLabel", window2)
			label_2:Dock(FILL)
			label_2:SetFont("CreditsOutroText")
			label_2:SetText("This option doesn't work on Fast Zombies, Because of their ... wired bone structures" ..
							"\n\n此功能不对 快速僵尸 起作用，因为那些玩意的骨骼太扭曲了，看起来很怪")
			label_2:SetColor(Color(200, 200, 200, 255))
			label_2:SizeToContents()
		end
	end

	local Replace_Headcrab_Check_txt_L = vgui.Create("DLabel", frame_1)
	Replace_Headcrab_Check_txt_L:SetPos(845, 70)
	if Title_Tb == Title_Tb_ENG then
		Replace_Headcrab_Check_txt_L:SetFont("TargetIDSmall")
	else
		Replace_Headcrab_Check_txt_L:SetFont("Trebuchet18")
	end
	Replace_Headcrab_Check_txt_L:SetText(Description_Tb["MR16"])
	Replace_Headcrab_Check_txt_L:SetColor(Color(100, 100, 100, 255))
	Replace_Headcrab_Check_txt_L:SizeToContents()

	---------------------------
	--启用模型缩放功能
	local Replace_Scale_Check = vgui.Create("DCheckBox", frame_1)
	Replace_Scale_Check:SetPos(820, 90)
	Replace_Scale_Check:SetConVar("ragdollize_scalemodel")
	function Replace_Scale_Check:OnChange(bVal)
		if Replace_Scale_Check:IsEditing() and (bVal) then
			local window2 = vgui.Create("DFrame")
			window2:SetSize(800, 100)
			window2:Center()
			window2:SetTitle("")
			window2:SetDraggable(true)
			window2:MakePopup()
	
			local label_2 = vgui.Create("DLabel", window2)
			label_2:Dock(FILL)
			label_2:SetFont("CreditsOutroText")
			label_2:SetText("You may want to turn this on if you are using a unusually Tiny/Large NPC model to replace Combine/Citizen" ..
							"\nTo some models it works good, to some models it works terribly, keep that in mind" ..
							"\n当你在用一些身体特别大/特别小的模型来替换联合军/市民时，可以开启该功能" ..
							"\n对于有些NPC/PM模型这功能很不错，对于有些NPC/PM模型这功能很糟糕，谨慎使用")
			label_2:SetColor(Color(200, 200, 200, 255))
			label_2:SizeToContents()
		end
	end

	local Replace_Scale_Check_txt_L = vgui.Create("DLabel", frame_1)
	Replace_Scale_Check_txt_L:SetPos(845, 90)
	if Title_Tb == Title_Tb_ENG then
		Replace_Scale_Check_txt_L:SetFont("TargetIDSmall")
	else
		Replace_Scale_Check_txt_L:SetFont("Trebuchet18")
	end
	Replace_Scale_Check_txt_L:SetText(Description_Tb["MR8"])
	Replace_Scale_Check_txt_L:SetColor(Color(100, 100, 100, 255))
	Replace_Scale_Check_txt_L:SizeToContents()


	---------------------------
	--模型面板
	local Model_Preview = vgui.Create("DAdjustableModelPanel", frame_2)
	Model_Preview:SetPos(630, 20)
	Model_Preview:SetSize(170, 290)
	Model_Preview:SetModel("models/combine_soldier.mdl")
	Model_Preview:SetLookAng( Angle( 0, 180, 0 ) )
	Model_Preview:SetCamPos( Vector( 150, 0, 35 ) )
	Model_Preview:SetFOV(18)
	function Model_Preview:LayoutEntity(ent)
		ent:SetAngles(Angle(0, 0, 0)) 
		ent:FrameAdvance( FrameTime() ) 
		Model_Preview:RunAnimation()
	end
	local Selected_Model = Model_Preview:GetEntity()
	Random_Sequence(Selected_Model)
	Selected_Model.label = ""

	local Model_Preview_txt = vgui.Create("DLabel", frame_2)
	Model_Preview_txt:SetPos(630, 300)
	Model_Preview_txt:SetFont("Default")
	Model_Preview_txt:SetText(Selected_Model.label)
	Model_Preview_txt:SetColor(Color(100, 100, 100, 250))
	Model_Preview_txt:SizeToContents()


	---------------------------
	--BodyGroup面板
	local Model_BodyGroup_Panel = vgui.Create("DPanel", frame_2)
	Model_BodyGroup_Panel:SetPos(820, 5)
	Model_BodyGroup_Panel:SetSize(185, 310)
	Model_BodyGroup_Panel.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(50, 50, 50, 255))
		draw.RoundedBox(10, 1, 1, w-2, h-2, Color(200, 200, 200, 255))
		draw.SimpleText("Set BodyGroup", "Default", w/2, 5, Color(50, 50, 50, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end

	local Model_BodyGroup_ScrollPanel = vgui.Create("DScrollPanel", Model_BodyGroup_Panel)
	Model_BodyGroup_ScrollPanel:SetPos(10, 10)
	Model_BodyGroup_ScrollPanel:SetSize(165, 280)

	Rebuild_BodyGroup(Model_BodyGroup_ScrollPanel, Selected_Model)


	---------------------------
	--DListView中所需的所有与模型面板有关的参数
	Elements = {}
	Elements.all_model_list_NPC = all_model_list_NPC
	Elements.all_model_list_PM = all_model_list_PM
	Elements.Selected_Model = Selected_Model
	Elements.Model_Preview_txt = Model_Preview_txt
	Elements.Model_BodyGroup_ScrollPanel = Model_BodyGroup_ScrollPanel


	---------------------------
	--NPC模型图标
	local Model_NPC_Panel_title = vgui.Create("DPanel", frame_2)
	Model_NPC_Panel_title:SetPos(10, 45)
	Model_NPC_Panel_title:SetSize(290, 35)	
	Model_NPC_Panel_title.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
		draw.SimpleText("All NPC Models", "TargetID", 145, 5, Color(100, 100, 100, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end

	local Model_NPC_Panel = vgui.Create("DPanel", frame_2)
	Model_NPC_Panel:SetPos(10, 90)
	Model_NPC_Panel:SetSize(290, 440)	
	Model_NPC_Panel.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
	end	

	local Model_NPC_Scroll = vgui.Create("DScrollPanel", Model_NPC_Panel) 
	Model_NPC_Scroll:Dock(FILL)

	local Model_NPC_Icon = vgui.Create("DIconLayout", Model_NPC_Scroll) 
	Model_NPC_Icon:Dock(FILL) 
	Model_NPC_Icon:SetSpaceY(5) 
	Model_NPC_Icon:SetSpaceX(5)
	for _, npcData in pairs(all_model_list_NPC) do
		local icon = vgui.Create("SpawnIcon", Model_NPC_Icon) 
		icon:SetModel(npcData.Model) 
		icon:SetToolTip(npcData.Name)
		icon.DoClick = function() 
			Selected_Model:SetModel(npcData.Model)
			Random_Sequence(Selected_Model)
			Selected_Model.label = npcData.Name
			Model_Preview_txt:SetText(Selected_Model.label)
			Model_Preview_txt:SizeToContents()
			Rebuild_BodyGroup(Model_BodyGroup_ScrollPanel, Selected_Model)
		end
	end


	---------------------------
	--PM模型图标
	local Model_PM_Panel_title = vgui.Create("DPanel", frame_2)
	Model_PM_Panel_title:SetPos(320, 45)
	Model_PM_Panel_title:SetSize(290, 35)	
	Model_PM_Panel_title.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
		draw.SimpleText("All Player Models", "TargetID", 145, 5, Color(100, 100, 100, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end		

	local Model_PM_Panel = vgui.Create("DPanel", frame_2)
	Model_PM_Panel:SetPos(320, 90)
	Model_PM_Panel:SetSize(290, 440)	
	Model_PM_Panel.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
	end	

	local Model_PM_Scroll = vgui.Create("DScrollPanel", Model_PM_Panel) 
	Model_PM_Scroll:Dock(FILL)

	local Model_PM_Icon = vgui.Create("DIconLayout", Model_PM_Scroll) 
	Model_PM_Icon:Dock(FILL) 
	Model_PM_Icon:SetSpaceY(5) 
	Model_PM_Icon:SetSpaceX(5)
	for _, pmData in pairs(all_model_list_PM) do
		local icon = vgui.Create("SpawnIcon", Model_PM_Icon) 
		icon:SetModel(pmData.Model) 
		icon:SetToolTip(pmData.Name)
		icon.DoClick = function() 
			Selected_Model:SetModel(pmData.Model)
			Random_Sequence(Selected_Model)
			Selected_Model.label = pmData.Name
			Model_Preview_txt:SetText(Selected_Model.label)
			Model_Preview_txt:SizeToContents()
			Rebuild_BodyGroup(Model_BodyGroup_ScrollPanel, Selected_Model)
		end
	end


	---------------------------
	--搜索框
	local Model_Search_Panel = vgui.Create("DPanel", frame_2)
	Model_Search_Panel:SetPos(10, 10)
	Model_Search_Panel:SetSize(600, 25)	
	Model_Search_Panel.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(235, 235, 235, 235))
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 235))
	end		

	local Model_Search_TextEntry = vgui.Create("DTextEntry", frame_2)
	Model_Search_TextEntry:SetPos(20, 10)
	Model_Search_TextEntry:SetSize(590, 25)
	Model_Search_TextEntry:SetTextColor(Color(250, 250, 250, 255))
	Model_Search_TextEntry:SetPaintBackground(false)
	Model_Search_TextEntry:SetPlaceholderText(Description_Tb["MR12"])
	Model_Search_TextEntry.OnChange = function(self)
		local text = self:GetValue()

		--重绘NPC图标
		Model_NPC_Icon:Clear()
		for _, npcData in pairs(all_model_list_NPC) do
			if not text or string.find(string.lower(npcData.Name), string.lower(text)) then
				local icon = vgui.Create("SpawnIcon", Model_NPC_Icon)
				icon:SetModel(npcData.Model)
				icon:SetToolTip(npcData.Name)
				icon.DoClick = function()
					Selected_Model:SetModel(npcData.Model)
					Random_Sequence(Selected_Model)
					Selected_Model.label = npcData.Name
					Model_Preview_txt:SetText(Selected_Model.label)
					Model_Preview_txt:SizeToContents()
					Rebuild_BodyGroup(Model_BodyGroup_ScrollPanel, Selected_Model)
				end
			end
		end

		--重绘PM图标
		Model_PM_Icon:Clear()
		for _, pmData in pairs(all_model_list_PM) do
			if not text or string.find(string.lower(pmData.Name), string.lower(text)) then
				local icon = vgui.Create("SpawnIcon", Model_PM_Icon) 
				icon:SetModel(pmData.Model) 
				icon:SetToolTip(pmData.Name)
				icon.DoClick = function() 
					Selected_Model:SetModel(pmData.Model)
					Random_Sequence(Selected_Model)
					Selected_Model.label = pmData.Name
					Model_Preview_txt:SetText(Selected_Model.label)
					Model_Preview_txt:SizeToContents()
					Rebuild_BodyGroup(Model_BodyGroup_ScrollPanel, Selected_Model)
				end
			end
		end

		Model_PM_Scroll:InvalidateLayout(true)
		Model_NPC_Scroll:InvalidateLayout(true)
	end

	---------------------------
	local Combine_List = vgui.Create("DListView", frame_2)
	Combine_List:SetPos(1020, 5)
	Combine_List:SetSize(245, 115)
	Combine_List:SetMultiSelect(false)
	Combine_List.col = Combine_List:AddColumn("Combine Replacement List")
	Combine_List.col.PaintOver = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
		draw.SimpleText("Combine Replacement List", "Default", w/2, 0, Color(10, 10, 10, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	Combine_List.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
	end

	if combineTb then
		Rebuild_List(Combine_List, combineTb, Elements)
	end


	---------------------------
	local Citizen_List = vgui.Create("DListView", frame_2)
	Citizen_List:SetPos(1020, 120)
	Citizen_List:SetSize(245, 115)
	Citizen_List:SetMultiSelect(false)
	Citizen_List.col = Citizen_List:AddColumn("Citizen Replacement List")
	Citizen_List.col.PaintOver = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
		draw.SimpleText("Citizen Replacement List", "Default", w/2, 0, Color(10, 10, 10, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	Citizen_List.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
	end

	if citizenTb then
		Rebuild_List(Citizen_List, citizenTb, Elements)
	end


	---------------------------
	local Zombies_List = vgui.Create("DListView", frame_2)
	Zombies_List:SetPos(1020, 235)
	Zombies_List:SetSize(245, 115)
	Zombies_List:SetMultiSelect(false)
	Zombies_List.col = Zombies_List:AddColumn("Zombies Replacement List")
	Zombies_List.col.PaintOver = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
		draw.SimpleText("Zombies Replacement List", "Default", w/2, 0, Color(10, 10, 10, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	Zombies_List.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
	end

	if zombiesTb then
		Rebuild_List(Zombies_List, zombiesTb, Elements)
	end


	---------------------------
	local Preset_List = vgui.Create("DListView", frame_2)
	Preset_List:SetPos(1020, 350)
	Preset_List:SetSize(245, 60)
	Preset_List:SetMultiSelect(false)
	Preset_List.col = Preset_List:AddColumn("Replacement Presets")
	Preset_List.col.PaintOver = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(50, 50, 50, 235))
		draw.SimpleText("Replacement Presets", "Default", w/2, 0, Color(230, 230, 230, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	Preset_List.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
		draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
	end

	if presetsTb then
		Rebuild_List_Preset(Preset_List)
	end



	---------------------------
	local Model_Add_Combine_Button = vgui.Create("DButton", frame_2)
	Model_Add_Combine_Button:SetPos(630, 330)
	Model_Add_Combine_Button:SetSize(370, 30)
	Model_Add_Combine_Button:SetText( "" )
	Model_Add_Combine_Button.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 235))
		draw.RoundedBox(5, 0, 0, w-3, h-3, Color(235, 235, 235, 235))
	end
	Model_Add_Combine_Button.DoClick = function()
		--将该模型的名称和模型路径同时写入表格
		local combine_data = {}
		combine_data.Name = Selected_Model.label
		combine_data.Model = Selected_Model:GetModel()
		--将该模型的bg写入表格validBodygroups，其k为bg的名称，v为该bg对应的值
		combine_data.validBodygroups = {}
		for k, bodygroup in pairs(Selected_Model:GetBodyGroups()) do
			if bodygroup.num > 1 then
				combine_data.validBodygroups[bodygroup.name] = Selected_Model:GetBodygroup(bodygroup.id)
			end
		end

		if combine_data.Name != "" then
			--如果有重名的，就将原来的移除，将新的写进去
			if combineTb then
				for k, read_data in pairs(combineTb) do
					if read_data.Name == combine_data.Name then
						table.remove(combineTb, k)
					end
				end
			end
			table.insert(combineTb, combine_data)

			file.Write("npc_physical_mod/combine_table.txt", util.TableToJSON(combineTb) )
			net.Start("Ragdollize_ChangeReplacementList_cTs")
			net.SendToServer()

			--重建DListView
			Rebuild_List(Combine_List, combineTb, Elements)
		end
	end

	local Model_Add_Combine_Button_txt_L = vgui.Create("DLabel", frame_2)
	Model_Add_Combine_Button_txt_L:SetPos(638, 335)
	Model_Add_Combine_Button_txt_L:SetFont("Trebuchet18")
	Model_Add_Combine_Button_txt_L:SetText(Description_Tb["MR2"])
	Model_Add_Combine_Button_txt_L:SetColor(Color(100, 100, 100, 250))
	Model_Add_Combine_Button_txt_L:SizeToContents()


	---------------------------
	local Model_Del_Combine_Button = vgui.Create("DButton", frame_2)
	Model_Del_Combine_Button:SetPos(630, 364)
	Model_Del_Combine_Button:SetSize(370, 30)
	Model_Del_Combine_Button:SetText( "" )
	Model_Del_Combine_Button.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w-3, h-3, Color(235, 235, 235, 235))
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 235))
	end
	Model_Del_Combine_Button.DoClick = function()
		local name = Selected_Model.label
		if name != "" then
			--从combineTb删除此name
			if combineTb then
				for k, v in pairs(combineTb) do
					if name == v.Name then
						table.remove(combineTb, k)
					end
				end
			end
			
			file.Write("npc_physical_mod/combine_table.txt", util.TableToJSON(combineTb) )
			net.Start("Ragdollize_ChangeReplacementList_cTs")
			net.SendToServer()

			--重建DListView
			Rebuild_List(Combine_List, combineTb, Elements)
		end
	end

	local Model_Del_Combine_Button_txt_L = vgui.Create("DLabel", frame_2)
	Model_Del_Combine_Button_txt_L:SetPos(638, 369)
	Model_Del_Combine_Button_txt_L:SetFont("Trebuchet18")
	Model_Del_Combine_Button_txt_L:SetText(Description_Tb["MR3"])
	Model_Del_Combine_Button_txt_L:SetColor(Color(235, 235, 235, 250))
	Model_Del_Combine_Button_txt_L:SizeToContents()


	---------------------------
	local Model_Add_Citizen_Button = vgui.Create("DButton", frame_2)
	Model_Add_Citizen_Button:SetPos(630, 398)
	Model_Add_Citizen_Button:SetSize(370, 30)
	Model_Add_Citizen_Button:SetText( "" )
	Model_Add_Citizen_Button.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 235))
		draw.RoundedBox(5, 0, 0, w-3, h-3, Color(235, 235, 235, 235))
	end
	Model_Add_Citizen_Button.DoClick = function()
		--将该模型的名称和模型路径同时写入表格
		local citizen_data = {}
		citizen_data.Name = Selected_Model.label
		citizen_data.Model = Selected_Model:GetModel()
		--将该模型的bg写入表格validBodygroups，其k为bg的名称，v为该bg对应的值
		citizen_data.validBodygroups = {}
		for k, bodygroup in pairs(Selected_Model:GetBodyGroups()) do
			if bodygroup.num > 1 then
				citizen_data.validBodygroups[bodygroup.name] = Selected_Model:GetBodygroup(bodygroup.id)
			end
		end

		if citizen_data.Name != "" then
			--如果有重名的，就将原来的移除，将新的写进去
			if citizenTb then
				for k, read_data in pairs(citizenTb) do
					if read_data.Name == citizen_data.Name then
						table.remove(citizenTb, k)
					end
				end
			end
			table.insert(citizenTb, citizen_data)

			file.Write("npc_physical_mod/citizen_table.txt", util.TableToJSON(citizenTb) )
			net.Start("Ragdollize_ChangeReplacementList_cTs")
			net.SendToServer()

			--重建DListView
			Rebuild_List(Citizen_List, citizenTb, Elements)
		end
	end

	local Model_Add_Citizen_Button_txt_L = vgui.Create("DLabel", frame_2)
	Model_Add_Citizen_Button_txt_L:SetPos(638, 403)
	Model_Add_Citizen_Button_txt_L:SetFont("Trebuchet18")
	Model_Add_Citizen_Button_txt_L:SetText(Description_Tb["MR4"])
	Model_Add_Citizen_Button_txt_L:SetColor(Color(100, 100, 100, 250))
	Model_Add_Citizen_Button_txt_L:SizeToContents()


	---------------------------
	local Model_Del_Citizen_Button = vgui.Create("DButton", frame_2)
	Model_Del_Citizen_Button:SetPos(630, 432)
	Model_Del_Citizen_Button:SetSize(370, 30)
	Model_Del_Citizen_Button:SetText( "" )
	Model_Del_Citizen_Button.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w-3, h-3, Color(235, 235, 235, 235))
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 235))
	end
	Model_Del_Citizen_Button.DoClick = function()
		local name = Selected_Model.label
		if name != "" then
			--从citizenTb删除此name
			if citizenTb then
				for k, v in pairs(citizenTb) do
					if name == v.Name then
						table.remove(citizenTb, k)
					end
				end
			end
			
			file.Write("npc_physical_mod/citizen_table.txt", util.TableToJSON(citizenTb) )
			net.Start("Ragdollize_ChangeReplacementList_cTs")
			net.SendToServer()

			--重建DListView
			Rebuild_List(Citizen_List, citizenTb, Elements)
		end
	end

	local Model_Del_Citizen_Button_txt_L = vgui.Create("DLabel", frame_2)
	Model_Del_Citizen_Button_txt_L:SetPos(638, 437)
	Model_Del_Citizen_Button_txt_L:SetFont("Trebuchet18")
	Model_Del_Citizen_Button_txt_L:SetText(Description_Tb["MR5"])
	Model_Del_Citizen_Button_txt_L:SetColor(Color(235, 235, 235, 250))
	Model_Del_Citizen_Button_txt_L:SizeToContents()


	---------------------------
	local Model_Add_Zombies_Button = vgui.Create("DButton", frame_2)
	Model_Add_Zombies_Button:SetPos(630, 466)
	Model_Add_Zombies_Button:SetSize(370, 30)
	Model_Add_Zombies_Button:SetText( "" )
	Model_Add_Zombies_Button.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 235))
		draw.RoundedBox(5, 0, 0, w-3, h-3, Color(235, 235, 235, 235))
	end
	Model_Add_Zombies_Button.DoClick = function()
		--将该模型的名称和模型路径同时写入表格
		local zombies_data = {}
		zombies_data.Name = Selected_Model.label
		zombies_data.Model = Selected_Model:GetModel()
		--将该模型的bg写入表格validBodygroups，其k为bg的名称，v为该bg对应的值
		zombies_data.validBodygroups = {}
		for k, bodygroup in pairs(Selected_Model:GetBodyGroups()) do
			if bodygroup.num > 1 then
				zombies_data.validBodygroups[bodygroup.name] = Selected_Model:GetBodygroup(bodygroup.id)
			end
		end

		if zombies_data.Name != "" then
			--如果有重名的，就将原来的移除，将新的写进去
			if zombiesTb then
				for k, read_data in pairs(zombiesTb) do
					if read_data.Name == zombies_data.Name then
						table.remove(zombiesTb, k)
					end
				end
			end
			table.insert(zombiesTb, zombies_data)

			file.Write("npc_physical_mod/zombies_table.txt", util.TableToJSON(zombiesTb) )
			net.Start("Ragdollize_ChangeReplacementList_cTs")
			net.SendToServer()

			--重建DListView
			Rebuild_List(Zombies_List, zombiesTb, Elements)
		end
	end

	local Model_Add_Zombies_Button_txt_L = vgui.Create("DLabel", frame_2)
	Model_Add_Zombies_Button_txt_L:SetPos(638, 471)
	Model_Add_Zombies_Button_txt_L:SetFont("Trebuchet18")
	Model_Add_Zombies_Button_txt_L:SetText(Description_Tb["MR14"])
	Model_Add_Zombies_Button_txt_L:SetColor(Color(100, 100, 100, 250))
	Model_Add_Zombies_Button_txt_L:SizeToContents()


	---------------------------
	local Model_Del_Zombies_Button = vgui.Create("DButton", frame_2)
	Model_Del_Zombies_Button:SetPos(630, 500)
	Model_Del_Zombies_Button:SetSize(370, 30)
	Model_Del_Zombies_Button:SetText( "" )
	Model_Del_Zombies_Button.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w-3, h-3, Color(235, 235, 235, 235))
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 235))
	end
	Model_Del_Zombies_Button.DoClick = function()
		local name = Selected_Model.label
		if name != "" then
			--从zombiesTb删除此name
			if zombiesTb then
				for k, v in pairs(zombiesTb) do
					if name == v.Name then
						table.remove(zombiesTb, k)
					end
				end
			end
			
			file.Write("npc_physical_mod/zombies_table.txt", util.TableToJSON(zombiesTb) )
			net.Start("Ragdollize_ChangeReplacementList_cTs")
			net.SendToServer()

			--重建DListView
			Rebuild_List(Zombies_List, zombiesTb, Elements)
		end
	end

	local Model_Del_Zombies_Button_txt_L = vgui.Create("DLabel", frame_2)
	Model_Del_Zombies_Button_txt_L:SetPos(638, 505)
	Model_Del_Zombies_Button_txt_L:SetFont("Trebuchet18")
	Model_Del_Zombies_Button_txt_L:SetText(Description_Tb["MR15"])
	Model_Del_Zombies_Button_txt_L:SetColor(Color(235, 235, 235, 250))
	Model_Del_Zombies_Button_txt_L:SizeToContents()




	---------------------------
	local Preset_Use_Button = vgui.Create("DButton", frame_2)
	Preset_Use_Button:SetPos(1020, 420)
	Preset_Use_Button:SetSize(245, 30)
	Preset_Use_Button:SetText( "" )
	Preset_Use_Button.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(235, 235, 235, 235))
		draw.RoundedBox(5, 0, 0, w-3, h-3, Color(10, 10, 10, 235))
	end
	Preset_Use_Button.DoClick = function()

		combineTb = chosenPreset.PresetCombine
		citizenTb = chosenPreset.PresetCitizen
		zombiesTb = chosenPreset.PresetZombies
		file.Write("npc_physical_mod/combine_table.txt", util.TableToJSON(combineTb) )
		file.Write("npc_physical_mod/citizen_table.txt", util.TableToJSON(citizenTb) )
		file.Write("npc_physical_mod/zombies_table.txt", util.TableToJSON(zombiesTb) )		
		net.Start("Ragdollize_ChangeReplacementList_cTs")
		net.SendToServer()
		Rebuild_List(Combine_List, combineTb, Elements)
		Rebuild_List(Citizen_List, citizenTb, Elements)
		Rebuild_List(Zombies_List, zombiesTb, Elements)
	end

	local Preset_Use_Button_txt_L = vgui.Create("DLabel", frame_2)
	Preset_Use_Button_txt_L:SetPos(1028, 425)
	Preset_Use_Button_txt_L:SetFont("Trebuchet18")
	Preset_Use_Button_txt_L:SetText(Description_Tb["MR9"])
	Preset_Use_Button_txt_L:SetColor(Color(235, 235, 235, 250))
	Preset_Use_Button_txt_L:SizeToContents()


	---------------------------
	local Preset_Add_Button = vgui.Create("DButton", frame_2)
	Preset_Add_Button:SetPos(1020, 460)
	Preset_Add_Button:SetSize(245, 30)
	Preset_Add_Button:SetText( "" )
	Preset_Add_Button.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(235, 235, 235, 235))
		draw.RoundedBox(5, 0, 0, w-3, h-3, Color(10, 10, 10, 235))
	end
	Preset_Add_Button.DoClick = function()
		Preset_List:ClearSelection()

		---------------------------
		--命名界面
		local window_AddPreset = vgui.Create("DFrame")
		window_AddPreset:SetSize(400, 150)
		window_AddPreset:Center()
		window_AddPreset:SetTitle("")
		window_AddPreset:SetDraggable(true)
		window_AddPreset:MakePopup()
		window_AddPreset:ShowCloseButton(false)
	
		local label = vgui.Create("DLabel", window_AddPreset)
		label:SetPos(10, 30)
		label:SetFont("CreditsOutroText")
		label:SetText("Enter the Name for this Preset" ..
					  "\n为预设命名")
		label:SetColor(Color(200, 200, 200, 255))
		label:SizeToContents()

		local text = vgui.Create("DTextEntry", window_AddPreset)
		text:SetPos(10, 70)
		text:SetSize(380, 30)
		text:SetPlaceholderText("Type your Preset Name here")

		---------------------------
		--点确认键后，将当前 combineTb和citizenTb和zombiesTb 写入表格 preset （是将所有保存过的preset重写进txt文件里，而不是仅仅将当前想要新增的preset写进去）
		local comfirm = vgui.Create("DButton", window_AddPreset)
		comfirm:SetPos(10, 100)
		comfirm:SetSize(380, 30)
		comfirm:SetText( "" )
		comfirm.Paint = function(self, w, h)
			draw.RoundedBox(5, 0, 0, w, h, Color(235, 235, 235, 235))
			draw.RoundedBox(5, 0, 0, w-3, h-3, Color(10, 10, 10, 235))
		end
		comfirm.DoClick = function()
			window_AddPreset:Close()

			--当前想要新增的preset的内容
			local preset = {}
			preset.PresetCombine = combineTb
			preset.PresetCitizen = citizenTb
			preset.PresetZombies = zombiesTb
			preset.PresetName = text:GetValue()

			--判断当前新增的preset的名字是否已经在presetsTb里存在，如果已经存在，则移除原有的以该名字命名的preset，再将新preset写入presetsTb
			local preset_AlreadyExists = false
			local preset_AlreadyExists_ID = nil
			if presetsTb then
				for k, v in pairs(presetsTb) do
					if v.PresetName == text:GetValue() then
						preset_AlreadyExists = true
						preset_AlreadyExists_ID = k
					end
				end
			else
				presetsTb = {}
				preset_AlreadyExists = false
			end

			if preset_AlreadyExists then
				table.remove(presetsTb, preset_AlreadyExists_ID)
			end

			table.insert(presetsTb, preset)
			file.Write("npc_physical_mod/presets_table.txt", util.TableToJSON(presetsTb) )
			Rebuild_List_Preset(Preset_List)
		end

		local comfirm_txt_L = vgui.Create("DLabel", window_AddPreset)
		comfirm_txt_L:SetPos(18, 105)
		comfirm_txt_L:SetFont("Trebuchet18")
		comfirm_txt_L:SetText("OK")
		comfirm_txt_L:SetColor(Color(235, 235, 235, 250))
		comfirm_txt_L:SizeToContents()
	end

	local Preset_Add_Button_txt_L = vgui.Create("DLabel", frame_2)
	Preset_Add_Button_txt_L:SetPos(1028, 465)
	Preset_Add_Button_txt_L:SetFont("Trebuchet18")
	Preset_Add_Button_txt_L:SetText(Description_Tb["MR10"])
	Preset_Add_Button_txt_L:SetColor(Color(235, 235, 235, 250))
	Preset_Add_Button_txt_L:SizeToContents()


	---------------------------
	local Preset_Del_Button = vgui.Create("DButton", frame_2)
	Preset_Del_Button:SetPos(1020, 500)
	Preset_Del_Button:SetSize(245, 30)
	Preset_Del_Button:SetText( "" )
	Preset_Del_Button.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(235, 235, 235, 235))
		draw.RoundedBox(5, 0, 0, w-3, h-3, Color(10, 10, 10, 235))
	end
	Preset_Del_Button.DoClick = function()
		--从presetsTb删除此preset
		for k, preset in pairs(presetsTb) do
			if chosenPreset.PresetName == preset.PresetName then
				table.remove(presetsTb, k)
			end
		end

		file.Write("npc_physical_mod/presets_table.txt", util.TableToJSON(presetsTb) )
		Rebuild_List_Preset(Preset_List)
	end

	local Preset_Del_Button_txt_L = vgui.Create("DLabel", frame_2)
	Preset_Del_Button_txt_L:SetPos(1028, 505)
	Preset_Del_Button_txt_L:SetFont("Trebuchet18")
	Preset_Del_Button_txt_L:SetText(Description_Tb["MR11"])
	Preset_Del_Button_txt_L:SetColor(Color(235, 235, 235, 250))
	Preset_Del_Button_txt_L:SizeToContents()




	---------------------------
	--语言
	local Language_Button = vgui.Create("DButton", window)
	Language_Button:SetPos(60, 55)
	Language_Button:SetSize(115, 30)
	Language_Button:SetText( "" )
	Language_Button:SetIcon("flags16/gb.png")
	Language_Button.Paint = function(self, w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(255, 51, 51, 235))
		draw.RoundedBox(5, 0, 0, w-10, h-4, Color(225, 225, 225, 255))
	end
	Language_Button.DoClick = function()
		Ragdollize_language_switch = 1 - Ragdollize_language_switch
		Ragdollize_Switch_Language_2()
	end

	local Language_Button_txt_L = vgui.Create("DLabel", window)
	Language_Button_txt_L:SetPos(95, 60)
	Language_Button_txt_L:SetFont("Trebuchet18")
	Language_Button_txt_L:SetText("切换中文")
	Language_Button_txt_L:SetColor(Color(100, 100, 100, 255))
	Language_Button_txt_L:SizeToContents()


	function Ragdollize_Switch_Language_2()
		if Ragdollize_language_switch == 1 then

			Title_Tb = Title_Tb_ENG
			Description_Tb = Description_Tb_ENG
			Language_Button:SetIcon("flags16/gb.png")

			label_1:SetText("You can use your own NPC or even PM models to replace combines/citizens")
			label_1:SizeToContents()

			Description_txt_S:SetText(Description_Tb["MR1"])
			Model_Add_Combine_Button_txt_L:SetText(Description_Tb["MR2"])
			Model_Del_Combine_Button_txt_L:SetText(Description_Tb["MR3"])
			Model_Add_Citizen_Button_txt_L:SetText(Description_Tb["MR4"])
			Model_Del_Citizen_Button_txt_L:SetText(Description_Tb["MR5"])
			Model_Add_Zombies_Button_txt_L:SetText(Description_Tb["MR14"])
			Model_Del_Zombies_Button_txt_L:SetText(Description_Tb["MR15"])
			Replace_Combine_Check_txt_L:SetText(Description_Tb["MR6"])
			Replace_Citizen_Check_txt_L:SetText(Description_Tb["MR7"])
			Replace_Zombies_Check_txt_L:SetText(Description_Tb["MR13"])
			Replace_Headcrab_Check_txt_L:SetText(Description_Tb["MR16"])
			Replace_Scale_Check_txt_L:SetText(Description_Tb["MR8"])
			Preset_Use_Button_txt_L:SetText(Description_Tb["MR9"])
			Preset_Add_Button_txt_L:SetText(Description_Tb["MR10"])
			Preset_Del_Button_txt_L:SetText(Description_Tb["MR11"])
			Model_Search_TextEntry:SetPlaceholderText(Description_Tb["MR12"])

			Replace_Combine_Check_txt_L:SetFont("TargetIDSmall")
			Replace_Citizen_Check_txt_L:SetFont("TargetIDSmall")
			Replace_Zombies_Check_txt_L:SetFont("TargetIDSmall")
			Replace_Headcrab_Check_txt_L:SetFont("TargetIDSmall")
			Replace_Scale_Check_txt_L:SetFont("TargetIDSmall")

			Description_txt_S:SizeToContents()
			Model_Add_Combine_Button_txt_L:SizeToContents()
			Model_Del_Combine_Button_txt_L:SizeToContents()
			Model_Add_Citizen_Button_txt_L:SizeToContents()
			Model_Del_Citizen_Button_txt_L:SizeToContents()
			Model_Add_Zombies_Button_txt_L:SizeToContents()
			Model_Del_Zombies_Button_txt_L:SizeToContents()
			Replace_Combine_Check_txt_L:SizeToContents()
			Replace_Citizen_Check_txt_L:SizeToContents()
			Replace_Zombies_Check_txt_L:SizeToContents()
			Replace_Headcrab_Check_txt_L:SizeToContents()
			Replace_Scale_Check_txt_L:SizeToContents()
			Preset_Use_Button_txt_L:SizeToContents()
			Preset_Add_Button_txt_L:SizeToContents()
			Preset_Del_Button_txt_L:SizeToContents()

			window.Paint = function(self, w, h)
				draw.RoundedBox(20, 0, 0, w, h, Color(10, 10, 10, 255))
				draw.RoundedBox(20, 0, 0, w-6, h-6, Color(235, 235, 235, 255))
				draw.SimpleText("Combine/Citizen/Zombie Replacer", "DermaLarge", 700, 5, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			Model_BodyGroup_Panel.Paint = function(self, w, h)
				draw.RoundedBox(10, 0, 0, w, h, Color(50, 50, 50, 255))
				draw.RoundedBox(10, 1, 1, w-2, h-2, Color(200, 200, 200, 255))
				draw.SimpleText("Set BodyGroup", "Default", w/2, 5, Color(50, 50, 50, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			Model_NPC_Panel_title.Paint = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
				draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
				draw.SimpleText("All NPC Models", "TargetID", 145, 5, Color(100, 100, 100, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			Model_PM_Panel_title.Paint = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
				draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
				draw.SimpleText("All Player Models", "TargetID", 145, 5, Color(100, 100, 100, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end	
			Combine_List.col.PaintOver = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 255))
				draw.RoundedBox(5, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
				draw.SimpleText("Combine Replacement List", "Default", w/2, 0, Color(10, 10, 10, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			Citizen_List.col.PaintOver = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 255))
				draw.RoundedBox(5, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
				draw.SimpleText("Citizen Replacement List", "Default", w/2, 0, Color(10, 10, 10, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			Zombies_List.col.PaintOver = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 255))
				draw.RoundedBox(5, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
				draw.SimpleText("Zombies Replacement List", "Default", w/2, 0, Color(10, 10, 10, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			Preset_List.col.PaintOver = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 255))
				draw.RoundedBox(5, 0, 0, w-2, h-2, Color(50, 50, 50, 235))
				draw.SimpleText("Replacement Presets", "Default", w/2, 0, Color(230, 230, 230, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		else

			Title_Tb = Title_Tb_CHN
			Description_Tb = Description_Tb_CHN
			Language_Button:SetIcon("flags16/cn.png")

			label_1:SetText("你可以用你自己的 NPC 甚至是 PM 模型来替换 联合军/市民 的模型")
			label_1:SizeToContents()

			Description_txt_S:SetText(Description_Tb["MR1"])
			Model_Add_Combine_Button_txt_L:SetText(Description_Tb["MR2"])
			Model_Del_Combine_Button_txt_L:SetText(Description_Tb["MR3"])
			Model_Add_Citizen_Button_txt_L:SetText(Description_Tb["MR4"])
			Model_Del_Citizen_Button_txt_L:SetText(Description_Tb["MR5"])
			Model_Add_Zombies_Button_txt_L:SetText(Description_Tb["MR14"])
			Model_Del_Zombies_Button_txt_L:SetText(Description_Tb["MR15"])
			Replace_Combine_Check_txt_L:SetText(Description_Tb["MR6"])
			Replace_Citizen_Check_txt_L:SetText(Description_Tb["MR7"])
			Replace_Zombies_Check_txt_L:SetText(Description_Tb["MR13"])
			Replace_Headcrab_Check_txt_L:SetText(Description_Tb["MR16"])
			Replace_Scale_Check_txt_L:SetText(Description_Tb["MR8"])
			Preset_Use_Button_txt_L:SetText(Description_Tb["MR9"])
			Preset_Add_Button_txt_L:SetText(Description_Tb["MR10"])
			Preset_Del_Button_txt_L:SetText(Description_Tb["MR11"])
			Model_Search_TextEntry:SetPlaceholderText(Description_Tb["MR12"])

			Replace_Combine_Check_txt_L:SetFont("Trebuchet18")
			Replace_Citizen_Check_txt_L:SetFont("Trebuchet18")
			Replace_Zombies_Check_txt_L:SetFont("Trebuchet18")
			Replace_Headcrab_Check_txt_L:SetFont("Trebuchet18")
			Replace_Scale_Check_txt_L:SetFont("Trebuchet18")

			Description_txt_S:SizeToContents()
			Model_Add_Combine_Button_txt_L:SizeToContents()
			Model_Del_Combine_Button_txt_L:SizeToContents()
			Model_Add_Citizen_Button_txt_L:SizeToContents()
			Model_Del_Citizen_Button_txt_L:SizeToContents()
			Model_Add_Zombies_Button_txt_L:SizeToContents()
			Model_Del_Zombies_Button_txt_L:SizeToContents()
			Replace_Combine_Check_txt_L:SizeToContents()
			Replace_Citizen_Check_txt_L:SizeToContents()
			Replace_Zombies_Check_txt_L:SizeToContents()
			Replace_Headcrab_Check_txt_L:SizeToContents()
			Replace_Scale_Check_txt_L:SizeToContents()
			Preset_Use_Button_txt_L:SizeToContents()
			Preset_Add_Button_txt_L:SizeToContents()
			Preset_Del_Button_txt_L:SizeToContents()

			window.Paint = function(self, w, h)
				draw.RoundedBox(20, 0, 0, w, h, Color(10, 10, 10, 255))
				draw.RoundedBox(20, 0, 0, w-6, h-6, Color(235, 235, 235, 255))
				draw.SimpleText("联合军/市民/僵尸 模型替换器", "DermaLarge", 700, 5, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			Model_BodyGroup_Panel.Paint = function(self, w, h)
				draw.RoundedBox(10, 0, 0, w, h, Color(50, 50, 50, 255))
				draw.RoundedBox(10, 1, 1, w-2, h-2, Color(200, 200, 200, 255))
				draw.SimpleText("设置身体组件", "Default", w/2, 5, Color(50, 50, 50, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			Model_NPC_Panel_title.Paint = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
				draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
				draw.SimpleText("所有可用的NPC模型", "TargetID", 145, 5, Color(100, 100, 100, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			Model_PM_Panel_title.Paint = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, Color(150, 150, 150, 255))
				draw.RoundedBox(5, 0, 0, w-2, h-2, Color(200, 200, 200, 255))
				draw.SimpleText("所有可用的玩家模型", "TargetID", 145, 5, Color(100, 100, 100, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end	

			Combine_List.col.PaintOver = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 255))
				draw.RoundedBox(5, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
				draw.SimpleText("[联合军]的模型替换列表", "Default", w/2, 0, Color(10, 10, 10, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			Citizen_List.col.PaintOver = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 255))
				draw.RoundedBox(5, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
				draw.SimpleText("[市民]的模型替换列表", "Default", w/2, 0, Color(10, 10, 10, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			Zombies_List.col.PaintOver = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 255))
				draw.RoundedBox(5, 0, 0, w-2, h-2, Color(150, 150, 150, 235))
				draw.SimpleText("[僵尸]的模型替换列表", "Default", w/2, 0, Color(10, 10, 10, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
			Preset_List.col.PaintOver = function(self, w, h)
				draw.RoundedBox(5, 0, 0, w, h, Color(200, 200, 200, 255))
				draw.RoundedBox(5, 0, 0, w-2, h-2, Color(50, 50, 50, 235))
				draw.SimpleText("替换预设", "Default", w/2, 0, Color(230, 230, 230, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
	end

	Ragdollize_Switch_Language_2()
end)



hook.Add( "PopulateToolMenu", "Physical_NPC", function()
	spawnmenu.AddToolMenuOption( "Utilities", "NPC Physics Mod", "Physical NPC", "#Physical NPC", "", "", function( panel )
		panel:Button("Open Settings Menu", "ragdollize_panel")
		panel:Button("Open Combine/Citizen/Zombies Replacer", "ragdollize_replace_panel")
	end)
end)