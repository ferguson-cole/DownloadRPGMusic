#download_rpg_music.rb
#!/usr/bin/ruby

def format_duration(quantity, unit)
	# ffmpeg accepts the following syntaxes for time:
	# [HH:]MM:SS[.m...], HH is hours, MM is minutes, SS is seconds
	# S+, where S expresses the number of seconds
	# Here I utilize the former, as it better suits my needs
	case unit
	when "h","hour","hours"
		return quantity.to_s + ":00:00"
	when "m","min","minute","minutes"
		return quantity.to_s + ":00"
	when "s","sec","second","seconds"
		return "00:" + quantity.to_s
	end
end


# Argument validation and parsing:
if ARGV.length <= 0
	puts "Insufficient number of arguments provided ("+ARGV.length.to_s+"), exiting..."
	return 1

elsif ARGV.length == 1
	# Format (full video): dl_rpg_music.rb https://youtu.be/3Fzi4lBzqIg
	url = ARGV[0]
	duration = nil

elsif ARGV.length == 2
	# Format (one minute): dl_rpg_music.rb https://youtu.be/3Fzi4lBzqIg 00:01:00.00
	url = ARGV[0]
	duration = ARGV[1]

elsif ARGV.length == 3
	# Format (five minutes): dl_rpg_music.rb https://youtu.be/3Fzi4lBzqIg 5 minutes
	url = ARGV[0]
	duration = format_duration(ARGV[1], ARGV[2])

end

# Download the video using Youtube-DL
download_cmd = "youtube-dl " + ARGV[0]
puts "Downloading video from Youtube..."
dl_output = `#{download_cmd}`
puts "Download complete."
# Initialize file variable
file = nil

if dl_output.include? "[ffmpeg]"
	# Isolate the [ffmpeg] line of the youtube-dl output
	file = dl_output.split("[ffmpeg]").last
	# Use regex to further isolate the resultant filename (whole match -> index 0)
	file = file.match(/"([^"]*)"/)[0]
end

new_file = file

# Convert the video using ffmpeg
if file != nil
	# Isolate the file name (group 0 -> index 1)
	new_file = file.match(/(.*)\./)[1]
	# Append the desired file extension (I'm using this to download VTT music so I default to .ogg)
	# Convert from array to str
	# new_file = new_file.join('')
	# TODO add custom file extension selection

	return unless new_file != nil

	new_file << ".ogg\""
	puts "Converting via ffmpeg..."
	# Here we use ffmpeg with the loglevel flag set so we get less output (less verbose)
	convert_cmd = "ffmpeg -loglevel warning -i #{file} -t #{duration} #{new_file}"
	ffmpeg_output = `#{convert_cmd}`
	puts "Conversion complete. Output file: " << new_file

	# Remove the original file
	puts "Removing pre-conversion file..."
	rm_cmd = "rm #{file}"
	`#{rm_cmd}`
	puts "Pre-conversion file removed."
else
	puts "Could not extract filename from youtube-dl output, exiting..."
	return 1
end



