--[[
Adapted From: https://www.gammon.com.au/forum/?id=13938
Big big thanks to this guy. Lua apparently doesn't have a way to check if files exist
natively and my knowledge of lua functions is somewhat lacking
]]--
function osexecute(cmd)
   local n = path .. "tempFile.txt"
   cmd = cmd .. " > \"" .. n .. "\""
   local err = os.execute(cmd)
   local messages = {}
   for line in io.lines(n) do
      table.insert(messages, line)
   end
   os.remove(n)
   return err, messages
end

function scanImages()
	local cmd = 'dir "' .. imagePath .. '" /b'
	local err,msg = osexecute(cmd)
	return msg
end

function fileExists(name) 
	for k,v in next, images do
		if name == v then
			return true
		end
	end
	return false
end

function Initialize()
	path = SKIN:GetVariable("Path", "n/a"):gsub("\\", "/")
	imagePath = path .. "images"
	images = scanImages()
end

function Update()
	timeMeasure = SKIN:GetMeasure("MeasureTime")
	time = timeMeasure:GetValue()
	
	currentFile = ""

	for i=0,1100 do
		if i > time then break end
		local tempFile = i .. ".png"
		if fileExists(tempFile) then
			currentFile = tempFile
		end
	end

	if fileExists(currentFile) then
		filepath = "#@#images\\" .. currentFile
		SKIN:Bang("!SetWallpaper", filepath, "Fill")
	end
end
