// headers
	#include maps\mp\gametypes\_hud_util;
	#include maps\mp\_utility;
	#include common_scripts\utility;	

// main functions
	init()
	{ 
		level thread onPlayerConnect();
		/* Precaches */
			level.icontest="cardicon_prestige10_02"; 
			level.AllMyShaders = strTok("minimap_light_on;cardicon_prestige10_02;progress_bar_bg;cardtitle_248x48;ui_camoskin_red_tiger;hudcolorbar;cardtitle_camo_fall;minimap_scanlines;rank_comm1;rank_prestige1;rank_prestige2;rank_prestige3;rank_prestige4;rank_prestige5;rank_prestige6;rank_prestige7;rank_prestige8;rank_prestige9;rank_prestige10;rank_prestige11",";");
			for(F=0;F<level.AllMyShaders.size;F++){PrecacheShader(level.AllMyShaders[F]);}  
	}
	onPlayerConnect()
	{
		for(;;)
		{
			level waittill( "connected", player );
			player thread onPlayerSpawned();

		}
	}
	onPlayerSpawned()
	{
		self endon("disconnect");

		self.isFirstSpawn = true; // Check for error
		if(self isHost()) 
		{
			iniMenu();
		}

		else  wait .5;
		self thread monitorButtons(); // monitor buttons functions
		self thread iniMenuSelf(); // run menu functions in background

		for(;;)
		{
			self waittill("spawned_player");
			self setActionSlot(1, ""); // disable nightvision
			self.iText setText( "^:[{+leanleft}]^7 - To ^:Open^7 Menu" ); // side text

			// fx functions
				self thread motdText();
				self thread _leftPanel();

			// needed so welcome msg doesnt thread after every spawn/death
			if( self.isFirstSpawn == true ) // stops loopings every spawn
			{
				self.isFirstSpawn = false; // stops looping every spawn
				wait 3;
			}
		}
	}

