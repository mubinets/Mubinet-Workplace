--[[
	Author  :  Mubinet (@mubinets | 5220307661)
	Date    :  2/11/2024
	Version :  1.0.0a
--]]



--!strict



--[[
	A private class for assistance.
--]]

local _MubFrame = {
	_RandomStringGenerator = {
		
		-- Declaration
		_alphabletArray  = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"},
		_numberArray	 = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"},
		_symbolArray	 = {"!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "+", "=", "{", "}", "[", "]", "|", "", ":", ";", "'", "\"", "<", ">", ",", ".", "?", "/"},
		
		--[[
			@return string
			Generate random letter.
		--]]
		
		generateRandomLetter = function(tableSelf) : string
			local startIndex = 1
			
			local letterIndex = math.random(startIndex, #tableSelf._alphabletArray)
			
			local letter = tableSelf._alphabletArray[letterIndex]
			
			return letter
		end,
		
		--[[
			@return number
			Generate random number.
		--]]
		
		generateRandomNumber = function(tableSelf) : string
			local startIndex  : number = 1

			local numberIndex : number = math.random(startIndex, #tableSelf._numberArray)

			local number = tableSelf._numberArray[numberIndex]

			return number
		end,
		
		--[[
			@return string
			Generate random symbol.
		--]]
		
		generateRandomSymbol = function(tableSelf) : string
			local startIndex : number = 1

			local letterIndex : number = math.random(startIndex, #tableSelf._symbolArray)

			local symbol : string = tableSelf._symbolArray[letterIndex]

			return symbol
		end
	}
}


--[[
	Declaration namespace.
--]]

local MubFrame = {}



--[[
	Declaration classes
--]]

--------------- RANDOM STRING GENERATOR --------------------

local RandomStringGenerator    = {}
local MetatableRandomStringGenerator = {}
MetatableRandomStringGenerator.__index  = MetatableRandomStringGenerator
MubFrame.RandomStringGenerator = RandomStringGenerator

-------------------------------------------------------------

--[[
	@param length		number					|	How long should the string be generated
	@param parameter	RandomStringParam?		|   THe parameter to generate the string
	@return string								|   The generated string
--]]

function RandomStringGenerator.new()
	return setmetatable({}, MetatableRandomStringGenerator)
end

function MetatableRandomStringGenerator:generateRandomString(length : number, parameter : RandomStringParam?) : string
	-- Guard Checks
	if (length < 1) then
		error("The length parameter cannot be less than the minimum value of 1.")
	end
	
	-- Declaration of probabilities.
	local numberProbability : number = (1 / 10)
	local symbolProbability : number = (1 / 10)
	local stringProbability : number = (1 / 10)
	
	-- Declaration of the final result.
	local result : string = ""
	
	if (parameter) then
		numberProbability = ( (parameter.numberFrequency and parameter.numberFrequency.value or 1) / 10)
		symbolProbability = ( (parameter.symbolFrequency and parameter.symbolFrequency.value or 1) / 10)
		stringProbability = ( (parameter.stringFrequency and parameter.stringFrequency.value or 1) / 10)
	end
	
	for lengthCount = 0, length, 1 do
		local random_number = math.random()
		
		if (random_number < numberProbability and parameter.includeNumber) then
			-- Generate random number
			result = result .. _MubFrame._RandomStringGenerator:generateRandomNumber()
		elseif (random_number < numberProbability + stringProbability) then
			-- Generate random letter
			result = result .. _MubFrame._RandomStringGenerator:generateRandomLetter()
		elseif (parameter.includeSymbol) then
			-- Generate random symbol
			result = result .. _MubFrame._RandomStringGenerator:generateRandomSymbol()
		end
	end
	
	return result
end


--[[
	Declaration of enums
--]]


export type FrequencyEnum = {
	value : number
}


MubFrame.FrequencyEnum = {
	["one"] 	= 	{  value = 1  },
	["two"] 	= 	{  value = 2  },
	["three"] 	=	{  value = 3  },
	["four"] 	=	{  value = 4  },
	["five"] 	= 	{  value = 5  },
	["six"] 	=   {  value = 6  },
	["seven"] 	=   {  value = 7  },
	["eight"] 	= 	{  value = 8  },
	["nine"] 	= 	{  value = 9  }
}


--[[
	A parameter for generating randomized string.
--]]


export type RandomStringParam = {
	includeNumber 	: boolean,
	includeSymbol 	: boolean,
	numberFrequency : FrequencyEnum,
	symbolFrequency : FrequencyEnum,
	stringFrequency : FrequencyEnum,
}

return MubFrame
