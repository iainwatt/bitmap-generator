require 'bitmap_editor.rb'
RSpec.describe BitmapEditor do
    @@bitmap_editor = BitmapEditor.new 

    describe "#run" do
        
        it "should error when 'I' is not the first command" do 
            File.open("example.txt", "w+") do |f|     
                f.write("L 1 2 3 W")   
            end
            response = @@bitmap_editor.run('./example.txt')
            expect(response).to eq("ERROR: Please create a bitmap image first")
        end

    end

    File.open("example.txt", "w+") do |f|     
        f.write("I 5 6\nL 9 9 A")   
    end
    specify { expect { @@bitmap_editor.run('./example.txt') }.to output.to_stdout }

    after(:each) do 
        File.delete('./example.txt')
    end 

end