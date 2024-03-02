--[[
	Author  :  Mubinet (@mubinets | 5220307661)
	Date    :  2/25/2024
	Updated :  2/25/2024
	Version :  1.0.0a
--]]

-- Enable Strict Mode for type checking.
--!strict

------------------- [[ SERVICES ]] -------------------

local TweenService = game:GetService("TweenService")

------------------- [[ UTILITY ]]

local function checkForEffectParameter(guiObject : GuiObject, uiEffectInfo : UIEffectInfo?)
	if not guiObject then
		error("GuiObject passed in parameter is nil or simply missing.")
	end

	if (uiEffectInfo and not uiEffectInfo.effectTime) or (uiEffectInfo and not uiEffectInfo.repeatEffectCount) then
		error("UIEffectInfo passed in parameter has missing one or more properties.")
	end
end

------------------- [[ MAIN ]] -------------------

local MubInterface = {}
local MubInterfacePrototype = {}
MubInterfacePrototype.__index = MubInterfacePrototype
MubInterfacePrototype.Effects = {}

--[[
	@return { MubInterface }
	
	A constructor that returns the newly created class.
--]]

function MubInterface.new()
	return setmetatable({}, MubInterfacePrototype)
end

--[[
	@param	guiObject		:	GuiObject		|	The gui object to be used for creating effect.
	@param	uiEffectInfo	:	UIEffectInfo	|	The information that specfies the behavior of the effect.
	@return	UIEffect
	
	Creates the appearing effect that can be used to play.
--]]

function MubInterfacePrototype.Effects:CreateAppearingEffect(guiObject : GuiObject, uiEffectInfo : UIEffectInfo?) : AppearingUIEffect
	-- Checking guard
	checkForEffectParameter(guiObject, uiEffectInfo)
	
	local originalSize : UDim2 = guiObject.Size
	guiObject.Size = UDim2.new(0,0,0,0)
	
	-- Creating TweenInfo
	local tweenInfo : TweenInfo
	
	if uiEffectInfo then
		tweenInfo = TweenInfo.new(uiEffectInfo.effectTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, uiEffectInfo.repeatEffectCount)
	end
	
	-- Creating goal
	local goal = {}
	goal.Size = originalSize
	
	local tween = TweenService:Create(guiObject, tweenInfo, goal)
	local effect : AppearingUIEffect = {}
	
	-- Creating RBXScriptSignal event
	local effectEvent : BindableEvent = Instance.new("BindableEvent")
	
	-- Assigning the completed event to the event of BindableEvent. Both are in the same type.
	effect.completed = effectEvent.Event
	
	-- Defining & Assigning the function.
	effect.play = function()
		tween.Completed:Connect(function()
			effectEvent:Fire()
		end)
		
		tween:Play()
	end
	
	return effect
end

--[[
	@param	guiObject		:	GuiObject		|	The gui object to be used for creating effect.
	@param	uiEffectInfo	:	UIEffectInfo	|	The information that specfies the behavior of the effect.
	@return	UIEffect
	
	Creates the appearing effect that can be used to play.
--]]

function MubInterfacePrototype.Effects:CreateDisappearingEffect(guiObject : GuiObject, uiEffectInfo : UIEffectInfo?) : DisappearingUIEffect
	-- Checking guard
	checkForEffectParameter(guiObject, uiEffectInfo)
	
	local finalSize : UDim2 = UDim2.new(0,0,0,0)
	
	-- Creating TweenInfo
	local tweenInfo : TweenInfo
	
	if uiEffectInfo then
		tweenInfo = TweenInfo.new(uiEffectInfo.effectTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, uiEffectInfo.repeatEffectCount)
	end
	
	-- Creating goal
	local goal = {}
	goal.Size = finalSize
	
	local tween = TweenService:Create(guiObject, tweenInfo, goal)
	local effect : DisappearingUIEffect = {}
	
	-- Creating RBXScriptSignal event
	local effectEvent : BindableEvent = Instance.new("BindableEvent")
	
	-- Assigning the completed event to the event of BindableEvent. Both are in the same type.
	effect.completed = effectEvent.Event
	
	-- Defining & Assigning the function.
	effect.play = function()
		tween.Completed:Connect(function()
			effectEvent:Fire()
		end)
		
		tween:Play()
	end
	
	return effect
end

------------------- [[ ENUMS ]] -------------------


------------------- [[ ENUM TYPES ]] -------------------


------------------- [[ BASE TYPES ]] -------------------

type BaseUIEffect = {
	isPlaying	:	boolean,
	completed	:	RBXScriptSignal,
	play		:	(baseUIEffect : BaseUIEffect) -> ()
}

------------------- [[ PUBLIC TYPES ]] -------------------

export type AppearingUIEffect = BaseUIEffect & {

}

export type DisappearingUIEffect = BaseUIEffect & {

}

export type UIEffectInfo = {
	effectTime			:	number,
	repeatEffectCount	:	number,
}

return MubInterface
