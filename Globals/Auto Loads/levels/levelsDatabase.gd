extends Node


const EASY_LEVELS : Array[Array] = [ # starting_word, target_word, solution(conjoined)
	["BIG", "DIG", "D"],
	["DOG", "JOG", "J"],
	["HAT", "BAR", "BR"],
	["FIG", "JAM", "AJM"],
	["POT", "GEM", "GEM"]
]

const MEDIUM_LEVELS : Array[Array] = [ # starting word, end word, soulution(conjoined)
	["CARD", "GAME", "EMG"],
	["RING", "LIFE", "DELF"],
	["CARE", "BEAR", "BKEAR"],
	["CARD", "KING", "BNIKG"],
	["WOOD", "DUCK", "HKCDU"]
]

const HARD_LEVELS : Array[Array] = [
	["GLASS", "SHARD", "CPHRDS"],
	["SLIDE", "COAST", "GABSTOC"], # Need to find better stuff for this
	["BROKE", "CHEAP", "ACTKCIHEEPA"],
	["WATER", "SPILL", "HDRISHIPLL"],
	["MAGIC", "SPELL", "NAGYLWLDIRLTWSPE"]
]
