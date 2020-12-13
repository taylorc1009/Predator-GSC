Iif(bool, rTrue, rFalse)
{
	if(bool)
		return rTrue;
	else
		return rFalse;
}
booleanReturnVal(bool, returnIfFalse, returnIfTrue)
{
	if(bool)
		return returnIfTrue;
	else
		return returnIfFalse;
}
booleanOpposite(bool)
{
	if(!isDefined(bool))
		return true;
	if(bool)
		return false;
	else
		return true;
}
getPlayerName(player)
{
	playerName = getSubStr(player.name, 0, player.name.size);
	for(i=0; i < playerName.size; i++)
	{
		if(playerName[i] == "]")
			break;
	}
	if(playerName.size != i)
		playerName = getSubStr(playerName, i + 1, playerName.size);
	return playerName;
}
resetBooleans()
{
    self.god = 0;
    self.InfiniteAmmo = false;
    self.InfiniteAmmoRel = false;
    self.invisible = 0;
    self.speedScaleX2 = false;
    self.uaimbot = false;
    self.taimbot = false;
    self.combataimbot = false;
    self.MultiJump = 0;
    self.nclip = true;
    self.forgemode = false;
    self.smokemonsterr = 0;
    self.smokeman = false;
    self.pokeBall = false;
    self.exorcist = false;
    self.explo = false;
    self.nfxexplo = false;
    self.savedVM = undefined;
    self.sabers = false;
    self.givinsbers = false;
    self.agrarmy = false;
	self.DrawFx = undefined;
    self.sNadeOn = 0;
    self.htorch = false;
    self.gersh = false;
    self.matrixgun = false;
    self.playerFX = 0;
    self.TB = true;
    self.jetpack = false;
    self.bloodg = false;
    self.lightman = false;
    self.eCherry = 0;
    self.hunted = false;
    self.SNades = 0;
    self.hunt = false;
    self.ff = false;
    self.novaG = 0;
    self.blueballs = false;
    self.aimf = 0;
    self.FastDelete = 0;
    self.Lodestar = false;
    self.backflipMod = false;
    self.PHDGLOPPER = 0;
    self.LethModel = 0;
    self.fire = 0;
    self.CF = 0;
    self.arcCam = 0;
    self.Axebot = 0;
    self.Drop = true;
    self.centp = false;
    self.fireballs = false;
    self.deathrock = false;
    self.tknifet = false;
    self.isRaygun = 0;
    self.TMG = true;
    self.mustG = false;
    self.rocketTeleOn = 0;
    self.isRaygunM2 = 0;
    self.isRaygunM3 = 0;
    self.Ray = false;
    self.AguaLoca = 0;
    self.Db = false;
    self.lightstuf = false;
    self.superm = false;
    self.artillery = 0;
    self.mFX = 0;
    self.mLTOn = 0;
    self.mBulletOn = 0;
    self.NukeBulletsOn = 0;
    self.EMPBulletsOn = 0;
    self.bullets4 = false;
    self.Rototr = 1;
    self.TPG = true;
    self.realdog = false;
    self.dogModel = "german_shepherd";
	self.dModCycle = 0;
    self.TPP = 0;
    self.defweap = 0;
    self.nacswap = "no";
    self.MainRootAimbot1 = 0;
    self.thefrog = false;
    self.thesuit = false;
    self.ridehunter = false;
    self.arrowMan = false;
	self.tomahawkaimbot = false;
	self.RealDefault = false;
}
resetdvars()
{
	setDvar("timescale", "1");
	setDvar("g_speed", "200");
	setDvar("player_meleeRange", "64");
    setDvar("cg_overheadnamessize","0.65");
    setDvar("cg_gun_x", "0");
	setDvar("cg_gun_y", "0");
	setDvar("cg_gun_z", "0");
	setDvar("timescale", "1");
	setDvar("scr_killcam_time",5);
	setDvar("cg_enemyNameFadeOut",250);
	setDvar("cg_enemyNameFadeIn",250);
	setDvar("cg_drawThroughWalls",0);
	setDvar("perk_weapRateMultiplier","1");
	setDvar("perk_weapReloadMultiplier","1");
	setDvar("perk_fireproof","1");
	setDvar("cg_weaponSimulateFireAnims","1");
	if(getDvar("g_gametype")== "tdm")
		setgametypesetting("scorelimit",75);
	if(getDvar("g_gametype")== "dom")
		setgametypesetting("scorelimit",200);
	if(getDvar("g_gametype")== "dm")
		setgametypesetting("scorelimit",30);
}
initVariables()
{
    self.SpawnweaponStringCreated=[];
    self.currentweaponhint=[];
    self.nearSpawnweapon=[];
    self.SpawnweaponcrateHintString=[];
    self.usingFlag=[];
    self.usingPackOPunch=[];
    self.nearPackOPunch=[];
    self.PackOPunchStringCreated=[];
    self.PackOPunchHintString=[];
    self.upw=[];
    self.splModsInt = false;
    self.needAim = 0;
    self.aimAtTag = "chest";
	self.feedTag = "MOD_RIFLE_BULLET";
	self.AimbotTag = "j_chest";
	self.menu.open = false;
    self.letter["currentResult"] = "";
    self.letter["keysUpper"] = strTok("1QAZ_;2WSX-;3EDC.;4RFV,;5TGB=;6YHN';7UJM?;8IK !;9OL#<;0P@^>", ";");
	self.letter["keysLower"] = strTok("1qaz_;2wsx-;3edc.;4rfv,;5tgb=;6yhn';7ujm?;8ik !;9ol#<;0p@^>", ";");
    self.letter["keysHUDLow"] = strTok("1\nq\na\nz\n_;2\nw\ns\nx\n-;3\ne\nd\nc\n.;4\nr\nf\nv\n,;5\nt\ng\nb\n=;6\ny\nh\nn\n';7\nu\nj\nm\n?;8\ni\nk\n \n!;9\no\nl\n#\n<;0\np\n@\n^\n>", ";");
	self.letter["keysHUDBig"] = strTok("1\nQ\nA\nZ\n_;2\nW\nS\nX\n-;3\nE\nD\nC\n.;4\nR\nF\nV\n,;5\nT\nG\nB\n=;6\nY\nH\nN\n';7\nU\nJ\nM\n?;8\nI\nK\n \n!;9\nO\nL\n#\n<;0\nP\n@\n^\n>", ";");
	self.letter["controls"] = "[{+actionslot 1}] [{+actionslot 4}] [{+actionslot 2}] [{+actionslot 3}] scroll\n[{+speed_throw}] toggle capitals\n[{+smoke}] finish\n[{+gostand}] select\n[{+switchseat}] space\n[{+usereload}] backspace\n[{+stance}] cancel";
	self.letter["currentText"] = "";
	self.letter["Caps"] = false;
}
AntiEndGame()
{
	level.hostforcedend = 1;
	self waittill("menuresponse", "endgame");
	level.hostforcedend = 0;
}
removeBarrier()
{
	entArray = getEntArray();
	for(index = 0; index < entArray.size; index++)
	{
		if(isSubStr(entArray[index].classname, "trigger_hurt") && entArray[index].origin[2] > 180)
			entArray[index].origin = (0, 0, 9999999);
	}
}









