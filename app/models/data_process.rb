require_relative 'quad_process.rb'
require_relative 'sensor.rb'
require 'rquad'
require 'json'
class DataProcess 
   
     
    
     attr_accessor :sensors
    def initialize 
    end
    def loadSensor
        # Here the query  for sensors is processed , that are within radius for consultation.
        # for now only is charged with static JSON data
        # For second sprint add query with (latitude,longitude,radius)
        jsensors= JSON.parse(File.read("app/assets/dataInput/jsonIn"))
	    tabBounds=JSON.parse(File.read("app/assets/dataInput/boundSensor"))
        # File.open('salida.txt', 'w') do |f2|    
             @sensors=jsensors['data'].each do 
                  |s| 
                  DrawableSensor.new(s["id"],s["value"],s["latitude"],s["longitude"],s["type"],s["radius"],1).setColor tabBounds
                #  |s|  sensor=DrawableSensor.new(s["id"],s["value"],s["latitude"],s["longitude"],s["type"],s["radius"]) 
                # str= sensor.id.to_s + sensor.value.to_s + sensor.type.to_s + sensor.color.to_s
                # f2.puts(str)
             end
        
       
    end
    
    
    def processSensors
        # Processes the intersection of sensors and gets the points to draw on the map 
        intersections = QuadProcess.new(-180,180,-90,90,3);
        #intersections.setData(@sensors)
        intersections.setRandomData
        intersections.process;
        intersections.to_json;
    end
end


