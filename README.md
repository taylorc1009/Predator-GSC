# Predator v6.7
A modification menu made for Call of Duty®: Black Ops II. This project was not actively commited to GitHub, it was only commitd post-completion. This is my first personal programming project and therefore probably not made to the best of my ability. The form which this project used to be active, also containing further information, can be found [here](https://www.nextgenupdate.com/forums/black-ops-2-gsc-mods-scripts/843778-source-predator-v6-7-original-oldschool-base-non-host-end-game-blocker-1.html)

__Disclaimer__
```
This project is a modification intended for use in the video game Call of Duty®: Black Ops II. With that
being said, as all of the rights of the original game are reserved by the owners, the rights of this
project are also granted to said owners.

This project contains no code taken directly from the game itself, nor was it created to inflict
malicious intent upon the game. It has been created solely for recreational use. Any funcionality found
within which may appear to be unjustifiable because of that statement, or even violate it and possibly be
recognised as cruel to other players; they only exist for the purpose of protecting one's self and others
from players who do have malicious intent (such as DDoS-ing). Although, whatever actions are made by
users of this project, through the means of any of its features, are all of their own accord - I do not
take resposibility for what you do to other players in the game without their consent.
```

In order to use this menu, you will need to, first, download this source code and compile it for your desired platform. Once you have the project compiled, you will need to inject it into the game at run time. There are a few compilers and injectors out there in the community, some are built into the same application (I, personally, used GSC Studio).

There are two different visual layouts: Original and Old School Edition. Inject the one that you wish to use - both are compiled as `_development_dvars.gsc`, but you can only use one at a time. Images/videos of these in action can be found on the web.

You will need to inject the GSC files into the following directories:
```
/maps
  |--- /mp
        |--- _development_dvars.gsc
        |--- _ambient_package.gsc
        |--- /gametypes
                  |--- _rank.gsc
```
