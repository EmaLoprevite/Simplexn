#####################################################
### Project of IN480 - From Python 2.7 to Julia 0.6
### --- SIMPLEXN - serial unit tests ---
### Authors: Fabio Fatelli, Emanuele Loprevite
#####################################################

include("../src/simplexn-serial.jl")

using Base.Test
#using LARVIEW
#using PyCall
#@pyimport larlib as p

### LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)

@testset "Unit Tests" begin
	@testset "larExtrude1" begin
		VOID = [Int64[]],[[0]] # the empty simplicial model
		pattern1 = [1]
		model1 = larExtrude1(VOID,pattern1) # 1D
		println(model1)
		@test typeof(model1) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model1[1]) == length(pattern1)+1 # number of vertices, no repetitions
		@test length(model1[2]) == length(filter(x->x>0,pattern1)) # number of 1D-simplices
		
		pattern2 = [1,3]
		model2 = larExtrude1(VOID,pattern2) # 1D
		println(model2)
		@test typeof(model2) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model2[1]) == length(pattern2)+1 # number of vertices, no repetitions
		@test length(model2[2]) == length(filter(x->x>0,pattern2)) # number of 1D-simplices
		
		pattern3 = [1,3,-2]
		model3 = larExtrude1(VOID,pattern3) # 1D
		println(model3)
		@test typeof(model3) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model3[1]) == length(pattern3)+1 # number of vertices, no repetitions
		@test length(model3[2]) == length(filter(x->x>0,pattern3)) # number of 1D-simplices
		
		model1 = larExtrude1(model1,pattern1) # 2D
		println(model1)
		@test typeof(model1) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model1[1]) == 4+2*(length(pattern1)-1)
		@test length(model1[2]) == 4*length(filter(x->x>0,pattern1))
		
		model2 = larExtrude1(model2,pattern2) # 2D
		println(model2)
		@test typeof(model2) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model2[1]) == 4+2*(length(pattern2)-1)
		@test length(model2[2]) == 4*length(filter(x->x>0,pattern2))
		
		model3 = larExtrude1(model3,pattern3) # 2D
		println(model3)
		@test typeof(model3) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model3[1]) == 4+2*(length(pattern3)-1)
		@test length(model3[2]) == 4*length(filter(x->x>0,pattern3))
		#=
		model1 = larExtrude1(model1,pattern1) # 3D
		println(model1)
		@test typeof(model1) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model1[1]) == 
		@test length(model1[2]) == 
		
		model2 = larExtrude1(model2,pattern2) # 3D
		println(model2)
		@test typeof(model2) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model2[1]) == 
		@test length(model2[2]) == 
		
		model3 = larExtrude1(model3,pattern3) # 3D
		println(model3)
		@test typeof(model3) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model3[1]) == 
		@test length(model3[2]) == 
		=#
		model = ([[0.0,0],[0,1]],[[1,0],[1,1]]) # 2D with float
		@test typeof(model[1]) == Array{Array{Float64,1},1}
		model = larExtrude1(model,pattern1)
		println(model)
		@test typeof(model) == Tuple{Array{Array{Float64,1},1},Array{Array{Int64,1},1}}
		@test length(model[1]) == 4+2*(length(pattern1)-1)
		@test length(model[2]) == 4*length(filter(x->x>0,pattern1))
	end
	@testset "larSimplexGrid1" begin
		shape = [3] # 1D
		model = larSimplexGrid1(shape)
		println(model)
		@test typeof(model) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model[1]) == shape[1]+1 # number of vertices, no repetitions
		@test length(model[2]) == shape[1] # number of 1D-simplices
		
		shape = [3,5] # 2D
		model = larSimplexGrid1(shape)
		println(model)
		@test typeof(model) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		# (shape[1]+1)*(shape[2]+1)
		@test length(model[1]) == prod(shape)+sum(shape)+1 # number of vertices, no repetitions
		@test length(model[2]) == 2*prod(shape) # number of 2D-simplices
		
		shape = [3,5,7] # 3D
		model = larSimplexGrid1(shape)
		println(model)
		@test typeof(model) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		# (shape[1]+1)*(shape[2]+1)*(shape[3]+1); number of vertices, no repetions
		@test length(model[1]) == prod(shape)+sum(prod.(collect(combinations(shape,2))))+sum(shape)+1
		@test length(model[2]) == 6*prod(shape) # number of faces with repetitions
	end
	@testset "larSimplexFacets" begin
	end
	@testset "quads2tria" begin
	end
end
