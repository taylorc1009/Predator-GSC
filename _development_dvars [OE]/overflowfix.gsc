recreateText()
{
	if(self isVerified())
	{
		if(self.menu.open == true)
		{
			self.Private["name"] setSafeText("Predator Oldschool Edition");
			self.Private["title2"] setSafeText(self.CurTitle2);
			self.Private["title3"] setSafeText(self.CurTitle3);
			self thread submenu(self.CurMenu, self.CurTitle);
		}
		if(self.lockHUD)
			self.lock["text"] setSafeText("Menu is currently locked!");
		if(self.welcomeRunning)
			self.welcomemsg setSafeText("Welcome\n^5" + self.name + "^7!\n^5Predator ^4OE\n^7Enjoy!");
		if(self.keyboard["inUse"])
		{
			self.keyboard["text"] setSafeText(self.letter["currentResult"]);
			self.keyboard["controls"] setSafeText(self.letter["controls"]);
			if(self.letter["Caps"])
        	{
        		for(i = 0; i < self.letter["keysHUDBig"].size; i++)
					self.keyboard["keys"+i] setSafeText(self.letter["keysHUDBig"][i]);
        	}
        	else
        	{
        		for(i = 0; i < self.letter["keysHUDLow"].size; i++)
					self.keyboard["keys"+i] setSafeText(self.letter["keysHUDLow"][i]);
        	}
		}
		if(self.crosshair == true)
			self.Pwnd setSafeText("^5"+self.name);
		if(self.forgemode)
			self.forgeText setSafeText("[{+speed_throw}] to ^3Move Objects^7\n[{+actionslot 3}] to ^2Spawn^7\n[{+actionslot 2}] to ^1Delete");
		if(self isHost())
		{
			if(level.doheart == 0)
				level.SA setSafeText(level.doHeartText);
			if(level.IsSpinning == true)
				level.SpinText setSafeText(self.name);
			if(self.initFJCInfoOnMe == 1)
			{
				self.FJCInfoOnMe setSafeText("[{+attack}] ^2Accelerate\n[{+smoke}] Drop Carepackage\n[{+switchseat}] ^5Change Weapon\n[{+speed_throw}] Fire Weapon\n[{+frag}] Bomblet to Under\n[{+stance}] ^1Exit\n[{+melee}] Delete Jet");
				self.FJetNowWeapMe setSafeText("^3Weapon: ^5" + self.FJetWeapName);
				self.FJetRaidInfoMe setSafeText("^3Press [{+usereload}] to ^1Ride on Jet");
			}
   		}
   	}
    if(level.papspawned == 1)
		self.packit setSafeText("^3Press [{+usereload}] for Pack-A-Punch");
	if(self.initnmlSawned==1)
		self.nmlInfo setSafetext("^3Changed to ^6Normal Lobby");
	if(self.initsplSawned == 0)
		self.splInfo setSafeText("^3Changed to ^6Sniper Lobby");
	if(self.initsplAISpawn == 1)
		self.splAInfo setSafeText("^3Press [{+speed_throw}] + [{+actionslot 3}] to ^6Give Max Ammo.\n^3Press [{+speed_throw}] + [{+actionslot 4}] to ^6Matrix Mode.\n^3Crouch + [{+actionslot 3}] to ^6Move Speed up.\n^3Crouch + [{+actionslot 4}] to use ^6Teleport.");
	if(self.MTrixWSpawnOn == 1)
		self.MTrixWOn setSafeText("^1Matrix Mode!!");
	if(level.bunker==false)
   	{
    	self.SpawnweaponcrateHintString[level.activeSpawnweaponCrates] setSafeText("Press ^3[{+activate}]^7 For " + weapon);
        self.PackOPunchHintString[level.activePackOPunchCrates] setSafeText("Press ^3[{+activate}]^7 To PackOPunch Your Weapon");
	}
	if(level.isMW2Nuke)
   	{
   		if(self.nukeHUD1)
   		{
    		self.MessageNukeReady setSafeText("MW2 Nuke Kill Streak!");
      		self.MessageNukeHowTo setSafeText("Press [{+frag}] for Tactical Nuke.");
		}
		if(self.nukeTimer)
			self.NukeCountdown setSafeText(self.currentNukeTime);
	}
}
overflowfix()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	test = level createServerFontString("default", 1);
	test setText("xFMz");
	test.alpha = 0;
	for(;;)
	{
		level waittill("textset"); 
		if(level.strings.size >= 100)
		{
			test ClearAllTextAfterHudElem();
			level.strings = [];
			foreach(player in level.players)
				player recreateText();
		}
	}
}
setSafeText(text)
{
    if(!isInArray(level.strings, text))
    {
        level.strings[level.strings.size] = text;
        self setText(text);
        level notify("textset");
    }
    else
        self setText(text);
}








































