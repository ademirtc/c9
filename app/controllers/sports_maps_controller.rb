class SportsMapsController < ApplicationController
    
    def index 
        # shows map and options
    end
    
    def loadData 
        # captures the parameters and redirects to indexrespond_to do |format|
        puts params[:sports_map][:radius]
        respond_to do |format|
            format.html do
              redirect_to '/'
            end
        end
        
    end    
    
    def drawmap
        @result = SensorProcess.new.create_intensity_map
        #will display the intensity map in a next sprint. For now,
        #it only show the json containing the coordinates of the points
        #that will be drawn on the screen
    end
    
    def algorithm
        #algorithm that receives the sensors and gives a value
        #according to their quality. This json will be passed
        #as an input to the drawmap
       obj= DataProcess.new
       obj.loadSensor
       @result=obj.processSensors
    end
    
end
