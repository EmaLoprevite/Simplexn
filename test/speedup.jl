#####################################################
### Project of IN480 - From Python 2.7 to Julia 0.6
### --- SIMPLEXN - speedup ---
### Authors: Fabio Fatelli, Emanuele Loprevite
#####################################################

include("../src/simplexn-serial.jl")
#include("../src/simplexn.jl")

VOID = [Int64[]],[[0]] # the empty simplicial model
N = 4

gr() # loading backend

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
	p1 = plot(timeS,label=s)
	p2 = plot(timeP,label=p,title=name)
	p3 = plot([timeS,timeP],label=[s,p])
	plot(p1,p2,p3,xlims=(1,l),xlabel=xlb,ylabel=ylb,dpi=1.5*DPI,layout=grid(1,3),size=(999,333),legend=:topleft)
end

timeSer = [timing(larExtrude1,(VOID,repmat([1],100*k)),N) for k in 1:N]
timePar = [timing(larExtrude1,(VOID,repmat([1],100*k)),N) for k in 1:N]
plotting("larExtrude1",timeSer,timePar)

#=
timeSer = [timing(larSimplexGrid1,,n) for k in 1:n]
timePar = [timing(larSimplexGrid1,,n) for k in 1:n]
plotting("larSimplexGrid1",timeSer,timePar)

timeSer = [timing(larSimplexFacets,,n) for k in 1:n]
timePar = [timing(larSimplexFacets,,n) for k in 1:n]
plotting("larSimplexFacets",timeSer,timePar)

timeSer = [timing(quads2tria,,n) for k in 1:n]
timePar = [timing(quads2tria,,n) for k in 1:n]
plotting("quads2tria",timeSer,timePar)
=#
