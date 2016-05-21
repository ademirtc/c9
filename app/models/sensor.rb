class Sensor
  attr_accessor :id
  attr_accessor :latitude
  attr_accessor :longitude
  attr_accessor :value
  attr_accessor :radius
  attr_accessor :type
  
    def initialize id,value,latitude,longitude,type,radius
       @id = id
       @latitude = latitude
       @longitude = longitude
       @value = value
       @type=type
       @radius=radius
    end
    
end


class DrawableSensor < Sensor
     attr_accessor :color
     attr_accessor :opacity
     attr_accessor :visit
     
    def initialize id,value,latitude,longitude,type,radius,opacity,color=nil
        # Initializes the attributes for the instance and sends a message to calculate the corresponding color
        #Additionally load a JSON file with limits for color scale depending on the type of sensor (Type of sensor: humedity ,temperature,airquality,indexuv)
        super id,value,latitude,longitude,type,radius
          @opacity =opacity
          @visit=false
          @color=color
    end
    
    def setColor tabBound
        # Calculates the color depending on the proximity to the boundaries of each color for the corresponding type of sensor
        # Select a color
        bounds= tabBound[@type.to_s]
        bound = bounds.select{|e| (e["intervalMin"]<=@value and @value<=e["intervalMax"])}[0]
        
        #  Obtains the weighted average color distance to each limit
        colors1=bound["color1"].to_s.split(",")
        dist1=(@value.abs - bound["intervalMax"].abs).abs
        dist2= (@value.abs - bound["intervalMin"].abs).abs
        colors1.map! { |a| a.to_i * dist2}
        colors2=bound["color2"].split(",")
        colors2.map! { |a| a.to_i * dist1}
        colorR= [colors1,colors2].transpose.map{|arr| arr.inject{|sum, element| (sum+element)/(dist1+dist2)}}
        @color=colorR.map { |i| i.to_s }.join(",")
        
    end
    
    def to_json
       json = "{";
       json += "id:" + @id.to_s
       json += ",latitude:"  + @latitude.to_s
       json += ",longitude:" + @longitude.to_s
       # json += ",value:"   + @value.to_s
       json += ",radius:"    + @radius.to_s
       json += ",color:"     + @color.to_s
       json += ",opacity:"   + @opacity.to_s 
       json += "}"
    end 
end
