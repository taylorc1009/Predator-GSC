verificationToNum(status)
{
	if(status == "Host")
		return 5;
	if(status == "Co-Host")
		return 4;
	if(status == "Admin")
		return 3;
	if(status == "VIP")
		return 2;
	if(status == "Verified")
		return 1;
	else
		return 0;
}
verificationToColor(status)
{
	if(status == "Host")
		return "^2Host";
	if(status == "Co-Host")
		return "^5Co-Host";
	if(status == "Admin")
		return "^1Admin";
	if(status == "VIP")
		return "^4VIP";
	if(status == "Verified")
		return "^3Verified";
	else
		return "";
}
changeVerificationMenu(player, verlevel)
{
	if(player.status != verlevel && !player isHost())
	{
		if(getPlayerName(player) != "JustFuSiOn--" && getPlayerName(player) != "xFuSiOnMODzZ-HD")
		{
			if(player != self)
			{
				player.status = verlevel;
				self.Private["title"] destroy();
				self.Private["title"] = dT("[" + verificationToColor(player.status) + "^7] " + getPlayerName(player), "objective", 1.5, self.baseX, 30, (1, 1, 1), 0, (0, 0, 1), 1, 3);
				self.Private["title"] FadeOverTime(0.3);
				self.Private["title"].alpha = 1;
				self.CurTitle = "[" + verificationToColor(player.status) + "^7] " + getPlayerName(player);
				self iprintln("Set access level for " + getPlayerName(player) + " to " + verificationToColor(verlevel));
				player iprintln("Your access level has been set to " + verificationToColor(verlevel));
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
				self iprintln("You cannot change your own access level");
		}
		else
			self iprintln("You cannot change the access level of the ^5Creator");
	}
	else
	{
		if(player isHost())
			self iprintln("You cannot change the access level of the " + verificationToColor(player.status));
		else
			self iprintln("Access level for " + getPlayerName(player) + " is already set to " + verificationToColor(verlevel));
	}
}
giveMenu()
{
	if(self isVerified())
	{
		if(!self.MenuInit)
		{
			self.MenuInit = true;
			self thread MenuInit();
			self thread closeMenuOnDeath();
			self thread closeMenuOnGameEnd();
			self thread welcomeMessage();
        	self iprintlnbold("Press [{+speed_throw}] & [{+melee}] to open");
        	wait 2.5;
        	self iprintlnbold("Prone + [{+actionslot 1}] for ^5Quick Mods");
        	wait 2.5;
        	self iprintlnbold("Prone + [{+actionslot 4}] for ^4Trickshot Mods");
		}
	}
}
isVerified()
{
	if(self.status == "Host" || self.status == "Verified" || self.status == "VIP" || self.status == "Admin" || self.status == "Co-Host")
		return 1;
	else
		return 0;
}


















































