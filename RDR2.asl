state("RDR2")
{
	byte mission_counter: 0x3EB2F00, 0x38;
	long loading: 0x3ED181E;
	byte checkpoint: 0x59B2FE0, 0x50;
	string255 mission: 0x3EA0EC0;
	byte in_cutscene: 0x49F8648, 0xB208;
	string255 cutscene: 0x49F8648, 0xB210;
}


startup
{
	vars.missionScripts = new Dictionary<string,string> {

		//Chapter 1
		{"WNT1", "-Outlaws From The West"},
		{"WNT2", "-Enter, Pursued by a Memory"},
		{"DST1", "-Old Friends"},
		{"RPRSN", "-The Aftermath of Genesis"},
		{"WNT4", "-Who the Hell is Leviticus Cornwall?"},
		{"MUD1", "-Eastward Bound"},

		//Chapter 2
		{"MUD3", "-Polite Society, Valentine Style"},
		{"MUD2", "-Americans At Rest"},
		{"RDOWN1", "-Money Lending And Other Sins I"},
		{"RDOWN2", "-Money Lending And Other Sins II"},
		{"RDST2", "-Paying A Social Call"},
		{"HNT1", "-Exit Pursued By A Bruised Ego"},
		{"SAL1", "-A Quiet Time"},
		{"REV1", "-Who Is Not Without Sin"},
		{"SEN1", "-The First Shall Be Last"},
		{"UTP1", "-Blessed Are The Meek"},
		{"RDOWN3", "-Money Lending And Other Sins III"},
		{"RMARY1", "-We Loved Once and True I (Letter)"},
		{"RMARY2", "-We Loved Once and True II"},	
		//{"RMUD33", "-Pouring Fourth Oil III"},
		{"RABI1", "-A Fisher of Men"},
		{"UTP2", "-An American Pastoral Scene"},
		{"RHMR0", "-The Spines of America"},
		{"MUD6", "-Pouring Fourth Oil IV"},
		{"MUD4", "-The Sheep and The Goats"},
		{"RDTC1", "-A Strange Kindness"},

		//Chapter 3
		{"FUD1", "-The New South"},
		{"RBNP11", "-The Course of True Love"},
		{"RSAD1", "-Further Questions of Female Suffrage"},
		{"CRN1", "-An Honest Mistake"},
		{"RBNP12", "-The Course of True Love III"},
		{"GRY1", "-American Distillation"},
		{"BRT1", "-Advertising, The New American Art"},
		{"RXCF1", "-Preaching Forgiveness as he Went"},
		{"TRE1", "-Magicians for Sport"},
		{"GRY2", "-Horse Flesh for Dinner"},
		{"MUD5", "-Sodom? Back to Gomorrah"},
		{"RCHRB", "-Friends in Very Low Places"},
		{"BRT2", "-The Fine Joys of Tobacco"},
		{"DST3", "-Blessed Are The Peacemakers"},
		{"GRY3", "-A Short Walk In A Pretty Town"},
		{"BRT3", "-Blood Feuds, Ancient and Modern"},
		{"RDTC2", "-The Battle of Shady Belle"},

		//Chapter 4
		{"MOB1", "-The Joys of Civilisation"},
		{"MOB2", "-Angelo Bronte, A Man of Honor"},
		{"IND1", "-The Gilded Cage"},
		{"SUS1", "-No, No, And Thrice, No"},
		{"RNATV1", "American Fathers I (?)"},
		{"IND3", "-A Fine Night for Debauchery"},
		{"RNATV2", "-American Fathers II"},
		{"ODR4", "-Horsemen, Apocalypses"},
		{"MOB3", "-Urban Pleasures"},
		{"MOB4", "-Country Pursuits"},
		{"MOB5", "-Revenge is a Dish Best Eaten"},
		{"NBD1", "-Banking, The Old American Art"},

		//Chapter 5
		{"GUA2", "-Welcome To The New World"},
		{"FUS2", "-Savagery Unleashed"},
		{"FUS1", "-A Kind And Benevolent Despot"},
		{"SMG2", "-Hell Hath No Fury"},
		{"GUA3", "-Paradise Mercifully Departed"},
		{"RGNG02", "-Dear Uncle Tacitus"},
		{"GNG1", "-Fleeting Joy"},
		{"RDCH3", "-That's Murfree Country"},
		{"RDOPN", "-A Fork In The Road"},

		//Chapter 6
		{"GNG2", "-Icarus And Friends"},
		{"GNG3", "-Visiting Hours"},
		{"TRN1", "-Just A Social Call"},
		{"NTS1", "-A Rage Unleashed"},
		{"TRN2", "-The Delights of Van Horn"},
		{"NTV2", "-The Fine Art of Conversation"},
		{"DST5", "-Goodbye Dear Friend"},
		{"NTS2", "-Favored Sons"},
		{"TRN3", "-The Bridge to Nowhere"},
		{"NTS3", "-The King's Son"},
		{"RDST61", "-Sadie Adler, Widow I"},
		{"NTV3", "-My Last Boy"},
		{"TRN4", "-Out Best Selves"},
		{"FIN1", "-Red Dead Redemption"},

		//Epilogue 1
		{"MAR1", "-The Wheel"},
		{"MAR5", "-Simple Pleasures"},
		{"MR53", "-Fatherhood, For Beginners"},
		{"MR52", "-Farming, For Beginners"},
		{"LAR1", "-Old Habits"},
		{"MAR4", "-Jim Milton Rides, Again?"},
		{"MAR2", "-Fatherhood, For Idiots"},
		{"AB21", "-Motherhood"},
		{"SAD2", "-Gainful Employment"},
		{"RBCH12", "-Home of the Gentry?"},

		//Epilogue 2
		{"MAR6", "-Bare Knuckle Friendship"},
		{"RBCH21", "-Home Improvement For Beginners"},
		{"SAD5", "-An Honest Day's Labors"},
		{"MAR7", "-The Tool Box"},
		{"BE22", "-A New Jerusalem"},
		{"SAD3", "-A Quick Favor for an Old Friend"},
		{"MAR8", "-Uncle's Bad Day"},
		{"SAD4", "-A Really Big Bastard"},
		{"RJCK2", "-Trying Again"},
		{"RABI3", "-A New Future Imagined"},
		{"FIN2", "-American Venom"},
		
	};

	vars.strangerScripts = new Dictionary<string,string> {

		// Side missions
		{"RCRLE", "No Good Deed"},
		{"RCTAX1", "A Better World, A New Friend - I"},
		{"RCTAX2", "A Better World, A New Friend - II"},
		{"RSKLR", "American Dreams"},
		{"RSLVC1", "The Iniquities Of History I"},
		{"RSLVC2", "The Iniquities Of History II"},
		{"RKTTY1", "He's British Of Course I"},
		{"RKTTY2", "He's British Of Course II"},
		{"RKTTY3", "He's British Of Course III"},
		{"RKTTY4", "He's British Of Course IV"},
		{"RKTTY5", "He's British Of Course V"},
		{"RWARV1", "The Veteran I"},
		{"RWARV2", "The Veteran II"},
		{"RWARV3", "The Veteran III"},
		{"RWARV4", "The Veteran IV"},
		{"RHNTN1", "The Wisdom Of the Elders I"},
		{"RHNTN2", "The Wisdom Of the Elders II"},
		{"RHNTN3", "The Wisdom Of the Elders III"},
		{"RHNTN4", "The Wisdom Of the Elders IV"},
		{"RHNTN5", "The Wisdom Of the Elders V"},
		{"RBWCG1", "The Ties That Bind Us I"},
		{"RBWCG3", "The Ties That Bind Us II"},
		{"RBWCG4", "The Ties That Bind Us III"},
		{"RBWCG6", "The Ties That Bind Us IV"},
		{"RBWCG7", "The Ties That Bind Us V"},
		{"RCKPT1", "A Bright Bouncing Boy I"},
		{"RCKPT2", "A Bright Bouncing Boy II"},
		{"RCKPT3", "A Bright Bouncing Boy III"},
		{"RFMA1", "The Artist's Way I"},
		{"RFMA2", "The Artist's Way II"},
		{"RFMA3", "The Artist's Way III"},
		{"RFMA4", "The Artist's Way IV"},
		{"ROBT1", "Oh Brother I"},
		{"ROBT2", "Oh Brother II"},
		{"ROBT3", "Oh Brother III"},
		{"RMAYR1", "Idealism And Pragmatism For Beginners I"},
		{"RMAYR2", "Idealism And Pragmatism For Beginners II"},
		{"RMAYR3", "Idealism And Pragmatism For Beginners III"},
		{"RMASN1", "Arcadia For Amateurs I"},
		{"RMASN2", "Arcadia For Amateurs II"},
		{"RMASN3", "Arcadia for Amateurs III"},
		{"RMASN4", "Arcadia for Amateurs IV"},
		{"RMASN5", "Arcadia for Amateurs V"},
		{"RODDF1", "The Smell Of Grease Paint I"},
		{"RODDF2", "The Smell Of Grease Paint II"},
		{"RCCIG", "Smoking And Other Hobbies"},
		{"RETH", "All That Glitters"},
		{"REFND", "Fundraiser"},
		{"RCDIN1", "A Test Of Faith I"},
		{"RCDIN2", "A Test Of Faith II"},
		{"RCRKF1", "Geology For Beginners I"},
		{"RCRKF2", "Geology For Beginners II"},
		{"RCEXO1", "Duchesses And Other Animals I"},
		{"RCEXO2", "Duchesses And Other Animals II"},
		{"RCEXO3", "Duchesses And Other Animals III"},
		{"RCEXO4", "Duchesses And Other Animals IV"},
		{"RCEXO5", "Duchesses And Other Animals V"},
		{"RCEXO6", "Duchesses And Other Animals VI"},
		{"REDW21", "Do Not Seek Absolution I"},
		{"REDW22", "Do Not Seek Absolution II"},
		{"RBNP20", "The Course of True Love IV"},
		{"RBNP21", "The Course of True Love V"},
		{"RSTR1", "Money Lending And Other Sins IV"},
		{"RSTR2", "Money Lending And Other Sins V"},
		{"RSTR31", "Money Lending And Other Sins VI"},
		{"RSTR32", "Money Lending And Other Sins VII"},
		{"RSTR33", "Money Lending And Other Sins VIII"},
		{"RCFSH1", "A Fisher of Fish I"},
		{"RCFSH2", "A Fisher of Fish II"},
		{"RCRAW", "A Fine Night For It"},
		{"RMRYB", "Mary-Beth"},
		{"RTLLY", "Tilly"},
		{"RRFA1", "Rains Fall"},
		{"RRTL1", "The Mercies of Knowledge I"},
		{"RRTL2", "The Mercies of Knowledge II"},		
		{"RRTL3", "The Mercies of Knowledge III"},		
		{"RRTL4", "The Mercies of Knowledge IV"},		
		{"RRTL5", "The Mercies of Knowledge V"},		
		{"RRTL6", "The Mercies of Knowledge VI"},		
		{"RRTL7", "The Mercies of Knowledge VII"},
		{"RCLD21", "Of Men and Angels I"},		
		{"RCLD22", "Of Men and Angels II"},
		{"RCLDN1", "Help a Brother Out"},						
		{"RCLDN2", "Brothers and Sisters, One and All"},												
		{"RMLLR1", "The American Inferno, Burnt Out I"},
		{"RMLLR2", "The American Inferno, Burnt Out II"},
		{"RMLLR3", "The American Inferno, Burnt Out III"},
		{"RMLLR4", "The American Inferno, Burnt Out IV"},
		{"RMLLR5", "The American Inferno, Burnt Out V"},

		// Gunslingers
		{"RCAL11", "The Noblest of Man And a Woman I"},
		{"RGUN12", "Emmett Granger"},
		{"RGUN2", "Flaco Hernandez"},
		{"RGUN3", "Billy Midnight"},
		{"RGUN5", "Black Belle"},
		{"RCAL12", "The Noblest of Man And a Woman III"},
		{"RCAL13", "The Noblest of Man And a Woman IV"},

		// Bounties
		{"BOU1", "Benedict Allbright"},
		{"RBT05", "Ellie Anne Swan"},
		{"RBRAN", "Mark Johnson"},
		{"RBCON", "Lindsey Wofford"},
		{"RBT20", "Elias Green"},
		{"RBT22", "Joaquin Arroyo"},
		{"RBDUL", "Joshua Brown"},
		{"RBT15", "Anthony Foreman"},
		{"RBT14", "Robbie Laidlaw"},
		{"RBT18", "Otis Skinner"},
		{"RBT12", "Camille de Millemont"},
		{"RBT21", "Herman Zizendorf"},
		{"RBT03", "Bart Cavanaugh"},
		{"RBT23", "Esteban Cortez"},
	};


    vars.starterCutscenes = new Dictionary<string,string>{
        {"RRVRD_", "-Chapter 2 (Horseshoe Overlook), Swanson mission"}, //not full cutscene name to avoid double split
        {"MUD3_INT", "-Chapter 2 (Horseshoe Overlook), Uncle mission"},
	{"FUD1_", "-Chapter 3 (Clemens Point)"}, //mission name, doesn't have starter cutscene
	{"MOB1_INT", "-Chapter 4 (Saint Denis)"},
	{"GUA1_EXT", "-Chapter 5 (Guarma)"},
	{"GNG3_INT", "-Chapter 6 (Beaver Hollow)"},
	{"MAR5_INT", "-Epilogue 1 (Pronghorn Ranch)"},
	{"RHLP2_RSC1", "-Epilogue 2 (Beechers Hope)"},
    };


    vars.finalCutscenes = new Dictionary<string,string>{
        {"MUD1_MCS5", "-Chapter 1"},
        {"RDTC1_RSC6", "-Chapter 2"},
	{"RDTC2_RSC4", "-Chapter 3"},
	{"NBD1_", "-Chapter 4"},
	{"RDTC3_RSC5", "-Chapter 5"},
	{"FIN1_", "-Chapter 6"}, //changed
	{"RBCH1_", "-Epilogue 1"},
    };


	//Autostarting
	settings.Add("starters", true, "Auto Starters");

	settings.Add("starter_chapter1", true, "Start the timer after skipping \"Chapter 1\" cutscene", "starters");
    	settings.Add("starter_chapters",false, "Chapters", "starters");
    	settings.Add("starter_loading", false, "Start the timer after loading save", "starters");

   	// Add starter cutscenes for every chapter
	foreach (var cs in vars.starterCutscenes) {
		settings.Add(cs.Key, false, cs.Value, "starter_chapters");
    }	


	//Autosplitting
	settings.Add("splitters", true, "Auto Splitters");
	settings.Add("splitter_missions", true, "Main Missions", "splitters");
	settings.Add("splitter_strangers", false, "Side Missions", "splitters");

	// Add main missions to setting list
	foreach (var script in vars.missionScripts) {
		settings.Add(script.Key, true, script.Value, "splitter_missions");
	}

	// Add side missions to setting list
	foreach (var script in vars.strangerScripts) {
		settings.Add(script.Key, true, script.Value, "splitter_strangers");
	}

	settings.Add("any_final_split", true, "Any% final split", "splitters");
	
	settings.Add("splitter_chapters_start", false, "Split at the start of each chapter", "splitters");
	settings.Add("splitter_chapters_end", false, "Split at the end of each chapter", "splitters");	

	// Add starter cutscenes for every chapter
	foreach (var cs in vars.starterCutscenes) {
		settings.Add("SPLIT_" + cs.Key, true, cs.Value, "splitter_chapters_start");
    }	

	// Add ending cutscenes for every chapter
	foreach (var cs in vars.finalCutscenes) {
		settings.Add(cs.Key, true, cs.Value, "splitter_chapters_end");
    }	
}	