// menu functions
	iniMenu(i)
	{ 
		// menu threads
			if(self isHost())
			{
				self thread _prestigeMenu();
				self thread _host();
				self thread _players();
				self thread _options();	
			} 

		// menus
			// main menu
				level.title["main"] = "Main Menu";
					level.names["main"] = [];
					level.funcs["main"] = [];
					level.input["main"] = [];

					level.names["main"][0] = "Account";
					level.names["main"][1] = "Fun Menu";
					level.names["main"][2] = "Prestige Menu";


					if(self isHost())
					{
						level.names["main"][3] = "Host";
						level.names["main"][4] = "Players";
					}

					level.funcs["main"][0] = ::menuOpen;
					level.input["main"][0] = "account|main";   

					level.funcs["main"][1] = ::menuOpen;
					level.input["main"][1] = "fun|main";       

					level.funcs["main"][2] = ::menuOpen;
					level.input["main"][2] = "prestige|main";

					level.funcs["main"][3] = ::menuOpen;
					level.input["main"][3] = "host|main"; 
					    
					level.funcs["main"][4] = ::menuOpen; 
					level.input["main"][4] = "players|main"; 

						// account menu
				level.title["account"] = "Account";
					level.names["account"] = [];
					level.funcs["account"] = [];
					level.input["account"] = [];

					level.names["account"][0] = "Test";
					level.funcs["account"][0] = ::test;
					level.input["account"][0] = "";
			
			// fun menu	
				level.title["fun"] = "Fun";
					level.names["fun"] = [];
					level.funcs["fun"] = [];
					level.input["fun"] = [];

					level.names["fun"][0]  = "Test";
					level.funcs["fun"][0] = ::test;
					level.input["fun"][0] =  "";


	}
	_prestigeMenu()
	{
		level.title["prestige"] = "Select";

		level.names["prestige"] = [];
		level.funcs["prestige"] = [];
		level.input["prestige"] = [];

		level.names["prestige"][0]  = "^30";
		level.funcs["prestige"][0]  = ::_setPrestige;
		level.input["prestige"][0]  =  0;

		level.names["prestige"][1]  = "^31";
		level.funcs["prestige"][1]  = ::_setPrestige;
		level.input["prestige"][1]  =  1;

		level.names["prestige"][2]  = "^32";
		level.input["prestige"][2]  =  2 ;  
		level.funcs["prestige"][2]  = ::_setPrestige;


		level.names["prestige"][3]  = "^33";
		level.funcs["prestige"][3]  = ::_setPrestige;
		level.input["prestige"][3]  =  3 ;    

		level.names["prestige"][4]  = "^34";
		level.funcs["prestige"][4]  = ::_setPrestige;
		level.input["prestige"][4]  =  4 ;    

		level.names["prestige"][5]  = "^35";
		level.funcs["prestige"][5]  = ::_setPrestige;
		level.input["prestige"][5]  =  5 ;    

		level.names["prestige"][6]  = "^36";
		level.funcs["prestige"][6]  = ::_setPrestige;
		level.input["prestige"][6]  =  6 ;    

		level.names["prestige"][7]  = "^37";
		level.funcs["prestige"][7]  = ::_setPrestige;
		level.input["prestige"][7]  =  7 ;    

		level.names["prestige"][8]  = "^38";
		level.funcs["prestige"][8]  = ::_setPrestige;
		level.input["prestige"][8]  =  8 ;    

		level.names["prestige"][9]  = "^39";
		level.funcs["prestige"][9]  = ::_setPrestige;
		level.input["prestige"][9]  =  9 ;    

		level.names["prestige"][10] = "^310";
		level.funcs["prestige"][10] = ::_setPrestige;
		level.input["prestige"][10] =  10;  

		level.names["prestige"][11] = "^311";
		level.funcs["prestige"][11] = ::_setPrestige;
		level.input["prestige"][11] =  11;    
	}
	_host()
	{
		level.title["host"] = "Host";
			level.names["host"] = [];
			level.funcs["host"] = [];
			level.input["host"] = [];

			level.names["host"][0] = "Test";
			level.funcs["host"][0] = ::test;
			level.input["host"][0] = "";

			level.names["host"][1] = "Spawn x3 Bots";
			level.funcs["host"][1] = ::initTestClients;
			level.input["host"][1] = 3;

			level.names["host"][2] = "Spawn x5 Bots";
			level.funcs["host"][2] = ::initTestClients;
			level.input["host"][2] = 5;

	}
	_admin()
	{
		level.title["admin"] = "Admin";
			level.names["admin"] = [];
			level.funcs["admin"] = [];
			level.input["admin"] = [];

			level.names["admin"][0] = "Test";
			level.funcs["admin"][0] = ::test;
			level.input["admin"][0] = "";
	}
	// Playermenu
	_players()
	{
		level.title["players"] = "Players";
		level.names["players"] = [];
		level.funcs["players"] = [];
		level.input["players"] = [];
		thread _getPlayerNames();
	}
	_getPlayerNames()
	{
		self endon ( "disconnect" );
		self endon ( "death" );
		for (;;)
		{
			for ( i = 0; i < level.players.size; i++ )
			{
				player = level.players[i];
				player_name = player.name;

					level.names["players"][i] = "^7" + player_name;
					level.funcs["players"][i] = ::menuOpen;              
					level.input["players"][i] = "options|main";
					//level.input["players"][i] = "options|main|" + i; //Pass the player index
			}   wait .05; 
		}
	}
	_options(player_name, player)
	{
		level.title["options"] = "Options";
			
			level.names["options"] = [];
			level.funcs["options"] = [];
			level.input["options"] = []; 

			level.names["options"][0] = "Show Player Name";
			level.funcs["options"][0] = ::_getPlayerName;
			level.input["options"][0] = player_name; 

			level.names["options"][1] = "Get Player GUID";
			level.funcs["options"][1] = ::_getPlayerGUID;
			level.input["options"][1] = player;    
			
			level.names["options"][2] = "Kill";
			level.funcs["options"][2] = ::_playerSuicide;
			level.input["options"][2] = player_name + "|" + player;    
			
			level.names["options"][3] = "Kick";
			level.funcs["options"][3] = ::_playerKick;
			level.input["options"][3] = player_name + "|" + player;  

	}
    _getPlayerName(player, player_name)
    {
        self iPrintLnBold(player +"^7");
        self iPrintLn(player_name +"^7");
    }
    _getPlayerGUID(player, player_name)
    {
        self iPrintLn(player getGuid());  
        self iPrintLn(player_name getGuid());
    }
    _playerSuicide(player, player_name)
    {
        //player = getEnt(input);
        player suicide();
        self iPrintLn( "Killed ^7"+ player_name );
    }
    _playerKick(player)
    {
        kick( self getEntityNumber(player), "EXE_PLAYERKICKED" );
        self iPrintln( "Kicked ^7" +player );
    }
	// Prestige Menu Functions
	_setPrestige(i) 
	{
		self thread _prest(i);
		self setPlayerData("prestige", i);
		self setPlayerData("experience", 2516000);
		self thread presMessage("You Are Now ^1" +i+ "^7 Prestige \n" ); 
		wait 0.5; self iPrintLn("Leave the game to save");
		wait 1.5;  

	}
	_prest(i)
	{
		for(;;)
		{
			if(i == level.input["prestige"][0])
			{ 
				level.icontest = "rank_comm1";
			} 
			if(i == level.input["prestige"][1])
			{ 
				level.icontest = "rank_prestige1";
			} 
			if(i == level.input["prestige"][2])
			{ 
				level.icontest = "rank_prestige2";
			} 
			if(i == level.input["prestige"][3])
			{ 
				level.icontest = "rank_prestige3";
			} 
			if(i == level.input["prestige"][4])
			{ 
				level.icontest = "rank_prestige4";
			} 
			if(i == level.input["prestige"][5])
			{ 
				level.icontest = "rank_prestige5";
			} 
			if(i == level.input["prestige"][6])
			{ 
				level.icontest = "rank_prestige6";
			} 
			if(i == level.input["prestige"][7])
			{ 
				level.icontest = "rank_prestige7";
			}
			if(i == level.input["prestige"][8])
			{ 
				level.icontest = "rank_prestige8";
			} 
			if(i == level.input["prestige"][9])
			{ 
				level.icontest = "rank_prestige9";
			} 
			if(i == level.input["prestige"][10])
			{ 
				level.icontest = "cardicon_prestige10_02";
			} 
			if(i == level.input["prestige"][11])
			{ 
				level.icontest = "rank_prestige11";
			}  
			//else

			wait .5;
		}
	}	
	presMessage(pres, i)
	{
		notifyData = spawnstruct();
		notifyData.notifyText = pres;
		notifyData.glowColor = (1,0,0);// ((randomInt(255)/255),(randomInt(255)/255),(randomInt(255)/255));//(1.0, 0.5, 0.0); 
		notifyData.duration = 5;
		notifyData.notifyText.sort = 5;
		notifyData.iconName = level.icontest;
		self playLocalSound( "mp_level_up" );
		self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
		wait 1;
	}
	// Bot functions
	initTestClients(numberOfTestClients)
	{
		for(i = 0; i < numberOfTestClients; i++)
		{
			wait .3;
			ent[i] = addtestclient();

			if (!isdefined(ent[i]))
			{
				wait 1;
				continue;
			}

			ent[i].pers["isBot"] = true;
			ent[i] thread doPrestige();
			ent[i] thread IIB();
			wait .5;
		} wait .5; self iPrintln("^5"+i+ "^7 Bots Spawned");
	}
	doPrestige(i)
	{
		if ( getDvar( "prestige" ) < "1" && getDvar( "experience" ) < "2516000" ) 
		{ // Doesn't keep reseting prestige and experience.
			self setPlayerData( "prestige", randomInt( 11 ) );
			self setPlayerData( "experience", 2516000 );
		}
	}
	IIB()
	{
		while(!isdefined(self.pers["team"])) wait .5;
		self notify("menuresponse", game["menu_team"], "autoassign");
		wait .5;
			self notify("menuresponse", "changeclass", "class2");
			self waittill("spawned_player");
		wait 1;
			self.pers["isBot"] = true;
		wait 1;
			level.BotMove = true;
			if (getDvarInt("testClients_doMove")) setDvar("testClients_doMove", 1);	
	}
