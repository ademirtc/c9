require_relative '../../app/models/sensor.rb'
#require_relative '../../app/models/data_process.rb'
require_relative '../../app/models/quad_process.rb'

require 'rquad'

describe QuadProcess do
include RQuad
before :each do
     #include RQuad
    @objQuadProccess = QuadProcess.new(-180,180,-90,90,2)
 end

 describe "#new" do
    #include RQuad 
    it "takes five parameters and returns a quadTree object" do        
        expect(@objQuadProccess).to be_an_instance_of(QuadProcess)
    end	
 end


 describe "#setData" do
	it "set 2 elements to quadTree and change o size of quadTree" do
	list = [];
	list << DrawableSensor.new(0,0,20,50,0,20,0.5)	
	list << DrawableSensor.new(0,0,5,35,0,20,0.5)		
	@objQuadProccess.setData(list)
	expect(@objQuadProccess.numNodes).to eq(2)
	end
end

 describe "#setRandomData" do
	it "generates random test data - unit test" do
	@objQuadProccess.setRandomData()
	expect(@objQuadProccess.numNodes).to eq(35)
	end	
end

describe "#process" do
	it "process the quadTree " do
	expect(@objQuadProccess.numNodes).to eq(0)		
	list = [];
	tmp = DrawableSensor.new(0,0,20,50,0,20,0.5)
	tmp.color = [255,0,0]
	list << tmp
	tmp = DrawableSensor.new(0,0,5,35,0,20,0.5)
	tmp.color = [0,255,0]
	list << tmp
	@objQuadProccess.setData(list)
	@objQuadProccess.process	
	expect(@objQuadProccess.numNodes).to eq(2)
	end	
end	

describe "#process" do
	it "process the quadTree and returns a json with intersections" do
	expect(@objQuadProccess.numNodes).to eq(0)		
	list = [];
	tmp = DrawableSensor.new(0,0,21,5,0,20,0.5)
	tmp.color = [255,0,0]
	list << tmp
	tmp = DrawableSensor.new(0,0,30,25,0,20,0.5)
	tmp.color = [0,255,0]
	list << tmp
	@objQuadProccess.setData(list)
	@objQuadProccess.process
	strJson = @objQuadProccess.to_json
	expect(@objQuadProccess.resultQTree.size).to eq(3)
	end	
end	

describe "#process" do
	it "process the quadTree and return a json empty" do
	strJson = @objQuadProccess.to_json	
	expect(@objQuadProccess.to_json).to eq("{ drawableSensors: []}")
	end	
end	

end
#TODO
# test array data
=begin
{ data: [ {id:0,latitude:11,longitude:-45,radius:20,color:[255, 510, 0],opacity:0},
          {id:0,latitude:12,longitude:20,radius:20,color:[255, 255, 0],opacity:0},
          {id:0,latitude:-11,longitude:-46,radius:20,color:[255, 255, 0],opacity:0},
          {id:0,latitude:-13,longitude:16,radius:20,color:[255, 255, 0],opacity:0},
          {id:0,latitude:17,longitude:-42,radius:20,color:[255, 0, 0],opacity:0},
          {id:0,latitude:17,longitude:-12,radius:20,color:[0, 255, 0],opacity:0}
          ]}
=end	