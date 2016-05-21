require_relative '../../app/models/sensor.rb'
require 'json'
 
describe Sensor do
 
before :each do
 @sensor = Sensor.new("1",35,"22.0","30.55","temperature","15")
 @dsensor= DrawableSensor.new("1",35,"22.0","30.55","temperature","15",1)  
end

 describe "#new" do
    it "takes six parameters and returns a Sensor object" do
     
      expect(@sensor).to be_an_instance_of(Sensor)
      expect(@sensor.value).to eq(35)
      expect(@sensor.type).to eq('temperature')
      expect(@sensor.radius).to eq('15')
    end
  end
 describe "#new" do
    it "takes seven parameters and returns a DrawableSensor object" do
      expect(@dsensor).to be_an_instance_of(DrawableSensor)
      expect(@dsensor.visit).to eq(false)
      expect(@dsensor.opacity).to eq(1)
      expect(@dsensor.color).to eq(nil)
    end
  end

  describe "#setColor" do
   it "Calculates the color depending on the proximity to the boundaries " do
   tabBounds=JSON.parse(File.read("app/assets/dataInput/boundSensor"))
   @dsensor.setColor(tabBounds)
   expect(@dsensor.color).to eq('255,255,0')
   end
 end
 describe "#to_json" do
   it "convert a objet to string json style" do
   tabBounds=JSON.parse(File.read("app/assets/dataInput/boundSensor"))
   @dsensor.setColor(tabBounds)
   expect(@dsensor.to_json).to eq('{id:1,latitude:22.0,longitude:30.55,radius:15,color:255,255,0,opacity:1}')
   end
 end

end
