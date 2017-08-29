class BitmapEditor

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line
      when 'I'
      when 'C'
      when 'L'
      when 'V'
      when 'H'
      when 'S'
          puts "There is no image"
      else
          puts 'unrecognised command :('
      end
    end
  end

  
end # class end

be = BitmapEditor.new 
be.run()


Program input
The input consists of a file containing a sequence of commands, 
where a command is represented by a single capital letter at the beginning of the line. 
Parameters of the command are separated by white spaces and they follow the command character.
Pixel co-ordinates are a pair of integers: a column number between 1 and 250, and a row number between 1 and 250. 
Bitmaps starts at coordinates 1,1. Colours are specified by capital letters.

There are 6 supported commands:
I M N - Create a new M (rows) x N (cols) image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image

Input 

I 5 6 - Create new image (5 col x 6 row)
L 1 3 A (color) L = color one pixel at certain coordinates
V 2 (column) 3 6 (rows) W (color) V = vertical line 
H 3 5 (cols) 2 (row) Z (color) H = horizontal line 
S

Output

OOOOO
OOZZZ 
AWOOO
OWOOO
OWOOO
OWOOO

command 1: I 5 6 - Create new image (5 col x 6 row) 

00000 
00000
00000
00000
00000
00000

command 2:  L 1 3 A (color) L = color one pixel at certain coordinates

00000 
00000
A0000
00000
00000
00000

command 3: V 2 (column) 3 6 (rows) W (color) V = vertical line  

00000 
00000
AW000
0W000
0W000
0W000

command 4: H 3 5 (between cols) 2 (row) Z (color) H = horizontal line 

00000 
00ZZZ
AW000
0W000
0W000
0W000