local lp = getLocalPlayer()
local resW, resH = 1366,768
local screenW,screenH = guiGetScreenSize()
local vx, vy = (screenW/resW), (screenH/resH)
local x, y = ((vx/vy) * vy), (vx * (vy/vx))

local giroflexs = {}
local giroflexsData = {}
local giroflexsLighting = {}

local data = {}
triggerServerEvent("getVehiclesLightData", lp)
addEvent("sendVehiclesLightData", true)
addEventHandler("sendVehiclesLightData", getRootElement(), 
function(vdata)
	data = vdata
end
)


--[[
	* Coisas liberada no painel ( Edite no vhdata )
	- Giroflex ( caso eu coloque false, nada irá funcionar do painel. )
	- Sound ( caso eu coloque false, eu desativo o som da sirene no painel. )
	- Alert ( caso eu coloque false, eu desativo o modo alerta do painel. )

	Formato:
	[596] = {giroflex = true, sound = true, alert = true},
	^ ID     ^ [ Coisas à ativar, explicada a cima. ]  ^
	   DO
	    VEÌCULO
]]
local vhdata = {

	--PCESP - NORMAL
	[585] = {giroflex = true, sound = true, alert = true},
	--PCESP - GARRA
	[490] = {giroflex = true, sound = true, alert = true},
	--ROCAM
	[523] = {giroflex = true, sound = false, alert = true},

}

local lights = {}
local lights_sounds = {}

local isVisible = {}

local location = {480, 680}

--[[
	* Velocidade de cada giroflex ( Edite no gv )
	Lenta Normal Rápida
	{1   , 3    , 8   }
]]
local gv = {1, 3, 8}

function showLightManager()
	local vehicle = getPedOccupiedVehicle(lp)
	if vehicle and data[getElementModel(vehicle)] then
		setVehicleSirensOn(vehicle, false) 
		isVisible[vehicle] = not isVisible[vehicle]
	end
end
bindKey("h", "down", showLightManager) -- Tecla que deve apertar para parecer o painel

