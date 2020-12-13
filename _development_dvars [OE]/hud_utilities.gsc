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
    return hud;
}
createText(font, fontScale, align, relative, x, y, sort, alpha)
{
    textElem = self createFontString(font, fontScale);
    textElem setPoint(align, relative, x, y);
    textElem.sort = sort;
    textElem.alpha = alpha;
    textElem.hideWhenInMenu = true;
    return textElem;
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
    return hud;
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
setNColor(color)
{
    setColor("name", color);
	self.Private["name"] FadeOverTime(.5);
	self.Private["name"].color = color;
}
setOColor(color)
{
    setColor("options", color);
	for(i = 0; i < self.Private["options"].size; i++)
	{
		if(self.Private["options"][i] != self.Private["options"][self.menu.curs[self.menu.currentmenu]])
		{
			self.Private["options"][i] FadeOverTime(.5);
			self.Private["options"][i].color = color;
		}
	}
}
setTColor(color)
{
	setColor("title", color);
	self.Private["title"] FadeOverTime(.5);
	self.Private["title"].color = color;
	setColor("title2", color);
	self.Private["title2"] FadeOverTime(.5);
	self.Private["title2"].color = color;
	setColor("title3", color);
	self.Private["title3"] FadeOverTime(.5);
	self.Private["title3"].color = color;
}
setSColor(color)
{
	setColor("scroller", color);
	self.Private["options"][self.menu.curs[self.menu.currentmenu]] FadeOverTime(.5);
	self.Private["options"][self.menu.curs[self.menu.currentmenu]].color = color;
}
setGColor(color)
{
	setColor("glow", color);
	self.Private["glow"] = color;
	self.Private["title"].glowColor = color;
	self.Private["title2"].glowColor = color;
	self.Private["title3"].glowColor = color;
	for(i = 0; i < self.Private["options"].size; i++)
		self.Private["options"][i].glowColor = color;
	self.Private["name"].glowColor = color;
}
doDefault()
{
	self setNColor(color("cyan"));
    self setOColor(color("white"));
    self setTColor(color("black"));
    self setSColor(color("blue"));
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








































