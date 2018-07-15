#####################################################
### Project of IN480 - From Python 2.7 to Julia 0.6
### --- SIMPLEXN - unit tests ---
### Authors: Fabio Fatelli, Emanuele Loprevite
#####################################################

include("../src/simplexn-serial.jl")

using Base.Test
using LARVIEW

using PyCall
@pyimport larlib as p

VOID = [Int64[]],[[0]] # the empty simplicial model

@testset "Unit Tests" begin
	@testset "larExtrude1" begin
		inModel = VOID
		pattern = [1]
		model = larExtrude1(inModel,pattern)
		println(model)
		@test length(model[1]) == length(pattern)+1
		#LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)
		
		pattern = [1,3]
		model = larExtrude1(inModel,pattern)
		println(model)
		@test length(model[1]) == length(pattern)+1
		#LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)
		
		pattern = [1,3,-2]
		model = larExtrude1(inModel,pattern)
		println(model)
		@test length(model[1]) == length(pattern)+1
		#LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)
		
		inModel = ([[0,0],[0,1]],[[1,0],[1,1]])
		pattern = [1]
		model = larExtrude1(inModel,pattern)
		println(model)
		@test length(model[1]) == 4+2*(length(pattern)-1)
		#LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)
		
		pattern = [1,3]
		model = larExtrude1(inModel,pattern)
		println(model)
		@test length(model[1]) == 4+2*(length(pattern)-1)
		#LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)
		
		pattern = [1,3,-2]
		model = larExtrude1(inModel,pattern)
		println(model)
		@test length(model[1]) == 4+2*(length(pattern)-1)
		#LARVIEW.viewexploded(hcat(model[1]...),model[2]+1)
	end
end
