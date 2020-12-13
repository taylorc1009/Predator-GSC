CreateMenu()
{
	self aM("Main Menu", undefined, "Unverified");
	self aO("Main Menu", "Mod ^5"+self.name, ::quickMods);
	self aO("Main Menu", "^7Main Mods", ::submenu, "Main Mods", "Main Mods"); 
	self aO("Main Menu", "Message Menu", ::submenu, "Message Menu", "Message Menu");
	self aO("Main Menu", "Fun Menu", ::submenu, "Fun Menu", "Fun Menu");
	self aO("Main Menu", "Aimbot Menu", ::submenu, "Aimbot Menu", "Aimbot Menu");
	self aO("Main Menu", "Weapons Menu", ::submenu, "Weapons Menu", "Weapons Menu");
	self aO("Main Menu", "Lobby Settings", ::submenu, "Lobby Settings", "Lobby Settings");
	self aO("Main Menu", "Dvars Menu", ::submenu, "Dvars Menu", "Dvars Menu");
	self aO("Main Menu", "Theme Menu", ::submenu, "Theme Menu", "Theme Menu");
	self aO("Main Menu", "Bots Menu", ::submenu, "Bots Menu", "Bots Menu");
	self aO("Main Menu", "Bullets Menu", ::submenu, "Bullets Menu", "Bullets Menu");
	self aO("Main Menu", "Model Menu", ::submenu, "Model Menu", "Model Menu");
	self aO("Main Menu", "Killstreak Menu", ::submenu, "Killstreak Menu", "Killstreak Menu");
	self aO("Main Menu", "FX Menu", ::submenu, "FX Menu", "FX Menu");
	self aO("Main Menu", "Spawnables", ::submenu, "Spawnables", "Spawnables");
	self aO("Main Menu", "Team Menu", ::submenu, "Team Menu", "Team Menu");
	self aO("Main Menu", "Change Map", ::submenu, "Change Map", "Change Map");
	self aO("Main Menu", "Host Menu", ::submenu, "Host Menu", "Host Menu");
	self aO("Main Menu", "Players Menu", ::submenu, "PlayersMenu", "Players");
	self aO("Main Menu", "All Players", ::submenu, "All Players", "All Players");

	self aM("Main Mods", "Main Menu", "Verified");
	self aO("Main Mods", "God Mode", ::toggle_god);
	self aO("Main Mods", "Demigod Mode", ::toggledemigod);
	self aO("Main Mods", "Infinite Ammo", ::unlimited_ammo);
	self aO("Main Mods", "Infinite Ammo + Reload", ::unlimitedammowithreload);
	self aO("Main Mods", "Invisible", ::invis);
	self aO("Main Mods", "Speed X2", ::speed_x2);
    self aO("Main Mods", "All Perks", ::give_all_perks);
    self aO("Main Mods", "Multi Jump", ::Toggle_Multijump);
	self aO("Main Mods", "Change Class In Game", ::change_class);
	self aO("Main Mods", "Scorestreaks", ::giveall_scorestreaks, self);
	self aO("Main Mods", "NoClip", ::togglenoclip);
	self aO("Main Mods", "Teleport", ::doTeleport);
	self aO("Main Mods", "FOV", ::doSlider, "FOV");
	self aO("Main Mods", "Visions", ::Dovisions);
	self aO("Main Mods", "Auto Drop Shot", ::AutoDropshot);
	self aO("Main Mods", "Clone", ::cloneme);
	self aO("Main Mods", "Dead Clone", ::deadclone);
	self aO("Main Mods", "Revive After Death", ::reviveMeThread);
	self aO("Main Mods", "ESP", ::init_ESPWallHack);
	self aO("Main Mods", "Unlock All Trophies", ::unlockAllCheevos);
	self aO("Main Mods", "Suicide", ::commitSuicide);

	self aM("Message Menu", "Main Menu", "Admin");
	self aO("Message Menu", "^5>Replies<", ::submenu, "Replies", "Replies");
	self aO("Message Menu", ">Kind Messages<", ::submenu, "Kind Messages", "Kind Messages");
	self aO("Message Menu", ">Unkind Messages<", ::submenu, "Unkind Messages", "Unkind Messages");
	self aO("Message Menu", ">Advertisments<", ::submenu, "Advertisments", "Advertisments");
	self aO("Message Menu", ">Host Messages<^7", ::submenu, "Host Messages", "Host Messages");
	self aO("Message Menu", "How To Use The Menu", ::menuInstructions);
	self aO("Message Menu", "Type Custom Message", ::keyboard, 1);

	self aM("Replies", "Message Menu", "Admin");
	self aO("Replies", "Yes", ::typewriter, "Yes");
	self aO("Replies", "No", ::typewriter, "No");
	self aO("Replies", "Probably", ::typewriter, "Probably");
	self aO("Replies", "Maybe", ::typewriter, "Maybe");
	self aO("Replies", "I Don't Know", ::typewriter, "I dont know...");
	self aO("Replies", "Want Some?", ::typewriter, "Y'want some?");
	self aO("Replies", "What?", ::typewriter, "What?");
	self aO("Replies", "Why?", ::typewriter, "Why?");
	self aO("Replies", "How?", ::typewriter, "How?");
	self aO("Replies", "When?", ::typewriter, "When?");
	self aO("Replies", "Sorry", ::typewriter, "Sorry");
	self aO("Replies", "Going AFK", ::typewriter, "I'm going AFK a sec...");

	self aM("Kind Messages", "Message Menu", "Admin");
	self aO("Kind Messages", "Like", ::typewriter, "I like you");
	self aO("Kind Messages", "Really Like", ::typewriter, "I really like you");
	self aO("Kind Messages", "Love", ::typewriter, "I love you");
	self aO("Kind Messages", "Amazing", ::typewriter, "You're amazing!");
	self aO("Kind Messages", "Great At This", ::typewriter, "You're great at this!");
	self aO("Kind Messages", "Joking", ::typewriter, "I was joking... LMAO");
	self aO("Kind Messages", "Love You All", ::typewriter, "I love you all!");
	self aO("Kind Messages", "Host Is A Legend", ::typewriter, "^4"+level.hostName+" ^7is a fucking ^5LEGEND^7!");

	self aM("Unkind Messages", "Message Menu", "Admin");
	self aO("Unkind Messages", "STFU", ::typewriter, "STFU!");
	self aO("Unkind Messages", "GTFO", ::typewriter, "GTFO!");
	self aO("Unkind Messages", "Squeaker", ::typewriter, "Someone get that fucking squeaker out of here!");
	self aO("Unkind Messages", "Not Cool", ::typewriter, "Dude, you're not cool...");
	self aO("Unkind Messages", "Menu Is Better", ::typewriter, "My menu is better than your shitty menu, Go back to CFG!");
	self aO("Unkind Messages", "I Don't Care", ::typewriter, "I really couldn't care");
	self aO("Unkind Messages", "No One Cares", ::typewriter, "No one cares...");
	self aO("Unkind Messages", "Fuck Off", ::typewriter, "Fuck off!");
	self aO("Unkind Messages", "Kill Yourself", ::typewriter, "Kill yourself");
	self aO("Unkind Messages", "Derank?", ::typewriter, "Wanna get deranked?");
	
	self aM("Advertisments", "Message Menu", "Admin");
	self aO("Advertisments", "Creator & GSC Advert ^6<3^7", ::creatorMessage);
	self aO("Advertisments", "NGU", ::typewriter, "Visit ^5www.nextgenupdate.com ^7for OFW and CFW mods!");
	self aO("Advertisments", "Se7enSins", ::typewriter, "Visit ^2www.se7ensins.com ^7for the latest mods");
	self aO("Advertisments", "Portal Centric", ::typewriter, "Visit ^1portalcentric.net ^7for CFW mods");

	self aM("Host Messages", "Message Menu", "Host");
	self aO("Host Messages", "Stop Using Aimbot", ::typewriter, "Stop using aimbot FFS...");
	self aO("Host Messages", "Want Kicked?", ::typewriter, "Do you want kicked bro?");
	self aO("Host Messages", "Who's Host?", ::typewriter, "I'm your Host!");
	self aO("Host Messages", "Not Getting Menu", ::typewriter, "You're not getting the menu...");
	self aO("Host Messages", "$10 PayPal", ::typewriter, "Modded accounts are $10 PayPal");
	self aO("Host Messages", "Who's Hacking?", ::typewriter, "Who's hacking?");
	self aO("Host Messages", "Stop Spamming The Menu", ::typewriter, "Stop spamming the menu!");
	self aO("Host Messages", "Don't Spam The Menu", ::typewriter, "Don't spam the menu");
	self aO("Host Messages", "Unlock All Isn't Free", ::typewriter, "Unlock all isn't free");
	self aO("Host Messages", "Trickshot Last", ::typewriter, "Trickshot last or you get kicked!");
	self aO("Host Messages", "Quickscope Lobby", ::typewriter, "Quickscope or you get kicked!");

	self aM("Fun Menu", "Main Menu", "Admin");
	self aO("Fun Menu", "Third Person", ::giveTP);
	self aO("Fun Menu", "Nac Mod", ::checkNacWep);
	self aO("Fun Menu", "Backflip Mod", ::initBackflip);
	self aO("Fun Menu", "Save & Load Position", ::saveAndLoad);
	self aO("Fun Menu", "Trickshot Mods", ::trickMods);
	self aO("Fun Menu", "Drivable Car", ::spawnDrivableCar);
	self aO("Fun Menu", "Teleport Gun", ::ToggleTeleportGun);
	self aO("Fun Menu", "Kamikaze Bomber", ::kamikaze);
	self aO("Fun Menu", "Smoke Monster", ::initSmokeMonster);
	self aO("Fun Menu", "Fireballs", ::fireballstoggle);
	self aO("Fun Menu", "Walking Lodestar", ::Lodestartoggle);
	self aO("Fun Menu", "Light Sabers", ::givesabers);
	self aO("Fun Menu", "Electric Cherry", ::initElectricCherry);
	self aO("Fun Menu", "The Hulk v2", ::hulktoggle);
	self aO("Fun Menu", "Nova Gas", ::NovaGas);
	self aO("Fun Menu", "Human Torch", ::human_torch);
	self aO("Fun Menu", "Matrix", ::Matrixx);
	self aO("Fun Menu", "^5>Flyable Jet<", ::submenu, "Flyable Jet", "Flyable Jet");
	self aO("Fun Menu", ">Fun Menu 2<", ::submenu, "Fun Menu 2", "Fun Menu 2");

	self aM("Fun Menu 2", "Fun Menu", "Admin");
	self aO("Fun Menu 2", "Adventure Time", ::initAdventureTime);
	self aO("Fun Menu 2", "Pokemon", ::pokeBall);
	self aO("Fun Menu 2", "Jetpack", ::doJetPack);
	self aO("Fun Menu 2", "Roll Away Dog", ::RollAwayDog);
	self aO("Fun Menu 2", "Hunter", ::hunter);
	self aO("Fun Menu 2", "Forcefield", ::initBallthing);
	self aO("Fun Menu 2", "Centipede", ::Centipede);
	self aO("Fun Menu 2", "Light Man", ::initLightMan);
	self aO("Fun Menu 2", "Clown Shoes", ::dogshoes);
	self aO("Fun Menu 2", "Leap Frog", ::toggleleapfrog);
	self aO("Fun Menu 2", "Ride Hunter Killer", ::RideHunter);
	self aO("Fun Menu 2", "Arrow Man", ::arrowMan);
	self aO("Fun Menu 2", "Crosshair", ::crosshairself);
	self aO("Fun Menu 2", "Dead Ops Arcade", ::DeadOpsArc);
	self aO("Fun Menu 2", "Super Grenades", ::initSuperNades);
	self aO("Fun Menu 2", "PHD Flopper", ::Toggle_PHDFLOPPER);
	self aO("Fun Menu 2", "Spectate Grenade", ::initSpecNade);
	self aO("Fun Menu 2", "Exorcist", ::exorcistToggle);
	self aO("Fun Menu 2", "Rotor Head", ::SpinnerHead);
	
	self aM("Flyable Jet", "Fun Menu", "Admin");
	self aO("Flyable Jet", "Spawn Jet", ::initFlyableJetMe);
	self aO("Flyable Jet", "Warthog Model", ::switchFJetModelMe, "veh_t6_air_a10f_alt", "Warthog");
	self aO("Flyable Jet", "Lightning Strike Model", ::switchFJetModelMe, "veh_t6_air_fa38_killstreak", "Lightning Strike");
	self aO("Flyable Jet", "Lodestar Model", ::switchFJetModelMe, "veh_t6_drone_pegasus_mp", "Lodestar");
	self aO("Flyable Jet", "VTOL Model", ::switchFJetModelMe, "veh_t6_air_v78_vtol_killstreak", "VTOL");
	self aO("Flyable Jet", "UAV Model", ::switchFJetModelMe, "veh_t6_drone_uav", "UAV");
	
	self aM("Aimbot Menu", "Main Menu", "Admin");
	self aO("Aimbot Menu", "Funny Combat Axe", ::funnyCAxe);
	self aO("Aimbot Menu", "Combat Axe Aimbot", ::toggleCAxeAim);
	self aO("Aimbot Menu", "Trickshot Aimbot", ::toggledAimTrick);
	self aO("Aimbot Menu", "Change Trickshot Tag", ::changeAimbotTag);
	self aO("Aimbot Menu", "Unfair Aimbot", ::unfairAimbot);
	self aO("Aimbot Menu", "Crosshair Aimbot", ::doAimbot);
	self aO("Aimbot Menu", "Super Legit Aimbot v4", ::tgl_MainRootAimbot2);
	self aO("Aimbot Menu", "Aiming Required", ::aimRequired);
	
	self aM("Weapons Menu", "Main Menu", "Verified");
	self aO("Weapons Menu", "^5>Camos<", ::submenu, "Camos", "Camos");
	self aO("Weapons Menu", ">Modded Weapons<", ::submenu, "Modded Weapons", "Modded Weapons");
	self aO("Weapons Menu", ">Normal Weapons<", ::submenu, "Normal Weapons", "Normal Weapons");
	self aO("Weapons Menu", ">Weapon Models<", ::submenu, "Weapon Models", "Weapon Models");

	self aM("Camos", "Weapons Menu", "Verified");
	self aO("Camos", "Random Camo", ::CamoChanger);
    self aO("Camos", "Random DLC Camo", ::DLCCamoChanger);
    self aO("Camos", "Diamond", ::givecamo, 16);
    self aO("Camos", "Gold", ::givecamo, 15);
    self aO("Camos", "Weaponized", ::givecamo, 43);
    self aO("Camos", "Dragon", ::givecamo, 32);
    self aO("Camos", "Ghosts", ::givecamo, 29);
    self aO("Camos", "Afterlife", ::givecamo, 44);
    self aO("Camos", "Cyborg", ::givecamo, 31);
    self aO("Camos", "CE Digital", ::givecamo, 18);
	
	self aM("Modded Weapons", "Weapons Menu", "VIP");
	self aO("Modded Weapons", "Raygun", ::initRaygun);
	self aO("Modded Weapons", "Raygun Mk. II", ::initRaygunM2);
	self aO("Modded Weapons", "Raygun Mk. III", ::initRaygunM3);
    self aO("Modded Weapons", "Thunder Gun", ::ThunGun);
    self aO("Modded Weapons", "Mustang And Sally", ::ToggleMustangGun);
    self aO("Modded Weapons", "Rocket Teleporter", ::initRocketTeleport);
    self aO("Modded Weapons", "Ballistic Teleporter", ::toggleknifetele);
	self aO("Modded Weapons", "Glitched Fiveseven", ::giveWeapon, "fiveseven_lh_mp");
	self aO("Modded Weapons", "Default Weapon", ::defaultweapon);
	self aO("Modded Weapons", "Water Shield", ::CrazyRiotShield);
	self aO("Modded Weapons", "Dragons Breath", ::ToggleDragonGun);
	self aO("Modded Weapons", "Electric Gun", ::toggle_lightGun);
	self aO("Modded Weapons", "Death Rocket Gun", ::shootvadertog);
	self aO("Modded Weapons", "Super Executioner", ::initSuperMagnum);
	self aO("Modded Weapons", "Maniac Knife", ::giveWeapon, "knife_mp");
	
	self aM("Normal Weapons", "Weapons Menu", "Verified");
    self aO("Normal Weapons", "^5>Assault Rifles<", ::submenu, "Assault Rifles", "Assault Rifles");
    self aO("Normal Weapons", ">Submachine Guns<", ::submenu, "Submachine Guns", "Submachine Guns");
    self aO("Normal Weapons", ">Light Machine Guns<", ::submenu, "Light Machine Guns", "Light Machine Guns");
    self aO("Normal Weapons", ">Sniper Rifles<", ::submenu, "Sniper Rifles", "Sniper Rifles");
    self aO("Normal Weapons", ">Shotguns<", ::submenu, "Shotguns", "Shotguns");
    self aO("Normal Weapons", ">Pistols<", ::submenu, "Pistols", "Pistols");
    self aO("Normal Weapons", ">Launchers<", ::submenu , "Launchers", "Launchers");
    self aO("Normal Weapons", ">Specials<", ::submenu, "Specials", "Specials");
    
    self aM("Submachine Guns", "Normal Weapons", "Verified");
	self aO("Submachine Guns", "MP7", ::giveWeapon, "mp7_mp");
	self aO("Submachine Guns", "PDW-57", ::giveWeapon, "pdw57_mp");
	self aO("Submachine Guns", "Vector-K10", ::giveWeapon, "vector_mp");
	self aO("Submachine Guns", "MSMC", ::giveWeapon, "insas_mp");
	self aO("Submachine Guns", "Chicom CQB", ::giveWeapon, "qcw05_mp");
	self aO("Submachine Guns", "Skorpion EVO", ::giveWeapon, "evoskorpion_mp");
	self aO("Submachine Guns", "Peacekeeper", ::giveWeapon, "peacekeeper_mp");

	self aM("Assault Rifles", "Normal Weapons", "Verified");
	self aO("Assault Rifles", "MTAR", ::giveWeapon, "tar21_mp");
	self aO("Assault Rifles", "Type 25", ::giveWeapon, "type95_mp");
	self aO("Assault Rifles", "SWAT-556", ::giveWeapon, "sig556_mp");
	self aO("Assault Rifles", "FAL OSW", ::giveWeapon, "sa58_mp");
	self aO("Assault Rifles", "M27", ::giveWeapon, "hk416_mp");
	self aO("Assault Rifles", "SCAR-H", ::giveWeapon, "scar_mp");
	self aO("Assault Rifles", "SMR", ::giveWeapon, "saritch_mp");
	self aO("Assault Rifles", "M8A1", ::giveWeapon, "xm8_mp");
	self aO("Assault Rifles", "AN-94", ::giveWeapon, "an94_mp");

	self aM("Shotguns", "Normal Weapons", "Verified");
	self aO("Shotguns", "R870 MCS", ::giveWeapon, "870mcs_mp");
	self aO("Shotguns", "S12", ::giveWeapon, "saiga12_mp");
	self aO("Shotguns", "KSG", ::giveWeapon, "ksg_mp");
	self aO("Shotguns", "M1216", ::giveWeapon, "srm1216_mp");

	self aM("Light Machine Guns", "Normal Weapons", "Verified");
	self aO("Light Machine Guns", "MK 48", ::giveWeapon, "mk48_mp");
	self aO("Light Machine Guns", "QBB LSW", ::giveWeapon, "qbb95_mp");
	self aO("Light Machine Guns", "LSAT", ::giveWeapon, "lsat_mp");
	self aO("Light Machine Guns", "HAMR", ::giveWeapon, "hamr_mp");

	self aM("Sniper Rifles", "Normal Weapons", "Verified");
	self aO("Sniper Rifles", "SVU-AS", ::giveWeapon, "svu_mp");
	self aO("Sniper Rifles", "DSR 50", ::giveWeapon, "dsr50_mp");
	self aO("Sniper Rifles", "Ballista", ::giveWeapon, "ballista_mp");
	self aO("Sniper Rifles", "XPR-50", ::giveWeapon, "as50_mp");

	self aM("Pistols", "Normal Weapons", "Verified");
	self aO("Pistols", "Five-Seven", ::giveWeapon, "fiveseven_mp");
	self aO("Pistols", "Tac-45", ::giveWeapon, "fnp45_mp");
	self aO("Pistols", "B23R", ::giveWeapon, "beretta93r_mp");
	self aO("Pistols", "Executioner", ::giveWeapon, "judge_mp");
	self aO("Pistols", "KAP-40", ::giveWeapon, "kard_mp");

	self aM("Launchers", "Normal Weapons", "Verified");
	self aO("Launchers", "SMAW", ::giveWeapon, "smaw_mp");
	self aO("Launchers", "RPG", ::giveWeapon, "usrpg_mp");

	self aM("Specials", "Normal Weapons", "Verified");
	self aO("Specials", "Assault Shield", ::giveWeapon, "riotshield_mp");
	self aO("Specials", "Ballistic Knife", ::giveWeapon, "knife_ballistic_mp");
	self aO("Specials", "Crossbow", ::giveWeapon, "crossbow_mp");
	
	self aM("Weapon Models", "Weapons Menu", "Admin");
	self aO("Weapon Models", "Reset", ::resetWeaponModel);
	self aO("Weapon Models", "Hunter Killer", ::changeWeaponModel, "veh_t6_drone_hunterkiller");
	self aO("Weapon Models", "Glitched Gun", ::changeWeaponModel, "veh_t6_drone_tank");
	self aO("Weapon Models", "Arrows", ::changeWeaponModel, "fx_axis_createfx");
	self aO("Weapon Models", "Dog", ::changeWeaponModel, "german_shepherd");
	self aO("Weapon Models", "RCXD", ::changeWeaponModel, "veh_t6_drone_rcxd");
	self aO("Weapon Models", "Heli Gunner Missile", ::changeWeaponModel, "projectile_hellfire_missile");
	self aO("Weapon Models", "No Hands", ::changeWeaponModel, "viewmodel_hands_no_model");
	
	self aM("Lobby Settings", "Main Menu", "Host");
	self aO("Lobby Settings", "Anti Quit", ::antiQuit);
	self aO("Lobby Settings", "Hear All Players", ::hearallplayers);
	self aO("Lobby Settings", "Long Melee", ::meleerange);
	self aO("Lobby Settings", "Gravity", ::gravity);
	self aO("Lobby Settings", "Super Jump", ::ToggleSuperJump);
	self aO("Lobby Settings", "Super Speed", ::superSpeed);
	self aO("Lobby Settings", "Flash Feed", ::doFlashFeed);
	self aO("Lobby Settings", "Timescale", ::changeTimescale);
	self aO("Lobby Settings", "Infinite Game", ::InfGame);
	self aO("Lobby Settings", "Fast Restart", ::doRestart);
	self aO("Lobby Settings", "Low Ammo Flash", ::flashlowammo);
	self aO("Lobby Settings", "End Game", ::doEndGame);
	self aO("Lobby Settings", "Pause Game", ::PauseGame);
	self aO("Lobby Settings", "Sniper Lobby", ::initSniperLobby);
	self aO("Lobby Settings", "Unlock All Lobby", ::unlockLobby);
	self aO("Lobby Settings", "Plant Bomb ^1(S&D)", ::PlantBomb);
	self aO("Lobby Settings", "^7Defuse Bomb ^1(S&D)", ::DefuseBomb);
	self aO("Lobby Settings", "^5>Change XP<", ::submenu, "Change XP", "Change XP");
	self aO("Lobby Settings", ">Change Minimap<", ::submenu, "Change Minimap", "Change Minimap");
	
	self aM("Change XP", "Lobby Settings", "Host");
	self aO("Change XP", "100 XP", ::BigXP, 100);
	self aO("Change XP", "1 XP", ::BigXP, 1);
	self aO("Change XP", "420 XP", ::BigXP, 420);
	self aO("Change XP", "1337 XP", ::BigXP, 1337);
	self aO("Change XP", "1000000 XP", ::BigXP, 1000000);
	self aO("Change XP", "2147483647 XP", ::BigXP, 2147483647);
	
	self aM("Change Minimap", "Lobby Settings", "Host");
	self aO("Change Minimap", "Reset", ::ChangeMiniMap, "compass_map_"+getdvar("mapname"));
	self aO("Change Minimap", "Parallelogram", ::ChangeMiniMap, "hud_mp_vis_ks_dpad_box");
	self aO("Change Minimap", "Connecting", ::ChangeMiniMap, "hud_status_connecting");
	self aO("Change Minimap", "Extra Cam", ::ChangeMiniMap, "extracam2d");
	self aO("Change Minimap", "DSR", ::ChangeMiniMap, "menu_mp_weapons_dsr1_big");
	self aO("Change Minimap", "Infinity", ::ChangeMiniMap, "hud_infinity");
	self aO("Change Minimap", "Current Map Load Screen", ::ChangeMiniMap, "loadscreen_"+getdvar("mapname"));
	self aO("Change Minimap", "Treyach Loading", ::ChangeMiniMap, "lui_loader_no_offset");
	self aO("Change Minimap", "Twitter", ::ChangeMiniMap, "menu_lobby_icon_twitter");
	self aO("Change Minimap", "Facebook", ::ChangeMiniMap, "menu_lobby_icon_facebook");
	self aO("Change Minimap", "Diner Load Screen", ::ChangeMiniMap, "loadscreen_zm_transit_dr_zcleansed_diner");
	self aO("Change Minimap", "Sam Turret", ::ChangeMiniMap, "compass_sam_turret_red");
	self aO("Change Minimap", "Platinum Series", ::ChangeMiniMap, "menu_div_pro_64");
	self aO("Change Minimap", "Weird Circle", ::ChangeMiniMap, "poison");
	self aO("Change Minimap", "Sun Glare", ::ChangeMiniMap, "light_corona");
	self aO("Change Minimap", "Like", ::ChangeMiniMap, "menu_mp_lobby_like");
	if(is_ps3())
		self aO("Change Minimap", "PS3 Controller", ::ChangeMiniMap, "ps3_controller_top");
	if(is_xenon())
		self aO("Change Minimap", "Xbox Controller", ::ChangeMiniMap, "xenon_controller_top");
	if(is_pc())
		self aO("Change Minimap", "Mouse", ::ChangeMiniMap, "button_middle_mouse");
	
	self aM("Dvars Menu", "Main Menu", "Host");
	self aO("Dvars Menu", "Ladder Jump", ::ladderjump);
	self aO("Dvars Menu", "Across Map Weapons", ::accrossweapons);
	self aO("Dvars Menu", "Names Through Walls", ::NAMESTHROUGHWALLS);
	self aO("Dvars Menu", "Disco Sun", ::discoSun);
	self aO("Dvars Menu", "15 Second Killcam", ::longkillcam);
	self aO("Dvars Menu", "360 Ladder/Prone", ::pl360);
	self aO("Dvars Menu", "Rapid Fire", ::rapidFire);
	self aO("Dvars Menu", "Big Names", ::dobig);
	self aO("Dvars Menu", "Bouncy Grenades", ::bouncygrenades);
	self aO("Dvars Menu", "Lag Switch", ::LagSwitch);
	self aO("Dvars Menu", "Sky Color", ::DoSky);
	self aO("Dvars Menu", "No Bob", ::togglecamera);
	self aO("Dvars Menu", "Super Reload", ::superreload);
	self aO("Dvars Menu", "Crosshair", ::togglecrosshair);

	self aM("Bots Menu", "Main Menu", "Co-Host");
	self aO("Bots Menu", "Spawn 1 Bot", ::spawnBots, 1);
	self aO("Bots Menu", "Spawn 2 Bots", ::spawnBots, 2);
	self aO("Bots Menu", "Spawn 3 Bots", ::spawnBots, 3);
	self aO("Bots Menu", "Spawn 4 Bots", ::spawnBots, 4);
	self aO("Bots Menu", "Spawn 5 Bots", ::spawnBots, 5);
	self aO("Bots Menu", "Spawn 6 Bots", ::spawnBots, 6);
	self aO("Bots Menu", "Spawn 7 Bots", ::spawnBots, 7);
	self aO("Bots Menu", "Spawn 8 Bots", ::spawnBots, 8);
	self aO("Bots Menu", "Spawn 9 Bots", ::spawnBots, 9);
	self aO("Bots Menu", "Spawn 10 Bots", ::spawnBots, 10);
	self aO("Bots Menu", "Spawn 11 Bots", ::spawnBots, 11);
	self aO("Bots Menu", "Spawn 12 Bots", ::spawnBots, 12);
	self aO("Bots Menu", "Spawn 13 Bots", ::spawnBots, 13);
	self aO("Bots Menu", "Spawn 14 Bots", ::spawnBots, 14);
	self aO("Bots Menu", "Spawn 15 Bots", ::spawnBots, 15);
	self aO("Bots Menu", "Spawn 16 Bots", ::spawnBots, 16);
	self aO("Bots Menu", "Fill Lobby", ::spawnBots, 17);
	self aO("Bots Menu", "Kick All Bots", ::kickAllBots);

	self aM("Bullets Menu", "Main Menu", "Admin");
	self aO("Bullets Menu", "Explosive", ::ExpBultOn);
	self aO("Bullets Menu", "No FX Explosive", ::noFXExpBultOn);
	if(getDvar("mapname") == "mp_nuketown_2020")
		self aO("Bullets Menu", "Nuke", ::initNukeBullets);
	self aO("Bullets Menu", "EMP", ::initEMPBullets);
	self aO("Bullets Menu", "^5>Modded Bullets<", ::submenu, "Modded Bullets", "Modded Bullets");
	self aO("Bullets Menu", ">Equipment Bullets<", ::submenu, "Equipment Bullets", "Equipment Bullets");
	self aO("Bullets Menu", ">FX Bullets<", ::submenu, "FX Bullets", "FX Bullets");
	self aO("Bullets Menu", ">Model Bullets<", ::submenu, "Model Bullets", "Model Bullets");
	self aO("Bullets Menu", ">Real Bullets<", ::submenu, "Real Bullets", "Real Bullets");
	self aO("Bullets Menu", ">Lethal Models<", ::submenu, "Lethal Models", "Lethal Models");
	
	self aM("Real Bullets", "Bullets Menu", "Host");
	self aO("Real Bullets", "Care Package", ::doRealCPBullets);
	self aO("Real Bullets", "Dogs", ::spawnDog, "player.team");
	self aO("Real Bullets", "Change Dog Model", ::setDogModel);
	
	self aM("Modded Bullets", "Bullets Menu", "Admin");
	self aO("Modded Bullets", "Modded Bullets ^5ON^7/^4OFF", ::initMagicBullet);
	self aO("Modded Bullets", "^7SMAW", ::doChangeBullet, "smaw_mp", 3);
	self aO("Modded Bullets", "War Machine", ::doChangeBullet, "m32_mp", 3);
	self aO("Modded Bullets", "AGR", ::doChangeBullet, "ai_tank_drone_rocket_mp", 3);
	self aO("Modded Bullets", "Hellstorm", ::doChangeBullet, "remote_missile_bomblet_mp", 3);
	self aO("Modded Bullets", "Warthog", ::doChangeBullet, "straferun_rockets_mp", 3);
	self aO("Modded Bullets", "Heli Gunner Missle", ::doChangeBullet, "heli_gunner_rockets_mp", 3);
	self aO("Modded Bullets", "Swarm", ::doChangeBullet, "missile_swarm_projectile_mp", 3);
	self aO("Modded Bullets", "Hunter Killer", ::doChangeBullet, "missile_drone_projectile_mp", 3);
	self aO("Modded Bullets", "Remote Missile", ::doChangeBullet, "remote_missile_missile_mp", 3);
	self aO("Modded Bullets", "Remington", ::doChangeBullet, "870mcs_mp", 3);
	self aO("Modded Bullets", "Lodestar", ::doChangeBullet, "remote_mortar_missile_mp", 3);

	self aM("Equipment Bullets", "Bullets Menu", "Admin");
	self aO("Equipment Bullets", "Equipment Bullets ^5ON^7/^4OFF", ::initMagicGrenade);
	self aO("Equipment Bullets", "^7Frag Grenade", ::doChangeBullet, "frag_grenade_mp", 2);
	self aO("Equipment Bullets", "Semtex", ::doChangeBullet, "sticky_grenade_mp", 2);
	self aO("Equipment Bullets", "Concussion", ::doChangeBullet, "concussion_grenade_mp", 2);
	self aO("Equipment Bullets", "Flashbang", ::doChangeBullet, "flash_grenade_mp", 2);
	self aO("Equipment Bullets", "EMP Grenade", ::doChangeBullet, "emp_grenade_mp", 2);
	self aO("Equipment Bullets", "Sensor Grenade", ::doChangeBullet, "sensor_grenade_mp", 2);
	self aO("Equipment Bullets", "C4", ::doChangeBullet, "satchel_charge_mp", 2);
	self aO("Equipment Bullets", "Claymore", ::doChangeBullet, "claymore_mp", 2);
	self aO("Equipment Bullets", "Smoke Grenade", ::doChangeBullet, "willy_pete_mp", 2);
	self aO("Equipment Bullets", "Trophy System", ::doChangeBullet, "trophy_system_mp", 2);
	self aO("Equipment Bullets", "Combat Axe", ::doChangeBullet, "hatchet_mp", 2);
	self aO("Equipment Bullets", "Shock Charge", ::doChangeBullet, "proximity_grenade_mp", 2);

	self aM("FX Bullets", "Bullets Menu", "Admin");
	self aO("FX Bullets", "FX Bullets ^5ON^7/^4OFF^7", ::initMagicFX);
	if(!(getDvar("mapname")== "mp_magma" || getDvar("mapname")== "mp_hydro" || getDvar("mapname")== "mp_uplink" || getDvar("mapname")== "mp_hydro"))
	{
		self aO("FX Bullets", "Glass", ::doChangeBullet, level.glassfx, 1);
		self aO("FX Bullets", "Hardpoint Arrows", ::doChangeBullet, level.wtfdude, 1);
		self aO("FX Bullets", "Shock Charge", ::doChangeBullet, level.electrical, 1);
		self aO("FX Bullets", "Sensor Grenade", ::doChangeBullet, level.grnorb, 1);
		self aO("FX Bullets", "Smoke", ::doChangeBullet, level.cloud, 1);
	}
	if(getDvar("mapname") != "mp_hydro")
	{
		self aO("FX Bullets", "Light", ::doChangeBullet, level.gershfx, 1);
		self aO("FX Bullets", "Water", ::doChangeBullet, level.majw, 1);
		self aO("FX Bullets", "Dirt", ::doChangeBullet, level.tnkdrt, 1);
	}
	self aO("FX Bullets", "Flares", ::doChangeBullet, level.flares, 1);
	self aO("FX Bullets", "Jet Explosion", ::doChangeBullet, level.Jetexplo, 1);
	self aO("FX Bullets", "Lightning Strike", ::doChangeBullet, level.remote_mortar_fx["missileExplode"], 1);
	if(!(getDvar("mapname")=="mp_studio" || getDvar("mapname")=="mp_la" || getDvar("mapname")=="mp_concert" || getDvar("mapname")=="mp_magma" || getDvar("mapname")=="mp_hydro"))
		self aO("FX Bullets", "Blood", ::doChangeBullet, level.bloody, 1);
	
	self aM("Model Bullets", "Bullets Menu", "Admin");
	self aO("Model Bullets", "Model Bullets ^5ON^7/^4OFF^7", ::doModelBullets, "t6_wpn_supply_drop_ally", 4);
	self aO("Model Bullets", "Care Packages", ::doChangeBullet, "t6_wpn_supply_drop_ally", 4);
	self aO("Model Bullets", "Red Care Packages", ::doChangeBullet, "t6_wpn_supply_drop_detect", 4);
	self aO("Model Bullets", "Default Actors", ::doChangeBullet, "defaultactor", 4);
	self aO("Model Bullets", "Dogs", ::doChangeBullet, "german_shepherd", 4);
	
	self aM("Lethal Models", "Bullets Menu", "Admin");
	self aO("Lethal Models", "Lethal Models ^5ON^7/^4OFF^7", ::initLethalModel);
	self aO("Lethal Models", "Flag", ::ChangeLModel, "mp_flag_red");
	self aO("Lethal Models", "Default Actor", ::ChangeLModel, "defaultactor");
	self aO("Lethal Models", "Arrows", ::ChangeLModel, "fx_axis_createfx");
	self aO("Lethal Models", "VTOL", ::ChangeLModel, "veh_t6_air_v78_vtol_killstreak");
	self aO("Lethal Models", "Care Package", ::ChangeLModel, "t6_wpn_supply_drop_ally");
	
	self aM("Model Menu", "Main Menu", "VIP");
	self aO("Model Menu", "Real Default Actor", ::doRealDefault);
	self aO("Model Menu", "Reset", ::doResetModel);
	self aO("Model Menu", "Default Vehicle", ::doSetModel, "defaultvehicle");
	self aO("Model Menu", "Default Actor", ::doSetModel, "defaultactor");
	self aO("Model Menu", "VTOL", ::doSetModel, "veh_t6_air_v78_vtol_killstreak");
	self aO("Model Menu", "Flag", ::doSetModel, "mp_flag_green");
	self aO("Model Menu", "Escort Drone", ::doSetModel, "veh_t6_drone_overwatch_light");
	self aO("Model Menu", "UAV", ::doSetModel, "veh_t6_drone_uav");
	self aO("Model Menu", "Arrows", ::doSetModel, "fx_axis_createfx");
	self aO("Model Menu", "Suitcase Bomb", ::doSetModel, "prop_suitcase_bomb");
	self aO("Model Menu", "AGR", ::doSetModel, "veh_t6_drone_tank");
	self aO("Model Menu", "Red Sentry Gun", ::doSetModel, "t6_wpn_turret_sentry_gun_red");
	self aO("Model Menu", "Dog Tags", ::doSetModel, "p6_dogtags");
	self aO("Model Menu", "Dog", ::doSetModel, "german_shepherd");
	self aO("Model Menu", "Care Package", ::doSetModel, "t6_wpn_supply_drop_ally");
	self aO("Model Menu", "Red Care Package", ::doSetModel, "t6_wpn_supply_drop_detect");
	self aO("Model Menu", "Lightning Strike", ::doSetModel, "veh_t6_air_fa38_killstreak");
	self aO("Model Menu", "Lodestar", ::doSetModel, "veh_t6_drone_pegasus_mp");
	self aO("Model Menu", "Train Track", ::doSetModel, "p6_express_train_track_a01");
		
	self aM("Killstreak Menu", "Main Menu", "VIP");
	self aO("Killstreak Menu", "^5>Normal Killstreaks<", ::submenu, "Normal Killstreaks", "Normal Killstreaks");
	self aO("Killstreak Menu", ">Modded Killstreaks<", ::submenu, "Modded Killstreaks", "Modded Killstreaks");

	self aM("Normal Killstreaks", "Killstreak Menu", "VIP");
	self aO("Normal Killstreaks", "UAV", ::initGiveKS, "killstreak_spyplane", 0);
    self aO("Normal Killstreaks", "RC-XD", ::initGiveKS, "killstreak_rcbomb", 0);
    self aO("Normal Killstreaks", "Hunter Killer", ::initGiveKS, "missile_drone_mp", 1);
    self aO("Normal Killstreaks", "Care Package", ::initGiveKS, "supplydrop_mp", 1);
    self aO("Normal Killstreaks", "Counter UAV", ::initGiveKS, "killstreak_counteruav", 0);
    self aO("Normal Killstreaks", "Gaurdian", ::initGiveKS, "microwaveturret_mp", 1);
    self aO("Normal Killstreaks", "Hellstorm Missile", ::initGiveKS, "killstreak_remote_missile", 0);
    self aO("Normal Killstreaks", "Lightning Strike", ::initGiveKS, "killstreak_planemortar", 0);
    self aO("Normal Killstreaks", "Sentry Gun", ::initGiveKS, "autoturret_mp", 1);
    self aO("Normal Killstreaks", "Minigun", ::initGiveKS, "minigun_mp", 1);
	self aO("Normal Killstreaks", "War Machine", ::initGiveKS, "m32_mp", 1);
    self aO("Normal Killstreaks", "AGR", ::initGiveKS, "ai_tank_drop_mp", 1);
    self aO("Normal Killstreaks", "Stealth Chopper", ::initGiveKS, "killstreak_helicopter_comlink", 0);
    self aO("Normal Killstreaks", "Orbital VSAT", ::initGiveKS, "killstreak_spyplane_direction", 0);
    self aO("Normal Killstreaks", "Escort Drone", ::initGiveKS, "killstreak_helicopter_guard", 0);
    self aO("Normal Killstreaks", "EMP System", ::initGiveKS, "emp_mp", 1);
    self aO("Normal Killstreaks", "Warthog", ::initGiveKS, "killstreak_straferun", 0);
    self aO("Normal Killstreaks", "Lodestar", ::initGiveKS, "killstreak_remote_mortar", 0);
    self aO("Normal Killstreaks", "VTOL Warship", ::initGiveKS, "helicopter_player_gunner_mp", 1);
    self aO("Normal Killstreaks", "Swarm", ::initGiveKS, "killstreak_missile_swarm", 0);

	self aM("Modded Killstreaks", "Killstreak Menu", "Host");
	self aO("Modded Killstreaks", "Pet Chopper", ::SSH);
	self aO("Modded Killstreaks", "Colossus Airstrike", ::doAS);
	self aO("Modded Killstreaks", "Circling Plane", ::circlingPlane);
	self aO("Modded Killstreaks", "W@W Artillery", ::makeArtillery);
	self aO("Modded Killstreaks", "Missile Barrage", ::MBarrage);
	self aO("Modded Killstreaks", "Predator Missile", ::spawnMissle);
    self aO("Modded Killstreaks", "Strafe Run", ::doStrafeRun);
    self aO("Modded Killstreaks", "Jericho Missles", ::initJericho);
    self aO("Modded Killstreaks", "MW2 Nuke", ::initMW2Nuke);
    self aO("Modded Killstreaks", "IMS", ::IMSMW3);
    self aO("Modded Killstreaks", "Mega Airdrop", ::MegaAirDrop);
	self aO("Modded Killstreaks", "Missile System", ::MissileSystem);
	
	self aM("FX Menu", "Main Menu", "Admin");
    self aO("FX Menu", "^5>Player FX<", ::submenu, "Player FX", "Player FX");
    self aO("FX Menu", ">Sky FX<", ::submenu, "Sky FX", "Sky FX");
	
	self aM("Player FX", "FX Menu", "Admin");
    self aO("Player FX", "Player FX ^5ON^7/^4OFF^7", ::initFXMan);
    if(!(getDvar("mapname")== "mp_hydro"))
    {
    	self aO("Player FX", "Feathers", ::ChangePFX, "impacts/fx_cushion_hit", "feathers");
    	self aO("Player FX", "Snow", ::ChangePFX, "vehicle/treadfx/fx_heli_snow_spray", "snow");
		self aO("Player FX", "Glass", ::ChangePFX, "impacts/fx_large_glass", "glass");
    }
    self aO("Player FX", "Water", ::ChangePFX, "vehicle/treadfx/fx_heli_water_spray", "water");
    self aO("Player FX", "Blood", ::ChangePFX, "impacts/fx_deathfx_dogbite", "blood");
    self aO("Player FX", "Fire", ::ChangePFX, "weapon/talon/fx_muz_talon_rocket_flash_1p", "fire");
    self aO("Player FX", "Exploding", ::ChangePFX, "weapon/bouncing_betty/fx_betty_destroyed", "exploding");
    self aO("Player FX", "Sparks", ::ChangePFX, "weapon/qr_drone/fx_qr_drone_impact_sparks", "sparks");
	if(!(getDvar("mapname")=="mp_la" || getDvar("mapname")=="mp_concert" || getDvar("mapname")=="mp_magma" || getDvar("mapname")== "mp_uplink" || getDvar("mapname")=="mp_hydro"))
    	self aO("Player FX", "Leaves", ::ChangePFX, "impacts/fx_small_foliage", "leaves");
	self aO("Player FX", "Electric", ::ChangePFX, "prox_grenade_player_shock", "electric");
	
	self aM("Sky FX", "FX Menu", "Host");
    self aO("Sky FX", "Sky FX ^5ON^7/^4OFF^7", ::LetsLightTheUP);
	self aO("Sky FX", "Flares", ::ChangeSkyFX, level.chapowereareu, "flares");
	self aO("Sky FX", "Lightning Strikes", ::ChangeSkyFX, level.remote_mortar_fx["missileExplode"], "Lightning Strikes");
	self aO("Sky FX", "Jet Explosion", ::ChangeSkyFX, level.Jetexplo, "jet explosions");
	if(!(getDvar("mapname")== "mp_hydro"))
    {
		self aO("Sky FX", "Water", ::ChangeSkyFX, level.majw, "water");
		self aO("Sky FX", "Dirt", ::ChangeSkyFX, level.tnkdrt, "dirt");
	}
	if(!(getDvar("mapname")== "mp_magma" || getDvar("mapname")== "mp_hydro" || getDvar("mapname")== "mp_uplink"))
		self aO("Sky FX", "Smoke", ::ChangeSkyFX, level.cloud, "smoke");
	
	self aM("Spawnables", "Main Menu", "Co-Host");
	self aO("Spawnables", "Advanced Forge Mode", ::ToggleForgeMode);
	self aO("Spawnables", "Fast Delete", ::initFastDelete);
	self aO("Spawnables", "AGR Army", ::AGR_ARMY);
	self aO("Spawnables", "Spiral Stairs", ::SpiralStairs);
	self aO("Spawnables", "Platform", ::Platform);
	self aO("Spawnables", "Pack-A-Punch", ::packapunch);
	self aO("Spawnables", "Spinning Crate", ::SpinningCrate);
    self aO("Spawnables", "Flipping Crate", ::FlippingCrate);
	self aO("Spawnables", "Rolling Crate", ::RollingCrate);
	self aO("Spawnables", "Windmill", ::WindMill);
	self aO("Spawnables", "Teleport Flags", ::initTeletoFlag);
	self aO("Spawnables", "Bunker", ::BunkerThread);
	self aO("Spawnables", "Sky Plaza", ::skyplaza);
	self aO("Spawnables", "Jwm614's Bunker", ::bunkerspawn);
	self aO("Spawnables", "Stunt Plane", ::StuntRuninit);
	self aO("Spawnables", "VTOL Crash v2", ::forplanesoneex);
	self aO("Spawnables", "^5>Waves<", ::submenu, "Waves", "Waves");
	self aO("Spawnables", ">Rain Models<", ::submenu, "Rain Models", "Rain Models");
	self aO("Spawnables", ">Spawnables 2<", ::submenu, "Spawnables 2", "Spawnables 2");

	self aM("Spawnables 2", "Spawnables", "Co-Host");
	self aO("Spawnables 2", "Merry-Go-Round", ::build);
	self aO("Spawnables 2", "Exploding Warthog", ::ExplodingWarthog);
	self aO("Spawnables 2", "Kids Ride", ::ToggleKid);
	self aO("Spawnables 2", "VTOL Launch", ::SparklyRocket);
	self aO("Spawnables 2", "Blowjob", ::initBJ);
	self aO("Spawnables 2", "Ice Skater", ::Togsk8r);
	self aO("Spawnables 2", "3D Draw FX", ::ToggleDraw_Fx);
	self aO("Spawnables 2", "The Claw", ::Spawn_Claw);
	self aO("Spawnables 2", "Roller Coaster", ::initCoaster);
	
	self aM("Waves", "Spawnables", "Co-Host");
	self aO("Waves", "Default Actors", ::mexicanWave, "defaultactor");
	self aO("Waves", "Care Packages", ::mexicanWave, "t6_wpn_supply_drop_ally");
	self aO("Waves", "Red Sentry Guns", ::mexicanWave, "t6_wpn_turret_sentry_gun_red");
	self aO("Waves", "Warthogs", ::mexicanWave, "veh_t6_air_a10f_alt");
	self aO("Waves", "Hellstorms", ::mexicanWave, "projectile_sa6_missile_desert_mp");
	
	self aM("Rain Models", "Spawnables", "Host");
	self aO("Rain Models", "Rain Models ^5ON^7/^4OFF^7", ::initRainModels);
	self aO("Rain Models", "Real Rockets", ::changeRainModel, "usrpg_mp");
	self aO("Rain Models", "Lodestars", ::changeRainModel, "veh_t6_drone_pegasus_mp");
	self aO("Rain Models", "Dogs", ::changeRainModel, "german_shepherd");
	self aO("Rain Models", "Default Actors", ::changeRainModel, "defaultactor");
	self aO("Rain Models", "Train Tracks", ::changeRainModel, "p6_express_train_track_a01");
	self aO("Rain Models", "Hellstorms", ::changeRainModel, "projectile_sa6_missile_desert_mp");
	self aO("Rain Models", "AGRs", ::changeRainModel, "veh_t6_drone_tank");

	self aM("Team Menu", "Main Menu", "Co-Host");
	self aO("Team Menu", "Change Team", ::initTeamChange);
	self aO("Team Menu", "^5>Your Team<", ::submenu, "Your Team", "Your Team");
	self aO("Team Menu", ">Enemy Team<", ::submenu, "Enemy Team", "Enemy Team");

	self aM("Your Team", "Team Menu", "Co-Host");
	self aO("Your Team", "ESP", ::TeamESP, "your");
	self aO("Your Team", "Freeze", ::TeamFreeze, "your");
	self aO("Your Team", "God Mode", ::TeamGod, "your");
	self aO("Your Team", "Invisible", ::TeamInvis, "your");
	self aO("Your Team", "Infinite Ammo", ::TeamAmmo, "your");
	self aO("Your Team", "Kill", ::TeamKill, "your");
	self aO("Your Team", "Revive", ::TeamRevive, "your");
	self aO("Your Team", "No FX Explosive Bullets", ::TeamNoFXExp, "your");
	self aO("Your Team", "+1 Score", ::TeamScore, "your");
	self aO("Your Team", "^5>Status<", ::submenu, "Your Team Status", "Your Team Status");
	
	self aM("Your Team Status", "Your Team", "Co-Host");
	self aO("Your Team Status", "Unverify", ::TeamVer, "your", "Unverified");
	self aO("Your Team Status", "Verify", ::TeamVer, "your", "Verified");
	self aO("Your Team Status", "VIP", ::TeamVer, "your", "VIP");
	self aO("Your Team Status", "Admin", ::TeamVer, "your", "Admin");
	self aO("Your Team Status", "Co-Host", ::TeamVer, "your", "Co-Host");
	
	self aM("Enemy Team", "Team Menu", "Co-Host");
	self aO("Enemy Team", "ESP", ::TeamESP, "enemy");
	self aO("Enemy Team", "Freeze", ::TeamFreeze, "enemy");
	self aO("Enemy Team", "God Mode", ::TeamGod, "enemy");
	self aO("Enemy Team", "Invisible", ::TeamInvis, "enemy");
	self aO("Enemy Team", "Infinite Ammo", ::TeamAmmo, "enemy");
	self aO("Enemy Team", "Kill", ::TeamKill, "enemy");
	self aO("Enemy Team", "Revive", ::TeamRevive, "enemy");
	self aO("Enemy Team", "No FX Explosive Bullets", ::TeamNoFXExp, "enemy");
	self aO("Enemy Team", "+1 Score", ::TeamScore, "enemy");
	self aO("Enemy Team", "^5>Status<", ::submenu, "Enemy Team Status", "Enemy Team Status");
	
	self aM("Enemy Team Status", "Enemy Team", "Co-Host");
	self aO("Enemy Team Status", "Unverify", ::TeamVer, "enemy", "Unverified");
	self aO("Enemy Team Status", "Verify", ::TeamVer, "enemy", "Verified");
	self aO("Enemy Team Status", "VIP", ::TeamVer, "enemy", "VIP");
	self aO("Enemy Team Status", "Admin", ::TeamVer, "enemy", "Admin");
	self aO("Enemy Team Status", "Co-Host", ::TeamVer, "enemy", "Co-Host");
	
	self aM("Change Map", "Main Menu", "Host");
	self aO("Change Map", "Nuketown 2025", ::changeMap, "mp_nuketown_2020");
	self aO("Change Map", "Aftermath", ::changeMap, "mp_la");
	self aO("Change Map", "Cargo", ::changeMap, "mp_dockside");
	self aO("Change Map", "Carrier", ::changeMap, "mp_carrier");
	self aO("Change Map", "Drone", ::changeMap, "mp_drone");
	self aO("Change Map", "Express", ::changeMap, "mp_express");
	self aO("Change Map", "Hijacked", ::changeMap, "mp_hijacked");
	self aO("Change Map", "Meltdown", ::changeMap, "mp_overflow");
	self aO("Change Map", "Plaza", ::changeMap, "mp_nightclub");
	self aO("Change Map", "Raid", ::changeMap, "mp_raid");
	self aO("Change Map", "Slums", ::changeMap, "mp_slums");
	self aO("Change Map", "Standoff", ::changeMap, "mp_village");
	self aO("Change Map", "Turbine", ::changeMap, "mp_turbine");
	self aO("Change Map", "Yemen", ::changeMap, "mp_socotra");
	self aO("Change Map", "^5>DLC Maps<", ::submenu, "DLC Maps", "DLC Maps");

	self aM("DLC Maps", "Change Map", "Host");
	self aO("DLC Maps", "Downhill", ::changeMap, "mp_downhill");
	self aO("DLC Maps", "Mirage", ::changeMap, "mp_mirage");
	self aO("DLC Maps", "Hydro", ::changeMap, "mp_hydro");
	self aO("DLC Maps", "Grind", ::changeMap, "mp_skate");
	self aO("DLC Maps", "Encore", ::changeMap, "mp_concert");
	self aO("DLC Maps", "Magma", ::changemap, "mp_magma");
	self aO("DLC Maps", "Vertigo", ::changemap, "mp_vertigo");
	self aO("DLC Maps", "Studio", ::changemap, "mp_studio");
	self aO("DLC Maps", "Uplink", ::changemap, "mp_uplink");
	self aO("DLC Maps", "Detour", ::changemap, "mp_bridge");
	self aO("DLC Maps", "Cove", ::changemap, "mp_castaway");
	self aO("DLC Maps", "Rush", ::changemap, "mp_paintball");
	self aO("DLC Maps", "Dig", ::changemap, "mp_dig");
	self aO("DLC Maps", "Frost", ::changemap, "mp_frostbite");
	self aO("DLC Maps", "Pod", ::changemap, "mp_pod");
	self aO("DLC Maps", "Takeoff", ::changemap, "mp_takeoff");

	self aM("Host Menu", "Main Menu", "Host");
	self aO("Host Menu", "Force Host", ::forceHost);
	self aO("Host Menu", "FPS Monitor", ::DrawFPS);
	self aO("Host Menu", "Host doHeart", ::dhtoggle);
	self aO("Host Menu", "Edit doHeart Text", ::keyboard, 2);
	self aO("Host Menu", "Spin Text", ::InitSpinText);
	self aO("Host Menu", "Clear Co-Host List", ::clearAList, "coHostList", "^5Co-Host^7 list");
	self aO("Host Menu", "Clear Admin List", ::clearAList, "adminList", "^1Admin^7 list");
	self aO("Host Menu", "Clear Blacklist", ::clearAList, "Blacklist", "^0Blacklist^7");
	self aO("Host Menu", "Verified Players Immune", ::toggleVerImmune);
	self aO("Host Menu", "Auto Anti Quit", ::toggleAutoAQ);
	self aO("Host Menu", "Lock Aimbot Submenu", ::lockAimbot);
	self aO("Host Menu", "^5>Gun Positions<", ::submenu, "Gun Positioning", "Gun Positioning");

	self aM("Gun Positioning", "Host Menu", "Host");
	self aO("Gun Positioning", "X Editor", ::doSlider, "Gun X", "cg_gun_x");
	self aO("Gun Positioning", "Y Editor", ::doSlider, "Gun Y", "cg_gun_y");
	self aO("Gun Positioning", "Z Editor", ::doSlider, "Gun Z", "cg_gun_z");
	
	self aM("All Players", "Main Menu", "Co-Host");
	self aO("All Players", "Freeze All", ::dofreezeall);
	self aO("All Players", "Teleport All to Me", ::AllToMe);
	self aO("All Players", "All to Crosshairs", ::teleToCrosshairs);
	self aO("All Players", "Kill All", ::killall);
	self aO("All Players", "Kick All", ::kickall);
	self aO("All Players", "God Mode All", ::godmodeall);
	self aO("All Players", "Infinite Ammo All", ::infiniteammoall);
	self aO("All Players", "Invisible All", ::invisibleall);
	self aO("All Players", "Send All To Space", ::sendalltospace);
	self aO("All Players", "Blind All", ::blindall);
	self aO("All Players", "Take All Weapons", ::takeallplayerweapons);
	self aO("All Players", "60k XP All", ::rankall);
	self aO("All Players", "Fake Derank All", ::allderank);
	self aO("All Players", "Fake Master All", ::allmaster);
	self aO("All Players", "Unlock Trophies All", ::unlockAllThrophiesAllPlayers);
	self aO("All Players", "Revive All", ::doAllRevive);
	self aO("All Players", "^5>All Players 2<", ::submenu, "All Players 2", "All Players 2");
	
	self aM("All Players 2", "All Players", "Co-Host");
	self aO("All Players 2", "Adventure Time All", ::AllAdventureTime);
	self aO("All Players 2", "Light Man All", ::AllLightMan);
	self aO("All Players 2", "Electric Man All", ::AllElectricMan);
	self aO("All Players 2", "Light Sabers All", ::Allsabers);
	self aO("All Players 2", "Clown Shoes All", ::AttachCShoesAll);
	self aO("All Players 2", "Leap Frog All", ::LeapFrogAll);
	self aO("All Players 2", "Swarm Bullets All", ::SwarmBAll);
	self aO("All Players 2", "Ride Hunter Killer All", ::RideHunterAll);
	self aO("All Players 2", "Arrow Man All", ::ArrowManAll);
	self aO("All Players 2", "Jetpack All", ::JetpackAll);
	self aO("All Players 2", "Rotor Head All", ::RotorAll);
	self aO("All Players 2", "Dead Ops Arcade All", ::DeadOpsCamAll);
	self aO("All Players 2", "^5>Status<", ::submenu, "All Players Status", "All Players Status");
	self aO("All Players 2", ">Modded Weapons All<", ::submenu, "Modded Weapons All", "Modded Weapons All");
	self aO("All Players 2", ">Set Model All<", ::submenu, "Set Model All", "Set Model All");
	
	self aM("All Players Status", "All Players 2", "Co-Host");
	self aO("All Players Status", "Unverify", ::AllVer, "Unverified");
	self aO("All Players Status", "Verify", ::AllVer, "Verified");
	self aO("All Players Status", "VIP", ::AllVer, "VIP");
	self aO("All Players Status", "Admin", ::AllVer, "Admin");
	self aO("All Players Status", "Co-Host", ::AllVer, "Co-Host");
	
	self aM("Modded Weapons All", "All Players 2", "Co-Host");
	self aO("Modded Weapons All", "Raygun All", ::Allraygun);
	self aO("Modded Weapons All", "Raygun M2 All", ::AllRaygunM2);
	self aO("Modded Weapons All", "Raygun M3 All", ::AllRaygunM3);
	self aO("Modded Weapons All", "Mustang & Sally All", ::AllMustangGun);
	self aO("Modded Weapons All", "Rocket Teleporter All", ::AllRocketTeleport);
	self aO("Modded Weapons All", "Ballistic Teleporter All", ::Allknifetele);
	self aO("Modded Weapons All", "Dragons Breath All", ::AllDragonGun);
	
	self aM("Set Model All", "All Players 2", "Co-Host");
	self aO("Set Model All", "Real Default Actor", ::RealDefaultAll);
	self aO("Set Model All", "Reset", ::AllResetModel);
	self aO("Set Model All", "Default Vehicle", ::AllSetModel, "defaultvehicle");
	self aO("Set Model All", "Default Actor", ::AllSetModel, "defaultactor");
	self aO("Set Model All", "VTOL", ::AllSetModel, "veh_t6_air_v78_vtol_killstreak");
	self aO("Set Model All", "Flag", ::AllSetModel, "mp_flag_green");
	self aO("Set Model All", "Escort Drone", ::AllSetModel, "veh_t6_drone_overwatch_light");
	self aO("Set Model All", "UAV", ::AllSetModel, "veh_t6_drone_uav");
	self aO("Set Model All", "Arrows", ::AllSetModel, "fx_axis_createfx");
	self aO("Set Model All", "Suitcase Bomb", ::AllSetModel, "prop_suitcase_bomb");
	self aO("Set Model All", "AGR", ::AllSetModel, "veh_t6_drone_tank");
	self aO("Set Model All", "Red Sentry Gun", ::AllSetModel, "t6_wpn_turret_sentry_gun_red");
	self aO("Set Model All", "Dog Tags", ::AllSetModel, "p6_dogtags");
	self aO("Set Model All", "Dog", ::AllSetModel, "german_shepherd");
	self aO("Set Model All", "Care Package", ::AllSetModel, "t6_wpn_supply_drop_ally");
	self aO("Set Model All", "Red Care Package", ::AllSetModel, "t6_wpn_supply_drop_detect");
	self aO("Set Model All", "Lightning Strike", ::AllSetModel, "veh_t6_air_fa38_killstreak");
	self aO("Set Model All", "Lodestar", ::AllSetModel, "veh_t6_drone_pegasus_mp");
	self aO("Set Model All", "Train Track", ::AllSetModel, "p6_express_train_track_a01");

	self aM("Theme Menu", "Main Menu", "Verified");
    self aO("Theme Menu", "^5>Lines & Scroller<", ::submenu, "Lines & Scroller", "Lines & Scroller");
    self aO("Theme Menu", ">Background<", ::submenu, "Background", "Background");
    self aO("Theme Menu", ">Text<", ::submenu, "Text", "Text");
    self aO("Theme Menu", ">Text Glow<^7", ::submenu, "Text Glow", "Text Glow");
	self aO("Theme Menu", "Default Colors", ::doDefault);
	self aO("Theme Menu", "Move Menu Right", ::MoveMenu, "right");
	self aO("Theme Menu", "Move Menu Left", ::MoveMenu, "left");
	self aO("Theme Menu", "Stealth Menu", ::toggleMenuStealth);
    
    self aM("Background", "Theme Menu", "Verified");
    self aO("Background", "White", ::setBGColor, color("white"));
    self aO("Background", "Black", ::setBGColor, color("black"));
    self aO("Background", "Red", ::setBGColor, color("red"));
    self aO("Background", "Blue", ::setBGColor, color("blue"));
    self aO("Background", "Green", ::setBGColor, color("green"));
    self aO("Background", "Yellow", ::setBGColor, color("yellow"));
    self aO("Background", "Pink", ::setBGColor, color("pink"));
    self aO("Background", "Cyan", ::setBGColor, color("cyan"));
    self aO("Background", "Aqua", ::setBGColor, color("aqua"));
    self aO("Background", "Orange", ::setBGColor, color("orange"));
    self aO("Background", "Purple", ::setBGColor, color("purple"));
 
    self aM("Lines & Scroller", "Theme Menu", "Verified");
 	self aO("Lines & Scroller", "White", ::setLColor, color("white"));
    self aO("Lines & Scroller", "Black", ::setLColor, color("black"));
    self aO("Lines & Scroller", "Red", ::setLColor, color("red"));
    self aO("Lines & Scroller", "Blue", ::setLColor, color("blue"));
    self aO("Lines & Scroller", "Green", ::setLColor, color("green"));
    self aO("Lines & Scroller", "Yellow", ::setLColor, color("yellow"));
    self aO("Lines & Scroller", "Pink", ::setLColor, color("pink"));
    self aO("Lines & Scroller", "Cyan", ::setLColor, color("cyan"));
    self aO("Lines & Scroller", "Aqua", ::setLColor, color("aqua"));
    self aO("Lines & Scroller", "Orange", ::setLColor, color("orange"));
    self aO("Lines & Scroller", "Purple", ::setLColor, color("purple"));
    
    self aM("Text", "Theme Menu", "Verified");
    self aO("Text", "White", ::setTColor, color("white"));
    self aO("Text", "Black", ::setTColor, color("black"));
    self aO("Text", "Red", ::setTColor, color("red"));
    self aO("Text", "Blue", ::setTColor, color("blue"));
    self aO("Text", "Green", ::setTColor, color("green"));
    self aO("Text", "Yellow", ::setTColor, color("yellow"));
    self aO("Text", "Pink", ::setTColor, color("pink"));
    self aO("Text", "Cyan", ::setTColor, color("cyan"));
    self aO("Text", "Aqua", ::setTColor, color("aqua"));
    self aO("Text", "Orange", ::setTColor, color("orange"));
    self aO("Text", "Purple", ::setTColor, color("purple"));
    
    self aM("Text Glow", "Theme Menu", "Verified");
    self aO("Text Glow", "White", ::setGColor, color("white"));
    self aO("Text Glow", "Black", ::setGColor, color("black"));
    self aO("Text Glow", "Red", ::setGColor, color("red"));
    self aO("Text Glow", "Blue", ::setGColor, color("blue"));
    self aO("Text Glow", "Green", ::setGColor, color("green"));
    self aO("Text Glow", "Yellow", ::setGColor, color("yellow"));
    self aO("Text Glow", "Pink", ::setGColor, color("pink"));
    self aO("Text Glow", "Cyan", ::setGColor, color("cyan"));
    self aO("Text Glow", "Aqua", ::setGColor, color("aqua"));
    self aO("Text Glow", "Orange", ::setGColor, color("orange"));
    self aO("Text Glow", "Purple", ::setGColor, color("purple"));
    
    self aM("PlayersMenu", "Main Menu", "Co-Host");
	for(i = 0; i < 12; i++)
	{
		self aM("playerMain " + i, "PlayersMenu", "Co-Host");
		self aM("pOpt " + i, "playerMain " + i, "Co-Host");
		self aM("pOpt2 " + i, "pOpt " + i, "Co-Host");
		self aM("status " + i, "playerMain " + i, "Co-Host");
	}
}
updatePlayersMenu()
{
	self.menu.menucount["PlayersMenu"] = 0;
	for(i = 0; i < 12; i++)
	{
		player = level.players[i];
		playerName = getPlayerName(player);
		playersizefixed = level.players.size - 1;
		if(self.menu.curs["PlayersMenu"] > playersizefixed)
		{ 
			self.menu.scrollerpos["PlayersMenu"] = playersizefixed;
			self.menu.curs["PlayersMenu"] = playersizefixed;
		}
		self aO("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName, ::submenu, "playerMain " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);

		self aMalt("playerMain " + i, "PlayersMenu");
		self aO("playerMain " + i, "^5>Status<", ::submenu, "status " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
		self aO("playerMain " + i, ">Options<", ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
		
		self aMalt("status " + i, "playerMain " + i);
		self aO("status " + i, "Co-Host", ::changeVerificationMenu, player, "Co-Host");
		self aO("status " + i, "Admin", ::changeVerificationMenu, player, "Admin");
		self aO("status " + i, "VIP", ::changeVerificationMenu, player, "VIP");
		self aO("status " + i, "Verify", ::changeVerificationMenu, player, "Verified");
		self aO("status " + i, "Unverify", ::changeVerificationMenu, player, "Unverified");
		self aO("status " + i, "+ Auto Co-Host List", ::addCoHostList, player);
		self aO("status " + i, "+ Auto Admin List", ::addAdminList, player);
		self aO("status " + i, "+ Blacklist", ::addBlackList, player);
		
		self aMalt("pOpt " + i, "playerMain " + i);
		self aO("pOpt " + i, "Kick", ::kickPlayer, player);
		self aO("pOpt " + i, "Kill", ::killPlayer, player);
		self aO("pOpt " + i, "Ban", ::banPlayer, player);
        self aO("pOpt " + i, "God Mode", ::givePlayerGod, player);
        self aO("pOpt " + i, "Infinite Ammo", ::infiniteAmmoPlayer, player);
        self aO("pOpt " + i, "Invisible", ::givePlayerInvis, player);
        self aO("pOpt " + i, "Freeze Controls", ::freezePlayer, player, true);
        self aO("pOpt " + i, "T-Bag", ::playertbag, player);
        self aO("pOpt " + i, "Spin", ::ToggleSpin, player);
        self aO("pOpt " + i, "Teleport To Me", ::teleportPlayer, player, "me");
        self aO("pOpt " + i, "Teleport To Them", ::teleportPlayer, player, "them");
        self aO("pOpt " + i, "Say Is Gay", ::typewriter, "Guess what guys, ^1"+player.name+"^7 is really ^6GAY!");
        self aO("pOpt " + i, "Say Stop Using Aimbot", ::typewriter, "^1"+player.name+"^7 stop using aimbot!");
        self aO("pOpt " + i, "Freeze Console", ::freezePS3, player);
        self aO("pOpt " + i, "Change Team", ::ChangeTeamPlayer, player);
        self aO("pOpt " + i, "Blind", ::blindPlayer, player);
        self aO("pOpt " + i, "Scorestreaks", ::giveall_scorestreaks, player);
        self aO("pOpt " + i, "Revive", ::revivePlayer, player);
        self aO("pOpt " + i, "^5>"+player.name+" 2<", ::submenu, "pOpt2 " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);

        self aMalt("pOpt2 " + i, "pOpt " + i);
        self aO("pOpt2 " + i, "+1 FFA Score", ::FFAscore, player);
        self aO("pOpt2 " + i, "ESP", ::playerESP, player);
        self aO("pOpt2 " + i, "Give 60k XP", ::rankupplayer, player);
        self aO("pOpt2 " + i, "Fake Master", ::doMaster, player);
        self aO("pOpt2 " + i, "Fake Derank", ::playerDerank, player);
        self aO("pOpt2 " + i, "No FX Explosive Bullets", ::playerNoFXExp, player);
        self aO("pOpt2 " + i, "Super Legit Aimbot v3", ::playerLegitAim, player);
        self aO("pOpt2 " + i, "Unfair Aimbot", ::playerUnfairAim, player);
        self aO("pOpt2 " + i, "Trickshot Aimbot", ::playerTrickAim, player);
        self aO("pOpt2 " + i, "Combat Axe Aimbot", ::playerCAxeAim, player);
	}
}


















































