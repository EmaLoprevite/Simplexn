#####################################################
### Project of IN480 - From Python 2.7 to Julia 0.6
### --- SIMPLEXN - unit tests ---
### Authors: Fabio Fatelli, Emanuele Loprevite
#####################################################

answer = 0
println("Do you want to test the serial(1) or the parallel(2) version?")
try
	answer = parse(Int8,readline())
catch e
	answer = 0
	println("\n$e")
end

if answer == 1
	include("../src/simplexn-serial.jl")
elseif answer == 2
	include("../src/simplexn.jl")
else
	println("\nWrong selection!")
	sleep(5)
	quit()
end

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
	@testset "larSimplexGrid1" begin
	end
	@testset "larSimplexFacets" begin
	end
	@testset "quads2tria" begin
	end
end
