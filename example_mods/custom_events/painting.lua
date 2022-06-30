local beatsUntilNo1 = nil
local beatsUntilNo2 = nil
local beatsUntilNo3 = nil
function onCreate()
    precacheImage('fd/cofre/Paintings/DrawingDemon')
	precacheImage('fd/cofre/Paintings/DrawingDemon2')
	precacheImage('fd/cofre/Paintings/DrawingMom')
end

function onEvent(name, value1, value2)
    if name == 'painting' then
	    if value1 == '1' then
	        beatsUntilNo1 = curBeat + value2
		elseif value1 == '2' then
		    beatsUntilNo2 = curBeat + value2
		elseif value1 == '3' then
		    beatsUntilNo3 = curBeat + value2
		end
		
	    if value1 == '1' or value1 == '2' then
		    if value1 == '1' then
		        makeAnimatedLuaSprite('painting1', 'fd/cofre/Paintings/DrawingDemon', 900,300)
				addAnimationByPrefix('painting'..value1,'demon','demon',24,false)
			else
			    makeAnimatedLuaSprite('painting2', 'fd/cofre/Paintings/DrawingDemon2',600,200)
				addAnimationByPrefix('painting'..value1,'demon','demon2',24,false)
			end
		    setObjectCamera('painting'..value1, 'hud')
		    
			
			
	        addLuaSprite('painting'..value1, true);
		elseif value1 == '3' then
		    makeAnimatedLuaSprite('painting3', 'fd/cofre/Paintings/DrawingMom',750,150)
		    addAnimationByPrefix('painting'..value1,'demon','mom',24,false)
		    setObjectCamera('painting'..value1, 'hud')
		    
			
			
	        addLuaSprite('painting'..value1, true);
		end
		--debugPrint('painting'..value1..' was created!')
	end
end

function onUpdate()
	    if beatsUntilNo1 == curBeat then
			objectPlayAnimation('painting1','demon',false)
			--debugPrint('painting1'..' was removed!')
			beatsUntilNo1 = nil
		elseif beatsUntilNo2 == curBeat then
			objectPlayAnimation('painting2','demon',false)
			--debugPrint('painting2'..' was removed!')
			beatsUntilNo2 = nil
		elseif beatsUntilNo3 == curBeat then
			objectPlayAnimation('painting3','demon',false)
			--debugPrint('painting3'..' was removed!')
			beatsUntilNo3 = nil
		end
	if getProperty('painting1.animation.curAnim.finished') then
        removeLuaSprite('painting1', false)
    end
	if getProperty('painting2.animation.curAnim.finished') then
        removeLuaSprite('painting2', false)
    end
	if getProperty('painting3.animation.curAnim.finished') then
        removeLuaSprite('painting3', false)
    end
end