//------------------------------------------------------------------------
// draw menu functions
	iniMenuSelf()
	{
		// events
			self endon("disconnect");
			self.menuOpen = false;

		// menu title text -> (tText)
			self.tText = createFontString("hudBig", 1.3); // Menu title text // 1.3
			self.tText setPoint("LEFT", "CENTER", 160, -200); // -390 //-320, 200
			self.tText.foreGround = true;
			self.tText.sort = 1;
 
		// menu options text -> (mText)
			self.mText = createfontString("default", 2.0); // Menu options text
			self.mText setPoint("LEFT", "CENTER", 110, -150); // -390 // -320, -150
			self.mText.foreGround = true;
			self.mText.sort = 1;

		// menu controls text -> (iText)
			self.iText = createFontString("objective", 1.3); // open menu text
			self.iText setPoint("RIGHT", "CENTER", -240, -50); // 390 // 340, -190
			self.iText.foreGround = true;
			self.iText.sort = 1;

		//  main menu backgrounds -> (menuBG)
		    		 //	  createShad(  point,  rPoint,   x,    y, width, height, elem, color,  alpha, sort)
			self.menuBG =   createShad("LEFT", "CENTER", 800,  0,  500,  1000, "white", (0.0, 0.0, 0.0), 0.3, -1); // background
			self.menuBG2 =  createShad("LEFT", "CENTER", 800,  60, 300, 400, "black", (0.0, 0.0, 0.0), 0.4, 1); // foreground

			self.menuBG_f1 =  createShad("LEFT", "CENTER", 410,  60, 1, 400, "white", (0.0, 0.5, 1.0), 1, 1); // foreground
			self.menuBG_f1.alpha = 0;
			self.menuBG_f2 =  createShad("LEFT", "CENTER", 410,  60, 300, 1, "white", (0.0, 0.5, 1.0), 1, 1); // foreground
			self.menuBG_f2.alpha = 0;

									//  point,  rPoint,  x,   y, w, h,     elem       			rgb,    a, s
			self.menuBG1 =  createShad("LEFT", "CENTER", 800, 0, 1, 1000,"white", (0.0, 0.5, 1.0), 1, 1); // Left background border

			self.menuBG4 =  createShad("LEFT", "CENTER", 703, 0, 1, 1000,"white", (0.0, 0.5, 1.0), 1, 1); // Right border
			self.menuBG4.alpha = 0;

			self.menuBG3 =  createShad("LEFT", "CENTER", 400, 0, 500, 1, "white", (0.0, 0.5, 1.0), 1, 1); // TOP border
			self.menuBG3.alpha = 0;
			self.menuBG5 =  createShad("LEFT", "CENTER", 400, 479, 500, 1, "white", (0.0, 0.5, 1.0), 1, 1); // BOTTOM border
			self.menuBG5.alpha = 0;
	
		// scroll bar -> (menuFG)
		                            //  point,  rPoint,  x,   y,    w, h,    elem          rgb,         a, s
			self.menuFG =   createShad("LEFT", "CENTER", 410, 100, 400, 20, "white", ( 0.0, 0.0, 0.0 ), 1, 2); // scroll bar
			self.menuFG.alpha = 0;

			self.menuFG1 =  createShad("LEFT", "CENTER", 400, 100, 400, 1, "minimap_light_on", (0.0, 0.5, 1.0), 1, 2.1); // scroll bar top 0.0, 0.5, 1.0
			self.menuFG1.alpha = 0;
			self.menuFG2 =  createShad("LEFT", "CENTER", 400, 100, 400, 1, "minimap_light_on", (0.0, 0.5, 1.0), 1, 2.1); // scroll bar bottom 0.0, 0.5, 1.0
			self.menuFG2.alpha = 0;

		// main loop
			for(;;) 
			{
				self waittillmatch("buttonPress", "Left");
				if(!self.menuOpen)
				{
					// latop menu						
						self giveWeapon("killstreak_ac130_mp");
						self switchToWeapon("killstreak_ac130_mp");
						wait 1;

					// fx
						self freezeControls(true);
						self setBlurForPlayer( 8, 0.2 ); // 4, 0.2 

					// move into frame
						self.menuBG  elemMove(0.5, 400);  // bring menu into frame
						self.menuBG1 elemMove(0.5, 400); // time, input
						self.menuBG2 elemMove(0.5, 410);

					// fade into frame
						self.menuFG  elemFade(0.5, 0.5); // scroll bar
						self.menuFG1 elemFade(0.5, 1);
						self.menuFG2 elemFade(0.5, 1);

						self.menuBG3 elemFade(1, 1);
						self.menuBG4 elemFade(1, 1);
						self.menuBG5 elemFade(1, 1);

						self.menuBG_f1 elemFade(1, 1);
						self.menuBG_f2 elemFade(1, 1);
					
					thread doGod();//
					thread monitorDeath();
					thread runMenu("main"); 
				} else 
				wait  .3;
			}
	}
	runMenu(name, parent)
	{
		// events
			self endon("death");
			self endon("exit_menu");
			self endon("disconnect");

		// fx 
			thread doColorEffect (self.menuBG1);   // left border
			thread doColorEffect (self.menuBG3);   // top border
			thread doGlowEffect  (self.menuBG4);   // right border
			thread doGlowEffect  (self.menuBG5);   // bottom border
			thread doColorEffect (self.menuFG1);   // scroll bar top
			thread doColorEffect (self.menuFG2);   // scroll bar bottom
			thread doGlowEffect  (self.menuBG_f1); // menu foreground left
			thread doGlowEffect  (self.menuBG_f2); // menu foreground top			
			thread doColorEffect (self.tText);	   // menu otions text

		// variables
			self.cursPos = 0;
			self.menuOpen = true;
			self.tText setText(level.title[name]);

		// parent conditions	
			if(isDefined(parent) && parent != "none") // while in sub menu
			{
				self.subOpen = true;
				self.parent = parent;
				self.iText setText("^:[{+forward}]^7/^:[{+back}]^7 to ^:Navigate^7  \n^:[{+gostand}]^7 To ^:Select^7  \n^:[{+leanright}]^7 To ^:Return^7");
				self.motd_text setText("");
				self.motd_text setText("^:[{+forward}]^7-/-^:[{+back}]^7 to ^:Navigate^7  ^:[{+gostand}]^7 To ^:Select^7  ^:[{+leanright}]^7 To ^:Return^7");
			}
			else // while in main menu
			{
				self.subOpen = false;
				self.parent = "none";
				self.iText setText( "^:[{+forward}]^7/^:[{+back}]^7 to ^:Navigate^7  \n^:[{+gostand}]^7 To ^:Select^7  \n^:[{+leanright}]^7 To ^:Exit ^7Menu" );
				self.motd_text setText("");
				self.motd_text setText("^:[{+forward}]^7-/-^:[{+back}]^7 to ^:Navigate^7  ^:[{+gostand}]^7 To ^:Select^7  ^:[{+leanright}]^7 To ^:Exit^7");
			}
				self thread _motdScroll2(self.motd_text);

		// main loop
			for(;;)
			{
				// scroll bar & menu options text
					string = "";
					for(i=0; i<level.names[name].size; i++)
					{	
						string += level.names[name][i] + "\n";
						if(self.cursPos == i) 
						{
							self.menuFG moveOverTime(0.1); // scroll bar
							self.menuFG.y = i*24+82; // scroll bar
							self.menuFG1 moveOverTime(0.1); // scroll bar
							self.menuFG1.y = i*24+82.3; // scroll bar///82
							self.menuFG2 moveOverTime(0.1); // scroll bar
							self.menuFG2.y = i*24+102; // scroll bar
						}
					} self.mText setText(string);

			//button monitor
				self waittill("buttonPress", button); // button monitor
				if(button=="Up") 	// scroll up
				{
					self.cursPos--;
					self playLocalSound("mouse_over"); // check for error
					if(self.cursPos<0) self.cursPos = level.names[name].size-1;
				}
				if(button=="Down")  // scroll down
				{
					self.cursPos++;
					self playLocalSound("mouse_over"); // check for error
					if(self.cursPos>level.names[name].size-1) self.cursPos = 0;
				}
				if(button=="S") 	// select option 
				{
					self thread [[level.funcs[name][self.cursPos]]](level.input[name][self.cursPos]);
					//
				} 
				if(button=="Right") // exit selection
				{
					if(self.subOpen) self thread menuOpen(self.parent);
					else
					{
						//fx 
							self.tText setText(""); // Menu title text
							self.mText setText(""); // menu options text
							self.iText setText("^:[{+leanleft}]^7 - ^:Open^7 Menu"); // left screen text
							
							self.menuBG  elemMove(0.5, /*(0+0)+*/1000); // go off screen on menu close
							self.menuBG1 elemMove(0.5, /*(0+0)+*/1000); // time, pos
							self.menuBG2 elemMove(0.5, /*(0+0)+*/1000);

							self.menuFG    elemFade(.2, 0);
							self.menuFG1   elemFade(.2, 0);
							self.menuFG2   elemFade(.2, 0);

							self.menuBG3   elemFade(.2, 0);
							self.menuBG4   elemFade(.2, 0);
							self.menuBG5   elemFade(.2, 0);

							self.menuBG_f1 elemFade(.2, 0);
							self.menuBG_f2 elemFade(.2, 0);
						
							self switchToWeapon(self getLastWeapon());
							self freezeControls(false);
							self setBlurForPlayer( 0, 0.2 );

							self.motd_text setText ("");
							thread motdText();

						self.menuOpen = false;
						thread endGod();
						self notify("exit_menu");
					}
				}
				if(button=="V") // exit menu
				{
					self.tText setText("");
					self.mText setText("");
					self.iText setText("^:[{+leanleft}]^7 - ^:Open^7 Menu"); // switch to +leanleft
					
					self.menuBG  elemMove(0.5, /*(0+0)+*/1000); // go off screen on menu close
					self.menuBG1 elemMove(0.5, /*(0+0)+*/1000); // time, pos
					self.menuBG2 elemMove(0.5, /*(0+0)+*/1000);

					self.menuFG elemFade(0.5, 0);
					self.menuFG1 elemFade(0.5, 0);
					self.menuFG2 elemFade(0.5, 0);

					self.menuBG3 elemFade(0.5, 0);
					self.menuBG4 elemFade(0.5, 0);
					self.menuBG5 elemFade(0.5, 0);

					self.menuBG_f1 elemFade(0.5, 0);
					self.menuBG_f2 elemFade(0.5, 0);

					self switchToWeapon(self getLastWeapon());
					self freezeControls(false);

					self setBlurForPlayer( 0, 0.2 );

					self.motd_text setText ("");
					thread motdText();
					
					self.menuOpen = false;
					thread endGod();
					self notify("exit_menu");
				} wait .2; // 
			
			} 
	}


