require_relative 'sensor.rb'
require 'rquad'

class QuadProcess
    include RQuad
    
    attr_accessor :qtree
    attr_accessor :numNodes
    attr_accessor :resultQTree
      
  def initialize (minLongitude,maxLongitude,minLatitude,maxLatitude,numFeatures)
    @qtree = QuadTree.new(Vector.new(-180, 90), Vector.new(180, -90)) 
    @resultQTree = QuadTree.new(Vector.new(-180, 90), Vector.new(180, -90)) 
    @numFeatures = numFeatures;
    @numNodes = 0;
  end  
  
  def setData (data) 
     data.each{ |obj|
         @qtree.add(QuadTreePayload.new(Vector.new(obj.longitude,obj.latitude),obj))    		
         @numNodes = @numNodes + 1
      }
  end 
  
  def setRandomData   
     longRandom = 50; # query bounds Quadtree
     latiRandom = 20; # query bounds Quadtree
     radiusDefault = 20; # default radius     
     colors = [[255,0,0],[255,255,0],[0,255,0]]
     35.times{
        longitude = Random.rand(-longRandom..longRandom)
        latitude  = Random.rand(-latiRandom..latiRandom)
        aDrawSensor = DrawableSensor.new(0,0,latitude,longitude,0,radiusDefault,0.5)
        aDrawSensor.color = colors[Random.rand(0..2)]
        @qtree.add(QuadTreePayload.new(Vector.new(longitude,latitude),aDrawSensor))
        @numNodes = @numNodes + 1
      } 
  end

  def process
     longRandom = 50; # query bounds Quadtree
     latiRandom = 50; # query bounds Quadtree
     radiusDefault = 20; # default radius 
     @qtree.each_payload {
          |point|
          radius       =  point.data.radius
          longitudeMin =  point.data.longitude - radius < -longRandom ? -longRandom : point.data.longitude - radius;
          longitudeMax =  point.data.longitude + radius >  longRandom ?  longRandom : point.data.longitude + radius
          latitudeMin  =  point.data.latitude - radius < -latiRandom  ? -latiRandom : point.data.latitude - radius
          latitudeMax  =  point.data.latitude + radius >  latiRandom  ?  latiRandom : point.data.latitude + radius

    	    neighbors = @qtree.payloads_in_region(Vector.new(longitudeMin,latitudeMax),Vector.new(longitudeMax,latitudeMin))
    	    point.data.visit = true

    	    neighbors.each{ |neighbor|
               
    			     if !neighbor.data.visit then
               
                    aDrawSensor = DrawableSensor.new( 0,0,
                                              (point.data.latitude+neighbor.data.latitude)  /2,
                                              (point.data.longitude+neighbor.data.longitude)/2,
                                              0,radiusDefault,0.8)
                    aDrawSensor.color = [point.data.color,neighbor.data.color].transpose.map{|arr| arr.inject{|sum, element| (sum+element)}}
    				        @resultQTree.add(QuadTreePayload.new(Vector.new((point.data.longitude+neighbor.data.longitude)/2,
                                                                    (point.data.latitude+neighbor.data.latitude)/2),
                						                                         aDrawSensor))
    			     end    
    	    }
    	
          newDrawSensor = DrawableSensor.new(0,0,point.data.latitude,point.data.longitude,0,radiusDefault,0.5)
          newDrawSensor.color = point.data.color
          @resultQTree.add(QuadTreePayload.new(Vector.new(point.data.longitude,point.data.latitude),newDrawSensor))
    }        
  end 
  
    def to_json
        json = "{ drawableSensors: [ "
        @resultQTree.each_payload{ |point|
            json += point.data.to_json
            json += ","
      	}
       json = json[0..-2];
       json += "]}"
       json
    end
end
