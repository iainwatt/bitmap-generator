class BitmapEditor
  @@image_array
  
  def create_image(cols, rows)
    num = 0
    image_array = []
    # do this at start
    rows = rows.to_i
    cols = cols.to_i
    rows.times do 
      image_array << Array.new(cols, 0)
    end 
    @@image_array = image_array
  end

  def color_pixel(col, row, color)
    row = row.to_i 
    col = col.to_i
    col -= 1 
    row -= 1
    @@image_array[row][col] = color 
    return @@image_array
  end 

  def draw_vertical(col, row_from, row_to, color)
    col = col.to_i 
    row_from = row_from.to_i 
    row_to = row_to.to_i
    col -= 1  
    @@image_array.each_with_index.map  do |row, i|
      i += 1
      if i >= row_from && i <= row_to 
        row[col] = color
      end 
    end 
    return @@image_array
  end 

  def draw_horizontal(col_from, col_to, drawable_row, color)
    drawable_row = drawable_row.to_i 
    col_from = col_from.to_i 
    col_to = col_to.to_i
    drawable_row -= 1
    col_from -= 1 
    col_to -= 1  
    @@image_array.each_with_index.map do |row, i|
      if i == drawable_row 
        row.each_with_index.map do |elem, i| 
          if i >= col_from && i <= col_to 
            row[i] = color
          end
        end 
      end 
    end 
    return @@image_array
  end 

  def show_image()
    @@image_array.each do |row|
      puts row.join(",").gsub('"', '').gsub(/[\s,]/ ,"")
    end
  end

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

  
end # class end

be = BitmapEditor.new 
be.run('/Users/iainwatt/Downloads/bitmap_editor-master/examples/test.txt')