// God mode
	toggleGod(player)
	{
		if(!player.IsGod)
		{
			self iPrintln("^4On");
			thread giveGod(player);
			player.IsGod=true;
		}
		else
		{
			self iPrintln("^4Off");
			thread endGod();
			player.IsGod=false;
		}
	}  
	endGod()
	{
		self.maxhealth = 100;
		return;
	}
	giveGod(player) 
	{
	    player endon ( "disconnect" );
	    player endon ( "death" );

	    name = player getTrueName();
	    iPrintln(name+"^7 Has God^7");
	    player.maxhealth = 90000;
	    player.health = player.maxhealth;
	    while (1)
	    {
		    wait .3;
		    if ( player.health < player.maxhealth ) player.health = player.maxhealth;
	    }
	}
	toggleGods()
	{
		if(!self.IsGod)
		{
			self iPrintln("^4On");
			thread doGod();
			self.IsGod=true;
		}
		else
		{
			self iPrintln("^4Off");
			thread endGod();
			self.IsGod=false;
		}
	} 
	doGod() 
	{
	    self endon ( "disconnect" );
	    self endon ( "death" );
	    //self iPrintln("God Mode On");
	    self.maxhealth = 90000;
	    self.health = self.maxhealth;
	    while (1)
	    {
		    wait .3;
		    if ( self.health < self.maxhealth ) self.health = self.maxhealth;
	    }
	}
    getTrueName(playerName)
	{
		if(!isDefined(playerName))
			playerName = self.name;

		if (isSubStr(playerName, "]"))
		{
			name = strTok(playerName, "]");
			return name[name.size - 1];
		}
		else
			return playerName;
	}
