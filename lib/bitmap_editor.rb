class BitmapEditor
	
	class Bitmap 
		attr_reader :x, :y, :image

		def initialize(x, y)
			@x = x.to_i
			@y = y.to_i
			@image = []
			@y.times do 
				@image << Array.new(@x, 0)
			end 
		end

		def bounds?(x, y)
    		x <= @width && y <= @height
  		end

	end # class Bitmap end

	class Draw

		def initialize(bitmap)
			@bitmap = bitmap.image 
			@bitmap_instance = bitmap
		end 

		def normalize_params(x=nil, y=nil, color=nil, from=nil, to=nil)
			# setting params as class vars and 0 indexing coordinates
			if !x.nil? 
				@x = x.to_i 
				@x -= 1 if @x >= 1
			end 
			if !y.nil?
				@y = y.to_i 
				@y -= 1 if @y >= 1
			end 	
			@color = color  if !color.nil?
			if !from.nil?
				@from = from.to_i 
				@from -= 1 if @from >= 1
			end 
			if !to.nil?
				@to = to.to_i 
				@to -= 1 if @to >= 1
			end 
		end 

		def valid_coordinates?(x, y)
			x <= @bitmap_instance.x && y <= @bitmap_instance.y
		end 

		def new_image
			new_image = []
			@bitmap_instance.y.times do 
				new_image << Array.new(@bitmap_instance.x, 0)
			end 
			@bitmap = new_image
		end 

		def one_pixel(x, y, color)
			normalize_params(x, y, color, from=nil, to=nil)
			if !valid_coordinates?(@x, @y)
				puts "ERROR: unable to execute command L. Coordinates out of range"
				return 
			end
			return @bitmap[@y][@x] = @color 
		end 

		def vertical_line(y, from, to, color)
			normalize_params(x=nil, y, color, from, to)
			@bitmap.each_with_index.map  do |row, i|
			  if i >= @from && i <= @to 
			    row[@y] = @color
			  end 
			end 
		end 

		def horizontal_line(from, to, y, color)
			normalize_params(x=nil, y, color, from, to)
			@bitmap.each_with_index.map do |row, i|
				if i == @y 
					row.each_with_index.map do |elem, i| 
						if i >= @from && i <= @to 
							row[i] = @color
						end
					end 
				end 
			end 
		end 

		def bitmap_image
			@bitmap.each do |row|
				puts row.join(",").gsub('"', '').gsub(/[\s,]/ ,"")
			end
		end 

	end # class Draw end

	def normalize_line(line)
		line = line.chomp
		if !line.nil? || !line.empty? 
			if line.length > 1
				line.gsub!(/\s+/, "") 
			else 
				line
			end 
		end
	end
	

	def run(file)
		return puts "please provide correct file" if file.nil? || !File.exists?(file)

		File.open(file).each_with_index do |line, i|
			line = normalize_line(line)

			return "ERROR: Please create a bitmap image first" if i == 0 && line[0] != 'I'
	
			case line[0] 
			when 'I'
				# draw the table and instantiate the draw class
				bitmap = Bitmap.new(line[1],line[2])
				@draw = Draw.new(bitmap)
			when 'C'
				@draw.new_image
			when 'L'
				@draw.one_pixel(line[1], line[2], line[3])
			when 'V'
				@draw.vertical_line(line[1], line[2], line[3], line[4])
			when 'H'
				@draw.horizontal_line(line[1], line[2], line[3], line[4])
			when 'S'
				@draw.bitmap_image
			else
				puts 'unrecognised command :('
			end
		end



	end

	
	
end # class end

be = BitmapEditor.new 
be.run('/Users/iainwatt/CodeTests/Carwow/bitmap_editor-master/examples/test.txt')
# be.test()



# ================================================== FEEDBACK ================================================== #
# Main error was insufficient testing, successful candidates had 20 tests 
# - Misses a lot of simple cases (doesn't reject 0 coordinates, the H command doesn't seem to work at all)
# - Allows lower case letters as colours
# - Allows multiple characters as colours (just takes first character)
# - Allows co-ordinates outside of canvas as valid (eg 0,0)
# - Incorrectly parses input (allows numbers as colours)
# + It does have a nice integration test using an example file, but no other unit tests at all
# CONCLUSION: Write 10+ unit tests and more integration tests 
#
# Other Issues 
# - Code is quite hard to follow
# - Left in a line for testing which causes it to always print an error before running
# - The Draw class is quite hard to follow (it tries to normalise all possible variants of inputs which makes 
#   understanding  what all the variables are in different cases quite tricky)
# - Incorrectly handles co-ordinates
# - Default pixel colour should be O (capital letter o) not zero
# - Several classes in same file Input validation is dispersed and awkward
# + has separated classes out which is good
#
# CONCLUSION
# 1. Lack of comments in code caused problems 
# 2. Sloppyness - caused issues with leaving line to run, not setting default color correctly and 
#    incorrectly handling co-ordinates
# 3. Style issues like classes in the same file need explained 
#
# ================================================== FEEDBACK ================================================== #




Left in a line for testing which causes it to always print an error before running
The Draw class is quite hard to follow (it tries to normalise all possible variants of inputs which makes understanding what all the variables are in different cases quite tricky)
It does have a nice integration test using an example file, but no other unit tests at all
Incorrectly handles co-ordinates




Default pixel colour should be O (capital letter o) not zero
Several classes in same file Input validation is dispersed and awkward 