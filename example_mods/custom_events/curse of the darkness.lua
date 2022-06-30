local active = false
local utilUnactive = nil
local alphaChange = nil

function onEvent(name, value1, value2)
	if name == 'curse of the darkness' then
	    active = true
	    utilUnactive = curStep + value1
		if value2 == '' then
	        alphaChange = 0.04 
		else
		    alphaChange = value2
		end
    end
end

function onUpdate(elapsed)
    if active == true then
	    local curseAlpha = getProperty('curse.alpha')
		setProperty('curse.alpha', curseAlpha - alphaChange)
	    if curseAlpha <= 0 then
		    setProperty('curse.alpha', 1.1)
		end
	    if curStep == utilUnactive then
		    active = false
			setProperty('curse.alpha', 0)
		end
	end
end

function onCreate()
    makeLuaSprite('curse','',-4,0)
    makeGraphic('curse',1480,882,'000000')
	setScrollFactor('curse',0,0)
    setObjectCamera('curse','hud')
	setProperty('curse.alpha', 0);
	
	addLuaSprite('curse',true)
end