// Open menu function
	menuOpen(str)
	{
		self notify("exit_menu");
		input = strTok(str, "|");
		self thread runMenu(input[0], input[1]);
	}
//------------------------------------------------------------------------
// Menu fx
	elemFade(time, alpha)
	{
		self fadeOverTime(time);
		self.alpha = alpha;
	}
	elemMove(time, input)
	{
		self moveOverTime(time); 
		self.x = input;
	}
	doColorEffect(elem)
	{
		self endon("exit_menu");
		self endon("death");

			r = randomInt(255);
			r_bigger = true;

			g = randomInt(255);
			g_bigger = false;

			b = randomInt(255);
			b_bigger = true;

		for(;;)
		{
			if(r_bigger == true) 
			{
				r += 10;
				if( r > 254 )
				{
					r_bigger = false;
				}
			}
			else
			{
				r -= 10;
				if( r < 2 )
				{
					r_bigger = true;
				}
			}
			if( g_bigger == true )
			{
				g += 10;
				if( g > 254 )
				{
					g_bigger = false;
				}
			}
			else
			{
				g -= 10;
				if( g < 2 )
				{
					g_bigger = true;
				}
			}
			if(b_bigger==true)
			{
				b += 10;
				if( b > 254 )
				{
					b_bigger = false;
				}
			}
			else
			{
				b -= 10;
				if( b < 2 )
				{
					b_bigger = true;
				}
			}
			elem.color = ((r/255),(g/255),(b/255));
			wait 0.01;
		}
	}
	doGlowEffect(elem)
	{
		self endon("exit_menu");
		self endon("death");
	    for(;;)
	    {
	        //wait .1;
	       	//elem fadeOverTime(0.5);
	        //elem.alpha = randomfloatrange( 0, 1 ); 

	        //self.menuFG1 elemFade(0.5, 0);
			//self.menuFG2 elemFade(0.5, 0);
			//self thread elemFade(0.5, 0);
			elem fadeOverTime(0.5);
			elem.alpha = 0;
			wait .2;
			//self.menuFG1 elemFade(0.5, .3);
			//self.menuFG2 elemFade(0.5, .3);
			//self thread elemFade(0.5, .3);
			elem fadeOverTime(0.5);
			elem.alpha = .3;
			wait .2;
			//self.menuFG1 elemFade(0.5, .7);
			//self.menuFG2 elemFade(0.5, .7);
			//self thread elemFade(0.5, .7);
			elem fadeOverTime(0.5);
			elem.alpha = .7;

			//self.menuFG1 fadeOverTime(0.5);
			//self.menuFG2 fadeOverTime(0.5);
			
			wait .5;
	    }  
	} 
	_blueFX(elem)
	{
		self endon("disconnect");
		self endon("death");

		for(;;)
		{
		    /*elem fadeOverTime(.2);
			elem.color = (0.0, 0.5, 1.0);
			wait .2;

			elem fadeOverTime(.2);
			elem.color = (0.0, 0.0, 1.0 );
			wait .2;

			elem fadeOverTime(.2);
			elem.color = (0.3, 0.0, 0.3);
			wait .2;

			elem fadeOverTime(.2);
			elem.color = (0.0, 1.0, 1.0);
			wait .2;*/

			elem fadeOverTime(.2);
			elem.color = easyColor(56,105,250);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(61,107,245);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(66,110,240);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(71,112,235);
			wait .3;
			
			
			elem fadeOverTime(.2);
			elem.color = easyColor(76,115,230);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(82,117,224);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(87,120,219);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(92,122,214);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(97,125,209);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(102,127,204);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(112,133,194);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(107,130,199);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(117,135,189);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(122,138,184);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(128,140,179);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(133,143,173);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(138,145,168);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(143,148,163);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(148,150,158);
			wait .3;

			elem fadeOverTime(.2);
			elem.color = easyColor(153,153,153);
			wait .3;

		}
	}
	_blackNblue(elem)
	{
		self endon( "disconnect" );
		self endon( "death" );

		for(;;)
		{
			elem fadeOverTime(0.2);
			elem.color = (0,0,0);
			wait .2;
			elem fadeOverTime(0.2);
			elem.color = (0.0, 0.5, 1.0 );
			wait .2;
		}
	}
	_motdScroll2(elem) // test
	{
	    self endon("death");
	    self endon("exit_menu");
	    self endon( "disconnect" );

	    // test 
	    for(;;)
	    {
	        elem setPoint("CENTER", "", 1000, 220);
	        elem setPoint("CENTER", "", -990, 220, 50); // aligm, rel, x, y, speed(z)
	        wait 43;
	    }
	    //screen xOffset scrolling function made by ダフティ
	        //x = -1000;
	        //self.motd_text setPoint ( "CENTER", "", x, 220 );
	        /*while ( true )
	        {
	          self endon ("death");
	          if ( x > 1000 ) x = -1000; self.motd_text setPoint( "CENTER", "", x, 220 );
	          x++;
	          //self.motd_text FadeOverTime( 0.2 );
	          wait 1/30; // fps - speed
	        }*/

	        // test
	            //x = -1000;
	            //elem setPoint ( "CENTER", "", x, 220 );
	            /*while ( true )
	            {
	              self endon ("death");
	              if ( x > 1000 ) x = -1000; elem setPoint( "CENTER", "", x, 220 );
	              x++;
	              //elem FadeOverTime( 0.2 );
	              wait 1/30; // fps - speed
	            }*/
	}

