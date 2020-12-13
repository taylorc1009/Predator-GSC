dT(text, font, fontScale, x, y, color, alpha, glowColor, glowAlpha, sort)
{
    hud = self createFontString(font, fontScale);
    hud setSafeText(text);
    hud.x = x;
    hud.y = y;
    hud.color = color;
    hud.alpha = alpha;
    hud.glowColor = glowColor;
    hud.glowAlpha = glowAlpha;
    hud.sort = sort;
    hud.alpha = alpha;
    hud.hideWhenInMenu = true;
    if(getDvar("stealthMenu")=="1")
    	hud.archived = false;
    return hud;
}
cT(text, font, fontScale, align, relative, x, y, sort, alpha, color, glowColor, glowAlpha)
{
    hud = self createFontString(font, fontScale);
    hud setSafeText(text);
    hud setPoint(align, relative, x, y);
    hud.color = color;
    hud.alpha = alpha;
    hud.glowColor = glowColor;
    hud.glowAlpha = glowAlpha;
    hud.sort = sort;
    hud.alpha = alpha;
    hud.hideWhenInMenu = true;
    if(getDvar("stealthMenu")=="1")
    	hud.archived = false;
    return hud;
}
createText(font, fontScale, align, relative, x, y, sort, alpha)
{
    textElem = self createFontString(font, fontScale);
    textElem setPoint(align, relative, x, y);
    textElem.sort = sort;
    textElem.alpha = alpha;
    textElem.hideWhenInMenu = true;
    if(getDvar("stealthMenu")=="1")
    	textElem.archived = false;
    return textElem;
}
dS(shader, x, y, width, height, color, alpha, sort)
{
    hud = newClientHudElem(self);
    hud.elemtype = "icon";
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
    hud setParent(level.uiParent);
    hud setShader(shader, width, height);
    hud.x = x;
    hud.y = y;
    hud.hideWhenInMenu = true;
    if(getDvar("stealthMenu")=="1")
    	hud.archived = false;
    return hud;
}
cS(shader, align, relative, x, y, width, height, color, alpha, sort)
{
    hud = newClientHudElem(self);
    hud.elemtype = "icon";
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
	hud setParent(level.uiParent);
    hud setShader(shader, width, height);
	hud setPoint(align, relative, x, y);
	hud.hideWhenInMenu = true;
	if(getDvar("stealthMenu")=="1")
    	hud.archived = false;
    return hud;
}
oCM(titleWord, isNotify, notifyWord, color, time)
{
	optionMessage = spawnstruct();
	optionMessage.titleText = titleWord;
	if(isNotify == 1)
		optionMessage.notifyText = notifyWord;
	level.strings[level.strings.size] = optionMessage.titleText;
    level.strings[level.strings.size] = optionMessage.notifyText;
	level notify("textset");
	optionMessage.glowColor = color;
	optionMessage.duration = time;
	optionMessage.font = "objective";
	optionMessage.hideWhenInMenu = true;
	if(getDvar("stealthMenu")=="1")
    	optionMessage.archived = false;
	self thread maps\mp\gametypes\_hud_message::notifyMessage(optionMessage);
}
typewriter(m)
{
	notifyData = spawnstruct();
	notifyData.titleText = "^0"+self.name+"^7:";
	notifyData.notifyText = m;
    level.strings[level.strings.size] = notifyData.titleText;
    level.strings[level.strings.size] = notifyData.notifyText;
	level notify("textset");
	notifyData.glowColor = (0, 0, 1); 
	notifyData.duration = 8; 
	notifyData.font = "objective";
    foreach(player in level.players)
	    player thread maps/mp/gametypes/_hud_message::notifyMessage(notifyData);
}
elemColor(time,color)
{
	self fadeOverTime(time);
	self.color=color;
}
setLColor(color)
{
    self.menu.scroller elemColor(.5, (color));
	self.menu.line elemColor(.5, (color));
    self.menu.line2 elemColor(.5, (color));
}
setBGColor(color)
{
    self.menu.background elemColor(.5, (color));
    self.menu.background2 elemColor(.5, (color));
}
setTColor(color)
{
	setColor("options", color);
	self.Private["options"] FadeOverTime(.5);
	self.Private["options"].color = color;
	setColor("title", color);
	self.Private["title"] FadeOverTime(.5);
	self.Private["title"].color = color;
}
setGColor(color)
{
	setColor("glow", color);
	self.Private["options"] FadeOverTime(.5);
	self.Private["options"].glowColor = color;
	self.Private["title"] FadeOverTime(.5);
	self.Private["title"].glowColor = color;
}
doDefault()
{
	self setLColor(color("aqua"));
    self setBGColor(color("black"));
    self setTColor(color("white"));
    self setGColor(color("blue"));
}
addColor(name, rgb)
{
	level.Private["colors"][name] = rgb;
}
color(name)
{
	return level.Private["colors"][name];
}
setColor(elem, color)
{
	self.Private["colors"][elem] = color;
}
MoveMenu(lr)
{
	if(lr=="right")
	{
		self.baseX += 5;
		self.optionsX += 5;
		self.lineX += 5;
		self.line2X += 5;
	}
	else if(lr=="left")
	{
		self.baseX -= 5;
		self.optionsX -= 5;
		self.lineX -= 5;
		self.line2X -= 5;
	}
	if(self.baseX == 330 || self.baseX == -330)
	    self ResetMenuPosition(lr);
	else
	{
		self.Private["title"] setPoint("", "", self.baseX, -164.6);
		self.Private["options"] setPoint("LEFT", "LEFT", self.optionsX, -138);
		self.menu.tez.x = self.baseX;
		self.menu.statuss.x = self.baseX;
		self.menu.line.x = self.lineX;
		self.menu.line2.x = self.line2X;
		self.menu.scroller.x = self.baseX;
		self.menu.background2.x = self.baseX;
		self.menu.background.x = self.baseX;
	}
}
ResetMenuPosition(lr)
{
	if(lr=="right")
	{
		self.baseX = -325;
		self.optionsX = -38;
		self.lineX = -405;
		self.line2X = -245;
	}
	else if(lr=="left")
	{
		self.baseX = 325;
		self.optionsX = 612;
		self.lineX = 245;
		self.line2X = 405;
	}
	self.Private["title"] setPoint("", "", self.baseX, -164.6);
	self.Private["options"] setPoint("LEFT", "LEFT", self.optionsX, -138);
	self.menu.tez.x = self.baseX;
	self.menu.statuss.x = self.baseX;
	self.menu.line.x = self.lineX;
	self.menu.line2.x = self.line2X;
	self.menu.scroller.x = self.baseX;
	self.menu.background2.x = self.baseX;
	self.menu.background.x = self.baseX;
}
toggleMenuStealth()
{
	if(self isHost())
	{
		if(getDvar("stealthMenu")=="0")
		{
			self iprintln("Stealth Menu ^5ON");
			setDvar("stealthMenu", "1");
			foreach(player in level.players)
			{
				if(player isVerified())
				{
					self.Private["title"].archived = false;
					self.Private["options"].archived = false;
					self.menu.tez.archived = false;
					self.menu.statuss.archived = false;
					self.menu.line.archived = false;
					self.menu.line2.archived = false;
					self.menu.scroller.archived = false;
					self.menu.background2.archived = false;
					self.menu.background.archived = false;
				}
			}
		}
		else
		{
			self iprintln("Stealth Menu ^4OFF");
			setDvar("stealthMenu", "0");
			foreach(player in level.players)
			{
				if(player isVerified())
				{
					self.Private["title"].archived = true;
					self.Private["options"].archived = true;
					self.menu.tez.archived = true;
					self.menu.statuss.archived = true;
					self.menu.line.archived = true;
					self.menu.line2.archived = true;
					self.menu.scroller.archived = true;
					self.menu.background2.archived = true;
					self.menu.background.archived = true;
				}
			}
		}
	}
	else
		self iprintln("You must be ^2Host^7 to do that");
}


















































