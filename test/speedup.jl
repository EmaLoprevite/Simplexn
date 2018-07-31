#####################################################
### Project of IN480 - From Python 2.7 to Julia 0.6
### --- SIMPLEXN - speedup ---
### Authors: Fabio Fatelli, Emanuele Loprevite
#####################################################

include("../src/simplexn-serial.jl")
include("../src/simplexn-parallel.jl")

addprocs(11)

using Plots
Plots.scalefontsizes(0.7)
gr() # loading backend

VOID = [Int64[]],[[0]] # the empty simplicial model
nt, N = 7, 5

# Compute the execution mean time
function timing(f::Function,x,n::Int64)
	t = Array{Float64}(n)
	f(x...)
	for k in 1:n
		t[k] = @elapsed f(x...)
	end
	return mean(t)
end

# Create and save the plots in the folder "figures"
function plotting(name::String,timeS::Array{Float64,1},timeP::Array{Float64,1},flag::Int64)
	l = max(length(timeS),length(timeP))+1
	pathName = "../doc/tex/figures/"*name
	s, p, xlb, ylb, DPI = "Serial", "Parallel", "Input", "Time (seconds)", 150
	plot(timeS,xlims=(1,l),title=name,label=s,xlabel=xlb,ylabel=ylb,dpi=DPI)
	savefig(pathName*"serial")
	plot(timeP,xlims=(1,l),title=name,label=p,xlabel=xlb,ylabel=ylb,dpi=DPI)
	savefig(pathName*"parallel")
	plot([timeS,timeP],xlims=(1,l),title=name,label=[s,p],xlabel=xlb,ylabel=ylb,dpi=DPI)
	savefig(pathName*"both")
end

# Create the plots
function plotting(name::String,timeS::Array{Float64,1},timeP::Array{Float64,1})
	l = max(length(timeS),length(timeP))+1
	s, p, xlb, ylb, DPI = "Serial", "Parallel", "Input", "Time (seconds)", 150
	p1 = plot(timeS,label=s,title=name)
	p2 = plot(timeP,label=p)
	p3 = plot([timeS,timeP],label=[s,p])
	plot(p1,p2,p3,xlims=(1,l),xlabel=xlb,ylabel=ylb,dpi=1.5*DPI,legend=:topleft)
	pathName = "../doc/tex/figures/"*name*"All"
	savefig(pathName)
end

timeSer = [timing(larExtrude1,[VOID,repmat([1,2,3,4],k^4)],nt) for k in 1:2*N]
timePar = [timing(plarExtrude1,[VOID,repmat([1,2,3,4],k^4)],nt) for k in 1:2*N]
#plotting("larExtrude1",timeSer,timePar)
println("larExtrude1\n","serial\n",timeSer,"\nparallel\n",timePar)

simp = [collect(1:500),collect(501:1000),collect(1001:1500)]
sLen = length(simp[1])
for k in 2:5*N
	push!(simp,simp[end]+sLen)
end
timeSer = [timing(larSimplexFacets,[simp[1:k]],nt) for k in 1:5*N]
timePar = [timing(plarSimplexFacets,[simp[1:k]],nt) for k in 1:5*N]
#plotting("larSimplexFacets",timeSer,timePar)
println("larSimplexFacets\n","serial\n",timeSer,"\nparallel\n",timePar)

#=
a=repmat([1],77)
model = plarExtrude1(VOID,a)
model = plarExtrude1(model,a)
model = plarExtrude1(model,a)
verts, quads = model
=#
verts, quads = [[0,0,0],[0,1,0],[1,0,0],[1,1,0]], [[0,1,2,3]]
len = length(quads[1])
for k in 2:7*N
	append!(verts,verts[end-len+1:end]+11)
	append!(quads,[quads[end]+len])
end
timeSer = [timing(quads2tria,[(verts[1:len*k],quads[1:k])],nt) for k in 1:7*N]
timePar = [timing(pquads2tria,[(verts[1:len*k],quads[1:k])],nt) for k in 1:7*N]
#plotting("quads2tria",timeSer,timePar)
println("quads2tria\n","serial\n",timeSer,"\nparallel\n",timePar)