init
{
	//print(modules.First().ModuleMemorySize.ToString());

	vars.doSplit = false;
	vars.shouldStart = false;

	vars.timeSpanSplit = new TimeSpan(); // for delayed split
	vars.cutsceneSkipCounter = 0; // to prevent double split at the start/end of each chapter
}

start
{
	bool flag_ch1 = (settings["starter_chapter1"] && current.mission_counter == 0 && current.cutscene != old.cutscene && old.cutscene == "WNT1_INT_CABIN");

	bool flag_load = (settings["starter_loading"] && current.loading != old.loading && old.loading > 0 && old.loading < 32768 && current.mission_counter > 0);

    	bool flag_chapters = false;

    	//print("T" + timer.CurrentTime.RealTime.ToString() + "------------------" + vars.timeSpanSplit.Ticks.ToString());

	if (settings[old.cutscene] && vars.starterCutscenes.ContainsKey(old.cutscene)) // Generic starter
		if (current.cutscene != old.cutscene)
			flag_chapters = true;

	if (settings["RRVRD_"]) // Chapter 2 exception
		if (current.cutscene == "RRVRD_RSC_1" && old.in_cutscene != 0 && current.in_cutscene == 0){
			System.Threading.Tasks.Task.Delay(1250).Wait(); //retarded
    		flag_chapters = true;
		}

	if (settings["FUD1_"]) // Chapter 3 exception
		if (current.mission != old.mission && current.mission == "FUD1")
			flag_chapters = true;


	vars.shouldStart = flag_ch1 || flag_chapters || flag_load;

	return vars.shouldStart;
}

