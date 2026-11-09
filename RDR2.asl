// When variables change for game patches, the offsets will generally stay the same.
// This means the only change should be in the base address.
//
// Mission counter: Passed missions count in the progress statistics screen. Variable counts all missions including strangers.
// Loading: 0 during gameplay, 1-32767 when loading a save file, >32768 during black screen. Restart game once or twice to
//     help with scanning (as the address is static). The correct value remains unchanged during loading.
// Checkpoint: Address always ends with 0050.
// Example values for testing during Who Is Not Without Sin:
//     3: Standing outside after intro
//     4: Fighting the first NPC
//     5: Chasing the witness
//     6: After shooting witness, before approaching bridge
//     7: Unstucking Swansons' foot
//     25: Taking Swanson back to camp
// Mission: Should be "none" when not on mission.
// In cutscene: 0 if not, any other value if so. Same base address as for variable below.
// Cutscene: Who Is Not Without Sin intro "RRVRD_RSC_1", cutscene after railroad bridge "REV1_MSC3"
//
// Challenge / collectible splits (only enabled on RDR2.exe 1.0.1491.50, ModuleMemorySize 0x7397600):
// Challenges: challenge manager [RDR2.exe+0x3EB8178]; +0x08 = array of challenge records, +0x10 = u16 count.
//     The 9 story categories are found by hash (SP_CHAL_<CAT>_ROOT at record +0x10).
//     Record +0x08 = ranks completed (0-10), +0x0C = 1 while a finished rank is waiting to be credited (~7 s).
//     Signature for the manager (disp32 at +3): 48 8B 15 ?? ?? ?? ?? 33 FF 0F B7 6A 10
// Script globals block 0 = [RDR2.exe+0x59B2FB0] (signature: 48 8D 15 ?? ?? ?? ?? 48 8B 1D ?? ?? ?? ?? 8B 3D, disp at +3).
//     Dreamcatchers Global_9051 (+0x11AD8) bits 1-20, graves Global_9057 (+0x11B08) bits 0-8,
//     legendary animal i killed Global_(9361+4i) (+0x12488 + 0x20*i), array length Global_9359 (+0x12478) = 16.
// Cigarette cards, dinosaur bones, rock carvings, legendary fish: engine collectable category objects (type pointer
//     RDR2.exe+0x33EF348, 0x30 bytes) live on the heap and are found by a one-time background scan (rebuilt on every
//     save load). Category +0x18 = item pointer array, +0x20 = u16 count, +0x28 = category hash: CIGARETTE_CARDS
//     0x84388B75 (144), DINO_BONES 0xE5C3465F (30, BONE_00-29), ROCK_CARVINGS 0x7D613448 (10, ROCK_00_GRZ-09_ROA),
//     LEGENDARY_FISH 0x76EED176 (14, LEGENDARY_FISH_01-14). Item record +0x54 = counter: card = number owned;
//     bone/carving/fish: 0 = not found, +1 when found (inspected / fish kept or stowed on the horse), +1 when mailed.
//     Card records (type RDR2.exe+0x33F0278): item hash +0x10, set hash +0x24. Others (RDR2.exe+0x33F01E0): hash +0x08.

