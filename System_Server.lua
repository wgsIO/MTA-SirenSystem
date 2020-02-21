local giroflex = {}
local gac = {}
local started = {}

--[[
	* Configuração do giroflex ( giroflexLocals )
	sleep - Taxa de atualização
	sound - Som da sirene
	locals { <- Aqui é a localidade de cada efeito do giroflex, ex:
		[1] = {x = 0.2, y = 0.08, z = 0.18, s = 0.2, color = {255, 0, 0, 255}, islight = false},
		^ID    ^X       ^Y        ^Z        ^ Tamanho  ^Cor  {^r , ^g, ^b, ^ transparencia} ^ islight = Efeito de a luz cobrir o veículo todo
	} 


]]
local giroflexLocals = {
	
	--PCESP - NORMAL
	[585] = {
		[1] = {
			sleep = 400,
			sound = "police-light.mp3",
			locals = {
				[1] = {x = 0.2, y = -0.1, z = 0.36, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[2] = {x = -0.9, y = -0.1, z = 0.36, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[3] = {x = 0, y = 0.05, z = 0.36, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[4] = {x = -0.7, y = 0.05, z = 0.36, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[5] = {x = 0, y = -2, z = 1.5, s = 10, color = {255, 0, 0, 255}, islight = true},
				[6] = {x = 0, y = -2, z = 1.5, s = 15, color = {255, 0, 0, 255}, islight = true},
			},
		},
		[2] = {
			sleep = 400,
			sound = "police-light.mp3",
			locals = {
				[1] = {x = -0.2, y = 0.08, z = 0.36, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[2] = {x = -0.6, y = 0.08, z = 0.36, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[3] = {x = -0.4, y = 0.2, z = 0.36, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[4] = {x = 0, y = 1, z = 1.5, s = 10, color = {255, 0, 0, 255}, islight = true},
				[5] = {x = 0, y = 1, z = 1.5, s = 15, color = {255, 0, 0, 255}, islight = true},
			}
		}
	},

	--PCESP - GARRA
	[490] = {
		[1] = {
			sleep = 400,
			sound = "police-light.mp3",
			locals = {
				[1] = {x = 0.2, y = 0.35, z = 0.18, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[2] = {x = -0.9, y = 0.35, z = 0.18, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[3] = {x = 0, y = 0.48, z = 0.18, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[4] = {x = -0.7, y = 0.48, z = 0.18, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[5] = {x = 0, y = 0, z = 1.5, s = 10, color = {255, 0, 0, 255}, islight = true},
				[6] = {x = 0, y = 0, z = 1.5, s = 15, color = {255, 0, 0, 255}, islight = true},
			},
		},
		[2] = {
			sleep = 400,
			sound = "police-light.mp3",
			locals = {
				[1] = {x = -0.2, y = 0.53, z = 0.18, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[2] = {x = -0.6, y = 0.53, z = 0.18, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[3] = {x = -0.4, y = 0.63, z = 0.18, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[4] = {x = 0, y = 1, z = 1.5, s = 10, color = {255, 0, 0, 255}, islight = true},
				[5] = {x = 0, y = 1, z = 1.5, s = 15, color = {255, 0, 0, 255}, islight = true},
			}
		}
	},

	--ROCAM
	[523] = {
		[1] = {
			sleep = 400,
			sound = "police-light.mp3",
			locals = {
				[1] = {x = -0.2, y = -0.5, z = 0.18, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				--[5] = {x = 0, y = -2, z = 1.5, z = 0.18, s = 10, color = {255, 0, 0, 255}, islight = true},
				--[6] = {x = 0, y = -2, z = 1.5, z = 0.18, s = 15, color = {255, 0, 0, 255}, islight = true},
			},
		},
		--[[[2] = {
			sleep = 400,
			sound = "police-light.mp3",
			locals = {
				[1] = {x = -0.2, y = 0.58, z = 0.18, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[2] = {x = -0.6, y = 0.58, z = 0.18, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				[3] = {x = -0.4, y = 0.65, z = 0.18, s = 0.2, color = {255, 0, 0, 255}, islight = false},
				--[4] = {x = -0.2, y = 3.15, z = -0.95, s = 0.1, color = {200, 0, 0, 255}, islight = false},
				[4] = {x = 0, y = 1, z = 1.5, s = 10, color = {255, 0, 0, 255}, islight = true},
				[5] = {x = 0, y = 1, z = 1.5, s = 15, color = {255, 0, 0, 255}, islight = true},
			}
		}]]
	},

}

addEvent("getVehiclesLightData", true)
addEventHandler("getVehiclesLightData", getRootElement(), 
function(vdata)
	triggerClientEvent(source, "sendVehiclesLightData", source, giroflexLocals)
end
)

addEvent("setVehicleLightStatus", true)
function setLightStatus(vh, isative, gtype)
	if type(isative) == "boolean" then
		local data
		local vmodel = getElementModel(vh)
		if isative then
			local color1, color2, color3 = getVehicleHeadLightColor(vh)
			giroflex[vh] = {vehicle = vh, status = isative, giroflex = gtype, model = vmodel, sound_status = false, alert_status = false, alert_value = 1, alert_backup = {color1, color2, color3}}
			gac[vh] = 1
			data = {[1] = giroflex[vh], [2] = giroflexLocals[vmodel], [3] = gac[vh]}
		else
			data = {[1] = giroflex[vh], [2] = giroflexLocals[vmodel], [3] = gac[vh]}
			giroflex[vh] = false
			gac[vh] = false
			data = false
			started[vh] = false
		end
		for i, p in ipairs(getElementsByType("player")) do
			if isative then
				triggerClientEvent(p, "sendVehicleGiroflexData", p, data)
			else
				triggerClientEvent(p, "removeVehicleGiroflexData", p, data)
			end
		end
	end
end
addEventHandler("setVehicleLightStatus", getRootElement(), setLightStatus)

addEvent("setVehicleLightSpeedChange", true)
function setLightSpeedChange(vh, gtype)
	local exists = (vh and vh ~= nil and isElement(vh))
	if type(gtype) == "number" then
		if exists then
			if giroflex[vh] then
				giroflex[vh].giroflex = gtype
			end
		end
	end
end
addEventHandler("setVehicleLightSpeedChange", getRootElement(), setLightSpeedChange)

addEvent("setVehicleSoundStatus", true)
function setVehicleSoundStatus(vh, status)
	local exists = (vh and vh ~= nil and isElement(vh))
	if type(status) == "boolean" then
		if exists then
			if giroflex[vh] then
				giroflex[vh].sound_status = status
			end
		end
	end
end
addEventHandler("setVehicleSoundStatus", getRootElement(), setVehicleSoundStatus)

addEvent("setVehicleAlertStatus", true)
function setVehicleAlertStatus(vh, status)
	local exists = (vh and vh ~= nil and isElement(vh))
	if type(status) == "boolean" then
		if exists then
			if giroflex[vh] then
				giroflex[vh].alert_status = status
				setVehicleOverrideLights(vh, 2 )
			end
		end
	end
end
addEventHandler("setVehicleAlertStatus", getRootElement(), setVehicleAlertStatus)

local updating = false
function lightOutPut()
	if giroflex and gac and not updating then
		for id,value in pairs(giroflex) do
			local exists = (value and value.vehicle ~= nil and value.status == true and isElement(value.vehicle)) or false
			if exists and not (started[value.vehicle] and value.status == true) then
				started[value.vehicle] = true
				local vid = giroflexLocals[value.model] or false
				if vid then
					local vgac = gac[value.vehicle]
					local sleep = math.round(vid[vgac].sleep / value.giroflex)
					started[value.vehicle] = true
					setTimer(function(giroflexValue, giroflexLocal)
						if (giroflexValue and giroflexValue.vehicle ~= nil and giroflex[giroflexValue.vehicle] and giroflexValue.status == true and isElement(giroflexValue.vehicle)) and giroflexLocal and not updating then
							vgac = gac[giroflexValue.vehicle] + 1
							if vgac > table.size(vid) then
								vgac = 1
							end
							gac[giroflexValue.vehicle] = vgac
							if giroflexValue and giroflexValue.alert_value then
								local vac = giroflexValue.alert_value + 1
								if vac > 2 then 
									vac = 1
								end
								giroflex[giroflexValue.vehicle].alert_value = vac
								giroflexValue.alert_value = vac
							end
							for i, p in ipairs(getElementsByType("player")) do
								triggerClientEvent(p, "updateVehicleGiroflexData", p, {[1] = giroflexValue, [2] = giroflexLocal, [3] = vgac})
							end
							started[giroflexValue.vehicle] = false
						end
					end
					, sleep, 1, value, vid)
				else
					started[value.vehicle] = false
				end
			elseif not exists then
				updating = true
				local gb = giroflex
				local bgac = gac
				local modelslight = {}
				giroflex = {}
				gac = {}
				local data = {}
				for id,value in pairs(gb) do
					local exists = (value and value.vehicle ~= nil and isElement(value.vehicle)) or false
					if exists then
						local vh = value.vehicle
						giroflex[vh] = {vehicle = vh, status = true, giroflex = value.giroflex, model = value.model}
						gac[vh] = bgac[vh]
						modelslight[vh] = giroflexLocals[value.model]
					end
				end
				data = {giroflex, modelslight, gac}
				for i, p in ipairs(getElementsByType("player")) do
					triggerClientEvent(p, "updateVehiclesGiroflexDatas", p, data)
				end
				updating = false
			end
		end
	end
end
setTimer(lightOutPut, 100, 0)

function math.round(number)
    return number - number % 1
end

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end