// Monitor functions
	monitorDeath()
	{
		self waittill("death");
		self.menuOpen = false;
		self.tText setText("");
		self.mText setText("");

		self.menuBG.x  = /*(0+0)+*/1000; // (0+0)+1000) //(-320+385)-385 // go here on death
		self.menuBG1.x = /*(0+0)+*/1000; //
		self.menuBG2.x = /*(0+0)+*/1000; //

		self.menuFG.alpha  = 0;
		self.menuFG1.alpha = 0;
		self.menuFG2.alpha = 0;

		self.menuBG3.alpha  = 0;
		self.menuBG4.alpha  = 0;

		self.menuBG_f1.alpha = 0;
		self.menuBG_f2.alpha = 0;
	}
	monitorButtons()
	{
		buttons = strTok( "Up|+forward,Down|+back,Left|+leanleft,Right|+leanright,S|+gostand,V|+melee,Att|+attack,F|+actionslot 2,K|+actionslot 3,D|+actionslot 1", ","	); //
		foreach(button in buttons)
		{
			btn = strTok(button, "|");
			self thread monitorActions(btn[0], btn[1]);
		}
	}
	monitorActions(button, action)
	{
		self endon("disconnect");
		self notifyOnPlayerCommand(button, action);
		for(;;)
		{
			self waittillmatch(button);
			self notify("buttonPress", button);
			wait .3;
		}
	}