function showingLightManager()
	local vehicle = getPedOccupiedVehicle(lp)
	local model = 0
	if vehicle then
		model = getElementModel(vehicle)
	end
	local hasVehicle = vehicle and data[getElementModel(vehicle)]
	if hasVehicle and getVehicleSirensOn(vehicle) then setVehicleSirensOn(vehicle, false) end
	if hasVehicle and isVisible[vehicle] then
		local hdata = vhdata[model]
		local g = giroflexs[vehicle]
		local s, sd, ad, gl = false, false, false, 1
		if g then
			s, sd, ad, gl = g.status, g.sound_status, g.alert_status, g.giroflex
		end
		dxDrawRectangle(x*location[1], y*location[2], x*415, y*85, tocolor(30, 30, 30, 220), false)
		dxDrawRectangle(x*location[1], y*location[2], x*415, y*22, tocolor(0, 123, 255, 220), false)
		dxDrawText("Giroflex", x*(location[1]+160), y*(location[2] - 5), x*475, y*30, tocolor(255, 255, 255, 200), x*2, "calibri", "left", "top", false, false, false, false, false)
		dxDrawText("Sirene:", x*(location[1]+5), y*(location[2]+23), x*475, y*30, tocolor(255, 255, 255, 200), x*2, "calibri", "left", "top", false, false, false, false, false)
		local color = {[1] = tocolor(255, 17, 0, 220), [2] = tocolor(255, 67, 54, 200)}
		local text = "Off"
		if s == true then
			if cursorPosition(x*(location[1]+85), y*(location[2]+25), x*71, y*25) then
				color = {[1] = tocolor(0, 160, 255, 220), [2] = tocolor(255, 255, 255, 200)}
				text = "Off"
			else
				color = {[1] = tocolor(0, 123, 255, 220), [2] = tocolor(255, 255, 255, 200)}
				text = "On"
			end
		elseif cursorPosition(x*(location[1]+85), y*(location[2]+25), x*71, y*25) then
			color = {[1] = tocolor(255, 40, 40, 255), [2] = tocolor(255, 137, 134, 200)}
			text = "On"
		end
		if not hdata.giroflex then
			color = {[1] = tocolor(130, 17, 0, 220), [2] = tocolor(150, 67, 54, 200)}
			text = "S/A"
		end
		dxDrawRectangle(x*(location[1]+85), y*(location[2]+25), x*71, y*25, color[1], false)
		dxDrawText(text, x*(location[1]+100), y*(location[2]+22), x*150, y*25, color[2], x*2, "calibri", "left", "top", false, false, false, false, false)

		color = {[1] = tocolor(255, 17, 0, 220), [2] = tocolor(255, 67, 54, 200)}
		if gl == gv[1] then
			if cursorPosition(x*(location[1]+157), y*(location[2]+25), x*71, y*25) then
				color = {[1] = tocolor(0, 160, 255, 220), [2] = tocolor(255, 255, 255, 200)}
			else
				color = {[1] = tocolor(0, 123, 255, 220), [2] = tocolor(255, 255, 255, 200)}
			end
		elseif cursorPosition(x*(location[1]+157), y*(location[2]+25), x*71, y*25) then
			color = {[1] = tocolor(255, 40, 40, 255), [2] = tocolor(255, 137, 134, 200)}
		end
		if not hdata.giroflex then
			color = {[1] = tocolor(130, 17, 0, 220), [2] = tocolor(150, 67, 54, 200)}
		end
		dxDrawRectangle(x*(location[1]+157), y*(location[2]+25), x*71, y*25, color[1], false)
		dxDrawText("Lenta", x*(location[1]+162), y*(location[2]+22), x*150, y*25, color[2], x*2, "calibri", "left", "top", false, false, false, false, false)

		color = {[1] = tocolor(255, 17, 0, 220), [2] = tocolor(255, 67, 54, 200)}
		if gl == gv[2] then
			if cursorPosition(x*(location[1]+232), y*(location[2]+25), x*88, y*25) then
				color = {[1] = tocolor(0, 160, 255, 220), [2] = tocolor(255, 255, 255, 200)}
			else
				color = {[1] = tocolor(0, 123, 255, 220), [2] = tocolor(255, 255, 255, 200)}
			end
		elseif cursorPosition(x*(location[1]+232), y*(location[2]+25), x*88, y*25) then
			color = {[1] = tocolor(255, 40, 40, 255), [2] = tocolor(255, 137, 134, 200)}
		end
		if not hdata.giroflex then
			color = {[1] = tocolor(130, 17, 0, 220), [2] = tocolor(150, 67, 54, 200)}
		end
		dxDrawRectangle(x*(location[1]+231), y*(location[2]+25), x*88, y*25, color[1], false)
		dxDrawText("Normal", x*(location[1]+235), y*(location[2]+22), x*150, y*25, color[2], x*2, "calibri", "left", "top", false, false, false, false, false)

		color = {[1] = tocolor(255, 17, 0, 220), [2] = tocolor(255, 67, 54, 200)}
		if gl == gv[3] then
			if cursorPosition(x*(location[1]+321), y*(location[2]+25), x*88, y*25) then
				color = {[1] = tocolor(0, 160, 255, 220), [2] = tocolor(255, 255, 255, 200)}
			else
				color = {[1] = tocolor(0, 123, 255, 220), [2] = tocolor(255, 255, 255, 200)}
			end
		elseif cursorPosition(x*(location[1]+321), y*(location[2]+25), x*88, y*25) then
			color = {[1] = tocolor(255, 40, 40, 255), [2] = tocolor(255, 137, 134, 200)}
		end
		if not hdata.giroflex then
			color = {[1] = tocolor(130, 17, 0, 220), [2] = tocolor(150, 67, 54, 200)}
		end
		dxDrawRectangle(x*(location[1]+321), y*(location[2]+25), x*88, y*25, color[1], false)
		dxDrawText("Rapida", x*(location[1]+325), y*(location[2]+22), x*150, y*25, color[2], x*2, "calibri", "left", "top", false, false, false, false, false)
	
		dxDrawText("Som:", x*(location[1]+5), y*(location[2]+47), x*475, y*30, tocolor(255, 255, 255, 200), x*2, "calibri", "left", "top", false, false, false, false, false)
		local text = "Desligado"
		color = {[1] = tocolor(255, 17, 0, 220), [2] = tocolor(255, 67, 54, 200)}
		if sd == true then
			if cursorPosition(x*(location[1]+66), y*(location[2]+52), x*125, y*25) then
				color = {[1] = tocolor(0, 160, 255, 220), [2] = tocolor(255, 255, 255, 200)}
				text = "Desligar"
			else
				color = {[1] = tocolor(0, 123, 255, 220), [2] = tocolor(255, 255, 255, 200)}
				text = "Ligado"
			end
		elseif cursorPosition(x*(location[1]+66), y*(location[2]+52), x*125, y*25) then
			color = {[1] = tocolor(255, 40, 40, 255), [2] = tocolor(255, 137, 134, 200)}
			text = "Ligar"
		end
		if not hdata.sound then
			color = {[1] = tocolor(130, 17, 0, 220), [2] = tocolor(150, 67, 54, 200)}
			text = "S/ Acesso"
		end
		dxDrawRectangle(x*(location[1]+66), y*(location[2]+52), x*125, y*25, color[1], false)
		dxDrawText(text, x*(location[1]+74), y*(location[2]+47), x*150, y*25, color[2], x*2, "calibri", "left", "top", false, false, false, false, false)
	
		dxDrawText("| Alerta:", x*(location[1]+192), y*(location[2]+47), x*475, y*30, tocolor(255, 255, 255, 200), x*2, "calibri", "left", "top", false, false, false, false, false)
		local text = "Desligado"
		color = {[1] = tocolor(255, 17, 0, 220), [2] = tocolor(255, 67, 54, 200)}
		if ad == true then
			if cursorPosition(x*(location[1]+285), y*(location[2]+44), x*125, y*25) then
				color = {[1] = tocolor(0, 160, 255, 220), [2] = tocolor(255, 255, 255, 200)}
				text = "Desligar"
			else
				color = {[1] = tocolor(0, 123, 255, 220), [2] = tocolor(255, 255, 255, 200)}
				text = "Ligado"
			end
		elseif cursorPosition(x*(location[1]+285), y*(location[2]+44), x*125, y*25) then
			color = {[1] = tocolor(255, 40, 40, 255), [2] = tocolor(255, 137, 134, 200)}
			text = "Ligar"
		end
		if not hdata.alert then
			color = {[1] = tocolor(130, 17, 0, 220), [2] = tocolor(150, 67, 54, 200)}
			text = "S/ Acesso"
		end
		dxDrawRectangle(x*(location[1]+285), y*(location[2]+52), x*125, y*25, color[1], false)
		dxDrawText(text, x*(location[1]+293), y*(location[2]+47), x*150, y*25, color[2], x*2, "calibri", "left", "top", false, false, false, false, false)
	end

