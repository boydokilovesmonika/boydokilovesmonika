local effectsBad = {'bad trip', 'amnesia', 'im excited', 'im drowsy', 'I found pills'}
local untilAmnesiOff = 0
local curEffect = nil
local extraSpeed = 0

function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'pill' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'fd/pillnotes');
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', 0);
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then 
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			end
		end
	end
	if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
	    makeLuaText('curPill', 'Current pill: ', 300, 975, 650)
	else
	    makeLuaText('curPill', 'Current pill: ', 300, 975, 90)
	end
	setTextAlignment('curPill', 'left')
	setObjectCamera('curPill', 'hud')
	setTextSize('curPill', 22.5)
	addLuaText('curPill')
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'pill' then
	    curEffect = math.floor(getRandomInt(1,#effectsBad))
		if effectsBad[curEffect] ~= 'I found pills' then
		    playSound('pillbad')
		end
		if effectsBad[curEffect] == 'bad trip' then
		    characterPlayAnim('boyfriend','hurt',true)
		    setProperty('health', getProperty('health') - 0.4)
		elseif effectsBad[curEffect] == 'I found pills' then
		    playSound('foundpills')
		elseif effectsBad[curEffect] == 'im drowsy' then
		    extraSpeed = extraSpeed - 0.15
		elseif effectsBad[curEffect] == 'im excited' then
		    extraSpeed = extraSpeed + 0.15
		elseif effectsBad[curEffect] == 'amnesia' then
		    untilAmnesiOff = untilAmnesiOff + 16
		end    
		setTextString('curPill', 'Effect:'..effectsBad[curEffect]) 
	end
end

function onBeatHit()
    if untilAmnesiOff > 0 then
	    untilAmnesiOff = untilAmnesiOff - 1
	end
end

function onUpdatePost()
    if untilAmnesiOff > 0 then
        for i = 0, getProperty('notes.length') - 1 do
		    if getPropertyFromGroup('notes', i, 'noteType') ~= 'pill' then
			    if getPropertyFromGroup('notes', i, 'mustPress') then 
	                setPropertyFromGroup('notes', i, 'alpha', 0.3)
				end
			end
		end
	else
	    for i = 0, getProperty('notes.length') - 1 do
	        setPropertyFromGroup('notes', i, 'alpha', 1)
		end
	end
	for i = 0, getProperty('notes.length') - 1 do
	    if getPropertyFromGroup('notes', i, 'mustPress') then
		    setPropertyFromGroup('notes', i, 'y', getPropertyFromGroup('notes', i, 'y') * (1 + extraSpeed))
		end
	end
end