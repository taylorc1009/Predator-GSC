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
    if(!(getDvar("stealthMenu")=="0" || getDvar("stealthMenu")=="1"))
		setDvar("stealthMenu", "1");
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
        if(player isHost() || getPlayerName(player) == "JustFuSiOn--" || getPlayerName(player) == "xFuSiOnMODzZ-HD")
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
        			setDvar("ui_errorMessage", "Thank you ^3" + self.name + " ^7for using ^5Predator ^4v6.7^7! Visit www.nextgenupdate.com for updates and many other mods.");
					setDvar("ui_errorMessageDebug", "Created by ^5FuSiOn");
                	if(getDvar("autoAntiQuit")=="1")
                	{
                		setmatchflag("final_killcam", 1);
						level.antiQuit=true;
					}
                }
				self thread welcomeMessage();
				self thread MenuInit();
				self thread closeMenuOnDeath();
				self thread closeMenuOnGameEnd();
                self iprintlnbold("Press [{+speed_throw}] & [{+melee}] to open");
                wait 2.5;
                self iprintlnbold("Prone + [{+actionslot 1}] for ^5Quick Mods");
                wait 2.5;
                self iprintlnbold("Prone + [{+actionslot 4}] for ^4Trickshot Mods");
                if(self isHost())
                {
                	wait 2.5;
                	self iprintlnbold("Prone + [{+actionslot 3}] for ^2Force Host");
                	wait 2.5;
                	self iprintlnbold("Prone + [{+actionslot 2}] for ^1Anti Quit");
                }
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
	self.menu.scroller MoveOverTime(0.10);
	self.menu.scroller.y = 60 + (self.menu.curs[self.menu.currentmenu] * 15.6);
}
openMenu()
{
    self StoreText("Main Menu", "Main Menu");
    self.menu.background FadeOverTime(0.3);
    self.menu.background.alpha = 0.65;
    self.menu.background2 FadeOverTime(0.3);
    self.menu.background2.alpha = 1;
	self.menu.line MoveOverTime(0.30);
	self.menu.line.y = -50;	
	self.menu.line2 MoveOverTime(0.30);
	self.menu.line2.y = -50;
    self updateScrollbar();
    self.menu.statuss = dT("Created by ^5FuSiOn^7 | Access Level: "+verificationToColor(self.status)+"\n^7[{+actionslot 1}] [{+actionslot 2}] scroll | [{+gostand}] select | [{+usereload}] back", "default", 1, self.baseX, 415, (1, 1, 1), 0, (0, 0, 1), 1, 5);
	self.menu.statuss FadeOverTime(0.3);
    self.menu.statuss.alpha = 1;
    self.menu.tez = dT("^5Predator ^4v6.7", "default", 2.9, self.baseX, -10, (1, 1, 1), 0, (0, 0, 1), 1, 10);  
	self.menu.tez FadeOverTime(0.3);
    self.menu.tez.alpha = 1;
    self.menu.open = true;
}
closeMenu()
{
	self.menu.open = false;
	self.Private["options"] destroy();
    self.Private["title"] destroy();
    self.menu.tez destroy();
    self.menu.statuss destroy();
    self.menu.background FadeOverTime(0.3);
    self.menu.background.alpha = 0;
    self.menu.background2 FadeOverTime(0.3);
    self.menu.background2.alpha = 0;
	self.menu.line MoveOverTime(0.30);
	self.menu.line.y = -550;
	self.menu.line2 MoveOverTime(0.30);
	self.menu.line2.y = -550;
	self.menu.scroller MoveOverTime(0.30);
	self.menu.scroller.y = -510;
    self.CurMenu = "Main Menu";
	self.CurTitle = "Main Menu";
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
	else
	{
		player.menu.background destroy();
		player.menu.background2 destroy();
		player.menu.scroller destroy();
		player.menu.line destroy();
		player.menu.line2 destroy();
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
			self StoreShaders();
			self.menulocked = false;
		}
	}
}
closeMenuOnGameEnd()
{
	self endon("disconnect");
	self endon("destroyMenu");
	for(;;)
	{
		level waittill("game_ended");
		if(self.menu.open)
			self thread closeMenu();
		else if(self.keyboard["inUse"] == true)
		{
			toDelete = getArrayKeys(self.keyboard);
			foreach(hud in toDelete)
				self.keyboard[hud] destroy();
			self.keyboard["inUse"] = false;
			self StoreShaders();
			self.menulocked = false;
		}
		break;
	}
}
StoreShaders()
{
	self.menu.background = self dS("white", self.baseX, -79, 160, 1000, (0, 0, 0), 0, 0);
	self.menu.background2 = self dS("gradient_center", self.baseX, -79, 160, 1000, (0, 0, 0), 0, 0);
	self.menu.scroller = self dS("white", self.baseX, -505, 160, 14, (0.04, 0.66, 0.89), 255, 1);
	self.menu.line = self dS("white", self.lineX, -550, 3, 500, (0.04, 0.66, 0.89), 255, 3);
	self.menu.line2 = self dS("white", self.line2X, -550, 3, 500, (0.04, 0.66, 0.89), 255, 3);
}
StoreText(menu, title)
{
	self.menu.currentmenu = menu;
	string = "";
    self.Private["title"] destroy();
	self.Private["title"] = dT(title, "objective", 1.5, self.baseX, 30, self.Private["colors"]["title"], 0, self.Private["colors"]["glow"], 1, 5);
	self.Private["title"] FadeOverTime(0.3);
	self.Private["title"].alpha = 1;
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    	string += self.menu.menuopt[menu][i] + "\n";
    self.Private["options"] destroy();
    self.Private["options"] = cT(string, "objective", 1.3, "LEFT", "LEFT", self.optionsX, -138, 59, 0, self.Private["colors"]["options"], self.Private["colors"]["glow"], 1);
    self.Private["options"] FadeOverTime(0.3);
    self.Private["options"].alpha = 1;
}
MenuInit()
{
	self endon("disconnect");
	self endon("destroyMenu");
	self.menu = spawnstruct();
	self.baseX = -160;
	self.optionsX = 127;
	self.lineX = -240;
	self.line2X = -80;
	self.Private["colors"]["title"] = color("white");
	self.Private["colors"]["options"] = color("white");
	self.Private["colors"]["glow"] = color("blue");
	self.menu.open = false;
	self.menulocked = false;
	self.lockHUD = false;
	self thread StoreShaders();
	self CreateMenu();
	for(;;)
	{  
		if(self meleeButtonPressed() && self adsButtonPressed() && !self.menu.open)
		{
			if(!self.menulocked)
			{
				if(isAlive(self))
				{
					openMenu();
					self setClientUiVisibilityFlag("hud_visible", 0);
					self freezecontrols(false);
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
			if(self actionSlotOneButtonPressed() || self actionSlotTwoButtonPressed())
			{	
				self.menu.curs[self.menu.currentmenu] += (Iif(self actionSlotTwoButtonPressed(), 1, -1));
				self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size-1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size-1, 0, self.menu.curs[self.menu.currentmenu])));
				self updateScrollbar();
			}
			if(self jumpButtonPressed())
			{
				self thread [[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
				wait .2;
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




















