state("RDR2")
{
	byte mission_counter: 0x3EB2F00, 0x38;
	long loading: 0x3ED181E;
	byte checkpoint: 0x59B2FE0, 0x50;
	string255 mission: 0x528DDC0;
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

	// Challenges & collectibles (game version 1.0.1491.50 only)
	var chalCats = new string[] { "BAND", "EXPL", "GAMB", "HERB", "HORSE", "HUNT", "SHOT", "SURV", "WEAP" };
	var chalNames = new string[] { "Bandit", "Explorer", "Gambler", "Herbalist", "Horseman", "Master Hunter", "Sharpshooter", "Survivalist", "Weapons Expert" };
	var legendNames = new string[] { "Bharati Grizzly Bear", "Beaver", "Big Horn Ram", "White Bison", "Boar", "Buck", "Tatanka Bison", "Bull Gator",
		"Cougar", "Coyote", "Elk", "Fox", "Moose", "Giaguaro Panther", "Pronghorn", "Wolf" };
	// Legendary fish: collectable item hash (joaat "LEGENDARY_FISH_NN", listed by name) and name
	var fishHashes = new uint[] { 0x225E4F40, 0x90D2ADDF, 0x7E31089C, 0xABFF6438, 0xD9BFBFB8, 0xC78E1B55, 0xD97CBF2E,
		0x3092EBAD, 0xC7071A43, 0xF55076D5, 0xE2A1D178, 0x692A5CD7, 0x12ECB05D, 0x30BDEBFF };
	var fishNames = new string[] { "Bluegill", "Bullhead Catfish", "Chain Pickerel", "Lake Sturgeon", "Largemouth Bass", "Longnose Gar", "Muskie",
		"Northern Pike (The Veteran)", "Perch", "Redfin Pickerel", "Rock Bass", "Smallmouth Bass", "Sockeye Salmon", "Steelhead Trout" };
	vars.chalCats = chalCats;
	vars.chalHashes = new uint[] { 0xD5D688C1, 0xB3CE15D7, 0x7011A716, 0xB8678749, 0x0908F687, 0x4960B55E, 0xD9B45839, 0x63C5A991, 0x004EE82F };
	// Engine collectable categories: 0 cigarette cards, 1 dinosaur bones, 2 rock carvings, 3 legendary fish
	vars.ecCatHash = new uint[] { 0x84388B75, 0xE5C3465F, 0x7D613448, 0x76EED176 }; // category hash at +0x28
	vars.ecCount = new int[] { 144, 30, 10, 14 }; // number of items
	vars.ecItemType = new int[] { 0x33F0278, 0x33F01E0, 0x33F01E0, 0x33F01E0 }; // item record type pointer (RVA)
	vars.ecHashOff = new int[] { 0x10, 0x08, 0x08, 0x08 }; // offset of the item hash in its record
	vars.ecFields = new int[] { 1, 1, 1, 3 }; // dwords from +0x54 that count as "found" (fish: caught, stowed or mailed)

	settings.Add("splitter_challenges", false, "Challenges", "splitters");
	settings.SetToolTip("splitter_challenges", "Split when a challenge rank is completed. Game version 1.0.1491.50 only.");
	settings.Add("chal_early", false, "Split when the rank's last goal is done (experimental)", "splitter_challenges");
	settings.SetToolTip("chal_early", "By default the split happens when the game credits the rank, about 7 seconds after the last goal is done. This splits at the moment the goal is done instead.");
	for (int c = 0; c < 9; c++) {
		settings.Add("chal_" + chalCats[c], true, chalNames[c], "splitter_challenges");
		for (int r = 1; r <= 10; r++)
			settings.Add("chal_" + chalCats[c] + "_" + r, true, chalNames[c] + " " + r, "chal_" + chalCats[c]);
	}

	settings.Add("splitter_collectibles", false, "Collectibles", "splitters");
	settings.SetToolTip("splitter_collectibles", "Game version 1.0.1491.50 only. One pickup never causes more than one split. " +
		"Cards, bones, carvings and legendary fish are found with a one-time memory scan after a save has loaded (a few seconds, in the background).");
	settings.Add("cards", true, "Cigarette cards", "splitter_collectibles");
	settings.Add("cards_each", true, "Every new card", "cards");
	settings.Add("cards_set", false, "Each completed set (12/12)", "cards");
	settings.SetToolTip("cards_set", "Only used when 'Every new card' is off.");
	settings.Add("cards_all", false, "All 144 cards", "cards");
	settings.SetToolTip("cards_all", "Only used when 'Every new card' and 'Each completed set' are off.");
	settings.Add("bones", true, "Dinosaur bones (every bone found)", "splitter_collectibles");
	settings.SetToolTip("bones", "Splits when you inspect a bone. Mailing it later does not split.");
	settings.Add("carvings", true, "Rock carvings (every carving found)", "splitter_collectibles");
	settings.SetToolTip("carvings", "Splits when you inspect a carving. Mailing it later does not split.");
	settings.Add("dc", true, "Dreamcatchers (every dreamcatcher found)", "splitter_collectibles");
	settings.Add("graves", true, "Graves (every grave visited, Epilogue)", "splitter_collectibles");
	settings.Add("legend", true, "Legendary animals (on kill)", "splitter_collectibles");
	for (int l = 0; l < 16; l++)
		settings.Add("legend_" + l, true, legendNames[l], "legend");
	settings.Add("fish", true, "Legendary fish (on catch)", "splitter_collectibles");
	settings.SetToolTip("fish", "Small legendary fish count when you keep them, big ones when you stow them on your horse. " +
		"A fish that is only carried to the post office counts when it is mailed.");
	for (int f = 0; f < 14; f++)
		settings.Add("fish_" + fishHashes[f].ToString("X8"), true, fishNames[f], "fish");

	// Per-run state lives here, not in init, so it survives the game being restarted mid-run.
	// update clears it while the timer is not running.
	vars.clock = Stopwatch.StartNew(); // monotonic time for the guards (not affected by clock changes)
	vars.splitQueue = new Queue<string>();
	vars.done = new HashSet<string>(); // events already split on in this run
	vars.cardGot = new HashSet<uint>(); // cards (by hash) owned at any point in this run
	vars.attempt = DateTime.MinValue; // start time of the attempt the state above belongs to
}

