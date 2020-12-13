welcomeMessage()
{
	self.welcomeRunning=true;
	self.welcomemsg = self createFontString("hudbig", 2); 
	self.welcomemsg setPoint("CENTER", "CENTER", -315, -50); 
	self.welcomemsg setSafeText("Welcome\n^5" + self.name + "^7!\n^5Predator ^4OE\n^7Enjoy!");
	self.welcomemsg.alpha = 1;
	self.welcomemsg.archived = false;
	self.welcomemsg.glowalpha = 1;
	self.welcomemsg.sort = 666;
	self.welcomemsg.glowColor = (0, 0, 1);
	self.welcomemsg setTypeWriterFx(90, 6600, 1500);
	wait 8.1;
	self.welcomeRunning=false;
	self.welcomemsg destroy();
}
menuInstructions()
{
	if(self isHost())
	{
		if(level.creatorMsg==0 && level.menuInsMsg==0)
		{
			level.menuInsMsg=1;
			foreach(player in level.players)
				if(player.crosshair)
					player.Pwnd.alpha=0;
    		level.menuinstructions=cT("How to use ^5Predator ^4Oldschool Edition", "default", 2, "CENTER", "CENTER", 0, 0, 0, 1, (1, 1, 1), (0, 0, 1), 1);
			wait 3;
			level.menuinstructions setSafeText("[{+actionslot 1}] to open the menu");
			wait 3;
			level.menuinstructions setSafeText("[{+actionslot 1}] & [{+actionslot 2}] to scroll");
			wait 3;
			level.menuinstructions setSafeText("[{+actionslot 3}] & [{+actionslot 4}] to change tabs");
			wait 3;
			level.menuinstructions setSafeText("[{+gostand}] to select & [{+usereload}] to go back");
			wait 3;
			level.menuinstructions destroy();
			foreach(player in level.players)
				if(player.crosshair)
					player.Pwnd.alpha=1;
			level.menuInsMsg=0;
		}
    	else
    		self iprintln("^1A message is already running");
    }
    else
    	self iprintln("You must be ^2Host^7 to do that");
}
creatorMessage()
{
	if(level.creatorMsg==0 && level.menuInsMsg==0)
	{
		level.creatorMsg=1;
		foreach(player in level.players)
			if(player.crosshair)
				player.Pwnd.alpha=0;
    	level.cnpmsg=cT("^5Predator ^4Oldschool Edition", "default", 3, "CENTER", "CENTER", 0, 0, 0, 1, (1, 1, 1), (0, 0, 1), 1);
    	level.cnpmsg ChangeFontScaleOverTime(0.1);
    	level.cnpmsg.fontScale = 2;
    	wait 3;
    	level.cnpmsg setSafeText("^7Created by ^5FuSiOn^7!");
    	wait 3;
    	level.cnpmsg setSafeText("^7Hosted by ^4"+level.hostName);
    	wait 3;
    	level.cnpmsg setSafeText("^F^5Enjoy^7!");
    	wait 3;
    	level.cnpmsg ChangeFontScaleOverTime(.1);
    	level.cnpmsg.fontScale = 3;
    	wait 0.1;
		level.cnpmsg destroy();
		foreach(player in level.players)
			if(player.crosshair)
				player.Pwnd.alpha=1;
		level.creatorMsg=0;
	}
    else
    	self iprintln("^1A message is already running");
}
crosshairself()
{
    if(self.crosshair == false)
    {
        self.Pwnd=createFontString("default",1.5);
        self.Pwnd setPoint("CENTER","CENTER",0,-200);
        self.Pwnd setSafeText("^5"+self.name);
	    if(level.creatorMsg==0 && level.menuInsMsg==0)
        	self.Pwnd.alpha=1;
        else
        	self.Pwnd.alpha=0;
        self.Pwnd.y=0;
        self iprintln("Crosshair ^3"+self.name+" ^5ON");
        self.crosshair = true;
    }
    else
    {
        self.Pwnd destroy();
        self iprintln("Crosshair ^4OFF");
        self.crosshair = false;
    }
}
dhtoggle()
{
	if(level.doheart==1)
	{
		self iprintln("Host doHeart ^5ON");
		level thread doHeart("[{+actionslot 4}] "+self.name+" ^7[{+actionslot 3}]");
		level thread fxloop2();
		level.doheart=0;
	}
	else
	{
		self iprintln("Host doHeart ^4OFF");
		level notify("endDH");
		level.SA destroy();
		level.doheart=1;
	}
}
doHeart(text)
{
	level endon("endDH");
	level.doHeartText = text;
	level.SA destroy();
	level.SA=createServerFontString("hudbig",2.1);
	level.SA setPoint("CENTER","TOP",300,10);
	level.SA setSafeText(text);
	level.SA setTypeWriterFx(70, 4000, 1000);
	level.SA.glowAlpha=1;
	for(;;)
	{
		level.SA ChangeFontScaleOverTime(0.4);
		if(level.SA.fontScale == 2)
			level.SA.fontScale = 2.3;
		else
			level.SA.fontScale = 2;
		level.SA FadeOverTime(0.3);
		level.SA.glowColor=((randomint(255)/255),(randomint(255)/255),(randomint(255)/255));
		level.SA.color=((randomint(255)/255),(randomint(255)/255),(randomint(255)/255));
		wait 0.4;
	}
}
fxloop2()
{
	level endon("endDH");
	for(;;)
	{
		wait 5;
		level.SA setTypeWriterFx(70, 4000, 1000);
	}
}
InitSpinText()
{
	if(!isDefined(level.IsSpinning))
	{
		level.IsSpinning = true;
		level thread SpinText();
		level thread ChangeSpinTextColor();
		self iprintln("Spin Text ^5ON");
	}
	else
	{
		level.IsSpinning = undefined;
		level notify("stop_spinText");
		level.SpinText destroy();
		self iprintln("Spin Text ^4OFF");
	}
}
SpinText()
{
	level endon("stop_spinText");
	level endon("host_migration_begin");
	level.SpinText = level createServerFontString("default", 3);
	level.SpinText setSafeText(level.hostname);
	level.SpinText.GlowAlpha = 1;
	CoordX = 0;
	CoordY = 0;
	Radius = 100;
	Index = 0;
	for(;;)
	{
		XPos = CoordX + sin(Index) * Radius;
		YPos = CoordY + cos(Index) * Radius;
		level.SpinText setPoint("CENTER", "CENTER", Xpos, YPos);
		Index++;
		wait .01;
	}
}
ChangeSpinTextColor()
{
	level endon("stop_spinText");
	level endon("host_migration_begin");
	for(;;)
	{
		level.SpinText FadeOverTime(0.3);
		level.SpinText.glowColor=((randomint(255)/255),(randomint(255)/255),(randomint(255)/255));
		level.SpinText.color=((randomint(255)/255),(randomint(255)/255),(randomint(255)/255));
		wait 0.4;
	}
}
keyboard(type)
{
    self endon("disconnect");
    self endon("death");
    self endon("destroyMenu");
    level endon("game_ended");
    self.menulocked=true;
    closeMenu();
    wait .3;
    self.menu.background destroy();
	self.menu.background2 destroy();
	self.menu.scroller destroy();
	self.menu.line destroy();
	self.menu.line2 destroy();
	wait .1;
    if(type == 1)
    	stringSize = 50;
    else if(type == 2)
    	stringSize = 21;
	self.letter["Caps"] = false;
	self.letter["currentResult"] = "";
	self.keyboard = [];
	self.keyboard["background"] = self cS("white", "CENTER", "CENTER", -315, 113, 200, 99, (0,0,0), .8, 1);
	self.keyboard["bar"] = self cS("white", "CENTER", "CENTER", -254, 50, 322, 24, (0,0,0), .8, 1);
	self.keyboard["infobox"] = self cS("white", "CENTER", "CENTER", -153, 113.4, 120, 99, (0,0,0), .8, 1);
	self.keyboard["controls"] = self dT(self.letter["controls"], "hudbig", 1.1, -164, 271, (1,1,1), 1, (0,0,0), 0, 3);
	self.keyboard["text"] = self dT("", "hudbig", 1.5, -253, 244.5, (1,1,1), 1, (0,0,0), 0, 3);
	self.keyboard["inUse"] = true;
	for(i = 0; i < self.letter["keysHUDLow"].size; i++)
		self.keyboard["keys"+i] = self dT(self.letter["keysHUDLow"][i], "hudbig", 1.5, -405 + (i * 20), 270, (1,1,1), 1, (0,0,0), 0, 3);
	startX = self.keyboard["keys0"].x;
	startY = self.keyboard["keys0"].y;
	self.keyboard["scrollbar"] = self dS("white", -405, 270, 15, 15, (0.04, 0.66, 0.89), 1, 2);
	curs = 0;
	keyCurs = 0;
    letterRemember = "";
    list = getArrayKeys(self.keyboard);
    foreach(index in list)
		self.keyboard[index].foreground = true;
    for(;;)
    {
    	if(self actionSlotOneButtonPressed() || self actionSlotTwoButtonPressed() || self actionSlotThreeButtonPressed() || self actionSlotFourButtonPressed())
		{
    		curs += self actionSlotTwoButtonPressed();
			curs -= self actionSlotOneButtonPressed();
			keyCurs += self actionSlotFourButtonPressed();
			keyCurs -= self actionSlotThreeButtonPressed();
			if(curs < 0)
				curs = 4;
			if(curs > 4)
				curs = 0;
			if(keyCurs < 0)
				keyCurs = 9;
			if(keyCurs > 9)
				keyCurs = 0;
			if(self actionSlotOneButtonPressed() || self actionSlotTwoButtonPressed())
			{
				if(curs == 0)
				{
					self.keyboard["scrollbar"] MoveOverTime(0.025);
					self.keyboard["scrollbar"].y = startY;
				}
				else
				{
					self.keyboard["scrollbar"] MoveOverTime(0.025);
					self.keyboard["scrollbar"].y = startY + (18.8 * curs);
				}
			}
			if(self actionSlotThreeButtonPressed() || self actionSlotFourButtonPressed())
			{
				if(keyCurs == 0)
				{
					self.keyboard["scrollbar"] MoveOverTime(0.025);
					self.keyboard["scrollbar"].x = startX;
				}
				else
				{
					self.keyboard["scrollbar"] MoveOverTime(0.025);
					self.keyboard["scrollbar"].x = startX + (20 * keyCurs);
				}
			}
			wait .1;
		}
       	if(self adsbuttonpressed())
       	{
       		if(!self.letter["Caps"])
       		{
       			self.letter["Caps"]=true;
       			for(i = 0; i < self.letter["keysHUDLow"].size; i++)
					self.keyboard["keys"+i] setSafeText(self.letter["keysHUDBig"][i]);
       		}
       		else
       		{
       			self.letter["Caps"]=false;
       			for(i = 0; i < self.letter["keysHUDLow"].size; i++)
					self.keyboard["keys"+i] setSafeText(self.letter["keysHUDLow"][i]);
       		}
       		wait .2;
       	}
       	if(self usebuttonpressed())
       	{
       		if(letterRemember.size != 0)
			{
				fixed = "";
				for(i = 0; i < letterRemember.size-1; i++)
					fixed += letterRemember[i];
				letterRemember = fixed;
				if(letterRemember.size == 0)
					self.keyboard["text"] setSafeText("");
				else
					self.keyboard["text"] setSafeText(letterRemember);
				self.letter["currentResult"] = letterRemember;
				wait .15;
			}
		}
       	if(self jumpButtonPressed())
		{
			if(letterRemember.size != stringSize)
			{
				if(!self.letter["Caps"])
					letterRemember += self.letter["keysLower"][keyCurs][curs];
				else
					letterRemember += self.letter["keysUpper"][keyCurs][curs];
				self.keyboard["text"] setSafeText(letterRemember);
				self.letter["currentResult"] = letterRemember;
			}
			else
				self iprintlnbold("^1Maximum amount of characters reached");
			wait .15;
		}
       	if(self secondaryoffhandbuttonpressed())
       	{
       		if(type == 1)
       			self typewriter(letterRemember);
       		else if(type == 2)
       		{
				level notify("endDH");
				level thread doHeart(letterRemember);
				level thread fxloop2();
				level.doheart=0;
			}
			break;
       	}
       	if(self changeseatbuttonpressed())
       	{
       		letterRemember += " ";
       		self.keyboard["text"] setSafeText(letterRemember);
			self.letter["currentResult"] = letterRemember;
			wait .15;
		}
		if(self stanceButtonPressed())
			break;
    	wait .01;
    }
	foreach(index in list)
		self.keyboard[index] destroy();
	self.keyboard["inUse"] = false;
	self.menulocked = false;
}
doSlider(hud, dvar)
{
	closeMenu();
	wait .3;
	self disableoffhandweapons();
	lol = createText("small", 1.75, "CENTER", "CENTER", 0, 0, 1, 1);
	if(hud != "FOV")
		value = 0;
	else
		value = 65;
	self iprintln("[{+frag}] [{+smoke}] change value\n[{+melee}] finish");
	for(;;)
	{
		if(self fragbuttonpressed())
			value++;
		if(self secondaryoffhandbuttonpressed())
			value--;
		if(self meleeButtonPressed())
        	break;
		if(hud == "FOV")
		{
			if(value >= 131)
				value = 65;
			else if(value <= 64)
				value = 130;
			self setclientfov(value);
		}
		else
		{
			if(dvar == "cg_gun_x")
			{
				if(value >= 51)
					value = -20;
				else if(value <= -21)
					value = 50;
			}
			if(dvar == "cg_gun_y" || dvar == "cg_gun_z")
			{
				if(value >= 21)
					value = -20;
				else if(value <= -21)
					value = 20;
			}
			setDvar(dvar, value);
		}
		lol setValue(value);
        wait .01;
	}
    lol destroy();
	self enableoffhandweapons();
	self iprintln(hud+": ^5"+value);
}
menuLockedHUD()
{
	if(!self.lockHUD)
	{
		self.lockHUD = true;
		self.lock["shader"] = self dS("menu_mp_lobby_locked_big", 288, 60, 50, 50, (1, 1, 1), 0, 666);
		self.lock["text"] = self dT("Menu is currently locked!", "default", 1.5, 288, 109, (1, 0, 0), 0, (1, 0, 0), 1, 666);
		self.lock["shader"] fadeAlphaChange(.5, 1);
		self.lock["text"] fadeAlphaChange(.5, 1);
		wait 3;
		self.lock["shader"] fadeAlphaChange(.5, 0);
		self.lock["text"] fadeAlphaChange(.5, 0);
		wait .5;
		self.lock["shader"] destroy();
		self.lock["text"] destroy();
		self.lockHUD = false;
	}
}