end
addEventHandler("onClientRender", getRootElement(), showingLightManager)

function onClick(botao, state)
	if state == "down" then
		local vehicle = getPedOccupiedVehicle(lp)
		local model = 0
		if vehicle then model = getElementModel(vehicle) end
		if botao == "left" and vehicle and data[getElementModel(vehicle)] and isVisible[vehicle] then
			local hdata = vhdata[model]
			if cursorPosition(x*(location[1]+85), y*(location[2]+25), x*71, y*25) and hdata.giroflex then
				local status, speed = true, 1
				if giroflexs[vehicle] then 
					status = not giroflexs[vehicle].status
					giroflexs[vehicle].status = status
					speed = giroflexs[vehicle].giroflex
				end
				triggerServerEvent("setVehicleLightStatus", lp, vehicle, status, speed)
			elseif cursorPosition(x*(location[1]+157), y*(location[2]+25), x*71, y*25) and hdata.giroflex then
				if giroflexs[vehicle] then
					triggerServerEvent("setVehicleLightSpeedChange", lp, vehicle, gv[1])
				end
			elseif cursorPosition(x*(location[1]+231), y*(location[2]+25), x*88, y*25) and hdata.giroflex then
				if giroflexs[vehicle] then
					triggerServerEvent("setVehicleLightSpeedChange", lp, vehicle, gv[2])
				end
			elseif cursorPosition(x*(location[1]+321), y*(location[2]+25), x*88, y*25) and hdata.giroflex then
				if giroflexs[vehicle] then
					triggerServerEvent("setVehicleLightSpeedChange", lp, vehicle, gv[3])
				end
			elseif cursorPosition(x*(location[1]+66), y*(location[2]+52), x*125, y*25) and hdata.sound then
				local status = true
				if giroflexs[vehicle] then 
					status = not giroflexs[vehicle].sound_status
				end
				triggerServerEvent("setVehicleSoundStatus", lp, vehicle, status)
			elseif cursorPosition(x*(location[1]+285), y*(location[2]+44), x*125, y*25) and hdata.alert then
				local status = true
				if giroflexs[vehicle] then 
					status = not giroflexs[vehicle].alert_status
				end
				triggerServerEvent("setVehicleAlertStatus", lp, vehicle, status)
				setTimer(
					function(vehicle, status)
						if not status then
							if vehicle and giroflexs[vehicle] then
								color = giroflexs[vehicle].alert_backup
								setVehicleHeadLightColor(vehicle, color[1], color[2], color[3])
								setVehicleLightState(vehicle, 1, 0)
								setVehicleLightState(vehicle, 0, 0)
							end
						end
					end
				,200, 10, vehicle, status)
			end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), onClick)

function cursorPosition(x, y, width, height)
	if (not isCursorShowing()) then
		return false
	end
	local sx, sy = guiGetScreenSize()
	local cx, cy = getCursorPosition()
	local cx, cy = (cx*sx), (cy*sy)
	if (cx >= x and cx <= x + width) and (cy >= y and cy <= y + height) then
		return true
	else
		return false
	end
end

addEvent("sendVehicleGiroflexData", true)
addEventHandler("sendVehicleGiroflexData", getRootElement(), 
function(vdata)
	local vh = vdata[1].vehicle
	giroflexs[vh] = vdata[1]
	giroflexsData[vh] = vdata[2]
	giroflexsLighting[vh] = vdata[3]
	lighting()
end
)

