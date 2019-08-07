function Update()
	timeMeasure = SKIN:GetMeasure("MeasureTime")
	time = timeMeasure:GetValue()
	for i=0,11 do
		if (time < (i+1)*100) and (time > i*100) then
			filepath = "#@#images\\" .. i .. ".png"
			SKIN:Bang("!SetWallpaper", filepath, "Fill")	
		end
	end
end
