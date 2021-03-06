#####################################################
### Project of IN480 - From Python 2.7 to Julia 0.6
### --- SIMPLEXN - serial version (everywhere) ---
### Authors: Fabio Fatelli, Emanuele Loprevite
#####################################################

# Generation of the output model vertices in a multiple extrusion of a LAR model
@everywhere function larExtrude1{T<:Real}(model::Tuple{Array{Array{T,1},1},Array{Array{Int64,1},1}},pattern::Array{Int64,1})
	V, FV = model
	d, m = length(FV[1]), length(pattern)
	coords = cumsum(append!([0],abs.(pattern))) # built-in function cumsum
	offset, outcells, rangelimit = length(V), Array{Int64}(m,0), d*m
	for cell in FV
		tube = [v+k*offset for k in 0:m for v in cell]
		celltube = Int64[]
		for k in 1:rangelimit
			append!(celltube,tube[k:k+d])
		end
		outcells = hcat(outcells,reshape(celltube,d*(d+1),m)')
	end
	cellGroups = Int64[]
	for k in 1:m
		if pattern[k]>0
			cellGroups = vcat(cellGroups,outcells[k,:])
		end
	end
	outVertices = [vcat(v,z) for z in coords for v in V]
	outCellGroups = Array{Int64,1}[]
	for k in 1:d+1:length(cellGroups)
		append!(outCellGroups,[cellGroups[k:k+d]])
	end
	return outVertices, outCellGroups
end

# Generation of simplicial grids of any dimension and shape
@everywhere function larSimplexGrid1(shape::Array{Int64,1})
	model = [Int64[]],[[0]] # the empty simplicial model
	for item in shape
		model = larExtrude1(model,repmat([1],item))
	end
	return model
end

# Extraction of non-oriented (d-1)-facets of d-dimensional simplices
@everywhere using Combinatorics # for the function combinations()

@everywhere function larSimplexFacets(simplices::Array{Array{Int64,1},1})
	out = Array{Int64,1}[]
	d = length(simplices[1])
	for simplex in simplices
		append!(out,collect(combinations(simplex,d-1)))
	end
	return sort!(unique(out),lt=lexless)
end

# Transformation to triangles by sorting circularly the vertices of faces
@everywhere function quads2tria{T<:Real}(model::Tuple{Array{Array{T,1},1},Array{Array{Int64,1},1}})
	V, FV = model
	if typeof(V) != Array{Array{Float64,1},1}
		V = convert(Array{Array{Float64,1},1},V)
	end
	out = Array{Int64,1}[]
	nverts = length(V)-1
	for face in FV
		arr = [V[v+1] for v in face]
		centroid = sum(arr)/length(arr)
		append!(V,[centroid])
		nverts += 1
		v1, v2 = V[face[1]+1]-centroid, V[face[2]+1]-centroid
		v3 = cross(v1,v2)
		if norm(v3) < 1/(10^3)
			v1, v2 = V[face[1]+1]-centroid, V[face[3]+1]-centroid
			v3 = cross(v1,v2)
		end
		transf = inv(hcat(v1,v2,v3)')
		verts = [(V[v+1]'*transf)'[1:end-1] for v in face]
		tcentroid = sum(verts)/length(verts)
		tverts = [v-tcentroid for v in verts]
		iterator = collect(zip(tverts,face))
		rverts = [[atan2(reverse(iterator[i][1])...),iterator[i][2]] for i in 1:length(iterator)]
		rvertsS = sort(rverts,lt=(x,y)->isless(x[1],y[1]))
		ord = [pair[2] for pair in rvertsS]
		append!(ord,ord[1])
		edges = [[i[2],ord[i[1]+1]] for i in enumerate(ord[1:end-1])]
		triangles = [prepend!(edge,nverts) for edge in edges]
		append!(out,triangles)
	end
	return V, out
end
