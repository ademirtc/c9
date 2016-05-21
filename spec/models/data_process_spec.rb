require_relative '../../app/models/sensor.rb'
require_relative '../../app/models/data_process.rb'
require 'json'
require 'rquad'
describe DataProcess do
include RQuad
before :each do
 @dataProcess = DataProcess.new
end

 describe "#new" do
    it "returns a DataProcess object" do
      expect(@dataProcess).to be_an_instance_of(DataProcess)
      expect(@dataProcess.sensors).to eq(nil)
    end
  end

# file not found but on aplication are found 
describe "#loadSensor" do
    it "load a data for sensors"  do
      @dataProcess.loadSensor
      expect(@dataProcess.sensors.size).not_to be(nil)
   end
end


describe "#processSensors" do
    it "process data from sensors"  do

      result=@dataProcess.processSensors
      expect(result).not_to be(nil)
   end
end


end