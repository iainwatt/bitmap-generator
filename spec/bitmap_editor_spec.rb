require 'bitmap_editor.rb'
RSpec.describe BitmapEditor do
    @@bitmap_editor = BitmapEditor.new 

    describe "#create_image" do
        
        it "should return an array" do 
            image_array = @@bitmap_editor.create_image(4, 4)
            # image_array = BitmapEditor.new.create_image(4, 4)
            # expect(1).to eq(1)
            expect(image_array).to be_instance_of(Array)
        end
    end

end