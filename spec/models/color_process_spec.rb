require_relative '../../app/models/sensor_process.rb'
require_relative '../../app/models/sensor.rb'
require_relative '../../app/models/color_process.rb'

describe ColorProcess do
    before :each do
        @s1 = DrawableSensor.new(0, 1, -23.45, -46.8, "", 1, 1, [0, 100, 100])
        @s2 = DrawableSensor.new(1, 1, -23.5, -46.85, "", 1, 0.8, [0, 80, 50])
        @s3 = DrawableSensor.new(2, 1, -23, -46.9, "", 1, 0.6, [60, 100, 50])
        @s4 = DrawableSensor.new(3, 1, -28.5, -47, "", 1, 0.4, [120, 100, 50])
        @cp = ColorProcess.new
    end
    
    it "returns a hash" do
        frac1 = 0
        frac2 = 0
        interpolated = @cp.interpolate(@s1, @s2, @s3, @s4, frac1, frac2)
        expect(interpolated).to be_instance_of(Hash)
    end
    
    it "returns the color of @s1 when frac1 = 0 = frac2" do
        frac1 = 0
        frac2 = 0
        interpolated = @cp.interpolate(@s1, @s2, @s3, @s4, frac1, frac2)
        expect(interpolated[:color]).to eq(@s1.color)
    end
    
    it "returns the opacity of @s1 when frac1 = 0 = frac2" do
        frac1 = 0
        frac2 = 0
        interpolated = @cp.interpolate(@s1, @s2, @s3, @s4, frac1, frac2)
        expect(interpolated[:opacity]).to eq(@s1.opacity)
    end
    
    it "returns the color of @s2 when frac1 = 0 and frac2 = 1" do
        frac1 = 0
        frac2 = 1
        interpolated = @cp.interpolate(@s1, @s2, @s3, @s4, frac1, frac2)
        expect(interpolated[:color]).to eq(@s2.color)
    end
    
    it "returns the average color between @s1 and @s2 for the L channel when frac1 = 0 and frac2 = 0.5" do
        frac1 = 0
        frac2 = 0.5
        interpolated = @cp.interpolate(@s1, @s2, @s3, @s4, frac1, frac2)
        expect(interpolated[:color][2]).to eq(frac2*@s2.color[2] + (1-frac2)*@s1.color[2])
    end
    
    it "returns the weighted color between @s1 and @s2 for the S channel when frac1 = 0 and frac2 = 0.25" do
        frac1 = 0
        frac2 = 0.25
        interpolated = @cp.interpolate(@s1, @s2, @s3, @s4, frac1, frac2)
        expect(interpolated[:color][1]).to eq(frac2*@s2.color[1] + (1-frac2)*@s1.color[1])
    end
    
    it "returns the weighted color between @s1 and @s3 for the H channel when frac1 = 0.75 and frac2 = 0" do
        frac1 = 0.75
        frac2 = 0
        interpolated = @cp.interpolate(@s1, @s2, @s3, @s4, frac1, frac2)
        expect(interpolated[:color][0]).to eq(frac1*@s3.color[0] + (1-frac1)*@s1.color[0])
    end
    
    it "returns the average opacity of all 4 sensors when frac1 = 0.5 and frac2 = 0.5" do
        frac1 = 0.5
        frac2 = 0.5
        interpolated = @cp.interpolate(@s1, @s2, @s3, @s4, frac1, frac2)
        expect(interpolated[:opacity]).to eq((@s1.opacity+@s2.opacity+@s3.opacity+@s4.opacity)/4)
    end
end