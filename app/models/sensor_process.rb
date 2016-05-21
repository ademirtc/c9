class SensorProcess
    attr_accessor :w, :h, :dist, :minLat, :maxLat, :minLng, :maxLng, :sensor_list, :intensityMap, :scaledW, :scaledH, :obj, :numberPolygons
    
    def create_intensity_map()
        #this method is a general 'recipe' of the algorithm used to create the
        #matrix of colors that will color the map. This algorithm receives the
        #position and quality of the sensors and returns a json containing
        #a dataset with the colors interpolated
        self.get_sensors()
        self.initialize_variables()
        self.compute_map_coordinates()
        self.create_json_intensityMap()
    end
    
    def get_sensors()
        #method used to get the sensors and their values.
        #it will be integrated to the database of the sensors
        #in the next sprints
        json_obj = self.getMockJSON()
        @obj = JSON.parse(json_obj)
    end
    
    def initialize_variables()
        #initialization of the pertinent variables 
        @h = @obj["height"];

        @w = @obj["width"];
        @dist = @obj["dist"];
        
        @numberPolygons = 1440 #how many squares we will draw in the screen
    
        @sensor_list = Array.new(h)
        for i in 0...@h
          @sensor_list[i] = Array.new(h)
        end
        sensor_list_json = @obj["sensors"]
        count = 0
        for sensor in sensor_list_json
          i = count/@w
          j = count%@w
          @sensor_list[i][j] = DrawableSensor.new(sensor["id"], 1, sensor["lat"], sensor["lng"], "any", 1, sensor["opacity"], sensor["hsl"])
          count += 1
        end
        @minLat = @sensor_list[@h-1][@w-1].latitude
        @maxLat = @sensor_list[0][0].latitude
        @minLng = @sensor_list[0][0].longitude
        @maxLng = @sensor_list[@h-1][@w-1].longitude
    end
    
    def convert_json_to_sensor(json)
        #receives a json and returns its respective sensor
        s = Sensor.new
        s.id = json["id"]
        s.lat = json["lat"]
        s.lng = json["lng"]
        s.hsl = json["hsl"]
        s.opacity = json["opacity"]
        s
    end
    
    def compute_map_coordinates()
        #maps the coordinates of the sensor to the matrix used to
        #color the map
        scale = Math.sqrt((@w*@h).to_f/@numberPolygons)
        @scaledH = @h/scale
        @scaledW = @w/scale
        stepH = @scaledH/h;
        stepW = @scaledW/w;
        @scaledH += 1
        @scaledW += 1
        
        cp = ColorProcess.new()

        @intensityMap = Array.new(@scaledH)
        for i in 0...@scaledH
            @intensityMap[i] = Array.new(@scaledW)
            for j in 0...@scaledW
                @intensityMap[i][j] = DrawableSensor.new(0, 1, 0, 0, "", 1, 1, [0, 100, 100])
            end
        end
  
        for i in 0...@h
            for j in 0...@w
                s1 = @sensor_list[i][j]
                s2 = DrawableSensor.new(0, 1, 0, 0, "", 1, 1, [0, 100, 100])
                s3 = DrawableSensor.new(0, 1, 0, 0, "", 1, 1, [0, 100, 100])
                s4 = DrawableSensor.new(0, 1, 0, 0, "", 1, 1, [0, 100, 100])
                if (j+1 < @w)
                    s2 = @sensor_list[i][j+1]
                end
                if (i+1 < @h)
                    s3 = @sensor_list[i+1][j]
                end
                if (j+1 < @w && i+1<@h)
                    s4 = @sensor_list[i+1][j+1]
                end
                for k in 0...stepH
                    for l in 0...stepW
                        frac1 = k/stepH
                        frac2 = l/stepW
                        x = (i*stepH + k).floor
                        y = (j*stepW + l).floor
                        interpolated = cp.interpolate(s1, s2, s3, s4, frac1, frac2)
                        @intensityMap[x][y] = DrawableSensor.new(-1, 1, s1.latitude - k*@dist/stepH, s1.longitude+l*@dist/stepW, "any", 1, interpolated["opacity"], interpolated["hsl"])
                    end
                end
            end
        end
    end
    
    def sensor_to_hash(sensor)
        #converts a sensor to a hash
        #used for convertion to the json format 
        h = Hash.new
        h[:lat] = sensor.latitude
        h[:lng] = sensor.longitude
        h[:hsl] = sensor.color
        h[:opacity] = sensor.opacity
        h
    end
    
    def create_json_intensityMap
        #convert the matrix of interpolated colors into a json file
        #so it can be used to paint the map
        sensors = Array.new
        for i in 0...@scaledH
            for j in 0...@scaledW
                hashSensor = sensor_to_hash(@intensityMap[i][j])
                sensors << hashSensor
            end
        end
        jsonHash = Hash.new
        jsonHash[:sensors] = sensors
        jsonHash.to_json
    end
    
    def getMockJSON()
    #mock json for testing purposes 
       return '{
        "width": 8,
        "height": 5,
        "dist": 0.04,
        "sensors": [ 
        {"id": 0, "lat": -23.48, "lng": -46.81, "hsl": [0, 100, 100], "opacity": 0},  
           {"id": -1, "lat": -23.48, "lng": -46.77, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 1, "lat": -23.48, "lng": -46.73, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 2, "lat": -23.48, "lng": -46.69, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 0, "lat": -23.48, "lng": -46.65, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": -1, "lat": -23.48, "lng": -46.61, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 1, "lat": -23.48, "lng": -46.57, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 2, "lat": -23.48, "lng": -46.53, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 0, "lat": -23.52, "lng": -46.81, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": -1, "lat": -23.52, "lng": -46.77, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 1, "lat": -23.52, "lng": -46.73, "hsl": [60, 100, 50] , "opacity": 0.6},   
           {"id": 2, "lat": -23.52, "lng": -46.69, "hsl": [120, 100, 50] , "opacity": 0.4},   
           {"id": -1, "lat": -23.52, "lng": -46.65, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 3, "lat": -23.52, "lng": -46.61, "hsl": [0, 100, 50], "opacity": 0.9},   
           {"id": 4, "lat": -23.52, "lng": -46.57, "hsl": [120, 100, 50], "opacity": 0.4},   
           {"id": 5, "lat": -23.52, "lng": -46.53, "hsl": [60, 100, 50] , "opacity": 0.6},   
           {"id": 0, "lat": -23.56, "lng": -46.81, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": -1, "lat": -23.56, "lng": -46.77, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 1, "lat": -23.56, "lng": -46.73, "hsl": [0, 100, 100] , "opacity": 0},   
           {"id": 2, "lat": -23.56, "lng": -46.69, "hsl": [30, 100, 50] , "opacity": 0.5},   
           {"id": 0, "lat": -23.56, "lng": -46.65, "hsl": [120, 100, 50], "opacity": 0.7},   
           {"id": -1, "lat": -23.56, "lng": -46.61, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 1, "lat": -23.56, "lng": -46.57, "hsl": [60, 100, 50] , "opacity": 0.4},   
           {"id": 2, "lat": -23.56, "lng": -46.53, "hsl": [60, 100, 50] , "opacity": 0.75},   
           {"id": 0, "lat": -23.6, "lng": -46.81, "hsl": [120, 100, 50], "opacity": 0},   
           {"id": -1, "lat": -23.6, "lng": -46.77, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 1, "lat": -23.6, "lng": -46.73, "hsl": [0, 100, 100] , "opacity": 0},   
           {"id": 2, "lat": -23.6, "lng": -46.69, "hsl": [0, 100, 100] , "opacity": 0},   
           {"id": -1, "lat": -23.6, "lng": -46.65, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 3, "lat": -23.6, "lng": -46.61, "hsl": [0, 100, 50], "opacity": 0.9},   
           {"id": 4, "lat": -23.6, "lng": -46.57, "hsl": [120, 100, 50], "opacity": 0.4},   
           {"id": 5, "lat": -23.6, "lng": -46.53, "hsl": [60, 100, 50] , "opacity": 0.6},   
           {"id": 0, "lat": -23.64, "lng": -46.81, "hsl": [0, 100, 50], "opacity": 0},   
           {"id": -1, "lat": -23.64, "lng": -46.77, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 1, "lat": -23.64, "lng": -46.73, "hsl": [60, 100, 50] , "opacity": 0.6},   
           {"id": 2, "lat": -23.64, "lng": -46.69, "hsl": [0, 100, 100] , "opacity": 0},   
           {"id": -1, "lat": -23.64, "lng": -46.65, "hsl": [0, 100, 100], "opacity": 0},   
           {"id": 6, "lat": -23.64, "lng": -46.61, "hsl": [120, 100, 100], "opacity": 0.6},   
           {"id": 7, "lat": -23.64, "lng": -46.57, "hsl": [60, 100, 50] , "opacity": 0.5},   
           {"id": -1, "lat": -23.64, "lng": -46.53, "hsl": [0, 100, 50], "opacity": 0}   
        ]
      }'
  end
end