split
{
	bool flag_missions = ((old.mission_counter == current.mission_counter - 1 || (old.mission_counter == current.mission_counter - 2 && old.mission == "BRT1")) && settings[old.mission]); // mission split, advertising exception

	bool flag_anyfinalsplit = (current.mission == "FIN2" && current.checkpoint == 13 && current.in_cutscene != 0 && old.in_cutscene == 0 && settings["any_final_split"]);
	
	bool flag_chapters = false;
	
	//print("T" + timer.CurrentTime.RealTime.ToString() + "------------------" + vars.timeSpanSplit.ToString());

	// Chapter start
	if (settings["splitter_chapters_start"]){
		if (settings["SPLIT_" + old.cutscene] && vars.starterCutscenes.ContainsKey(old.cutscene)) // Generic starter
			if (current.cutscene != old.cutscene)
				flag_chapters = true;

		if (settings["SPLIT_RRVRD_"]){ // Chapter 2 Swanson exception
			if (current.cutscene == "RRVRD_RSC_1" && old.in_cutscene != 0 && current.in_cutscene == 0 && vars.timeSpanSplit.Ticks == 0){
				if (++(vars.cutsceneSkipCounter) == 1)
					vars.timeSpanSplit = timer.CurrentTime.RealTime + new TimeSpan(0, 0, 0, 0, 1250);
			}
			else if	(vars.timeSpanSplit.Ticks != 0 && timer.CurrentTime.RealTime >= vars.timeSpanSplit){ // Delayed split
				vars.timeSpanSplit = new TimeSpan();
				flag_chapters = true;
			}
			else if (old.cutscene == "RRVRD_RSC_1" && current.cutscene == "") // Reset cutsceneSkipCounter when the cutscene ends
				vars.cutsceneSkipCounter = 0;
		}

		if (settings["SPLIT_FUD1_"]) // Chapter 3 exception
			if (current.mission != old.mission && current.mission == "FUD1")
				flag_chapters = true;
	}
	
	// Chapter end
	if (settings["splitter_chapters_end"]){
		//if (current.cutscene != old.cutscene && (vars.finalCutscenes.ContainsKey(old.cutscene) ^ current.cutscene == "FIN1_EXT")) // Generic split with ch6 exception
		//	flag_chapters = true;

		if (current.in_cutscene + old.in_cutscene == old.in_cutscene) {
			if (settings[current.cutscene] && vars.finalCutscenes.ContainsKey(current.cutscene) && current.cutscene == old.cutscene && vars.timeSpanSplit.Ticks == 0) { // Generic split
				int sleep_delay = 0;

				if (current.cutscene == "MUD1_MCS5"){
					sleep_delay = 4417;
				}
				else if (current.cutscene == "RDTC1_RSC6"){
					sleep_delay = 8100;
				}
				else if (current.cutscene == "RDTC2_RSC4"){
					sleep_delay = 17733;
				}
				else if (current.cutscene == "RDTC3_RSC5"){
					sleep_delay = 9133;
				}

				if (++(vars.cutsceneSkipCounter) == 1) //set the delay only if the cutscene was skipped certain amount of times, used to prevent double split
					vars.timeSpanSplit = timer.CurrentTime.RealTime + new TimeSpan(0, 0, 0, 0, sleep_delay);
			}
		}
		
		if ((settings["NBD1_"] && current.cutscene != old.cutscene && old.cutscene == "NBD1_EXT") || // Chapter 4 exception
		    (settings["FIN1_"] && current.cutscene == "FIN1_EXT" && old.cutscene == "") || // Chapter 6 exception
		    (settings["RBCH1_"] && current.cutscene == "RBCH1_RSC6_PTL" && current.cutscene != old.cutscene)) // Epilogue 1 exception
				flag_chapters = true;

		if (vars.timeSpanSplit.Ticks != 0 && timer.CurrentTime.RealTime >= vars.timeSpanSplit) { // Delayed split for chapter finish
			vars.timeSpanSplit = new TimeSpan();
			flag_chapters = true;
		}

		if (current.cutscene != old.cutscene && vars.finalCutscenes.ContainsKey(old.cutscene)) // Reset cutsceneSkipCounter when the cutscene ends
			vars.cutsceneSkipCounter = 0;
	}


	vars.doSplit = flag_missions || flag_anyfinalsplit || flag_chapters;

	return vars.doSplit;
}

isLoading
{
	return current.loading != 0;
}
