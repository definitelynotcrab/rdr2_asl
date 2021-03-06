state("RDR2")
{
	//?
}

state("RDR2", "Steam")
{
	byte mission_counter: 0x3EFECE0, 0x38;
	long loading: 0x5ACB70C;
	byte checkpoint: 0x59E1070, 0x50;
	string255 mission: 0x52D6930;
	byte in_cutscene: 0x4A43788, 0xB208;
}

state("RDR2", "RGL")
{
	byte mission_counter: 0x3EFECE0, 0x38;
	long loading: 0x5ACB70C;
	byte checkpoint: 0x59E1070, 0x50;
	string255 mission: 0x52D6930;
	byte in_cutscene: 0x4A43788, 0xB208;
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
		{"RDOWN2", "-Money Lending And Other Sins II"},
		{"RDST2", "-Paying A Social Call"},
		{"HNT1", "-Exit Pursued By A Bruised Ego"},
		{"SAL1", "-A Quiet Time"},
		{"REV1", "-Who Is Not Without Sin"},
		{"SEN1", "-The First Shall Be Last"},
		{"UTP1", "-Blessed Are The Meek"},
		{"RDOWN3", "-Money Lending And Other Sins III"},
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
		//{"", "American Fathers I (?)"},
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


	//Autostarting
	settings.Add("starters", true, "Auto Starters");

	settings.Add("starter_chapter1", true, "Start the timer after skipping \"Chapter 1\" cutscene", "starters");
	settings.Add("starter_loading", false, "Start the timer after loading save", "starters");


	//Autosplitting
	settings.Add("splitters", true, "Auto Splitters");
	settings.Add("splitter_missions", true, "Main Mission", "splitters");

	// Add missions to setting list
	foreach (var script in vars.missionScripts) {
		settings.Add(script.Key, true, script.Value, "splitter_missions");
	}	

	settings.Add("any_final_split", true, "Any% final split", "splitters");
}

init
{
	//print(modules.First().ModuleMemorySize.ToString());
	switch (modules.First().ModuleMemorySize)
	{
		case 1:
			version = "Not Steam";
			break;
		default:
			version = "Steam";
			break;
	}

	vars.doSplit = false;
	vars.shouldStart = false;
}

update
{
	if (version == "") return false;
}

start
{
	bool flag_ch1 = (settings["starter_chapter1"] && current.mission_counter == 0 && current.checkpoint == 2 && old.checkpoint == 1);

	bool flag_load = (settings["starter_loading"] && current.loading != old.loading && old.loading > 0 && old.loading < 32768 && current.mission_counter > 0);

	vars.shouldStart = flag_ch1 || flag_load;

	return vars.shouldStart;
}

split
{
	bool flag_missions = (old.mission_counter == current.mission_counter - 1 && settings[old.mission]);

	bool flag_anyfinalsplit = (current.mission == "FIN2" && current.checkpoint == 13 && current.in_cutscene != 0 && old.in_cutscene == 0 && settings["any_final_split"]);

	vars.doSplit = flag_missions || flag_anyfinalsplit;

	return vars.doSplit;
}

isLoading
{
	return current.loading != 0;
}
