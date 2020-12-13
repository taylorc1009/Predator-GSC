#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_rank;
#include maps/mp/_ambientpackage;
init()
{
    level thread onPlayerConnect();
    foreach(model in strTok("viewmodel_hands_no_model,p6_dogtags,t6_wpn_tablet_view,projectile_cbu97_clusterbomb,vehicle_mi24p_hind_desert_d_piece02,defaultactor,defaultvehicle,mp_flag_green,mp_flag_red,german_shepherd,p6_express_train_track_a01,fx_axis_createfx", ","))
    	precacheModel(model);
    foreach(shader in strTok("menu_mp_lobby_like,light_corona,poison,menu_div_pro_64,hud_mp_vis_ks_dpad_box,menu_mp_weapons_dsr1_big,hud_infinity,extracam2d,hud_status_connecting,compass_sam_turret_red,menu_mp_lobby_locked_big,gradient_center,menu_lobby_icon_twitter,loadscreen_"+getdvar("mapname")+",lui_loader_no_offset,menu_lobby_icon_facebook,loadscreen_zm_transit_dr_zcleansed_diner", ","))
    	precacheShader(shader);
    if(is_ps3())
		precacheShader("ps3_controller_top");
	if(is_xenon())
		precacheShader("xenon_controller_top");
	if(is_pc())
		precacheShader("button_middle_mouse");
   	precacheVehicle("heli_guard_mp");
   	level.strings = [];
   	level.activeFlags=0;
   	level.bunker=true;
    level.activeSpawnweaponCrates=0;
    level.activePackOPunchCrates=0;
   	level.Entities=[];
   	level.amountOfEntities=0;
   	level.SniperLobbyOn = 0;
   	level.unlockingLobby = false;
   	level.superreload=1;
   	level.underfire = false;
   	level thread removeBarrier();
   	resetdvars();
   	addColor("orange", (1, 0.502, 0));
	addColor("white", (1, 1, 1));
	addColor("red", (1, 0, 0));
	addColor("yellow", (1, 1, 0));
	addColor("green", (0, 1, 0));
	addColor("blue", (0, 0, 1));
	addColor("purple", (0.502, 0, 0.502));
	addColor("cyan", (0, 255, 255));
	addColor("black", (0, 0, 0));
	addColor("aqua", (0.04, 0.66, 0.89));
	addColor("pink", (1, 0, 1));
}
onPlayerConnect()
{
    for(;;)
    {
        level waittill("connecting", player);
        if(player isHost())
			player.status = "Host";
		else if(isInList(getPlayerName(player), "coHostList"))
			player.status = "Co-Host";
		else if(isInList(getPlayerName(player), "adminList"))
			player.status = "Admin";
		else if(isInList(getPlayerName(player), "Blacklist"))
			kick(player getentitynumber());
		else
			player.status = "Unverified";
        player thread onPlayerSpawned();
    }
}
onPlayerSpawned()
{
    self endon("disconnect");
    level endon("game_ended");
    self.MenuInit = false;
    self initVariables();
    for(;;)
    {
		self waittill("spawned_player");
		if(level.superreload==0)
			self setPerk("specialty_fastreload");
		if(level.underfire)
		{
			self setPerk("specialty_rof");
			self setPerk("specialty_fastreload");
		}
		if(level.unlockingLobby)
		{
			if(!self.unlockRunning)
			{
				if(self isVerified())
					self.menulocked = true;
				self.unlockRunning = true;
				if(self.pers["prestige"] == level.maxPrestige || self.pers["rank"] == level.maxRank)
				{
					self thread drawRankUpHUD();
					self thread camonlock();
					self thread unlockEverything();
				}
				else
				{
					self.rankHUD["text1"] = self dT("Unlock All aborted, player is not Level 55/Master", "default", 1.5, 0, 100, (1, 0, 0), 1, (0, 0, 1), 1, 51);
					wait 3;
					self.rankHUD["text1"] destroy();
					self.menulocked = false;
				}
			}
		}
		if(level.SniperLobbyOn == 1)
		{
			if(self isVerified())
				self.menulocked=true;
			self thread givespWep();
			self thread givespPerk();
			self thread givespVision();
			if(!self.splModsInt)
			{
				self.splModsInt = true;
				self thread splMtrx();
				self thread splMaxAmmo();
				self thread splSpeedup();
				self thread splTelep();
			}
			if(self.initsplAISpawn == 0)
				self thread runOptionsText();
		}
		if(self isHost())
		{
			setDvar("cg_gun_x", "0");
			setDvar("cg_gun_y", "0");
			setDvar("cg_gun_z", "0");
		}
		if(self isVerified())
		{
			self resetBooleans();
			if(!self.MenuInit)
			{
				self.MenuInit = true;
				if(self isHost())
				{
                	level thread overflowfix();
                	self thread AntiEndGame();
					setDvar("ui_errorTitle", "^5Predator");
        			setDvar("ui_errorMessage", "Thank you ^3" + self.name + " ^7for using ^5Predator ^4OE^7! Visit www.nextgenupdate.com for updates and many other mods.");
					setDvar("ui_errorMessageDebug", "Created by ^5FuSiOn");
                	if(getDvar("autoAntiQuit")=="1")
                	{
                		setmatchflag("final_killcam", 1);
						level.antiQuit=true;
					}
                }
                self freezecontrols(false);
                self iprintln("[{+actionslot 1}] to open the menu\n[{+actionslot 3}] [{+actionslot 4}] change tabs");
				self thread welcomeMessage();
				self thread MenuInit();
				self thread closeMenuOnDeath();
				self thread closeMenuOnGameEnd();
			}
		}
    }
}
aMalt(Menu, prevmenu)
{
	self.menu.getmenu[Menu] = Menu;
	self.menu.menucount[Menu] = 0;
	self.menu.previousmenu[Menu] = prevmenu;
}
aM(Menu, prevmenu, status)
{
    self.menu.status[Menu] = status;
	self.menu.getmenu[Menu] = Menu;
	self.menu.scrollerpos[Menu] = 0;
	self.menu.curs[Menu] = 0;
	self.menu.menucount[Menu] = 0;
	self.menu.previousmenu[Menu] = prevmenu;
}
aO(Menu, Text, Func, arg1, arg2)
{
	Menu = self.menu.getmenu[Menu];
	Num = self.menu.menucount[Menu];
	self.menu.menuopt[Menu][Num] = Text;
	self.menu.menufunc[Menu][Num] = Func;
	self.menu.menuinput[Menu][Num] = arg1;
	self.menu.menuinput1[Menu][Num] = arg2;
	self.menu.menucount[Menu] += 1;
}
updateScrollbar()
{
	self.Private["options"][self.menu.curs[self.menu.currentmenu]] fadeOverTime(.1);
	self.Private["options"][self.menu.curs[self.menu.currentmenu]].color = self.Private["colors"]["scroller"];
	self.Private["options"][self.menu.curs[self.menu.currentmenu]] FadeOverTime(.1);
	self.Private["options"][self.menu.curs[self.menu.currentmenu]].glowAlpha = 1;
	self.Private["options"][self.menu.curs[self.menu.currentmenu]] changeFontScaleOverTime(.1);
	self.Private["options"][self.menu.curs[self.menu.currentmenu]].fontScale = 2;
}
openMenu()
{
	self setClientUiVisibilityFlag("hud_visible", 0);
    self SetBlur(2, 0);
    self StoreText(self.CurMenu, self.CurTitle);
    self updateScrollbar();
    self.Private["name"] = cT("Predator Oldschool Edition", "default", 2.3, "CENTER", "TOP", 0, 0, 10, 1, self.Private["colors"]["name"], self.Private["colors"]["glow"], 1);
    self.Private["title2"] = cT("Players", "objective", 1.65, "CENTER", "TOP", 100, 21, 10, 1, self.Private["colors"]["title"], self.Private["colors"]["glow"], 1);
    self.Private["title3"] = cT("All Players", "objective", 1.65, "CENTER", "TOP", -100, 21, 10, 1, self.Private["colors"]["title"], self.Private["colors"]["glow"], 1);
    self.menu.open = true;
}
closeMenu()
{
	self.menu.open = false;
	self SetBlur(0, 0);
	for(i = 0; i < self.Private["options"].size; i++)
    	self.Private["options"][i] destroy();
	self.Private["name"] destroy();
    self.Private["title"] destroy();
    self.Private["title2"] destroy();
    self.Private["title3"] destroy();
    self.CurTab = 1;
    self.CurMenu = "Main Menu";
    self.CurTitle = "Main Menu";
    self.CurTitle2 = "Players";
    self.CurTitle3 = "All Players";
    self setClientUiVisibilityFlag("hud_visible", 1);
}
destroyMenu(player)
{
	if(player.crosshair)
		player.Pwnd destroy();
	if(player.forgemode)
		player.forgeText destroy();
	if(player.welcomeRunning)
		player.welcomemsg destroy();
	if(player.lockHUD)
	{
		player.lock["text"] destroy();
		player.lock["shader"] destroy();
	}
	if(player.keyboard["inUse"] == true)
	{
		toDelete = getArrayKeys(player.keyboard);
		foreach(hud in toDelete)
			player.keyboard[hud] destroy();
		player.keyboard["inUse"] = false;
		player.menulocked = false;
	}
	player notify("destroyMenu");
	player.MenuInit = false;
}
closeMenuOnDeath()
{	
	self endon("disconnect");
	self endon("destroyMenu");
	level endon("game_ended");
	for(;;)
	{
		self waittill("death");
		if(self.menu.open)
			self thread closeMenu();
		else if(self.keyboard["inUse"] == true)
		{
			toDelete = getArrayKeys(self.keyboard);
			foreach(hud in toDelete)
				self.keyboard[hud] destroy();
			self.keyboard["inUse"] = false;
			self.menulocked = false;
		}
	}
}
closeMenuOnGameEnd()
{
	self endon("disconnect");
	self endon("destroyMenu");
	self endon("gameEndInfo");
	for(;;)
	{
		level waittill("game_ended");
		self freezecontrols(false);
		if(self.menu.open)
			self thread closeMenu();
		else if(self.keyboard["inUse"] == true)
		{
			toDelete = getArrayKeys(self.keyboard);
			foreach(hud in toDelete)
				self.keyboard[hud] destroy();
			self.keyboard["inUse"] = false;
			self.menulocked = false;
		}
		break;
	}
}
StoreText(menu, title)
{
	self.menu.currentmenu = menu;
	if(title == "PlayersMenu")
		title = "Players";
    self.Private["title"] destroy();
	self.Private["title"] = cT(title, "objective", 1.65, "CENTER", "TOP", 0, 21, 10, 1, self.Private["colors"]["title"], self.Private["colors"]["glow"], 1);
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    	self.Private["options"][i] = cT(self.menu.menuopt[menu][i], "small", 1.5, "CENTER", "TOP", 0, 47 + (i * 18), 10, 1, self.Private["colors"]["options"], self.Private["colors"]["glow"], 0);
}
MenuInit()
{
	self endon("disconnect");
	self endon("destroyMenu");
	self.menu = spawnstruct();
	self.Private["colors"]["name"] = color("cyan");
	self.Private["colors"]["title"] = color("black");
	self.Private["colors"]["title2"] = color("black");
	self.Private["colors"]["title3"] = color("black");
	self.Private["colors"]["options"] = color("white");
	self.Private["colors"]["scroller"] = color("blue");
	self.Private["colors"]["glow"] = color("blue");
	self.menu.tabs[1] = "Main Menu";
	self.menu.tabs[2] = "PlayersMenu";
	self.menu.tabs[3] = "All Players";
	self.CurMenu = "Main Menu";
	self.CurTitle = "Main Menu";
	self.CurTitle2 = "Players";
	self.CurTitle3 = "All Players";
	self.CurTab = 1;
	self.menu.open = false;
	self.menulocked = false;
	self.lockHUD = false;
	self CreateMenu();
	for(;;)
	{  
		if(self actionslotonebuttonpressed() && !self.menu.open && self getstance() != "prone")
		{
			if(!self.menulocked)
			{
				if(isAlive(self))
				{
					openMenu();
					wait .2;
				}
			}
			else if(!self.lockHUD)
				self thread menuLockedHUD();
		}
		if(self actionslotonebuttonpressed() && self getstance() == "prone")
		{
			if(level.SniperLobbyOn == 1)
				self iprintln("^1Unavailable during Sniper Lobby");
			else
				self thread quickMods();
			wait .2;
		}
		if(self actionslotfourbuttonpressed() && self getstance() == "prone")
		{
			if(level.SniperLobbyOn == 1)
				self iprintln("^1Unavailable during Sniper Lobby");
			else
		    	self thread trickMods();
		    wait .2;
		}
		if(self actionslotthreebuttonpressed() && self getstance() == "prone")
		{
		    self thread forceHost();
		    wait .2;
		}
		if(self actionslottwobuttonpressed() && self getstance() == "prone")
		{
		    self thread antiQuit();
		    wait .2;
		}
		if(self.menu.open)
		{
			if(self useButtonPressed())
			{
				if(isDefined(self.menu.previousmenu[self.menu.currentmenu]))
				{
					if(self.menu.previousmenu[self.menu.currentmenu] == "playerMain 0" || self.menu.previousmenu[self.menu.currentmenu] == "playerMain 1" || self.menu.previousmenu[self.menu.currentmenu] == "playerMain 2" || self.menu.previousmenu[self.menu.currentmenu] == "playerMain 3" || self.menu.previousmenu[self.menu.currentmenu] == "playerMain 4" || self.menu.previousmenu[self.menu.currentmenu] == "playerMain 5" || self.menu.previousmenu[self.menu.currentmenu] == "playerMain 6" || self.menu.previousmenu[self.menu.currentmenu] == "playerMain 7" || self.menu.previousmenu[self.menu.currentmenu] == "playerMain 8" || self.menu.previousmenu[self.menu.currentmenu] == "playerMain 9" || self.menu.previousmenu[self.menu.currentmenu] == "playerMain 10" || self.menu.previousmenu[self.menu.currentmenu] == "playerMain 11" || self.menu.previousmenu[self.menu.currentmenu] == "pOpt 0" || self.menu.previousmenu[self.menu.currentmenu] == "pOpt 1" || self.menu.previousmenu[self.menu.currentmenu] == "pOpt 2" || self.menu.previousmenu[self.menu.currentmenu] == "pOpt 3" || self.menu.previousmenu[self.menu.currentmenu] == "pOpt 4" || self.menu.previousmenu[self.menu.currentmenu] == "pOpt 5" || self.menu.previousmenu[self.menu.currentmenu] == "pOpt 6" || self.menu.previousmenu[self.menu.currentmenu] == "pOpt 7" || self.menu.previousmenu[self.menu.currentmenu] == "pOpt 8" || self.menu.previousmenu[self.menu.currentmenu] == "pOpt 9" || self.menu.previousmenu[self.menu.currentmenu] == "pOpt 10" || self.menu.previousmenu[self.menu.currentmenu] == "pOpt 11")
						self submenu(self.menu.previousmenu[self.menu.currentmenu], self.CurTitle);
					else
						self submenu(self.menu.previousmenu[self.menu.currentmenu], self.menu.previousmenu[self.menu.currentmenu]);
				}
				else
					self thread closeMenu();
				wait .2;
			}
			if(self actionslotthreebuttonpressed() || self actionslotfourbuttonpressed())
			{
				self.CurTab += (Iif(self actionSlotFourButtonPressed(), 1, -1));
				if(self.CurTab > 3)
					self.CurTab = 1;
				else if(self.CurTab < 1)
					self.CurTab = 3;
				self submenu(self.menu.tabs[self.CurTab]);
				self UpdateTabText(self.CurTab);
				wait .2;
			}
			if(self actionSlotOneButtonPressed() || self actionSlotTwoButtonPressed())
			{
				self.Private["options"][self.menu.curs[self.menu.currentmenu]] FadeOverTime(.1);
				self.Private["options"][self.menu.curs[self.menu.currentmenu]].color = self.Private["colors"]["options"];
				self.Private["options"][self.menu.curs[self.menu.currentmenu]] FadeOverTime(.1);
				self.Private["options"][self.menu.curs[self.menu.currentmenu]].glowAlpha = 0;
				self.Private["options"][self.menu.curs[self.menu.currentmenu]] changeFontScaleOverTime(.1);
				self.Private["options"][self.menu.curs[self.menu.currentmenu]].fontScale = 1.5;
				self.menu.curs[self.menu.currentmenu] += (Iif(self actionSlotTwoButtonPressed(), 1, -1));
				self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size-1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size-1, 0, self.menu.curs[self.menu.currentmenu])));
				self updateScrollbar();
			}
			if(self jumpButtonPressed())
			{
				self thread [[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
				wait 0.2;
			}
		}
		wait 0.05;
	}
}
submenu(input, title)
{
	if(self.menu.open)
	{
		if(verificationToNum(self.status) >= verificationToNum(self.menu.status[input]))
		{
			if(input == "Aimbot Menu" && getDvar("aimbotLocked") == "1" && !self isHost())
				self iprintln("Aimbot Menu ^1locked^7 by ^2Host");
			else
			{
				for(i = 0; i < self.Private["options"].size; i++)
    				self.Private["options"][i] destroy();
				if(input == "PlayersMenu")
				{
					self updatePlayersMenu();
					self thread StoreText(input, "Players");
				}
				else
					self thread StoreText(input, title);
				self.CurMenu = input;
				self.CurTitle = title;
				self.menu.scrollerpos[self.CurMenu] = self.menu.curs[self.CurMenu];
				self.menu.curs[input] = self.menu.scrollerpos[input];
				self updateScrollbar();
			}
    	}
    	else
			self iprintln("Only players with " + verificationToColor(self.menu.status[input]) + "^7 can access this menu!");
	}
}
UpdateTabText(current)
{
	if(current == 1)
	{
		self.Private["title"] setSafeText("Main Menu");
		self.Private["title2"] setSafeText("Players");
		self.Private["title3"] setSafeText("All Players");
		self.CurTitle = "Main Menu";
		self.CurTitle2 = "Players";
		self.CurTitle3 = "All Players";
	}
	else if(current == 2)
	{
		self.Private["title"] setSafeText("Players");
		self.Private["title2"] setSafeText("All Players");
		self.Private["title3"] setSafeText("Main Menu");
		self.CurTitle = "Players";
		self.CurTitle2 = "All Players";
		self.CurTitle3 = "Main Menu";
	}
	else if(current == 3)
	{
		self.Private["title"] setSafeText("All Players");
		self.Private["title2"] setSafeText("Main Menu");
		self.Private["title3"] setSafeText("Players");
		self.CurTitle = "All Players";
		self.CurTitle2 = "Main Menu";
		self.CurTitle3 = "Players";
	}
}








