addEvent("removeVehicleGiroflexData", true)
addEventHandler("removeVehicleGiroflexData", getRootElement(), 
function(vdata)
	local vh = vdata[1].vehicle
	giroflexs[vh] = nil
	giroflexsData[vh] = nil
	giroflexsLighting[vh] = nil
	if lights[vh] then
		for i, v in ipairs(lights[vh]) do
			detachElements(v, vh)
			destroyElement(v)
			lights[vehicle][i] = nil
		end
	end
	if lights_sounds[vh] then
		destroyElement(lights_sounds[vh])
		lights_sounds[vh] = nil
	end	
end
)

addEvent("updateVehicleGiroflexData", true)
addEventHandler("updateVehicleGiroflexData", getRootElement(), 
function(vdata)
	local vh = vdata[1].vehicle
	if lights[vh] then
		for i, v in ipairs(lights[vh]) do
			detachElements(v, vh)
			destroyElement(v)
			lights[vh][i] = nil
		end
	end
	giroflexs[vh] = vdata[1]
	giroflexsData[vh] = vdata[2]
	giroflexsLighting[vh] = vdata[3]
	--outputChatBox(">> "..giroflexsLighting[vh])
	lighting()
end
)

addEvent("updateVehiclesGiroflexDatas", true)
addEventHandler("updateVehiclesGiroflexDatas", getRootElement(), 
function(vdata)
	if lights then
		for i, v in pairs(lights) do
			for id, l in ipairs(v) do
				destroyElement(l)
				lights[i][id] = nil
			end
		end
	end	
	if lights_sounds then
		for i, v in pairs(lights_sounds) do
			destroyElement(v)
			lights_sounds[i] = nil
		end
	end	
	giroflexs = vdata[1]
	giroflexsData = vdata[2]
	giroflexsLighting = vdata[3]
	lighting()
end
)

local status = false
function lighting()
	local px, py, pz = getElementPosition(lp)
	for i ,v in pairs(giroflexs) do
		local gv = v
		local vehicle = false
		if gv then vehicle = gv.vehicle end
		if vehicle and isElement(vehicle) then
			local sx, sy, sz = getElementPosition(vehicle)
			local dist = getDistanceBetweenPoints3D(px, py, pz, sx, sy, sz)
			if dist > 150 or isVehicleBlown(vehicle) then
				for i ,v in ipairs(lights[vehicle]) do
					detachElements(v, vehicle)
					destroyElement(v)
					lights[vehicle][i] = nil
				end
				if lights_sounds[vehicle] then
					destroyElement(lights_sounds[vehicle])
					lights_sounds[vehicle] = nil
				end
			elseif not (status and isVehicleBlown(vehicle)) then
				status = true
				local size = table.size(giroflexsData[vehicle][giroflexsLighting[vehicle]].locals)
				for i,v in ipairs(giroflexsData[vehicle][giroflexsLighting[vehicle]].locals) do
					if not lights[vehicle] or (not lights[vehicle][i]) then
						local color = v.color
						local vlight = false
						if v.islight then
							vlight = createLight(0, 0, 0, 0, v.s, color[1], color[2], color[3], 0, 0,0, true)
						else
							vlight = createMarker(0, 0, 0, 'corona', v.s, color[1], color[2], color[3], color[4], lp)
						end
						if gv.sound_status == true then
							createSound(vehicle, giroflexsData[vehicle][giroflexsLighting[vehicle]].sound)
						elseif lights_sounds[vehicle] then
							destroyElement(lights_sounds[vehicle])
							lights_sounds[vehicle] = nil
						end
						if gv.alert_status then
							if gv.alert_value == 1 then
								setVehicleHeadLightColor(vehicle, 255, 0, 0)
								setVehicleLightState(vehicle, 0, 1)
								setVehicleLightState(vehicle, 1, 0)
							elseif gv.alert_value == 2 then
								setVehicleHeadLightColor(vehicle, 0, 0, 255)
								setVehicleLightState(vehicle, 1, 1)
								setVehicleLightState(vehicle, 0, 0)
							end
						end
						if vlight then
							attachElements(vlight, vehicle, 0.4+v.x, -0.2+v.y, 0.8+v.z)
							if lights[vehicle] then
								lights[vehicle][i] = vlight
							else
								lights[vehicle] = {[i] = vlight}
							end
						end
					end
					if i >= size then status = false end
				end
			end
		end
	end
end
--setTimer(lighting, 0, 0)

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function createSound(vehicle, sound)
	if not lights_sounds[vehicle] then
		local sound = playSound3D("sounds/"..sound, 0,0,0, true)
		setSoundMaxDistance(sound, 200)
		setSoundVolume(sound, 0.5)
		attachElements(sound, vehicle, 0, 0, 0)
		lights_sounds[vehicle] = sound
	end
end