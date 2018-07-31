#####################################################
### Project of IN480 - From Python 2.7 to Julia 0.6
### --- SIMPLEXN - speedup ---
### Authors: Fabio Fatelli, Emanuele Loprevite
#####################################################

include("../src/simplexn-serial.jl")
include("../src/simplexn-parallel.jl")

VOID = [Int64[]],[[0]] # the empty simplicial model
N = 3

gr() # loading backend

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
	l = max(length(timeS),length(timeP))+3
	s, p, xlb, ylb, DPI = "Serial", "Parallel", "Input", "Time (seconds)", 150
	p1 = plot(timeS,label=s,title=name)
	p2 = plot(timeP,label=p)
	p3 = plot([timeS,timeP],label=[s,p])
	plot(p1,p2,p3,xlims=(1,l),xlabel=xlb,ylabel=ylb,dpi=1.5*DPI,legend=:bottomright)
	pathName = "../doc/tex/figures/"*name*"All"
	savefig(pathName)
end

timeSer = [timing(larExtrude1,[VOID,repmat([1],100*k)],N) for k in 1:N]
timePar = [timing(plarExtrude1,[VOID,repmat([1],100*k)],N) for k in 1:N]
plotting("larExtrude1",timeSer,timePar)

timeSer = [timing(larSimplexGrid1,[[2^k,2^k,2^k]],N) for k in 1:N]
timePar = [timing(plarSimplexGrid1,[[2^k,2^k,2^k]],N) for k in 1:N]
plotting("larSimplexGrid1",timeSer,timePar)

simp = [collect(1:101)]
sLen = length(simp[1])
for k in 2:N
	push!(simp,simp[end]+sLen)
end
timeSer = [timing(larSimplexFacets,[simp[1:k]],N) for k in 1:N]
timePar = [timing(plarSimplexFacets,[simp[1:k]],N) for k in 1:N]
plotting("larSimplexFacets",timeSer,timePar)

verts, quads = [[0,0,0],[0,1,0],[1,0,0],[1,1,0]], [[0,1,2,3]]
len = length(quads[1])
for k in 2:N
	append!(verts,verts[end-len+1:end]+1)
	append!(quads,[quads[end]+len])
end
timeSer = [timing(quads2tria,[(verts[1:len*k],quads[1:k])],N) for k in 1:N]
timePar = [timing(pquads2tria,[(verts[1:len*k],quads[1:k])],N) for k in 1:N]
plotting("quads2tria",timeSer,timePar)