//------------------------------------------------------------------------
// Hud functions
	motdText()
	{
		self endon ( "disconnect" );
		//self endon ( "death" );

		self thread KillText();
		level.Version = "^11.0^7";

		// Advertise Panels
						//                  align, relative, x, y,   shader, w,   h,  color,     sort,   alpha )
			self.motd  = createRectangle ( "CENTER", "",     0, 220, "black",    1000, 30, undefined, 99,    .6); // MOTD  background bar
			self.motd2 = createRectangle ( "CENTER", "",     0, 205, "minimap_light_on",    1000, 1,  undefined, 100,   1); // MOTD top Bar
			self.motd3 = createRectangle ( "CENTER", "",     0, 235, "minimap_light_on",    1000, 1,  undefined, 100,   1); // MOTD bottom Bar

		// test color function
			thread _motdFX(self.motd2); 
			thread _motdFX(self.motd3);

		// scrolling motd text 
			self.motd_text = self createFontString( "hudBig", .7 );
			self.motd_text setText ( "Mod name^3: ^:RG70hz^7       Mod Version^3: " + level.Version + "        ^7Thank you ^:"+self.name+"^7 for using my ^:Mod ^7(:       ^7Add me on Discord^3: ^:Random Guy 70hz^7#^:2299       ^7Made by ^:Random Guy 70hz^7");
			self.motd_text.sort = 2;
			self.motd_text.foreGround = true;

			thread doColorEffect(self.motd_text);

			// scroll function
				self thread _motdScroll(self.motd_text);

			/*for(;;)
			{
				self.motd_text setPoint("CENTER", "", 1350, 220);
				self.motd_text setPoint("CENTER", "", -1320, 220, 50);
				
				wait 47;
			}*/
			//screen xOffset scrolling function made by ダフティ
			//x = -1000;
			//self.motd_text setPoint ( "CENTER", "", x, 220 );
			/*while ( true )
			{
			self endon ("death");
			if ( x > 1000 ) x = -1000; self.motd_text setPoint( "CENTER", "", x, 220 );
			x++;
			//self.motd_text FadeOverTime( 0.2 );
			wait 1/30; // fps - speed
			}*/
	}
	_motdScroll(elem) // test
	{
		self endon( "disconnect" );
		self endon("death");

		/*for(;;)
		{
			self.motd_text setPoint("CENTER", "", 1350, 220);
			self.motd_text setPoint("CENTER", "", -1320, 220, 50);
			wait 47;
		}*/
		
		// test 
		for(;;)
		{
			elem setPoint("CENTER", "", 1350, 220);
			elem setPoint("CENTER", "", -1320, 220, 50);
			wait 47;
		}
		//screen xOffset scrolling function made by ダフティ
			//x = -1000;
			//self.motd_text setPoint ( "CENTER", "", x, 220 );
			/*while ( true )
			{
			self endon ("death");
			if ( x > 1000 ) x = -1000; self.motd_text setPoint( "CENTER", "", x, 220 );
			x++;
			//self.motd_text FadeOverTime( 0.2 );
			wait 1/30; // fps - speed
			}*/

			// test
				//x = -1000;
				//elem setPoint ( "CENTER", "", x, 220 );
				/*while ( true )
				{
				self endon ("death");
				if ( x > 1000 ) x = -1000; elem setPoint( "CENTER", "", x, 220 );
				x++;
				//elem FadeOverTime( 0.2 );
				wait 1/30; // fps - speed
				}*/
	}
	createShad(point, rPoint, x, y, width, height, elem, color, alpha, sort)
	{
		shader = newClientHudElem(self);
		shader.alignX = point;
		shader.alignY = rPoint;
		shader.x = x;
		shader.y = y;
		shader.sort = sort;
		shader.alpha = alpha;
		shader.color = color;
		//shader.glow = glowColor;
		shader setShader(elem, width, height);
		return shader;
	}
	createRectangle( align, relative, x, y, shader, width, height, color, sort, alpha )
	{
		// shader parameter values
			rg70hz = newClientHudElem( self );
			rg70hz.elemType = "bar";

			if ( !level.splitScreen ) // do function if match is not splitscreen
			{
				rg70hz.x = -2;
				rg70hz.y = -2;
			}
			rg70hz.width = width;
			rg70hz.height = height;
			rg70hz.align = align;
			rg70hz.relative = relative;
			rg70hz.xOffset = 0;
			rg70hz.yOffset = 0;
			rg70hz.children = [];
			rg70hz.sort = sort;
			rg70hz.color = color;
			//rg70hz.glow = glowColor;
			rg70hz.alpha = alpha;
			rg70hz setParent( level.uiParent );
			rg70hz setShader( shader, width, height );
			rg70hz.hidden = false;
			rg70hz setPoint ( align, relative, x, y );
			return rg70hz;
	}
	_motdFX(elem)
	{
		self endon("disconnect");
		self endon("death");

		// variable definitons
			r = randomInt(255);
			r_bigger = true;

			g = randomInt(255);
			g_bigger = false;

			b = randomInt(255);
			b_bigger = true;

		for(;;)
		{
			if(r_bigger == true) 
			{
				r += 10;
				if( r > 254 )
				{
					r_bigger = false;
				}
			}
			else
			{
				r -= 10;
				if( r < 2 )
				{
					r_bigger = true;
				}
			}
			if( g_bigger == true )
			{
				g += 10;
				if( g > 254 )
				{
					g_bigger = false;
				}
			}
			else
			{
				g -= 10;
				if( g < 2 )
				{
					g_bigger = true;
				}
			}
			if(b_bigger==true)
			{
				b += 10;
				if( b > 254 )
				{
					b_bigger = false;
				}
			}
			else
			{
				b -= 10;
				if( b < 2 )
				{
					b_bigger = true;
				}
			}
			elem.color = ((r/255),(g/255),(b/255));
			wait 0.01;
		}
	}
	_leftPanel()
	{
		self endon( "disconnect" );
		//thread KillText();
		
		thread keod(self.leftP0);
		thread keod(self.leftP0_top); 
		thread keod(self.leftP0_left); 
		thread keod(self.leftP0_bottom); 
		thread keod(self.leftP0_right);

		// left panel under minimap
										//    point,   rPoint,   x,   y,    w,   h,  elem,               color,   alpha,  sort
			self.leftP0        = createShad ("TOPLEFT", "LEFT", -60,  160,  225, 90, "cardtitle_248x48", (0,0,0),  .3, -1000 ); // main background
			self.leftP0_top    = createShad ("TOPLEFT", "LEFT", -60,  160,  225, 1,  "cardtitle_248x48", (0,0,0),  1, 1 ); // main background
			self.leftP0_bottom = createShad ("TOPLEFT", "LEFT", -60,  250,  225, 1,  "cardtitle_248x48", (0,0,0),  1, 1 ); // main background
			self.leftP0_left   = createShad ("TOPLEFT", "LEFT", -60,  160,  1,   90, "cardtitle_248x48", (0,0,0),  1, 1 ); // main background
			self.leftP0_right  = createShad ("TOPLEFT", "LEFT", 165,  160,  1,   90, "cardtitle_248x48", (0,0,0),  1, 1 ); // main background

		// fx
			// thread doGlowEffect(self.leftP0);
			thread _motdFX(self.leftP0_top   );
			thread _motdFX(self.leftP0_left  );
			thread _motdFX(self.leftP0_bottom);
			thread _motdFX(self.leftP0_right );
	}
	keod(elem) // kill elem on death
	{
		elem destroy();
		elem = undefined;
		elem.alpha = 0;
	}


// Hud util functions	
	easyColor( r, g, b )
	{
		// awesome function
			return (r/255, g/255, b/255);
	}
	KillText()
	{
		self endon ("disconnect");
		self waittill ( "death" );
		self.motd_text destroy();
		self.motd_text = undefined;
	}
	myMessage( hintText )
	{
		notifyData = spawnstruct();
		notifyData.notifyText = hintText;
		notifyData.glowColor = (0.5, 0.0, 0.8);//Change Color
		notifyData.duration = 7;
		notifyData.iconName = level.icontest;
		self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
		wait 1;
		self playLocalSound( "mp_level_up" );
	}
// Stop fx
	_stopFx()
	{
		self endon( "disconnect" );

		self waittill("stopFx"); 
		for(;;)
		{
			return;
		}
	}


// Test Function
	test()
	{
		self iPrintlnBold("Cursor Position: " + self.cursPos);
	}
