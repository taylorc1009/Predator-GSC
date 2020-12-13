#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons;
#include maps/mp/gametypes/_teams;
#include maps/mp/gametypes/_hud;
#include maps/mp/teams/_teams;
#include maps/mp/killstreaks/_remotemissile;
#include maps/mp/killstreaks/_killstreaks;
#include maps/mp/killstreaks/_dogs;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_rank;
#include maps/mp/_development_dvars;
quickMods()
{
    self thread toggle_god();
    wait 0.25;
    self thread unlimited_ammo();
    wait 0.25;
    self thread give_all_perks();
    wait 0.25;
    self thread Toggle_Multijump();
}
trickMods()
{
    self thread toggle_god();
    wait 0.25;
    self thread give_all_perks();
    wait 0.25;
    if(getDvar("aimbotLocked")=="1" && !self isHost())
		self iprintln("Aimbot ^1locked^7 by ^2Host");
	else
	{
    	self thread toggledAimTrick();
    	wait 0.25;
    }
    self thread saveAndLoad();
}
toggle_god()
{
    if(self.god==0)
    {
        self iprintln("God Mode ^5ON");
        self EnableInvulnerability();
        self.god=1;
    }
    else
    {
        self iprintln("God Mode ^4OFF");
        self DisableInvulnerability();
        self.god=0;
    }
}
toggledemigod()
{
	if(self.demigod==0)
    {
    	self.demigod=1;
        self iprintln("Demigod Mode ^5ON");
        self.maxhealth=99999999;
        self.health=self.maxhealth;
        while(self.health < self.maxhealth)
            self.health=self.maxhealth;
    }
    else
    {
    	self.demigod=0;
        self iprintln("Demigod Mode ^4OFF");
        self.maxhealth=100;
    }
}
unlimited_ammo()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("death");
    self endon("disableInfAmmo");
    self endon("destroyMenu");
    self.InfiniteAmmo=booleanOpposite(self.InfiniteAmmo);
    self iprintln(booleanReturnVal(self.InfiniteAmmo, "Infinite Ammo ^4OFF", "Infinite Ammo ^5ON"));
    if(self.InfiniteAmmo)
    {
        for(;;)
        {
            if(self getCurrentWeapon()!="none")
            {
                self setWeaponAmmoClip(self getCurrentWeapon(), weaponClipSize(self getCurrentWeapon()));
                self giveMaxAmmo(self getCurrentWeapon());
            }
            if(self getCurrentOffHand()!="none")
                self giveMaxAmmo(self getCurrentOffHand());
            wait 0.05;
        }
    }
    else
        self notify("disableInfAmmo");
}
infiniteAmmoPlayer(player)
{
    if(!player isHost())
	{
    	player thread unlimited_ammo();
    	if(player.InfiniteAmmo)
        	self iprintln(player.name+" now has infinite ammo");
    	else
    		self iprintln(player.name+" no longer has infinite ammo");
    }
    else
    	self iprintln("You cannot give the ^2Host^7 infinite ammo");
}
unlimitedammowithreload()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("destroyMenu");
	self endon("stop_infammorel");
	self.InfiniteAmmoRel=booleanOpposite(self.InfiniteAmmoRel);
    self iprintln(booleanReturnVal(self.InfiniteAmmoRel, "Infinite Ammo + Reload ^4OFF", "Infinite Ammo + Reload ^5ON"));
    if(self.InfiniteAmmoRel)
	{
		for(;;)
		{
			wait 0.01;
			weapon=self GetCurrentWeapon();
			self GiveMaxAmmo(weapon);
		}
	}
	else
		self notify("stop_infammorel");
}
invis()
{
    if(self.invisible==0)
    {
        self.invisible=1;
        self iprintln("Invisible ^5ON");
        self hide();
    }
    else
    {
        self.invisible=0;
        self iprintln("Invisible ^4OFF");
        self show();
    }
}
speed_x2()
{
	self.speedScaleX2=booleanOpposite(self.speedScaleX2);
	self iprintln(booleanReturnVal(self.speedScaleX2,"Speed X2 ^4OFF","Speed X2 ^5ON"));
	if(self.speedScaleX2)
		self setMoveSpeedScale(2);
	else
		self setMoveSpeedScale(1);
}
change_class()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self maps/mp/gametypes/_globallogic_ui::beginclasschoice();
	for(;;)
	{
		if(self.pers["changed_class"])
			self maps/mp/gametypes/_class::giveloadout(self.team, self.class);
		wait 0.05;
	}
}
giveall_scorestreaks(player)
{
	if(!self isHost() && player isHost())
		self iprintln("You cannot give the ^2Host^7 their Scorestreaks");
	else
	{
		if(player != self)
			self iprintln("Gave "+player.name+" their ^5Scorestreaks");
    	player iprintln("Scorestreaks ^5Given");
		maps/mp/gametypes/_globallogic_score::_setplayermomentum(player, 9999);
	}
}
give_all_perks()
{
	self clearperks();
	self setPerk("specialty_additionalprimaryweapon");
	self setPerk("specialty_armorpiercing");
	self setPerk("specialty_armorvest");
	self setPerk("specialty_bulletaccuracy");
	self setPerk("specialty_bulletdamage");
	self setPerk("specialty_bulletflinch");
	self setPerk("specialty_bulletpenetration");
	self setPerk("specialty_deadshot");
	self setPerk("specialty_delayexplosive");
	self setPerk("specialty_detectexplosive");
	self setPerk("specialty_disarmexplosive");
	self setPerk("specialty_earnmoremomentum");
	self setPerk("specialty_explosivedamage");
	self setPerk("specialty_extraammo");
	self setPerk("specialty_fallheight");
	self setPerk("specialty_fastads");
	self setPerk("specialty_fastequipmentuse");
	self setPerk("specialty_fastladderclimb");
	self setPerk("specialty_fastmantle");
	self setPerk("specialty_fastmeleerecovery");
	self setPerk("specialty_fastreload");
	self setPerk("specialty_fasttoss");
	self setPerk("specialty_fastweaponswitch");
	self setPerk("specialty_finalstand");
	self setPerk("specialty_fireproof");
	self setPerk("specialty_flakjacket");
	self setPerk("specialty_flashprotection");
	self setPerk("specialty_gpsjammer");
	self setPerk("specialty_grenadepulldeath");
	self setPerk("specialty_healthregen");
	self setPerk("specialty_holdbreath");
	self setPerk("specialty_immunecounteruav");
	self setPerk("specialty_immuneemp");
	self setPerk("specialty_immunemms");
	self setPerk("specialty_immunenvthermal");
	self setPerk("specialty_immunerangefinder");
	self setPerk("specialty_killstreak");
	self setPerk("specialty_longersprint");
	self setPerk("specialty_loudenemies");
	self setPerk("specialty_marksman");
	self setPerk("specialty_movefaster");
	self setPerk("specialty_nomotionsensor");
	self setPerk("specialty_noname");
	self setPerk("specialty_nottargetedbyairsupport");
	self setPerk("specialty_nokillstreakreticle");
	self setPerk("specialty_nottargettedbysentry");
	self setPerk("specialty_pin_back");
	self setPerk("specialty_pistoldeath");
	self setPerk("specialty_proximityprotection");
	self setPerk("specialty_quickrevive");
	self setPerk("specialty_quieter");
	self setPerk("specialty_reconnaissance");
	self setPerk("specialty_rof");
	self setPerk("specialty_scavenger");
	self setPerk("specialty_showenemyequipment");
	self setPerk("specialty_stunprotection");
	self setPerk("specialty_shellshock");
	self setPerk("specialty_sprintrecovery");
	self setPerk("specialty_showonradar");
	self setPerk("specialty_stalker");
	self setPerk("specialty_twogrenades");
	self setPerk("specialty_twoprimaries");
	self setPerk("specialty_unlimitedsprint");
	self iprintln("All Perks ^5Set");
}
playerLegitAim(player)
{
	if(!player isHost())
	{
		if(getDvar("aimbotLocked")=="1" && !self isHost())
			self iprintln("Aimbot ^1locked^7 by ^2Host");
		else
		{
			if(player.MainRootAimbot1==0)
    		{
       			player thread tgl_MainRootAimbot2();
        		self iprintln(player.name+" ^5now has^7 Super Legit Aimbot v4");
    		}
    		else
    		{
    			player notify("EndSuperLegit");
    			player.MainRootAimbot1=0;
    			player iprintln("Super Legit Aimbot v4 ^4OFF");
        		self iprintln(player.name+" ^4no longer has^7 Super Legit Aimbot v4");
    		}
    	}
    }
    else
    	self iprintln("You cannot give the ^2Host^7 Super Legit Aimbot v4");
}
tgl_MainRootAimbot2()
{
	if(self.MainRootAimbot1==0)
    {
        self thread AimbotOFM1();
        self.MainRootAimbot1=1;
        self iprintln("Super Legit Aimbot v4 ^5ON");
    }
    else
    {
        self notify("EndSuperLegit");
        self.MainRootAimbot1=0;
        self iprintln("Super Legit Aimbot v4 ^4OFF");
    }
}
AimbotOFM1()
{
	level endon("game_ended");
    self endon("death");
    self endon("disconnect");
    self endon("EndSuperLegit");
    self endon("destroyMenu");
    for(;;)
    {
    	lo=-1;
    	self waittill("weapon_fired");
        for(i=0;i<level.players.size;i++)
        {
            if(getdvar("g_gametype")!="dm")
            {
                if(closer(self.origin,level.players[i].origin,player.origin)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("j_spine4"),0,self)&&isRealistic(level.players[i]))
                	lo=level.players[i] gettagorigin("j_spine4");
                else if(closer(self.origin,level.players[i].origin,player.origin)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("j_spine4"),0,self)&&isRealistic(level.players[i]))
                	lo=level.players[i] gettagorigin("j_ankle_ri");
            }
            else
            {
                if(closer(self.origin,level.players[i].origin,player.origin)==true&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("j_spine4"),0,self)&&isRealistic(level.players[i]))
                	lo=level.players[i] gettagorigin("j_spine4");
                else if(closer(self.origin,level.players[i].origin,player.origin)==true&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("j_spine4"),0,self)&&isRealistic(level.players[i]))
                	lo=level.players[i] gettagorigin("j_ankle_ri");
            }
        }
        if(lo!=-1)
        {
        	if(self.needAim==1)
        	{
        		if(self adsbuttonpressed())
					MagicBullet(self getcurrentweapon(),lo+(0,0,10),lo,self);
        	}
        	else
				MagicBullet(self getcurrentweapon(),lo+(0,0,10),lo,self);
		}
    }
}
isRealistic(player)
{
	self.angles=self getPlayerAngles();
	crosshair=VectorToAngles(player getTagOrigin("j_spine4") - self getTagOrigin("j_spine4"));
	distance=length(crosshair - self.angles);
	if(distance < 25)
		return 1;
	else
		return 0;
}
changeAimbotTag()
{
	if(self.aimAtTag=="chest")
    {
        self iprintln("Aimbot aiming at: ^5Head");
        self.aimAtTag="head";
		self.feedTag="MOD_HEAD_SHOT";
		self.AimbotTag="j_head";
    }
    else
    {
        self iprintln("Aimbot aiming at: ^5Chest");
        self.aimAtTag="chest";
		self.feedTag="MOD_RIFLE_BULLET";
		self.AimbotTag="j_chest";
    }
}
playerUnfairAim(player)
{
	if(!player isHost())
	{
		if(getDvar("aimbotLocked")=="1" && !self isHost())
			self iprintln("Aimbot ^1locked^7 by ^2Host");
		else
		{
			if(player.uaimbot==false)
    		{
    			player thread unfairAimBot();
        		self iprintln(player.name+" ^5now has^7 Unfair Aimbot");
    		}
    		else
    		{
    			player notify("EndUAim1");
    			player.uaimbot=false;
    			player iprintln("Unfair Aimbot ^4OFF");
        		self iprintln(player.name+" ^4no longer has^7 Unfair Aimbot");
    		}
    	}
	}
    else
    	self iprintln("You cannot give the ^2Host^7 Unfair Aimbot");
}
unfairAimBot()
{
	if(self.uaimbot==false)
	{
		self iprintln("Unfair Aimbot ^5ON");
		self thread doUnfairAimBot();
		self.uaimbot=true;
	}
	else
	{
		self iprintln("Unfair Aimbot ^4OFF");
		self notify("EndUAim1");
		self.uaimbot=false;
	}
}
doUnfairAimBot()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("EndUAim1");
	self endon("destroyMenu");
	for(;;)
	{
		aimAt=undefined;
		foreach(player in level.players)
		{
			if((player==self) || (!isAlive(player)) || (level.teamBased && self.pers["team"]==player.pers["team"]) || (player isHost()))
			continue;
			if(isDefined(aimAt))
			{
				if(closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
				aimAt=player;
			}
			else aimAt=player; 
		}
		if(isDefined(aimAt)) 
		{
			if(self.needAim==1)
			{
				if(self adsbuttonpressed())
				{
					self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head")))); 
					if(self attackbuttonpressed())
						aimAt thread [[level.callbackPlayerDamage]](self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0, 0);
				}
			}
			else
			{
				self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head")))); 
				if(self attackbuttonpressed())
					aimAt thread [[level.callbackPlayerDamage]](self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0, 0);
			}
		}
		wait 0.01;
	}
}
playerTrickAim(player)
{
	if(!player isHost())
	{
		if(getDvar("aimbotLocked")=="1" && !self isHost())
			self iprintln("Aimbot ^1locked^7 by ^2Host");
		else
		{
			if(player.taimbot==false)
    		{
        		player thread toggledAimTrick();
        		self iprintln(player.name+" ^5now has^7 Trickshot Aimbot");
    		}
    		else
    		{
    			player notify("EndUAim2");
    			player.taimbot=false;
    			player iprintln("Trickshot Aimbot ^4OFF");
        		self iprintln(player.name+" ^4no longer has^7 Trickshot Aimbot");
    		}
    	}
    }
    else
    	self iprintln("You cannot give the ^2Host^7 Trickshot Aimbot");
}
toggledAimTrick()
{
	if(self.taimbot==false)
	{
		self iprintln("Trickshot Aimbot ^5ON");
		self thread doToggledAimTrick();
		self.taimbot=true;
	}
	else
	{
		self iprintln("Trickshot Aimbot ^4OFF");
		self notify("EndUAim2");
		self.taimbot=false;
	}
}
doToggledAimTrick()
{
	self endon("disconnect");
	self endon("death");
	self endon("EndUAim2");
	self endon("destroyMenu");
    for(;;)
    {
        aimAt=undefined;
        self waittill("weapon_fired");
        foreach(player in level.players)
        {
            if((player==self)||(!isAlive(player))||(level.teamBased && self.pers["team"]==player.pers["team"])||(player isHost()))
            	continue;
            if(isDefined(aimAt))
            {
                if(closer(self getTagOrigin(self.AimbotTag),player getTagOrigin(self.AimbotTag),aimAt getTagOrigin(self.AimbotTag)))
                	aimAt=player;
            }
            else
            	aimAt=player;
        }
        if(isDefined(aimAt))
        {
            if(self.needAim==1)
            {
            	if(self adsbuttonpressed())
            	{
                	aimAt thread[[level.callbackPlayerDamage]](self,self,2147483600,8,self.feedTag,self getCurrentWeapon(),(0,0,0),(0,0,0),self.aimAtTag,0,0);
                	wait 0.01;
                }
            }
            else
            {
                aimAt thread[[level.callbackPlayerDamage]](self,self,2147483600,8,self.feedTag,self getCurrentWeapon(),(0,0,0),(0,0,0),self.aimAtTag,0,0);
                wait 0.01;
            }
        }
        wait 0.01;
    }
}
doAimbot()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("EndAutoAim");
	self endon("destroyMenu");
	self.faimbot=booleanOpposite(self.faimbot);
    self iprintln(booleanReturnVal(self.faimbot, "Crosshair Aimbot ^4OFF", "Crosshair Aimbot ^5ON"));
	if(self.faimbot)
	{
		for(;;)
  		{
  			self waittill("weapon_fired");
			foreach(player in level.players)
			{
				if(player==self||!isAlive(player)||level.teamBased && self.pers["team"]==player.pers["team"]||player isHost())
					continue;
				if(isRealistic(player))
				{
					x=randomint(10);
					if(self.needAim==1)
    				{
    					if(self adsbuttonpressed())
    					{
							if(x==1)
								player thread [[level.callbackPlayerDamage]](self,self,100,0,"MOD_HEAD_SHOT",self getCurrentWeapon(),(0,0,0),(0,0,0),"head",0,0);
							else
								player thread [[level.callbackPlayerDamage]](self,self,100,0,"MOD_RIFLE_BULLET",self getCurrentWeapon(),(0,0,0),(0,0,0),"spinelower",0,0);
						}
					}
					else
					{
						if(x==1)
							player thread [[level.callbackPlayerDamage]](self,self,100,0,"MOD_HEAD_SHOT",self getCurrentWeapon(),(0,0,0),(0,0,0),"head",0,0);
						else
							player thread [[level.callbackPlayerDamage]](self,self,100,0,"MOD_RIFLE_BULLET",self getCurrentWeapon(),(0,0,0),(0,0,0),"spinelower",0,0);
					}
				}
			}
		}
	}
	else
		self notify("EndAutoAim");
}
aimRequired()
{
	if(self.needAim==0)
    {
        self.needAim=1;
        self iprintln("Aiming Required ^5ON");
    }
    else
    {
        self.needAim=0;
        self iprintln("Aiming Required ^4OFF");
    }
}
doTeleport()
{
	self beginLocationSelection("map_mortar_selector"); 
	self.selectingLocation=1;
	self giveWeapon("killstreak_remote_turret_mp");
	self switchToWeapon("killstreak_remote_turret_mp");
	self waittill("confirm_location", location); 
	newLocation=BulletTrace(location+(0, 0, 100000), location, 0, self)["position"];
	self SetOrigin(newLocation);
	self endLocationSelection();
	self switchToWeapon(self maps\mp\_utility::getlastweapon());
	self.selectingLocation=undefined;
	self iprintln("^2Teleported!");
}
initRainModels()
{
	if(level.raining==0)
	{
		level.raining=1;
		self iprintlnbold("Rain Models ^5ON");
		self thread rainModels();
	}
	else
	{
		level.raining=0;
		self iprintlnbold("Rain Models ^4OFF");
		self notify("stopRainModels");
		self.rainMSet=false;
	}
}
rainModels()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("stopRainModels");
	if(!self.rainMSet)
	{
		self changeRainModel("veh_t6_drone_pegasus_mp");
		self.rainMSet=true;
	}
	for(;;)
	{
		x=randomIntRange(-10000,10000);
		y=randomIntRange(-10000,10000);
		z=randomIntRange(8000,10000);
		if(level.CurRain=="usrpg_mp")
			MagicBullet(level.CurRain, (x,y,z), (x,y,0), self);
		else
		{
			obj3=spawn("script_model",(x,y,z));
			level.Entities[level.amountOfEntities]=obj3;
			level.amountOfEntities++;
			obj3 setmodel(level.CurRain);
			obj3 PhysicsLaunch();
			obj3 thread DeleteOverTime();
		}
		wait 0.05;
	}
}
changeRainModel(model)
{
	self iprintln("Rain Model: ^5"+model);
	level.CurRain=model;
}
DeleteOverTime()
{
	wait 6.5;
	self delete();
}
Dovisions()
{
	if(self.visions==0)
	{
		self useServerVisionSet(0);
		self setinfraredvision(0);
		wait 0.01;
		self iprintln("Black and White");
		self useServerVisionSet(1);
		self SetVisionSetforPlayer("mpintro",0);
		self.visions=1;
	}
	else if(self.visions==1)
	{
		self useServerVisionSet(0);
		self setinfraredvision(0);
		wait 0.01;
		self iprintln("^4Light Vision");
		self.visions=2;
		self useServerVisionSet(1);
		self SetVisionSetforPlayer("taser_mine_shock",0);
	}
	else if(self.visions==2)
	{
		self useServerVisionSet(0);
		self setinfraredvision(0);
		wait 0.01;
		self iprintln("^3Enhanced Vision");
		self.visions=3;
		self useServerVisionSet(1);
		self SetVisionSetforPlayer("remote_mortar_enhanced",0);
	}
	else if(self.visions==3)
	{
		self useServerVisionSet(0);
		self setinfraredvision(0);
		wait 0.01;
		self setinfraredvision(1);
		self iprintln("^1Thermal Vision");
		self.visions=4;
	}
	else if(self.visions==4)
	{
		self useServerVisionSet(1);
		self SetVisionSetforPlayer("remote_mortar_enhanced",0);
		self iprintln("^5Cartoon Vision");
		self.visions=5;
	}
	else if(self.visions==5)
	{
		self useServerVisionSet(0);
		self setinfraredvision(0);
		wait 0.01;
		self useServerVisionSet(1);
		self SetVisionSetforPlayer("tvguided_sp",0);
		self iprintln("^2Blue Vision");
		self.visions=6;
	}
	else if(self.visions==6)
	{
		self unsetPerk("specialty_immuneemp");
		self useServerVisionSet(0);
		self setempjammed(1);
		self iprintln("^8EMP Vision");
		self.visions=7;
	}
	else if(self.visions==7)
	{
		self useServerVisionSet(0);
		self setempjammed(0);
		self iprintln("Normal Vision");
		self.visions=0;
	}
}
ExplodingWarthog()
{
    wartyProj=spawn("script_model", self.origin + (0, 0, 10)); 
    wartyProj setModel("veh_t6_air_a10f_alt");
    wartyProj rotatepitch(-90,1);
    wait 3;
   	wartyProj moveto(wartyProj.origin + (0,0,1000),2);
   	wartyProj rotateyaw(9000, 9);
   	wait 2;
 	playFX(level.chopper_fx["explode"]["large"], wartyProj.origin+(0,0,0));
 	playFX(level.chopper_fx["explode"]["large"], wartyProj.origin+(10,0,0));
 	playFX(level.chopper_fx["explode"]["large"], wartyProj.origin+(20,0,0));
 	playFX(level.chopper_fx["explode"]["large"], wartyProj.origin+(30,60,0));
 	playFX(level.chopper_fx["explode"]["large"], wartyProj.origin+(10,60,0));
 	playFX(level.chopper_fx["explode"]["large"], wartyProj.origin+(20,60,0));
 	playFX(level.chopper_fx["explode"]["large"], wartyProj.origin+(30,60,0));
 	playFX(level.chopper_fx["explode"]["large"], wartyProj.origin+(60,10,0));
 	playFX(level.chopper_fx["explode"]["large"], wartyProj.origin+(60,20,0));
 	playFX(level.chopper_fx["explode"]["large"], wartyProj.origin+(60,30,0));
 	wartyProj delete();
 	self playsound("wpn_rocket_explode");
 	wait 0.01;
 	self playsound("wpn_rocket_explode");
 	wait 0.01;
 	self playsound("wpn_rocket_explode");
 	wait 0.01;
 	self playsound("wpn_rocket_explode");
}
initTeamChange()
{
	if(getdvar("g_gametype")!="dm")
    {
		if(self.pers["team"]=="allies")
		{
			self iprintlnbold("Team set to ^5axis");
			self changeteam("axis");
		}
		else if(self.pers["team"]=="axis")
		{
			self iprintlnbold("Team set to ^5allies");
			self changeteam("allies");
		}
	}
	else
		self iprintln("^1Gamemode is not team based");
}
changeteam(team)
{
	if(self.sessionstate!="dead")
	{
		self.switching_teams=1;
		self.joining_team=team;
		self.leaving_team=self.pers["team"];
	}
	self.pers["team"]=team;
	self.team=team;
	self.sessionteam=self.pers["team"];
	self maps/mp/gametypes/_globallogic_ui::updateobjectivetext();
	self maps/mp/gametypes/_spectating::setspectatepermissions();
	self notify("end_respawn");
}
ChangeTeamPlayer(player)
{
	if(!player isHost())
	{
		self iprintln("Changed ^5" + player.name + "'s^7 team.");
		player thread initTeamChange();
	}
	else
		self iprintln("You cannot change the ^2Host's^7 team");
}
revivePlayer(player)
{
	if(!isAlive(player))
	{
		player thread spawnRevive();
		self iprintln("Revived ^5" + player.name);
	}
	else
		self iprintln("^1Player already alive");
}
doAllRevive()
{
	foreach(player in level.players)
	{
		if(!player isHost())
		{
			if(!isAlive(player))
				player thread spawnRevive();
		}
	}
	self iprintln("All players ^5revived");
}
spawnRevive()
{
	self endon("disconnect");
	self endon("end_respawn");
	if(!maps/mp/gametypes/_globallogic_utils::isvalidclass(self.pers["class"]))
	{
		self.pers["class"]="CLASS_CUSTOM1";
		self.class=self.pers["class"];
	}
	self maps/mp/gametypes/_globallogic_ui::closemenus();
	self unlink();
	if(isDefined(self.spectate_cam))
		self.spectate_cam delete();
	self thread [[level.spawnplayer]]();
}
reviveMeThread()
{
	self endon("disconnect");
	self endon("destroyMenu");
	level endon("game_ended");
	self endon("stop_res");
	self.resAfterDeath=booleanOpposite(self.resAfterDeath);
    self iprintln(booleanReturnVal(self.resAfterDeath, "Revive After Death ^4OFF", "Revive After Death ^5ON"));
    if(self.resAfterDeath)
    {
		self iprintlnbold("Press [{+usereload}] & [{+gostand}] while dead to respawn");
    	self waittill("death");
		for(;;)
		{
			if(!isAlive(self))
			{
				if(self jumpButtonPressed() && self useButtonPressed())
					self thread spawnRevive();
			}
			wait .06;
		}
	}
	else
		self notify("stop_res");
}
commitSuicide()
{
    self suicide();
}
giveTP()
{
    if(self.TPP==0)
    {
        self.TPP=1;
        self iprintln("Third Person ^5ON");
        self setclientthirdperson(1);
    }
    else
    {
        self.TPP=0;
        self iprintln("Third Person ^4OFF");
        self notify("stop_loopTPerson");
        self setclientthirdperson(0);
    }
}
forceHost()
{
    if(self isHost())
    {
		if(getDvar("forcingHost")=="0")
		{
			self iprintln("Force Host ^5ON");
			setDvar("forcingHost", "1");
			setDvar("party_connectToOthers", "0");
			setDvar("partyMigrate_disabled", "1");
			setDvar("party_mergingEnabled", "0");
			setDvar("allowAllNAT", "1");
		}
		else
		{
			self iprintln("Force Host ^4OFF");
			setDvar("forcingHost", "0");
			setDvar("party_connectToOthers", "1");
			setDvar("partyMigrate_disabled", "0");
			setDvar("party_mergingEnabled", "1");
			setDvar("allowAllNAT", "0");
		}
	}
	else
	    self iprintln("You must be ^2Host^7 to do that");
}
Toggle_Multijump()
{
    if(self.MultiJump==0)
    {
        self thread onPlayerMultijump();
        self.MultiJump=1;
        self iprintln("Multi Jump ^5ON");
    }
    else
    {
        self notify("EndMultiJump");
        self.MultiJump=0;
        self iprintln("Multi Jump ^4OFF");
    }
}
landsOnGround()
{
	level endon("game_ended");
	self endon("death");
   	self endon("disconnect");
   	self endon("EndMultiJump");
   	self endon("destroyMenu");
   	loopResult=true;
   	for(;;)
   	{
   		wait 0.05;
     	newResult=self isOnGround();
     	if(newResult!=loopResult)
     	{
       		if(!loopResult && newResult)
        	self notify("landedOnGround");
       		loopResult=newResult;
     	}
   	}
}
onPlayerMultijump()
{
	level endon("game_ended");
	self endon("death");
   	self endon("disconnect");
   	self endon("EndMultiJump");
   	self endon("destroyMenu");
   	self thread landsOnGround();
   	if(!isDefined(self.numOfMultijumps))
     	self.numOfMultijumps=999;
   	for(;;)
   	{
     	currentNum=0;
     	while(!self jumpbuttonpressed()) wait 0.05;
     	while(self jumpbuttonpressed()) wait 0.05;
     	if(getDvarFloat("jump_height") > 250)
       		continue;
     	if(!isAlive(self))
     	{
      		self waittill("spawned_player");
       		continue;
     	}
     	if(!self isOnGround())
     	{
       		while(!self isOnGround() && isAlive(self) && currentNum < self.numOfMultijumps)
       		{
         		waittillResult=self waittill_any_timeout(0.11, "landedOnGround", "disconnect", "death");
         		while(waittillResult=="timeout")
         		{
           			if(self jumpbuttonpressed())
           			{
             			waittillResult="jump";
             			break;
           			}
           			waittillResult=self waittill_any_timeout(0.05, "landedOnGround", "disconnect", "death");
         		}
         		if(waittillResult=="jump" && !self isOnGround() && isAlive(self))
         		{
           			playerAngles=self getplayerangles();
           			playerVelocity=self getVelocity();
           			self setvelocity((playerVelocity[0], playerVelocity[1], playerVelocity[2]/2) + anglestoforward((270, playerAngles[1], playerAngles[2])) * getDvarInt("jump_height") * (((-1/39) * getDvarInt("jump_height")) + (17/2)));
           			currentNum++;
           			while(self jumpbuttonpressed()) wait 0.05;
         		}
         		else
           			break;
       		}
       		while(!self isOnGround())
         	wait 0.05;
     	}
   	}
}
kickPlayer(player)
{
    if(player isHost())
        self iprintln("You cannot kick the " + verificationToColor("Host"));
    else
    {
        kick(player GetEntityNumber());
        wait .5;
        self submenu("PlayersMenu", "PlayersMenu");
    }
}
killPlayer(player)
{
    if(!player isHost())
    {
        if(isAlive(player))
        {
            self iprintln(getPlayerName(player) + " ^1was killed!");
            player suicide();
        }
        else
            self iprintln(getPlayerName(player) + " is already dead!");
    }
    else
        self iprintln("You cannot kill the " + verificationToColor(player.status));
}
givePlayerGod(player)
{
	if(!player isHost())
	{
    	player InfiniteHealth(false);
    	self iprintln(booleanReturnVal(player.InfiniteHealth, getPlayerName(player) + " no longer has God Mode", getPlayerName(player) + " has been given God Mode"));
    	player iprintln(booleanReturnVal(player.InfiniteHealth, "You no longer have God Mode", "You have been given God Mode"));
    }
    else
    	self iprintln("You cannot give the ^2Host^7 God Mode");
}
InfiniteHealth(print, printplayer)
{
    self.InfiniteHealth=booleanOpposite(self.InfiniteHealth);
    if(print)
        self iprintln(booleanReturnVal(self.InfiniteHealth, "God Mode ^4OFF", "God Mode ^5ON"));
    if(self.InfiniteHealth)
    {
        self enableInvulnerability();
        self.god=1;
    }
    else
    {
        self disableInvulnerability();
        self.god=0;
    }
}
givePlayerInvis(player)
{
    player endon("disconnect");
    player endon("death");
    if(!player isHost())
	{
    	if(player.invisible==0)
    	{
     	   player.invisible=1;
     	   self iprintln(player.name+" is now invisible");
     	   player iprintln("Invisible ^5ON");
     	   player hide();
   		}
    	else
    	{
			player.invisible=0;
        	self iprintln(player.name+" is no longer invisible");
        	player iprintln("Invisible ^4OFF");
        	player show();
        }
    }
    else
    	self iprintln("You cannot make the ^2Host^7 invisible");
}
freezePlayer(player, print)
{
	level endon("game_ended");
    player endon("disconnect");
    player endon("disableFreeze");
    if(!player isHost())
    {
        player.controlsFrozen=booleanOpposite(player.controlsFrozen);
        player iprintln(booleanReturnVal(player.controlsFrozen, "You have been ^4Unfrozen", "You have been ^5Frozen"));
        if(print)
            self iprintln(booleanReturnVal(player.controlsFrozen, getPlayerName(player) + " has been ^4Unfrozen", getPlayerName(player) + " has been ^5Frozen"));
        if(player.controlsFrozen)
        {
            for(;;)
            {
            	player freezeControls(true);
                wait 0.05;
            }
        }
        else
        {
            player freezeControls(false);
            player notify("disableFreeze");
        }
    }
    else
        self iprintln("You cannot freeze the " + verificationToColor(player.status));
}
teleportPlayer(player, destination)
{
	if(destination=="me")
	{
        if(!player isHost())
        {
            player setOrigin(self.origin);
            self iprintln(getPlayerName(player) + " was teleported to you");
        }
        else
    		self iprintln("You cannot teleport the ^2Host");
    }
    else if(destination=="them")
    {
        self setOrigin(player.origin);
        self iprintln("You were teleported to " + getPlayerName(player));
    }
}
antiQuit()
{
    if(self isHost())
    {
        level.antiQuit=booleanOpposite(level.antiQuit);
        self iprintln(booleanReturnVal(level.antiQuit, "Anti Quit ^4OFF", "Anti Quit ^5ON\n^1This removes the +XP and Medals HUD, you still receive them though"));
        if(level.antiQuit)
        {
            foreach(player in level.players)
            	player maps/mp/gametypes/_globallogic_ui::closeMenus();
            setmatchflag("final_killcam", 1);
        }
        else
            setmatchflag("final_killcam", 0);
    }
    else
        self iprintln("You must be ^2Host^7 to do that");
}
locationSelector()
{
    self beginLocationSelection("map_mortar_selector");
    self.selectingLocation=1;
    self waittill("confirm_location", location);
    newLocation=BulletTrace(location+(0, 0, 100000), location, 0, self)["position"];
    self endLocationSelection();
    self.selectingLocation=undefined;
    return newLocation;
}
kamikaze()
{
    self endon("disconnect");
    self endon("death");
    Location=locationSelector();
    self iprintln("^3Kamikaze Bomber Inbound");
    Kamikaze=spawn("script_model", self.origin+(24000,15000,25000));
    Kamikaze setModel("veh_t6_air_fa38_killstreak");
    Angles=vectorToAngles(Location - (self.origin+(8000,5000,10000)));
    Kamikaze.angles=Angles;
    Kamikaze moveto(Location, 3.5);
    Kamikaze playsound("mpl_lightning_flyover_boom");
    playFxOnTag(level.chopper_fx["damage"]["light_smoke"], Kamikaze, "tag_origin");
    wait 3.6;
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin);
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(400,0,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,400,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(400,400,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,400));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(400,0,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(0,400,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(400,400,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,800));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(200,0,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,200,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(200,200,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,200));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(200,0,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(0,200,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(200,200,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,200));
    Kamikaze playsound(level.heli_sound["crash"]);
    self RadiusDamage(Kamikaze.origin, 500, 1000, 100, self);
    Kamikaze delete();
    Earthquake(0.4, 4, Kamikaze.origin, 800);
}
noclip()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("stopNoclip");
	self endon("destroyMenu");
	nocliping = 0;
	for(;;)
	{
		if(self fragbuttonpressed() && nocliping == 0 || self secondaryoffhandbuttonpressed() && nocliping == 0)
		{
			self disableoffhandweapons();
			self.originObj=spawn("script_origin",self.origin,1);
			self.originObj.angles=self.angles;
			self playerlinkto(self.originObj,undefined);
			nocliping = 1;
		}
		if(self secondaryoffhandbuttonpressed() && nocliping == 1)
		{
			normalized=anglesToForward(self getPlayerAngles());
			scaled=vectorScale(normalized,20);
			originpos=self.origin + scaled;
			self.originObj.origin=originpos;
		}
		if(self fragbuttonpressed() && nocliping == 1)
		{
			normalized=anglesToForward(self getPlayerAngles());
			scaled=vectorScale(normalized,50);
			originpos=self.origin + scaled;
			self.originObj.origin=originpos;
		}
		if(self stancebuttonpressed() && nocliping == 1)
		{
			self unlink();
			self.originObj delete();
			self enableoffhandweapons();
			nocliping = 0;
		}
		wait 0.05;
	}
}
togglenoclip()
{
	if(self.nclip==true)
	{
		self thread noclip();
		self iprintln("NoClip ^5ON\nHold [{+frag}] or [{+smoke}] to move\nPress [{+stance}] to stop");
		self.nclip=false;
	}
	else
	{
		self enableoffhandweapons();
		self iprintln("NoClip ^4OFF");
		self unlink();
		self.originObj delete();
		self.nclip=true;
		self notify("stopNoclip");
	}
}
ToggleForgeMode()
{
	if(self.forgemode==false)
	{
		self thread ForgeMode();
		self iprintln("Advanced Forge Mode ^5ON");
		self.forgemode=true;
	}
	else
	{
		self iprintln("Advanced Forge Mode ^4OFF");
		self notify("StopForge");
		self.forgeText destroy();
		self.forgemode=false;
	}
}
ForgeMode()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("StopForge");
	self endon("destroyMenu");
	self.forgeText = self dT("[{+speed_throw}] ^3Move Objects^7\n[{+actionslot 3}] ^2Spawn^7\n[{+actionslot 4}] ^1Delete", "objective", 1.2, -280, 200, (1, 1, 1), 1, (1, 0, 0), 1, 1);
	for(;;)
	{
		if(self adsbuttonpressed())
		{
			trace=bulletTrace(self GetTagOrigin("j_head"),self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 1000000,true,self);
			while(self adsbuttonpressed())
			{
				trace["entity"] setOrigin(self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200);
				trace["entity"].origin=self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200;
				wait 0.05;
			}
		}
		if(self actionSlotThreeButtonPressed())
		{
			self SpawnCrate();
			self iprintln("Crate ^2spawned");
		}
		if(self actionslotfourbuttonpressed())
		{
			if(isdefined(self.CurrentCrate))
			{
				self.CurrentCrate delete();
				self.CurrentCrate=undefined;
			}
			else
				self NormalisedTrace("entity") delete();
			self iprintln("Entity ^1deleted");
		}
		wait 0.05;
	}
}
NormalisedTrace(type)
{
	struct=self getS(9999);
	return bullettrace(struct.start,struct.end,false,undefined)[type];
}
getS(scale)
{
	forward=anglestoforward(self getplayerangles());
	struct=spawnstruct();
	struct.start=self geteye();
	struct.end=struct.start + vectorScale(forward,scale);
	return struct;
}
SpawnCrate()
{
	self.CurrentCrate=spawn("script_model",self NormalisedTrace("position"));
	self.CurrentCrate setmodel("t6_wpn_supply_drop_ally");
}
initSmokeMonster()
{
    self.smokeman=booleanOpposite(self.smokeman);
	self iprintln(booleanReturnVal(self.smokeman,"Smoke Monster ^4OFF","Smoke Monster ^5ON"));
    if(self.smokemonsterr==0 || self.smokeman)
    {
   		self.smokemonsterr=1;
        self thread doSmokeMonster();
    }
    else
    {
        self.smokemonsterr=0;
        self notify("stop_smokemonster");
    }
}
doSmokeMonster()
{
	level endon("game_ended");
    self endon("death");
    self endon("disconnect");
    self endon("stop_smokemonster");
    self endon("destroyMenu");
    for(;;)
    {
        spawntimedfx(level.fx_smokegrenade_single, self getTagOrigin("j_spine4"), (0, 0, 1), 6);
        wait 0.2;
    }
}
dofreezeall()
{
	if(level.frozen==false)
	{
		self iprintln("All players ^5Frozen");
		level.frozen=true;
		foreach(player in level.players)
		{
			if(player isHost() && !self isHost())
				player iprintln(self.name+" ^4has^7 frozen all");
			else
			{
				if(getDvar("verPlayersImmune")=="1")
				{
					if(!player isVerified())
						player freezecontrols(true);
				}
				else
					player freezecontrols(true);
			}
		}
	}
	else
	{
		self iprintln("All players ^4Unfrozen");
		level.frozen=false;
		foreach(player in level.players)
		{
			if(player isHost() && !self isHost())
				player iprintln(self.name+" ^4has^7 unfrozen all");
			if(!player isHost())
			{
				if(getDvar("verPlayersImmune")=="1")
				{
					if(!player isVerified())
						player freezecontrols(false);
				}
				else
					player freezecontrols(false);
			}
		}
	}
}
doRestart()
{
	map_restart(false);
}
doEndGame()
{
	level.hostforcedend = 0;
    level thread maps/mp/gametypes/_globallogic::forceend();
}
pokeBall()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("pokemonRelease");
    if(!self.pokeBall)
    {
        self takeweapon(self getcurrentoffhand());
    	self giveweapon("sensor_grenade_mp");
        self iprintln("^6Throw a Sensor Grenade");
        self.pokeBall=true;
        for(;;)
        {
            self waittill("grenade_fire", grenade, weaponName);
            if(weaponName=="sensor_grenade_mp")
            {
            	if(self.god==0)
            		self EnableInvulnerability();
                self iprintlnbold("^3Pikachu! ^1I choose you!");
                grenade hide();
                self.fakeSensorGrenade=spawn("script_model", grenade.origin);
                self.fakeSensorGrenade setModel("t6_wpn_motion_sensor_world_detect");
                self.fakeSensorGrenade linkTo(grenade);
                grenade waittill("death");
                self thread Pokemon_Think(self.fakeSensorGrenade.origin, self.fakeSensorGrenade.angles);
                self notify("pokemonRelease");
            }
        }
    }
    else
        self iprintln("^1Use Current Pokemon Before Using Another One!");
}
Pokemon_Think(origin, angles)
{
    self.pokemon["model"]="german_shepherd";
    self.pokemon["pokemonEntity"]=spawn("script_model", origin);
    self.pokemon["pokemonEntity"] SetModel(self.pokemon["model"]);
    self.pokemon["pokemonEntity"].killCamEnt=self.pokemon["pokemonEntity"];
    self.pokemon["newOrigin"]=origin + (0, 0, 500);
    self.pokemon["pokemonEntity"] RotateTo((0, angles[1], 0), 0);
    self.pokemon["pokemonEntity"] MoveTo(self.pokemon["newOrigin"], 5);
    wait 5;   
    self.pokemon["newOrigin"]=self.pokemon["pokemonEntity"].origin + VectorScale(AnglesToForward(self.pokemon["pokemonEntity"].angles), 1000);
    self.pokemon["pokemonEntity"] MoveTo(self.pokemon["newOrigin"], 0.50);
    wait 0.50;
    self.pokemon["pokemonEntity"] PlaySound(level.heli_sound["crash"]);
    foreach(player in level.players)
    {
        if(level.teamBased && self.pers["team"]==player.pers["team"])
        { }
        else
        {
        	if(!player isHost())
            {
                if(player!=self)
                    player thread [[level.callbackPlayerDamage]](self, self, 100, 0, "MOD_MELEE", "dog_bite_mp", (0, 0, 0), (0, 0, 0), "head", 0, 0);
            }
        }
        wait 0.05;
     }
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin);
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (400, 0, 0));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 400, 0));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (400, 400, 0));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 0 ,400));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (400, 0, 0));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (0, 400, 0));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (400, 400, 0));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 0, 800));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (200, 0, 0));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 200, 0));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (200, 200, 0));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 0, 200));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (200, 0, 0));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (0 ,200 ,0));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (200, 200, 0));
     playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 0, 200));
     self.pokemon["pokemonEntity"] delete();
     self.fakeSensorGrenade delete();
     self.pokeBall=false;
     if(self.god==0)
     	self DisableInvulnerability();
}
doStrafeRun()
{
    if(!self.AwaitingPreviousStrafe)
    {
        Location=locationSelector();
        self.AwaitingPreviousStrafe=true;
        foreach(player in level.players)
            player iprintlnbold("^4---^3Strafe Run ^1Inbound^4---");
        locationYaw=180;
        flightPath1=getFlightPath(Location, locationYaw, 0);
        flightPath2=getFlightPath(Location, locationYaw, -620);  
        flightPath3=getFlightPath(Location, locationYaw, 620);
        flightPath4=getFlightPath(Location, locationYaw, -1140);
        flightPath5=getFlightPath(Location, locationYaw, 1140);
        level thread Strafe_Think(self, flightPath1);
        wait 0.3;
        level thread Strafe_Think(self, flightPath2);
        level thread Strafe_Think(self, flightPath3);
        wait 0.3;
        level thread Strafe_Think(self, flightPath4);
        level thread Strafe_Think(self, flightPath5);
        wait 60;
        self.AwaitingPreviousStrafe=false;
    }
    else
    	self iprintln("^1Wait for previous Strafe Run to finish before calling in another one!");
}
Strafe_Think(owner, flightPath)
{
    level endon("game_ended");
    if(!isDefined(owner))
    return;
    forward=vectorToAngles(flightPath["end"] - flightPath["start"]);
    StrafeHeli=SpawnStrafeHelicopter(owner, flightPath["start"], forward);
    StrafeHeli thread Strafe_Attack_Think();
    StrafeHeli setYawSpeed(120, 60);  
    StrafeHeli setSpeed(48, 48);
    StrafeHeli setVehGoalPos(flightPath["end"], 0);
    StrafeHeli waittill("goal");
    StrafeHeli setYawSpeed(30, 40);
    StrafeHeli setSpeed(32, 32);
    StrafeHeli setVehGoalPos(flightPath["start"], 0);  
    wait 2;
    StrafeHeli setYawSpeed(100, 60);
    StrafeHeli setSpeed(64, 64);
    StrafeHeli waittill("goal");
    self notify("chopperdone");
     StrafeHeli delete();
}
Strafe_Attack_Think()
{
	level endon("game_ended");
	self endon("disconnect");
    self endon("chopperdone");
    self setVehWeapon(self.defaultweapon);
    for(;;)
    {
        for(i=0; i < level.players.size; i++)
        {
            if(CanTargetPlayer(level.players[i]))
            {
                self setturrettargetent(level.players[i]);
                self FireWeapon("tag_flash", level.players[i]);
            }
        }
        wait 0.5;
    }
}
SpawnStrafeHelicopter(owner, origin, angles)
{
    Team=owner.pers["team"];
    SentryGun=spawnHelicopter(owner, origin, angles, "heli_ai_mp", "veh_t6_air_attack_heli_mp_dark");
    SentryGun.team=Team;
    SentryGun.pers["team"]=Team;
    SentryGun.owner=owner;
    SentryGun.currentstate="ok";
    SentryGun setdamagestage(4);
    SentryGun.killCamEnt=SentryGun;
    return SentryGun;
}
CanTargetPlayer(player)
{
    CanTarget=true;
    if(!IsAlive(player) || player.sessionstate!="playing")
    	return false;
    if(Distance(player.origin, self.origin) > 5000)
        return false;
    if(!isDefined(player.pers["team"]))
        return false;  
    if(level.teamBased && player.pers["team"]==self.team)
        return false;  
    if(player==self.owner)
        return false;  
    if(player.pers["team"]=="spectator")
        return false;  
    if(!BulletTracePassed(self getTagOrigin("tag_origin"), player getTagOrigin("j_head"), false, self))
        return false;
    return CanTarget;
}
getFlightPath(location, locationYaw, rightOffset)
{
    location=location * (1, 1, 0);
    initialDirection=(0, locationYaw, 0);
    planeHalfDistance=12000;
    flightPath=[];
    if(isDefined(rightOffset) && rightOffset!=0)
    location=location + (AnglesToRight(initialDirection) * rightOffset) + (0, 0, RandomInt(300));
    startPoint=(location + (AnglesToForward(initialDirection) * (-1 * planeHalfDistance)));
    endPoint=(location + (AnglesToForward(initialDirection) * planeHalfDistance));
    flyheight=1500;
    if(isDefined(maps/mp/killstreaks/_airsupport::getminimumflyheight()))
    flyheight=maps/mp/killstreaks/_airsupport::getminimumflyheight();
    flightPath["start"]=startPoint + (0, 0, flyHeight);  
    flightPath["end"]=endPoint + (0, 0, flyHeight);
    return flightPath;
}
initGiveKS(code, patt)
{
    self iprintlnbold("Gave: ^5"+code);
    if(patt==0)
        self maps/mp/killstreaks/_killstreaks::givekillstreak(maps/mp/killstreaks/_killstreaks::getkillstreakbymenuname(code) , 5594, true, 5594);
    else if(patt==1)
    {
        self GiveWeapon(code, 0, false);
        self switchToWeapon(code);
    }
}
unlockAllCheevos()
{
   self thread maps\mp\gametypes\_hud_message::hintMessage("^1All Trophys Unlocking Now...\n^3Please wait... this takes some time ^5;)", 10);
   cheevoList=strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_****STAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_****STAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST", ",");
   foreach(cheevo in cheevoList)
   {
       self giveachievement(cheevo);
       wait 0.25;
   }
}
changeMap(mapname)
{
    setDvar("ls_mapname", mapname);
	setDvar("mapname", mapname);
	setDvar("party_mapname", mapname);
	setDvar("ui_mapname", mapname);
	setDvar("ui_currentMap", mapname);
	setDvar("ui_mapname", mapname);
	setDvar("ui_preview_map", mapname);
	setDvar("ui_showmap", mapname);
	map(mapname, false);
}
pl360()
{
	if(self.kkkz==0)
    {
    	setDvar("bg_ladder_yawcap","360");
        setDvar("bg_prone_yawcap","360");
        self iprintln("360 Ladder/Prone ^5ON");
        self.kkkz=1;
    }
    else
    {
       	self iprintln("360 Ladder/Prone ^4OFF");
        setDvar("bg_ladder_yawcap","85");
        setDvar("bg_prone_yawcap","85");
        self.kkkz=0;
    }
}
freezePS3(player)
{
	if(!player isHost())
	{
		level endon("game_ended");
		player endon("disconnect");
		self iprintln("^5" + player.name + "'s ^7console has been frozen");
		player iprintln("^1Your game will crash in 5 seconds\n^2Have a nice day!");
		for(i=0;i < 250;i++)
		{
			player iprintlnbold("^HO");
			wait 0.01;
		}
	}
	else
		self iprintln("You cannot freeze the ^2Host's^7 console");
}
ChangeMiniMap(shader)
{
    maps\mp\_compass::setupminimap(shader);
    self iprintln("Minimap ^5changed!");
}
RandomMod()
{
    self TakeAllWeapons();
    if(self.TPP==0)
    	self setclientthirdperson(1);
    self giveWeapon("knife_ballistic_mp",0,true(44,0,0,0,0));
	self givemaxammo("knife_ballistic_mp");
	playFxOnTag(level.waypointRed, self, "tag_weapon_left");
	playFxOnTag(level.waypointGreen, self, "tag_weapon_right");
	playFxOnTag(level.waypointRed, self, "tag_weapon_right");
	playFxOnTag(level.waypointGreen, self, "tag_weapon_left");
	level endon("game_ended");
	self endon("death");
	self endon("sabers");
	self endon("disconnect");
	self endon("destroyMenu");
	for(;;)
	{
	    self waittill("fireworks");
	    playFxOnTag(level.bettydestroyedfx, self, "tag_weapon_right");
	 	playFxOnTag(level.bettydestroyedfx, self, "tag_weapon_left");
	}
}
givesabers()
{
	if(self.givinsbers==false)
	{
		self thread RandomMod();
		self.sabers=true;
		self.givinsbers=true;
		self iprintln("Light Sabers ^5ON");
	}
	else
	{
		self.sabers=false;
		self notify("sabers");
		self.givinsbers=false;
		if(self.TPP==0)
			self setclientthirdperson(0);
		self takeweapon("knife_ballistic_mp");
		self giveWeapon("mp7_mp");
		self givemaxammo("mp7_mp");
		self iprintln("Light Sabers ^4OFF");
	}
}
initElectricCherry()
{
	if(self.eCherry==0)
	{
		self.eCherry=1;
		self thread ElectricCherry();
		self iprintln("Electric Cherry ^5ON");
	}
	else
	{
		self.eCherry=0;
		self notify("EndECherry");
		self iprintln("Electric Cherry ^4OFF");
	}
}
ElectricCherry()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("destroyMenu");
	self endon("EndECherry");
	for(;;)
	{
		self waittill("reload_start");
		playFxOnTag(level._effect["prox_grenade_player_shock"], self, "j_head");
		playFxOnTag(level._effect["prox_grenade_player_shock"], self, "J_Spine1");
		playFxOnTag(level._effect["prox_grenade_player_shock"], self, "J_Spine4");
		playFxOnTag(level._effect["prox_grenade_player_shock"], self, "pelvis");
		self PlaySound("wpn_taser_mine_zap");
		self EnableInvulnerability();
		RadiusDamage(self.origin,200,9999,50,self);
		wait 1;
		self DisableInvulnerability();
	}
}
AGR_ARMY()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("death");
    self endon("stop_agrarmy");
    self endon("destroyMenu");
    self.agrarmy=booleanOpposite(self.agrarmy);
    self iprintln(booleanReturnVal(self.agrarmy, "AGR Army ^4OFF", "AGR Army ^5ON\n^7Shoot to spawn\n^1Do not spawn too many, otherwise G-Spawn error"));
    if(self.agrarmy)
	for(;;)
	{
		self waittill ("weapon_fired");
		direction=self GetPlayerAngles();
		direction_vec=AnglesToForward(direction);
		eye=self GetEye();
		scale=8000;
		direction_vec=(direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
		trace=bullettrace(eye, eye + direction_vec, 0, undefined)["position"];
		drone=spawnvehicle("veh_t6_drone_tank", "talon", "ai_tank_drone_mp", trace, (0, 0, 1));
		drone setenemymodel("veh_t6_drone_tank_alt");
		drone setvehicleavoidance(1);
		drone setclientfield("ai_tank_missile_fire", 4);
		drone setowner(self);
		drone.owner=self;
		drone.team=self.team;
		drone.aiteam=self.team;
		drone.type="tank_drone";
		drone setteam(self.team);
		drone maps/mp/_entityheadicons::setentityheadicon(drone.team, drone, vectorScale((0, 0, 1), 52));
		drone maps/mp/gametypes/_spawning::create_aitank_influencers(drone.team);
		drone.controlled=0;
		drone makevehicleunusable();
		drone.numberrockets=99;
		drone.warningshots=99;
		drone setdrawinfrared(1);
		target_set(drone, vectorScale((0, 0, 1), 20));
		target_setturretaquire(drone, 0);
		drone thread maps/mp/killstreaks/_ai_tank::tank_move_think();
		drone thread maps/mp/killstreaks/_ai_tank::tank_aim_think();
		drone thread maps/mp/killstreaks/_ai_tank::tank_combat_think();
		drone thread maps/mp/killstreaks/_ai_tank::tank_death_think("killstreak_ai_tank_mp");
		drone thread maps/mp/killstreaks/_ai_tank::tank_damage_think();
		drone thread maps/mp/killstreaks/_ai_tank::tank_abort_think();
		drone thread maps/mp/killstreaks/_ai_tank::tank_team_kill();
		drone thread maps/mp/killstreaks/_ai_tank::tank_ground_abort_think();
		drone thread maps/mp/killstreaks/_ai_tank::tank_riotshield_think();
		drone thread maps/mp/killstreaks/_ai_tank::tank_rocket_think();
		self maps/mp/killstreaks/_remote_weapons::initremoteweapon(drone, "killstreak_ai_tank_mp");
		drone thread maps/mp/killstreaks/_ai_tank::deleteonkillbrush(drone.owner);
		level thread maps/mp/killstreaks/_ai_tank::tank_game_end_think(drone);
	}
	else
	    self notify("stop_agrarmy");
}
cloneme()
{
    self iprintln("Clone ^5Spawned");
    ffdc=self ClonePlayer(9999);
}
deadclone()
{
    self iprintln("Dead Clone ^5Spawned");
    ffdc=self ClonePlayer(9999);
    ffdc startragdoll(1);
}
mexicanWave(mexmodel)
{
	level.mexicanWave=spawnMultipleModels((self.origin+(0,180,0)),1,20,1,0,-25,0,mexmodel,(0,180,0));
	for(m=0;m<level.mexicanWave.size;m++)
	{
		level.mexicanWave[m] thread mexicanMove();
		wait .1;
	}
}
mexicanMove()
{
	while(isDefined(self))
	{
		self moveZ(80,1,.2,.4);
		wait 1;
		self moveZ(-80,1,.2,.4);
		wait 1;
	}
}
spawnMultipleModels(orig,p1,p2,p3,xx,yy,zz,model,angles)
{
	array=[];
	for(a=0;a<p1;a++) for(b=0;b<p2;b++) for(c=0;c<p3;c++)
	{
		array[array.size]=spawnSM((orig[0]+(a*xx),orig[1]+(b*yy),orig[2]+(c*zz)),model,angles);
		wait .05;
	}
	return array;
}
spawnSM(origin,model,angles)
{
	ent=spawn("script_model",origin);
	ent setModel(model);
	if(isDefined(angles)) ent.angles=angles;
	return ent;
}
array_Delete(array)
{
	for(i=0;i<array.size;i ++)
		array[i] delete();
}
spawnMissle()
{
    self thread closeMenu();
	self giveWeapon("briefcase_bomb_mp", 0, false);
	self switchToWeapon("briefcase_bomb_mp");
    self hide();
    wait 2.5;
    enemies=self GetEnemies(true);
    self iprintln("Press [{+speed_throw}] to boost");
    self.missile_reticle_top=newclienthudelem(self);
    self.missile_reticle_top.alignX="center";
    self.missile_reticle_top.alignY="middle";
    self.missile_reticle_top.horzAlign="user_center";
    self.missile_reticle_top.vertAlign="user_center";
    self.missile_reticle_top.font="small";
    self.missile_reticle_top SetShader("reticle_side_round_big_top", 140, 64);
    self.missile_reticle_top.hidewheninmenu=false;
    self.missile_reticle_top.immunetodemogamehudsettings=true;
    self.missile_reticle_top.x=0;
    self.missile_reticle_top.y=0;
    self.missile_reticle_bottom=newclienthudelem(self);
    self.missile_reticle_bottom.alignX="center";
    self.missile_reticle_bottom.alignY="middle";
    self.missile_reticle_bottom.horzAlign="user_center";
    self.missile_reticle_bottom.vertAlign="user_center";
    self.missile_reticle_bottom.font="small";
    self.missile_reticle_bottom SetShader("reticle_side_round_big_bottom", 140, 64);
    self.missile_reticle_bottom.hidewheninmenu=false;
    self.missile_reticle_bottom.immunetodemogamehudsettings=true;
    self.missile_reticle_bottom.x=0;
    self.missile_reticle_bottom.y=0;
    self.missile_reticle_right=newclienthudelem(self);
    self.missile_reticle_right.alignX="center";
    self.missile_reticle_right.alignY="middle";
    self.missile_reticle_right.horzAlign="user_center";
    self.missile_reticle_right.vertAlign="user_center";
    self.missile_reticle_right.font="small";
    self.missile_reticle_right SetShader("reticle_side_round_big_right", 64, 140);
    self.missile_reticle_right.hidewheninmenu=false;
    self.missile_reticle_right.immunetodemogamehudsettings=true;
    self.missile_reticle_right.x=0;
    self.missile_reticle_right.y=0;
    self.missile_reticle_left=newclienthudelem(self);
    self.missile_reticle_left.alignX="center";
    self.missile_reticle_left.alignY="middle";
    self.missile_reticle_left.horzAlign="user_center";
    self.missile_reticle_left.vertAlign="user_center";
    self.missile_reticle_left.font="small";
    self.missile_reticle_left SetShader("reticle_side_round_big_left", 64, 140);
    self.missile_reticle_left.hidewheninmenu=false;
    self.missile_reticle_left.immunetodemogamehudsettings=true;
    self.missile_reticle_left.x=0;
    self.missile_reticle_left.y=0;
    remoteMissileSpawnArray=getEntArray("remoteMissileSpawn" , "targetname");
    foreach(spawn in remoteMissileSpawnArray)
    {
        if(isDefined(spawn.target))
        spawn.targetEnt=getEnt(spawn.target, "targetname");
    }
    if(remoteMissileSpawnArray.size > 0)
        remoteMissileSpawn=self getBestSpawnPoint(remoteMissileSpawnArray);
    else
        remoteMissileSpawn=undefined;
    if(isDefined(remoteMissileSpawn))
    {
        startPos=remoteMissileSpawn.origin;
        targetPos=remoteMissileSpawn.targetEnt.origin;
        vector=vectorNormalize(startPos - targetPos);
        startPos=(vector * 18000) + targetPos;
    }
    else
    {
        upVector=(0, 0, 18000);
        backDist=7000;
        targetDist=7000;
        forward=AnglesToForward(self.angles);
        startpos=self.origin + upVector + forward * backDist * -1;
        targetPos=self.origin + forward * targetDist;
    }
    self setUsingRemote("remote_missile_mp");
    rocket=MagicBullet("remote_missile_missile_mp", startpos, targetPos, self);
    rocket.targetname="remote_missile";
    rocket.team=self.team;
    rocket setTeam(self.team);
    self LinkToMissile(rocket, true);
    rocket.owner=self;
    rocket.killcament=self;
    rocket missile_sound_play(self);
    rocket thread missile_timeout_watch();
    rocket thread missile_sound_impact(self, 4000);
    self thread missile_sound_boost(rocket);
    rocket waittill("death");
    missile_end_sounds(rocket, snd_first, snd_third);
    self UnlinkFromMissile();
    self freezeControlsWrapper(false);
    self clearUsingRemote();
    self EnableWeaponCycling();
    if(isDefined(self.missile_reticle_top))
        self.missile_reticle_top destroy();
    if(isDefined(self.missile_reticle_bottom))
        self.missile_reticle_bottom destroy();
    if(isDefined(self.missile_reticle_right))
        self.missile_reticle_right destroy();
    if(isDefined(self.missile_reticle_left))
        self.missile_reticle_left destroy();
    self switchToWeapon(self maps/mp/_utility::getlastweapon());
	self show();
}
hulktoggle()
{
    self endon("death");
    self endon("disconnect");
    self endon("koral");
    if(level.hulkamania==0)
    {
        level.hulkamania=1;
        self iprintlnbold("^1Your Getting ANGRY!");
        if(self.god==0)
        	self EnableInvulnerability();
        self closeMenu();
        wait 1.5;
        self thread theHulk();
        self thread HulkSmash();
        self thread hulkquake();
        self thread hulkdone();
        self setPerk("specialty_unlimitedsprint");
        self setPerk("specialty_sprintrecovery");
        self setPerk("specialty_stunprotection");
        self setPerk("specialty_pin_back");
        self setPerk("specialty_flashprotection");
        self setPerk("specialty_flakjacket");
        self setPerk("specialty_fasttoss");
        self setPerk("specialty_fastmantle");
        self setPerk("specialty_fallheight");
        self setPerk("specialty_fastequipmentuse");
        self setPerk("specialty_fastreload");
        self setPerk("specialty_fastmeleerecovery");
        self setPerk("specialty_movefaster");
        self setPerk("specialty_healthregen");
        self iprintln("^1Press [{+frag}] To Throw A Helicopter");
        self disableusability();
        self disableweaponcycling();
        self setModel("defaultactor");
        self giveweapon("defaultweapon_mp");
        self switchtoweapon("defaultweapon_mp");
        self givemaxammo("defaultweapon_mp");
        self iprintln("^4Press [{+switchseat}] To Turn Hulk ^4OFF!");
        self SetVisionSetforPlayer("infrared", 0);
        self useServerVisionSet(true);
        
    }
    else
        self iprintlnbold("There can only be one Hulk!");
}
theHulk()
{
	level endon("game_ended");
    self endon("death");
    self endon("disconnect");
    self endon("koral");
    self endon("destroyMenu");
    self takeweapon(self getcurrentoffhand());
    self giveweapon("destructible_car_mp");
    for(;;)
    {
        self waittill("grenade_fire", grenade, weaponName);
        self takeweapon(self getcurrentoffhand());
        self giveweapon("destructible_car_mp");
        if(weaponName=="destructible_car_mp")
        {
            grenade hide();
            self.boom=spawn("script_model", grenade.origin);
            self.boom SetModel("veh_t6_drone_overwatch_light");
            self.boom linkTo(grenade);
            self disableoffhandweapons();
            grenade waittill("death");
            playfx(level.remote_mortar_fx["missileExplode"], self.boom.origin);
            RadiusDamage(self.boom.origin, 400, 400, 300, self, "MOD_EXPLOSIVE");
            self.boom delete();
            self enableoffhandweapons();
        }
        continue;
        wait 0.05;
    }
}
hulkdone()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("destroyMenu");
	self endon("death");
    for(;;)
    {
        if(self changeseatbuttonpressed())
        {    
            if(isDefined(level.hulkamania))
                level.hulkamania=0;
            if(self.god==0)
        		self DisableInvulnerability();
            self enableusability();
            self enableweaponcycling();
            self unsetPerk("specialty_unlimitedsprint");
            self unsetPerk("specialty_sprintrecovery");
            self unsetPerk("specialty_stunprotection");
            self unsetPerk("specialty_pin_back");
            self unsetPerk("specialty_flashprotection");
            self unsetPerk("specialty_flakjacket");
            self unsetPerk("specialty_fasttoss");
            self unsetPerk("specialty_fastmantle");
            self unsetPerk("specialty_fallheight");
            self unsetPerk("specialty_fastequipmentuse");
            self unsetPerk("specialty_fastreload");
            self unsetPerk("specialty_fastmeleerecovery");
            self unsetPerk("specialty_movefaster");
            self unsetPerk("specialty_healthregen");
            self useServerVisionSet(false);
            self enableoffhandweapons();
            self [[game["set_player_model"][self.team]["default"]]]();
            self takeweapon("defaultweapon_mp");
            self iprintln("The Hulk ^4OFF");
            self notify("koral");
            if(isDefined(self.boom))
                self.boom delete();
            wait 0.05;
            break;
        }
        wait 0.05;
    }
}
HulkSmash()
{
    self endon("disconnect");
    self endon("death");
    self endon("koral");
    self endon("destroyMenu");
    if(!isDefined(self.isEarthQuake))
        self.isEarthQuake=true;
    while(isDefined(self.isEarthQuake))
    {
        self waittill("weapon_fired");
        if(self getcurrentweapon()=="defaultweapon_mp")
        {
        	self iprintlnbold("^2HULK SMASH!");
            position=bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"];
            earthquake(0.9, 0.9, self.origin, 400);
            PlayRumbleOnPosition("grenade_rumble", self.origin);
            foreach(person in level.players)
                person playsound("wpn_rocket_explode_rock");
            wait 0.05;
        }
    }
}
hulkquake()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("death");
    self endon("koral");
    self endon("destroyMenu");
    for(;;)
    {
        self waittill ("weapon_fired");
        forward=self getTagOrigin("j_head");
        end=vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
        ExpLocation=BulletTrace(forward, end, false, self)["position"];
        RadiusDamage(ExpLocation, 300, 500, 400, self);
        wait 0.05;
    }
}
packapunch()
{
	if(self isHost())
	{
		if(level.papspawned==0)
		{
			level.papspawned=1;
    		self iprintln("Pack-A-Punch ^5Spawned");
    		self doPAP();
    	}
    	else
    	{
    		level.papspawned=0;
    		level notify("end_pap");
    		self iprintln("Pach-A-Punch ^4Destroyed");
    		level.NGU delete();
    		self.packit destroy();
    	}
    }
    else
    	self iprintln("You must be ^2Host^7 to do that");
}
doPAP()
{
	self endon("disconnect");
	level endon("game_ended");
	level endon("end_pap");
    level.NGU=spawn("script_model", self.origin + (0,0,40.5));
    level.NGU.angles=(0,10,0);
    level.NGU setModel("t6_wpn_supply_drop_ally");
    foreach(player in level.players)
    {
    	player.packit=player createFontString("hudbig", 1.8);
    	player.packit setPoint("TOP", "TOP", 0, 20);
    	player.packit setSafeText("^3Press [{+usereload}] for Pack-A-Punch");
    	player.packit.alpha = 0;
    }
    for(;;)
    {
    	foreach(player in level.players)
    	{
        	if(distance(player.origin, level.NGU.origin) <150)
        	{
    			player.packit.alpha = 1;
            	if(player usebuttonpressed())
            	{
               		weap=player getCurrentWeapon();
                	if(player.upw[weap]!=1)
                	{
                    	player takeWeapon(player getCurrentWeapon());
                    	player.packit.alpha = 0;
                    	player freezeControls(true);
                    	if(player.god==0)
                    		player EnableInvulnerability();
                    	player iprintlnbold("^5Packing that shit, hold up...");
                    	wait 4;
                    	player freezeControls(false);
                    	if(player.god==0)
                    		player DisableInvulnerability();
                    	player iprintlnbold("^2Done, Now fuck shit up!");
                    	player.upw[weap]=1;
                    	player initGiveWeap(weap, "", 43, 0);
                    	player thread bo2modz(weap);
                    	player thread clearPAPOnDeath(weap);
                	}
                	else
                	{
                    	player iprintlnbold("^1You have already upgraded this gun!");
                   		wait 1;
                	}
                }
            }
            else
    			player.packit.alpha = 0;
        }
       	wait 0.05;
    }
}
bo2modz(gun)
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	level endon("end_pap");
    for(;;)
    {
        self waittill ("weapon_fired");
        weap=self getCurrentWeapon();
        if(weap==gun)
        {
            forward=self getTagOrigin("j_head");
            end=self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
            SPLOSIONlocation=BulletTrace(forward, end, 0, self)["position"];
            playfx(level._effect["rcbombexplosion"], SPLOSIONlocation);
            RadiusDamage(SPLOSIONlocation, 300, 200, 100, self);
        }
    }
}
clearPAPOnDeath(weap)
{
	self endon("disconnect");
	level endon("game_ended");
	level endon("end_pap");
	for(;;)
	{
		self waittill("death");
		self.upw[weap]=0;
	}
}
hearallplayers()
{
	if(self.hearall==false)
	{
		self iprintln("Hear All Players ^5ON");
		setmatchtalkflag("EveryoneHearsEveryone", 1);
		self.hearall=true;
	}
	else
	{
		self iprintln("Hear All Players ^4OFF");
		setmatchtalkflag("EveryoneHearsEveryone", 0);
		self.hearall=false;
	}
}
meleerange()
{
	if(self.mele==true)
	{
		setDvar("player_meleeRange", "999");
		self.mele=false;
		self iprintln("Long Melee ^5ON");
	}
	else
	{
		setDvar("player_meleeRange", "64");
		self.mele=true;
		self iprintln("Long Melee ^4OFF");
	}
}
IMSMW3()
{
	level endon("game_ended");
    self endon("disconnect");
    iprintln("IMS ^5Spawned");
    o=self;
    offset=(50,0,10);
    ims=spawn("script_model", self.origin + offset);
    ims setModel("t6_wpn_turret_sentry_gun_red");
    ims.angles=(90,0,0);
    s="fhj18_mp";
    for(;;)
    {
        foreach(p in level.players)
        {
            d=distance(ims.origin,p.origin);
            if(level.teambased)
            {
                if((p!=o)&&(p.pers["team"]!=self.pers["team"]))
                if(d<250)
                if(isAlive(p)) p thread imsxpl(ims,o,p,s);
            }
            else
            {
                if(p!=o)
                if(d<250)
                if(isAlive(p)) p thread imsxpl(ims,o,p,s);
            }
            wait 0.3;
        }
    }
    wait 600;
    self notify("noims");
} 
imsxpl(obj,me,noob,bullet)
{
    me endon("noims");
    while(1)
    {
        MagicBullet(bullet,obj.origin,noob.origin,me);
        wait 2;
        break;
    }
}
initTeletoFlag()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("stop_TeletoFlag");
	self endon("destroyMenu");
	if(level.setTele1Ori==3)
	{
		level.setTele1Ori=0;
		self notify("stop_warpzone");
		level.TtF delete();
		level.TtF2 delete();
		self iprintlnbold("Flag Object ^1deleted.");
		self iprintln("Warpzone setting ^5restarted");
		wait 0.5;
	}
	for(;;)
	{
		self.TtF["setOrigin"]=self.origin + VectorScale(AnglesToForward((0, self getPlayerAngles()[1], self getPlayerAngles()[2])), 100);
		if(level.setTele1Ori==0)
		{
			level.setTele1Ori=1;
			self iprintlnbold("Please set ^61st Teleport Start Flag.");
			self iprintln("Press [{+actionslot 3}] to ^6Set.");
			wait 0.5;
		}
		if(level.setTele1Ori==1)
		{
			if(self actionSlotThreeButtonPressed())
			{
				level.setTele1Ori=2;
				level.TtF=spawn("script_model", self.TtF["setOrigin"]);
				level.TtF.angles=(0,10,0);
				level.TtF setModel("mp_flag_green");
				self iprintlnbold("Please set ^62nd Teleport End Flag.");
				self iprintln("Press [{+actionslot 4}] to ^6Set.");
				wait 0.5;
			}
		}
		if(level.setTele1Ori==2)
		{
			if(self actionSlotFourButtonPressed())
			{
				level.setTele1Ori=3;
				level.TtF2=spawn("script_model", self.TtF["setOrigin"]);
				level.TtF2.angles=(0,10,0);
				level.TtF2 setModel("mp_flag_red");
				self iprintlnbold("Origin setting is ^2now complete.");
				self iprintln("Start ^2Warpzone...");
				wait 0.5;
				foreach(player in level.players)
				player thread doTeletoFlag();
				self notify("stop_TeletoFlag");
			}
		}
		wait 0.05;
	}
}
doTeletoFlag()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("stop_warpzone");
	self endon("destroyMenu");
	for(;;)
	{
		if(distance(self.origin, level.TtF.origin) < 95)
		{
			self setorigin(level.TtF2.origin);
			wait 2;
		}

		if(distance(self.origin, level.TtF2.origin) < 95)
		{
			self setorigin(level.TtF.origin);
			wait 2;
		}
		wait 0.05;
	}
}
gravity()
{
	if(self.grav==true)
	{
		setDvar("bg_gravity", "150");
		self.grav=false;
		self iprintln("Gravity ^5ON");
	}
	else
	{
		setDvar("bg_gravity", "800");
		self.grav=true;
		self iprintln("Gravity ^4OFF");
	}
}
human_torch()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("stop_torch");
	self endon("destroyMenu");
	self.htorch=booleanOpposite(self.htorch);
    self iprintln(booleanReturnVal(self.htorch, "Human Torch ^4OFF", "Human Torch ^5ON\n^1Walk near things to destroy them!"));
	if(self.htorch)
	{
		if(self.god==0)
	    	self enableInvulnerability();
	    for(;;)
	    {
	    	PlayFX(level.torch,self.origin+(0,0,60));
	    	RadiusDamage(self.origin,160,160,50,self);
	    	wait 0.1;
	    }
	}
	else
		if(self.god==0)
	    	self DisableInvulnerability();
	    self notify("stop_torch");
}
Matrixx()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon ("stop_matrix");
	self endon("destroyMenu");
	self.matrixgun=booleanOpposite(self.matrixgun);
    self iprintln(booleanReturnVal(self.matrixgun, "Matrix ^4OFF", "Matrix ^5ON\n^1Press [{+speed_throw}] to enable"));
    if(self.matrixgun)
	for(;;)
	{
		if(self AdsButtonPressed())
		{
			self thread pushdowntscale();self setblur(0.7,0.3);
			self useServerVisionSet(true);
		    self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
		}
		else
		{
			self useServerVisionSet(false);
			setDvar("timescale",1);self setblur(0,0.5);
		}
		wait 0.01;
	}
	else
	    self notify("stop_matrix");
}
pushdowntscale()
{
    for(mtb=1; mtb > 0.3; mtb-=0.5)
    {
        setDvar("timescale",mtb);
        wait 0.001;
    }
}
playertbag(player)
{
	level endon("game_ended");
    self endon("disconnect");
	self endon("death");
    self endon("stop_playertbag");
    if(!player isHost())
    {
        player.ptbag=booleanOpposite(player.ptbag);
        self iprintln(booleanReturnVal(player.ptbag, player.name+" T-Bag ^4OFF", player.name+" T-Bag ^5ON"));
        if(player.ptbag)
        {
            for(;;)
	        {
	        	player setStance("crouch");
		        wait .5;
		        player setStance("stand");
		        wait .5;
	        }
	    }
	    else
	        self notify("stop_playertbag");
	}
	else
        self iprintln("You cannot make the " + verificationToColor(player.status) + "^7 T-Bag");
}
ToggleSpin(player)
{
    if(!player isHost())
    {
        if(player.isSpinning==false)
        {
            player thread spinme();
            player iprintln("Spinning ^5ON");
            self iprintln(player.name+ " Spinning ^5ON");
            player.isSpinning=true;
        }
        else
        {
            if(player.isSpinning==true)
            {
                player notify("Stop_Spining");
                player iprintln("Spinning ^4OFF");
                self iprintln(player.name+ " Spinning ^4OFF");
                player.isSpinning=false;
            }
        }
    }
    else
        self iprintln("You cannot spin the " + verificationToColor(player.status));
}
spinme()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("Stop_Spining");
    for(;;)
    {
        self setplayerangles(self.angles+(0,20,0));
        wait 0.01;
        self setplayerangles(self.angles+(0,20,0));
        wait 0.01;
    }
    wait 0.05;
}
doJetPack()
{
	if(self.jetpack==false)
	{
		self thread StartJetPack();
		self iprintln("Jetpack ^5ON");
		self iprintln("Press [{+gostand}] & [{+usereload}]");
		self.jetpack=true;
	}
	else if(self.jetpack==true)
	{
		self.jetpack=false;
		self detach("projectile_hellfire_missile","tag_stowed_back");
		self notify("jetpack_off");
		self iprintln("Jetpack ^4OFF");
	}
}
StartJetPack()
{
    self endon("death");
	self endon("jetpack_off");
	self.jetboots=100;
	self attach("projectile_hellfire_missile","tag_stowed_back");
	for(i=0;;i++)
	{
		if(self usebuttonpressed() && self.jetboots>0)
		{
		    self playsound("veh_huey_chaff_explo_npc");
			if(!(getDvar("mapname")== "mp_hydro" || getDvar("mapname")== "mp_village"))
			{
				playFX("flak20_fire_fx", self getTagOrigin("J_Ankle_RI"));
				playFx("flak20_fire_fx", self getTagOrigin("J_Ankle_LE"));
			}
			earthquake(.15,.2,self gettagorigin("j_spine4"),50);
			self.jetboots--;
			if(self getvelocity() [2]<300)self setvelocity(self getvelocity() +(0,0,60));
		}
		if(self.jetboots<100 &&!self usebuttonpressed())self.jetboots++;
		wait .05;
	}
}
AllToMe()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
			player iprintln(self.name+" has Teleported All to Them");
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player SetOrigin(self.origin);
			}
			else
				player SetOrigin(self.origin);
		}
	}
	self iprintln("All Players ^5Teleported");
}
SuperJumpEnable()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("StopJump");
    for(;;)
    {
        if(self JumpButtonPressed() && !isDefined(self.allowedtopress))
        {
            for(i=0; i < 10; i++)
            {
                self.allowedtopress=true;
                self setVelocity(self getVelocity()+(0, 0, 999));
                wait 0.05;
            }
            self.allowedtopress=undefined;
        }
        wait 0.05;
    }
}
ToggleSuperJump()
{
    if(!isDefined(!level.superjump))
    {
        self iprintln("Super Jump ^5ON");
        level.superjump=true;
        for(i=0; i < level.players.size; i++)
        	level.players[i] thread SuperJumpEnable();
    }
    else
    {
        self iprintln("Super Jump ^4OFF");
        level.superjump=undefined;
        for(x=0; x < level.players.size; x++)
        	level.players[x] notify("StopJump");
    }
}
superSpeed()
{
    level.superSpeed=booleanOpposite(level.superSpeed);
    self iprintln(booleanReturnVal(level.superSpeed, "Super Speed ^4OFF", "Super Speed ^5ON"));
    if(level.superSpeed)
    	setDvar("g_speed", "500");
    else
        setDvar("g_speed", "200");
}
doFlashFeed()
{
    if(self.FlashFeed2==false)
    {
        self thread FlashFeed();
        self.FlashFeed2=true;
        self iprintln("Flash Feed ^5ON");
    }
    else
    {
        self notify("FlashFeed2_end");
        self.FlashFeed2=false;
        self iprintln("Flash Feed ^4OFF");
    }
}
FlashFeed()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("FlashFeed2_end");
    flash=strTok("1 0 0 1,1 0.7 0 1,1 1 0 1,0 1 0 1,0 0 1 1,1 0 1 1,0 1 1 1",",");
    i=0;
    for(;;)
    {
    	if(i==flash.size)
        	i=0;
        setDvar("g_TeamColor_Axis",flash[i]);
        setDvar("g_TeamColor_Allies",flash[i]);
        i++;
        wait .2;
    }
}
changeTimescale()
{
    if(self.tsc==0)
    {
    	setDvar("timescale", "0.5");
        self iprintln("Timescale set to ^5Slow");
        self.tsc=2;
    }
    else if(self.tsc==1)
    {
        setDvar("timescale", "2");
        self iprintln("Timescale set to ^5Fast");
        self.tsc=0;
    }
    else if(self.tsc==2)
    {
        setDvar("timescale", "1");
        self iprintln("Timescale set to ^4Normal");
        self.tsc=1;
    }
}
InfGame()
{
    if(self.infinitegg==0)
    {
		if(getDvar("g_gametype")== "tdm" || getDvar("g_gametype")== "dom" || getDvar("g_gametype")== "dm")
			setgametypesetting("scorelimit",0);
        maps\mp\gametypes\_globallogic_utils::pausetimer();
        self.infinitegg=1;
        self iprintln("Infinite Game ^5ON");
    }
    else
    {
    	if(getDvar("g_gametype")== "tdm")
    		setgametypesetting("scorelimit",75);
		if(getDvar("g_gametype")== "dom")
			setgametypesetting("scorelimit",200);
		if(getDvar("g_gametype")== "dm")
			setgametypesetting("scorelimit",30);
        maps\mp\gametypes\_globallogic_utils::resumetimer();
        self.infinitegg=0;
        self iprintln("Infinite Game ^4OFF");
    }
}
killall()
{
    foreach(player in level.players)
    {
        if(player isHost() && !self isHost())
        	player iprintln(self.name+" has Killed All");
        if(!player isHost())
        {
        	if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
        			player suicide();
        	}
        	else
        		player suicide();
        }
    }
}
kickall()
{
	if(self isHost())
	{
    	foreach(player in level.players)
    	{
        	if(player isHost() && !self isHost())
        		player iprintln(self.name+" has Kicked All");
        	if(!player isHost())
        	{
        		if(getDvar("verPlayersImmune")=="1")
				{
					if(!player isVerified())
        				kick(player getentitynumber());
        		}
        		else
        			kick(player getentitynumber());
        	}
    	}
    }
    else
    	self iprintln("You must be ^2Host^7 to do that");
}
godmodeall()
{
    if(level.godmodeall==false)
    {
        level.godmodeall=true;
        self iprintln("God Mode for all ^5ON");
        foreach(player in level.players)
        {
            if(player isHost() && !self isHost())
            	player iprintln(self.name+" ^5has enabled^7 God Mode All");
            if(!player isHost() && !player isVerified())
            {
               player.god=1;
               player enableInvulnerability();
            }
        }
    }
    else
    {
        level.godmodeall=false;
        self iprintln("God Mode for all ^4OFF");
        foreach(player in level.players)
        {
        	if(player isHost() && !self isHost())
            	player iprintln(self.name+" ^4has disabled^7 God Mode All");
            if(!player isHost() && !player isVerified())
            {
            	player.god=0;
            	player disableInvulnerability();
            }
        }
    }
}
infiniteammoall()
{
	self endon("disconnect");
	level endon("game_ended");
	if(level.ammoall==0)
	{
		level.ammoall=1;
		self iprintln("Infinite Ammo for All ^5ON");
		foreach(player in level.players)
			if(player isHost() && !self isHost())
				player iprintln(self.name+" ^5has enabled^7 Infinite Ammo All");
		while(1)
		{
			if(level.ammoall)
			{
				foreach(player in level.players)
				{
					if(!player isHost())
					{
						if(!player isVerified())
						{
							currentWeapon=player getcurrentweapon();
							if(currentWeapon!="none")
							{
								player setweaponammoclip(currentWeapon,weaponclipsize(currentWeapon));
								player givemaxammo(currentWeapon);
							}
							currentoffhand=player getcurrentoffhand();
							if(currentoffhand!="none")player givemaxammo(currentoffhand);
						}
					}
				}
			}
			else
				break;
			wait 0.05;
		}
	}
	else
	{
		level.ammoall=0;
		self iprintln("Infinite Ammo for All ^4OFF");
		foreach(player in level.players)
			if(player isHost() && !self isHost())
				player iprintln(self.name+" ^4has disabled^7 Infinite Ammo All");
	}
}
BigXP(xp)
{
	self iprintln("XP Set to ^5"+xp);
	registerScoreInfo("kill", xp);
	registerScoreInfo("suicide", xp);
}
doMaster(player)
{
	if(!player isHost())
	{
		self.pers["rank"]=level.maxrank;
		self.pers["prestige"]=level.maxprestige;
		player setrank(level.maxrank, level.maxprestige);
		player iprintln("^2You are now ^1Master Prestige!");
		self iprintln("Fake Master Prestige ^5Set!");
	}
	else
		self iprintln("You cannot make the ^2Host^7 fake master");
}
allmaster()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
			player iprintln(self.name+" ^5set^7 Fake Master All");
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
				{
					self.pers["rank"]=level.maxrank;
					self.pers["prestige"]=level.maxprestige;
					player setrank(level.maxrank, level.maxprestige);
					player iprintln("^2You are now ^1Master Prestige!");
				}
			}
			else
			{
				self.pers["rank"]=level.maxrank;
				self.pers["prestige"]=level.maxprestige;
				player setrank(level.maxrank, level.maxprestige);
				player iprintln("^2You are now ^1Master Prestige!");
			}
		}
	}
	self iprintln("Fake Master Prestige All ^5Set!");
}
traceBullet(distance)
{
	if(!isDefined(distance))
		distance=10000000;
	return bulletTrace(self getEye(), self getEye() + vectorScale(AnglesToForward(self getPlayerAngles()), distance), false, self)["position"];
}
saveAndLoad()
{
    if(self.snl==0)
    {
        self iprintln("Save & Load ^5ON\nPress [{+Actionslot 3}] while crouching to ^5save\nPress [{+actionslot 4}] while crouching to ^4load");
        self thread dosaveandload();
        self.snl=1;
    }
    else
    {
        self iprintln("Save & Load ^4OFF");
        self.snl=0;
        self notify("stop_snl");
    }
}
dosaveandload()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("stop_snl");
    self endon("destroyMenu");
    load=0;
    for(;;)
    {
        if(self actionslotthreebuttonpressed() && self.snl==1 && self getstance()=="crouch")
        {
            o=self.origin;
            a=self.angles;
            load=1;
            self iprintln("Position ^5Saved!");
            wait 0.01;
        }
        if(self actionslotfourbuttonpressed() && load==1 && self.snl==1 && self getstance()=="crouch")
        {
            self setplayerangles(a);
            self setorigin(o);
            self iprintln("Position ^4Loaded!");
            wait 0.01;
        }
        wait 0.01;
    }
}
initBackflip()
{
	if(!self.backflipMod)
	{
		self.backflipMod = true;
		self thread doBackflip();
		self iprintln("Backflip Mod ^5ON\n^1[{+actionslot 3}] while standing to flip");
	}
	else
	{
		self.backflipMod = false;
		self notify("endFlip");
		self iprintln("Backflip Mod ^4OFF");
	}
}
doBackflip()
{	
	self endon("endFlip");
	self endon("disconnect");
	self endon("death");
	self endon("destroyMenu");
	level endon("game_ended");
	Flipping = false;
	for(;;)
	{
		if(self actionslotthreebuttonpressed() && self getStance() == "stand" && Flipping == false)
		{
			Flipping = true;
			flip = modelSpawner(self.origin, "tag_origin", self.angles);
			self linkto(flip);
			flip RotatePitch(2 * -180, 1.5);
			wait 1.6;
			self unlink();
			flip delete();
			Flipping = false;
		}
		wait .05;
	}
}
SpiralStairs()
{
    level endon("game_ended");
    self endon("death");
    self endon("stop_stairz");
    self endon("destroyMenu");
    if(self isHost())
	{
    	self thread stopspiralstairs();
    	self.StairSize=99;
		self iprintln("Spiral Stairs are ^5being built...\n^1Press [{+actionslot 1}] to stop build");
    	for(;;)
    	{
        	vec=anglestoforward(self getPlayerAngles());
        	center=BulletTrace(self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+(vec[0] * 200000, vec[1] * 200000, vec[2] * 200000), 0, self)["position"];
        	level.center=spawn("script_origin", center);
        	level.stairs=[];
        	origin=level.center.origin+(70,0,0);
        	h=0;
        	for(i=0;i<self.StairSize;i--)
        	{
            	level.center rotateyaw(22.5, 0.05);
            	wait 0.07;
            	level.center moveto(level.center.origin+(0,0,18), 0.05);
            	wait 0.02;
            	level.stairs[i]=spawn("script_model", origin);
            	level.stairs[i] setmodel("t6_wpn_supply_drop_ally");
            	level.stairs[i] linkto(level.center);
        	}
        	level.center moveto(level.center.origin-(0,0,10), 0.05);
    	}
    }
	else
		self iprintln("You must be ^2Host^7 to do that");
}
stopspiralstairs()
{
    self endon("stop_stairz");
    level endon("game_ended");
    self endon("death");
    self endon("destroyMenu");
    for(;;)
    {
        if(self actionslotonebuttonpressed())
        {
            self iprintln("Spiral Stairs ^4stopped!");
            self notify("stop_stairz");
        }
        wait 0.01;
    }
}
Platform()
{
	location=self.origin;
 	while(isDefined(self.spawnedcrate[0][0]))
    {
        i=-3;
        while (i < 3)
        {
            d=-3;
            while (d < 3)
            {
                self.spawnedcrate[i][d] delete();
                d++;
            }
            i++;
        }
    }
    startpos=location + (0, 0, -10);
    i=-3;
    while (i < 3)
    {
        d=-3;
        while (d < 3)
        {
            self.spawnedcrate[i][d]=spawn("script_model", startpos + (d * 40, i * 70, 0));
            self.spawnedcrate[i][d] setmodel("t6_wpn_supply_drop_ally");
            d++;
        }
        i++;
    }
    self iprintln("Platform ^5Spawned");
    wait 1;
}
PlantBomb()
{
    if(getDvar("g_gametype")=="sd")
    {
        if(!level.bombplanted)
        {
            level thread maps/mp/gametypes/sd::bombplanted(level.bombzones[0], self);
            level thread maps/mp/_popups::displayteammessagetoall(&"MP_EXPLOSIVES_PLANTED_BY", self);
            self iprintln("Bomb ^5Planted!");
        }
        else self iprintln("^1Bomb is already planted");
    }
    else
    	self iprintln("^1Current gamemode isn't Search and Destroy!");
}
DefuseBomb()
{
    if(getDvar("g_gametype")=="sd")
    {
        if(level.bombplanted)
        {
            level thread maps/mp/gametypes/sd::bombdefused();
            level thread maps/mp/_popups::displayteammessagetoall(&"MP_EXPLOSIVES_DEFUSED_BY", self);
            self iprintln("Bomb ^4Defused!");
        }
        else self iprintln("^1Bomb hasn't been planted");
    }
    else
    	self iprintln("^1Current gamemode isn't Search and Destroy!");
}
RollAwayDog()
{
	if(self isHost())
	{
		level endon("game_ended");
		self endon("disconnect");
		self endon("endrollaway");
		self thread stoprollaway();
		self iprintlnbold("^5Shoot ^7to make the dog roll away!");
    	dog=spawn("script_model", self.origin + (30, 0, 45), 1);
    	dog setModel("german_shepherd");
    	self waittill("weapon_fired");
    	for(;;)
    	{
        	dog moveTo(dog.origin + (300, 0, 0), 1);
        	dog rotatepitch(360, 1);
        	wait .1;
    	}
    }
    else
    	self iprintln("You must be ^2Host^7 to do that");
}
stoprollaway()
{
    wait 20;
    self notify("endrollaway");
    self iprintln("^1Dog stopped to stop lag");
}
PauseGame()
{
	self thread maps\mp\gametypes\_hostmigration::callback_hostmigration();
	foreach(player in level.players)
		player iprintln("^1Game Paused");
}
arrowMan()
{
	self.arrowMan=booleanOpposite(self.arrowMan);
	self iprintln(booleanReturnVal(self.arrowMan,"Arrow Man ^4OFF","Arrow Man ^5ON"));
	if(self.arrowMan)
	{
		self attach("fx_axis_createfx","j_ball_le");
		self attach("fx_axis_createfx","j_ball_ri");
		self attach("fx_axis_createfx","j_head");
		self attach("fx_axis_createfx","j_Elbow_ri");
		self attach("fx_axis_createfx","j_Elbow_le");
		self attach("fx_axis_createfx","j_Ankle_ri");
		self attach("fx_axis_createfx","j_Ankle_le");
		self attach("fx_axis_createfx","j_spinelower");
		self attach("fx_axis_createfx","j_spineupper");
		self attach("fx_axis_createfx","j_spine4");
		self attach("fx_axis_createfx","back_low");
		if(self.TPP==0)
			self setclientthirdperson(1);
	}
	else
	{
		self detach("fx_axis_createfx","j_ball_le");
		self detach("fx_axis_createfx","j_ball_ri");
		self detach("fx_axis_createfx","j_head");
		self detach("fx_axis_createfx","j_Elbow_ri");
		self detach("fx_axis_createfx","j_Elbow_le");
		self detach("fx_axis_createfx","j_Ankle_ri");
		self detach("fx_axis_createfx","j_Ankle_le");
		self detach("fx_axis_createfx","j_spinelower");
		self detach("fx_axis_createfx","j_spineupper");
		self detach("fx_axis_createfx","j_spine4");
		self detach("fx_axis_createfx","back_low");
		if(self.TPP==0)
			self setclientthirdperson(0);
	}
}
bouncygrenades()
{
	level.bouncygrenades=booleanOpposite(level.bouncygrenades);
	self iprintln(booleanReturnVal(level.bouncygrenades,"Bouncy Grenades ^4OFF","Bouncy Grenades ^5ON"));
	if(level.bouncygrenades)
	{
		setDvar("grenadeBounceRestitutionMax",5);
		setDvar("toggle grenadeBumpFreq",9);
		setDvar("toggle grenadeBumpMag",0);
		setDvar("toggle grenadeBumpMax",20);
		setDvar("grenadeCurveMax",0);
		setDvar("grenadeFrictionHigh",0);
		setDvar("grenadeFrictionLow",0);
		setDvar("grenadeFrictionMaxThresh",0);
		setDvar("grenadeRestThreshold",0);
		setDvar("grenadeRollingEnabled",1);
		setDvar("grenadeWobbleFreq",999);
		setDvar("grenadeWobbleFwdMag",999);
	}
	else
	{
		setDvar("grenadeBounceRestitutionMax",.3);
		setDvar("toggle grenadeBumpFreq",.3);
		setDvar("toggle grenadeBumpMag",.4);
		setDvar("toggle grenadeBumpMax",100);
		setDvar("grenadeCurveMax",4);
		setDvar("grenadeFrictionHigh",.4);
		setDvar("grenadeFrictionLow",.01);
		setDvar("grenadeFrictionMaxThresh",100);
		setDvar("grenadeRestThreshold",20);
		setDvar("grenadeWobbleFreq",.08);
		setDvar("grenadeWobbleFwdMag",10);
	}
}
Lodestartoggle()
{
	self.Lodestar=booleanOpposite(self.Lodestar);
	self iprintln(booleanReturnVal(self.Lodestar,"Walking Lodestar ^4OFF","Walking Lodestar ^5ON"));
	if(self.Lodestar)
	{
		self thread closemenu();
		wait .3;
		self thread WalkingLodestar();
		self thread WalkingLodestar();
	}
	else
	{
		self notify("Lodestarend");
		self enableweapons();
	}
}
WalkingLodestar()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	self endon("Lodestarend");
	self endon("destroyMenu");
	self notify("GiveNewWeapon");
	self disableweapons();
	level.remote_mortar_fx["missileExplode"] LinkTo(weapon);
	for(;;)
	{
		if(self.menu.open == false)
		if(self attackbuttonpressed())
		{
			MagicBullet("remote_mortar_missile_mp",self getEye(),self traceBullet(),self);
			self waittill("missile_fire",weapon,weapname);
			if(weapname=="remote_mortar_missile_mp")
				self thread lodestardeath(weapon);
			wait 0.8;
		}
		wait 0.05;
	}
}
lodestardeath(weapon)
{
	weapon waittill("death");
	playfx(level.remote_mortar_fx["missileExplode"], weapon.origin);
	RadiusDamage(weapon.origin,400,400,300,self,"MOD_EXPLOSIVE");
	earthquake(0.9,0.9,weapon.origin,999);
	self PlayRumbleOnEntity("sniper_fire");
}
hunter()
{
    self endon("death");
    self.hunted=booleanOpposite(self.hunted);
    self iprintln(booleanReturnVal(self.hunted,"Hunter ^4OFF","Hunter ^5ON"));
    if(self.hunted)
    {
    	if(self.speedScaleX2==false)
        	self setmovespeedscale(2);
        if(self.visions!=3)
			self setinfraredvision(1);
		if(self.invisible==0)
        	self hide();
        self giveWeapon("crossbow_mp+stackfire+vzoom");
        self switchToWeapon("crossbow_mp+stackfire+vzoom");
    }
    else
    {
        if(self.speedScaleX2==false)
        	self setmovespeedscale(1);
        if(self.visions!=3)
			self setinfraredvision(0);
        if(self.invisible==0)
        	self Show();
        self TakeWeapon("crossbow_mp+stackfire+vzoom");
    }
}
initBallthing()
{
    self.blueballs=booleanOpposite(self.blueballs);
    self iprintln(booleanReturnVal(self.blueballs,"Forcefield ^4OFF","Forcefield ^5ON"));
    if(self.ff==false||self.blueballs)
    {
        self thread ballThing();
        self.ff=true;
    }
    else if(self.ff==true)
    {
        self.ff=false;
        self notify("forceend");
        self detachall();
    }
}
ballThing()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("death");
    self endon("forceend");
    self endon("destroyMenu");
    ball=spawn("script_model",self.origin +(0,0,20));
    ball.angles=(0,115,0);
    self thread monBall(ball);
    self thread monPlyr();
    self thread DOD(ball);
    for(;;)
    {
        ball rotateyaw(-360,2);
        wait 1;
    }
}
monBall(obj)
{
	self endon("disconnect");
	level endon("game_ended");
    self endon("death");
    self endon("forceend");
    self endon("destroyMenu");
    while(1)
    {
        obj.origin=self.origin +(0,0,120);
        wait 0.05;
    }
}
monPlyr()
{
	self endon("disconnect");
	level endon("game_ended");
    self endon("death");
    self endon("forceend");
    self endon("destroyMenu");
    while(1)
    {
        foreach(p in level.players)
        {
            if(distance(self.origin,p.origin)<=200)
            {
                AtF=AnglesToForward(self getPlayerAngles());
                if(p!=self)
                p setVelocity(p getVelocity()+(AtF[0]*(300*(2)),AtF[1]*(300*(2)),(AtF[2]+0.25)*(300*(2))));
            }
        }
        wait 0.05;
    }
}
DOD(ent)
{
    self waittill("death");
    self waittill("forceend");
    ent delete();
}
initLightMan()
{
	self.lightman=booleanOpposite(self.lightman);
	self iprintln(booleanReturnVal(self.lightman,"Light Man ^4OFF","Light Man ^5ON"));
	if(self.lightman)
		self thread doLightMan();
	else
		self notify("stop_LightMan");
}
doLightMan()
{
	self endon("disconnect");
	self endon("stop_LightMan");
	for(;;)
	{
		playFx(level.GreenLight, self getTagOrigin("j_head"));
		playFx(level.RedLight, self getTagOrigin("j_spineupper"));
		playFx(level.GreenLight, self getTagOrigin("j_spinelower"));
		playFx(level.RedLight, self getTagOrigin("j_spine4"));
		playFx(level.GreenLight, self getTagOrigin("j_spine1"));
		playFx(level.RedLight, self getTagOrigin("J_Elbow_RI"));
		playFx(level.GreenLight, self getTagOrigin("J_Elbow_LE"));
		playFx(level.RedLight, self getTagOrigin("j_knee_le"));
		playFx(level.GreenLight, self getTagOrigin("j_knee_ri"));
		playFx(level.RedLight, self getTagOrigin("J_Ankle_LE"));
		playFx(level.GreenLight, self getTagOrigin("J_Ankle_RI"));
		playFx(level.RedLight, self getTagOrigin(" J_Wrist_RI"));
		playFx(level.GreenLight, self getTagOrigin(" J_Wrist_LE"));
		playFx(level.GreenLight, self getTagOrigin("j_head"));
		playFx(level.RedLight, self getTagOrigin("j_spineupper"));
		playFx(level.GreenLight, self getTagOrigin("j_spinelower"));
		playFx(level.RedLight, self getTagOrigin("j_spine4"));
		playFx(level.GreenLight, self getTagOrigin("j_spine1"));
		playFx(level.RedLight, self getTagOrigin("J_Elbow_RI"));
		playFx(level.GreenLight, self getTagOrigin("J_Elbow_LE"));
		playFx(level.RedLight, self getTagOrigin("j_knee_le"));
		playFx(level.GreenLight, self getTagOrigin("j_knee_ri"));
		playFx(level.RedLight, self getTagOrigin("J_Ankle_LE"));
		playFx(level.GreenLight, self getTagOrigin("J_Ankle_RI"));
		playFx(level.RedLight, self getTagOrigin(" J_Wrist_RI"));
		playFx(level.GreenLight, self getTagOrigin(" J_Wrist_LE"));
		wait .45;
	}
}
initJericho()
{
    missilesReady=0;
    numberOfMissiles=10;
    self iprintln("^2Fire to select nodes");
    while(missilesReady!=numberOfMissiles)
    {
        self waittill("weapon_fired");
        target=traceBullet();
        mFx=spawnFx(level.waypointGreen,target,(0,0,1),(1,0,0));
        triggerFx(mFx);
        self thread spawnJerichoMissile(target,mFx);
        missilesReady++;
    }
    self iprintln("^1All missile paths initialized, fire your weapon to launch");
    self waittill("weapon_fired");
    self notify("launchMissiles");
}
spawnJerichoMissile(target,mFx)
{
    self waittill("launchMissiles");
    mFx delete();
    mFx=spawnFx(level.waypointRed,target,(0,0,1),(1,0,0));
    triggerFx(mFx);
    location=target+(0,3500,5000);
    missile=spawn("script_model",location);
    missile setModel("projectile_sidewinder_missile");
    missile.angles=missile.angles+(90,90,90);
    missile.killcament=missile;
    missile rotateto(VectorToAngles(target - missile.origin),0.01);
    wait 0.01;
    time=3;
    endLocation=BulletTrace(missile.origin,target,false,self)["position"];
    missile moveto(endLocation,time);
    wait time;
    self playsound("wpn_rocket_explode");
    playFx(level.remote_mortar_fx["missileExplode"],missile.origin+(0,0,1));
    RadiusDamage(missile.origin,450,700,350,self,"MOD_PROJECTILE_SPLASH","remote_missile_bomblet_mp");
    missile delete();
    mFx delete();
}
SpinningCrate()
{
    self endon("disconnect");
    level endon("game_ended");
    SpinCrate=spawn("script_model",self.origin +(60,0,25));
    SpinCrate setModel("t6_wpn_supply_drop_ally");
    SpinCrate setContents(1);
    self iprintln("Spinning Crate ^5Spawned");
    for(;;)
    {
        SpinCrate rotateyaw(-360,1);
        wait 1;
    }
}
FlippingCrate()
{
    self endon("disconnect");
    level endon("game_ended");
    SpinCrate2=spawn("script_model",self.origin +(60,0,25));
    SpinCrate2 setModel("t6_wpn_supply_drop_ally");
    SpinCrate2 setContents(1);
    self iprintln("Flipping Crate ^5Spawned");
    for(;;)
    {
        SpinCrate2 rotateroll(-360,1);
        wait 1;
    }
}
RollingCrate()
{
    self endon("disconnect");
    level endon("game_ended");
    SpinCrate3=spawn("script_model",self.origin +(60,0,25));
    SpinCrate3 setModel("t6_wpn_supply_drop_ally");
    SpinCrate3 setContents(1);
    self iprintln("Rolling Crate ^5Spawned");
    for(;;)
    {
        SpinCrate3 rotatepitch(-360,1);
        wait 1;
    }
}
WindMill()
{
    self endon("disconnect");
    self iprintln("Windmill ^5Spawned");
    spawnPosition=self.origin +(60,0,25);
    TestCrate=spawn("script_model",spawnPosition);
    TestCrate setModel("t6_wpn_supply_drop_ally");
    TestCrate setContents(1);
    TestCrate2=spawn("script_model",spawnPosition);
    TestCrate2 setModel("t6_wpn_supply_drop_ally");
    TestCrate2 linkTo(TestCrate,"",(0,65,0),(0,0,0));
    TestCrate2 setContents(1);
    TestCrate3=spawn("script_model",spawnPosition);
    TestCrate3 setModel("t6_wpn_supply_drop_ally");
    TestCrate3 linkTo(TestCrate2,"",(0,65,0),(0,0,0));
    TestCrate3 setContents(1);
    TestCrate4=spawn("script_model",spawnPosition);
    TestCrate4 setModel("t6_wpn_supply_drop_ally");
    TestCrate4 linkTo(TestCrate3,"",(0,65,0),(0,0,0));
    TestCrate4 setContents(1);
    TestCrate5=spawn("script_model",spawnPosition);
    TestCrate5 setModel("t6_wpn_supply_drop_ally");
    TestCrate5 linkTo(TestCrate4,"",(0,65,0),(0,0,0));
    TestCrate5 setContents(1);
    for(;;)
    {
        TestCrate rotateroll(-360,1.5);
        wait 1;
    }
}
initFastDelete()
{
    if(self.FastDelete==0)
    {
        self.FastDelete=1;
        self thread doFastDelete();
        self iprintln("Fast Delete ^5ON\n^1Hold [{+speed_throw}] at objects to delete them");
    }
    else
    {
        self.FastDelete=0;
        self notify("stop_FastDelete");
        self iprintln("Fast Delete ^4OFF");
    }
}
doFastDelete()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("death");
    self endon("stop_FastDelete");
    self endon("destroyMenu");
    for(;;)
    {
        if(self.surge["menu"]["active"]==false)
        if(self adsButtonPressed())
            self NormalisedTrace("entity") delete();
        wait 0.05;
    }
}
BunkerThread()
{
    if(level.SneakerbunkerIsSpawned==false)
    {
        level.SneakerbunkerIsSpawned=true;
        self iprintln("Bunker ^5Spawned");
        WP("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,25,30,50,30,75,30,100,30,125,30,150,30,175,30,200,30,225,30,250,30,275,30,0,60,25,60,50,60,75,60,100,60,125,60,150,60,175,60,200,60,225,60,250,60,275,60,0,90,25,90,50,90,75,90,100,90,125,90,150,90,175,90,200,90,225,90,250,90,275,90,0,120,25,120,50,120,75,120,100,120,125,120,150,120,175,120,200,120,225,120,250,120,275,120,0,150,25,150,50,150,75,150,100,150,125,150,150,150,175,150,200,150,225,150,250,150,275,150,0,180,25,180,50,180,75,180,100,180,125,180,150,180,175,180,200,180,225,180,250,180,275,180,0,210,25,210,50,210,75,210,100,210,125,210,150,210,175,210,200,210,225,210,250,210,275,210,0,240,25,240,50,240,75,240,100,240,125,240,150,240,175,240,200,240,225,240,250,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270",-3,0);WP("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,200,270,225,270,250,270,275,270",20,0);WP("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,200,270,225,270,250,270,275,270",53,0);WP("0,0,25,0,50,0,75,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270",87,0);WP("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270",117,0);WP("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,25,30,50,30,75,30,100,30,125,30,150,30,175,30,200,30,225,30,250,30,275,30,0,60,25,60,50,60,75,60,100,60,125,60,150,60,175,60,200,60,225,60,250,60,275,60,0,90,25,90,50,90,75,90,100,90,125,90,150,90,175,90,200,90,225,90,250,90,275,90,0,120,25,120,50,120,75,120,100,120,125,120,150,120,175,120,200,120,225,120,250,120,275,120,0,150,25,150,50,150,75,150,100,150,125,150,150,150,175,150,200,150,225,150,250,150,275,150,0,180,25,180,50,180,75,180,100,180,125,180,150,180,175,180,200,180,225,180,250,180,275,180,0,210,25,210,50,210,75,210,100,210,125,210,150,210,175,210,200,210,225,210,250,210,275,210,0,240,25,240,50,240,75,240,100,240,125,240,150,240,175,240,200,240,225,240,250,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270",144,0);
    }
    else
        self iprintln("^1Bunker has already been spawned");
}
skyplaza()
{
    self endon("disconnect");
    level endon("game_ended");
    if(level.sky==true)
    {
        WP("0,0,55,0,110,0,0,30,110,30,55,60,0,90,110,90,55,120,0,150,110,150,55,180,0,210,110,210,55,240,0,270,110,270,55,300,0,330,110,330,55,360,0,390,110,390,55,420,0,450,110,450,55,480,0,510,110,510,55,540,0,570,110,570,55,600,0,630,110,630,55,660,0,690,110,690,55,720,1155,720,1210,720,1265,720,1320,720,1375,720,0,750,110,750,1155,750,1210,750,1265,750,1320,750,1375,750,55,780,1100,780,1155,780,1210,780,1265,780,1320,780,1375,780,0,810,110,810,1100,810,1155,810,1210,810,1265,810,1320,810,1375,810,55,840,1100,840,1155,840,1210,840,1265,840,1320,840,1375,840,0,870,110,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,55,900,0,930,110,930,55,960,0,990,110,990,55,1020,0,1050,110,1050,55,1080,0,1110,110,1110,55,1140,0,1170,110,1170,165,1170,55,1200,165,1200,0,1230,110,1230,55,1260,0,1290,110,1290,55,1320,0,1350,110,1350,55,1380,0,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470",800,1);
        WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,1050,110,1080,0,1470,55,1470,110,1470",825,1);
        WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,900,110,930,0,1470,55,1470,110,1470",850,1);
        WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,110,780,1100,780,1155,780,1375,780,110,810,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",875,1);
        WP("0,0,55,0,110,0,110,690,110,720,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",900,1);
        WP("0,0,55,0,110,0,110,600,110,630,110,660,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",925,1);
        WP("0,0,55,0,110,0,0,30,55,30,110,30,165,30,220,30,0,60,55,60,110,60,220,60,275,60,330,60,0,90,55,90,110,90,330,90,55,120,330,120,55,150,330,150,55,180,330,180,55,210,330,210,330,240,385,240,440,240,495,240,550,240,550,270,605,270,330,300,605,300,605,330,605,360,330,390,605,390,605,420,660,420,715,420,770,420,770,450,825,450,880,450,935,450,330,480,935,480,880,510,935,510,880,540,935,540,990,540,1045,540,1100,540,1155,540,165,570,220,570,275,570,330,570,495,570,1155,570,1210,570,330,600,495,600,1210,600,330,630,495,630,1210,630,165,660,220,660,275,660,330,660,385,660,440,660,495,660,1210,660,165,690,330,690,1210,690,165,720,330,720,1100,720,1155,720,1210,720,1265,720,1320,720,1375,720,165,750,330,750,385,750,440,750,495,750,1100,750,1155,750,1375,750,935,780,990,780,1045,780,1100,780,1155,780,1375,780,935,810,1100,810,1375,810,935,840,1100,840,1375,840,935,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,935,900,935,930,825,960,880,960,935,960,825,990,825,1020,825,1050,825,1080,825,1110,770,1140,825,1140,770,1170,770,1200,770,1230,770,1260,770,1290,770,1320,55,1350,110,1350,165,1350,220,1350,275,1350,330,1350,385,1350,440,1350,495,1350,550,1350,605,1350,660,1350,715,1350,770,1350,55,1380,0,1410,55,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470",950,1);
        self iprintln("Sky Plaza ^5Spawned!");
        level.sky=false;
    }
    else
        self iprintln("^1You already spawned the skyplaza!");
}
WP(D,Z,P)
{
    L=strTok(D,",");
    for(i=0 ;i < L.size;i +=2)
    {
        B=spawn("script_model",self.origin+(int(L[i]),int(L[i+1]),Z));
        if(!P)B.angles=(90,0,0);
        B setModel("t6_wpn_supply_drop_ally");
    }
}
sendalltospace()
{
    self iprintln("^5Everyone has been sent off to a galaxy far far away");
	foreach(player in level.players)
	{
	    if(player isHost() && !self isHost())
			player iprintln(self.name+" ^5has^7 Sent All to Space");
		if(!player isHost())
		{
			x=randomIntRange(-75,75);
	        y=randomIntRange(-75,75);
			player.location=(0+x,0+y,500000);
	        player.angle=(0,176,0);
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
				{
	        		player iprintln("^2Lost ^3In ^2Space");
	        		player setOrigin(player.location);
	        		player setPlayerAngles(player.angle);
	        	}
	        }
	        else
	        {
	        	player iprintln("^2Lost ^3In ^2Space");
	        	player setOrigin(player.location);
	        	player setPlayerAngles(player.angle);
	        }
	    }
	}
}
rankall()
{
	if(!level.spank)
	{
		foreach(player in level.players)
		{
			if(player isHost() && !self isHost())
				player iprintln(self.name+" ^5has given^7 60k XP All");
			if(!player isHost())
			{
				if(getDvar("verPlayersImmune")=="1")
				{
					if(!player isVerified())
					{
						player iprintlnbold("60k XP ^5Given");
						player rankup(0);
					}
				}
				else
				{
					player iprintlnbold("60k XP ^5Given");
					player rankup(0);
				}
			}
		}
		self iprintlnbold("60k XP ^5Given");
		level.spank=1;
	}
	else
		self iprintln("Everyone has already been given XP!");
}
rankup(print)
{
	if(!self.ranked && !level.spank)
	{
		self playsoundtoplayer("mus_lau_rank_up",self);
		self addrankxpvalue("contract", 60000);
		if(print)
			self iprintlnbold("60k XP ^5Given");
		self.ranked=1;
	}
	else if(print)
		self iprintln("You've already been given XP!");
}
rankupplayer(player)
{
	if(!player isHost())
	{
		if(!player.ranked)
		{
			self iprintln("You gave ^5"+player.name+"^7 60k XP!");
			player rankup(0);
		}
		else
			self iprintln(player.name + " has already been given XP!");
	}
	else
		self iprintln("You cannot rank up the ^2Host");
}
allderank()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
			player iprintln(self.name+" ^5has set^7 Derank All");
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
				{
					player setRank(0,0);
					player iprintlnbold("You got ^4Deranked!");
				}
			}
			else
			{
				player setRank(0,0);
				player iprintlnbold("You got ^4Deranked!");
			}
		}
	}
	self iprintln("All Players ^4Fake Deranked!");
}
playerDerank(player)
{
	if(!player isHost())
	{
		player setRank(0,0);
		player iprintlnbold("You got ^4Deranked!");
		self iprintln("You deranked ^5"+player.name);
	}
	else
		self iprintln("You cannot derank the ^2Host");
}
banPlayer(player)
{
	if(self isHost())
	{
		if(!player isHost())
		{
			ban(player getentitynumber());
			wait .5;
			self submenu("PlayersMenu", "PlayersMenu");
		}
		else
			self iprintln("You cannot ban the ^2Host");
	}
	else
		self iprintln("You must be ^2Host^7 to do that");
}
blindPlayer(player)
{
	if(!player isHost())
	{
		if(player.blinded==0)
		{
			player.blinded=1;
			self iprintln(player.name+"^5 blinded");
			player.blackscreen=newclienthudelem(player);
       		player.blackscreen.x=0;
        	player.blackscreen.y=0; 
        	player.blackscreen.horzAlign="fullscreen";
        	player.blackscreen.vertAlign="fullscreen";
        	player.blackscreen.sort=50; 
        	player.blackscreen SetShader("black", 640, 480); 
        	player.blackscreen.alpha=1;
        }
        else
        {
        	player.blinded=0;
			self iprintln(player.name+"^4 unblinded");
        	player.blackscreen destroy();
        }
    }
    else
    	self iprintln("You cannot blind the ^2Host");
}
blindall()
{
    if(level.isBlind==0)
    {
        foreach (player in level.players)
        {
            if(player isHost() && !self isHost())
				player iprintln(self.name+" ^5has enabled^7 Blind All");
			if(!player isHost() && player.blinded==0)
			{
				if(getDvar("verPlayersImmune")=="1")
				{
					if(!player isVerified())
					{
                		player.blackscreen=newclienthudelem(player);
                		player.blackscreen.x=0;
                		player.blackscreen.y=0; 
                		player.blackscreen.horzAlign="fullscreen";
                		player.blackscreen.vertAlign="fullscreen";
                		player.blackscreen.sort=50; 
                		player.blackscreen SetShader("black", 640, 480); 
                		player.blackscreen.alpha=1;
                	}
                }
                else
                {
                	player.blackscreen=newclienthudelem(player);
                	player.blackscreen.x=0;
                	player.blackscreen.y=0; 
                	player.blackscreen.horzAlign="fullscreen";
                	player.blackscreen.vertAlign="fullscreen";
                	player.blackscreen.sort=50; 
                	player.blackscreen SetShader("black", 640, 480); 
                	player.blackscreen.alpha=1;
                }
                player.blinded=1;
            }
        }
        level.isBlind=1;
        self iprintln("All Players ^5Blinded!\n^1Click again to remove it");
    }
    else
    {
        foreach (player in level.players)
        {
        	if(player isHost() && !self isHost())
        		player iprintln(self.name+" ^4has disabled^7 Blind All");
        	if(!player isHost())
        	{
            	player.blackscreen destroy();
            	player.blinded=0;
            }
        }
        level.isBlind=0;
        self iprintln("^4Unblinded ^7everyone!");
    }
}
unlockAllThrophiesAllPlayers()
{
    self iprintln("^5Unlocking all trophies for all...");
    if(self isHost())
    {
        foreach(player in level.players)
        {
            if(player isHost() && !self isHost())
				player iprintln(self.name+" ^5has set^7 Unlock Trophies All");
			if(!player isHost())
			{
				if(getDvar("verPlayersImmune")=="1")
				{
					if(!player isVerified())
					{
                		player thread maps\mp\gametypes\_hud_message::hintMessage("^1All Trophys Unlocking Now...\n^3Please wait... this takes some time ^5;)", 10);
                		cheevoList=strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_****STAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_****STAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST,ZM_PRISON_PERK_CHERRY,ZM_DLC4_MASTER_OF_DISGUISE,ZM_DLC4_SAVING_THE_DAY_ALL_DAY,ZM_DLC4_IM_ON_A_TANK,ZM_DLC4_KUNG_FU_GRIP,ZM_DLC4_NOT_A_GOLD_DIGGER,ZM_DLC4_OVERACHIEVER,ZM_DLC4_PLAYING_WITH_POWER,ZM_DLC4_ALL_YOUR_BASE,ZM_DLC4_TOMB_SIDEQUEST,ZM_DLC4_MASTER_WIZARD", ",");
                		foreach(cheevo in cheevoList)
                    		player giveachievement(cheevo);
                	}
                }
                else
                {
                	player thread maps\mp\gametypes\_hud_message::hintMessage("^1All Trophys Unlocking Now...\n^3Please wait... this takes some time ^5;)", 10);
                	cheevoList=strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_****STAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_****STAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST,ZM_PRISON_PERK_CHERRY,ZM_DLC4_MASTER_OF_DISGUISE,ZM_DLC4_SAVING_THE_DAY_ALL_DAY,ZM_DLC4_IM_ON_A_TANK,ZM_DLC4_KUNG_FU_GRIP,ZM_DLC4_NOT_A_GOLD_DIGGER,ZM_DLC4_OVERACHIEVER,ZM_DLC4_PLAYING_WITH_POWER,ZM_DLC4_ALL_YOUR_BASE,ZM_DLC4_TOMB_SIDEQUEST,ZM_DLC4_MASTER_WIZARD", ",");
                	foreach(cheevo in cheevoList)
                    	player giveachievement(cheevo);
                }
            }
        }
    }
}
AutoDropshot()
{
	if(self.Drop==true)
	{
		self thread DropTheBase();
		self iprintln("Auto Drop Shot ^5ON");
		self.Drop=false;
	}
	else
	{
		self notify("stop_drop");
		self iprintln("Auto Drop Shot ^4OFF");
		self.Drop=true;
	}
}
DropTheBase()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("stop_drop");
	self endon("destroyMenu");
	for(;;)
	{
		self waittill("weapon_fired");
		self setStance("prone");
	}
}
Centipede()
{
    self.centp=booleanOpposite(self.centp);
	self iprintln(booleanReturnVal(self.centp, "Centipede ^4OFF", "Centipede ^5ON"));
	if(self.centp)
	{
		level endon("game_ended");
		self endon("stop_centipede");
		self endon("disconnect");
		self endon("death");
		self endon("destroyMenu");
		for(;;)
		{
			ent=self ClonePlayer(9999999);
			wait .1;
			ent thread destroyModelOnTime(2);
		}
	}
	else
	    self notify("stop_centipede");
}
destroyModelOnTime(time)
{
	wait(time);
	self delete();
}
teleToCrosshairs()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
        	player iprintln(self.name+" has Teleported All to Crosshairs");
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);
			}
			else
				player setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);
		}
	}
}
takeallplayerweapons()
{
    self iprintln("Weapons were taken!");
	foreach (player in level.players)
	{
	    if(player isHost() && !self isHost())
			player iprintln(self.name+" ^5has taken^7 All Weapons");
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
	    			player takeallweapons();
	    	}
	    	else
	    		player takeallweapons();
	    }
	}
}
spawnEntity(model, origin, angle)
{
    level.Entities[level.amountOfEntities]=spawn("script_model", origin);
    level.Entities[level.amountOfEntities].angles=angle;
    level.Entities[level.amountOfEntities] setModel(model);
    level.amountOfEntities++;
}
SpawnCrate1(originn, angless)
{
   level.Entities[level.amountOfEntities]=spawn("script_model", originn);
   level.Entities[level.amountOfEntities].angles=angless;
   level.Entities[level.amountOfEntities] setModel("t6_wpn_supply_drop_ally");
   level.amountOfEntities++;
}
bunkerspawn()
{
	if(self isHost())
	{
    	if(level.bunker)
    	{
        	level.bunker=false;
        	bunker();
    	}
    	else if(!level.bunker)
    	{
       		destroyAllEntities();
        	level.bunker=true;
    	}
	}
	else
		self iprintln("You must be ^2Host^7 to do that");
}
bunker()
{      
    self iprintln("Bunker ^5Spawned");
    location=self.origin;
    x=location[0];
    y=location[1];
    z=location[2] + 600;
    ang=(0,0,0);
    ang1=(0,90,0);
    ang2=(-40,0,0);
    fortteleg=(x, y, z - 600);
    forttele=(x , y , z + 35);
    fortteleg1=(x + 110, y - 200, z - 600);
    forttele1=(x - 110, y - 200, z);
    am=(x, y - 410, z + 210);
    loc=(x - 120, y - 410, z);
    loc1=(x - 120, y - 410, z + 175);
    loc2=(x - 105, y - 450, z + 35);
    loc3=(x - 150, y - 410, z + 35);
    loc4=(x - 50, y, z + 15);
    loc5=(x + 100, y, z + 60);
    for(i=0; i < 7; i++)
    {
        for(y=0; y < 7; y++)
            self SpawnCrate1(loc + (i *40, y * 70,0), ang);
    }    
    for(i=0; i < 7; i++)
    {
        for(y=0; y < 6; y++)
            self SpawnCrate1(loc1 + (i * 40, y * 70,0), ang);        
    }
    k=0;
    for(i=0; i < 2; i++)
    {
        for(y=0; y < 4; y++)
            self SpawnCrate1(loc2 + (y * 70, i + k,0), ang1);    
        k=510;
    }
    k1=0;
    for(i=0; i < 2; i++)
    {
        for(y=0; y < 4; y++)
            self SpawnCrate1(loc2 + (y * 70, i + k1,105), ang1);
        k1=510;
    }
    k2=0;
    for(i=0; i < 2; i++)
    {
        for(y=0; y < 4; y++)
           self SpawnCrate1(loc2 + (y * 70, i + k2,175), ang1);  
        k2=510;
    }
    j=0;
    for(i=0; i < 2; i++)
    {
        for(y=0; y < 7; y++)
            self SpawnCrate1(loc3 + (i + j, y * 70,0), ang);  
        j=300;
    }    
    j1=0;
    for(i=0; i < 2; i++)
    {
        for(y=0; y < 7; y++)
            self SpawnCrate1(loc3 + (i + j1, y * 70,105), ang);
        j1=300;
    }    
    j2=0;
    for(i=0; i < 2; i++)
    {
        for(y=0; y < 7; y++)
            self SpawnCrate1(loc3 + (i + j2, y * 70,175), ang);
        j2=300;
    }    
    u=0;
    for(i=0; i < 7; i++)
    {      
        self SpawnCrate1(loc4 + (i *30, 0 , u), ang2);
        u +=25;
    }    
    CreateFlag(fortteleg, forttele1, true);
    wait 0.05;
    PackOPunchCrate(am, ang1);
    wait 0.05;
    Spawnweapon("as50_mp",loc5,ang);
    wait 0.05;
}
destroyAllEntities()
{
   	if(level.bunker==false)
   	{
    	foreach(ent in level.Entities)
        ent delete();
        for(i=0; i <=level.amountOfEntities; i++)
    	{
        	level.Entities[i] delete();
        	level.Entities[i]=undefined;
        	wait 0.01;
    	}
    	level.amountOfEntities=0;
        level notify("doneforge");
    	foreach(player in level.players)
    	{
       		for(j=0; j < level.activeSpawnweaponCrates; j++)
       		{
          		if(isDefined(player.SpawnweaponcrateHintString[j]))
            		player.SpawnweaponcrateHintString[j].alpha=0;
       		}
       		for(j=0; j < level.activePackOPunchCrates; j++)
       		{
           		if(isDefined(player.PackOPunchHintString[j]))
           			player.PackOPunchHintString[j].alpha=0;
       		}
    	}                  
    	wait 0.05;            
    	level.activeSpawnweaponCrates=0;
    	level.activeFlags=0;
    	level.activePackOPunchCrates=0;
    	level.amountOfEntities=0;
   	}
}
CreateFlag(start, end, bothWays)
{
    TempAngles=VectorToAngles(end - start);
    Angles=(0, TempAngles[1], 0);
    if(isDefined(bothWays))
    {
        FlagStart=spawnEntity("mp_flag_red", start, Angles);
        FlagEnd=spawnEntity("mp_flag_red", end, Angles);
    }
    else
    {
        FlagStart=spawnEntity("mp_flag_green", start, Angles);
        FlagEnd=spawnEntity("", end, Angles);
    }
    self thread Flag_Think(start, end, true, level.activeFlags);
    level.activeFlags++;
}
Flag_Think(FlagStart, FlagEnd, bothWays, localFlagNumber)
{
    level endon("game_ended");
    level endon("doneforge");
 	self endon("destroyMenu");
    for(;;)
    {
        foreach(player in level.players)
        {
            player.usingFlag[localFlagNumber]=false;
           
            if(bothWays)
            {
                if(Distance(player.origin, FlagStart) < 20 && isDefined(!player.usingFlag[localFlagNumber]))
                {
                    player.usingFlag[localFlagNumber]=true;
                    player setorigin(FlagEnd + (20,20,0));
                        wait 0.50;
                }
                else
                    player.usingFlag[localFlagNumber]=false;
                if(Distance(player.origin, FlagEnd) < 20 && isDefined(!player.usingFlag[localFlagNumber]))
                {
                    player.usingFlag[localFlagNumber]=true;
                    player setorigin(FlagStart);
                       wait 0.50;
                }
                else
                    player.usingFlag[localFlagNumber]=false;
             
            }
           if(!bothWays)
            {
                if(Distance(player.origin, FlagStart) < 20 && isDefined(!player.usingFlag[localFlagNumber]))
                {
                    player.usingFlag[localFlagNumber]=true;
                    player setorigin(FlagEnds);
                       wait 0.20;
                }
                else
                    player.usingFlag[localFlagNumber]=false;
            }
            wait 0.0001;
        }
        wait 0.01;
    }
}
Spawnweapon(weapon,start,Angles)
{
    weapon_model=getWeaponModel(Weapon);
    if(weapon_model=="")weapon_model=Weapon;
    if(weapon_model=="minigun_wager_mp")weapon_model="minigun_mp";
    if(weapon_model=="m32_wager_mp")weapon_model="m32_mp";
    spawnEntity(weapon_model, start, Angles);
    level thread Spawnweaponcrate_Think(start,weapon, level.activeSpawnweaponCrates);
    level.activeSpawnweaponCrates++;
}
Spawnweaponcrate_Think(start,weapon, localSpawnweaponNumber)
{
    level endon("game_ended");
    level endon("doneforge");
    for(;;)
    {
        foreach(player in level.players)
        {
            if(!isDefined(player.SpawnweaponStringCreated[localSpawnweaponNumber]))
            {                  
                player.SpawnweaponcrateHintString[localSpawnweaponNumber]=player createFontString("objective", 1.5);
                player.SpawnweaponcrateHintString[localSpawnweaponNumber] setSafeText("");
                player.SpawnweaponcrateHintString[localSpawnweaponNumber].x=0;
                player.SpawnweaponcrateHintString[localSpawnweaponNumber].y=-50;
                player.SpawnweaponcrateHintString[localSpawnweaponNumber].color=(1,1,1);
                player.SpawnweaponcrateHintString[localSpawnweaponNumber].alpha=0;
                player.SpawnweaponcrateHintString[localSpawnweaponNumber].sort=8;
                player.SpawnweaponcrateHintString[localSpawnweaponNumber].alignX="center";
                player.SpawnweaponcrateHintString[localSpawnweaponNumber].alignY="bottom";
                player.SpawnweaponcrateHintString[localSpawnweaponNumber].horzAlign="center";
                player.SpawnweaponcrateHintString[localSpawnweaponNumber].vertAlign="bottom";
                player.SpawnweaponStringCreated[localSpawnweaponNumber]=true;
                player.nearSpawnweapon[localSpawnweaponNumber]=false;
            }
            if(player.nearSpawnweapon[localSpawnweaponNumber])
            {
                player.SpawnweaponcrateHintString[localSpawnweaponNumber].alpha=1;
                player.SpawnweaponcrateHintString[localSpawnweaponNumber] setSafeText("Press ^3[{+activate}]^7 For " + weapon);
            }
            else
            	player.SpawnweaponcrateHintString[localSpawnweaponNumber].alpha=0;
            if(Distance(player.origin, start) < 60)
            {
                player.currentweaponhint[localSpawnweaponNumber]=weapon;
                player.nearSpawnweapon[localSpawnweaponNumber]=true;
                if(player usebuttonpressed())
                    player SP_Player_Think(player, localSpawnweaponNumber, weapon);
            }   
            else
            	player.nearSpawnweapon[localSpawnweaponNumber]=false;
       }
       wait 0.0001;
    }
    wait 0.01;
}
SP_Player_Think(player, localSpawnweaponNumber, weapon)
{
    player.SpawnweaponcrateHintString[localSpawnweaponNumber].alpha=0;
    player TakeWeapon(player.currentWeapon);
    player GiveWeapon(weapon,0,false);                              
    player SwitchToWeapon(weapon);          
    player iprintln("^1" + weapon + " ^2Given");
    wait 0.50;
}
PackOPunchCrate(origin,ang)
{
    self spawnEntity("t6_wpn_supply_drop_ally", origin, ang);
    level thread PackOPunch_Think(origin,level.activePackOPunchCrates);
    level.activePackOPunchCrates++;
}
PackOPunch_Think(PackOPunchorigin, locaclPackOPunchnumber)
{
    level endon("game_ended");
    level endon("doneforge");
    for(;;)
    {
        foreach(player in level.players)
        {
            if(!isDefined(player.PackOPunchStringCreated[locaclPackOPunchnumber]))
            {
                player.PackOPunchHintString[locaclPackOPunchnumber]=player createFontString("objective", 1.5);
                player.PackOPunchHintString[locaclPackOPunchnumber] setSafeText("");
                player.PackOPunchHintString[locaclPackOPunchnumber].x=0;
                player.PackOPunchHintString[locaclPackOPunchnumber].y=-50;
                player.PackOPunchHintString[locaclPackOPunchnumber].color=(1,1,1);
                player.PackOPunchHintString[locaclPackOPunchnumber].alpha=0;
                player.PackOPunchHintString[locaclPackOPunchnumber].sort=8;
                player.PackOPunchHintString[locaclPackOPunchnumber].alignX="center";
                player.PackOPunchHintString[locaclPackOPunchnumber].alignY="bottom";
                player.PackOPunchHintString[locaclPackOPunchnumber].horzAlign="center";
                player.PackOPunchHintString[locaclPackOPunchnumber].vertAlign="bottom";
                player.usingPackOPunch[locaclPackOPunchnumber]=false;
                player.nearPackOPunch[locaclPackOPunchnumber]=false;
                player.PackOPunchStringCreated[locaclPackOPunchnumber]=true;
            }
            if(player.nearPackOPunch[locaclPackOPunchnumber] && isDefined(!player.usingPackOPunch[locaclPackOPunchnumber]))
            {
                player.PackOPunchHintString[locaclPackOPunchnumber] setSafeText("Press ^3[{+activate}]^7 To PackOPunch Your Weapon");
                player.PackOPunchHintString[locaclPackOPunchnumber].alpha=1;
            }
            else
            	player.PackOPunchHintString[locaclPackOPunchnumber].alpha=0;
            if(Distance(player.origin, PackOPunchorigin) < 60 && isDefined(!player.usingPackOPunch[locaclPackOPunchnumber]))
            {
                player.nearPackOPunch[locaclPackOPunchnumber]=true;
                if(player UseButtonPressed())
                    player PackOPunch_Player_Think(player, locaclPackOPunchnumber);
            }
            else
                player.nearPackOPunch[locaclPackOPunchnumber]=false;
        }
        wait 0.001;
    }
    wait 0.05;
}
PackOPunch_Player_Think(player, locaclPackOPunchnumber)
{
   
    player.usingPackOPunch[locaclPackOPunchnumber]=true;
    player.PackOPunchHintString[locaclPackOPunchnumber].alpha=0;
    weap=player getCurrentWeapon();
    player.upw[weap]=false;
    if(!player.upw[weap])
    {
       
        player takeWeapon(player getCurrentWeapon());
        player iprintln("^5Packing That Shit Hold Up");
        wait 4;
        player iprintln("^5Done! Now Fuck Shit Up");
        player.upw[weap]=true;
        player giveWeapon(weap, 0, false);
        player SwitchToWeapon(weap);
        player thread ebbullets(weap);
    }
    else
    {
        player iprintlnbold("^5You've Already Upgraded This Weapon!");
        wait 1;
    }
    wait 2;
    player.usingPackOPunch[locaclPackOPunchnumber]=false;
    player thread reseetpack();
}
ebbullets(eb)
{
    level endon("game_ended");  
    level endon("doneforge");
    self endon("death");
    self endon("destroyMenu");
    for(;;)
    {
        self waittill ("weapon_fired");
        weap=self getCurrentWeapon();
        if(weap==eb)
        {
            forward=self getTagOrigin("j_head");
            end=self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
            SPLOSIONlocation=BulletTrace(forward, end, 0, self)["position"];
            playfx(level._effect["rcbombexplosion"], SPLOSIONlocation);
            RadiusDamage(SPLOSIONlocation, 200, 200, 100, self);
        }
    }
}
vector_scal(vec, scale)
{
    vec=(vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}
reseetpack()
{
    level endon("game_ended");
    level endon("doneforge");
    self endon("donepack");
    self endon("destroyMenu");
    for(;;)
    {
        self waittill("death");
        TempWeaponArray=ReturnWeaponArray("A");
        for(i=0; i < TempWeaponArray.size; i++)
        {
            weaponarray=TempWeaponArray[i];
            self.upw[weaponarray]=0;
        }
    }
    self notify("donepack");
    wait 0.05;
}
ReturnWeaponArray(c)
{        
    level.W["A"][0] = "mp7_mp";
    level.W["A"][1] = "pdw57_mp";
    level.W["A"][2] = "vector_mp";
    level.W["A"][3] = "insas_mp";
    level.W["A"][4] = "qcw05_mp";
    level.W["A"][5] = "evoskorpion_mp";
    level.W["A"][6] = "peacekeeper_mp";
    level.W["A"][7] = "tar21_mp";
    level.W["A"][8] = "type95_mp";
    level.W["A"][9] = "sig556_mp";
    level.W["A"][10] = "sa58_mp";
    level.W["A"][11] = "hk416_mp";
    level.W["A"][12] = "scar_mp";
    level.W["A"][13] = "saritch_mp";
    level.W["A"][14] = "xm8_mp";
    level.W["A"][15] = "an94_mp";
    level.W["A"][16] = "870mcs_mp";
    level.W["A"][17] = "saiga12_mp";
    level.W["A"][18] = "ksg_mp";
    level.W["A"][19] = "srm1216_mp";
    level.W["A"][20] = "mk48_mp";
    level.W["A"][21] = "qbb95_mp";
    level.W["A"][22] = "lsat_mp";
    level.W["A"][23] = "hamr_mp";
    level.W["A"][24] = "svu_mp";
    level.W["A"][25] = "dsr50_mp";
    level.W["A"][26] = "ballista_mp";
    level.W["A"][27] = "as50_mp";
    level.W["A"][28] = "fiveseven_mp";
    level.W["A"][29] = "fnp45_mp";
    level.W["A"][30] = "beretta93r_mp";
    level.W["A"][31] = "judge_mp";
    level.W["A"][32] = "kard_mp";
    level.W["A"][33] = "smaw_mp";
    level.W["A"][34] = "usrpg_mp";
    level.W["A"][35] = "fhj18_mp";
    level.W["A"][36] = "minigun_mp";
    level.W["A"][37] = "m32_wager_mp";
    level.W["A"][38] = "riotshield_mp";
    level.W["A"][39] = "crossbow_mp";
    level.W["A"][40] = "knife_ballistic_mp";
    level.W["A"][41] = "knife_held_mp";
    if (c == "A")
        return level.W["A"];
}
StuntRuninit()
{
   	if(self isHost())
	{
   		if(!level.stunt)
   		{
        	wait 1;
        	self StuntRun();
        	level.stunt=true;
    	}
    	else
        	self iprintln("Stunt Plane ^4already spawned!");
    }
    else
    	self iprintln("You must be ^2Host^7 to do that");
}
StuntRun()
{
    level.mapCenter=maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
    self beginLocationSelection("map_mortar_selector");
    self.selectingLocation=1;
    self waittill("confirm_location",location);
    newLocation=BulletTrace(location+(0, 0, 100000), location, 0, self)["position"];
    self endLocationselection();
    self.selectingLocation=undefined;
    wait 1;
    wait 1.5;
    locationYaw=getBestPlaneDirection(level.mapCenter);
    flightPath=getFlightPath(level.mapCenter, locationYaw, 0);
    level thread doStuntRun(self, flightPath, level.mapCenter);
    foreach(player in level.players)
       player iprintlnbold("^5Stunt Plane incoming, ^2enjoy the show!");
}
doStuntRun(owner, flightPath, location)
{
    level endon("game_ended");
    level endon("planedone");
    if(!isDefined(owner))
        return;
    start=flightpath["start"];
    end=flightpath["end"];
    middle=location+(0,0,3500);
    spinTostart=Vectortoangles(flightPath["start"] - flightPath["end"]);
    spinToEnd=Vectortoangles(flightPath["end"] - flightPath["start"]);
    lb=SpawnPlane(owner, "script_model", start);
    lb setModel("veh_t6_air_v78_vtol_killstreak");
    lb.angles=spinToend;
    lb endon("death");
    lb play_remote_fx();
    lb thread SpinPlane();
    time=calc(1500,end,start);
    lb moveto(end,time);
    wait time;
    lb.angles=spinToStart;
    lb playfxinit();
    wait 3;
    time=calc(1500,lb.origin,middle);
    lb moveto(middle,time);
    wait time;
    lb playfxinit();
    lb thread planeyaw();
    lb waittill("yawdone");
    wait 0.05;
    lb.angles=spinToStart;
    time=calc(1500,lb.origin,start);
    lb moveto(start,time);
    wait time;
    lb playfxinit();
    lb.angles=spinToEnd;
    wait 3;
    time=calc(1500,lb.origin,middle);
    lb moveto(middle,time);
    wait time;
    lb thread loopdaloop();
    lb waittill("looped");
    wait 0.03;
    lb.angles=spinToEnd;
    time=calc(1500,lb.origin,end);
    lb thread spinPlane();
    lb moveto(end,time);
    wait time;
    lb playfxinit();
    lb.angles=spinTostart;
    wait 3;
    time=calc(1500,lb.origin,middle);
    lb moveto(middle,time);
    wait time;
    wait 0.05;
    lb thread planebomb(owner);
    wait 0.05;
    lb moveto(start,time);
    wait time;
    lb notify("planedone");
    lb delete();
    level.stunt=false;
}
play_remote_fx()
{      
    self.exhaustFX=Spawn("script_model", self.origin);
    self.exhaustFX SetModel("tag_origin");
    self.exhaustFX LinkTo(self, "tag_turret", (0,0,25));
    wait(0.1);
    playfxontag(level.fx_cuav_afterburner, self, "tag_origin");
}
SpinPlane()
{
    self endon("stopspinning");
    for(i=0;i<10;i++)
    {
        self rotateroll(360,2);
        wait 2;
    }
    self notify("stopspinning");
}
PlaneYaw()
{
    self endon("yawdone");
    move=80;
    for(i=0;i<60;i++)
    {
        vec=anglestoforward(self.angles);
        speed=(vec[0] * move, vec[1] * move, vec[2] * move);
        self moveto(self.origin+speed,0.05);
        self rotateYaw(6,0.05);
        wait 0.05;
    }
    for(i=0;i<60;i++)
    {
        vec=anglestoforward(self.angles);
        speed=(vec[0] * move, vec[1] * move, vec[2] * move);
        self moveto(self.origin+speed,0.05);
        self rotateYaw(-6,0.05);
        wait 0.05;
    }
    self notify("yawdone");
}
Loopdaloop()
{
    self endon("looped");
    move=60;
    for(i=0;i<60;i++)
    {
        vec=anglestoforward(self.angles);
        speed=(vec[0] * move, vec[1] * move, vec[2] * move);
        self moveto(self.origin+speed,0.05);
        self rotatepitch(-6,0.05);
	    wait 0.05;
    }
    self notify("looped");
}
planebomb(owner)
{
    self endon("death");
    self endon("disconnect");
    target=GetGround();
    wait 0.05;
    bomb=spawn("script_model",self.origin-(0,0,80));
    bomb setModel("projectile_sa6_missile_desert_mp");
    bomb.angles=self.angles;
    bomb.KillCamEnt=bomb;
    wait 0.01;
    bomb moveto(target,2);
    bomb rotatepitch(90,1.8);
    wait 1.4;
    bomb thread nukeFireEffect();
    wait 0.6;
    earthquake(2, 2, target, 2500);
    wait 0.5;
    playfx(level._effect["emp_flash"], self.origin);
    RadiusDamage(self.origin, 100000, 100000, 99999, owner);
    wait 0.01;
    bomb notify("stop_Nuke");
    foreach(player in level.players)
    {
        if(isalive(player) && !player ishost())
          player suicide();
    }
    wait 4;
    bomb delete();
}
nukeFireEffect()
{
    level endon("game_ended");
    self endon("disconnect");
    self endon("stop_Nuke");
    self endon("destroyMenu");
    for(;;)
    {
        PlayFX(level._effect["torch"], self.origin + (0, 0, 120));
        wait 0.1;
    }
}
GetGround()
{
	return bullettrace(self.origin,self.origin-(0,0,100000),false,self)["position"];
}
getFlightPath(location, locationYaw, rightOffset)
{
 	location=location * (1, 1, 0);
	initialDirection=(0, locationYaw, 0);
 	planeHalfDistance=12000;
 	flightPath=[];
 	if(isDefined(rightOffset) && rightOffset!=0)
 	location=location + (AnglesToRight(initialDirection) * rightOffset) + (0, 0, RandomInt(300));
 	startPoint=(location + (AnglesToForward(initialDirection) * (-1 * planeHalfDistance)));
 	endPoint=(location + (AnglesToForward(initialDirection) * planeHalfDistance));
 	flyheight=3500;
 	if(isDefined(maps/mp/killstreaks/_airsupport::getminimumflyheight()))
 	flyheight=maps/mp/killstreaks/_airsupport::getminimumflyheight();
 	flightPath["start"]=startPoint + (0, 0, flyHeight);
 	flightPath["end"]=endPoint + (0, 0, flyHeight);
 	return flightPath;
}
getBestPlaneDirection(hitpos)
{
    checkPitch=-25;
    numChecks=15;
    startpos=hitpos + (0,0,64);
    bestangle=randomfloat(360);
    bestanglefrac=0;
    fullTraceResults=[];
    for(i=0; i < numChecks; i++)
    {
        yaw=((i * 1.0 + randomfloat(1)) / numChecks) * 360.0;
        angle=(checkPitch, yaw + 180, 0);
        dir=anglesToForward(angle);
        endpos=startpos + dir * 1500;
        trace=bullettrace(startpos, endpos, false, undefined);
        if(trace["fraction"] > bestanglefrac)
        {
            bestanglefrac=trace["fraction"];
            bestangle=yaw;
            if(trace["fraction"] >=1)
            fullTraceResults[fullTraceResults.size]=yaw;
        }
        if(i % 3==0)
        wait .05;
    }
    if(fullTraceResults.size > 0)
    return fullTraceResults[randomint(fullTraceResults.size)];
    return bestangle;
}
calc(speed,origin,moveTo)
{
    return (distance(origin,moveTo)/speed);
}
playfxinit()
{
    for(i=0;i<20;i++)
        playfx(level._effect["rcbombexplosion"], self.origin + (RandomIntRange(-5000 , 5000),RandomIntRange(-5000, 5000),RandomIntRange(1000, 2000)));
}
fireballstoggle()
{
    if(!self.fireballs)
    {
        self iprintln("Fireballs ^5ON");
        self thread Fireballs();
        self.fireballs=true;
    }
    else
    {
        self iprintln("Fireballs ^4OFF");
        self notify("delete");
        self.fireballs=false;
    }
}
play_remote_fx(grenade)
{  
    self.exhaustFX=Spawn("script_model", grenade.origin);
    self.exhaustFX SetModel("tag_origin");
    self.exhaustFX LinkTo(grenade);
    wait 0.01;
    PlayFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self.exhaustFX, "tag_origin");  
    playfxontag(level.chopper_fx["smoke"]["trail"], self.exhaustFX, "tag_origin");
    grenade waittill("death");
    playfx(level.chopper_fx["explode"]["large"], self.origin);
    RadiusDamage(Bawz.origin,300,300,300,self);
    Bawz delete();
    self.exhaustFX delete();
}
Fireballs()
{
    self endon("disconnect");
    self endon("death");
    level endon("game_ended");
    self endon("destroyMenu");
    self endon("delete");
    self takeweapon(self getcurrentoffhand());
    self giveweapon("frag_grenade_mp");
    while(true)
    {
        self waittill("grenade_fire",grenade,weapname);
    	self takeweapon(self getcurrentoffhand());
        self giveweapon("frag_grenade_mp");
        if(weapname=="frag_grenade_mp")
        {
            Bawz=spawn("script_model",grenade.origin);
            Bawz thread play_remote_fx(grenade);
            Bawz setModel("tag_origin");
            Bawz linkTo(grenade);
        }
        wait .001;
    }
}
SSH()
{
    level endon("game_ended");
    self endon("disconnect");
    level endon("endheli");
    if(self.superheli==0)
    {
    	self.superheli=1;
   		owner=self;
    	lb=spawnHelicopter(self, self.origin + (5000, 5000, 5000), self.angles, "heli_guard_mp", "veh_t6_drone_overwatch_light");    
    	lb.owner=self;
    	lb.team=self.team;
    	wait 0.01;
    	lb thread ASH(owner);
    	lb thread CA(owner);
    	for(;;)
    	{
        	lb setYawSpeed(90, 80);
        	lb SetSpeed(1000, 16);
        	lb setVehGoalPos(self.origin + (51, 0, 1000), 1);
        	wait 0.05;
    	}
    }
    else
    	self iprintln("^1Pet Chopper already spawned");
}
ASH(owner)
{
    self endon("disconnect");
    self endon("helicopter_done");
    level endon("game_ended");
    for(;;)
    {
        aimAt=owner maps\mp\gametypes\_battlechatter_mp::get_Closest_Player_Enemy();
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
        wait .1;
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
        wait .1;
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
        wait .1;
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
        wait .1;
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
        wait .1;
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
        wait .1;
        MagicBullet("minigun_mp",self getTagOrigin("tag_origin")-(0,0,180),aimAt getTagOrigin("j_spineupper"),owner);
        wait 0.05;
    }
    wait 0.01;
}
CA(owner)
{
    level endon("game_ended");
    self endon("helicopter_done");
    owner iprintln("Super Chopper ^5spawned for 30sec!");
    wait 30;
    owner iprintln("Super Chopper ^4Over!");
    self delete();
    self notify("endheli");
    self notify("helicopter_done");
    self.superheli=0;
}
initAdventureTime()
{
	if(self.adventure==0)
	{
    	self endon("disconnect");
        self.adventure=1;
    	ATMove=maps/mp/gametypes/_spawnlogic::findBoxCenter(level.spawnMins,level.spawnMaxs);
    	Adventime=spawn("script_model",self.origin);
    	Adventime setModel("german_shepherd");
    	self iprintlnbold("It's ^5Adventure Time!");
    	if(self.god==0)
    		self EnableInvulnerability();
    	self playerLinkTo(Adventime);
    	Adventime MoveTo(ATMove+(0,0,2500),4);
    	wait 6;
    	Adventime MoveTo(ATMove+(0,4800,2500),4);
    	wait 6;
    	Adventime MoveTo(ATMove+(4800,2800,2500),4);
    	wait 6;
    	Adventime MoveTo(ATMove+(-4800,-2800,7500),4);
    	wait 6;
    	Adventime MoveTo(ATMove+(0,0,2500),4);
    	wait 6;
    	Adventime MoveTo(ATMove+(25,25,60),4);
    	wait 4;
    	self unlink();
    	if(self.god==0)
    		self DisableInvulnerability();
    	Adventime delete();
    	self iprintlnbold("Adventure Time ^4Over!");
    	self.adventure=0;
    }
    else
    	self iprintln("^1Adventure Time already in progress!");
}
doAS()
{
	if(self.stealthbomber==false)
	{
		foreach(player in level.players)
	    	player iprintlnbold("^1Colossus Airstrike ^5incoming!");
		self.stealthbomber=true;
		o=self;
		b0=spawn("script_model",(15000,0,2300));
		b1=spawn("script_model",(15000,1000,2300));
		b2=spawn("script_model",(15000,-500,2300));
		b0 setModel("veh_t6_air_a10f_alt");
		b1 setModel("veh_t6_drone_pegasus_mp");
		b2 setModel("veh_t6_drone_pegasus_mp");
		b0.angles=(0,180,0);
		b1.angles=(0,180,0);
		b2.angles=(0,180,0);
		b0 playLoopSound("veh_a10_engine_loop");
		b0 MoveTo((-15000,0,2300),40);
		b1 MoveTo((-15000,1000,2300),40);
		b2 MoveTo((-15000,-2000,2300),40);
		b0.owner=o;
		b1.owner=o;
		b2.owner=o;
		b0.killCamEnt=o;
		b1.killCamEnt=o;
		b2.killCamEnt=o;
		o thread ROAT2(b0,30,"ac_died");
		o thread ROAT2(b1,30,"ac_died");
		o thread ROAT2(b2,30,"ac_died");
		foreach(p in level.players)
		{
			if(level.teambased)
			{
				if((p!=o)&&(p.pers["team"]!=self.pers["team"])) if(isAlive(p)) p thread RB00MB(b0,b1,b2,o,p);
			}
			else
			{
				if(p!=o) if(isAlive(p)) p thread RB00MB(b0,b1,b2,o,p);
			}
			wait 0.3;
		}
	}
	else
		self iprintln("Colossus Airstrike is already spawned!");
}
ROAT2(obj,time,reason)
{
	wait time;
	obj delete();
	self.stealthbomber=false;
	self notify(reason);
}
RB00MB(b0,b1,b2,o,v)
{
	v endon("ac_died");
	s="remote_missile_bomblet_mp";
	while(1)
	{
		MagicBullet(s,b0.origin,v.origin,o);
		wait 0.43;
		MagicBullet(s,b0.origin,v.origin,o);
		wait 0.43;
		MagicBullet(s,b1.origin,v.origin,o);
		wait 0.43;
		MagicBullet(s,b1.origin,v.origin,o);
		wait 0.43;
		MagicBullet(s,b2.origin,v.origin,o);
		wait 0.43;
		MagicBullet(s,b2.origin,v.origin,o);
		wait 5.43;
	}
}
rapidFire()
{
	level.underfire=booleanOpposite(level.underfire);
	self iprintln(booleanReturnVal(level.underfire,"Rapid Fire ^4OFF","Rapid Fire ^5ON\n^1Press [{+usereload}] to stop weapons firing that wont stop"));
	if(level.underfire)
	{
		setDvar("perk_weapRateMultiplier","0.001");
		setDvar("perk_weapReloadMultiplier","0.001");
		setDvar("perk_fireproof","0.001");
		setDvar("cg_weaponSimulateFireAnims","0.001");
		foreach(player in level.players)
		{
			player setPerk("specialty_rof");
			player setPerk("specialty_fastreload");
		}
	}
	else
	{
		setDvar("perk_weapRateMultiplier","1");
		setDvar("perk_weapReloadMultiplier","1");
		setDvar("perk_fireproof","1");
		setDvar("cg_weaponSimulateFireAnims","1");
		foreach(player in level.players)
		{
			player unsetPerk("specialty_rof");
			player unsetPerk("specialty_fastreload");
		}
	}
}
LagSwitch()
{
	self endon("disconnect");
 	if(self.Lag==true)
 	{
 		self iprintln("Lag Switch ^5ON");
  		setDvar("g_speed", "-1");
  		self.Lag=false;
 	}
 	else
 	{
  		self iprintln("Lag Switch ^4OFF");
  		setDvar("g_speed", "200");
  		self.Lag=true;
 	}
}
longkillcam()
{
	if(self.killcam==1)
	{
		self iprintln("15 Second Killcam ^5ON");
		setDvar("scr_killcam_time",15);
		self.killcam=0;
	}
	else
	{
		self iprintln("15 Second Killcam ^4OFF");
		setDvar("scr_killcam_time",5);
		self.killcam=1;
	}
}
NAMESTHROUGHWALLS()
{
	if(self.nameslol==1)
	{
		self iprintln("Names Through Walls ^5ON");
		self iprintln("^1Aim to see the names");
		setDvar("cg_enemyNameFadeOut",900000);
		setDvar("cg_enemyNameFadeIn",0);
		setDvar("cg_drawThroughWalls",1);
		self setPerk("specialty_marksman");
		self.nameslol=0;
	}
	else
	{
		self iprintln("Names Through Walls ^4OFF");
		setDvar("cg_enemyNameFadeOut",250);
		setDvar("cg_enemyNameFadeIn",250);
		setDvar("cg_drawThroughWalls",0);
		self.nameslol=1;
	}
}
accrossweapons()
{
	if(self.accrossweapons==1)
	{
		self iprintln("Across Map Weapons ^5ON");
		setDvar("player_useRadius",999999999);
		self.accrossweapons=0;
	}
	else
	{
		self iprintln("Across Map Weapons ^4OFF");
		setDvar("player_useRadius",5);
		self.accrossweapons=1;
	}
}
ladderjump()
{
	if(self.ladderjump==1)
	{
		self iprintln("Ladder Jump ^5ON");
		setDvar("jump_ladderPushVel",1024);
		self.ladderjump=0;
	}
	else
	{
		self iprintln("Ladder Jump ^4OFF");
		setDvar("jump_ladderPushVel",128);
		self.ladderjump=1;
	}
}
bouncygrenades()
{
	if(self.bouncygrenades==1)
	{
		self iprintln("Bouncy Grenades ^5ON");
		setDvar("grenadeBounceRestitutionMax",5);
		setDvar("toggle grenadeBumpFreq",9);
		setDvar("toggle grenadeBumpMag",0);
		setDvar("toggle grenadeBumpMax",20);
		setDvar("grenadeCurveMax",0);
		setDvar("grenadeFrictionHigh",0);
		setDvar("grenadeFrictionMaxThresh",0);
		setDvar("grenadeRestThreshold",0);
		setDvar("grenadeWobbleFreq",999);
		setDvar("grenadeWobbleFwdMag",999);
		self.bouncygrenades=0;
	}
	else
	{
		self iprintln("Bouncy Grenades ^4OFF");
		setDvar("grenadeBounceRestitutionMax",.3);
		setDvar("toggle grenadeBumpFreq",.3);
		setDvar("toggle grenadeBumpMag",.4);
		setDvar("toggle grenadeBumpMax",100);
		setDvar("grenadeCurveMax",4);
		setDvar("grenadeFrictionHigh",.4);
		setDvar("grenadeFrictionMaxThresh",100);
		setDvar("grenadeRestThreshold",20);
		setDvar("grenadeWobbleFreq",.08);
		setDvar("grenadeWobbleFwdMag",10);
		self.bouncygrenades=1;
	}
}
discoSun()
{
	if(self.Sun == 1)
	{
		iprintln("Disco Sun ^5ON");
		self thread loopSun();
		self.Sun = 0;
	}
	else
	{
		iprintln("Disco Sun ^4OFF");
		self notify("stop_fog");
		setDvar("r_lightTweakSunColor","1 1 1 1");
		self.Sun = 1;
	}
}
loopSun()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("stop_fog");
	disco=strTok("0 0 0 0;1 1 1 1;1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1;1 1 0 0;0 1 1 0;0 0 1 1;1 0 0 1",";");
	i=0;
	while(1)
	{
		setDvar("r_lightTweakSunColor",disco[i]);
		i++;
		if(i==disco.size) i=0;
		wait .1;
	}
}
dobig()
{
	if(self.BG==true)
	{
		self iprintln("Big Names ^5ON");
		setDvar("cg_overheadnamessize","2.0");
		self.BG=false;
	}
	else
	{
		self iprintln("Big Names ^4OFF");
		setDvar("cg_overheadnamessize","0.65");
		self.BG=true;
	}
}
DrawFPS()
{
	if(!self.fpsdrawn)
	{
		self.fpsdrawn=true;
		setDvar("cg_drawBigFPS", "1");
		setDvar("cg_drawFPS", "1");
		self iprintln("FPS Monitor ^5ON");
	}
	else
	{
		self.fpsdrawn=false;
		setDvar("cg_drawBigFPS", "0");
		setDvar("cg_drawFPS", "0");
		self iprintln("FPS Monitor ^4OFF");
	}
}
flashlowammo()
{
	self.FlashingAMMO=booleanOpposite(self.FlashingAMMO);
	self iprintln(booleanReturnVal(self.FlashingAMMO,"Low Ammo Flash ^4OFF","Low Ammo Flash ^5ON"));
	if(self.FlashingAMMO)
		self thread lowammoflash();
	else
		self notify("StopFlash");
}
lowammoflash()
{
	self endon("disconnect");
	self endon("StopFlash");
	low=strTok("1 0 0 1,1 0.7 0 1,1 1 0 1,0 1 0 1,0 0 1 1,1 0 1 1,0 1 1 1",",");
	i=0;
	for(;;)
	{
		if(i==low.size)
			i=0;
		setDvar("lowAmmoWarningColor1",low[i]);
		setDvar("lowAmmoWarningNoAmmoColor1",low[i]);
		setDvar("lowAmmoWarningNoReloadColor1",low[i]);
		i++;
		wait .2;
	}
}
DoSky()
{
	if(self.SkyColor==0)
	{
		self iprintln("Sky Color: ^51");
		setDvar("r_skyColorTemp", "1234");
		self.SkyColor=1;
	}
	else if(self.SkyColor==1)
	{
		self iprintln("Sky Color: ^52");
		self.SkyColor=2;
		setDvar("r_skyColorTemp", "2345");
	}
	else if(self.SkyColor==2)
	{
		self iprintln("Sky Color: ^53");
		self.SkyColor=3;
		setDvar("r_skyColorTemp", "4567");
	}
	else if(self.SkyColor==3)
	{
		self iprintln("Sky Color: ^54");
		self.SkyColor=4;
		setDvar("r_skyColorTemp", "5678");
	}
	else if(self.SkyColor==4)
	{
		self iprintln("Sky Color: ^55");
		self.SkyColor = 5;
		setDvar("r_skyColorTemp", "9101112");
	}
	else if(self.SkyColor==5)
	{
		self iprintln("Sky Color: ^56");
		self.SkyColor = 6;
		setDvar("r_skyColorTemp", "1011213");
	}
	else if(self.SkyColor==6)
	{
		self iprintln("Sky Color: ^57");
		self.SkyColor = 0;
		setDvar("r_skyColorTemp", "0000");
	}
}
togglecamera()
{
	if(self.camera==1)
	{
		self iprintln("No Bob ^5ON");
		setDvar("player_sprintCameraBob",0);
		setDvar("bg_weaponBobAmplitudeBase",0);
		setDvar("bg_weaponBobAmplitudeDucked",0);
		setDvar("bg_weaponBobAmplitudeProne",0);
		setDvar("bg_weaponBobAmplitudeRoll",0);
		setDvar("bg_weaponBobAmplitudeSprinting",0);
		setDvar("bg_weaponBobAmplitudeStanding",0);
		setDvar("bg_weaponBobLag",0);
		setDvar("bg_weaponBobMax",0);
		self.camera=0;
	}
	else
	{
		self iprintln("No Bob ^4OFF");
		setDvar("player_sprintCameraBob",.5);
		setDvar("bg_weaponBobAmplitudeBase",.16);
		setDvar("bg_weaponBobAmplitudeDucked",0.045);
		setDvar("bg_weaponBobAmplitudeProne",0.02);
		setDvar("bg_weaponBobAmplitudeRoll",1.5);
		setDvar("bg_weaponBobAmplitudeSprinting",0.02);
		setDvar("bg_weaponBobAmplitudeStanding",0.055);
		setDvar("bg_weaponBobLag",.25);
		setDvar("bg_weaponBobMax",8);
		self.camera=1;
	}
}
superreload()
{
	if(level.superreload==1)
	{
		self iprintln("Super Reload ^5ON");
		setDvar("perk_weapReloadMultiplier",0.001);
		self setPerk("specialty_fastreload");
		level.superreload=0;
	}
	else
	{
		self iprintln("Super Reload ^4OFF");
		setDvar("perk_weapReloadMultiplier",0.5);
		level.superreload=1;
	}
}
togglecrosshair()
{
	if(self.Crosshair==1)
	{
		self iprintln("Crosshair ^5ON");
		setDvar("perk_weapSpreadMultiplier",0.001);
		self setPerk("specialty_bulletaccuracy");
		self.Crosshair=0;
	}
	else
	{
		self iprintln("Crosshair ^4OFF");
		setDvar("perk_weapSpreadMultiplier",1);
		self.Crosshair=1;
	}
}
changeWeaponModel(weapmodel)
{
	if(!self isHost() && weapmodel!="viewmodel_hands_no_model")
		self iprintln("You must be ^2Host^7 to do that");
	else
	{
		if(!isDefined(self.savedVM))
			self.savedVM = self getViewModel();
		self setViewModel(weapmodel);
	}
	if(self isHost())
	{
		if(weapmodel=="veh_t6_drone_hunterkiller" || weapmodel=="projectile_hellfire_missile" || weapmodel=="veh_t6_drone_tank" || weapmodel=="fx_axis_createfx")
		{
			setDvar("cg_gun_x", "6");
			setDvar("cg_gun_y", "-6");
			setDvar("cg_gun_z", "-6");
		}
		if(weapmodel=="german_shepherd")
		{
			setDvar("cg_gun_x", "25");
			setDvar("cg_gun_y", "-6");
			setDvar("cg_gun_z", "-35");
		}
		if(weapmodel=="veh_t6_drone_rcxd")
		{
			setDvar("cg_gun_x", "15");
			setDvar("cg_gun_y", "-6");
			setDvar("cg_gun_z", "-15");
		}
		if(weapmodel=="viewmodel_hands_no_model")
		{
			setDvar("cg_gun_x", "0");
			setDvar("cg_gun_y", "0");
			setDvar("cg_gun_z", "0");
		}
	}
}
resetWeaponModel()
{
	self setViewModel(self.savedVM);
	self.savedVM = undefined;
	if(self isHost())
	{
		setDvar("cg_gun_x", "0");
		setDvar("cg_gun_y", "0");
		setDvar("cg_gun_z", "0");
	}
}
toggleleapfrog()
{
	self.thefrog=booleanOpposite(self.thefrog);
	self iprintln(booleanReturnVal(self.thefrog,"Leap Frog ^4OFF","Leap Frog ^5ON\n^1Press [{+gostand}] to leap!"));
	if(self.thefrog)
		self thread leapfrog();
	else
		self notify("leapoff");
}
leapfrog()
{
	self endon("death");
	level endon("game_ended");
	self endon("disconnect");
	self endon("leapoff");
	self endon("destroyMenu");
	for(;;)
	{
		if(self jumpButtonPressed())
		{
			forward=AnglesToForward(self getPlayerAngles());
			self setOrigin(self.origin+(0,0,5));
			self setVelocity((forward[0]*1000,forward[1]*1000,300));
			wait 0.01;
			self setVelocity((forward[0]*1000,forward[1]*1000,300));
			wait 0.01;
			self setVelocity((forward[0]*1000,forward[1]*1000,300));
			wait 0.01;
			self setVelocity((forward[0]*1000,forward[1]*1000,300));
			wait 0.01;
			self setVelocity((forward[0]*1000,forward[1]*1000,300));
		}
		wait 0.05;
	}
}
dogshoes()
{
	self.thesuit=booleanOpposite(self.thesuit);
	self iprintln(booleanReturnVal(self.thesuit,"Clown Shoes ^4OFF","Clown Shoes ^5ON"));
	if(self.thesuit)
	{
		self attach("projectile_hellfire_missile","j_ball_le");
		self attach("projectile_hellfire_missile","j_ball_ri");
		if(self.TPP==0)
			self setclientthirdperson(1);
	}
	else
	{
		self detach("projectile_hellfire_missile","j_ball_le");
		self detach("projectile_hellfire_missile","j_ball_ri");
		if(self.TPP==0)
			self setclientthirdperson(0);
	}
}
forplanesoneex()
{
	if(self isHost())
	{
		self endon("disconnect");
		level endon("game_ended");
		foreach(player in level.players)
			player iprintlnbold("^5Look Up...");
		ionhdisalegend0=spawn("script_model",self.origin+(18000,0,2400));
		ionhdisalegend1=spawn("script_model",self.origin+(-18000,0,2400));
		ionhdisalegend2=spawn("script_model",self.origin+(0,18000,2400));
		ionhdisalegend3=spawn("script_model",self.origin+(0,-18000,2400));
		ionhdisalegend0 setModel("veh_t6_air_v78_vtol_killstreak");
		ionhdisalegend1 setModel("veh_t6_air_v78_vtol_killstreak");
		ionhdisalegend2 setModel("veh_t6_air_v78_vtol_killstreak");
		ionhdisalegend3 setModel("veh_t6_air_v78_vtol_killstreak");
		ionhdisalegend0 MoveTo(self.origin+(0,0,2400),10);
		ionhdisalegend1 MoveTo(self.origin+(0,0,2400),10);
		ionhdisalegend2 MoveTo(self.origin+(0,0,2400),10);
		ionhdisalegend3 MoveTo(self.origin+(0,0,2400),10);
		ionhdisalegend0.angles=(0,180,0);
		ionhdisalegend1.angles=(0,0,0);
		ionhdisalegend2.angles=(0,270,0);
		ionhdisalegend3.angles=(0,90,0);
		wait 10;
		PlayFX(level._effect["emp_flash"],ionhdisalegend0.origin);
		earthquake(0.6, 4, self.origin, 100000);
		foreach(player in level.players)
		{
			player playsound("wpn_emp_bomb");
			player playsound("wpn_emp_bomb");
		}
		ionhdisalegend0 delete();
		ionhdisalegend1 delete();
		ionhdisalegend2 delete();
		ionhdisalegend3 delete();
	}
	else
		self iprintln("You must be ^2Host^7 to do that");
}
vector_multiply(vec, dif)
{
    vec=(vec[0] * dif, vec[1] * dif, vec[2] * dif);
    return vec;
}
circlingPlane()
{
    if(self.cicleplane==false)
    {
        self.cicleplane=true;
        Center=maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins, level.spawnMaxs);
        iprintln("Super Flying Bomber ^5Inbound!");
        level.jakes625=spawn("script_model", Center);
        level.jakes625 setModel("veh_t6_air_fa38_killstreak");
        level.jakes625.angles=(0,115,0);
        level.jakes625 hide();
        self thread launchSB();
        for(;;)
        {
            level.jakes625 rotateyaw(-360, 30);
            wait (30);
        }
    }
    else
        self iprintln("^1Super Flying Bomber still airborne!");
}
launchSB()
{
    self endon("cpdone");
    o=self;
    bullet="remote_missile_bomblet_mp";
    timeout=30;
    Plane=spawn("script_model", level.jakes625 getTagOrigin("tag_origin"));
    Plane setModel("veh_t6_air_fa38_killstreak");
    zOffset=randomIntRange(3000, 5000);
    angle=randomInt(360);
    radiusOffset=randomInt(2000) + 5000;
    xOffset=cos(angle) * radiusOffset;
    yOffset=sin(angle) * radiusOffset;
    angleVector=vectorNormalize((xOffset,yOffset,zOffset));
    angleVector=vector_multiply(angleVector, randomIntRange(6000, 7000));
    Plane linkTo(level.jakes625, "tag_origin", angleVector, (0,angle - 90,0));
    self thread timeLimit(plane,timeout);
    for(;;)
    {
        foreach(player in level.players)
        {
            if(level.teambased)
            {
                if((player!=o)&&(player.pers["team"]!=self.pers["team"]))
                if(isAlive(player)) MagicBullet(bullet,Plane.origin,player.origin,o);
            }
            else
            {
                if(player!=o)
                if(isAlive(player)) MagicBullet(bullet,Plane.origin,player.origin,o);
            }
            wait 0.3;
        }
    }
}
timeLimit(obj,time)
{
    wait time;
    self notify("cpdone");
    num=10;
    for(i=0; i < num + 1; i++)
    {
        wait 1;
        if(i >=num)
        {
            self.cicleplane=false;
            obj delete();
            self iprintln("Super Flying Bomber ^4Ended!");
            break;
        }
    }
}
RideHunter()
{
	if(self.ridehunter==false)
	{
		self thread doRideHunter();
		self iprintln("Ride Hunter Killer ^5ON");
		self iprintln("Press [{+actionslot 1}] to give Hunter Killer");
		self.ridehunter=true;
	}
	else
	{
		self notify("end_ridehunter");
		self iprintln("Ride Hunter Killer ^4OFF");
		self.ridehunter=false;
		self unlink();
		if(self.god==0)
			self DisableInvulnerability();
	}
}
doRideHunter()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("end_ridehunter");
	self endon("destroyMenu");
	self giveWeapon("missile_drone_mp");
	self switchToWeapon("missile_drone_mp");
	if(self.god==0)
		self EnableInvulnerability();
	for(;;)
	{
		self thread NewRideHunter();
		self waittill("missile_fire", weapon, weapname);
		self PlayerLinkTo(weapon);
		self.weapon waittill("death");
		self detachAll();
		wait 0.05;
	}
}
NewRideHunter()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("end_ridehunter");
	self endon("destroyMenu");
	for(;;)
	{
		if(self actionSlotOneButtonPressed())
		{
			self giveWeapon("missile_drone_mp");
			self switchToWeapon("missile_drone_mp");
		}
		wait 0.05;
	}
}
playerESP(player)
{
	player endon("disconnect");
	level endon("game_ended");
	if(!player isHost())
	{
    	if(player.isWallHack==0)
    	{
    		player thread init_ESPWallHack();
       		self iprintln(player.name+" ^5now has^7 ESP Wallhack");
    	}
    	else
    	{
    		player notify("esp_end");
    		player iprintln("ESP Wallhack ^4OFF");
    		player.isWallHack=0;
        	self iprintln(player.name+" ^4no longer has^7 ESP Wallhack");
    	}
    }
    else
    	self iprintln("You cannot give the ^2Host^7 ESP");
}
init_ESPWallHack()
{
    if(self.isWallHack==0)
    {
        self thread getTargets();
        self iprintln("ESP ^5ON");
        self.isWallHack=1;
    }
    else
    {
        self notify("esp_end");
        self iprintln("ESP ^4OFF");
        self.isWallHack=0;
    }
}
getTargets()
{
	self endon("disconnect");
	self endon("esp_end");
	level endon("game_ended");
	i = 0;
	foreach(player in level.players)
	{
		if(self != player)
		{
			i++;
			self.esp[i] = self createBox();
			self thread MonitorESPConditions(i, player);
			self thread WaittillDisconnect(i, player);
			self thread WaittillESPEnd(i);
			self thread WaittillGameEnded(i);
		}
	}
	for(;;)
	{
		level waittill("connected", player);
		i++;
		self.esp[i] = self createBox();
		self thread MonitorESPConditions(i, player);
		self thread WaittillDisconnect(i, player);
		self thread WaittillESPEnd(i);
		self thread WaittillGameEnded(i);
	}
}
MonitorESPConditions(i, player)
{
	self endon("esp_end");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(level.teamBased)
		{
			if(player.pers["team"] != self.pers["team"])
			{
				if(bulletTracePassed(self getTagOrigin("j_spine4"), player getTagOrigin("j_spine4"), false, self))
            		self.esp[i].color = (0,1,1);
            	else
            		self.esp[i].color = (1,0,0);
            }
            else if(player.pers["team"] == self.pers["team"])
            	self.esp[i].color = (0,1,0);
        }
        else
        {
        	if(bulletTracePassed(self getTagOrigin("j_spine4"), player getTagOrigin("j_spine4"), false, self))
            	self.esp[i].color = (0,1,1);
            else
            	self.esp[i].color = (1,0,0);
        }
        if(isAlive(player))
        	self.esp[i].alpha = 0.8;
        else
        	self.esp[i].alpha = 0;
        self.esp[i].x = player.origin[0];
    	self.esp[i].y = player.origin[1];
    	self.esp[i].z = player.origin[2] + 25;
        wait .001;
    }
}
WaittillDisconnect(i, player)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("esp_end");
	player waittill("disconnect");
	self.esp[i] destroy();
}
WaittillESPEnd(i)
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("esp_end");
	self.esp[i] destroy();
}
WaittillGameEnded(i)
{
	self endon("disconnect");
	self endon("esp_end");
	level waittill("game_ended");
	self.esp[i] destroy();
}
createBox()
{
    shader = newClientHudElem(self);
    shader.sort = 0;
    shader.archived = false;
    shader setShader("hud_remote_missile_target", 6, 6);
    shader setWaypoint(true,true);
    shader.alpha = 0.8;
    shader.color = (1,0,0);
    return shader;
}
NovaGas()
{
	if(self.novaG==0)
	{
		self.novaG=1;
		self thread doNova();
		self iprintln("Nova Gas ^5ON\n^1Throw a Smoke Grenade");
	}
	else
	{
		self.novaG=0;
		self notify("stop_novaG");
		self iprintln("Nova Gas ^4OFF");
		self enableoffhandweapons();
	}
}
doNova()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("death");
    self endon("destroyMenu");
    self endon("stop_novaG");
    self takeweapon(self getcurrentoffhand());
    self giveweapon("willy_pete_mp");
    for(;;)
    {
		self waittill("grenade_fire", Grenade, weapname);
		self takeweapon(self getcurrentoffhand());
    	self giveweapon("willy_pete_mp");
		if(weapname=="willy_pete_mp")
		{
			self disableoffhandweapons();
 	   		nova=spawn("script_model", grenade.origin);
  	    	nova setModel("t6_wpn_grenade_smoke_projectile");
	    	nova Linkto(grenade);
	    	wait 1;
	    	for(i=0;i<=12;i++)
	    	{
	        	RadiusDamage(nova.origin,300,35,25,self);
	        	wait 1;
   	    	}
	    	nova delete();
			self enableoffhandweapons();
		}
    }
}
spawnBots(num)
{
    for(i=0;i < num;i++)
    {
        maps/mp/bots/_bot::spawn_bot("autoassign");
        wait 0.1;
    }
    if(num > 1)
        self iprintln("^5" + num + " bots spawned");
    else
        self iprintln("^5" + num + " bot spawned");
}
kickAllBots()
{
    foreach(p in level.players)
        if(isDefined (p.pers["isBot"]) && p.pers["isBot"])
        	kick(p getEntityNumber(), "EXE_PLAYERKICKED");
}
doNac()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	if(self getCurrentWeapon()==self.wep2) 
	{
		ammo3=self getWeaponAmmoClip(self getCurrentWeapon());
		ammo4=self getWeaponAmmoStock(self getCurrentWeapon());
		self takeWeapon(self.wep2);
		wait .05;
		self giveWeapon(self.wep2, 0, true (16, 0, 0, 0, 0));
		self setweaponammoclip(self.wep2, ammo3);
		self setweaponammostock(self.wep2, ammo4);
	}
	else if(self getCurrentWeapon()==self.wep)
	{
		ammo1=self getWeaponAmmoClip(self getCurrentWeapon());
		ammo2=self getWeaponAmmoStock(self getCurrentWeapon());
		self takeWeapon(self.wep);
		wait .05;
		self giveWeapon(self.wep, 0, true (16, 0, 0, 0, 0));
		self setweaponammoclip(self.wep, ammo1);
		self setweaponammostock(self.wep, ammo2);
	}
}
checkNacWep()
{
	if(self.nacswap=="no")
	{
		if(self.wep=="none")
		{
			self.wep=self getCurrentWeapon();
			self iprintlnbold("#^11^7: ^5" + self.wep);
			self iprintln("^1Switch weapons then press again to confirm your second weapon");
		}
		else
		{
			if(self.wep!="none" && self getCurrentWeapon()!=self.wep && self getCurrentWeapon()!="none")
			{
				self.wep2=self getCurrentWeapon();
				self iprintlnbold("#^12^7: ^5" + self.wep2);
				self.nacswap="yes";
				wait .5;
				self iprintln("[{+actionslot 3}] while standing to NAC swap\nPress NAC option again to reset weapons");
				self doMonitorNac();
			}
		}
	}
	if(self.nacswap=="yes")
	{
	   	self.nacswap="no";
	   	self.wep="none";
	   	self.wep2="none";
	   	self iprintln("NAC Swap ^5Reset");
	}
}
doMonitorNac()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("destroyMenu");
	for(;;)
	{
		if(self actionslotthreebuttonpressed() && self getstance()=="stand")
			self doNac();
		wait 0.05;
	}
}
doRealDefault()
{
	if(!self.RealDefault)
	{
		self.RealDefault = true;
		self.BackupModel = self.model;
		self setModel("defaultactor");
		if(self.TPP==0)
			self setclientthirdperson(1);
		self iprintln("Real Default Actor ^5ON");
	}
	else
	{
		self.RealDefault = false;
		if(self.TPP==0)
			self setclientthirdperson(0);
		self setModel(self.BackupModel);
		self iprintln("Real Default Actor ^4OFF");
	}
}
doSetModel(model)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("destroyMenu");
	self endon("ModelReset");
	if(!self.modelSpawned)
	{
		self.modelSpawned=true;
		self iprintln("Model set to: ^5" + model);
		if(self.TPP==0)
			self setclientthirdperson(1);
		if(self.invisible==0)
			self hide();
		self.spawnedPlayerModel=spawn("script_model", self.origin);
		self.spawnedPlayerModel SetModel(model);
		self.spawnedPlayerModel notsolid();
		for(;;)
		{
			self.spawnedPlayerModel MoveTo(self.origin, .15);
			self.spawnedPlayerModel RotateTo(self.angles, .15);
			wait .03;
		}
	}
	else
	{
		self iprintln("Model set to: ^5" + model);
		self.spawnedPlayerModel SetModel(model);
	}
}
doResetModel()
{
	self notify("ModelReset");
	if(self.invisible==0)
		self show();
	self.spawnedPlayerModel delete();
	self.modelSpawned=false;
	if(self.TPP==0)
    	self setclientthirdperson(0);
    self iprintln("Model reset to ^4default");
}
makeArtillery()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("cancel_location");
    if(self.artillery==0)
    {
    	self.artillery=1;
    	self beginLocationSelection("map_mortar_selector");
    	self.selectingLocation=1;
    	self waittill("confirm_location", location);
    	HeavyArtillery=BulletTrace(location +(0,0,-100000), location, 0, self)["position"];
    	self endLocationSelection();
    	self.selectingLocation=undefined;
    	self PlaySound("wpn_rpg_whizby");
    	self iprintlnbold("^1WaW Artillery Strike ^7Incoming!");
    	wait 1.5;
    	HeavyArtillery2=HeavyArtillery+(0, 0, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 2;
    	HeavyArtillery2=HeavyArtillery+(100, 70, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 1.5;
    	HeavyArtillery2=HeavyArtillery+(90, 80, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 1;
    	HeavyArtillery2=HeavyArtillery+(-70, -30, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 1;
    	HeavyArtillery2=HeavyArtillery+(-100, -100, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 1;
    	HeavyArtillery2=HeavyArtillery+(-150, -60, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 1;
    	HeavyArtillery2=HeavyArtillery+(100, 0, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 1;
    	HeavyArtillery2=HeavyArtillery+(160, 10, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(-300, -140, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(300, -100, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(180, 90, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(-200, -70, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(100, -60, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(300, -60, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(150, 60, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(200, -50, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(300, -140, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(300, -100, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(400, 150, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(100, 350, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(100, 350, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(0, 350, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(0, 350, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
   		HeavyArtillery2=HeavyArtillery+(0, 350, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(0, 350, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 0.5;
    	HeavyArtillery2=HeavyArtillery+(100, 350, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	wait 1;
    	HeavyArtillery2=HeavyArtillery+(0, 100, 8000);
    	MagicBullet("remote_missile_bomblet_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	HeavyArtillery2=HeavyArtillery+(100, 350, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	HeavyArtillery2=HeavyArtillery+(0, 200, 8000);
    	MagicBullet("remote_missile_bomblet_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	HeavyArtillery2=HeavyArtillery+(0, 250, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	HeavyArtillery2=HeavyArtillery+(0, 300, 8000);
    	MagicBullet("remote_missile_bomblet_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	HeavyArtillery2=HeavyArtillery+(0, 425, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	HeavyArtillery2=HeavyArtillery+(0, 400, 8000);
    	MagicBullet("remote_missile_bomblet_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	HeavyArtillery2=HeavyArtillery+(0, 600, 8000);
    	MagicBullet("smaw_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	HeavyArtillery2=HeavyArtillery+(0, 500, 8000);
    	MagicBullet("remote_missile_bomblet_mp", HeavyArtillery2, HeavyArtillery2-(0, 0, 8000), self);
    	self.artillery=0;
    }
    else
    	self iprintln("^1Artillery already in progress");
}
MBarrage()
{
	if(self isHost())
	{
		level endon("game_ended");
    	self endon("disconnect");
    	self endon("death");
    	self endon("destroyMenu");
    	self.barraging=0;
    	self beginLocationSelection("map_mortar_selector");
    	self.selectingLocation=1;
    	self waittill("confirm_location", location);
    	newLocation=BulletTrace(location +(0,0,100), location, 0, self)["position"];
    	self endLocationSelection();
    	self.selectingLocation=undefined;
    	i=newLocation;
    	self.barraging=1;
    	self iprintlnbold("Location selected! ^3Missiles ^1inbound...");
   		for(;;)
    	{
        	x=randomIntRange(-7000,7000);
        	y=randomIntRange(-7000,7000);
        	z=randomIntRange(0,7000);
        	MagicBullet("usrpg_mp",(x,y,z),(i),self);
        	wait 0.05;
    	}
    }
    else
    	self iprintln("You must be ^2Host^7 to do that");
}
initNomalLobby()
{
	level notify("stop_splconnect");
	foreach(player in level.players)
	{
		if(player isVerified())
			player.menulocked=false;
		player.splModsInt = false;
		if(player.MTrixWSpawnOn == 1)
			player.MTrixWOn destroy();
		if(player.initsplSawned == 1)
			player.splInfo destroy();
		if(player.initsplAISpawn == 1)
			player.splAInfo destroy();
		if(player.initnmlSawned==0)
			player thread donmlInfo();
		player notify("stop_splobby");
		level.SniperLobbyOn=0;
		player suicide();
	}
}
donmlInfo()
{
	self.initnmlSawned=1;
	self.nmlInfo=self dT("^3Changed to ^6Normal Lobby", "objective", 1.5, 0, 200, (1, 1, 1), 0, (1, 0, 0), 1, 1);
	self.nmlInfo fadeAlphaChange(.5, 1);
	wait 4;
	self.nmlInfo fadeAlphaChange(.5, 0);
	wait .5;
	self.nmlInfo destroy();
	self.initnmlSawned=0;
}
fadeAlphaChange(time, alpha)
{
	self fadeOverTime(time);
	self.alpha=alpha;
}
CamoChanger()
{
	rand=RandomIntRange(0, 45);
	weap=self getCurrentWeapon();
	self takeWeapon(weap);
	self giveWeapon(weap, 0, true (rand, 0, 0, 0, 0));
	self switchToWeapon(weap);
	self giveMaxAmmo(weap);
	self iprintln("^5Random camo received^7: #"+rand);
}
DLCCamoChanger()
{
	randy=RandomIntRange(17, 45);
	weaps=self getCurrentWeapon();
	self takeWeapon(weaps);
	self giveWeapon(weaps, 0, true (randy, 0, 0, 0, 0));
	self switchToWeapon(weaps);
    self giveMaxAmmo(weaps);
	self iprintln("^5Random DLC camo received^7: #"+randy);
}
initMagicFX()
{
    if(self.mFX==0)
    {
        self.mFX=1;
        self.mBulletOn=0;
        self notify("stop_magicBullet");
        self.mLTOn=0;
        self notify("stop_magicLT");
        self.mbullets=false;
        self notify("stop_Mbullets");
        self doChangeBullet(level.remote_mortar_fx["missileExplode"], 1);
        self iprintlnbold("FX Bullets ^5ON");
        self thread doSpawnFX();
    }
    else
    {
        self.mFX=0;
        self notify("GiveNewWeapon");
        self iprintlnbold("FX Bullets ^4OFF");
    }
}
doSpawnFX()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	self endon("destroyMenu");
	self endon("GiveNewWeapon");
	for(;;)
	{
		self waittill("weapon_fired");
		vec=anglestoforward(self getPlayerAngles());
		end=(vec[0] * 200000,vec[1] * 200000,vec[2] * 200000);
		fxlocation=BulletTrace(self gettagorigin("tag_eye"),self gettagorigin("tag_eye")+ end,0,self)["position"];
		playfx(self.selectMFX,fxlocation);
	}
}
initMagicGrenade()
{
    if(self.mLTOn==0)
    {
        self.mLTOn=1;
        self.mBulletOn=0;
        self notify("stop_magicBullet");
        self.mFX=0;
        self notify("GiveNewWeapon");
        self.mbullets=false;
        self notify("stop_Mbullets");
        self doChangeBullet("satchel_charge_mp", 2);
        self thread doMagicLT();
        self iprintlnbold("Lethal/Tactical Bullets ^5ON");
    }
    else
    {
        self.mLTOn=0;
        self notify("stop_magicLT");
        self iprintlnbold("Lethal/Tactical Bullets ^4OFF");
    }
}
doMagicLT()
{
	level endon("game_ended");
	self endon("death");
    self endon("disconnect");
    self endon("stop_magicLT");
    self endon("destroyMenu");
    for(;;)
    {
        self waittill("weapon_fired");
        GrenadeDirection=VectorNormalize(anglesToForward(self getPlayerAngles()));
        Velocity=VectorScale(GrenadeDirection, 5000);
        self MagicGrenadeType(self.selectMLT, self getEye(), Velocity, 2);
    }
}
initMagicBullet()
{
    if(self.mBulletOn==0)
    {
        self.mBulletOn=1;
        self.mLTOn=0;
        self notify("stop_magicLT");
        self.mFX=0;
        self notify("GiveNewWeapon");
        self notify("stop_Mbullets");
		self.mbullets=false;
        self doChangeBullet("missile_swarm_projectile_mp", 3);
        self thread doMagicBullet();
        self iprintlnbold("Modded Bullets ^5ON");
    }
    else
    {
        self.mBulletOn=0;
        self notify("stop_magicBullet");
        self iprintlnbold("Modded Bullets ^4OFF");
    }
}
doMagicBullet()
{
	level endon("game_ended");
	self endon("death");
    self endon("disconnect");
    self endon("stop_magicBullet");
    self endon("destroyMenu");
    for(;;)
    {
        self waittill("weapon_fired");
        MagicBullet(self.selectMB, self getEye(), self traceBullet(), self);
    }
}
doModelBullets()
{
	if(self.mbullets==false)
	{
		self.mBulletOn=0;
        self notify("stop_magicBullet");
        self.mLTOn=0;
        self notify("stop_magicLT");
        self.mFX=0;
        self notify("GiveNewWeapon");
		self doChangeBullet("t6_wpn_supply_drop_ally", 4);
		self thread modelBullets();
		self.mbullets=true;
		self iprintlnbold("Model Bullets ^5ON");
	}
	else
	{
		self notify("stop_Mbullets");
		self.mbullets=false;
		self iprintlnbold("Model Bullets ^4OFF");
	}
}
modelBullets()
{
	level endon("game_ended");
    self endon("death");
    self endon("disconnect");
	self endon("stop_Mbullets");
	self endon("destroyMenu");
	while(1)
	{
		self waittill ("weapon_fired");
		forward=self getTagOrigin("j_head");
		end=self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		SPLOSIONlocation=BulletTrace(forward, end, 0, self)["position"];
        M=spawn("script_model",SPLOSIONlocation);
		M setModel(self.selectMDB);
	}
}
doChangeBullet(weap, bullet)
{
	if(bullet==1)
    	self.selectMFX=weap;
    if(bullet==2)
    	self.selectMLT=weap;
    if(bullet==3)
    	self.selectMB=weap;
    if(bullet==4)
    	self.selectMDB=weap;
    self iprintln("Bullet: ^5"+weap);
}
doRealCPBullets()
{
	if(self isHost())
	{
		if(self.bullets4==false)
		{
			self thread careMaker();
			self.bullets4=true;
			self iprintln("Real Care Package Bullets ^5ON");
		}
		else
		{
			self notify("stop_bullets4");
			self.bullets4=false;
			self iprintln("Real Care Package Bullets ^4OFF");
		}
	}
	else
		self iprintln("You must be ^2Host^7 to do that");
}
careMaker()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("death");
    self endon("stop_bullets4");
    self endon("destroyMenu");
	for(;;)
	{
		self waittill ("weapon_fired");	
        start=self gettagorigin("tag_eye");
		end=anglestoforward(self getPlayerAngles()) * 1000000;
		destination=BulletTrace(start, end, true, self)["position"];
		self thread maps\mp\killstreaks\_supplydrop::dropcrate(destination, self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
		wait 1;
	}
}
initNukeBullets()
{
    if(self.NukeBulletsOn==0)
    {
        self.NukeBulletsOn=1;
        self thread doNukeBullets();
        self iprintln("Nuke Bullets ^5ON");
    }
    else
    {
        self.NukeBulletsOn=0;
        self notify("stop_nukeBullets");
  		self iprintln("Nuke Bullets ^4OFF");
    }
}
doNukeBullets()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("stop_nukeBullets");
	self endon("destroyMenu");
	for(;;)
	{
		self waittill ("weapon_fired");
		forward=self getTagOrigin("j_head");
		end=vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
		ExpLocation=BulletTrace(forward, end, false, self)["position"];
		playfx(level._effect["fx_mp_nuked_final_explosion"], ExpLocation);
		playfx(level._effect["fx_mp_nuked_final_dust"], ExpLocation);
		earthquake(0.6, 8.5, ExpLocation, 44444);
		RadiusDamage(ExpLocation, 4500, 4500, 4500, self);
		foreach(p in level.players)
			p playsound("amb_end_nuke");
		wait 0.05;
	}
}
initEMPBullets()
{
    if(self.EMPBulletsOn==0)
    {
        self.EMPBulletsOn=1;
        self thread doEMPBullets();
        self iprintln("EMP Bullets ^5ON");
    }
    else
    {
        self.EMPBulletsOn=0;
        self notify("stop_EMPBullets");
		self iprintln("EMP Bullets ^4OFF");
    }
}
doEMPBullets()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("stop_EMPBullets");
	self endon("destroyMenu");
	for(;;)
	{
		self waittill ("weapon_fired");
		forward=self getTagOrigin("j_head");
		end=vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
		ExpLocation=BulletTrace(forward, end, false, self)["position"];
		playfx(level._effect["emp_flash"], ExpLocation);
		earthquake(0.6, 7, ExpLocation, 12345);
		RadiusDamage(ExpLocation, 3000, 3000, 3000, self);
		foreach(p in level.players)
			p playsound("wpn_emp_bomb");
		wait 0.05;
	}
}
ToggleTeleportGun()
{
    if(self.TPG==true)
    {
        self thread TeleportGun();
        self iprintln("^7Teleport Gun ^5ON");
        self.TPG=false;
    }
    else
    {
        self notify("Stop_TP");
        self iprintln("^7Teleport Gun ^4OFF");
        self.TPG=true;
    }
}
TeleportGun()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("death");
    self endon("Stop_TP");
    self endon("destroyMenu");
    for(;;)
    {
    	self waittill("weapon_fired");
    	self setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);
    }
}
spawnDog(team)
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("death");
    self endon("stop_realdogs");
	if(self isHost())
	{
		self.dogModel = "german_shepherd";
		self.dModCycle=0;
    	self.realdog=booleanOpposite(self.realdog);
    	self iprintln(booleanReturnVal(self.realdog, "Real Dog Bullets ^4OFF", "Real Dog Bullets ^5ON"));
    	if(self.realdog)
    	{
        	for(;;)
        	{
            	self waittill("weapon_fired");
            	dog_spawner=GetEnt("dog_spawner", "targetname");
            	level.dog_abort=false;
            	if(!IsDefined(dog_spawner))
            	{
                	self iprintln("No dog spawners found in map");
                	return;
            	}
            	direction=self GetPlayerAngles();
           		direction_vec=AnglesToForward(direction);
            	eye=self GetEye();
            	scale=8000;
            	direction_vec=(direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
            	trace=bullettrace(eye, eye + direction_vec, 0, undefined);
            	nodes=GetNodesInRadius(trace["position"], 256, 0, 128, "Path", 8); 
            	if(!nodes.size)
            	{
                	self iprintln("No nodes found near crosshair position");
                	return;
            	}
            	self iprintln("Spawning dog at your crosshair position");
            	node=getclosest(trace["position"], nodes);
            	dog=dog_manager_spawn_dog(self, self.team, node, 5);
        		dog setModel(self.dogModel);
        	}
    	}
    	else
    		self notify("stop_realdogs");
    }
    else
    	self iprintln("You must be ^2Host^7 to do that");
}
setDogModel()
{
	if(self.dModCycle==0)
	{
		self.dogModel = self.model;
		self.dModCycle = 1;
	}
	else if(self.dModCycle==1)
	{
		self.dogModel = "defaultactor";
		self.dModCycle = 2;
	}
	else if(self.dModCycle==2)
	{
		self.dogModel = "defaultvehicle";
		self.dModCycle = 3;
	}
	else if(self.dModCycle==3)
	{
		self.dogModel = "t6_wpn_turret_sentry_gun";
		self.dModCycle = 4;
	}
	else if(self.dModCycle==4)
	{
		self.dogModel = "veh_t6_drone_uav";
		self.dModCycle = 5;
	}
	else if(self.dModCycle==5)
	{
		self.dogModel = "german_shepherd";
		self.dModCycle = 0;
	}
	self iprintln("Dog Model: ^5" + self.dogModel);
}
ExpBultOn()
{
	self.explo=booleanOpposite(self.explo);
	self iprintln(booleanReturnVal(self.explo,"Explosive Bullets ^4OFF","Explosive Bullets ^5ON"));
	if(self.explo)
		self thread doExplosiveBullets();
	else
		self notify("stop_ExpBult");
}
doExplosiveBullets()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("stop_ExpBult");
	self endon("death");
	self endon("destroyMenu");
	for(;;)
	{
		self waittill("weapon_fired");
		forward=self getTagOrigin("j_head");
		end=vectorScale(anglestoforward(self getPlayerAngles()),1000000);
		ExpLocation=BulletTrace(forward,end,false,self)["position"];
		playfx(level._effect["rcbombexplosion"],ExpLocation);
		RadiusDamage(ExpLocation,300,500,50,self);
		wait 0.05;
	}
}
playerNoFXExp(player)
{
	if(!player isHost())
	{
		if(player.NoFXExpBult==true)
    	{
    		player thread noFXExpBultOn();
        	self iprintln(player.name+" ^5now has^7 No FX Explosive Bullets");
    	}
    	else
    	{
    		player notify("stop_nFXExpBult");
    		player.NoFXExpBult=true;
    		player.nfxexplo=false;
    		player iprintln("No FX Explosive Bullets ^4OFF");
        	self iprintln(player.name+" ^4no longer has^7 No FX Explosive Bullets");
    	}
    }
    else
    	self iprintln("You cannot give the ^2Host ^7No FX Explosive Bullets");
}
noFXExpBultOn()
{
	self.nfxexplo=booleanOpposite(self.nfxexplo);
	self iprintln(booleanReturnVal(self.nfxexplo,"No FX Explosive Bullets ^4OFF","No FX Explosive Bullets ^5ON"));
	if(self.nfxexplo)
		self thread doNoFXExplosiveBullets();
	else
		self notify("stop_nFXExpBult");
}
doNoFXExplosiveBullets()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("stop_nFXExpBult");
	self endon("death");
	self endon("destroyMenu");
	for(;;)
	{
		self waittill("weapon_fired");
		forward=self getTagOrigin("j_head");
		end=vectorScale(anglestoforward(self getPlayerAngles()),1000000);
		ExpLocation=BulletTrace(forward,end,false,self)["position"];
		RadiusDamage(ExpLocation,300,500,50,self);
		wait 0.05;
	}
}
initGiveWeap(code, name, camo, enab)
{
	if(camo==0)
		self giveWeapon(code, 0, false);
	else
		self giveWeapon(code, 0, true(camo, 0, 0, 0, 0));
	self switchToWeapon(code);
	self givemaxammo(code);
	self setWeaponAmmoClip(code, weaponClipSize(self getCurrentWeapon()));
	if(enab==1)
		self iprintlnbold("^5Gave Weapon!");
}
giveWeapon(weapon)
{
	self giveWeapon(weapon);
	self switchToWeapon(weapon);
	self setWeaponAmmoClip(weapon, weaponClipSize(self getCurrentWeapon()));
}
shootvadertog()
{
	self.deathrock=booleanOpposite(self.deathrock);
	self iprintln(booleanReturnVal(self.deathrock,"Death Rocket Gun ^4OFF","Death Rocket Gun ^5ON"));
	if(self.deathrock)
		self thread ShootVader();
	else
	{
		self notify("sex");
		self takeWeapon("870mcs_mp+extbarrel");
	}
}
ShootVader()
{
	level endon("game_ended");
    self endon("death");
    self endon("sex");
    self endon("disconnect");
    self endon("destroyMenu");
    self giveWeapon("870mcs_mp+extbarrel",0,true(29,0,0,0,0));
    self switchToWeapon("870mcs_mp+extbarrel");
    self givemaxammo("870mcs_mp+extbarrel");
    for(;;)
    {
     	self waittill("weapon_fired");
	    if(self getcurrentweapon()=="870mcs_mp+extbarrel") 
	    {
	    	l=self getTagOrigin("tag_eye");
	    	lb=spawnHelicopter(self, l, self.angles + (0,180,0), "heli_guard_mp", "projectile_sa6_missile_desert_mp");
	    	if(!isDefined(lb))return;
	    	lb.owner=self;
	    	lb.team=self.team;
	    	self thread x_DaftVader_xxx(lb);
	    	n=BulletTrace(self getTagOrigin("tag_eye"),anglestoforward(self getPlayerAngles())* 100000,0,self)["position"];
	    	lb SetSpeed(5000, 80);
	    	lb setVehGoalPos(n);
	    	wait 0.05;
        }
    }
}
x_DaftVader_xxx(lb)
{
	self endon("disconnect");
	self endon("death");
	self endon("sex");
	wait 1.22;
	playfx(level.chopper_fx["explode"]["large"],lb.origin);
	lb playSound("mpl_lightning_flyover_boom");
	RadiusDamage(lb.origin,300,300,1500,self);
	wait 0.1;
	lb delete();
}
traceBullet()
{
	return bulletTrace(self getEye(), self getEye()+vectorScale(anglesToForward(self getPlayerAngles()), 1000000), false, self)["position"];
}
initRaygun()
{
	if(self.isRaygun==0)
	{
		self initGiveWeap("judge_mp+reflex", "", 43, 0);
		self thread doRaygun();
		self iprintln("Raygun ^5ON");
		self thread oCM("You get the ^2Raygun^7!!", 1, "^7Is this ^0Zombies?", (0.243, 0.957, 0.545), 8);
		self.isRaygun=1;
	}
	else
	{
		self notify("stop_Raygun");
		self notify("stop_RaygunFX");
		self takeWeapon("judge_mp+reflex");
		self iprintln("Raygun ^4OFF");
		self.isRaygun=0;
	}
}
doRaygun()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("stop_Raygun");
	self endon("destroyMenu");
	self thread waitRaygunSuicide();
	for(;;)
	{
		self waittill("weapon_fired");
		if(self getCurrentWeapon()=="judge_mp+reflex" || self getCurrentWeapon()=="kard_mp+reflex")
			self thread mainRaygun();
	}
}
mainRaygun()
{
	raygunExplode=loadfx("weapon/emp/fx_emp_explosion_equip");
	raygunExplode2=loadfx("explosions/fx_exp_equipment_lg");
	weapOrigin=self getTagOrigin("tag_weapon_right");
	target=self traceBullet();
	raygunMissile=spawn("script_model", weapOrigin);
	raygunMissile setModel("projectile_at4");
	raygunMissile.killcament=raygunMissile;
	endLocation=BulletTrace(raygunMissile.origin, target, false, self)["position"];
	raygunMissile.angles=VectorToAngles(endLocation - raygunMissile.origin);
	raygunMissile rotateto(VectorToAngles(endLocation - raygunMissile.origin), 0.001);
	raygunMissile moveto(endLocation, 0.55);
	self thread raygunEffect(raygunMissile, endLocation);
	wait 0.556;
	self notify("stop_RaygunFX");
	playfx(raygunExplode, raygunMissile.origin);
	playfx(raygunExplode2, raygunMissile.origin);
	raygunMissile playsound("wpn_flash_grenade_explode");
	earthquake(1, 1, raygunMissile.origin, 300);
	raygunMissile RadiusDamage(raygunMissile.origin, 200, 200, 200, self);
	raygunMissile delete();
}
raygunEffect(object, target)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("stop_RaygunFX_Final");
	self endon("stop_Raygun");
	self endon("destroyMenu");
	raygunLaser=loadFX("misc/fx_equip_tac_insert_light_grn");
	for(;;)
	{
		raygunGreen=spawnFx(raygunLaser, object.origin, VectorToAngles(target - object.origin));
		triggerFx(raygunGreen);
		wait 0.0005;
		raygunGreen delete();
	}
	for(;;)
	{
		self waittill("stop_RaygunFX");
		effect delete();
		self notify("stop_RaygunFX_Final");
	}
}
waitRaygunSuicide()
{
	self waittill("death");
	self notify("stop_Raygun");
	self notify("stop_RaygunFX");
	self.isRaygun=0;
}
ThunGun()
{
    self endon("disconnect");
    self endon ("death");
    namezy=self;
    self giveWeapon("ksg_mp", 7, false);
    self switchToWeapon("ksg_mp");
    self setWeaponAmmoStock("ksg_mp", 0);
    self setWeaponAmmoClip("ksg_mp", 1);
    self iprintlnbold("^5ForceBlast ^2Ready!^7 Shots Remaining: ^48");
    for(j=8; j > 0; j--)
    {
        self waittill ("weapon_fired");
		if(self getCurrentWeapon()=="ksg_mp")
        {	
	    	forward=self getTagOrigin("j_head");
	    	end=vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
	    	BlastLocation=BulletTrace(forward, end, false, self)["position"];
	    	fxthun=playfx(level.bettydestroyedfx, self getTagOrigin("tag_weapon_right"));
	    	fxthun.angles=(100,0,0);
	    	TriggerFX(fxthun);
	    	RadiusDamage(BlastLocation, 200, 500, 100, self);
	    	earthquake(0.9, 0.9, self.origin, 600);
	    	PlayRumbleOnPosition("grenade_rumble", self.origin);
	    	foreach(player in level.players)
	    	{
            	if(player.team!=self.team)
            	{
                	if(Distance(self.origin, player.origin) < 600)
		        		player thread ThunDamage();
             	}
         	}
	     	self switchToWeapon("ksg_mp");
	    	wait 0.8;
	     	wait .5;
	     	bulletz=(j - 1);
	     	self iprintlnbold("^5ForceBlast ^2Ready!^7 Shots Remaining: ^4"+ bulletz);
	     	self setWeaponAmmoStock("ksg_mp", 0);
	     	self setWeaponAmmoClip("ksg_mp", 1);
	     	self switchToWeapon("ksg_mp");
	 	}	
     	else
		 	j++;
    }
	self takeWeapon("ksg_mp");
	wait 2;
	self notify("THUNGONE");
}
ThunDamage()
{
    self endon("disconnect");
    for(m=4; m > 0; m--)
    {	
        self setvelocity(self getvelocity()+(250,250,250));
		wait .1;
    }
    self setvelocity(0,0,0);
    wait 7;
}
ToggleMustangGun()
{
	self.mustG=booleanOpposite(self.mustG);
	self iprintln(booleanReturnVal(self.mustG, "Mustang And Sally ^4OFF", "Mustang And Sally ^5ON"));
    if(self.TMG==true || self.mustG)
    {
        self thread mustangbro();
        self.TMG=false;
    }
    else
    {
        self notify("Stop_TMP");
        self takeWeapon("fnp45_dw_mp");
        self.TMG=true;
    }
}
mustangbro()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("Stop_TMP");
    self endon("death");
    self endon("destroyMenu");
    self giveWeapon("fnp45_dw_mp", 0, true (39, 0, 0, 0, 0));
	self switchtoweapon("fnp45_dw_mp");
	self givemaxammo("fnp45_dw_mp");
	self.erection +=1;
	if(self.erection==1)
		self.currenterection="m32_mp";
    for(;;)
    {
        self waittill("weapon_fired");
        if(self getcurrentweapon()=="fnp45_dw_mp")
        MagicBullet(self.currenterection, self getEye(), self traceBullet(), self);
    }
}
initRaygunM2()
{
    if(self.isRaygunM2==0)
    {
        self initGiveWeap("beretta93r_mp+reflex", "", 38, 0);
        self thread doRaygunM2();
        self iprintln("Raygun Mk. II ^5ON");
        self thread oCM("Wow!! ^1Ray Gun Mk. 2?!", 1, "^7Upgraded Weapon ^1LOL", (1, 0.502, 0.251), 8);
        self.isRaygunM2=1;
    }
    else
    {
        self notify("stop_RaygunM2");
        self notify("stop_RaygunM2FX");
        self takeWeapon("beretta93r_mp+reflex");
        self iprintln("Raygun Mk. II ^4OFF");
        self.isRaygunM2=0;
    }
}
doRaygunM2()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("stop_RaygunM2");
    self endon("destroyMenu");
    self thread waitRaygunM2Suicide();
    for(;;)
    {
       self waittill("weapon_fired");
       if(self getCurrentWeapon()=="beretta93r_mp+reflex")
          self thread mainRaygunM2();
    }
}            
mainRaygunM2()
{
    raygunM2Explode=loadfx("weapon/bouncing_betty/fx_betty_destroyed");
    raygunM2Explode2=loadfx("weapon/tracer/fx_tracer_flak_single_noExp");
    weapOrigin=self getTagOrigin("tag_weapon_right");
    target=self traceBullet();
    raygunM2Missile=spawn("script_model", weapOrigin);
    raygunM2Missile setModel("projectile_at4");
    raygunM2Missile.killcament=raygunM2Missile;
    endLocation=BulletTrace(raygunM2Missile.origin, target, false, self)["position"];
    raygunM2Missile.angles=VectorToAngles(endLocation - raygunM2Missile.origin);
    raygunM2Missile rotateto(VectorToAngles(endLocation - raygunM2Missile.origin), 0.001);
    raygunM2Missile moveto(endLocation, 0.3);
    self thread raygunM2Effect(raygunM2Missile, endLocation);
    wait 0.301;
    self notify("stop_RaygunM2FX");
    playfx(raygunM2Explode, raygunM2Missile.origin);
    playfx(raygunM2Explode2, raygunM2Missile.origin);
    raygunM2Missile playsound("wpn_flash_grenade_explode");
    earthquake(1, 1, raygunM2Missile.origin, 300);
    raygunM2Missile RadiusDamage(raygunM2Missile.origin, 270, 270, 270, self);
    raygunM2Missile delete();
}
raygunM2Effect(object, target)
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("stop_RaygunM2FX_Final");
    self endon("stop_RaygunM2");
    self endon("destroyMenu");
    raygunM2Laser=loadFX("misc/fx_equip_tac_insert_light_red");
    for(;;)
    {
        raygunM2Red=spawnFx(raygunM2Laser, object.origin, VectorToAngles(target - object.origin));
        triggerFx(raygunM2Red);
        wait 0.0005;
        raygunM2Red delete();
    }
    for(;;)
    {
        self waittill("stop_RaygunM2FX");
        raygunM2Red delete();
        self notify("stop_RaygunM2FX_Final");
    }
}
waitRaygunM2Suicide()
{
    self waittill("death");
    self notify("stop_RaygunM2");
    self notify("stop_RaygunM2FX");
    self.isRaygunM2=0;
}
givecamo(camo)
{
	weap=self getCurrentWeapon();
	self takeWeapon(self getCurrentWeapon());
	self giveWeapon(weap, 0, true (camo, 0, 0, 0, 0));
	self switchToWeapon(weap);
	self iprintln("^5Camo received^7: #"+camo);
}
initRocketTeleport()
{
	if(self.rocketTeleOn==0)
	{
		self iprintln("Rocket Teleporter ^5ON\n^1Fire RPG, ^3you can ^4fly!");
		self initGiveWeap("usrpg_mp", "", 0);
		self thread doRocketTeleport();
		if(self.god==0)
			self enableInvulnerability();
		self.rocketTeleOn=1;
	}
	else
	{
		self iprintln("Rocket Teleporter ^4OFF");
		self notify("stop_rocketTele");
		if(self.god==0)
			self disableInvulnerability();
		self takeWeapon("usrpg_mp");
		self.rocketTeleOn=0;
	}
}
doRocketTeleport()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("stop_rocketTele");
	for(;;)
	{
		self waittill("missile_fire", weapon, weapname);
		if(weapname=="usrpg_mp")
		{
			self PlayerLinkTo(weapon);
			weapon waittill("death");
			self detachAll();
		}              
		wait 0.05;
	}
}
toggleknifetele()
{
	self.tknifet=booleanOpposite(self.tknifet);
	self iprintln(booleanReturnVal(self.tknifet,"Ballistic Teleporter ^4OFF","Ballistic Teleporter ^5ON"));
	if(self.tknifet)
		self thread knifeTeleportGun();
	else
	{
		self notify("disableknifeGun");
		self Takeweapon("knife_ballistic_mp");
	}
}
knifeTeleportGun()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("disableknifeGun");
	self endon("death");
	self endon("destroyMenu");
	self giveWeapon("knife_ballistic_mp",0,true(43,0,0,0,0));
	self switchToWeapon("knife_ballistic_mp");
	self givemaxammo("knife_ballistic_mp");
	for(;;)
	{
		self waittill("missile_fire",weapon,weapname);
		if(weapname=="knife_ballistic_mp")
		{
			self detachAll();
			self PlayerLinkTo(weapon);
			weapon waittill("death");
			self detachAll();
		}
		wait 0.05;
	}
}
defaultweapon()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("death");
    self endon("stop_defaultweapon");
    self endon("destroyMenu");
    if(self.defweap==0)
    {
        self.defweap=1;
        self thread stopdefaultweapon();
        self disableusability();
        self disableweaponcycling();
        self giveWeapon("defaultweapon_mp");
        self switchToWeapon("defaultweapon_mp");
        self giveMaxAmmo("defaultweapon_mp");
        self iprintln("Default Weapon ^5ON\n^1Press [{+weapnext_inventory}] to stop defaultweapon_mp");
        for(;;)
        {
            self waittill("weapon_fired");
            forward=anglestoforward(self getplayerangles());
            start=self geteye();
            end=vectorscale(forward, 9999);
            magicbullet("remote_missile_bomblet_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
        }
    }
    else
        self iprintln("^1There can only be 1 default weapon at a time");
}
stopdefaultweapon()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("death");
    self endon("stop_defaultweapon");
    self endon("destroyMenu");
    for(;;)
    {
        if(self changeseatbuttonpressed())
        {
            self.defweap=0;
            self takeweapon("defaultweapon_mp");
            self iprintln("Default Weapon ^4OFF");
            self enableusability();
            self enableweaponcycling();
            self notify("stop_defaultweapon");
        }
        wait 0.05;
    }
}
initRaygunM3()
{
    if(self.isRaygunM3==0)
    {
        self initGiveWeap("kard_mp+reflex", "", 39, 0);
        self thread doRaygunM3();
        self iprintln("Raygun Mk. III ^5ON");
        self thread oCM("^3Upgrade WoW!", 1, "^1Rapid Fire ^5Beast!", (1, 0.502, 0.251), 8);
        self.isRaygunM3=1;
    }
    else
    {
        self notify("stop_RaygunM3");
        self notify("stop_RaygunM3FX");
        self takeWeapon("kard_mp+reflex");
        self iprintln("Raygun Mk. III ^4OFF");
        self.isRaygunM3=0;
    }
}
doRaygunM3()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("stop_RaygunM3");
    self endon("destroyMenu");
    self thread waitRaygunM3Suicide();
    for(;;)
    {
        self waittill("weapon_fired");
        if(self getCurrentWeapon()=="kard_mp+reflex")
            self thread mainRaygunM3();
    }
}
mainRaygunM3()
{
    raygunM3Explode=loadfx("weapon/bouncing_betty/fx_betty_destroyed");
    raygunM3Explode2=loadfx("weapon/tracer/fx_tracer_flak_single_noExp");
    weapOrigin=self getTagOrigin("tag_weapon_right");
    target=self traceBullet();
    raygunM3Missile=spawn("script_model", weapOrigin);
    raygunM3Missile setModel("projectile_at4");
    raygunM3Missile.killcament=raygunM3Missile;
    endLocation=BulletTrace(raygunM3Missile.origin, target, false, self)["position"];
    raygunM3Missile.angles=VectorToAngles(endLocation - raygunM3Missile.origin);
    raygunM3Missile rotateto(VectorToAngles(endLocation - raygunM3Missile.origin), 6.001);

    raygunM3Missile moveto(endLocation, 0.3);
    self thread raygunM3Effect(raygunM3Missile, endLocation);
    wait 0.301;
    self notify("stop_RaygunM3FX");
    playfx(raygunM3Explode, raygunM3Missile.origin);
    playfx(raygunM3Explode2, raygunM3Missile.origin);
    raygunM3Missile playsound("wpn_flash_grenade_explode");
    earthquake(3, 3, raygunM3Missile.origin, 300);
    raygunM3Missile RadiusDamage(raygunM3Missile.origin, 770, 770, 770, self);
    raygunM3Missile delete();
}
raygunM3Effect(object, target)
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("stop_RaygunM3FX_Final");
    self endon("stop_RaygunM3");
    self endon("destroyMenu");
    raygunM3Laser=loadFX("misc/fx_equip_tac_insert_light_red");
    for(;;)
    {
        raygunM3Red=spawnFx(raygunM3Laser, object.origin, VectorToAngles(target - object.origin));
        triggerFx(raygunM3Red);
        wait 0.0005;
        raygunM3Red delete();
    }
    for(;;)
    {
        self waittill("stop_RaygunM3FX");
        raygunM3Red delete();
        self notify("stop_RaygunM3FX_Final");
    }
}
waitRaygunM3Suicide()
{
    self waittill("death");
    self notify("stop_RaygunM3");
    self notify("stop_RaygunM3FX");
    self.isRaygunM3=0;
}
CrazyRiotShield()
{
	if(self.AguaLoca==0)
	{
		self initGiveWeap("riotshield_mp", "", 44, 0);
		self switchToWeapon("riotshield_mp");
		self thread fuckrebbecablack();
		self PlaySoundToPlayer("mus_lau_rank_up",self);
		self iprintln("Water Shield ^5ON\n^1[{+melee}] to use");
		self thread oCM("^5WATER UP IN THIS Bitch", 1, "^4Hatez ^0EDITION", (.3671, .101, .432), 8);
		self.AguaLoca=1;
	}
	else
	{
		self notify("stop_ithurts");
		self notify("stop_ithurtsFX");
		self takeWeapon("riotshield_mp");
		self PlaySoundToPlayer("exp_barrel",self);
		self iprintln("Water Shield ^4OFF");
		self.AguaLoca=0;
	}
}
fuckrebbecablack()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("stop_ithurts");
	self endon("destroyMenu");
	self thread mecojes();
	for(;;)
	{
		if(self getCurrentWeapon()=="riotshield_mp")
			self thread LetsStartThis();
		wait 0.01;
	}
}
LetsStartThis()
{
	if(self meleeButtonPressed())
    {
    	SuperRiot=loadfx("impacts/fx_xtreme_water_hit_mp");
        SuperRiot2=loadfx("weapon/rocket/fx_rocket_exp_water_shallow_mp");
        weapOrigin=self getTagOrigin("tag_weapon_right");
        target=self traceBullet();
        AguaDePuta=spawn("script_model", weapOrigin);
        AguaDePuta setModel("t5_veh_rcbomb_gib_large");
        AguaDePuta.killcament=AguaDePuta;
        endLocation=BulletTrace(AguaDePuta.origin, target, false, self)["position"];
        AguaDePuta.angles=VectorToAngles(endLocation - AguaDePuta.origin);
        AguaDePuta rotateto(VectorToAngles(endLocation - AguaDePuta.origin), 0.001);
        AguaDePuta moveto(endLocation, 0.3);
        self thread ChapoWereRU(AguaDePuta, endLocation);
        wait 0.321;
        self notify("stop_ithurtsFX");
        playfx(SuperRiot, AguaDePuta.origin);
        playfx(SuperRiot2, AguaDePuta.origin);
        AguaDePuta playsound("prj_bullet_impact_headshot_helmet_nodie");
        earthquake(1, 1, AguaDePuta.origin, 400);
        AguaDePuta RadiusDamage(AguaDePuta.origin, 270, 290, 280, self);
        AguaDePuta delete();
    }
}
ChapoWereRU(object, target)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("stop_ithurtsFX_Final");
	self endon("stop_ithurts");
	self endon("destroyMenu");
	aguatrail=loadfx("weapon/tank/fx_tank_water_mp");
	aguatrail2=loadfx("system_elements/fx_snow_sm_em");
	aguatrail3=LoadFx("impacts/fx_ap_waterhit");
	for(;;)
	{
		blazeit420=spawnFx(aguatrail, object.origin, VectorToAngles(target - object.origin));
		triggerFx(blazeit420);
		wait 0.0005;
		smokeUs=spawnFx(aguatrail2, object.origin, VectorToAngles(target - object.origin));
		triggerFx(smokeUs);
		wait 0.0007;
		fuckcarolina=spawnFx(aguatrail3, object.origin, VectorToAngles(target - object.origin));
		triggerFx(fuckcarolina);
		wait 0.0009;
		blazeit420 delete();
		smokeUs delete();
		fuckcarolina delete();
	}
	for(;;)
	{
		self waittill("stop_ithurtsFX");
		blazeit420 delete();
		smokeUs delete();
		fuckcarolina delete();
		self notify("stop_ithurtsFX_Final");
	}
}
mecojes()
{
	self waittill("death");
	self notify("stop_ithurts");
	self notify("stop_ithurtsFX");
	self.AguaLoca=0;
}
ToggleDragonGun()
{
    self.Db=booleanOpposite(self.Db);
	self iprintln(booleanReturnVal(self.Db,"Dragons Breath ^4OFF","Dragons Breath ^5ON"));
	if(self.Db)
		self thread DragonGun();
	else
	{
	    self notify("TDBend");
	    self takeWeapon("svu_mp+acog");
    }
}
DragonGun()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("TDBend");
	self endon("death");
	self endon("destroyMenu");
	self giveWeapon("svu_mp+acog",0,true(32,0,0,0,0));
	self switchtoweapon("svu_mp+acog");
	self givemaxammo("svu_mp+acog");
	for(;;)
	{
		self waittill("weapon_fired");
		if(self getcurrentweapon()=="svu_mp+acog") 
		MagicBullet("ai_tank_drone_rocket_mp",self getEye(),self traceBullet(),self);
	}
}
toggle_lightGun()
{
	self.lightstuf=booleanOpposite(self.lightstuf);
	self iprintln(booleanReturnVal(self.lightstuf,"Electric Gun ^4OFF","Electric Gun ^5ON"));
	if(self.lightstuf)
	{
		self thread lightGun();
		self.lightgun=false;
	}
	else
	{
	    self.lightgun=true;
	    self notify("lightgunend");
	    self takeWeapon("vector_mp+silencer");
	}
}
lightGun()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("lightgunend");
	self endon("WeaponChanged");
	self endon("destroyMenu");
	self giveWeapon("vector_mp+silencer",0,true(44,0,0,0,0));
	self switchToWeapon("vector_mp+silencer");
	lightupgun=loadfx("weapon/emp/fx_emp_explosion_equip");
	for(;;)
	{
		self waittill("weapon_fired");
		if(self getCurrentWeapon()=="vector_mp+silencer")
		{
			vec2=anglestoforward(self getPlayerAngles());
			e1nd=(vec2[0] * 200000,vec2[1] * 200000,vec2[2] * 200000);
			SPLOSIONlocation1=BulletTrace(self gettagorigin("tag_eye"),self gettagorigin("tag_eye")+ e1nd,0,self)["position"];
			playfx(lightupgun,SPLOSIONlocation1);
			RadiusDamage(SPLOSIONlocation1,80,80,80,self);
			earthquake(0.3,1,SPLOSIONlocation1,150);
		}
		wait 0.001;
	}
}
initSuperMagnum()
{
	if(self.supermagnum==0)
	{
		self iprintln("Super Magnum ^5ON");
		self initGiveWeap("judge_mp", "", 0);
		self thread doSuperMagnum();
		if(self.god==0)
			self enableInvulnerability();
		self allowAds(false);
		self.supermagnum=1;
	}
	else
	{
		self iprintln("Super Magnum ^4OFF");
		self notify("stop_superm");
		self takeWeapon("judge_mp");
		if(self.god==0)
			self disableInvulnerability();
		self allowAds(true);
		self.supermagnum=0;
	}
}
doSuperMagnum() 
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("death"); 
    self endon("stop_superm");
    self endon("destroyMenu");
    for(;;)
    { 
        self waittill("weapon_fired"); 
        self playsound("wpn_weap_pickup_plr"); 
        my=self gettagorigin("j_head"); 
        trace=bullettrace(my,my+anglestoforward(self getplayerangles())*100000,true,self)["position"];
        playfx(level.expbullit,trace); 
        self playSound("phy_impact_soft_metal"); 
        Earthquake(0.6,3,self.origin,100);
        dis=distance(self.origin,trace); 
        if(dis<101)RadiusDamage(trace,dis,800,800,self); 
        RadiusDamage(trace,800,800,800,self); 
   }
}
unlockLobby()
{
	if(!level.unlockingLobby)
	{
		level.unlockingLobby = true;
		foreach(player in level.players)
		{
			if(!player.unlockRunning)
			{
				player.unlockRunning = true;
				player iprintln("Unlock All Lobby ^5ON");
				if(player isVerified())
				{
					player.menulocked = true;
					if(player.menu.open)
					{
						player thread closeMenu();
						wait .3;
					}
				}
				player thread drawRankUpHUD();
				if(player.pers["prestige"] == level.maxPrestige || player.pers["rank"] == level.maxRank)
				{
					player thread camonlock();
					player thread unlockEverything();
				}
			}
		}
	}
	else
	{
		level.unlockingLobby = false;
		self iprintln("Unlock All Lobby ^4OFF");
	}
}
drawRankUpHUD()
{
	if(self.pers["prestige"] == level.maxPrestige || self.pers["rank"] == level.maxRank)
	{
   		self.rankHUD["text1"] = self dT("^3Unlocking camos for", "default", 1.5, 0, 100, (1, 1, 1), 1, (0, 0, 1), 1, 51);
   		self.rankHUD["text2"] = self dT("^1Setting legit stats...", "default", 1.5, 0, 120, (1, 1, 1), 1, (0, 0, 1), 1, 51);
		self.rankHUD["percent"] = self createText("default", 1.5, "", "", 60, -75, 51, 1);
		self.rankHUD["percent"].glowColor = (0, 0, 1);
		self.rankHUD["percent"].glowAlpha = 1;
		for(i = 0;i < 101;i++)
		{
			self.rankHUD["percent"] setValue(i);
			wait .17495;
		}
	}
	else
	{
		self.rankHUD["text1"] = self dT("Unlock All aborted, player is not Level 55/Master", "default", 1.5, 0, 100, (1, 0, 0), 1, (0, 0, 1), 1, 51);
		wait 3;
		self.rankHUD["text1"] destroy();
		if(self isVerified())
			self.menulocked = false;
	}
}
camonlock()
{
	self thread camoChallengeSG("870mcs_mp");
	wait .6;
	self thread camoChallengeAR("an94_mp");
	wait .6;
	self thread camoChallengeSniper("as50_mp");
	wait .6;
	self thread camoChallengeSniper("ballista_mp");
	wait .6;
	self thread camoChallengePistol("beretta93r_mp");
	wait .6;
	self thread camoChallengeCB("crossbow_mp");
	wait .6;
	self thread camoChallengeSniper("dsr50_mp");
	wait .6;
	self thread camoChallengeSMG("evoskorpion_mp");
	wait .6;
	self thread camoChallengePistol("fiveseven_mp");
	wait .6;
	self thread camoChallengeFHJ("fhj18_mp");
	wait .6;
	self thread camoChallengePistol("fnp45_mp");
	wait .6;
	self thread camoChallengeLMG("hamr_mp");
	wait .6;
	self thread camoChallengeAR("hk416_mp");
	wait .6;
	self thread camoChallengeSMG("insas_mp");
	wait .6;
	self thread camoChallengePistol("judge_mp");
	wait .6;
	self thread camoChallengePistol("kard_mp");
	wait .6;
	self thread camoChallengePistol("kard_wager_mp");
	wait .6;
	self thread camoChallengeBK("knife_ballistic_mp");
	wait .6;
	self thread camoChallengeCombatK("knife_held_mp");
	wait .6;
	self thread unlockallcamos("knife_mp");
	wait .6;
	self thread camoChallengeSG("ksg_mp");
	wait .6;
	self thread camoChallengeLMG("lsat_mp");
	wait .6;
	self thread camoChallengeLMG("mk48_mp");
	wait .6;
	self thread camoChallengeSMG("mp7_mp");
	wait .6;
	self thread camoChallengeSMG("pdw57_mp");
	wait .6;
	self thread camoChallengeSMG("peacekeeper_mp");
	wait .6;
	self thread camoChallengeLMG("qbb95_mp");
	wait .6;
	self thread camoChallengeSMG("qcw05_mp");
	wait .6;
	self thread camoChallengeRIOT("riotshield_mp");
	wait .6;
	self thread camoChallengeAR("sa58_mp");
	wait .6;
	self thread camoChallengeSG("saiga12_mp");
	wait .6;
	self thread camoChallengeAR("saritch_mp");
	wait .6;
	self thread camoChallengeSMG("vector_mp");
	wait .6;
	self thread camoChallengeAR("scar_mp");
	wait .6;
	self thread camoChallengeAR("sig556_mp");
	wait .6;
	self thread camoChallengeSMAW("smaw_mp");
	wait .6;
	self thread camoChallengeSG("srm1216_mp");
	wait .6;
	self thread camoChallengeSniper("svu_mp");
	wait .6;
	self thread camoChallengeAR("tar21_mp");
	wait .6;
	self thread camoChallengeAR("type95_mp");
	wait .6;
	self thread camoChallengeRPG("usrpg_mp");
	wait .6;
	self thread camoChallengeAR("xm8_mp");
	wait .6;
	self PlaySoundToPlayer("mpl_wager_humiliate", self);
	self.rankHUD["text1"] setSafeText("^2Unlock all complete!");
	wait 2;
	self.rankHUD["text1"] setSafeText("^1You will only get Diamond for weapons you have unlocked");
	self.rankHUD["text2"] destroy();
	wait 3;
	if(self isHost())
	{
		self.rankHUD["text1"] destroy();
		self.menulocked = false;
	}
	if(!self isHost())
	{
		self.rankHUD["text1"] setSafeText("^2You're welcome!");
		wait 2;
		self thread destroyMenu(self);
		self.menulocked = false;
		self.rankHUD["text1"] destroy();
		kick(self getentitynumber());
	}
}
unlockEverything()
{
	self addPlayerStat("score", 550000);
	wait .1;
	self addPlayerStat("time_played_total", 50000);
	wait .1;
	self addgametypestat("killstreak_10", 2244);
	wait .1;
	self addgametypestat("killstreak_15", 1542);
	wait .1;
	self addgametypestat("killstreak_20", 733);
	wait .1;
	self addgametypestat("killstreak_30", 72);
	wait .1;
	self addweaponstat("dogs_mp", "used", 21);
	wait .1;
	self addweaponstat("emp_mp", "used", 23);
	wait .1;
	self addweaponstat("missile_drone_mp", "used", 38);
	wait .1;
	self addweaponstat("missile_swarm_mp", "used", 13);
	wait .1;
	self addweaponstat("planemortar_mp", "used", 39);
	wait .1;
	self addweaponstat("killstreak_qrdrone_mp", "used", 39);
	wait .1;
	self addweaponstat("remote_missile_mp", "used", 28);
	wait .1;
	self addweaponstat("remote_mortar_mp", "used", 38);
	wait .1;
	self addweaponstat("straferun_mp", "used", 21);
	wait .1;
	self addweaponstat("supplydrop_mp", "used", 18);
	wait .1;
	self addweaponstat("ai_tank_drop_mp", "used", 12);
	wait .1;
	self addweaponstat("acoustic_sensor_mp", "used", 22);
	wait .1;
	self addweaponstat("qrdrone_turret_mp", "destroyed", 23);
	wait .1;
	self addweaponstat("rcbomb_mp", "destroyed", 21);
	wait .1;
	self addweaponstat("qrdrone_turret_mp", "used", 23);
	wait .1;
	self addweaponstat("rcbomb_mp", "used", 43);
	wait .1;
	self addweaponstat("microwaveturret_mp", "used", 13);
	wait .1;
	self addweaponstat("autoturret_mp", "used", 14);
	wait .1;
	self addweaponstat("helicopter_player_gunner_mp", "used", 17);
	wait .1;
	self addweaponstat("missile_drone_mp", "destroyed", 173);
	wait .1;
	self addweaponstat("missile_swarm_mp", "destroyed", 84);
	wait .1;
	self addweaponstat("planemortar_mp", "destroyed", 413);
	wait .1;
	self addweaponstat("killstreak_qrdrone_mp", "destroyed", 634);
	wait .1;
	self addweaponstat("remote_missile_mp", "destroyed", 535);
	wait .1;
	self addweaponstat("remote_mortar_mp", "destroyed", 824);
	wait .1;
	self addweaponstat("straferun_mp", "destroyed", 485);
	wait .1;
	self addweaponstat("supplydrop_mp", "destroyed", 556);
	wait .1;
	self addweaponstat("ai_tank_drop_mp", "destroyed", 302);
	wait .1;
	self addweaponstat("acoustic_sensor_mp", "destroyed", 1002);
	wait .1;
	self addweaponstat("microwaveturret_mp", "destroyed", 923);
	wait .1;
	self addweaponstat("autoturret_mp", "destroyed", 994);
	wait .1;
	self addweaponstat("helicopter_player_gunner_mp", "destroyed", 1017);
	wait .1;
	self addgametypestat("round_win_no_deaths", 831);
	wait .1;
	self addgametypestat("last_man_defeat_3_enemies", 323);
	wait .1;
	self addgametypestat("CRUSH", 623);
	wait .1;
	self addgametypestat("most_kills_least_deaths", 143);
	wait .1;
	self addgametypestat("SHUT_OUT", 434);
	wait .1;
	self addgametypestat("ANNIHILATION", 321);
	wait .1;
	self addgametypestat("kill_2_enemies_capturing_your_objective", 351);
	wait .1;
	self addgametypestat("capture_b_first_minute", 234);
	wait .1;
	self addgametypestat("immediate_capture", 346);
	wait .1;
	self addgametypestat("contest_then_capture", 692);
	wait .1;
	self addgametypestat("both_bombs_detonate_10_seconds", 56);
	wait .1;
	self addgametypestat("multikill_3", 294);
	wait .1;
	self addgametypestat("kill_enemy_who_killed_teammate", 3423);
	wait .1;
	self addgametypestat("kill_enemy_injuring_teammate", 511);
	wait .1;
	self addgametypestat("defused_bomb_last_man_alive", 245);
	wait .1;
	self addgametypestat("elimination_and_last_player_alive", 232);
	wait .1;
	self addgametypestat("killed_bomb_planter", 234);
	wait .1;
	self addgametypestat("killed_bomb_defuser", 341);
	wait .1;
	self addgametypestat("kill_flag_carrier", 131);
	wait .1;
	self addgametypestat("defend_flag_carrier", 112);
	wait .1;
	self addgametypestat("killed_bomb_planter", 162);
	wait .1;
	self addgametypestat("killed_bomb_defuser", 152);
	wait .1;
	self addgametypestat("kill_flag_carrier", 114);
	wait .1;
	self addgametypestat("defend_flag_carrier", 183);
	wait .1;
	self addplayerstat("reload_then_kill_dualclip", 823);
	wait .1;
	self addplayerstat("kill_with_remote_control_ai_tank", 628);
	wait .1;
	self addplayerstat("killstreak_5_with_sentry_gun", 152);
	wait .1;
	self addplayerstat("kill_with_remote_control_sentry_gun", 523);
	wait .1;
	self addplayerstat("killstreak_5_with_death_machine", 345);
	wait .1;
	self addplayerstat("kill_enemy_locking_on_with_chopper_gunner", 52);
	wait .1;
	self addplayerstat("kill_with_loadout_weapon_with_3_attachments", 523);
	wait .1;
	self addplayerstat("kill_with_both_primary_weapons", 652);
	wait .1;
	self addplayerstat("kill_with_2_perks_same_category", 134);
	wait .1;
	self addplayerstat("kill_while_uav_active", 824);
	wait .1;
	self addplayerstat("kill_while_cuav_active", 878);
	wait .1;
	self addplayerstat("kill_while_satellite_active", 524);
	wait .1;
	self addplayerstat("kill_after_tac_insert", 239);
	wait .1;
	self addplayerstat("kill_enemy_revealed_by_sensor", 54);
	wait .1;
	self addplayerstat("kill_while_emp_active", 423);
	wait .1;
	self addplayerstat("survive_claymore_kill_planter_flak_jacket_equipped", 235);
	wait .1;
	self addplayerstat("killstreak_5_dogs", 34);
	wait .1;
	self addplayerstat("kill_flashed_enemy", 453);
	wait .1;
	self addplayerstat("kill_concussed_enemy", 343);
	wait .1;
	self addplayerstat("kill_enemy_who_shocked_you", 232);
	wait .1;
	self addplayerstat("kill_shocked_enemy", 632);
	wait .1;
	self addplayerstat("shock_enemy_then_stab_them", 824);
	wait .1;
	self addplayerstat("mantle_then_kill", 874);
	wait .1;
	self addplayerstat("kill_enemy_with_picked_up_weapon", 822);
	wait .1;
	self addplayerstat("killstreak_5_picked_up_weapon", 564);
	wait .1;
	self addplayerstat("kill_enemy_shoot_their_explosive", 124);
	wait .1;
	self addplayerstat("kill_enemy_while_crouched", 1324);
	wait .1;
	self addplayerstat("kill_enemy_while_prone", 1182);
	wait .1;
	self addplayerstat("kill_prone_enemy", 1122);
	wait .1;
	self addplayerstat("kill_every_enemy", 1213);
	wait .1;
	self addplayerstat("pistolHeadshot_10_onegame", 1123);
	wait .1;
	self addplayerstat("headshot_assault_5_onegame", 143);
	wait .1;
	self addplayerstat("kill_enemy_one_bullet_sniper", 1754);
	wait .1;
	self addplayerstat("kill_10_enemy_one_bullet_sniper_onegame", 2341);
	wait .1;
	self addplayerstat("kill_enemy_one_bullet_shotgun", 415);
	wait .1;
	self addplayerstat("kill_10_enemy_one_bullet_shotgun_onegame", 321);
	wait .1;
	self addplayerstat("kill_enemy_with_tacknife", 961);
	wait .1;
	self addplayerstat("KILL_CROSSBOW_STACKFIRE", 241);
	wait .1;
	self addplayerstat("hatchet_kill_with_shield_equiped", 741);
	wait .1;
	self addplayerstat("kill_with_claymore", 361);
	wait .1;
	self addplayerstat("kill_with_hacked_claymore", 317);
	wait .1;
	self addplayerstat("kill_with_c4", 121);
	wait .1;
	self addplayerstat("kill_enemy_withcar", 341);
	wait .1;
	self addplayerstat("stick_explosive_kill_5_onegame", 121);
	wait .1;
	self addplayerstat("kill_with_cooked_grenade", 123);
	wait .1;
	self addplayerstat("kill_with_tossed_back_lethal", 155);
	wait .1;
	self addplayerstat("kill_with_dual_lethal_grenades", 123);
	wait .1;
	self addplayerstat("perk_movefaster_kills", 153);
	wait .1;
	self addplayerstat("perk_noname_kills", 112);
	wait .1;
	self addplayerstat("perk_quieter_kills", 1500);
	wait .1;
	self addplayerstat("perk_longersprint", 123);
	wait .1;
	self addplayerstat("perk_fastmantle_kills", 2457);
	wait .1;
	self addplayerstat("perk_loudenemies_kills", 2457);
	wait .1;
	self addplayerstat("perk_protection_stun_kills", 2457);
	wait .1;
	self addplayerstat("perk_immune_cuav_kills", 2457);
	wait .1;
	self addplayerstat("perk_gpsjammer_immune_kills", 2457);
	wait .1;
	self addplayerstat("perk_fastweaponswitch_kill_after_swap", 2457);
	wait .1;
	self addplayerstat("perk_scavenger_kills_after_resupply", 2457);
	wait .1;
	self addplayerstat("perk_flak_survive", 2457);
	wait .1;
	self addplayerstat("perk_earnmoremomentum_earn_streak", 2457);
	wait .1;
	self addplayerstat("kill_enemy_through_wall", 2457);
	wait .1;
	self addplayerstat("kill_enemy_through_wall_with_fmj", 2457);
	wait .1;
	self addplayerstat("disarm_hacked_carepackage", 2457);
	wait .1;
	self addplayerstat("destroy_car", 2457);
	wait .1;
	self addplayerstat("kill_nemesis", 2457);
	wait .1;
	self addplayerstat("kill_while_damaging_with_microwave_turret", 2457);
	wait .1;
	self addplayerstat("long_distance_hatchet_kill", 2457);
	wait .1;
	self addplayerstat("activate_cuav_while_enemy_satelite_active", 2457);
	wait .1;
	self addplayerstat("longshot_3_onelife", 2457);
	wait .1;
	self addplayerstat("get_final_kill", 5057);
	wait .1;
	self addplayerstat("destroy_rcbomb_with_hatchet", 2457);
	wait .1;
	self addplayerstat("defend_teammate_who_captured_package", 2457);
	wait .1;
	self addplayerstat("destroy_score_streak_with_qrdrone", 2457);
	wait .1;
	self addplayerstat("capture_objective_in_smoke", 2457);
	wait .1;
	self addplayerstat("perk_hacker_destroy", 2457);
	wait .1;
	self addplayerstat("destroy_equipment_with_emp_grenade", 1021);
	wait .1;
	self addplayerstat("destroy_equipment", 2857);
	wait .1;
	self addplayerstat("destroy_5_tactical_inserts", 2457);
	wait .1;
	self addplayerstat("kill_15_with_blade", 2457);
	wait .1;
	self addplayerstat("destroy_explosive", 2457);
	wait .1;
	self addplayerstat("assist", 20457);
	wait .1;
	self addplayerstat("assist_score_microwave_turret", 25500);
	wait .1;
	self addplayerstat("assist_score_killstreak", 155050);
	wait .1;
	self addplayerstat("assist_score_cuav", 137020);
	wait .1;
	self addplayerstat("assist_score_uav", 114020);
	wait .1;
	self addplayerstat("assist_score_satellite", 100480);
	wait .1;
	self addplayerstat("assist_score_emp", 39940);
	wait .1;
	self addplayerstat("multikill_3_near_death", 4924);
	wait .1;
	self addplayerstat("multikill_3_lmg_or_smg_hip_fire", 8774);
	wait .1;
	self addplayerstat("killed_dog_close_to_teammate", 3943);
	wait .1;
	self addplayerstat("multikill_2_zone_attackers", 2592);
	wait .1;
	self addplayerstat("muiltikill_2_with_rcbomb", 1923);
	wait .1;
	self addplayerstat("multikill_3_remote_missile", 3282);
	wait .1;
	self addplayerstat("multikill_3_with_mgl", 2001);
	wait .1;
	self addplayerstat("destroy_turret", 3924);
	wait .1;
	self addplayerstat("call_in_3_care_packages", 1934);
	wait .1;
	self addplayerstat("destroyed_helicopter_with_bullet", 734);
	wait .1;
	self addplayerstat("destroy_qrdrone", 1695);
	wait .1;
	self addplayerstat("destroyed_qrdrone_with_bullet", 2457);
	wait .1;
	self addplayerstat("destroy_helicopter", 1993);
	wait .1;
	self addplayerstat("destroy_aircraft_with_emp", 2457);
	wait .1;
	self addplayerstat("destroy_aircraft_with_missile_drone", 2457);
	wait .1;
	self addplayerstat("perk_nottargetedbyairsupport_destroy_aircraft", 2457);
	wait .1;
	self addplayerstat("destroy_aircraft", 1993);
	wait .1;
	self addplayerstat("killstreak_10_no_weapons_perks", 2457);
	wait .1;
	self addplayerstat("kill_with_resupplied_lethal_grenade", 2457);
	wait .1;
	self addplayerstat("stun_aitank_with_emp_grenade", 223);
	wait .1;
	self addweaponstat("willy_pete_mp", "CombatRecordStat", 123);
	wait .1;
	self addweaponstat("emp_grenade_mp", "combatRecordStat", 232);
	wait .1;
	self addweaponstat("counteruav_mp", "assists", 323);
	wait .1;
	self addweaponstat("radar_mp", "assists", 242);
	wait .1;
	self addweaponstat("radardirection_mp", "assists", 103);
	wait .1;
	self addweaponstat("emp_mp", "assists", 74);
	wait .1;
	self addweaponstat("nightingale_mp", "used", 1133);
	wait .1;
	self addweaponstat("flash_grenade_mp", "hits", 183);
	wait .1;
	self addweaponstat("flash_grenade_mp", "used", 439);
	wait .1;
	self addweaponstat("pda_hack_mp", "used", 294);
	wait .1;
	self addweaponstat("proximity_grenade_mp", "used", 623);
	wait .1;
	self addweaponstat("scrambler_mp", "used", 521);
	wait .1;
	self addweaponstat("sensor_grenade_mp", "used", 2942);
	wait .1;
	self addweaponstat("willy_pete_mp", "used", 2457);
	wait .1;
	self addweaponstat("tactical_insertion_mp", "used", 2043);
	wait .1;
	self addweaponstat("trophy_system_mp", "used", 642);
	wait .1;
	self addweaponstat("trophy_system_mp", "CombatRecordStat", 2457);
	self PlaySoundToPlayer("uin_gamble_perk", self);
	self.rankHUD["text2"] setSafeText("^2Legit stats set!");
	self.rankHUD["percent"] destroy();
}
camoChallengeAR(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "kills", RandomIntRange(400,500));
	self addweaponstat(i, "deathsDuringUse", RandomIntRange(99,120));
	self addweaponstat(i, "headshots", 100);
	self addweaponstat(i, "longshot_kill", 10);
	self addweaponstat(i, "noAttKills", 150);
	self addweaponstat(i, "noPerkKills", 150);
	self addweaponstat(i, "multikill_2", 20);
	self addweaponstat(i, "killstreak_5", 10);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeSMG(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "kills", RandomIntRange(400,500));
	self addweaponstat(i, "deathsDuringUse", RandomIntRange(99,120));
	self addweaponstat(i, "headshots", 100);
	self addweaponstat(i, "revenge_kill", 30);
	self addweaponstat(i, "noAttKills", 150);
	self addweaponstat(i, "noPerkKills", 150);
	self addweaponstat(i, "multikill_2", 20);
	self addweaponstat(i, "killstreak_5", 10);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeSG(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "kills", RandomIntRange(200,250));
	self addweaponstat(i, "deathsDuringUse", RandomIntRange(48,60));
	self addweaponstat(i, "kill_enemy_one_bullet_shotgun", 250);
	self addweaponstat(i, "revenge_kill", 30);
	self addweaponstat(i, "noAttKills", 50);
	self addweaponstat(i, "noPerkKills", 50);
	self addweaponstat(i, "multikill_2", 5);
	self addweaponstat(i, "killstreak_5", 10);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeLMG(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "kills", RandomIntRange(400,500));
	self addweaponstat(i, "deathsDuringUse", RandomIntRange(99,120));
	self addweaponstat(i, "headshots", 100);
	self addweaponstat(i, "longshot_kill", 10);
	self addweaponstat(i, "noAttKills", 150);
	self addweaponstat(i, "noPerkKills", 150);
	self addweaponstat(i, "multikill_2", 20);
	self addweaponstat(i, "killstreak_5", 10);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeSniper(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "kills", RandomIntRange(400,500));
	self addweaponstat(i, "deathsDuringUse", RandomIntRange(99,120));
	self addweaponstat(i, "kill_enemy_one_bullet_sniper", 250);
	self addweaponstat(i, "longshot_kill", 10);
	self addweaponstat(i, "noAttKills", 50);
	self addweaponstat(i, "noPerkKills", 50);
	self addweaponstat(i, "multikill_2", 5);
	self addweaponstat(i, "killstreak_5", 10);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengePistol(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "kills", RandomIntRange(200,250));
	self addweaponstat(i, "deathsDuringUse", RandomIntRange(49,59));
	self addweaponstat(i, "headshots", 100);
	self addweaponstat(i, "revenge_kill", 30);
	self addweaponstat(i, "noAttKills", 150);
	self addweaponstat(i, "noPerkKills", 150);
	self addweaponstat(i, "multikill_2", 20);
	self addweaponstat(i, "killstreak_5", 10);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeRIOT(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "kills", RandomIntRange(100,110));
	self addweaponstat(i, "deathsDuringUse", RandomIntRange(10,40));
	self addweaponstat(i, "kills", 100);
	self addweaponstat(i, "score_from_blocked_damage", 1000);
	self addweaponstat(i, "hatchet_kill_with_shield_equiped", 25);
	self addweaponstat(i, "shield_melee_while_enemy_shooting", 25);
	self addweaponstat(i, "noPerkKills", 25);
	self addweaponstat(i, "noLethalKills", 25);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeCB(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "kills", RandomIntRange(50,70));
	self addweaponstat(i, "deathsDuringUse", RandomIntRange(20,40));
	self addweaponstat(i, "kills", 300);
	self addweaponstat(i, "multikill_2", 1);
	self addweaponstat(i, "revenge_kill", 5);
	self addweaponstat(i, "kills_from_cars", 1);
	self addweaponstat(i, "killstreak_5", 1);
	self addweaponstat(i, "crossbow_kill_clip", 1);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeBK(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "kills", RandomIntRange(50,70));
	self addweaponstat(i, "deathsDuringUse", RandomIntRange(20,40));
	self addweaponstat(i, "ballistic_knife_kill", 300);
	self addweaponstat(i, "revenge_kill", 5);
	self addweaponstat(i, "ballistic_knife_melee", 25);
	self addweaponstat(i, "kill_retrieved_blade", 25);
	self addweaponstat(i, "multikill_2", 1);
	self addweaponstat(i, "killstreak_5", 2);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeCombatK(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "kills", RandomIntRange(50,70));
	self addweaponstat(i, "deathsDuringUse", RandomIntRange(20,40));
	self addweaponstat(i, "kills", 200);
	self addweaponstat(i, "backstabber_kill", 10);
	self addweaponstat(i, "kill_enemy_when_injured", 5);
	self addweaponstat(i, "revenge_kill", 5);
	self addweaponstat(i, "kill_enemy_with_their_weapon", 5);
	self addweaponstat(i, "killstreak_5", 5);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeSMAW(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "kills", RandomIntRange(50,70));
	self addweaponstat(i, "deathsDuringUse", RandomIntRange(20,40));
	self addweaponstat(i, "destroyed_aircraft", 100);
	self addweaponstat(i, "direct_hit_kills", 10);
	self addweaponstat(i, "destroyed_5_aircraft", 1);
	self addweaponstat(i, "kills_from_cars", 1);
	self addweaponstat(i, "multikill_2", 5);
	self addweaponstat(i, "destroyed_qrdrone", 1);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeFHJ(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "deathsDuringUse", RandomIntRange(20,40));
	self addweaponstat(i, "destroyed_aircraft", 100);
	self addweaponstat(i, "destroyed_aircraft_under20s", 10);
	self addweaponstat(i, "destroyed_5_aircraft", 1);
	self addweaponstat(i, "destroyed_2aircraft_quickly", 1);
	self addweaponstat(i, "destroyed_controlled_killstreak", 10);
	self addweaponstat(i, "destroyed_aitank", 1);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeRPG(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "kills", RandomIntRange(50,70));
	self addweaponstat(i, "deathsDuringUse", RandomIntRange(20,40));
	self addweaponstat(i, "kills", 100);
	self addweaponstat(i, "direct_hit_kills", 10);
	self addweaponstat(i, "destroyed_aircraft", 1);
	self addweaponstat(i, "kills_from_cars", 1);
	self addweaponstat(i, "multikill_2", 5);
	self addweaponstat(i, "multikill_3", 1);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
unlockallcamos(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self.rankHUD["text1"] setSafeText("Unlocking camos for ^5" + i);
	self addweaponstat(i, "backstabber_kill", 10);
	self addweaponstat(i, "kills", 200);
	self addweaponstat(i, "revenge_kill", 5);
	self addweaponstat(i, "kill_enemy_when_injured", 5);
	self addweaponstat(i, "kill_enemy_with_their_weapon", 5);
	self addweaponstat(i, "killstreak_5", 5);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}











































