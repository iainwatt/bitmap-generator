class BitmapEditor
	
	class Bitmap 
		attr_reader :width, :x, :image

		def initialize(width, height)
			@width = width
			@height = height
			@image = []
			@height.times do 
				@image << Array.new(@width, 0)
			end 
		end

	end # class Bitmap end

	class Draw

		def initialize(bitmap)
			@bitmap = bitmap
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

		def one_pixel(x, y, color)
			normalize_params(x, y, color, from=nil, to=nil)
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

		def horizontal_line(from, to, width, color)
			normalize_params(x=nil, width, color, from, to)
			# draw_horizontal(col_from, col_to, drawable_row, color)
			# drawable_row = drawable_row.to_i 
			# col_from = col_from.to_i 
			# col_to = col_to.to_i
			# drawable_row -= 1
			# col_from -= 1 
			# col_to -= 1  
			# @@image_array.each_with_index.map do |row, i|
			# 	if i == drawable_row 
			# 		row.each_with_index.map do |elem, i| 
			# 			if i >= col_from && i <= col_to 
			# 				row[i] = color
			# 			end
			# 		end 
			# 	end 
			# end 
			# return @@image_array

		end 

		def bitmap_image
			@bitmap.each do |row|
				puts row.join(",").gsub('"', '').gsub(/[\s,]/ ,"")
			end
		end 

	end # class Draw end
	

	def run(file)
		return puts "please provide correct file" if file.nil? || !File.exists?(file)

		File.open(file).each do |line|
			line = line.chomp

			case line[0]
			when 'I'
				# draw the table 
				line.gsub!(/\s+/, "") 
				create_image(line[1], line[2])
			when 'C'
				# redraw the table setting all elements to white 
				create_image(cols, rows)
			when 'L'
				# color one pixe;
				line.gsub!(/\s+/, "") 
				color_pixel(line[1], line[2], line[3])
			when 'V'
				# draw a vertical line 
				line.gsub!(/\s+/, "") 
				draw_vertical(line[1], line[2], line[3], line[4])
			when 'H'
				# draw a horizontal line 
				line.gsub!(/\s+/, "") 
				draw_horizontal(line[1], line[2], line[3], line[4])
			when 'S'
					show_image()
			else
					puts 'unrecognised command :('
			end
		end



	end

	def test()
		bitmap = Bitmap.new(5,6)
		draw = Draw.new(bitmap.image)
		draw.one_pixel('1', '3', 'A')
		draw.vertical_line('2', '3', '6', 'W')
		draw.bitmap_image
	end 
	
end # class end

be = BitmapEditor.new 
# be.run('/Users/iainwatt/Downloads/bitmap_editor-master/examples/test.txt')
be.test()



