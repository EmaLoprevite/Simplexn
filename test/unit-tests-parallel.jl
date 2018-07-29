#####################################################
### Project of IN480 - From Python 2.7 to Julia 0.6
### --- SIMPLEXN - parallel unit tests ---
### Authors: Fabio Fatelli, Emanuele Loprevite
#####################################################

include("../src/simplexn-parallel.jl")

using Base.Test
using LARVIEW

using PyCall
@pyimport larlib as p

VOID = [Int64[]],[[0]] # the empty simplicial model

@testset "Unit Tests" begin
	@testset "larExtrude1" begin
	end
	@testset "larSimplexGrid1" begin
	end
	@testset "larSimplexFacets" begin
	end
	@testset "quads2tria" begin
	end
end
