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

VOID = [Int64[]],[[0]] # the empty simplicial model

@testset "Unit Tests" begin
	@testset "larExtrude1" begin
		inModel = VOID
		pattern = [1]
		model = larExtrude1(inModel,pattern)
		println(model)
		@test typeof(model) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model[1]) == length(pattern)+1
		@test length(model[2]) == length(filter(x->x>0,pattern))
		#LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)
		
		pattern = [1,3]
		model = larExtrude1(inModel,pattern)
		println(model)
		@test typeof(model) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model[1]) == length(pattern)+1
		@test length(model[2]) == length(filter(x->x>0,pattern))
		#LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)
		
		pattern = [1,3,-2]
		model = larExtrude1(inModel,pattern)
		println(model)
		@test typeof(model) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model[1]) == length(pattern)+1
		@test length(model[2]) == length(filter(x->x>0,pattern))
		#LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)
		
		inModel = ([[0,0],[0,1]],[[1,0],[1,1]])
		pattern = [1]
		model = larExtrude1(inModel,pattern)
		println(model)
		@test typeof(model) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model[1]) == 4+2*(length(pattern)-1)
		@test length(model[2]) == 4*length(filter(x->x>0,pattern))
		#LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)
		
		pattern = [1,3]
		model = larExtrude1(inModel,pattern)
		println(model)
		@test typeof(model) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model[1]) == 4+2*(length(pattern)-1)
		@test length(model[2]) == 4*length(filter(x->x>0,pattern))
		#LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)
		
		pattern = [1,3,-2]
		model = larExtrude1(inModel,pattern)
		println(model)
		@test typeof(model) == Tuple{Array{Array{Int64,1},1},Array{Array{Int64,1},1}}
		@test length(model[1]) == 4+2*(length(pattern)-1)
		@test length(model[2]) == 4*length(filter(x->x>0,pattern))
		#LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)
		
		inModel = ([[0.0,0],[0,1]],[[1,0],[1,1]])
		@test typeof(inModel[1]) == Array{Array{Float64,1},1}
		pattern = [1]
		model = larExtrude1(inModel,pattern)
		println(model)
		@test typeof(model) == Tuple{Array{Array{Float64,1},1},Array{Array{Int64,1},1}}
		@test length(model[1]) == 4+2*(length(pattern)-1)
		@test length(model[2]) == 4*length(filter(x->x>0,pattern))
		#LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)
	end
	@testset "larSimplexGrid1" begin
	end
	@testset "larSimplexFacets" begin
	end
	@testset "quads2tria" begin
	end
end
