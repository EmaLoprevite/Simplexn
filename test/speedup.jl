#####################################################
### Project of IN480 - From Python 2.7 to Julia 0.6
### --- SIMPLEXN - speedup ---
### Authors: Fabio Fatelli, Emanuele Loprevite
#####################################################

function timing(f,x,N::UInt8) # f::Function ?
	t = Array{Float64}(N)
	f(x) # or x... ?
	for k in 1:N
		t[k] = @elapsed f(x)
	end
	return mean(t)
end

function plotting(name::String,timeS::Array{Float64,1},timeP::Array{Float64,1})
	plot(timeS,title=name,label="Serial",xlabel="Input",ylabel="Time (seconds)")
	plot(timeP,title=name,label="Parallel",xlabel="Input",ylabel="Time (seconds)")
	plot(,title=name,label=["Serial","Parallel"],xlabel="Input",ylabel="Time (seconds)")
end
