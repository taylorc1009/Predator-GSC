#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/_development_dvars;
#include maps/mp/_ambientpackage;
init()
{
	if(!(getDvar("mapname")== "mp_magma" || getDvar("mapname")== "mp_hydro" || getDvar("mapname")== "mp_uplink"))
	{
		level.glassfx=loadfx("impacts/fx_xtreme_glass_hit_mp");
		level.wtfdude=loadfx("maps/mp_maps/fx_mp_koth_marker_neutral_1");
		level.electrical=loadfx("weapon/grenade/fx_prox_grenade_exp");
		level.grnorb=loadfx("weapon/sensor_grenade/fx_sensor_exp_scan_friendly");
		level.cloud=loadfx("maps/mp_maps/fx_mp_exp_bomb_smk_streamer");
	}
	if(!(getDvar("mapname")== "mp_hydro"))
	{
		level.gershfx=loadfx("misc/fx_theater_mode_camera_head_glow_grn");
		level.majw=loadfx("weapon/rocket/fx_rocket_exp_water_shallow_mp");
		level.tnkdrt=loadFX("weapon/tank/fx_tank_dirt");
		level._effect["impacts/fx_cushion_hit"] = loadfx("impacts/fx_cushion_hit");
		level._effect["flak20_fire_fx"] = loadfx("weapon/tracer/fx_tracer_flak_single_noExp");
		level._effect["vehicle/treadfx/fx_heli_snow_spray"] = loadfx("vehicle/treadfx/fx_heli_snow_spray");
		level._effect["impacts/fx_large_glass"] = loadfx("impacts/fx_large_glass");
	}
	if(!(getDvar("mapname")=="mp_studio" || getDvar("mapname")=="mp_la" || getDvar("mapname")=="mp_concert" || getDvar("mapname")=="mp_magma" || getDvar("mapname")=="mp_hydro"))
		level.bloody=loadfx("impacts/fx_flesh_hit_body_fatal_lg_exit");
	if(getDvar("mapname")=="mp_nuketown_2020")
	{
		level._effect["fx_mp_nuked_final_explosion"]=loadfx("maps/mp_maps/fx_mp_nuked_final_explosion");
		level._effect["fx_mp_nuked_final_dust"]=loadfx("maps/mp_maps/fx_mp_nuked_final_dust");
	}
	if(!(getDvar("mapname")=="mp_la" || getDvar("mapname")=="mp_concert" || getDvar("mapname")=="mp_magma" || getDvar("mapname")== "mp_uplink" || getDvar("mapname")=="mp_hydro"))
		level._effect["impacts/fx_small_foliage"] = loadFx("impacts/fx_small_foliage");
   	level.Jetexplo = loadfx("vehicle/vexplosion/fx_vexplode_u2_exp_mp");
	level.waypointGreen=loadFX("misc/fx_equip_tac_insert_light_grn");
   	level.waypointRed=loadFX("misc/fx_equip_tac_insert_light_red");
    level.bettydestroyedfx=loadfx("weapon/bouncing_betty/fx_betty_destroyed");
	level.flares=loadfx("env/smoke/fx_smoke_supply_drop_blue_mp");
	level.remote_mortar_fx["missileExplode"]=loadfx("weapon/remote_mortar/fx_rmt_mortar_explosion");
	level.chapowereareu=loadfx("weapon/straferun/fx_straferun_chaf");
	level.RedLight=loadFX("misc/fx_equip_light_red");
	level.GreenLight=loadFX("misc/fx_equip_light_green");
	level.watergunfx=loadfx("impacts/fx_xtreme_water_hit_mp");
	level.ac130fx=loadfx("vehicle/vexplosion/fx_vexplode_vtol_mp");
	level.fx_cuav_afterburner=loadFx("vehicle/exhaust/fx_exhaust_u2_spyplane_afterburner");
	level._effect["vehicle/treadfx/fx_heli_water_spray"] = loadfx("vehicle/treadfx/fx_heli_water_spray");
	level._effect["weapon/talon/fx_muz_talon_rocket_flash_1p"] = loadfx("weapon/talon/fx_muz_talon_rocket_flash_1p");
	level._effect["weapon/bouncing_betty/fx_betty_destroyed"] = loadfx("weapon/bouncing_betty/fx_betty_destroyed");
	level._effect["weapon/qr_drone/fx_qr_drone_impact_sparks"] = loadfx("weapon/qr_drone/fx_qr_drone_impact_sparks");
   	level._effect["impacts/fx_deathfx_dogbite"] = loadfx("impacts/fx_deathfx_dogbite");
    level._effect["rcbombexplosion"]=loadfx("maps/mp_maps/fx_mp_exp_rc_bomb");
    level._effect["emp_flash"]=loadfx("weapon/emp/fx_emp_explosion");
    level._effect["torch"]=loadfx("maps/mp_maps/fx_mp_exp_rc_bomb");
	if(!(getDvar("verPlayersImmune")=="0" || getDvar("verPlayersImmune")=="1"))
   		setDvar("verPlayersImmune", "1");
   	if(!(getDvar("aimbotLocked") == "0" || getDvar("aimbotLocked") == "1"))
   		setDvar("aimbotLocked", "0");
   	if(!(getDvar("autoAntiQuit")=="0" || getDvar("autoAntiQuit")=="1"))
   		setDvar("autoAntiQuit", "0");
   	if(!(getDvar("forcingHost")=="0" || getDvar("forcingHost")=="1"))
		setDvar("forcingHost", "0");
	level.scoreinfo = [];
	level.xpscale = getDvarFloat( "scr_xpscale" );
	level.codpointsxpscale = getDvarFloat( "scr_codpointsxpscale" );
	level.codpointsmatchscale = getDvarFloat( "scr_codpointsmatchscale" );
	level.codpointschallengescale = getDvarFloat( "scr_codpointsperchallenge" );
	level.rankxpcap = getDvarInt( "scr_rankXpCap" );
	level.codpointscap = getDvarInt( "scr_codPointsCap" );
	level.usingmomentum = 1;
	level.usingscorestreaks = getDvarInt( "scr_scorestreaks" ) != 0;
	level.scorestreaksmaxstacking = getDvarInt( "scr_scorestreaks_maxstacking" );
	level.maxinventoryscorestreaks = getdvarintdefault( "scr_maxinventory_scorestreaks", 3 );
	if ( isDefined( level.usingscorestreaks ) )
	{
		level.usingrampage = !level.usingscorestreaks;
	}
	level.rampagebonusscale = getDvarFloat( "scr_rampagebonusscale" );
	level.ranktable = [];
	precacheshader( "white" );
	if ( !sessionmodeiszombiesgame() )
	{
		initscoreinfo();
	}
	level.maxrank = int( tablelookup( "mp/rankTable.csv", 0, "maxrank", 1 ) );
	level.maxprestige = int( tablelookup( "mp/rankIconTable.csv", 0, "maxprestige", 1 ) );
	pid = 0;
	rid = 0;
	pid = 0;
	while ( pid <= level.maxprestige )
	{
		rid = 0;
		while ( rid <= level.maxrank )
		{
			precacheshader( tablelookup( "mp/rankIconTable.csv", 0, rid, pid + 1 ) );
			rid++;
		}
		pid++;
	}
	rankid = 0;
	rankname = tablelookup( "mp/ranktable.csv", 0, rankid, 1 );
	while ( isDefined( rankname ) && rankname != "" )
	{
		level.ranktable[ rankid ][ 1 ] = tablelookup( "mp/ranktable.csv", 0, rankid, 1 );
		level.ranktable[ rankid ][ 2 ] = tablelookup( "mp/ranktable.csv", 0, rankid, 2 );
		level.ranktable[ rankid ][ 3 ] = tablelookup( "mp/ranktable.csv", 0, rankid, 3 );
		level.ranktable[ rankid ][ 7 ] = tablelookup( "mp/ranktable.csv", 0, rankid, 7 );
		level.ranktable[ rankid ][ 14 ] = tablelookup( "mp/ranktable.csv", 0, rankid, 14 );
		rankid++;
		rankname = tablelookup( "mp/ranktable.csv", 0, rankid, 1 );
	}
	level thread onplayerconnect();
}
initscoreinfo()
{
	scoreinfotableid = getscoreeventtableid();
	if ( !isDefined( scoreinfotableid ) )
	{
		return;
	}
	scorecolumn = getscoreeventcolumn( level.gametype );
	xpcolumn = getxpeventcolumn( level.gametype );
	if ( scorecolumn < 0 )
	{
		return;
	}
	if ( xpcolumn < 0 )
	{
		return;
	}
	row = 1;
	while ( row < 512 )
	{
		type = tablelookupcolumnforrow( scoreinfotableid, row, 0 );
		if ( type != "" )
		{
			labelstring = tablelookupcolumnforrow( scoreinfotableid, row, 1 );
			label = undefined;
			if ( labelstring != "" )
			{
				label = tablelookupistring( scoreinfotableid, 0, type, 1 );
			}
			scorevalue = int( tablelookupcolumnforrow( scoreinfotableid, row, scorecolumn ) );
			registerscoreinfo( type, scorevalue, label );
			if ( maps/mp/_utility::getroundsplayed() == 0 )
			{
				xpvalue = float( tablelookupcolumnforrow( scoreinfotableid, row, xpcolumn ) );
				setddlstat = tablelookupcolumnforrow( scoreinfotableid, row, 5 );
				addplayerstat = 0;
				if ( setddlstat == "TRUE" )
				{
					addplayerstat = 1;
				}
				ismedal = 0;
				istring = tablelookupistring( scoreinfotableid, 0, type, 2 );
				if ( isDefined( istring ) && istring != &"" )
				{
					ismedal = 1;
				}
				demobookmarkpriority = int( tablelookupcolumnforrow( scoreinfotableid, row, 6 ) );
				if ( !isDefined( demobookmarkpriority ) )
				{
					demobookmarkpriority = 0;
				}
				registerxp( type, xpvalue, addplayerstat, ismedal, demobookmarkpriority, row );
			}
			allowkillstreakweapons = tablelookupcolumnforrow( scoreinfotableid, row, 4 );
			if ( allowkillstreakweapons == "TRUE" )
			{
				level.scoreinfo[ type ][ "allowKillstreakWeapons" ] = 1;
			}
		}
		row++;
	}
}
getrankxpcapped( inrankxp )
{
	if ( isDefined( level.rankxpcap ) && level.rankxpcap && level.rankxpcap <= inrankxp )
	{
		return level.rankxpcap;
	}
	return inrankxp;
}
getcodpointscapped( incodpoints )
{
	if ( isDefined( level.codpointscap ) && level.codpointscap && level.codpointscap <= incodpoints )
	{
		return level.codpointscap;
	}
	return incodpoints;
}
registerscoreinfo( type, value, label )
{
	overridedvar = "scr_" + level.gametype + "_score_" + type;
	if ( getDvar( overridedvar ) != "" )
	{
		value = getDvarInt( overridedvar );
	}
	if ( type == "kill" )
	{
		multiplier = getgametypesetting( "killEventScoreMultiplier" );
		level.scoreinfo[ type ][ "value" ] = int( ( multiplier + 1 ) * value );
	}
	else
	{
		level.scoreinfo[ type ][ "value" ] = value;
	}
	if ( isDefined( label ) )
	{
		precachestring( &"MP_PLUS" );
		level.scoreinfo[ type ][ "label" ] = &"MP_PLUS";
		level.scoreinfo[ type ][ "label" ] = &"";
	}
}
getscoreinfovalue( type )
{
	if ( isDefined( level.scoreinfo[ type ] ) )
	{
		return level.scoreinfo[ type ][ "value" ];
	}
}
getscoreinfolabel( type )
{
	return level.scoreinfo[ type ][ "label" ];
}
killstreakweaponsallowedscore( type )
{
	if ( isDefined( level.scoreinfo[ type ][ "allowKillstreakWeapons" ] ) && level.scoreinfo[ type ][ "allowKillstreakWeapons" ] == 1 )
	{
		return 1;
	}
	else
	{
		return 0;
	}
}
doesscoreinfocounttowardrampage( type )
{
	if ( isDefined( level.scoreinfo[ type ][ "rampage" ] ) )
	{
		return level.scoreinfo[ type ][ "rampage" ];
	}
}
getrankinfominxp( rankid )
{
	return int( level.ranktable[ rankid ][ 2 ] );
}
getrankinfoxpamt( rankid )
{
	return int( level.ranktable[ rankid ][ 3 ] );
}
getrankinfomaxxp( rankid )
{
	return int( level.ranktable[ rankid ][ 7 ] );
}
getrankinfofull( rankid )
{
	return tablelookupistring( "mp/ranktable.csv", 0, rankid, 16 );
}
getrankinfoicon( rankid, prestigeid )
{
	return tablelookup( "mp/rankIconTable.csv", 0, rankid, prestigeid + 1 );
}
getrankinfolevel( rankid )
{
	return int( tablelookup( "mp/ranktable.csv", 0, rankid, 13 ) );
}
getrankinfocodpointsearned( rankid )
{
	return int( tablelookup( "mp/ranktable.csv", 0, rankid, 17 ) );
}
shouldkickbyrank()
{
	if ( self ishost() )
	{
		return 0;
	}
	if ( level.rankcap > 0 && self.pers[ "rank" ] > level.rankcap )
	{
		return 1;
	}
	if ( level.rankcap > 0 && level.minprestige == 0 && self.pers[ "plevel" ] > 0 )
	{
		return 1;
	}
	if ( level.minprestige > self.pers[ "plevel" ] )
	{
		return 1;
	}
	return 0;
}
getcodpointsstat()
{
	codpoints = self getdstat( "playerstatslist", "CODPOINTS", "StatValue" );
	codpointscapped = getcodpointscapped( codpoints );
	if ( codpoints > codpointscapped )
	{
		self setcodpointsstat( codpointscapped );
	}
	return codpointscapped;
}
setcodpointsstat( codpoints )
{
	self setdstat( "PlayerStatsList", "CODPOINTS", "StatValue", getcodpointscapped( codpoints ) );
}
getrankxpstat()
{
	rankxp = self getdstat( "playerstatslist", "RANKXP", "StatValue" );
	rankxpcapped = getrankxpcapped( rankxp );
	if ( rankxp > rankxpcapped )
	{
		self setdstat( "playerstatslist", "RANKXP", "StatValue", rankxpcapped );
	}
	return rankxpcapped;
}
onplayerconnect()
{
	for (;;)
	{
		level waittill( "connected", player );
		player.pers[ "rankxp" ] = player getrankxpstat();
		player.pers[ "codpoints" ] = player getcodpointsstat();
		player.pers[ "currencyspent" ] = player getdstat( "playerstatslist", "currencyspent", "StatValue" );
		rankid = player getrankforxp( player getrankxp() );
		player.pers[ "rank" ] = rankid;
		player.pers[ "plevel" ] = player getdstat( "playerstatslist", "PLEVEL", "StatValue" );
		if ( player shouldkickbyrank() )
		{
			kick( player getentitynumber() );
			continue;
		}
		else
		{
			if ( !isDefined( player.pers[ "participation" ] ) || level.gametype == "twar" && game[ "roundsplayed" ] >= 0 && player.pers[ "participation" ] >= 0 )
			{
				player.pers[ "participation" ] = 0;
			}
			player.rankupdatetotal = 0;
			player.cur_ranknum = rankid;
			prestige = player getdstat( "playerstatslist", "plevel", "StatValue" );
			player setrank( rankid, prestige );
			player.pers[ "prestige" ] = prestige;
			if ( !isDefined( player.pers[ "summary" ] ) )
			{
				player.pers[ "summary" ] = [];
				player.pers[ "summary" ][ "xp" ] = 0;
				player.pers[ "summary" ][ "score" ] = 0;
				player.pers[ "summary" ][ "challenge" ] = 0;
				player.pers[ "summary" ][ "match" ] = 0;
				player.pers[ "summary" ][ "misc" ] = 0;
				player.pers[ "summary" ][ "codpoints" ] = 0;
			}
			if ( !level.rankedmatch || level.wagermatch && level.leaguematch )
			{
				player setdstat( "AfterActionReportStats", "lobbyPopup", "none" );
			}
			if ( level.rankedmatch )
			{
				player setdstat( "playerstatslist", "rank", "StatValue", rankid );
				player setdstat( "playerstatslist", "minxp", "StatValue", getrankinfominxp( rankid ) );
				player setdstat( "playerstatslist", "maxxp", "StatValue", getrankinfomaxxp( rankid ) );
				player setdstat( "playerstatslist", "lastxp", "StatValue", getrankxpcapped( player.pers[ "rankxp" ] ) );
			}
			player.explosivekills[ 0 ] = 0;
			player thread onplayerspawned();
			player thread onjoinedteam();
			player thread onjoinedspectators();
		}
	}
}
onjoinedteam()
{
	self endon( "disconnect" );
	for (;;)
	{
		self waittill( "joined_team" );
		self thread removerankhud();
	}
}
onjoinedspectators()
{
	self endon( "disconnect" );
	for (;;)
	{
		self waittill( "joined_spectators" );
		self thread removerankhud();
	}
}
onplayerspawned()
{
	self endon( "disconnect" );
	for (;;)
	{
		self waittill( "spawned_player" );
		if ( !isDefined( self.hud_rankscroreupdate ) )
		{
			self.hud_rankscroreupdate = newscorehudelem( self );
			self.hud_rankscroreupdate.horzalign = "center";
			self.hud_rankscroreupdate.vertalign = "middle";
			self.hud_rankscroreupdate.alignx = "center";
			self.hud_rankscroreupdate.aligny = "middle";
			self.hud_rankscroreupdate.x = 0;
			if ( self issplitscreen() )
			{
				self.hud_rankscroreupdate.y = -15;
			}
			else
			{
				self.hud_rankscroreupdate.y = -60;
			}
			self.hud_rankscroreupdate.font = "default";
			self.hud_rankscroreupdate.fontscale = 2;
			self.hud_rankscroreupdate.archived = 0;
			self.hud_rankscroreupdate.color = ( 1, 1, 0.5 );
			self.hud_rankscroreupdate.alpha = 0;
			self.hud_rankscroreupdate.sort = 50;
			self.hud_rankscroreupdate maps/mp/gametypes/_hud::fontpulseinit();
		}		
	} 			
} 			
inccodpoints( amount )
{
	if ( !isrankenabled() )
	{
		return;
	}
	if ( !level.rankedmatch )
	{
		return;
	}
	newcodpoints = getcodpointscapped( self.pers[ "codpoints" ] + amount );
	if ( newcodpoints > self.pers[ "codpoints" ] )
	{
		self.pers[ "summary" ][ "codpoints" ] += newcodpoints - self.pers[ "codpoints" ];
	}
	self.pers[ "codpoints" ] = newcodpoints;
	setcodpointsstat( int( newcodpoints ) );
}
atleastoneplayeroneachteam()
{
	foreach( team in level.teams )
	{
		if ( !level.playerCount[team] )
	    	return false;
	}
	return true; 
}
giverankxp( type, value, devadd )
{
	self endon( "disconnect" );
	if ( sessionmodeiszombiesgame() )
	{
		return;
	}
	if ( level.teambased && !atleastoneplayeroneachteam() && !isDefined( devadd ) )
	{
		return;
	}
	else
	{
		if ( !level.teambased && maps/mp/gametypes/_globallogic::totalplayercount() < 2 && !isDefined( devadd ) )
		{
			return;
		}
	}
	if ( !isrankenabled() )
	{
		return;
	}
	pixbeginevent( "giveRankXP" );
	if ( !isDefined( value ) )
	{
		value = getscoreinfovalue( type );
	}
	if ( level.rankedmatch )
	{
		bbprint( "mpplayerxp", "gametime %d, player %s, type %s, delta %d", getTime(), self.name, type, value );
	}
	switch( type )
	{
		case "assault": case "assault_assist": case "assist": case "assist_25": case "assist_50": case "assist_75": case "capture": case "defend": case "defuse": case "destroyer": case "dogassist": case "dogkill": case "headshot": case "helicopterassist": case "helicopterassist_25": case "helicopterassist_50": case "helicopterassist_75": case "helicopterkill": case "kill": case "medal": case "pickup": case "plant": case "rcbombdestroy": case "return": case "revive": case "spyplaneassist": case "spyplanekill": value = int( value * level.xpscale );
		break;
		default: if ( level.xpscale == 0 )
		{
			value = 0;
		}
		break;
	}
	xpincrease = self incrankxp( value );
	if ( level.rankedmatch )
	{
		self updaterank();
	}
	if ( value != 0 )
	{
		self syncxpstat();
	}
	if ( isDefined( self.enabletext ) && self.enabletext && !level.hardcoremode )
	{
		if ( type == "teamkill" )
		{
			self thread updaterankscorehud( 0 - getscoreinfovalue( "kill" ) );
		}
		else
		{
			self thread updaterankscorehud( value );
		}
	}
	switch( type )
	{
		case "assault": case "assist": case "assist_25": case "assist_50": case "assist_75": case "capture": case "defend": case "headshot": case "helicopterassist": case "helicopterassist_25": case "helicopterassist_50": case "helicopterassist_75": case "kill": case "medal": case "pickup": case "return": case "revive": case "suicide": case "teamkill": self.pers[ "summary" ][ "score" ] += value;
		inccodpoints( round_this_number( value * level.codpointsxpscale ) );
		break;
		case "loss": case "tie": case "win": self.pers[ "summary" ][ "match" ] += value;
		inccodpoints( round_this_number( value * level.codpointsmatchscale ) );
		break;
		case "challenge": self.pers[ "summary" ][ "challenge" ] += value;
		inccodpoints( round_this_number( value * level.codpointschallengescale ) );
		break;
		default: self.pers[ "summary" ][ "misc" ] += value;
		self.pers[ "summary" ][ "match" ] += value;
		inccodpoints( round_this_number( value * level.codpointsmatchscale ) );
		break;
	}
	self.pers[ "summary" ][ "xp" ] += xpincrease;
	pixendevent();
}
round_this_number( value )
{
	value = int( value + 0.5 );
	return value;
}
updaterank()
{
	newrankid = self getrank();
	if ( newrankid == self.pers[ "rank" ] )
	{
		return 0;
	}
	oldrank = self.pers[ "rank" ];
	rankid = self.pers[ "rank" ];
	self.pers[ "rank" ] = newrankid;
	while ( rankid <= newrankid )
	{
		self setdstat( "playerstatslist", "rank", "StatValue", rankid );
		self setdstat( "playerstatslist", "minxp", "StatValue", int( level.ranktable[ rankid ][ 2 ] ) );
		self setdstat( "playerstatslist", "maxxp", "StatValue", int( level.ranktable[ rankid ][ 7 ] ) );
		self.setpromotion = 1;
		if ( level.rankedmatch && level.gameended && !self issplitscreen() )
		{
			self setdstat( "AfterActionReportStats", "lobbyPopup", "promotion" );
		}
		if ( rankid != oldrank )
		{
			codpointsearnedforrank = getrankinfocodpointsearned( rankid );
			inccodpoints( codpointsearnedforrank );
			if ( !isDefined( self.pers[ "rankcp" ] ) )
			{
				self.pers[ "rankcp" ] = 0;
			}
			self.pers[ "rankcp" ] += codpointsearnedforrank;
		}
		rankid++;
	}
	self logstring( "promoted from " + oldrank + " to " + newrankid + " timeplayed: " + self getdstat( "playerstatslist", "time_played_total", "StatValue" ) );
	self setrank( newrankid );
	return 1;
}
codecallback_rankup( rank, prestige, unlocktokensadded )
{
	if ( rank > 8 )
	{
		self giveachievement( "MP_MISC_1" );
	}
	self luinotifyevent( &"rank_up", 3, rank, prestige, unlocktokensadded );
	self luinotifyeventtospectators( &"rank_up", 3, rank, prestige, unlocktokensadded );
}
getitemindex( refstring )
{
	itemindex = int( tablelookup( "mp/statstable.csv", 4, refstring, 0 ) );
	return itemindex;
}
endgameupdate()
{
	player = self;
}
updaterankscorehud( amount )
{
	self endon( "disconnect" );
	self endon( "joined_team" );
	self endon( "joined_spectators" );
	if ( isDefined( level.usingmomentum ) && level.usingmomentum )
	{
		return;
	}
	if ( amount == 0 )
	{
		return;
	}
	self notify( "update_score" );
	self endon( "update_score" );
	self.rankupdatetotal += amount;
	wait 0.05;
	if ( isDefined( self.hud_rankscroreupdate ) )
	{
		if ( self.rankupdatetotal < 0 )
		{
			self.hud_rankscroreupdate.label = &"";
			self.hud_rankscroreupdate.color = ( 0.73, 0.19, 0.19 );
		}
		else
		{
			self.hud_rankscroreupdate.label = &"MP_PLUS";
			self.hud_rankscroreupdate.color = ( 1, 1, 0.5 );
		}
		self.hud_rankscroreupdate setvalue( self.rankupdatetotal );
		self.hud_rankscroreupdate.alpha = 0.85;
		self.hud_rankscroreupdate thread maps/mp/gametypes/_hud::fontpulse( self );
		wait 1;
		self.hud_rankscroreupdate fadeovertime( 0.75 );
		self.hud_rankscroreupdate.alpha = 0;
		self.rankupdatetotal = 0;
	}
}
updatemomentumhud( amount, reason, reasonvalue )
{
	self endon( "disconnect" );
	self endon( "joined_team" );
	self endon( "joined_spectators" );
	if ( amount == 0 )
	{
		return;
	}
	self notify( "update_score" );
	self endon( "update_score" );
	self.rankupdatetotal += amount;
	if ( isDefined( self.hud_rankscroreupdate ) )
	{
		if ( self.rankupdatetotal < 0 )
		{
			self.hud_rankscroreupdate.label = &"";
			self.hud_rankscroreupdate.color = ( 0.73, 0.19, 0.19 );
		}
		else
		{
			self.hud_rankscroreupdate.label = &"MP_PLUS";
			self.hud_rankscroreupdate.color = ( 1, 1, 0.5 );
		}
		self.hud_rankscroreupdate setvalue( self.rankupdatetotal );
		self.hud_rankscroreupdate.alpha = 0.85;
		self.hud_rankscroreupdate thread maps/mp/gametypes/_hud::fontpulse( self );
		if ( isDefined( self.hud_momentumreason ) )
		{
			if ( isDefined( reason ) )
			{
				if ( isDefined( reasonvalue ) )
				{
					self.hud_momentumreason.label = reason;
					self.hud_momentumreason setvalue( reasonvalue );
				}
				else
				{
					self.hud_momentumreason.label = reason;
					self.hud_momentumreason setvalue( amount );
				}
				self.hud_momentumreason.alpha = 0.85;
				self.hud_momentumreason thread maps/mp/gametypes/_hud::fontpulse( self );
			}
			else
			{
				self.hud_momentumreason fadeovertime( 0.01 );
				self.hud_momentumreason.alpha = 0;
			}
		}
		wait 1;
		self.hud_rankscroreupdate fadeovertime( 0.75 );
		self.hud_rankscroreupdate.alpha = 0;
		if ( isDefined( self.hud_momentumreason ) && isDefined( reason ) )
		{
			self.hud_momentumreason fadeovertime( 0.75 );
			self.hud_momentumreason.alpha = 0;
		}
		wait 0.75;
		self.rankupdatetotal = 0;
	}
}
removerankhud()
{
	if ( isDefined( self.hud_rankscroreupdate ) )
	{
		self.hud_rankscroreupdate.alpha = 0;
	}
	if ( isDefined( self.hud_momentumreason ) )
	{
		self.hud_momentumreason.alpha = 0;
	}
}
getrank()
{
	rankxp = getrankxpcapped( self.pers[ "rankxp" ] );
	rankid = self.pers[ "rank" ];
	if ( rankxp < ( getrankinfominxp( rankid ) + getrankinfoxpamt( rankid ) ) )
	{
		return rankid;
	}
	else
	{
		return self getrankforxp( rankxp );
	}
}
getrankforxp( xpval )
{
	rankid = 0;
	rankname = level.ranktable[ rankid ][ 1 ];
	while ( isDefined( rankname ) && rankname != "" )
	{
		if ( xpval < ( getrankinfominxp( rankid ) + getrankinfoxpamt( rankid ) ) )
		{
			return rankid;
		}
		rankid++;
		if ( isDefined( level.ranktable[ rankid ] ) )
		{
			rankname = level.ranktable[ rankid ][ 1 ];
			continue;
		}
		else
		{
			rankname = undefined;
		}
	}
	rankid--;
	return rankid;
}
getspm()
{
	ranklevel = self getrank() + 1;
	return ( 3 + ( ranklevel * 0.5 ) ) * 10;
}
getrankxp()
{
	return getrankxpcapped( self.pers[ "rankxp" ] );
}
incrankxp( amount )
{
	if ( !level.rankedmatch )
	{
		return 0;
	}
	xp = self getrankxp();
	newxp = getrankxpcapped( xp + amount );
	if ( self.pers[ "rank" ] == level.maxrank && newxp >= getrankinfomaxxp( level.maxrank ) )
	{
		newxp = getrankinfomaxxp( level.maxrank );
	}
	xpincrease = getrankxpcapped( newxp ) - self.pers[ "rankxp" ];
	if ( xpincrease < 0 )
	{
		xpincrease = 0;
	}
	self.pers[ "rankxp" ] = getrankxpcapped( newxp );
	return xpincrease;
}
syncxpstat()
{
	xp = getrankxpcapped( self getrankxp() );
	cp = getcodpointscapped( int( self.pers[ "codpoints" ] ) );
	self setdstat( "playerstatslist", "rankxp", "StatValue", xp );
	self setdstat( "playerstatslist", "codpoints", "StatValue", cp );
}
getEnemyTeam()
{
	if(self.pers["team"]=="allies")
		return "axis";
	else
		return "allies";
}
TeamESP(team)
{
	if(getdvar("g_gametype")!="dm")
    {
		if(team == "your")
		{
			foreach(player in level.players)
			{
				if(player.pers["team"]==self.pers["team"] && !player isHost())
				{
					if(getDvar("verPlayersImmune")=="1" && !player isVerified())
						player thread init_ESPWallHack();
					else
						player thread init_ESPWallHack();
				}
			}
			level.teamESP=booleanOpposite(level.teamESP);
    		self iprintln(booleanReturnVal(level.teamESP, "Your team ^4no longer^7 has ESP", "Your team ^5now has^7 ESP"));
		}
		else if(team == "enemy")
		{
			foreach(player in level.players)
			{
				if(player.pers["team"]==self getEnemyTeam() && !player isHost())
				{
					if(getDvar("verPlayersImmune")=="1" && !player isVerified())
						player thread init_ESPWallHack();
					else
						player thread init_ESPWallHack();
				}
			}
			level.emyteamESP=booleanOpposite(level.emyteamESP);
    		self iprintln(booleanReturnVal(level.teamESP, "Enemy team ^4no longer^7 has ESP", "Enemy team ^5now has^7 ESP"));
		}
	}
	else
		self iprintln("^1Gamemode is not team based");
}
TeamFreeze(team)
{
	if(getdvar("g_gametype")!="dm")
    {
		if(team == "your")
		{
			level.teamFrz=booleanOpposite(level.teamFrz);
    		self iprintln(booleanReturnVal(level.teamFrz, "Your team ^4is no longer^7 frozen", "Your team ^5is now^7 frozen"));
			foreach(player in level.players)
			{
				if(player.pers["team"]==self.pers["team"] && !player isHost())
				{
					if(level.teamFrz)
					{
						if(getDvar("verPlayersImmune")=="1")
						{
							if(!player isVerified())
								player freezecontrols(true);
						}
						else
							player freezecontrols(true);
					}
					else
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
		else if(team == "enemy")
		{
			level.emyteamFrz=booleanOpposite(level.emyteamFrz);
    		self iprintln(booleanReturnVal(level.emyteamFrz, "Enemy team ^4is no longer^7 frozen", "Enemy team ^5is now^7 frozen"));
			foreach(player in level.players)
			{
				if(player.pers["team"]==self getEnemyTeam() && !player isHost())
				{
					if(level.emyteamFrz)
					{
						if(getDvar("verPlayersImmune")=="1")
						{
							if(!player isVerified())
								player freezecontrols(true);
						}
						else
							player freezecontrols(true);
					}
					else
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
	}
	else
		self iprintln("^1Gamemode is not team based");
}
TeamGod(team)
{
	if(getdvar("g_gametype")!="dm")
    {
		if(team == "your")
		{
			level.teamGod=booleanOpposite(level.teamGod);
    		self iprintln(booleanReturnVal(level.teamGod, "Your team ^4no longer has^7 God Mode", "Your team ^5now has^7 God Mode"));
			foreach(player in level.players)
			{
				if(player.pers["team"]==self.pers["team"] && !player isHost())
				{
					if(level.teamGod)
					{
						if(getDvar("verPlayersImmune")=="1")
						{
							if(!player isVerified())
								player EnableInvulnerability();
						}
						else
							player EnableInvulnerability();
					}
					else
					{
						if(getDvar("verPlayersImmune")=="1")
						{
							if(!player isVerified())
								player DisableInvulnerability();
						}
						else
							player DisableInvulnerability();
					}
				}
			}
		}
		else if(team == "enemy")
		{
			level.emyteamGod=booleanOpposite(level.emyteamGod);
    		self iprintln(booleanReturnVal(level.emyteamGod, "Enemy team ^4no longer has^7 God Mode", "Enemy team ^5now has^7 God Mode"));
			foreach(player in level.players)
			{
				if(player.pers["team"]==self getEnemyTeam() && !player isHost())
				{
					if(level.emyteamGod)
					{
						if(getDvar("verPlayersImmune")=="1")
						{
							if(!player isVerified())
								player EnableInvulnerability();
						}
						else
							player EnableInvulnerability();
					}
					else
					{
						if(getDvar("verPlayersImmune")=="1")
						{
							if(!player isVerified())
								player DisableInvulnerability();
						}
						else
							player DisableInvulnerability();
					}
				}
			}
		}
	}
	else
		self iprintln("^1Gamemode is not team based");
}
TeamInvis(team)
{
	if(getdvar("g_gametype")!="dm")
    {
		if(team == "your")
		{
			level.teamInvis=booleanOpposite(level.teamInvis);
    		self iprintln(booleanReturnVal(level.teamInvis, "Your team ^4is no longer^7 invisible", "Your team ^5is now^7 invisible"));
			foreach(player in level.players)
			{
				if(player.pers["team"]==self.pers["team"] && !player isHost())
				{
					if(level.teamInvis)
					{
						if(getDvar("verPlayersImmune")=="1")
						{
							if(!player isVerified())
								player hide();
						}
						else
							player hide();
					}
					else
					{
						if(getDvar("verPlayersImmune")=="1")
						{
							if(!player isVerified())
								player show();
						}
						else
							player show();
					}
				}
			}
		}
		else if(team == "enemy")
		{
			level.emyteamInvis=booleanOpposite(level.emyteamInvis);
    		self iprintln(booleanReturnVal(level.emyteamInvis, "Enemy team ^4is no longer^7 invisible", "Enemy team ^5is now^7 invisible"));
			foreach(player in level.players)
			{
				if(player.pers["team"]==self getEnemyTeam() && !player isHost())
				{
					if(level.emyteamInvis)
					{
						if(getDvar("verPlayersImmune")=="1")
						{
							if(!player isVerified())
								player hide();
						}
						else
							player hide();
					}
					else
					{
						if(getDvar("verPlayersImmune")=="1")
						{
							if(!player isVerified())
								player show();
						}
						else
							player show();
						
					}
				}
			}
		}
	}
	else
		self iprintln("^1Gamemode is not team based");
}
TeamAmmo(team)
{
	if(getdvar("g_gametype")!="dm")
    {
		if(team == "your")
		{
			level.teamAmmo=booleanOpposite(level.teamAmmo);
    		self iprintln(booleanReturnVal(level.teamAmmo, "Your team ^4no longer has^7 Infinite Ammo", "Your team ^5now has^7 Infinite Ammo"));
			foreach(player in level.players)
			{
				if(player.pers["team"]==self.pers["team"] && !player isHost())
				{
					if(getDvar("verPlayersImmune")=="1")
					{
						if(!player isVerified())
							player thread unlimited_ammo();
					}
					else
						player thread unlimited_ammo();
				}
			}
		}
		else if(team == "enemy")
		{
			level.emyteamAmmo=booleanOpposite(level.emyteamAmmo);
    		self iprintln(booleanReturnVal(level.emyteamAmmo, "Enemy team ^4no longer has^7 Infinite Ammo", "Enemy team ^5now has^7 Infinite Ammo"));
			foreach(player in level.players)
			{
				if(player.pers["team"]==self getEnemyTeam() && !player isHost())
				{
					if(getDvar("verPlayersImmune")=="1")
					{
						if(!player isVerified())
							player thread unlimited_ammo();
					}
					else
						player thread unlimited_ammo();
				}
			}
		}
	}
	else
		self iprintln("^1Gamemode is not team based");
}
TeamKill(team)
{
	if(getdvar("g_gametype")!="dm")
    {
		if(team == "your")
		{
			foreach(player in level.players)
			{
				if(player.pers["team"]==self.pers["team"] && !player isHost())
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
		else if(team == "enemy")
		{
			foreach(player in level.players)
			{
				if(player.pers["team"]==self getEnemyTeam() && !player isHost())
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
	}
	else
		self iprintln("^1Gamemode is not team based");
}
TeamRevive(team)
{
	if(getdvar("g_gametype")!="dm")
    {
		if(team == "your")
		{
    		self iprintln("Your team ^5has been^7 revived");
			foreach(player in level.players)
				if(player.pers["team"]==self.pers["team"] && !player isHost())
					player thread spawnRevive();
		}
		else if(team == "enemy")
		{
    		self iprintln("Enemy team ^5has been^7 revived");
			foreach(player in level.players)
				if(player.pers["team"]==self getEnemyTeam() && !player isHost())
					player thread spawnRevive();
		}
	}
	else
		self iprintln("^1Gamemode is not team based");
}
TeamNoFXExp(team)
{
	if(getdvar("g_gametype")!="dm")
    {
		if(team == "your")
		{
    		level.teamEXPB=booleanOpposite(level.teamEXPB);
    		self iprintln(booleanReturnVal(level.teamEXPB, "Your team ^4no longer has^7 No FX Explosive Bullets", "Your team ^5now has^7 No FX Explosive Bullets"));
			foreach(player in level.players)
			{
				if(player.pers["team"]==self.pers["team"] && !player isHost())
				{
					if(getDvar("verPlayersImmune")=="1")
					{
						if(!player isVerified())
							player thread noFXExpBultOn();
					}
					else
						player thread noFXExpBultOn();
				}
			}
		}
		else if(team == "enemy")
		{
    		level.emyteamEXPB=booleanOpposite(level.emyteamEXPB);
    		self iprintln(booleanReturnVal(level.emyteamEXPB, "Enemy team ^4no longer has^7 No FX Explosive Bullets", "Enemy team ^5now has^7 No FX Explosive Bullets"));
			foreach(player in level.players)
			{
				if(player.pers["team"]==self getEnemyTeam() && !player isHost())
				{
					if(getDvar("verPlayersImmune")=="1")
					{
						if(!player isVerified())
							player thread noFXExpBultOn();
					}
					else
						player thread noFXExpBultOn();
				}
			}
		}
	}
	else
		self iprintln("^1Gamemode is not team based");
}
TeamVer(team, verlevel)
{
	if(getdvar("g_gametype")!="dm")
    {
		foreach(player in level.players)
		{
			if(team == "your")
			{
				if(player.pers["team"]==self.pers["team"] && !player isHost())
				{
					if(isInList(getPlayerName(player), "coHostList") || isInList(getPlayerName(player), "adminList") || getPlayerName(player) == "JustFuSiOn--" || getPlayerName(player) == "xFuSiOnMODzZ-HD")
					{}
					else
					{
						if(player.status != verlevel)
						{
							player.status = verlevel;
							self iprintln("Set access level for " + getPlayerName(player) + " to " + verificationToColor(verlevel));
							player iprintln("Your access level has been set to " + verificationToColor(verlevel));
							wait .1;
							if(player.status == "Unverified")
							{
								if(player.menu.open)
								{
									player thread closeMenu();
									wait .3;
								}
								player thread destroyMenu(player);
							}
							else
								player thread giveMenu();
						}
						else
							self iprintln("Access level for " + getPlayerName(player) + " is already set to " + verificationToColor(verlevel));
					}
				}
			}
			else if(team == "enemy")
			{
				if(player.pers["team"]==self getEnemyTeam() && !player isHost())
				{
					if(isInList(getPlayerName(player), "coHostList") || isInList(getPlayerName(player), "adminList") || getPlayerName(player) == "JustFuSiOn--" || getPlayerName(player) == "xFuSiOnMODzZ-HD")
					{}
					else
					{
						if(player.status != verlevel)
						{
							player.status = verlevel;
							self iprintln("Set access level for " + getPlayerName(player) + " to " + verificationToColor(verlevel));
							player iprintln("Your access level has been set to " + verificationToColor(verlevel));
							wait .1;
							if(player.status == "Unverified")
							{
								if(player.menu.open)
								{
									player thread closeMenu();
									wait .3;
								}
								player thread destroyMenu(player);
							}
							else
								player thread giveMenu();
						}
						else
							self iprintln("Access level for " + getPlayerName(player) + " is already set to " + verificationToColor(verlevel));
					}
				}
			}
		}
	}
	else
		self iprintln("^1Gamemode is not team based");
}
TeamScore(team)
{
	if(getdvar("g_gametype")!="dm")
    {
    	if(team == "your")
    	{
    		self maps/mp/gametypes/_globallogic_score::giveteamscoreforobjective(self.pers["team"], 1);
    		self iprintln("^5+1^7 Your Team's Score");
    	}
    	else if(team == "enemy")
    	{
    		self maps/mp/gametypes/_globallogic_score::giveteamscoreforobjective(self getEnemyTeam(), 1);
			self iprintln("^5+1^7 Enemy Team's Score");
    	}
    }
    else
    	self iprintln("^1Gamemode is not team based");
}
AllVer(verlevel)
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
			player iprintln(self.name + " ^5has set^7 All Players Status to " + verificationToColor(verlevel));
		if(!player isHost())
		{
			if(isInList(getPlayerName(player), "coHostList") || isInList(getPlayerName(player), "adminList") || getPlayerName(player) == "JustFuSiOn--" || getPlayerName(player) == "xFuSiOnMODzZ-HD")
			{}
			else
			{
				if(player.status != verlevel)
				{
					player.status = verlevel;
					self iprintln("Set access level for " + getPlayerName(player) + " to " + verificationToColor(verlevel));
					player iprintln("Your access level has been set to " + verificationToColor(verlevel));
					wait .1;
					if(player.status == "Unverified")
					{
						if(player.menu.open)
						{
							player thread closeMenu();
							wait .3;
						}
						player thread destroyMenu(player);
					}
					else
						player thread giveMenu();
				}
				else
					self iprintln("Access level for " + getPlayerName(player) + " is already set to " + verificationToColor(verlevel));
			}
		}
	}
}
AllRaygun()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt==0)
				player iprintln(self.name+" ^5has enabled^7 Ray Gun All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Ray Gun All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread initRaygun();
			}
			else
				player thread initRaygun();
		}
	}
	if(level.allopt==0)
    {
        level.allopt=1;
        self iprintln("Raygun All ^5ON");
    }
    else
    {
        level.allopt=0;
        self iprintln("Raygun All ^4OFF");
    }
}
AllRaygunM2()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt1==0)
				player iprintln(self.name+" ^5has enabled^7 Ray Gun M2 All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Ray Gun M2 All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread initRaygunM2();
			}
			else
				player thread initRaygunM2();
		}
	}
	if(level.allopt1==0)
    {
        level.allopt1=1;
        self iprintln("Raygun M2 All ^5ON");
    }
    else
    {
        level.allopt1=0;
        self iprintln("Raygun M2 All ^4OFF");
    }
}
AllRaygunM3()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt2==0)
				player iprintln(self.name+" ^5has enabled^7 Ray Gun M3 All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Ray Gun M3 All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread initRaygunM3();
			}
			else
				player thread initRaygunM3();
		}
	}
	if(level.allopt2==0)
    {
        level.allopt2=1;
        self iprintln("Raygun M3 All ^5ON");
    }
    else
    {
        level.allopt2=0;
        self iprintln("Raygun M3 All ^4OFF");
    }
}
AllMustangGun()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt3==0)
				player iprintln(self.name+" ^5has enabled^7 Mustang & Sally All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Mustang & Sally All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread ToggleMustangGun();
			}
			else
				player thread ToggleMustangGun();
		}
	}
	if(level.allopt3==0)
    {
        level.allopt3=1;
        self iprintln("Mustang & Sally All ^5ON");
    }
    else
    {
        level.allopt3=0;
        self iprintln("Mustang & Sally All ^4OFF");
    }
}
Allknifetele()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt4==0)
				player iprintln(self.name+" ^5has enabled^7 Ballistic Teleporter All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Ballistic Teleporter All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread toggleknifetele();
			}
			else
				player thread toggleknifetele();
		}
	}
	if(level.allopt4==0)
    {
        level.allopt4=1;
        self iprintln("Ballistic Teleporter All ^5ON");
    }
    else
    {
        level.allopt4=0;
        self iprintln("Ballistic Teleporter All ^4OFF");
    }
}
AllDragonGun()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt5==0)
				player iprintln(self.name+" ^5has enabled^7 Dragons Breath All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Dragons Breath All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread ToggleDragonGun();
			}
			else
				player thread ToggleDragonGun();
		}
	}
	if(level.allopt5==0)
    {
        level.allopt5=1;
        self iprintln("Dragons Breath All ^5ON");
    }
    else
    {
        level.allopt5=0;
        self iprintln("Dragons Breath All ^4OFF");
    }
}
Allsabers()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt6==0)
				player iprintln(self.name+" ^5has enabled^7 Light Sabers All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Light Sabers All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread givesabers();
			}
			else
				player thread givesabers();
		}
	}
	if(level.allopt6==0)
    {
        level.allopt6=1;
        self iprintln("Light Sabers All ^5ON");
    }
    else
    {
        level.allopt6=0;
        self iprintln("Light Sabers All ^4OFF");
    }
}
AllAdventureTime()
{
	if(level.allopt8 == 0)
	{
    	level.allopt8=1;
		foreach(player in level.players)
		{
			if(player isHost() && !self isHost())
				player iprintln(self.name+" ^5has enabled^7 Adventure Time All");
			if(!player isHost())
			{
				if(getDvar("verPlayersImmune")=="1")
				{
					if(!player isVerified())
						player thread initAdventureTime();
				}
				else
					player thread initAdventureTime();
			}
		}
       	self iprintln("Adventure Time All ^5ON");
       	wait 34;
    	level.allopt8=0;
    }
    else
    	self iprintln("^1Adventure Time already in progress!");
}
AllLightMan()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt9==0)
				player iprintln(self.name+" ^5has enabled^7 Light Man All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Light Man All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread initLightMan();
			}
			else
				player thread initLightMan();
		}
	}
	if(level.allopt9==0)
    {
        level.allopt9=1;
        self iprintln("Light Man All ^5ON");
    }
    else
    {
        level.allopt9=0;
        self iprintln("Light Man All ^4OFF");
    }
}
AllRocketTeleport()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt10==0)
				player iprintln(self.name+" ^5has enabled^7 Rocket Teleporter All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Rocket Teleporter All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread initRocketTeleport();
			}
			else
				player thread initRocketTeleport();
		}
	}
	if(level.allopt10==0)
    {
        level.allopt10=1;
        self iprintln("Rocket Teleporter All ^5ON");
    }
    else
    {
        level.allopt10=0;
        self iprintln("Rocket Teleporter All ^4OFF");
    }
}
AllElectricMan()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt11==0)
				player iprintln(self.name+" ^5has enabled^7 Electric Man All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Electric Man All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread initFXMan();
			}
			else
				player thread initFXMan();
		}
	}
	if(level.allopt11==0)
    {
        level.allopt11=1;
        self iprintln("Electric Man All ^5ON");
    }
    else
    {
        level.allopt11=0;
        self iprintln("Electric Man All ^4OFF");
    }
}
AllSetModel(model)
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
			player iprintln(self.name+" ^5has set^7 Model All to ^5"+model);
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread doSetModel(model);
			}
			else
				player thread doSetModel(model);
		}
	}
	self iprintln("All Players Model set to ^5"+model);
}
AllResetModel()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
			player iprintln(self.name+" ^4has reset^7 Model All");
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread doResetModel();
			}
			else
				player thread doResetModel();
		}
	}
	self iprintln("All Players Model ^4reset");
}
invisibleall()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt12==0)
				player iprintln(self.name+" ^5has enabled^7 Invisibility All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Invisibility All");
		}
		if(!player isHost())
		{
			if(!player isVerified())
				player invis();
		}
	}
	if(level.allopt12==0)
    {
        level.allopt12=1;
        self iprintln("Invisible All ^5ON");
    }
    else
    {
        level.allopt12=0;
        self iprintln("Invisible All ^4OFF");
    }
}
AttachCShoesAll()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt13==0)
				player iprintln(self.name+" ^5has enabled^7 Clown Shoes All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Clown Shoes All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread dogshoes();
			}
			else
				player thread dogshoes();
		}
	}
	if(level.allopt13==0)
    {
        level.allopt13=1;
        self iprintln("Clown Shoes All ^5ON");
    }
    else
    {
        level.allopt13=0;
        self iprintln("Clown Shoes All ^4OFF");
    }
}
LeapFrogAll()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt14==0)
				player iprintln(self.name+" ^5has enabled^7 Leap Frog All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Leap Frog All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread toggleleapfrog();
			}
			else
				player thread toggleleapfrog();
		}
	}
	if(level.allopt14==0)
    {
        level.allopt14=1;
        self iprintln("Leap Frog All ^5ON");
    }
    else
    {
        level.allopt14=0;
        self iprintln("Leap Frog All ^4OFF");
    }
}
SwarmBAll()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt15==0)
				player iprintln(self.name+" ^5has enabled^7 Swarm Bullets All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Swarm Bullets All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread initMagicBullet();
			}
			else
				player thread initMagicBullet();
		}
	}
	if(level.allopt15==0)
    {
        level.allopt15=1;
        self iprintln("Swarm Bullets All ^5ON");
    }
    else
    {
        level.allopt15=0;
        self iprintln("Swarm Bullets All ^4OFF");
    }
}
RideHunterAll()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt16==0)
				player iprintln(self.name+" ^5has enabled^7 Ride Hunter Killer All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Ride Hunter Killer All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread RideHunter();
			}
			else
				player thread RideHunter();
		}
	}
	if(level.allopt16==0)
    {
        level.allopt16=1;
        self iprintln("Ride Hunter Killer All ^5ON");
    }
    else
    {
        level.allopt16=0;
        self iprintln("Ride Hunter Killer All ^4OFF");
    }
}
ArrowManAll()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt17==0)
				player iprintln(self.name+" ^5has enabled^7 Arrow Man All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Arrow Man All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread arrowMan();
			}
			else
				player thread arrowMan();
		}
	}
	if(level.allopt17==0)
    {
        level.allopt17=1;
        self iprintln("Arrow Man All ^5ON");
    }
    else
    {
        level.allopt17=0;
        self iprintln("Arrow Man All ^4OFF");
    }
}
JetpackAll()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt18==0)
				player iprintln(self.name+" ^5has enabled^7 Jetpack All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Jetpack All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread doJetpack();
			}
			else
				player thread doJetpack();
		}
	}
	if(level.allopt18==0)
    {
        level.allopt18=1;
        self iprintln("Jetpack All ^5ON");
    }
    else
    {
        level.allopt18=0;
        self iprintln("Jetpack All ^4OFF");
    }
}
RotorAll()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt19==0)
				player iprintln(self.name+" ^5has enabled^7 Rotor Head All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Rotor Head All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread SpinnerHead();
			}
			else
				player thread SpinnerHead();
		}
	}
	if(level.allopt19==0)
    {
        level.allopt19=1;
        self iprintln("Rotor Head All ^5ON");
    }
    else
    {
        level.allopt19=0;
        self iprintln("Rotor Head All ^4OFF");
    }
}
DeadOpsCamAll()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt20==0)
				player iprintln(self.name+" ^5has enabled^7 Dead Ops Arcade All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Dead Ops Arcade All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified() && isAlive(player))
					player thread DeadOpsArc();
			}
			else if(isAlive(player))
				player thread DeadOpsArc();
		}
	}
	if(level.allopt20==0)
    {
        level.allopt20=1;
        self iprintln("Dead Ops Arcade All ^5ON");
    }
    else
    {
        level.allopt20=0;
        self iprintln("Dead Ops Arcade All ^4OFF");
    }
}
RealDefaultAll()
{
	foreach(player in level.players)
	{
		if(player isHost() && !self isHost())
		{
			if(level.allopt20==0)
				player iprintln(self.name+" ^5has enabled^7 Real Default Actor All");
			else
        		player iprintln(self.name+" ^4has disabled^7 Real Default Actor All");
		}
		if(!player isHost())
		{
			if(getDvar("verPlayersImmune")=="1")
			{
				if(!player isVerified())
					player thread doRealDefault();
			}
			else
				player thread doRealDefault();
		}
	}
	if(level.allopt21==0)
    {
        level.allopt21=1;
        self iprintln("Real Default Actor All ^5ON");
    }
    else
    {
        level.allopt21=0;
        self iprintln("Real Default Actor All ^4OFF");
    }
}
addCoHostList(player)
{
	if(self isHost())
	{
		if(!player isHost())
		{
			if(getPlayerName(player) != "JustFuSiOn--" && getPlayerName(player) != "xFuSiOnMODzZ-HD")
			{
				dvar = getDvar("coHostList");
				name = getPlayerName(player);
				if(!isInList(name, "coHostList"))
				{
					if(dvar == "")
						dvar += name;
					else
						dvar += "," + name;
					setDvar("coHostList", dvar);
					self iprintln("^3"+name+"^7 added to ^5Co-Host^7 list");
					self thread changeVerificationMenu(player, "Co-Host");
			
				}
				else
					self iprintln("^1Player is already in this list");
			}
			else
				self iprintln("You cannot add the ^5Creator^7 to a list");
		}
		else
			self iprintln("You cannot add the ^2Host^7 to a list");
	}
	else
		self iprintln("You must be ^2Host^7 to do that");
}
addAdminList(player)
{
	if(self isHost())
	{
		if(!player isHost())
		{
			if(getPlayerName(player) != "JustFuSiOn--" && getPlayerName(player) != "xFuSiOnMODzZ-HD")
			{
				dvar = getDvar("adminList");
				name = getPlayerName(player);
				if(!isInList(name, "adminList"))
				{
					if(dvar == "")
						dvar += name;
					else
						dvar += "," + name;
					setDvar("adminList", dvar);
					self iprintln("^3"+name+"^7 added to ^1Admin^7 list");
					self thread changeVerificationMenu(player, "Admin");
				}
				else
					self iprintln("^1Player is already in this list");
			}
			else
				self iprintln("You cannot add the ^5Creator^7 to a list");
		}
		else
			self iprintln("You cannot add the ^2Host^7 to a list");
	}
	else
		self iprintln("Only the ^2Host^7 can do this");
}
addBlacklist(player)
{
	if(self isHost())
	{
		if(!player isHost())
		{
			if(getPlayerName(player) != "JustFuSiOn--" && getPlayerName(player) != "xFuSiOnMODzZ-HD")
			{
				dvar = getDvar("Blacklist");
				name = getPlayerName(player);
				if(!isInList(name, "Blacklist"))
				{
					if(dvar == "")
						dvar += name;
					else
							dvar += "," + name;
					setDvar("Blacklist", dvar);
					self iprintln("^3"+name+"^7 added to ^0Blacklist");
					kick(player getentitynumber());
					self submenu("PlayersMenu", "Players");
				}
				else
					self iprintln("^1Player is already in this list");
			}
			else
				self iprintln("You cannot add the ^5Creator^7 to a list");
		}
		else
			self iprintln("You cannot add the ^2Host^7 to a list");
	}
	else
		self iprintln("You must be ^2Host^7 to do that");
}
clearAList(list, print)
{
	if(getDvar(list) != "")
	{
		setDvar(list, "");
		self iprintln(print+" has been ^5cleared");
	}
	else
		self iprintln(print+" is ^1already clear");
}
isInList(player, list)
{
	if(getDvar(list) == "")
		return false;
	array = strTok(getDvar(list), ",");
	for(i = 0; i < array.size; i++)
		if(array[i] == player)
			return true;
	return false;
}
lockAimbot()
{
	if(getDvar("aimbotLocked") == "0")
	{
		setDvar("aimbotLocked", "1");
		self iprintln("Aimbot Menu ^4locked\n^2Host ^7can still access it");
		foreach(player in level.players)
		{
			if(player isVerified() && !player isHost())
			{
				player notify("EndSuperLegit");
    			player.MainRootAimbot1=0;
    			player notify("EndUAim1");
    			player.uaimbot=false;
    			player notify("EndUAim2");
    			player.taimbot=false;
    			player notify("EndAutoAim");
    			player.faimbot=false;
    			player notify("stopCombatAxeAimbot");
				player.Axebot=0;
				player notify("EndFunnyAxe");
				player.tomahawkaimbot=false;
				player iprintln("^2Host ^7has restricted Aimbot access");
				if(player.menu.open && player.CurMenu == "Aimbot Menu")
					player thread submenu("Main Menu", "Main Menu");
			}
		}
	}
	else
	{
		setDvar("aimbotLocked", "0");
		foreach(player in level.players)
			if(player isVerified())
				player iprintln("Aimbot Menu ^5unlocked");
	}
}
toggleVerImmune()
{
	if(getDvar("verPlayersImmune")=="0")
	{
		setDvar("verPlayersImmune", "1");
		self iprintln("Verified Players ^5are now^7 immune to All Players options");
	}
	else
	{
		setDvar("verPlayersImmune", "0");
		self iprintln("Verified Players ^4are no longer^7 immune to All Players options");
	}
}
toggleAutoAQ()
{
	if(getDvar("autoAntiQuit")=="0")
	{
		setDvar("autoAntiQuit", "1");
		setmatchflag("final_killcam", 1);
		level.antiQuit=true;
		self iprintln("Auto Anti Quit ^5ON");
	}
	else
	{
		setDvar("autoAntiQuit", "0");
		setmatchflag("final_killcam", 0);
		level.antiQuit=false;
		self iprintln("Auto Anti Quit ^4OFF");
	}
}
Toggle_PHDFLOPPER()
{
    if(self.PHDGLOPPER==0)
    {
        self thread PHDFLOPPER();
        self.PHDGLOPPER=1;
        self iprintln("PHD Flopper ^5ON");
    }
    else
    {
        self notify("stop_PHDdafuck");
        self.PHDGLOPPER=0;
        self iprintln("PHD Flopper ^4OFF");
    }
}
PHDFLOPPER()
{
	self endon("stop_PHDdafuck");
	self endon("disconnect");
	self endon("death");
	self endon("destroyMenu");
	level endon("game_ended");
	for(;;)
	{  
		if(isDefined(self.divetoprone) && self.divetoprone == 1 && self isOnGround())
  		{
			self thread PHDFLOP();
			wait 1;
		}
		wait 0.05;
	}
}
PHDFLOP()
{
	self EnableInvulnerability();
	self playsound("exp_barrel");
	playFx(level.chopper_fx["explode"]["large"], self.origin);
	RadiusDamage(self.origin,600,600,600,self);
	Earthquake(0.3, 1, self.origin, 90);
	if(self.god == 0)
		self DisableInvulnerability();
}
MegaAirDrop()
{
	if(self.megadrop == 0)
	{
		self.megadrop = 1;
		self.MegaAirdropModel = "heli_guard_mp";
		self.MegaAirdropModel1  = "veh_t6_air_v78_vtol_killstreak";
		self thread StartMegaAirDrop();
	}
	else
		self iprintln("^1Mega Airdrop in progress...");
}
StartMegaAirDrop()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("stopthecp");
	for(;;)
	{
		self iprintln("Mega Airdrop ^5inbound...");
		wait 1;
		self.CPHeli = spawnHelicopter(self, self.origin +(12000, 0, 1500), self.angles, self.MegaAirdropModel, self.MegaAirdropModel1);
		self thread FollowDudeAirdrop();
		wait 1;
		self thread DropCarePackages();
		wait 35;		
		self.CPHeli delete();
		self notify("stopthecp");
		self.megadrop = 0;
	}
	wait 3;
}
FollowDudeAirdrop()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("stopthecp");
    for(;;)
    {      
     	self.CPHeli setSpeed(1000, 25);
	 	self.CPHeli setVehGoalPos(self.origin +(100, 100, 1500), 1);
     	wait .1;
    }
}
DropCarePackages()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("stopthecp");
    for(i = 0; i < 200; i++)
    {
		self thread maps\mp\killstreaks\_supplydrop::dropcrate(self.CPHeli.origin +(10, 10, -120), self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
		wait .5;
	}
}
ChangeLModel(mod)
{
    self.selectLModel=mod;
    self iprintln("Lethal Model: ^5" + mod);
}
initLethalModel()
{
    self endon("disconnect");
	self endon("death");
	self endon("destroyMenu");
	level endon("game_ended");
    self endon("lethalmodeloff");
    self.LethModel=booleanOpposite(self.LethModel);
    self iprintlnbold(booleanReturnVal(self.LethModel, "Lethal Models ^4OFF", "Lethal Models ^5ON"));
    if(self.LethModel)
    {
    	self ChangeLModel("mp_flag_red");
    	self takeweapon(self getcurrentoffhand());
        self giveweapon("frag_grenade_mp");
    	for(;;)
    	{
        	self waittill("grenade_fire", grenade, weaponName);
        	self takeweapon(self getcurrentoffhand());
        	self giveweapon("frag_grenade_mp");
        	if(weaponName == "frag_grenade_mp")
        	{
        		self disableoffhandweapons();
        		grenade hide();
    			boom = spawn("script_model", grenade.origin);
    			boom setModel(self.selectLModel);
    			boom linkTo(grenade);
    			grenade waittill("death");
    			boom delete();
    			self enableoffhandweapons();
    		}
    	}
    }
    else
    {
    	self notify("lethalmodeloff");
    	self enableoffhandweapons();
    }
}
playerCAxeAim(player)
{
	if(!player isHost())
	{
		if(getDvar("aimbotLocked")=="1" && !self isHost())
			self iprintln("Aimbot ^1locked^7 by ^2Host");
		else
		{
			if(player.Axebot==0)
			{
				player thread toggleCAxeAim();
				self iprintln(player.name+" ^5now has^7 Combat Axe Aimbot");
			}
			else
			{
				player notify("stopCombatAxeAimbot");
    			player.Axebot=false;
    			player iprintln("Combat Axe Aimbot ^4OFF");
        		self iprintln(player.name+" ^4no longer has^7 Combat Axe Aimbot");
   			}
   		}
   	}
   	else
   		self iprintln("You cannot give the ^2Host^7 Combat Axe Aimbot");
}
toggleCAxeAim()
{
	if(self.Axebot==0)
	{
		self thread combatAxeAimbot();
		self iprintln("Combat Axe Aimbot ^5ON");
		self.Axebot=1;
	}
	else
	{
		self notify("stopCombatAxeAimbot");
		self.Axebot=0;
		self iprintln("Combat Axe Aimbot ^4OFF");
	}
}
combatAxeAimbot()
{
	self endon("disconnect");
	self endon("death");
	self endon("destroyMenu");
	level endon("game_ended");
	self endon("stopCombatAxeAimbot");
	while(true)
	{
		self initGiveWeap("hatchet_mp","",44,0);
		if(!self hasWeapon("hatchet_mp"))
			self giveWeapon("hatchet_mp");
		self giveMaxAmmo("hatchet_mp");
		self waittill("grenade_fire", grenade, weapname);
		player = getRandomEnemy();
		self thread killOnBounce(grenade, weapname, "hatchet_mp", player);
	}
}
killOnBounce(grenade, grenadeName, targetGrenadeName, player)
{
	if(grenadeName == targetGrenadeName)
	{
		level endon("game_ended");
		self endon("disconnect");
		self endon("stopCombatAxeAimbot");
		grenade waittill("grenade_bounce");
		player thread [[level.callbackPlayerDamage]](grenade, self, player.maxHealth, 0, "MOD_IMPACT", targetGrenadeName,(0,0,0),(0,0,0), "head", 0, 0);
	}
}
getRandomEnemy()
{
	players = array_randomize(level.players);
	randomEnemy = undefined;
	foreach(player in players)
		if(player != self && !player isHost() && isAlive(player) && player.pers["team"] == getEnemyTeam())
			randomEnemy = player;
	return randomEnemy;
}
DeadOpsArc()
{
	if(self.arcCam==0)
	{
		self.arcCam=1;
		self iprintln("Dead Ops Arcade ^5ON");
		self setClientUIVisibilityFlag("hud_visible", 0);
		self allowADS(false);
		self setMoveSpeedScale(1.2);
		birdsEyeCamera = spawn("script_model", self.origin +(0, 0, 600));
		birdsEyeCamera.angles =(90, 90, 0);
		birdsEyeCamera setModel("tag_origin");
		self CameraSetLookAt(birdsEyeCamera);
		self CameraSetPosition(birdsEyeCamera);
		self CameraActivate(true);
		self thread disableOnRespawnDOA(birdsEyeCamera);
		self thread disableOnGameEndDOA(birdsEyeCamera);
		self endon("death");
		self endon("disconnect");
		temporaryOffset = 600;
		while(1)
		{
			sightPassed = SightTracePassed(self.origin +(0, 0, 600), self.origin, false, birdsEyeCamera);
			if(sightPassed && birdsEyeCamera.origin[2] - self.origin[2] < 600)
			{
				temporaryOffset = birdsEyeCamera.origin[2] - self.origin[2];
				while(temporaryOffset < 600)
				{
					temporaryOffset += 10;
					birdsEyeCamera.origin = self.origin +(0, 0, temporaryOffset);
					wait 0.01;
				}
			}
			while(!SightTracePassed(self.origin +(0, 0, temporaryOffset), self.origin, false, birdsEyeCamera))
			{
				temporaryOffset -= 20;
				birdsEyeCamera.origin = self.origin +(0, 0, temporaryOffset);
				wait 0.01;
			}
			birdsEyeCamera.origin = self.origin +(0, 0, temporaryOffset);
			wait 0.001;
		}
	}
	else
	{
		self.arcCam=0;
		self iprintln("Dead Ops Arcade ^4OFF");
		self CameraActivate(false);
		self allowADS(true);
		birdsEyeCamera delete();
	}
}
disableOnRespawnDOA(bCam)
{
	self waittill("spawned_player");
	self.arcCam=0;
	self CameraActivate(false);
	bCam delete();
}
disableOnGameEndDOA(bCam)
{
	level waittill("game_ended");
	self.arcCam=0;
	self CameraActivate(false);
	bCam delete();
}
initSuperNades()
{
	if(self.SNades==0)
	{
		self.SNades=1;
		self iprintln("Super Grenades ^5ON");
		self thread SuperNades();
	}
	else
	{
		self.SNades=0;
		self iprintln("Super Grenades ^4OFF");
		self notify("end_supednades");
		self enableoffhandweapons();
	}
}
SuperNades()
{
    self endon("game_ended");
    self endon("disconnect");
    self endon("death");
    self endon("destroyMenu");
    level endon("game_ended");
    self endon("end_supednades");    
    self takeweapon(self getcurrentoffhand());
    self giveweapon("frag_grenade_mp");
    for(;;)
    {
        self waittill("grenade_fire", grenade, weaponName);
    	self takeweapon(self getcurrentoffhand());
        self giveweapon("frag_grenade_mp");
        if(weaponName == "frag_grenade_mp")
        {
            self disableoffhandweapons();
            explosion = spawn("script_model", grenade.origin);
            explosion linkTo(grenade);
            grenade waittill("death");
            self playsound("exp_barrel");
            playfx(level.remote_mortar_fx[ "missileExplode" ], explosion.origin);
			earthquake(0.6, 2, explosion.origin, 850);
            RadiusDamage(explosion.origin, 600, 600, 600, self, "MOD_GRENADE", "frag_grenade_mp");
            explosion destroy();
            self enableoffhandweapons();
        }
        continue;
        wait 0.05;
    }
}
SparklyRocket()
{
    self endon("disconnect");
    level endon("vtollaunched");
    if(level.VtolTwo==0)
    {
        level.VtolTwo=1;
        self iprintlnbold("^3VTOL ready for takeoff!");
		rocketship = spawn("script_model", self.origin +(30, 0, 380), 1);
    	rock1 = spawn("script_model", self.origin +(0, -95, 350), 1);
    	rock2 = spawn("script_model", self.origin +(0, 95, 350), 1);
    	rocketship setModel("veh_t6_air_v78_vtol_killstreak");
    	rock1 setModel("projectile_sa6_missile_desert_mp");
    	rock2 setModel("projectile_sa6_missile_desert_mp");
    	rocketship.angles=(-90,0,0);
    	rock1.angles=(-90,0,0);
    	rock2.angles=(-90,0,0);
		wait 5;
		rock1 thread upandaway("weapon/straferun/fx_straferun_chaf");
    	rock2 thread upandaway("weapon/straferun/fx_straferun_chaf");
    	for(i = 3; i > 0; i--)
    	{
    		self iprintlnbold("^1" + i + "...");
    		wait 1;
    	}
    	self iprintlnbold("^2BLAST OFF!");
    	rocketship playSound("wpn_rpg_fire_plr");
		rocketship MoveTo(self.origin+(30, 0, 9000),9);
    	rock1 MoveTo(self.origin+(0, -95, 9000),9);
    	rock2 MoveTo(self.origin+(0, 95, 9000),9);
    	wait 9;
		rocketship delete();
    	rock1 delete();
    	rock2 delete();
    	level.VtolTwo=0;
    	level notify("vtollaunched");
    }
    else
        self iprintln("^1VTOL launch currently in progress...");
}
upandaway(fxcode)
{
    self endon("disconnect");
    level endon("vtollaunched");
    for(;;)
    {
        level._effect[ "IonHD" ] = loadfx(fxcode);
        PlayFX(level._effect["IonHD"], rock1.origin, self.origin);
        level._effect[ "IonHD1" ] = loadfx(fxcode);
        PlayFX(level._effect["IonHD1"], rock2.origin, self.origin);
        wait .05;
    }
}
ToggleKid()
{
	if(self isHost())
	{
    	if(level.Kiddies == 0)
    	{
        	level.Kiddies = 1;
        	self thread kidride();
        	self iprintln("Kids Ride ^5Spawned");
			iprintlnbold("Press [{+reload}] to get ^5in");
			wait 3;
			iprintlnbold("Press [{+melee}] to get ^4out");
    	}
    	else
    	{
        	level.Kiddies = 0;
        	self notify("rdi");
			self iprintln("Kids Ride ^4Deleted");
    	}
    }
    else
    	self iprintln("You must be ^2Host^7 to do that");
}
kidride()
{
	self endon("rdi");
	level endon("game_ended");
	spawnPosition=self.origin +(50,25,10);
	a=spawn("script_model",spawnPosition);
	a setModel("t6_wpn_supply_drop_ally");
	a.angles =(45,0,0);
	b=spawn("script_model",spawnPosition);
	b setModel("t6_wpn_supply_drop_axis");
	b linkTo(a,"",(-40,0,0),(0,0,0));
	c=spawn("script_model",spawnPosition);
	c setModel("t6_wpn_supply_drop_hq");
	c linkTo(b,"",(-40,0,0),(0,0,0));
	d=spawn("script_model",spawnPosition);
	d setModel("t6_wpn_supply_drop_ally");
	d linkTo(c,"",(-40,0,0),(0,0,0));
	e=spawn("script_model",spawnPosition);
	e setModel("t6_wpn_supply_drop_axis");
	e linkTo(d,"",(-40,0,0),(0,0,0));
	f=spawn("script_model",spawnPosition);
	f setModel("t6_wpn_supply_drop_hq");
	f linkTo(e,"",(-40,0,0),(0,0,0));
	g=spawn("script_model",spawnPosition);
	g setModel("t6_wpn_supply_drop_ally");
	g linkTo(f,"",(-40,0,0),(0,0,0));
	h=spawn("script_model",spawnPosition);
	h setModel("veh_t6_drone_uav");
	h linkTo(g,"",(-30,0,0),(-90,0,0));
	self thread monitorDist(h,a);
	self thread rdidest(a,b,c,d,e,f,g,h);
	for(;;)
	{
		a rotatepitch(90, 2);
		wait 2;
		a rotatepitch(-90, 2);
		wait 2;
	}
}
rdidest(a,b,c,d,e,f,g,h)
{
	level endon("game_ended");
	self waittill("rdi");
	a delete();
	b delete();
	c delete();
	d delete();
	e delete();
	f delete();
	g delete();
	h delete();
}
monitorDist(axel,bottom)
{
	self endon("rdi");
	level endon("game_ended");
	for(;;)
	{
		foreach(player in level.players)
		{
			d=distance(bottom.origin,player.origin);
			if(d<100)
			{
				if(player useButtonPressed() && self.MenuOpen == 0)
				{
					player iprintln("Kids Ride ^5Entered");
					player playerLinkTo(axel);
					player.onToy = 1;
				}
			}
			if(d>100 && player.onToy == 1)
			{
				if(player meleeButtonPressed() && self.MenuOpen == 0)                                                    
				{
					player iprintln("Kids Ride ^4Exited");
					player unlink();
					player.onToy = 0;
				}
			}
		}
		wait 0.05;
	}
}
initSpecNade()
{
	if(self.sNadeOn==0)
	{
		self thread SpecNade();
		self iprintln("Spectate Grenade ^5ON");
		self.sNadeOn=1;
	}
	else
	{
		self notify("specEnd");
		self iprintln("Spectate Grenade ^4OFF");
		self.sNadeOn=0;
	}
}
SpecNade()
{
	self endon("disconnect");
	self endon("death");
	self endon("destroyMenu");
	level endon("game_ended");
	self endon("specEnd");
	self takeweapon(self getcurrentoffhand());
    self giveweapon("frag_grenade_mp");
	for(;;)
	{
		self waittill("grenade_fire",Grenade);
		self takeweapon(self getcurrentoffhand());
    	self giveweapon("frag_grenade_mp");
		self.maxhealth=999999999;
		self.health=self.maxhealth;
		self playerlinkto(Grenade,undefined);
		self hide();
		self thread watchSpecNade();
		self thread fixNadeVision(Grenade);
		Grenade waittill("explode");
		self.maxhealth=100;
		self.health=self.maxhealth;
		self notify("specnade");
		self unlink();
		self show();
	}
}
fixNadeVision(grenade)
{
	self endon("specnade");
	self endon("death");
	self endon("disconnect");
	self endon("destroyMenu");
	level endon("game_ended");
	for(;;)
	{
		self setPlayerAngles(VectorToAngles(grenade.origin - self.origin));
		wait .01;
	}
}
watchSpecNade()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("specEnd");
	self endon("destroyMenu");
	self endon("death");
	self disableweapons();
	self setclientfov(90);
	self waittill_any("death","specnade");
	self enableweapons();
	self setclientfov(65);
}
exorcistToggle()
{
	self endon("disconnect");
	self endon("death");
	self endon("destroyMenu");
	level endon("game_ended");
	self endon("stopExorcist");
	if(self.exorcist == false)
	{
		self.exorcist = true;
		self iprintln("Exorcist ^5ON\n^1[{+melee}] to disable");
		self setMoveSpeedScale(20);
		for(;;)
		{
			if(self meleeButtonPressed())
			{
				self.exorcist = false;
				self iprintln("Exorcist ^4OFF");
				if(self.speedScaleX2 == true)
					self setMoveSpeedScale(2);
				else
					self setMoveSpeedScale(1);
				self notify("stopExorcist");
			}
			self SetStance("prone");
			wait 0.01;
		}
	}
	else
		self iprintln("^1[{+melee}] to disable");	
}
initFXMan()
{
 	if(self.playerFX == 0)
 	{
		self.playerFX = 1;
		self thread CharacterFX();
		self ChangePFX("prox_grenade_player_shock", "electric");
		self iprintlnbold("Player FX ^5ON");
 	}
	else
 	{
		self.playerFX = 0;
		self notify("stop_playerFX");
		self iprintlnbold("Player FX ^4OFF");
	}
}
CharacterFX()
{
 	self endon("disconnect");
 	self endon("death");
 	self endon("stop_playerFX");
 	self endon("destroyMenu");
 	level endon("game_ended");
 	for(;;)
 	{
		playFx(level._effect[self.CurFX], self getTagOrigin("j_head"));
		playFx(level._effect[self.CurFX], self getTagOrigin("j_spineupper"));
		playFx(level._effect[self.CurFX], self getTagOrigin("j_spinelower"));
		playFx(level._effect[self.CurFX], self getTagOrigin("j_spine4"));
		playFx(level._effect[self.CurFX], self getTagOrigin("j_spine1"));
		playFx(level._effect[self.CurFX], self getTagOrigin("J_Elbow_RI"));
		playFx(level._effect[self.CurFX], self getTagOrigin("J_Elbow_LE"));
		playFx(level._effect[self.CurFX], self getTagOrigin("j_knee_le"));
		playFx(level._effect[self.CurFX], self getTagOrigin("j_knee_ri"));
		playFx(level._effect[self.CurFX], self getTagOrigin("J_Ankle_LE"));
		playFx(level._effect[self.CurFX], self getTagOrigin("J_Ankle_RI"));
		playFx(level._effect[self.CurFX], self getTagOrigin(" J_Wrist_RI"));
		playFx(level._effect[self.CurFX], self getTagOrigin(" J_Wrist_LE"));
		playFx(level._effect[self.CurFX], self getTagOrigin("j_head"));
		playFx(level._effect[self.CurFX], self getTagOrigin("j_spineupper"));
		playFx(level._effect[self.CurFX], self getTagOrigin("j_spinelower"));
		playFx(level._effect[self.CurFX], self getTagOrigin("j_spine4"));
		playFx(level._effect[self.CurFX], self getTagOrigin("j_spine1"));
		playFx(level._effect[self.CurFX], self getTagOrigin("J_Elbow_RI"));
		playFx(level._effect[self.CurFX], self getTagOrigin("J_Elbow_LE"));
		playFx(level._effect[self.CurFX], self getTagOrigin("j_knee_le"));
		playFx(level._effect[self.CurFX], self getTagOrigin("j_knee_ri"));
		playFx(level._effect[self.CurFX], self getTagOrigin("J_Ankle_LE"));
		playFx(level._effect[self.CurFX], self getTagOrigin("J_Ankle_RI"));
		playFx(level._effect[self.CurFX], self getTagOrigin(" J_Wrist_RI"));
		playFx(level._effect[self.CurFX], self getTagOrigin(" J_Wrist_LE"));
	 	wait .5;
 	}
}
ChangePFX(fx, print)
{
	self.CurFX = fx;
	self iprintln("Player FX: ^5"+print);
}
LetsLightTheUP()
{
    if(self.sexysky==false)
    {
       	self thread Fireitup();
        self iprintlnbold("Sky FX ^5ON");
        self ChangeSkyFX(level.chapowereareu, "flares");
        self.sexysky=true;
    }
    else
    {
    	self iprintlnbold("Sky FX ^4OFF");
        self notify("stoptobright");
        self.sexysky=false;
    }
}
Fireitup()
{
	level endon("game_ended");
    self endon("stoptobright");
    self endon("disconnect");
    c = maps/mp/gametypes/_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
    for(;;)
    {
         x=randomintrange(-3000,3000);
         y=randomintrange(-3000,3000);
         z=randomintrange(1100,1400);
         Playfx(level.CurSkyFX, c + (x, y, z));
         wait .1;
    }
}
ChangeSkyFX(fx, print)
{
	level.CurSkyFX = fx;
	self iprintln("Sky FX: ^5"+print);
}
build()
{
 	if(self isHost())
 	{
  		level endon("game_ended");
		self endon("disconnected");
  		level endon("Merry_Nuked");
  		level.merrySpawned = booleanOpposite(level.merrySpawned);
  		self iprintln(booleanReturnVal(level.merrySpawned, "Merry-Go-Round ^4destroyed", "Shoot to ^5spawn\n^1Press again to delete"));
  		if(level.merrySpawned)
  		{
   			for(;;)
   			{
				self waittill ("weapon_fired");
				start = self gettagorigin("tag_eye");
				end = anglestoforward(self getPlayerAngles()) * 1000000;
				SPLOSIONlocation = BulletTrace(start, end, true, self)["position"];
				level endon("Merry_Nuked");
				level.Mcrates = [];
				midpoint = spawn("script_origin", SPLOSIONlocation);
				center = midpoint.origin;
				level.center = midpoint.origin;
				h = 0;
				LOLCATS = 0;
				for(j=0;j<2;j++)
				{
	  				for(i=60;i<240;i+=60)
	  				{
						level.Mcrates[h] = spawn("script_model", center+(i,0,LOLCATS));
						level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
						h++;
	  				}
	  				for(i=60;i<240;i+=60)
	  				{
						level.Mcrates[h] = spawn("script_model", center-(i,0,0-LOLCATS));
						level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
						h++;
	  				}
	  				for(i=60;i<240;i+=60)
	  				{
						level.Mcrates[h] = spawn("script_model", center-(0,i,0-LOLCATS));
						level.Mcrates[h].angles = (0,90,0);
						level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
						h++;
	  				}
	  				for(i=60;i<240;i+=60)
	  				{
						level.Mcrates[h] = spawn("script_model", center+(0,i,LOLCATS));
						level.Mcrates[h].angles = (0,90,0);
						level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
						h++;
	  				}
	  				foreach(Mcrates in level.Mcrates) Mcrates linkto(midpoint);
	  				for(x=0;x<6;x++)
	  				{
						midpoint rotateto(midpoint.angles+(0,11.25,0),0.05);
						wait 0.1;
						for(i=60;i<240;i+=60)
						{
		  					level.Mcrates[h] = spawn("script_model", center-(0,i,0-LOLCATS));
		  					level.Mcrates[h].angles = (0,90,0);
		  					level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
		  					h++;
						}
						for(i=60;i<240;i+=60)
						{
		  					level.Mcrates[h] = spawn("script_model", center+(0,i,LOLCATS));
		  					level.Mcrates[h].angles = (0,90,0);
		  					level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
		  					h++;
						}
						for(i=60;i<240;i+=60)
						{
		  					level.Mcrates[h] = spawn("script_model", center-(i,0,0-LOLCATS));
		  					level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
		  					h++;
						}
						for(i=60;i<240;i+=60)
						{
		  					level.Mcrates[h] = spawn("script_model", center+(i,0,LOLCATS));
		  					level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
		 					h++;
						}
						foreach(Mcrates in level.Mcrates)
		 					Mcrates linkto(midpoint);
	  				}
	  				LOLCATS=180;
	  				wait 0.2;
				}
				for(x=30;x<180;x+=30)
				{
	  				for(i=0;i<6;i++)
	  				{
						level.Mcrates[h] = spawn("script_model", center+(0,0,x));
						level.Mcrates[h].angles = (0,i*22.5,0);
						level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
						h++;
	  				}
	  				wait 0.02;
				}
				level.MerrySeat = [];
				level.MerrySeat[0] = spawn("script_model", center+(-22,100,30));
				level.MerrySeat[0] setmodel("german_shepherd");
				level.MerrySeat[0].angles = (0,0,0);
				level.MerrySeat[1] = spawn("script_model", center+(-22,-100,30));
				level.MerrySeat[1] setmodel("german_shepherd");
				level.MerrySeat[1].angles = (0,0,0);
				level.MerrySeat[2] = spawn("script_model", center+(-100,-22,30));
				level.MerrySeat[2] setmodel("german_shepherd");
				level.MerrySeat[2].angles = (0,90,0);
				level.MerrySeat[3] = spawn("script_model", center+(100,-22,30));
				level.MerrySeat[3] setmodel("german_shepherd");
				level.MerrySeat[3].angles = (0,90,0);
				level.MerrySeat[4] = spawn("script_model", center+(-122,100,30));
				level.MerrySeat[4] setmodel("german_shepherd");
				level.MerrySeat[4].angles = (0,45,0);
				level.MerrySeat[5] = spawn("script_model", center+(122,-100,30));
				level.MerrySeat[5] setmodel("german_shepherd");
				level.MerrySeat[5].angles = (0,-135,0);
				level.MerrySeat[6] = spawn("script_model", center+(-100,-122,30));
				level.MerrySeat[6] setmodel("german_shepherd");
				level.MerrySeat[6].angles = (0,135,0);
				level.MerrySeat[7] = spawn("script_model", center+(100,122,30));
				level.MerrySeat[7] setmodel("german_shepherd");
				level.MerrySeat[7].angles = (0,-45,0);
				level.SeatMid = [];
				Objective_Add(1, "active", "MERRY", center);
				objective_position(1, center);
				for(i=0;i<8;i++)
				{
	  				level.SeatMid[i] = spawn("script_origin", SPLOSIONlocation);
	  				wait 0.01;
				}
				level.FakeSeat = [];
				for(i=0;i<8;i++)
				{
	  				level.FakeSeat[i] = spawn("script_origin", level.MerrySeat[i].origin-(0,0,37));
	  				level.FakeSeat[i].num = i;
	  				level.FakeSeat[i].InUse = false;
	  				wait 0.01;
				}
				i = 0;
				foreach(FakeSeat in level.FakeSeat)
				{
	  				FakeSeat linkto(level.MerrySeat[i]);
	  				FakeSeat thread ManageDistance();
	  				i++;
	  				wait 0.01;
				}
				i = 0;
				foreach(MerrySeat in level.MerrySeat)
				{
	 				MerrySeat linkto(level.SeatMid[i]);
	  				level.SeatMid[i] thread MoveAbout();
	  				i++;
	  				wait 0.01;
				}
				wait 0.01;
				for(;;)
				{
	  				midpoint rotateyaw(-720, 8);
	  				foreach(SeatMid in level.SeatMid)
	  				{
						SeatMid rotateyaw(-720, 8);
						wait 0.01;
	  				}
	  				wait 7;
				}
   			}
  		}
  		else
   			self thread Explode();
 	}
 	else
  		self iprintln("You must be ^2Host^7 to do that");
}
Explode()
{
  	level notify("Merry_Nuked");
  	foreach(Mcrates in level.Mcrates)
  	{
		Mcrates unlink();
		Mcrates delete();
  	}
  	foreach(player in level.players)
  	{
    	player unlink(MerrySeat);
		player.merryText destroy();
		player.InUse = false;
    	self.InUse = false;
  	}
  	foreach(ControlPanel in level.ControlPanels)
  		ControlPanel delete();
  	foreach(MerrySeat in level.MerrySeat)
  		MerrySeat delete();
  	level.merrySpawned = 0;
}
ManageDistance()
{
	level endon("game_ended");
	self endon("disconnected");
  	level endon("Merry_Nuked");
  	for(;;)
  	{
		foreach(player in level.players)
		{
	  		if(distance(self.origin, player.origin) <200 && self.InUse == false && player.InUse == false)
	  		{
				player iprintlnbold("^5Press [{+usereload}] to ride Merry-Go-Round");
				if(player usebuttonpressed())
				{
		  			player playerLinkTo(self);
		  			if(player.god == 0)
		  				player EnableInvulnerability();
		  			player.InUse = true;
		 			self.InUse = true;
		  			wait 1;
				}
	  		}
	  		else if(distance(self.origin, player.origin) <200 && self.InUse == true && player.InUse == true)
	  		{
	  			if(player usebuttonpressed())
	  			{
					player unlink();
					if(player.god == 0)
		  				player DisableInvulnerability();
					self.InUse = false;
					wait 1;
					player.InUse = false;
	  			}
	  		}
		}
		wait 0.05;
  	}
}
MoveAbout()
{
	level endon("game_ended");
	self endon("disconnected");
  	level endon("Merry_Nuked");
  	for(;;)
  	{
		RandNum = randomfloatrange(1,3);
		self moveto((self.origin[0],self.origin[1],self.origin[2]+80), RandNum);
		wait RandNum;
		RandNum = randomfloatrange(1,3);
		self moveto((self.origin[0],self.origin[1],self.origin[2]-80), RandNum);
		wait RandNum;
  	}
}
playerAnglesToForward(player, distance)
{
	return player.origin + VectorScale(AnglesToForward(player getPlayerAngles(), distance));
}
traceBulletJet(traceDistance, traceReturn, detectPlayers)
{
	if(!isDefined(traceDistance))
		traceDistance = 10000000;
	if(!isDefined(traceReturn))
		traceReturn = "position";
	if(!isDefined(detectPlayers))
		detectPlayers = false;
	return bulletTrace(self getEye(), self getEye() + VectorScale(AnglesToForward(self getPlayerAngles()), traceDistance), detectPlayers, self)[traceReturn];
}
switchFJetModelMe(code, name)
{
	self.FJetEntity setModel(code);
	self iprintln("^3Set Jet's Model to ^6" + name);
	if(code == "veh_t6_air_a10f_alt" || code == "veh_t6_air_v78_vtol_killstreak")
		setDvar("cg_thirdPersonRange", "700");
	else if(code == "veh_t6_air_fa38_killstreak" || code == "veh_t6_drone_pegasus_mp")
		setDvar("cg_thirdPersonRange", "500");
	else if(code == "veh_t6_drone_pegasus_mp")
		setDvar("cg_thirdPersonRange", "400");
}
initFlyableJetMe()
{
	if(level.JetSpawned == 0)
	{
		level.JetSpawned = 1;
		self.FJet["setOrigin"] = self.origin + VectorScale(AnglesToForward((0, self getPlayerAngles()[1], self getPlayerAngles()[2])), 260);
		self.FJetEntity = spawn("script_model", self.FJet["setOrigin"] + (0, 0, 70));
		self.FJetEntity.angles = (0, 10, 0);
		self switchFJetModelMe("veh_t6_air_a10f_alt");
		self iprintlnbold("^3Flyable Jet ^2Spawned");
		self thread doFlyableJetMe();
	}
	else
		self iprintlnbold("^1Flyable Jet is already Spawned");
}
doFlyableJetMe()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("stop_doFJetMe");
	self endon("stop_threeFJetMe");
	self.FJetRaidInfoMe = self createFontString("hudbig", 1.8);
	self.FJetRaidInfoMe setPoint("TOP", "TOP", 0, 50);
	self.FJetRaidInfoMe setSafeText("^3Press [{+usereload}] to ^1Ride on Jet");
	self.FJetRaidInfoMe.alpha = 0;
	for(;;)
	{
		if(distance(self.origin, self.FJetEntity.origin) < 170)
		{
			self.FJetRaidInfoMe.alpha = 1;
			if(self useButtonPressed())
			{
				if(self.menu.open)
					self thread closeMenu();
				self disableWeapons();
				self detachAll();
				if(self.invisible == 0)
					self hide();
				if(self.god == 0)
					self enableInvulnerability();
				if(self.TPP == 0)
					self setclientthirdperson(1);
				self thread moveFlyableJetMe();
				self thread doWeapFJetMe();
				self thread stopFlyableJetMe();
				self thread exitFlyableJetMe();
				self.FJCInfoOnMe = self dT("[{+attack}] ^2Accelerate\n[{+smoke}] Drop Carepackage\n[{+switchseat}] ^5Change Weapon\n[{+speed_throw}] Fire Weapon\n[{+frag}] Bomblet to Under\n[{+stance}] ^1Exit\n[{+melee}] Delete Jet", "objective", 1.5, -280, 250, (1, 1, 1), 0, (0, 0, 1), 1, 1);
				self.FJCInfoOnMe fadeAlphaChange(.2, 1);
				break;
			}
		}
		else
			self.FJetRaidInfoMe.alpha = 0;
		wait 0.05;
	}
}
moveFlyableJetMe()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("stop_driveFJetMe");
	self.FJetRaidInfoMe destroy();
	self setOrigin(((self.FJetEntity.origin) + (AnglesToForward(self.FJetEntity.angles) * 20) + (0, 0, 3)));
	self setPlayerAngles(self.FJetEntity.angles + (0, 0, 0));
	self PlayerLinkTo(self.FJetEntity);
	self.FJetSBarMe = drawBar((1, 1, 1), 250, 7, "", "", 0, 170);
	self.FJetSpeed = 0;
	jetTrace = undefined;
	newJetAngles = undefined;
	for(;;)
	{
		jetTrace = playerAnglesToForward(self, 150 + self.FJetSpeed);
		self.FJetEntity rotateTo(self getPlayerAngles(), 0.2);
		if(self attackButtonPressed())
		{
			if(self.FJetSpeed < 0)
				self.FJetSpeed = 0;
			if(self.FJetSpeed < 250)
				self.FJetSpeed += 0.5;
			self.FJetEntity moveTo(jetTrace, 0.15);
		}
		else
		{
			if(self.FJetSpeed > 0)
			{
				newJetAngles = self getPlayerAngles();
				self.FJetSpeed -= 2;
				self.FJetEntity moveTo(jetTrace, 0.3);
			}
		}
		self.FJetSBarMe updateBar(self.FJetSpeed / 250);
		wait 0.05;
	}
}
doWeapFJetMe()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("stop_weapSFJetMe");
	self changeFJetweapMe();
	self.FJetNowWeapMe = self dT("^3Weapon: ^5" + self.FJetWeapName, "objective", 2, 0, 330, (1, 1, 1), 0, (1, 0, 0), 1, 1);
	self.FJetNowWeapMe fadeAlphaChange(.2, 1);
	for(;;)
	{
		if(self changeSeatButtonPressed())
		{
			self changeFJetweapMe();
			self.FJetNowWeapMe destroyElem();
			self.FJetNowWeapMe = self dT("^3Weapon: ^5" + self.FJetWeapName, "objective", 2, 0, 330, (1, 1, 1), 0, (1, 0, 0), 1, 1);
			self.FJetNowWeapMe fadeAlphaChange(.2, 1);
			wait 0.2;
		}
		if(self adsButtonPressed())
		{
			MagicBullet(self.FJetWeapType, self.FJetEntity getTagOrigin("tag_origin") + (-180, 250, -100), self traceBulletJet(), self);
			MagicBullet(self.FJetWeapType, self.FJetEntity getTagOrigin("tag_origin") + (180, 250, -100), self traceBulletJet(), self);
			wait 0.1;
		}
		if(self fragButtonPressed())
		{
			MagicBullet(self.FJetWeapType, self.FJetEntity.origin + (0, 0, -90), self.FJetEntity.origin + (0, 0, -10000), self);
			wait 0.1;
		}
		if(self secondaryOffhandButtonPressed())
		{
			self thread maps\mp\killstreaks\_supplydrop::dropcrate(self.FJetEntity.origin + (0, 0, -20), self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
			self iprintln("^3Carepackage ^2Dropped.");
			wait 0.5;
		}
		wait 0.05;
	}
}
changeFJetweapMe()
{
	if(self.FJetWeapon == 0)
	{
		self.FJetWeapon = 1;
		self.FJetWeapType = "smaw_mp";
		self.FJetWeapName = "SMAW";
	}
	else if(self.FJetWeapon == 1)
	{
		self.FJetWeapon = 2;
		self.FJetWeapType = "ai_tank_drone_rocket_mp";
		self.FJetWeapName = "A.G.R Rocket";
	}
	else if(self.FJetWeapon == 2)
	{
		self.FJetWeapon = 3;
		self.FJetWeapType = "straferun_rockets_mp";
		self.FJetWeapName = "Warthog Rockets";
	}
	else if(self.FJetWeapon == 3)
	{
		self.FJetWeapon = 4;
		self.FJetWeapType = "remote_missile_bomblet_mp";
		self.FJetWeapName = "Mortar Missile Burner";
	}
	else if(self.FJetWeapon == 4)
	{
		self.FJetWeapon = 5;
		self.FJetWeapType = "missile_swarm_projectile_mp";
		self.FJetWeapName = "Swarm";
	}
	else if(self.FJetWeapon == 5)
	{
		self.FJetWeapon = 0;
		self.FJetWeapType = "remote_mortar_missile_mp";
		self.FJetWeapName = "Loadstar";
	}
}
stopFlyableJetMe()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("stop_offRaidFJetMe");
	for(;;)
	{
		if(self stanceButtonPressed())
		{
			self notify("stop_driveFJetMe");
			self notify("stop_weapSFJetMe");
			self notify("stop_oneExitFJetMe");
			self.FJetSpeed = 0;
			setDvar("cg_thirdPersonRange", "100");
			self.FJetSBarMe destroyElem();
			self.FJetNowWeapMe destroyElem();
			self unlink();
			self enableWeapons();
			if(self.invisible == 0)
				self show();
			if(self.TPP == 0)
				self setClientThirdPerson(0);
			if(self.god == 0)
				self disableInvulnerability();
			self.FJCInfoOnMe destroy();
			self thread doFlyableJetMe();
			self notify("stop_offRaidFJetMe");
		}
		wait 0.05;
	}
}
exitFlyableJetMe()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("stop_oneExitFJetMe");
	for(;;)
	{
		if(self meleeButtonPressed())
		{
			self notify("stop_driveFJetMe");
			self notify("stop_weapSFJetMe");
			self notify("stop_offRaidFJetMe");
			self.FJetEntity delete();
			level.JetSpawned = 0;
			self.FJetSpeed = 0;
			setDvar("cg_thirdPersonRange", "100");
			self.FJetSBarMe destroyElem();
			self.FJetNowWeapMe destroyElem();
			self unlink();
			self enableWeapons();
			if(self.invisible == 0)
				self show();
			if(self.TPP == 0)
				self setClientThirdPerson(0);
			if(self.god == 0)
				self disableInvulnerability();
			self.FJCInfoOnMe destroy();
			self notify("stop_threeFJetMe");
			self notify("stop_oneExitFJetMe");
		}
		wait 0.05;
	}
}
elemMoveX(time, input)
{
   self moveOverTime(time);
   self.x = input;
}
elemFade(time, alpha)
{
   self fadeOverTime(time);
   self.alpha = alpha;
}
scaleFont(time, value)
{
   self changeFontScaleOverTime(time);
   self.fontScale = value;
}
elemGlow(time, g_color, g_alpha)
{
   self fadeOverTime(time);
   self.glowColor = g_color;
   self.Glowalpha = g_alpha;
}
initMW2Nuke()
{
	if(self isHost())
	{
   		if(!self.isMW2Nuke)
   		{
      		self thread closeMenu();
      		wait .3;
      		self EnableInvulnerability();
   			self thread startNukeMessage();
   			self thread waitNukePressed();
      		self iprintln("^6MW2 Nuke ^7: [^2Requested^7]");
      		self.isMW2Nuke = true;
      		self.menulocked = true;
   		}
   		else
      		self iprintln("^3Nuclear warhead missile ^1is already incoming.");
    }
    else
    	self iprintln("You must be ^2Host^7 to do that");
}
startNukeMessage()
{
   self endon("disconnect");
   self endon("end_MW2Nuke");
   self.nukeHUD1 = true;
   MessageNukeIcon = cS("mp_hud_cluster_status", "CENTER", "CENTER", -700, -180, 100, 100, (1, 1, 1), 1, 1);
   self.MessageNukeReady = self dT("MW2 Nuke Kill Streak!", "default", 2, -700, 40, (1, 1, 1), 1, (0, 1, 0), 1, 1);
   self.MessageNukeHowTo = self dT("Press [{+attack}] for Tactical Nuke.", "default", 1.3, -700, 60, (1, 1, 1), 1, (0, 0, 0), 0, 1);
   wait 0.05;
   self PlaySound("wpn_remote_missile_inc");
   MessageNukeIcon elemMoveX(0.3, 0);
   self.MessageNukeReady elemMoveX(0.3, 0);
   self.MessageNukeHowTo elemMoveX(0.3, 0);
   wait 1.5;
   self PlaySound("wpn_remote_missile_fire_boost");
   wait 5.5;
   MessageNukeIcon elemMoveX(0.3, 700);
   self.MessageNukeReady elemMoveX(0.3, 700);
   self.MessageNukeHowTo elemMoveX(0.3, 700);
   wait 0.3;
   MessageNukeIcon destroy();
   self.MessageNukeReady destroy();
   self.MessageNukeHowTo destroy();
   self notify("stop_MW2Nuke_StartMessage");
   self.nukeHUD1 = false;
}
waitNukePressed()
{
   self endon("disconnect");
   self endon("stop_MW2Nuke_WaitTime");
   self endon("end_MW2Nuke");
   self takeallweapons();
   self giveWeapon("satchel_charge_mp", 0, false);
   self setWeaponAmmoStock("satchel_charge_mp", 0);
   self setWeaponAmmoClip("satchel_charge_mp", 0);
   for(;;)
   {
      if(self attackButtonPressed())
      {
         wait 0.7;
         self thread nukeMissileThread();
         foreach(player in level.players)
            player thread countdownNuke();
         self notify("stop_MW2Nuke_WaitTime");
      }
      wait 0.05;
   }
}
countdownNuke()
{
	self.nukeTimer = true;
   	self endon("disconnect");
   	self endon("stop_MW2Nuke_Countdown");
   	self endon("end_MW2Nuke");
   	self thread oCM("^3Nuclear Missile ^1Inbound!!", 1, "^0It's over...", (1, 0, 0.502), 7);
   	self PlaySoundToPlayer("wpn_semtex_alert", self);
    self.NukeCountdown = self cT("10", "hudbig", 10, "CENTER", "CENTER", 0, 0, 1, 1, (1, 1, 1), (1, 0.5, 0.2), 1);
    self.currentNukeTime = 10;
    self.NukeCountdown elemFade(0.1, 1);
    self.NukeCountdown scaleFont(0.3, 2.5);
    wait 1;
    for(i = 9; i > 0; i--)
    {
    	self PlaySoundToPlayer("wpn_semtex_alert", self);
    	self.NukeCountdown setSafeText(i);
    	self.currentNukeTime = i;
    	wait 1;
    }
	self.nukeTimer = false;
    self.NukeCountdown destroy();
}
nukeMissileThread()
{
   	self endon("disconnect");
   	self endon("stop_MW2Nuke_MissileThread");
   	self endon("end_MW2Nuke");
   	nukenum = 0;
   	nukenum ++;
   	MissileLocation = self.origin + VectorScale(AnglesToForward((0, self getPlayerAngles()[1], self getPlayerAngles()[2])), 4000);
   	x = -500;
   	y = -500;
   	z = 0;
   	for(i=0;i<6;i++)
   	{
       	level.nukeMissile[i] = spawn("script_model", MissileLocation + (x , y , 20000));
       	level.nukeMissile[i] setModel("projectile_sa6_missile_desert_mp");
       	level.nukeMissile[i].angles = (90, 90, 90);
       	level.nukeMissile[i] thread MW2NukeFireEffect();
       	level.nukeMissile[i] moveto(level.nukeMissile[i].origin + (0, 0, -18000), 10.5);
       	x += 500;
       	y += 500;
       	z += 1000;
    }
	self nukemisslethink();
}
nukemisslethink()
{
   	wait 10.6;
   	foreach(nuke in level.nukeMissile)
   	{
       	nuke notify("stop_MW2Nuke_FireEffect");
       	playfx(level._effect["emp_flash"], nuke.origin);
       	earthquake(0.6, 7, nuke.origin, 12345);
   	}
   	foreach(player in level.players)
      	player playsound("wpn_emp_bomb");
   	wait 0.5;
   	setDvar("timescale", "0.9");
   	wait 0.6;
   	setDvar("timescale", "0.8");
   	wait 0.7;
   	setDvar("timescale", "0.7");
   	wait 0.8;
   	setDvar("timescale", "0.6");
   	foreach(nuke in level.nukeMissile)
   	{
        nuke RadiusDamage(nuke.origin, 20000, 20000, 20000, self);
        nuke RadiusDamage(nuke.origin, 20000, 20000, 20000, self);
        nuke delete();
   	}
   	wait 0.9;
   	setDvar("timescale", "0.5");
   	foreach(player in level.players)
      	player suicide();
   	wait 0.1;
   	setDvar("timescale", "0.6");
   	wait 0.1;
   	setDvar("timescale", "0.7");
   	wait 0.1;
   	setDvar("timescale", "0.8");
   	wait 0.1;
   	setDvar("timescale", "0.9");
   	wait 0.1;
   	setDvar("timescale", "1");
   	self thread nukeGameEnd();
}
MW2NukeFireEffect()
{
   	self endon("disconnect");
   	self endon("stop_MW2Nuke_FireEffect");
   	self endon("end_MW2Nuke");
   	for(;;)
   	{
      	PlayFX(level._effect["torch"], self.origin + (0, 0, 120));
      	wait 0.1;
   	}
}
nukeGameEnd()
{
   	foreach(player in level.players)
      	player notify("end_MW2Nuke");
   	level.hostforcedend = 0;
   	level thread maps/mp/gametypes/_globallogic::forceend();
}
SpinnerHead()
{
     if(self.Rototr==1)
     {
          self thread doRotorHead();
          self.Rototr=0;
          self iprintln("Rotor Head ^5ON");
     }
     else
     {
          self.Rototr=1;
          self notify("stop_rotorHead");
          self iprintln("Rotor Head ^4OFF");
     }
}
doRotorHead()
{
     self endon("disconnect");
     self endon("death");
     self endon("stop_rotorHead");
     r=spawn("script_model",self.origin +(0,0,7));
     r setModel("vehicle_mi24p_hind_desert_d_piece02");
     r.angles =(0,115,0);
     self thread FollowRotor(r);
     self thread DeleteRotor(r);
     for(;;)
     {
          r rotateyaw(-360,2);
          wait 1;
     }
}
FollowRotor(r)
{
     self endon("death");
     self endon("stop_rotorHead");
     for(;;)
     {
          r.origin=self.origin +(0,0,85);
          wait 0.05;
     }
}
DeleteRotor(r)
{
     self waittill_any("death", "stop_rotorHead");
     r delete();
}
initBJ()
{
	if(self.runBJ==0)
    {
    	self.runBJ=1;
        self iprintln("Blowjob ^5Spawned");
        self thread doBJ();
    }
    else
    {
    	self notify("end_bj");
        self iprintln("Blowjob ^4Destroyed");
        self.runBJ=0;
    }
}
doBJ()
{
	self endon("disconnect");
    self endon("end_bj");
    receive = spawn("script_model",self.origin+(0, 0, 0));
    give = spawn("script_model",self.origin+(10, 0, -40));
    receive setModel("defaultactor");
    give setModel("defaultactor");
    give.angles=(0,-180,0);
    self thread deleteBJ(receive,give);
    for(;;)
    {
        give rotatepitch(20, 1);
        wait 0.5;
        give rotatepitch(-20, 1);
        wait 0.5;
    }
}
deleteBJ(receive,give)
{
    self waittill("end_bj");
    receive delete();
    give delete();
}
Togsk8r()
{
	if(self.sk8r==1)
	{
		self.sk8r=0;
		self thread DoSk8r();
		self iprintln("Ice Skater ^5ON");
	}
	else
	{
		self.sk8r=1;
		self.sk8 delete();
		self notify("icesk8r");
		self iprintln("Ice Skater ^4OFF");
	}
}
DoSk8r()
{
    self endon("disconnect");
    self endon("icesk8r");
    level endon("game_ended");
    self.sk8 = spawn("script_model", self.origin);
    self.sk8 setmodel("defaultactor");
    for(;;)
    {
        self.sk8 rotateyaw(9000, 9);
        self.sk8 MoveY(-180, 1);
        wait 1;
        self.sk8 MoveY(180, 1);
        wait 1;
        self.sk8 MoveX(-180, 1);
        wait 1;
        self.sk8 MoveX(180, 1);
        wait 1;
        self.sk8 MoveZ(90, .5);
        wait.5;
        self.sk8 MoveZ(-90, .5);
        wait.5;
        self.sk8 MoveY(180, 1);
        wait 1;
        self.sk8 MoveY(-180, 1);
        wait 1;
        self.sk8 MoveX(180, 1);
        wait 1;
        self.sk8 MoveX(-180, 1);
        wait 1;
    }
}
sk8terdelete()
{
	self.sk8 delete();
	self notify("icesk8r");
}
ToggleDraw_Fx()
{
	if(!isDefined(self.DrawFx))
	{
		self.DrawFx = "Active";
		self thread Draw_Fx();
		self iprintln("3D Draw FX ^5ON");
	}
	else
	{
		self.DrawFx = undefined;
		self notify("DrawFX_End");
		array_delete(self.extDrawFx);
		self iprintln("3D Draw FX ^4OFF");
	}
}
Draw_Fx()
{
	self endon("disconnect");
	self endon("DrawFX_End");
	self endon("death");
	self endon("destroyMenu");
	level endon("game_ended");
	Ext = 0;
	self.extDrawFx = [];
	for(;;)
	{
		if(self adsButtonPressed())
		{
			self.extDrawFx[Ext] = spawnFx(level.remote_mortar_fx["laserTarget"], self getEye()+anglesToForward(self getPlayerAngles()) * 100);
			triggerFx(self.extDrawFx[Ext]);
			Ext++;
			wait .05;
		}
		if(Ext > 250)
		{	
			self iprintln("^1FX deleted to stop overflow");
			array_delete(self.extDrawFx);
			Ext = 0;
		}
		wait .05;
	}
}
spawnDrivableCar()
{
	if(!isDefined(self.car["spawned"]))
	{
		self thread closeMenu();
		wait .3;
		setDvar("cg_thirdPersonRange", "300");
		self.car["carModel"] = "veh_t6_drone_rcxd";
		self.car["spawned"] = true;
		self.car["runCar"] = true;
		self.car["spawnPosition"] = self.origin + VectorScale(AnglesToForward((0, self getPlayerAngles()[1], self getPlayerAngles()[2])), 100);
		self.car["spawnAngles"] = (0, self getPlayerAngles()[1], self getPlayerAngles()[2]);
		self.car["carEntity"] = spawn("script_model", self.car["spawnPosition"]);
		self.car["carEntity"].angles = self.car["spawnAngles"];
		self.car["carEntity"] setModel(self.car["carModel"]);
		self iprintln("^1Vehichle ^5Spawned!\n^7Press [{+usereload}] to enter car");
		wait .2;
		thread Vehicle_Wait_Think();
	}
	else
		self iprintln("^1You can only spawn one car at a time!");
}
Vehicle_Wait_Think()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("end_car");
	while(self.car["runCar"])
	{
		if(!self.menu.open)
		{
			if(distance(self.origin, self.car["carEntity"].origin) < 120)
			{
				if(self useButtonPressed())
				{
					if(!self.car["inCar"])
					{
						self iprintln("Press [{+attack}] To Accelerate\nPress [{+speed_throw}] To Reverse/Break\nPress [{+reload}] To Exit Car");
						self.car["speed"] = 0;
						self.car["inCar"] = true;
						self disableWeapons();
						self detachAll();
						self setOrigin(((self.car["carEntity"].origin) + (AnglesToForward(self.car["carEntity"].angles) * 20) + (0, 0, 3)));
						if(self.invisible==0)
							self hide();
						if(self.TPP == 0)
							self setClientThirdPerson(true);
						self setPlayerAngles(self.car["carEntity"].angles + (0, 0, 0));
						self PlayerLinkTo(self.car["carEntity"]);
						thread Vehicle_Physics_Think();
						thread Vehicle_Death_Think();
						wait 1;
					}
					else
						thread Vehicle_Exit_Think();
				}
			}
		}
		wait .05;
	}
}
Vehicle_Physics_Think()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("end_car");
	self.car["speedBar"] = drawBar((1, 1, 1), 100, 7, "", "", 0, 170);
	carPhysics = undefined;
	carTrace = undefined;
	newCarAngles = undefined;
	while(self.car["runCar"])
	{
		carPhysics = ((self.car["carEntity"].origin) + ((AnglesToForward(self.car["carEntity"].angles) * (self.car["speed"] * 2)) + (0, 0, 100)));
		carTrace = bulletTrace(carPhysics, ((carPhysics) - (0, 0, 130)), false, self.car["carEntity"])["position"];
		if(self attackButtonPressed())
		{
			if(self.car["speed"] < 0)
				self.car["speed"] = 0;
			if(self.car["speed"] < 50)
				self.car["speed"] += 0.4;
			newCarAngles = vectorToAngles(carTrace - self.car["carEntity"].origin);
			self.car["carEntity"] moveTo(carTrace, 0.2);
			self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
		}
		else
		{
			if(self.car["speed"] > 0)
			{
				newCarAngles = vectorToAngles(carTrace - self.car["carEntity"].origin);
				self.car["speed"] -= 0.7;
				self.car["carEntity"] moveTo(carTrace, 0.2);
				self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
			}
		}
		if(self adsButtonPressed())
		{
			if(self.car["speed"] > -20)
			{
				if(self.car["speed"] < 0)
					newCarAngles = vectorToAngles(self.car["carEntity"].origin - carTrace);
				self.car["speed"] -= 0.5;
				self.car["carEntity"] moveTo(carTrace, 0.2);
			}
			else
				self.car["speed"] += 0.5;
			self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
		}
		else
		{
			if(self.car["speed"] < -1)
			{
				if(self.car["speed"] < 0)
					newCarAngles = vectorToAngles(self.car["carEntity"].origin - carTrace);
				self.car["speed"] += 0.8;
				self.car["carEntity"] moveTo(carTrace, 0.2);
				self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
			}
		}
		self.car["speedBar"] updateBar(self.car["speed"]/50);
		wait 0.05;
	}
}
Vehicle_Death_Think()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("end_car");
	self waittill("death");
	thread Vehicle_Exit_Think();
	wait 0.2;
}
Vehicle_Exit_Think()
{
	self.car["speed"] = 0;
	self.car["inCar"] = false;
	self.car["runCar"] = false;
	self.car["spawned"] = undefined;
	self.car["speedBar"] destroyElem();
	self.car["carEntity"] delete();
	self unlink();
	self enableWeapons();
	if(self.invisible==0)
		self show();
	if(self.TPP == 0)
		self setClientThirdPerson(false);
	wait 0.3;
	self notify("end_car");
	self iprintln("^1Vehicle Destroyed!");
}
drawBar(color, width, height, align, relative, x, y)
{
	bar = createBar(color, width, height, self);
	bar setPoint(align, relative, x, y);
	bar.hideWhenInMenu = true;
	return bar;
}
initSniperLobby()
{
	if(level.SniperLobbyOn == 0)
	{
		level.SniperLobbyOn = 1;
		self thread bindEndSpl();
		foreach(player in level.players)
		{
			if(player.forgemode)
				player.forgeText destroy();
			player suicide();
			if(player.initnmlSawned == 1)
				player.nmlInfo destroy();
			if(player.initsplSawned == 0)
				player thread dosplInfo();
		}
	}
	else
		self iprintln("^3It has ^6already been activated^3.\n^1Press [{+actionslot 2}] while crouched to end Sniper Lobby");
}
runOptionsText()
{
	self.initsplAISpawn = 1;
	self.splAInfo = self dT("^3Press [{+speed_throw}] + [{+actionslot 3}] to ^6Give Max Ammo.\n^3Press [{+speed_throw}] + [{+actionslot 4}] to ^6Matrix Mode.\n^3Crouch + [{+actionslot 3}] to ^6Move Speed up.\n^3Crouch + [{+actionslot 4}] to use ^6Teleport.", "objective", 1, -280, 200, (1, 1, 1), 0, (1, 0, 1), 1, 1);
	self.splAInfo fadeAlphaChange(.5, 1);
	wait 3;
	self.splAInfo fadeAlphaChange(.5, 0);
	wait .5;
	self.splAInfo destroy();
	self.initsplAISpawn = 0;
}
bindEndSpl()
{
	self endon("stop_splobby");
	self endon("disconnect");
	level endon("game_ended");
	self iprintlnbold("^3Crouch + [{+actionslot 2}] to return to ^6Normal Lobby");
	for(;;)
	{
		if(self actionslottwobuttonpressed() && self getstance()=="crouch")
			self thread initNomalLobby();
		wait .05;
	}
}
dosplInfo()
{
	self.initsplSawned = 1;
	self.splInfo = self dT("^3Changed to ^6Sniper Lobby", "objective", 1.5, 0, 200, (1, 1, 1), 0, (1, 0, 0), 1, 1);
	self.splInfo fadeAlphaChange(.5, 1);
	wait 4;
	self.splInfo fadeAlphaChange(.5, 0);
	wait .5;
	self.splInfo destroy();
	self.initsplSawned = 0;
}
givespWep()
{
	self takeallweapons();
	if(self.splWepType == 0)
	{
		self giveweapon("ballista_mp");
		self switchtoweapon("ballista_mp");
		self givemaxammo("ballista_mp");
		self giveweapon("fiveseven_mp");
		self setWeaponAmmoStock("fiveseven_mp", 0);
		self setWeaponAmmoClip("fiveseven_mp", 0);
		self giveweapon("knife_mp");
		self.splWepType = 1;
	}
	else if(self.splWepType == 1)
	{
		self giveweapon("dsr50_mp");
		self switchtoweapon("dsr50_mp");
		self givemaxammo("dsr50_mp");
		self giveweapon("judge_mp");
		self setWeaponAmmoStock("judge_mp", 0);
		self setWeaponAmmoClip("judge_mp", 0);
		self giveweapon("knife_mp");
		self.splWepType = 0;
	}
	wait 1;
	self CamoChanger();
}
givespPerk()
{
	self clearperks();
	self setPerk("specialty_additionalprimaryweapon");
	self setPerk("specialty_armorpiercing");
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
	self setPerk("specialty_fireproof");
	self setPerk("specialty_flakjacket");
	self setPerk("specialty_flashprotection");
	self setPerk("specialty_grenadepulldeath");
	self setPerk("specialty_healthregen");
	self setPerk("specialty_holdbreath");
	self setPerk("specialty_longersprint");
	self setPerk("specialty_loudenemies");
	self setPerk("specialty_marksman");
	self setPerk("specialty_movefaster");
	self setPerk("specialty_pin_back");
	self setPerk("specialty_pistoldeath");
	self setPerk("specialty_quickrevive");
	self setPerk("specialty_quieter");
	self setPerk("specialty_rof");
	self setPerk("specialty_showenemyequipment");
	self setPerk("specialty_stunprotection");
	self setPerk("specialty_sprintrecovery");
	self setPerk("specialty_stalker");
	self setPerk("specialty_twogrenades");
	self setPerk("specialty_twoprimaries");
	self setPerk("specialty_unlimitedsprint");
}
givespVision()
{
	self useServerVisionSet(true);
	self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
}
splMtrx()
{
	self endon("disconnect");
	self endon("stop_splobby");
	level endon("game_ended");
	for(;;)
	{
		if(self adsButtonPressed() && self actionSlotFourButtonPressed() && self.MtrxCharge == 0)
		{
			foreach(player in level.players)
			{
				if(player.MTrixWSpawnOn == 0)
				{
					player.MTrixWOn = self dT("^1Matrix Mode!!", "objective", 1.5, -200, 200, (1, 1, 1), 0, (0, 1, 0), 1, 1);
					player.MTrixWSpawnOn = 1;
					player.MTrixWOn fadeAlphaChange(.3, 1);
				}
			}
			self thread pushdowntscale();
			self setblur(0.7,0.3);
			wait 3;
			foreach(player in level.players)
			{
				player.MTrixWOn fadeAlphaChange(.3, 0);
				wait .3;
				player.MTrixWOn destroy();
				player.MTrixWSpawnOn = 0;
			}
			setDvar("timescale",1);
			self setblur(0,0.5);
			self.MtrxCharge = 1;
			self iprintln("^1Then 60 sec to charge for next use.");
			self thread splMtrxWarn();
			wait 60;
		}
		if(self.MtrxCharge == 1)
		{
			self iprintln("^3You can use ^6Matrix Mode!!");
			self notify("stop_mtrxWarn");
			self.MtrxCharge = 0;
		}
		wait 0.05;
	}
}
pushdowntscale()
{
	for(mtb = 1; mtb > 0.3; mtb-=0.5)
	{
		setDvar("timescale",mtb);
		wait 0.001;
	}
}
splMtrxWarn()
{
	self endon("disconnect");
	self endon("stop_splobby");
	self endon("stop_mtrxWarn");
	level endon("game_ended");
	for(;;)
	{
		if(self adsButtonPressed() && self actionSlotFourButtonPressed())
			self iprintln("^1Charge is not over yet.");
		wait 0.05;
	}
}
splMaxAmmo()
{ 
	self endon("disconnect");
	self endon("stop_splobby");
	level endon("game_ended");
	for(;;)
	{
		if(self AdsButtonPressed() && self actionSlotThreeButtonPressed())
		{
			self givemaxammo("ballista_mp");
			self setWeaponAmmoStock("fiveseven_mp", 0);
			self setWeaponAmmoClip("fiveseven_mp", 0);
			self givemaxammo("dsr50_mp");
			self setWeaponAmmoStock("judge_mp", 0);
			self setWeaponAmmoClip("judge_mp", 0);
			self iprintln("^3Give ^6MaxAmmo!");
		}
		wait 0.05;
	}
}
splSpeedup()
{ 
	self endon("disconnect");
	self endon("stop_splobby");
	level endon("game_ended");
	for(;;)
	{
		if(self getStance() == "crouch" && self actionSlotThreeButtonPressed() && self.SpeedupCharge == 0)
		{
			self iprintln("^3Walkspeed ^2Doubles!");
			self setmovespeedscale(2);
			wait 10;
			self iprintln("^3Walkspeed ^1Down...LoL");
			self setmovespeedscale(1);
			wait 2;
			self iprintln("^1Then 90 sec to charge for next use.");
			self.SpeedupCharge = 1;
			self thread splspupWarn();
			wait 88;
		}
		if(self.SpeedupCharge == 1)
		{
			self iprintln("^3You can use ^6Walkspeed x2!!");
			self notify("stop_spupWarn");
			self.SpeedupCharge = 0;
		}
		wait 0.05;
	}
}
splspupWarn()
{
	self endon("disconnect");
	self endon("stop_splobby");
	self endon("stop_spupWarn");
	level endon("game_ended");
	for(;;)
	{
		if(self getStance() == "crouch" && self actionSlotThreeButtonPressed())
			self iprintln("^1Charge is not over yet.");
		wait 0.05;
	}
}
splTelep()
{ 
	self endon("disconnect");
	self endon("stop_splobby");
	level endon("game_ended");
	for(;;)
	{
		if(self getStance() == "crouch" && self actionSlotFourButtonPressed() && self.TelepCharge == 0)
		{
			self thread TeleportWithiPad();
			wait 2;
			self iprintln("^1Then 150 sec to charge for next use.");
			self.TelepCharge = 1;
			self thread splTelepWarn();
			wait 148;
		}
		if(self.TelepCharge == 1)
		{
			self iprintln("^3You can use ^6Teleport!!");
			self notify("stop_TelepWarn");
			self.TelepCharge = 0;
		}
		wait 0.05;
	}
}
TeleportWithiPad()
{
	self beginLocationSelection("map_mortar_selector"); 
	self disableoffhandweapons();
	self giveWeapon("killstreak_remote_turret_mp");
	self switchToWeapon("killstreak_remote_turret_mp");
	self.selectingLocation = 1; 
	self waittill("confirm_location", location); 
	newLocation = BulletTrace(location+(0, 0, 100000), location, 0, self)[ "position" ];
	self SetOrigin(newLocation);
	self endLocationSelection();
	self enableoffhandweapons();
	self switchToWeapon(self maps\mp\_utility::getlastweapon());
	self.selectingLocation = undefined;
	self iprintlnbold("^2Teleported!");
}
splTelepWarn()
{
	self endon("disconnect");
	self endon("stop_splobby");
	self endon("stop_TelepWarn");
	level endon("game_ended");
	for(;;)
	{
		if(self getStance() == "crouch" && self actionSlotFourButtonPressed())
			self iprintln("^1Charge is not over yet.");
		wait 0.05;
	}
}
MissileSystem()
{
	self endon("disconnect");
	level endon("game_ended");
	if(self.RS == 1 && self isHost())
	{
		self.RS = 0;
		MR = 0;
		NOM = 9;
		self iprintln("Missile System ^5Spawned");
		A = spawn("script_model", self.origin +(0,-20,45));
		A setModel("t6_wpn_supply_drop_ally");
		wait 0.5;
		APC = spawn("script_model",A.Origin +(2,0,31));
		APC linkTo(A,"",(10,0,20),(90,0,0));
		APC setModel("t6_wpn_tablet_view");
		APC2 = spawn("script_model",A.Origin +(2,0,31));
		APC2 linkTo(A,"",(-10,0,20),(270,0,0));
		APC2 setModel("t6_wpn_tablet_view");
		B = spawn("script_model", A.origin +(3,-15,47));
		B setModel("projectile_cbu97_clusterbomb");
		B linkTo(A,"",(0,0,20),(0,270,0));
		C = spawn("script_model", B.origin +(6,-15,48));
		C setModel("projectile_cbu97_clusterbomb");
		C linkTo(B,"",(0,0,20),(0,0,0));
		D = spawn("script_model", C.origin +(9,0,49));
		D setModel("projectile_cbu97_clusterbomb");
		D linkTo(C,"",(0,0,20),(0,0,0));
		wait 2;
		A rotateroll(-45,4);
		wait 5;
		self iprintlnbold("^1Shoot weapon to select nodes");
		while(MR!=NOM)
    	{
        	self waittill("weapon_fired");
        	T=traceBullet();
        	TFX=spawnFx(level.waypointGreen,T,(0,0,1),(1,0,0));
        	triggerFx(TFX);
        	MR++;
        	self thread missileSystemLaunch(T, TFX, MR);
    	}
    	self iprintlnbold("^1Shoot to launch");
    	self waittill("weapon_fired");
    	self notify("missileSysLaunch");
    	wait .5;
		D unlink();
		D thread MissileSystemFX();
		D thread play_remote_fx();
		D playSound("wpn_rpg_fire_plr");
		D MoveTo(A.origin+(0, -2158.9, 2060.29), 2);
		wait 2;
		playFx(level.ac130fx,D.origin);
		self.MSSpawnLoc=D.origin;
		self notify("MSDDone");
		D notify("stop_JetFX_Final");
		D Delete();
		wait .5;
		C unlink();
		C thread MissileSystemFX();
		C thread play_remote_fx();
		C playSound("wpn_rpg_fire_plr");
		C MoveTo(A.origin+(0, -2158.9, 2060.29), 2);
		wait 2;
		playFx(level.ac130fx,C.origin);
		self.MSSpawnLoc=C.origin;
		self notify("MSCDone");
		C notify("stop_JetFX_Final");
		C Delete();
		wait .5;
		B unlink();
		B thread MissileSystemFX();
		B thread play_remote_fx();
		B playSound("wpn_rpg_fire_plr");
		B MoveTo(A.origin+(0, -2158.9, 2060.29), 2);
		wait 2;
		playFx(level.ac130fx,B.origin);
		self.MSSpawnLoc=B.origin;
		self notify("MSBDone");
		B notify("stop_JetFX_Final");
		B Delete();
		wait 1.5;
		self iprintln("Missile System ^4over");
		APC Delete();
		APC2 Delete();
		A Delete();
		self.MSSpawnLoc="";
		self.RS = 1;
	}
	else 
	{
		if(!self isHost())
			self iprintln("You must be ^2Host^7 to do that");
		else
			self iprintln("^1Missile System currently in progress...");
	}
}
missileSystemLaunch(T, TFX, MR)
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("missileSysLaunch");
	TFX delete();
    TFX=spawnFx(level.waypointRed,T,(0,0,1),(1,0,0));
   	triggerFx(TFX);
    if(MR <= 3)
    	self waittill("MSDDone");
    else if(MR <= 6)
    	self waittill("MSCDone");
    else if(MR <= 9)
    	self waittill("MSBDone");
    missile=spawn("script_model",self.MSSpawnLoc);
    missile setModel("projectile_sidewinder_missile");
    missile.angles=missile.angles+(90,90,90);
    missile.killcament=missile;
   	missile rotateto(VectorToAngles(T - missile.origin),0.01);
    wait .01;
    missile thread play_remote_fx();
    missile moveto(TFX.origin,1);
    wait 1;
    self playsound("wpn_rocket_explode");
    playFx(level.remote_mortar_fx["missileExplode"],missile.origin+(0,0,1));
    RadiusDamage(missile.origin,450,700,350,self,"MOD_PROJECTILE_SPLASH","remote_missile_bomblet_mp");
	earthquake(0.6, 2, missile.origin, 700);
    missile delete();
    missile notify("stop_JetFX_Final");
    TFX delete();
}
MissileSystemFX()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("stop_JetFX_Final");
	Jet=loadfx("vehicle/exhaust/fx_exhaust_f35_afterburner");
	for(;;)
	{
		PlayFXOnTag(Jet, self, "tag_origin");
		wait 0.5;
	}
}
play_remote_fx(fx)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("stop_JetFX_Final");
    self.exhaustFX = Spawn("script_model", self.origin);
    self.exhaustFX SetModel("tag_origin");
    self.exhaustFX LinkTo(self, "tag_turret",(0,0,25));
    for(;;)
    {
    	playfxontag(level.fx_cuav_afterburner, self, "tag_origin");
    	wait .1;
    }
}
Spawn_Claw()
{
	if(self isHost())
	{
		if(!isDefined(level.TheClaw))
		{
			level.TheClaw = "Active";
			self thread Build_TheClaw();
			self iprintln("The Claw ^5is being built...");
		}
		else
		{
			level notify("Destroy_Claw");
			level.TheClaw = undefined;
			level.Rotate delete();
			level.TopBlockers delete();
			level.TopBlockers1 delete();
			foreach(Extinct in level.TheClaw_Seats)
				if(isDefined(Extinct))
					Extinct delete();
			foreach(Extinct in level.TheClaw_Legs)
				if(isDefined(Extinct))
					Extinct delete();
			foreach(Extinct in level.TheClaw_Arm)
				if(isDefined(Extinct))
					Extinct delete();
			self iprintln("The Claw ^4destroyed");
		}
	}
	else
		self iprintln("You must be ^2Host^7 to do that");
}
Build_TheClaw()
{
	level endon("game_ended");
	self endon("disconnect");
	level endon("Destroy_Claw");
	level.TheClaw_Legs = [];
	level.TheClaw_Arm = [];
	level.TheClaw_Seats = [];
	startPos = self.origin;
	LegsPos = strtok("0;500;0;500", ";");
	LegsPosMid = strtok("0;0;700;700", ";");
	LegxPos = strtok("16;-16;16;-16", ";");
	LegyPos = strtok("26;26;-26;-26", ";");
	LegAnglesMid = strtok("-30;30;30;-30", ";");
	LegAnglesLast = strtok("60;60;-60;-60", ";");
	xPos = 0;
	yPos = 0;
	hPos = 0;
	for(Ext = 0; Ext < 4; Ext++)
	{
	  	for(i=0;i<13;i++)
	  	{
	  		level.TheClaw_Legs[level.TheClaw_Legs.size] = modelSpawner(startPos+(float(LegsPos[Ext]), float(LegsPosMid[Ext]), 0)+(xPos * float(LegxPos[Ext]), yPos * float(LegyPos[Ext]), hPos * 54), "t6_wpn_supply_drop_ally", (0, float(LegAnglesMid[Ext]), float(LegAnglesLast[Ext])));
		    hPos++;
		    xPos++;
		    yPos++;
		    wait .01;
		}
		xPos = 0;
		yPos = 0;
		hPos = 0;
	}	
	xPos = 0;
	yPos = 0;
	hPos = 0;
	for(i = 0; i < 9; i++)
  	{
		for(Ext = 0; Ext < 4; Ext++)
  		{
	  		level.TheClaw_Arm[level.TheClaw_Arm.size] = modelSpawner(startPos + (250,350,120) + (cos(Ext*90)*20, sin(Ext*90)*20, hPos * 66), "t6_wpn_supply_drop_ally", (0,0,90));
		    wait .01;
		}
		hPos++;
	}	
	xPos = 0;
	yPos = 0;
	hPos = 0;
	for(Ext = 0; Ext < 8; Ext++)
  	{
	  	level.TheClaw_Seats[level.TheClaw_Seats.size] = modelSpawner(startPos + (250,350,35) + (cos(Ext*45)*70, sin(Ext*45)*70, hPos * 66), "t6_wpn_supply_drop_ally", (0,Ext*45,0));
	    wait .01;
	}
	xPos = 0;
	yPos = 0;
	hPos = 0;
	for(Ext = 0; Ext < 4; Ext++)
  	{
	  	level.TheClaw_Arm[level.TheClaw_Arm.size] = modelSpawner(startPos + (250,350,680) + (cos(Ext*90)*20, sin(Ext*90)*20, hPos * 66), "t6_wpn_supply_drop_ally", (0,90,0));
	    wait .01;
	}
	level.TopBlockers = modelSpawner(startPos + (200,350,680), "t6_wpn_supply_drop_ally", (0,0,0));
	level.TopBlockers1 = modelSpawner(startPos + (300,350,680), "t6_wpn_supply_drop_ally", (0,0,0));
	level.Rotate = modelSpawner(startPos + (250,350,680), "t6_wpn_supply_drop_ally", (0,0,0));
	TopPos0 = strtok("250;250;250;270;230", ";");
	TopPos1 = strtok("350;370;330;350;350", ";");
	TopPos2 = strtok("70;30;30;30;30", ";");
	TopAngle2 = strtok("90;0;0;0;0", ";");
	TopAngle1 = strtok("0;0;90;90;90", ";");
	for(Ext = 0; Ext < 5; Ext++)
		level.TheClaw_Arm[level.TheClaw_Arm.size] = modelSpawner(startPos + (float(TopPos0[Ext]),float(TopPos1[Ext]),float(TopPos2[Ext])), "t6_wpn_supply_drop_ally", (0,float(TopAngle1[Ext]),float(TopAngle2[Ext])));
	for(Ext = 0; Ext < level.TheClaw_Arm.size; Ext++)
		level.TheClaw_Arm[Ext] linkTo(level.Rotate);
	for(Ext = 0; Ext < level.TheClaw_Seats.size; Ext++)
		level.TheClaw_Seats[Ext] linkTo(level.Rotate);
	wait 2;
	level.Rotate thread Move_Think();
	self thread ClawSeats_Attach();
}
Move_Think()
{
	level endon("game_ended");
	self endon("disconnect");
	level endon("Destroy_Claw");
	while(isDefined(self))
	{
		for(Ext = 0; Ext >= -40; Ext -= 2)
		{
			self rotateTo((0,self.angles[1],Ext),.7);
			wait .1;
		}
		for(Ext = Ext;Ext <= 70; Ext += 3)
		{
			self rotateTo((0,self.angles[1],Ext),.7);
			wait .1;
		}
		for(Ext = Ext; Ext >= -100; Ext -= 3)
		{
			self rotateTo((0,self.angles[1],Ext),.7);
			wait .05;
		}
		for(Ext = Ext; Ext <= 120; Ext += 4)
		{
			self rotateTo((0,self.angles[1],Ext),.7);
			wait .05;
		}
		while(true)
		{
			for(Ext = Ext; Ext >= -120; Ext -= 5)
			{
				self rotateTo((0,self.angles[1],Ext),.7);
				wait .05;
			}
			for(Ext = Ext; Ext <= 120; Ext += 5)
			{
				self rotateTo((0,self.angles[1],Ext),.7);
				wait .05;
			}
			wait .05;
		}
	}
}
ClawSeats_Attach()
{
	level endon("game_ended");
	self endon("disconnect");
	level endon("Destroy_Claw");
	for(;;)
	{
		foreach(Rider in level.players)
		{
			if(!isDefined(Rider.OnRide))
			{
				for(Ext = 0; Ext < level.TheClaw_Seats.size; Ext++)
				{
					if(distance(level.TheClaw_Seats[Ext].origin, Rider.origin) < 100)
					{
						Rider iprintlnbold("Hold [{+usereload}] To Ride The Claw!");
						if(Rider useButtonPressed())
						{
							Rider iprintlnbold("[{+melee}] to exit");
							Rider.SavePos = Rider.origin;
							Rider playerLinkTo(level.TheClaw_Seats[Ext-1]);
							Rider.OnRide = true;
							if(Rider.god==0)
								Rider EnableInvulnerability();
						}
					}
				}
			}	
			else if(isDefined(Rider.OnRide) && Rider meleeButtonPressed())
			{
				Rider Unlink();
				Rider setOrigin(self.SavePos);
				if(Rider.god==0)
					Rider DisableInvulnerability();
				Rider.OnRide = undefined;
			}
		}
		wait .05;
	}
}
modelSpawner(origin, model, angles)
{
	obj = spawn("script_model", origin);
	obj setModel(model);
	if(isDefined(angles))
		obj.angles = angles;
	return obj;
}
initCoaster()
{
	if(self isHost())
	{
		if(!isDefined(level.RollerCoaster))
		{
			level.RollerCoaster = "Active";
			self thread buildCoaster();
			self iprintln("Roller Coaster ^5spawned");
		}
		else
		{
			level.RollerCoaster = undefined;
			level notify("stop_coaster");
			self iprintln("Roller Coaster ^4destroyed");
			foreach(player in level.players)
				if(player.god==0)
					player DisableInvulnerability();
			level.coasterFlag delete();
			foreach(kart in level.Kart)
				if(isDefined(kart))
					kart delete();
			foreach(package in level.Rail)
				if(isDefined(package))
					package delete();
		}
	}
	else
		self iprintln("You must be ^2Host^7 to do that");
}
buildCoaster()
{
	level endon("game_ended");
	self endon("disconnect");
	level endon("stop_coaster");
    level.Rail = [];
    level.Kart = [];
    for(Ext = 0; Ext < 8; Ext++)
        level.Rail[level.Rail.size] = modelSpawner(self.origin+(-70,22-Ext*70,105),"t6_wpn_supply_drop_ally",(0,0,0));
    for(Ext = 1; Ext < 12; Ext++)
        level.Rail[level.Rail.size] = modelSpawner(level.Rail[7].origin+(0,-280,1240)+(0,sin(154+Ext*5)*625,cos(184+Ext*3)*625+627),"t6_wpn_supply_drop_ally",(0,0,180-Ext*4));
    for(Ext = 1; Ext < 28; Ext++)
        level.Rail[level.Rail.size] = modelSpawner(level.Rail[18].origin+(0,sin(-60)*(Ext*60),sin(60)*(Ext*60)),"t6_wpn_supply_drop_ally",(0,0,136));  
    for(Ext = 1; Ext < 12; Ext++)
        level.Rail[level.Rail.size] = modelSpawner(level.Rail[45].origin+(0,0,-40)+(0,sin(150)*(Ext*-90),cos(250-Ext*6)*1-180),"t6_wpn_supply_drop_ally",(0,0,136+Ext*4));
    for(Ext = 1; Ext < 20; Ext++)
        level.Rail[level.Rail.size] = modelSpawner(level.Rail[56].origin+(0,sin(-75)*(Ext*75),0),"t6_wpn_supply_drop_ally",(0,0,0));
    for(Ext = 1; Ext < 50; Ext++)
        level.Rail[level.Rail.size] = modelSpawner(level.Rail[74].origin+(-440,25,0)+(sin(-250+Ext*5)*491,cos(-250+Ext*5)*491-87,0),"t6_wpn_supply_drop_ally",(0,0+Ext*5.5,0));
    for(Ext = 1; Ext < 30; Ext++)
        level.Rail[level.Rail.size] = modelSpawner(level.Rail[124].origin+(0,0,30)+(sin(60)*(Ext*60),0,sin(-60)*(Ext*60)),"t6_wpn_supply_drop_ally",(0,90,40));
    level.coasterFlag = spawn("script_model", self.origin+(-70,22,-10));
	level.coasterFlag setModel("mp_flag_neutral");
    for(;;)
	{
		foreach(player in level.players)
			if(Distance(player.origin, level.coasterFlag.origin) < 25)
				player thread Coaster_Think();
		wait .05;
	}
}
Coaster_Think()
{
	level endon("game_ended");
	self endon("disconnect");
	level endon("stop_coaster");
	if(self.god==0)
		self EnableInvulnerability();
	i = level.Kart.size;
    level.Kart[i] = modelSpawner(level.Rail[1].origin,"t6_wpn_supply_drop_ally",(0,270,0));
    self playerLinkTo(level.Kart[i]);
    self setplayerangles(vectorToAngles(((level.Rail[6].origin) - self geteye())));
    for(Ext=0;Ext<7;Ext++)
    {
        level.Kart[i] moveTo(level.Rail[Ext].origin+(0,0,30),.3);
        level.Kart[i] rotateTo((0,-90,0),.3);
        earthquake(.1,1,level.Rail[Ext].origin,150);
        wait .3;
    }
    for(Ext=8;Ext<26;Ext++)
    {
        level.Kart[i] moveTo(level.Rail[Ext].origin+(0,0,30),.5);
        level.Kart[i] rotateTo((45-Ext*4,-90,0),.5);
        earthquake(.15,.5,level.Rail[Ext].origin,100);
        wait .5;
    }
    for(Ext=26;Ext<45;Ext++)
    {
        level.Kart[i] moveTo(level.Rail[Ext].origin+(0,0,30),.2);
        level.Kart[i] rotateTo((-50,-90,0),.3);
        earthquake(.15,.5,level.Rail[Ext].origin,100);
        wait .2;
    }
    for(Ext=45;Ext<57;Ext++)
    {
        level.Kart[i] moveTo(level.Rail[Ext].origin+(0,0,30),.5);
        level.Kart[i] rotateTo((0,-90,0),.8);
        earthquake(.15,.5,level.Rail[Ext].origin,100);
        wait .5;
    }
    for(Ext=57;Ext<77;Ext++)
    {
        level.Kart[i] moveTo(level.Rail[Ext].origin+(0,0,30),.2);
        earthquake(.15,.5,level.Rail[Ext].origin,100);
        wait .2;
    }
    for(Ext=77;Ext<127;Ext++)
    {
        level.Kart[i] moveTo(level.Rail[Ext].origin+(0,0,30),.2);
        level.Kart[i] rotateTo((0,-90-Ext*5,0),.3);
        earthquake(.15,.5,level.Rail[Ext].origin,100);
        wait .2;
    }
    for(Ext=127;Ext<157;Ext++)
    {
        level.Kart[i] moveTo(level.Rail[Ext].origin+(0,0,30),.07);
        earthquake(.15,.5,level.Rail[Ext].origin,150);
        level.Kart[i] rotateTo((40,0,0),.3);
        wait .07;
    }
    level.Kart[i] delete();
    self setOrigin(level.coasterFlag.origin+(75,75,0));
    if(self.god==0)
		self DisableInvulnerability();
}
FFAscore(player)
{
	if(player isHost() && !self isHost())
		self iprintln("You cannot give the ^2Host^7 score");
	else
	{
		if(getdvar("g_gametype")=="dm")
    	{
    		player maps/mp/gametypes/_globallogic_score::givepointstowin(1);
    		player iprintln("^5+1^7 FFA Score");
    		if(!player isHost())
    			self iprintln("Gave ^5"+player.name+"^7 +1 FFA Score");
    	}
    	else
    		self iprintln("^1Gamemode is not Free For All");
    }
}
funnyCAxe()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("destroyMenu");
	self endon("EndFunnyAxe");
	self.tomahawkaimbot=booleanOpposite(self.tomahawkaimbot);
    self iprintln(booleanReturnVal(self.tomahawkaimbot, "Funny Combat Axe ^4OFF", "Funny Combat Axe ^5ON"));
    if(self.tomahawkaimbot)
    {
    	viable_targets = [];
		enemy = undefined;
		for(;;)
		{
			self takeweapon(self getcurrentoffhand());
			self giveweapon("hatchet_mp");
			self waittill("grenade_fire", grenade, weapname);
			if(weapname == "hatchet_mp")
			{
				wait .25;
				viable_targets = array_copy(level.players);
				arrayremovevalue(viable_targets, self);
				if(getdvar("g_gametype")!="dm")
				{
					foreach(player in level.players)
						if(player.pers["team"] == self.pers["team"] || player isHost() || !isAlive(player))
							arrayremovevalue(viable_targets, player);
				}
				enemy = getclosest(grenade getorigin(), viable_targets);
				if(isDefined(enemy))
					grenade thread trackplayer(enemy, self);
			}
		}
	}
	else
		self notify("EndFunnyAxe");
}
trackplayer(enemy, host)
{
	attempts = 35;
	if(enemy != host)
	{
		while(attempts > 0 && isalive(enemy) && IsDefined(enemy) && IsDefined(self) && !(self istouching(enemy)))
		{
			self.origin = (enemy.origin + (0, 0, 50)) + (self.origin - (enemy.origin + (0, 0, 50))) * (attempts / 35);
			wait 0.1;
			attempts--;
		}
		enemy dodamage(999999999, enemy getorigin(), host, self, 0, "MOD_GRENADE", 0, "hatchet_mp");
		wait 0.05;
		self delete();
	}
}























