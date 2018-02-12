
#!/usr/bin/ruby
###############################################################
#
# CSCI 305 - Ruby Programming Lab
#
# Brandon O'Brien
# brandonhobrien@gmail.com
# 11 Feb 2018
#
###############################################################

$bigrams = Hash.new # The Bigram data structure
$name = "Brandon O'Brien"

# method to clean the song title
def cleanup_title(title)
	title = title.gsub(/.*>/, '')
	title = title.gsub(/\(.*|\[.*|\{.*|\\.*|\/.*|_.*|-.*|:.*|\".*|\'.*|\+.*|\=.*|\feat..*/,'')
	title = title.gsub(/[?¿!¡.;&@%#|]/, '')
	if/[^\x00-\x7F]/.match(title)
	else
		title = title.downcase
		return title
	end
end

# method to convert a string into an array
def convertToArray(title)
		if/[^' ']/.match(title)
			words = title.split
			#p words # prints arrays populated with song title
			return words
		end
end

# takes in an array, concatinates the words and then inputs them into a Hash
# tests to see if concatinated string is already in hash or not
# if it is, 1 is added to the current value
# else a new item in the hash is created with a value of 1
def concat(array)
	if array.length > 1
		i = 1
		while i < array.length do
			temp = array[i-1]+ " " +array[i]
			#----------------------------------
			if value = $bigrams[temp]
				$bigrams[temp] += 1
			else
			$bigrams[temp] = 1
			#----------------------------------
		end
			i = i + 1
			#p temp # -prints concatinated strings of song titles
		end
	else
		#p array[0] # -prints string of song title with just one word
		#----------------------------------
		if value = $bigrams[array[0]]
			$bigrams[array[0]] += 1
		else
		$bigrams[array[0]] = 1
		#----------------------------------
	end
end
end

# prints most common word to come before and after a given word
def mcw(word)
beginword = word + " "
#endword = " " + word
puts "Searching: " + word
#-----------------------------------------------------------------
if value = $bigrams.select { |key, value| key.start_with? beginword}
	puts "Most used phrase starting with " + word + " was:"
	p value.max_by{|k,v| v}[0]
	p value.max_by{|k,v| v}[1]
	valuetest = value.max_by{|k,v| v}[0]
	returnValue = valuetest.gsub(/.*\s/, '')

	p returnValue
	return returnValue
else
	puts "Error, #{item} not found!"
end
#-----------------------------------------------------------------
# determines most common word to come before word given
#if value = $bigrams.select { |key, value| key.end_with? endword}
#	puts "Most used phrase ending with " + word + " was:"
#	puts value.max_by{|k,v| v}
#else
#	puts "Error, #{item} not found!"
#end
#-----------------------------------------------------------------

end

# function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "

	begin
		IO.foreach(file_name) do |line|
			# clean the song title
			title = cleanup_title(line)
			# converts string into array
			array = convertToArray(title)
			if array != nil
				concat(array)
			end
		end
		#-----------------------------------------------------------------
		# item value tests to see how many "this set of 1 or 2 words" is in the hash
		# need to place before of after when testing end_with or begin_ with respectively
		#item = "love "
		# if loop to seach a hash. value is set to the item,
		# if the item is not in the Hash, value gets set to null and if loop is false
		# can use start_with to search begining of string and end_with to each end
		#-----------------------------------------------------------------
		#if value = $bigrams.select { |key, value| key.start_with? item}
			#puts value.max_by{|k,v| v}
  		#puts "#{item}, #{value}"
		#else
  		#puts "Error, #{item} not found!"
		#end
		#-----------------------------------------------------------------
		#love = "love"
		#mcw(love)

		puts "Finished. Bigram model built.\n"
	rescue
		STDERR.puts "Could not open file"
		exit 4
	end
end

# Executes the program
def main_loop()
	puts "CSCI 305 Ruby Lab submitted by #{$name}"

	if ARGV.length < 1
		puts "You must specify the file name as the argument."
		exit 4
	end

	# process the file
	process_file(ARGV[0])
	# Get user input
end

if __FILE__==$0
	main_loop()
end