init
{
	//print(modules.First().ModuleMemorySize.ToString());

	vars.doSplit = false;
	vars.shouldStart = false;

	vars.timeSpanSplit = new TimeSpan(); // for delayed split
	vars.cutsceneSkipCounter = 0; // to prevent double split at the start/end of each chapter

	// Challenges & collectibles
	vars.newOk = modules.First().ModuleMemorySize == 0x7397600;
	print("[RDR2] ModuleMemorySize = 0x" + modules.First().ModuleMemorySize.ToString("X") +
		(vars.newOk ? "" : " (unknown game version: challenge/collectible splits disabled)"));
	vars.baseAddr = modules.First().BaseAddress;
	vars.guardUntil = -1.0; // no new splits until a few seconds after a load or black screen
	vars.rebase = false; // a save load was seen: take new baselines instead of comparing
	vars.chalSettle = 0.0; // no splits from data that was just (re)found until this time
	vars.globSettle = 0.0;
	vars.globWasOk = false;
	vars.chalRoots = new IntPtr[9];
	vars.chalReady = false;
	vars.chalNextTry = 0.0;
	vars.chalPrevRanks = new int[9];
	vars.chalPrevPend = new int[9];
	vars.chalPrevOk = false;
	vars.dcPrev = 0;
	vars.gravesPrev = 0;
	vars.legPrev = new int[16];
	vars.globPrevOk = false;
	// Engine collectables (per category, see ecCatHash in startup)
	vars.ecCat = new IntPtr[4]; // category object (0 = not found yet)
	vars.ecArr = new IntPtr[4]; // its item pointer array (changes when the data is rebuilt)
	vars.ecItems = new IntPtr[4][]; // item records
	vars.ecHashes = new uint[4][]; // item hashes
	vars.ecPrev = new int[4][]; // previous "found" state per item
	vars.ecPrevOk = new bool[4];
	vars.ecSettle = new double[4];
	vars.ecProbe = new int[4];
	vars.cardSets = new uint[144]; // set hash per card
	vars.ecScanDone = null;
	vars.ecScanResult = null;
	vars.ecScanNext = 0.0;
	vars.ecScanStart = 0.0;
	vars.ecScanFails = 0; // scans in a row that did not find everything (for the retry backoff)
}

