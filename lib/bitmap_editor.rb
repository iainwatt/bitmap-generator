class BitmapEditor
  
  def create_image(cols, rows)
    num = 0
    image_array = []
    rows.times do 
      image_array << Array.new(cols, 0)
    end 
    return image_array
  end

  def color_pixel(image_array, row, col, color)
    col -= 1 
    row -= 1
    image_array[row][col] = color 
    return image_array
  end 

  def draw_vertical(image_array, col, row_from, row_to, color)
    col -= 1  
    image_array.each_with_index.map  do |row, i|
      i += 1
      if i >= row_from && i <= row_to 
        row[col] = color
      end 
    end 
    return image_array
end 

def draw_horizontal(image_array, drawable_row, col_from, col_to, color)
  drawable_row -= 1
  col_from -= 1 
  col_to -= 1  
  image_array.each_with_index.map do |row, i|
    if i == drawable_row 
      row.each_with_index.map do |elem, i| 
        if i >= col_from && i <= col_to 
          row[i] = color
        end
      end 
    end 
  end 
  return image_array
end 

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    


    File.open(file).each do |line|
      line = line.chomp
      # p line
      # p line.class
      # p line[0]
      case line[0]
      when 'I'
        p line 
        # draw the table 
      when 'C'
        p line 
        # redraw the table setting all elements to white 
      when 'L'
        p line 
        # color one pixe;
      when 'V'
        p line 
        # draw a vertical line 
      when 'H'
        p line 
        # draw a horizontal line 
      when 'S'
          puts "There is no image"
      else
          puts 'unrecognised command :('
      end
    end
  end

  
end # class end

be = BitmapEditor.new 
be.run('/Users/iainwatt/Downloads/bitmap_editor-master/examples/test.txt')


