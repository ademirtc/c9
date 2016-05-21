require_relative '../../app/models/sensor_process.rb'
require_relative '../../app/models/sensor.rb'
require_relative '../../app/models/color_process.rb'
require 'json'

describe SensorProcess do
    before :each do
        @sp = SensorProcess.new
    end
    it "should create an instance of Hash when calling the method get_sensors()" do
        @sp.get_sensors()
        expect(@sp.obj).to be_instance_of(Hash)
    end
    
    it "should correctly assign to w the value obtained from the list of sensors when using method initialize_variables()" do
        @sp.get_sensors()
        @sp.initialize_variables()
        expect(@sp.w).to eq(@sp.obj["width"])
    end
    
    it "should assign -23.48 to the value of latitute of the first sensor when using mock data" do
        @sp.get_sensors()
        @sp.initialize_variables()
        expect(@sp.sensor_list[0][0].latitude).to eq(-23.48) 
    end
    
    it "should assign to minLat the value -23.64 when using mock data" do
        @sp.get_sensors()
        @sp.initialize_variables()
        expect(@sp.minLat).to eq(-23.64) 
    end
    
    it "should assign to maxLng the value -46.53 when using mock data" do
        @sp.get_sensors()
        @sp.initialize_variables()
        expect(@sp.maxLng).to eq(-46.53) 
    end
    
    it "should assign to scaledW the value 49 when using mock data and the default parameters" do
        @sp.get_sensors()
        @sp.initialize_variables()
        @sp.compute_map_coordinates()
        expect(@sp.scaledW).to eq(6*8+1) 
    end
    
    it "should assign to scaledW the value 31 when using mock data and the default parameters" do
        @sp.get_sensors()
        @sp.initialize_variables()
        @sp.compute_map_coordinates()
        expect(@sp.scaledH).to eq(6*5+1) 
    end
    
    it "should assign to scaledW the value 31 when using mock data and the default parameters" do
        @sp.get_sensors()
        @sp.initialize_variables()
        @sp.compute_map_coordinates()
        expect(@sp.scaledH).to eq(6*5+1) 
    end
    
    it "should assign to scaledW the value 31 when using mock data and the default parameters" do
        @sp.get_sensors()
        @sp.initialize_variables()
        @sp.compute_map_coordinates()
        expect(@sp.scaledH).to eq(6*5+1) 
    end
    
    it "should assign to intensityMap[0][0].latitude the value of the latitude of the first sensor read" do
        @sp.get_sensors()
        @sp.initialize_variables()
        @sp.compute_map_coordinates()
        expect(@sp.intensityMap[0][0].latitude).to eq(@sp.sensor_list[0][0].latitude) 
    end
    
    it "should return an instance of a Hash when calling the method sensor_to_hash()" do
        s = DrawableSensor.new(0, 1, 0, 0, "", 1, 1, [0, 100, 100])
        hash = @sp.sensor_to_hash(s)
        expect(hash).to be_instance_of(Hash)
    end
end