update
{
	var queue = (Queue<string>)vars.splitQueue;
	var done = (HashSet<string>)vars.done;
	// No run, or a different attempt than last time (also catches a reset + new start made while the game was
	// closed): forget the previous run.
	DateTime attempt = timer.AttemptStarted.Time;
	if (timer.CurrentPhase == TimerPhase.NotRunning || attempt != (DateTime)vars.attempt) {
		queue.Clear();
		done.Clear();
		((HashSet<uint>)vars.cardGot).Clear();
		// A delayed chapter split that was still pending must not fire in the next run
		vars.timeSpanSplit = new TimeSpan();
		vars.cutsceneSkipCounter = 0;
		vars.attempt = attempt;
	}

	if (!vars.newOk)
		return true;

	double now = ((Stopwatch)vars.clock).Elapsed.TotalSeconds;
	Process proc = game;
	IntPtr baseAddr = vars.baseAddr;
	IntPtr rootType = baseAddr + 0x3415F48;
	IntPtr catType = baseAddr + 0x33EF348;
	// Any load or black screen: no new splits until 5 s after it ends.
	if (current.loading != 0 && (double)vars.guardUntil < now + 5)
		vars.guardUntil = now + 5;
	// Save load (1-32767): all values change, so take new baselines. During other black screens (fast travel,
	// sleeping, fades) the baselines are kept, so an event that happens then still splits once the guard ends.
	if (current.loading > 0 && current.loading < 32768)
		vars.rebase = true;
	bool teardown = false;

	// ---- Challenges: find and validate the records ----
	var roots = (IntPtr[])vars.chalRoots;
	uint[] chalHashes = vars.chalHashes;
	string[] chalCats = vars.chalCats;
	if (!vars.chalReady && now >= vars.chalNextTry) {
		vars.chalNextTry = now + 2;
		IntPtr mgr = proc.ReadPointer(baseAddr + 0x3EB8178);
		IntPtr list = mgr == IntPtr.Zero ? IntPtr.Zero : proc.ReadPointer(mgr + 0x8);
		int count = mgr == IntPtr.Zero ? 0 : proc.ReadValue<ushort>(mgr + 0x10);
		int found = 0;
		if (list != IntPtr.Zero && count > 0 && count <= 1024) {
			for (int i = 0; i < count; i++) {
				IntPtr rec = proc.ReadPointer(list + 8 * i);
				if (rec == IntPtr.Zero)
					continue;
				int idx = Array.IndexOf(chalHashes, proc.ReadValue<uint>(rec + 0x10));
				if (idx >= 0) {
					roots[idx] = rec;
					found++;
				}
			}
		}
		if (found == 9) {
			vars.chalReady = true;
			vars.chalPrevOk = false;
			vars.chalSettle = now + 10; // freshly built data may still read 0 before the save's values arrive
			print("[RDR2] challenge data found");
		}
	}
	bool chalOk = vars.chalReady;
	var ranks = new int[9];
	var pend = new int[9];
	if (chalOk) {
		for (int c = 0; c < 9; c++) {
			ranks[c] = proc.ReadValue<int>(roots[c] + 0x8);
			pend[c] = proc.ReadValue<int>(roots[c] + 0xC);
			// Records are rebuilt when a save is loaded: check type and hash every tick
			if (proc.ReadPointer(roots[c]) != rootType || proc.ReadValue<uint>(roots[c] + 0x10) != chalHashes[c] ||
				ranks[c] < 0 || ranks[c] > 10) {
				chalOk = false;
				vars.chalReady = false;
				teardown = true;
				break;
			}
		}
	}

	// ---- Engine collectables (cards, bones, carvings, legendary fish): validate the cached data ----
	uint[] ecCatHash = vars.ecCatHash;
	int[] ecCount = vars.ecCount;
	int[] ecItemType = vars.ecItemType;
	int[] ecHashOff = vars.ecHashOff;
	int[] ecFields = vars.ecFields;
	var ecCat = (IntPtr[])vars.ecCat;
	var ecArr = (IntPtr[])vars.ecArr;
	var ecItems = (IntPtr[][])vars.ecItems;
	var ecHashes = (uint[][])vars.ecHashes;
	var ecPrev = (int[][])vars.ecPrev;
	var ecPrevOk = (bool[])vars.ecPrevOk;
	var ecSettle = (double[])vars.ecSettle;
	var ecProbe = (int[])vars.ecProbe;
	for (int e = 0; e < 4; e++) {
		if (ecCat[e] == IntPtr.Zero)
			continue;
		// The collectable data is rebuilt when a save is loaded: validate it every tick
		IntPtr itemType = baseAddr + ecItemType[e];
		int n = ecCount[e];
		int probe = ecProbe[e];
		ecProbe[e] = (probe + 1) % n;
		bool valid = proc.ReadPointer(ecCat[e]) == catType && proc.ReadValue<uint>(ecCat[e] + 0x28) == ecCatHash[e] &&
			proc.ReadValue<ushort>(ecCat[e] + 0x20) == n && proc.ReadPointer(ecCat[e] + 0x18) == ecArr[e];
		for (int k = 0; valid && k < 2; k++) { // two records per tick, all of them over time
			int i = (probe + (n / 2) * k) % n;
			valid = proc.ReadPointer(ecItems[e][i]) == itemType && proc.ReadValue<uint>(ecItems[e][i] + ecHashOff[e]) == ecHashes[e][i];
		}
		if (!valid) {
			print("[RDR2] collectable data moved, scanning again");
			ecCat[e] = IntPtr.Zero;
			ecPrevOk[e] = false;
			vars.ecScanNext = now + 1; // give the game a moment to rebuild it
			vars.ecScanFails = 0;
			teardown = true;
		}
	}

	// The engine data is torn down when a save load starts, one tick before 'loading' rises: treat it as a load.
	if (teardown) {
		vars.rebase = true;
		if ((double)vars.guardUntil < now + 10)
			vars.guardUntil = now + 10;
	}
	bool running = timer.CurrentPhase == TimerPhase.Running;
	bool live = running && now >= vars.guardUntil;
	bool freeze = running && !live && !vars.rebase;
	Action<string> enqueue = key => { if (done.Add(key)) queue.Enqueue(key); };

	// ---- Challenge splits ----
	if (chalOk && vars.chalPrevOk && live && now >= vars.chalSettle) {
		var prevRanks = (int[])vars.chalPrevRanks;
		var prevPend = (int[])vars.chalPrevPend;
		bool early = settings["chal_early"];
		for (int c = 0; c < 9; c++) {
			int rank = 0;
			if (ranks[c] == prevRanks[c] + 1)
				rank = ranks[c];
			else if (early && pend[c] != 0 && prevPend[c] == 0 && ranks[c] < 10)
				rank = ranks[c] + 1;
			if (rank > 0) {
				string chalKey = "chal_" + chalCats[c] + "_" + rank;
				if (settings[chalKey])
					enqueue(chalKey);
				else
					done.Add(chalKey);
			}
		}
	}

	// ---- Dreamcatchers, graves, legendary animals (saved script globals) ----
	IntPtr g0 = proc.ReadPointer(baseAddr + 0x59B2FB0);
	bool globOk = g0 != IntPtr.Zero && proc.ReadValue<int>(g0 + 0x12478) == 16;
	if (globOk && !vars.globWasOk)
		vars.globSettle = now + 10;
	vars.globWasOk = globOk;
	int dc = 0;
	int gr = 0;
	var leg = new int[16];
	if (globOk) {
		dc = proc.ReadValue<int>(g0 + 0x11AD8) & 0x1FFFFE;
		gr = proc.ReadValue<int>(g0 + 0x11B08) & 0x1FF;
		for (int i = 0; i < 16; i++)
			leg[i] = proc.ReadValue<int>(g0 + 0x12488 + 0x20 * i) != 0 ? 1 : 0;
	}
	if (globOk && vars.globPrevOk && live && now >= vars.globSettle) {
		int newDc = dc & ~(int)vars.dcPrev;
		if (newDc != 0 && (newDc & (newDc - 1)) == 0 && settings["dc"]) // exactly one new dreamcatcher
			enqueue("dc_" + newDc.ToString("X"));
		int newGr = gr & ~(int)vars.gravesPrev;
		if (newGr != 0 && (newGr & (newGr - 1)) == 0 && settings["graves"]) // exactly one new grave
			enqueue("grave_" + newGr.ToString("X"));
		var prevLeg = (int[])vars.legPrev;
		int newLeg = 0;
		for (int i = 0; i < 16; i++)
			if (leg[i] == 1 && prevLeg[i] == 0)
				newLeg++;
		if (newLeg == 1) {
			for (int i = 0; i < 16; i++)
				if (leg[i] == 1 && prevLeg[i] == 0 && settings["legend_" + i])
					enqueue("legend_" + i);
		}
	}

	// ---- Engine collectables: locate them with a one-time background scan ----
	bool wantEc = settings["cards_each"] || settings["cards_set"] || settings["cards_all"] ||
		settings["bones"] || settings["carvings"] || settings["fish"];
	bool ecMissing = false;
	for (int e = 0; e < 4; e++)
		if (ecCat[e] == IntPtr.Zero)
			ecMissing = true;
	if (ecMissing && wantEc) {
		if (vars.ecScanDone != null) {
			if (((bool[])vars.ecScanDone)[0]) {
				var res = (IntPtr[])vars.ecScanResult;
				vars.ecScanDone = null;
				bool allFound = true;
				for (int e = 0; e < 4; e++) {
					if (ecCat[e] != IntPtr.Zero)
						continue;
					int n = ecCount[e];
					IntPtr itemType = baseAddr + ecItemType[e];
					IntPtr arr = res[e] == IntPtr.Zero ? IntPtr.Zero : proc.ReadPointer(res[e] + 0x18);
					bool ok = arr != IntPtr.Zero && proc.ReadPointer(res[e]) == catType && proc.ReadValue<ushort>(res[e] + 0x20) == n;
					var items = new IntPtr[n];
					var hashes = new uint[n];
					for (int i = 0; ok && i < n; i++) {
						items[i] = proc.ReadPointer(arr + 8 * i);
						hashes[i] = proc.ReadValue<uint>(items[i] + ecHashOff[e]);
						ok = proc.ReadPointer(items[i]) == itemType;
					}
					if (!ok) {
						allFound = false;
						continue;
					}
					if (e == 0) {
						var cardSets = (uint[])vars.cardSets;
						for (int i = 0; i < n; i++)
							cardSets[i] = proc.ReadValue<uint>(items[i] + 0x24);
					}
					ecItems[e] = items;
					ecHashes[e] = hashes;
					ecArr[e] = arr;
					ecProbe[e] = 0;
					ecPrevOk[e] = false;
					ecSettle[e] = now + 10; // freshly built data may still read 0 before the save's values arrive
					ecCat[e] = res[e];
				}
				print("[RDR2] collectable data " + (allFound ? "found" : "partly found") + " after " +
					(int)((now - (double)vars.ecScanStart) * 1000) + " ms");
				if (allFound) {
					vars.ecScanFails = 0;
				} else { // e.g. still loading: try again soon, then less often (3, 6, 12, 24, 30 s)
					int fails = (int)vars.ecScanFails;
					vars.ecScanNext = now + Math.Min(3 * (1 << Math.Min(fails, 4)), 30);
					vars.ecScanFails = fails + 1;
				}
			}
		} else if (now >= vars.ecScanNext && chalOk) { // chalOk: a save is loaded (nothing to find in the main menu)
			var scanDone = new bool[1];
			var scanResult = new IntPtr[4];
			var wantHash = (uint[])ecCatHash.Clone();
			var wantCount = (int[])ecCount.Clone();
			ulong catTypeValue = (ulong)(long)catType;
			var scan = new System.Threading.Thread(() => {
				try {
					var pages = new List<LiveSplit.ComponentUtil.MemoryBasicInformation>();
					foreach (var page in proc.MemoryPages(false)) {
						// Plain read/write memory only: GPU-mapped no-cache / write-combined regions are very slow to read
						uint prot = (uint)page.Protect;
						if ((prot & 0xFF) == 0x04 && (prot & 0x700) == 0 && (ulong)page.RegionSize >= 0x100000)
							pages.Add(page);
					}
					// The data lives in the game's main heap, one of the biggest regions: scan those first.
					pages.Sort((a, b) => ((ulong)b.RegionSize).CompareTo((ulong)a.RegionSize));
					int left = wantHash.Length;
					foreach (var page in pages) {
						long start = (long)page.BaseAddress;
						long size = (long)(ulong)page.RegionSize;
						for (long off = 0; off < size && left > 0; off += 0x400000) {
							byte[] buf = proc.ReadBytes((IntPtr)(start + off), (int)Math.Min(0x400000, size - off));
							if (buf == null)
								continue;
							for (int i = 0; i + 8 <= buf.Length && left > 0; i += 8) {
								if (BitConverter.ToUInt64(buf, i) != catTypeValue)
									continue;
								IntPtr cand = (IntPtr)(start + off + i);
								int idx = Array.IndexOf(wantHash, proc.ReadValue<uint>(cand + 0x28));
								if (idx >= 0 && scanResult[idx] == IntPtr.Zero && proc.ReadValue<ushort>(cand + 0x20) == wantCount[idx]) {
									scanResult[idx] = cand;
									left--;
								}
							}
						}
						if (left == 0)
							break;
					}
				} catch (Exception) { }
				scanDone[0] = true;
			});
			scan.IsBackground = true;
			scan.Start();
			vars.ecScanResult = scanResult;
			vars.ecScanDone = scanDone;
			vars.ecScanStart = now;
			print("[RDR2] scanning for collectable data");
		}
	}

	// ---- Engine collectables: read the "found" state of every item and split on new ones ----
	var ecOk = new bool[4];
	var ecCur = new int[4][];
	for (int e = 0; e < 4; e++) {
		int n = ecCount[e];
		ecCur[e] = new int[n];
		ecOk[e] = ecCat[e] != IntPtr.Zero && ecItems[e] != null;
		if (!ecOk[e])
			continue;
		for (int i = 0; i < n; i++) {
			if (ecFields[e] == 1) {
				ecCur[e][i] = proc.ReadValue<int>(ecItems[e][i] + 0x54) > 0 ? 1 : 0;
			} else {
				byte[] f = proc.ReadBytes(ecItems[e][i] + 0x54, 4 * ecFields[e]);
				int any = 0;
				for (int j = 0; f != null && j < f.Length; j++)
					any |= f[j];
				ecCur[e][i] = any != 0 ? 1 : 0;
			}
		}
	}
	for (int e = 0; e < 4; e++) {
		if (!ecOk[e] || !ecPrevOk[e] || !live || now < ecSettle[e])
			continue;
		int n = ecCount[e];
		int newItems = 0;
		for (int i = 0; i < n; i++)
			if (ecCur[e][i] == 1 && ecPrev[e][i] == 0)
				newItems++;
		if (newItems == 1) { // more than one at once means a save was loaded
			for (int i = 0; i < n; i++) {
				if (ecCur[e][i] == 0 || ecPrev[e][i] == 1)
					continue;
				string hash = ecHashes[e][i].ToString("X8");
				if (e == 0) {
					var cardSets = (uint[])vars.cardSets;
					var cardGot = (HashSet<uint>)vars.cardGot;
					int inSet = 0; // held now (needed to complete a set)
					int total = 0; // held at any point in this run (mailed sets still count)
					for (int j = 0; j < n; j++) {
						if (ecCur[e][j] == 1 && cardSets[j] == cardSets[i])
							inSet++;
						if (ecCur[e][j] == 1 || cardGot.Contains(ecHashes[e][j]))
							total++;
					}
					if (settings["cards_each"])
						enqueue("card_" + hash);
					else if (inSet == 12 && settings["cards_set"])
						enqueue("cardset_" + cardSets[i].ToString("X8"));
					else if (total == 144 && settings["cards_all"])
						enqueue("cards_all");
				} else if (e == 1) {
					if (settings["bones"])
						enqueue("bone_" + hash);
				} else if (e == 2) {
					if (settings["carvings"])
						enqueue("carving_" + hash);
				} else {
					if (settings["fish_" + hash])
						enqueue("fish_" + hash);
				}
			}
		}
		if (e == 0) {
			var cardGot = (HashSet<uint>)vars.cardGot;
			for (int i = 0; i < n; i++)
				if (ecCur[e][i] == 1)
					cardGot.Add(ecHashes[e][i]);
		}
	}

	// New baselines, except during a black screen (not a save load, not freshly found data) while the timer runs:
	// then the old ones are kept so an event that happens meanwhile is still seen when the guard ends.
	if (!freeze || now < vars.chalSettle || !chalOk || !vars.chalPrevOk) {
		vars.chalPrevRanks = ranks;
		vars.chalPrevPend = pend;
		vars.chalPrevOk = chalOk;
	}
	if (!freeze || now < vars.globSettle || !globOk || !vars.globPrevOk) {
		vars.dcPrev = dc;
		vars.gravesPrev = gr;
		vars.legPrev = leg;
		vars.globPrevOk = globOk;
	}
	for (int e = 0; e < 4; e++) {
		if (!freeze || now < ecSettle[e] || !ecOk[e] || !ecPrevOk[e]) {
			ecPrev[e] = ecCur[e];
			ecPrevOk[e] = ecOk[e];
		}
	}
	if (now >= vars.guardUntil)
		vars.rebase = false;
	return true;
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

	// Challenge / collectible splits queued by update (one per tick). Only while LiveSplit will really split
	// (not paused, not before 0:00 with a start offset), otherwise the queued event would be lost.
	if (!vars.doSplit && timer.CurrentPhase == TimerPhase.Running && timer.CurrentTime.RealTime > TimeSpan.Zero &&
		((Queue<string>)vars.splitQueue).Count > 0) {
		print("[RDR2] split: " + ((Queue<string>)vars.splitQueue).Dequeue());
		vars.doSplit = true;
	}

	return vars.doSplit;
}

isLoading
{
	return current.loading != 0;
}
