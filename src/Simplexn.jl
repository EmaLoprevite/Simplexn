#####################################################
### Project of IN480 - From Python 2.7 to Julia 0.6
### --- SIMPLEXN ---
### Authors: Fabio Fatelli, Emanuele Loprevite
#####################################################

using Combinatorics			# for the function combinations()


VOID = V0,CV0 = [Int64[]],[[0]]			# the empty simplicial model

function larExtrude1(model, pattern)
	V, FV = model
	d, m = length(FV[1]), length(pattern)
	coords = cumsum(append!([0],abs.(pattern)))			# built-in function cumsum
	offset, outcells, rangelimit = length(V), Int64[], d*m
	outcells = Array{Int64}(m,0)
	for cell in FV
		tube = [v + k*offset for k in 0:m for v in cell]
		celltube = Int64[]
		for k in 1:rangelimit
			append!(celltube,tube[k:k+d])
		end
		outcells = hcat(outcells,permutedims(reshape(celltube,d*(d+1),m),[2,1]))
	end
	cellGroups = Int64[]
	for k in 1:m
		if pattern[k]>0
			cellGroups=vcat(cellGroups,outcells[k,:])
		end
	end
	outVertices = [vcat(v,z) for z in coords for v in V]
	outCellGroups = Array{Int64,1}[]
	for k in 1:d+1:length(cellGroups)
		append!(outCellGroups,[cellGroups[k:k+d]])
	end
	return outVertices, outCellGroups
end

function larSimplexGrid1(shape)
	model = VOID
	for item in shape
		model = larExtrude1(model, repmat([1],item))
	end
	return model
end

function larSimplexFacets(simplices)			# Return array of arrays and not array of tuples
	out = Array{Int64,1}[]
    d = length(simplices[1])
    for simplex in simplices
    	append!(out,collect(combinations(simplex,d-1)))			# combinations() needs pkg Combinatorics
    end
	return sort!(unique(out), lt=lexless)
end
#map(x -> tuple(x...) ,[[0, 1], [0, 4], [1, 2]])

# Transformation to triangles by sorting circularly the vertices of faces
function quads2tria(model)
	V, FV = model
	out = Array{Int64,1}[]
	nverts = length(V)-1
	#println("nverts:\n", nverts)
	for face in FV
		#println("face\n", face)
		arr = [V[v+1] for v in face]
		#println("arr\n", arr)
		centroid = sum(arr)/length(arr)
		#println("centroid\n", centroid)
		append!(V,[centroid])
		#println("V\n", V)
		nverts += 1
		#println("nverts\n", nverts)
		#println("face[1]\n",face[1])
		#println("face[2]\n",face[2])
		v1, v2 = V[face[1]+1]-centroid, V[face[2]+1]-centroid
		#println("v1\n", v1)
		#println("v2\n", v2)
		v3 = cross(v1,v2)
		#println("v3\n", v3)
		if norm(v3) < 1/(10^3)										# mettere if o while?
			v1, v2 = V[face[1]+1]-centroid, V[face[3]+1]-centroid
			#println("v1\n", v1)
			#println("v2\n", v2)
			v3 = cross(v1,v2)
			#println("v3\n", v3)
		end
		transf = inv(hcat(v1,v2,v3)')
		#println("transf\n",transf)
		verts = [(V[v+1]'*transf)'[1:end-1] for v in face]
		#println("verts\n",verts)
		tcentroid = sum(verts)/length(verts)
		#println("tcentroid\n",tcentroid)
		#println(typeof(tcentroid))
		tverts = [v-tcentroid for v in verts]
		#println("tverts\n",tverts)
		iterator = collect(zip(tverts, face))
		#println("iterator\n",iterator)
		rverts = [ [atan2(reverse(iterator[i][1])...), iterator[i][2]] for i in 1:length(iterator) ]
		#println("rverts\n",rverts)
		rvertss = sort(rverts, lt=(x,y)->isless(x[1],y[1]))
		#println("rvertss\n",rvertss)
		ord = [pair[2] for pair in rvertss]
		#println("ord 1\n",ord)
		append!(ord,ord[1])
		#println("ord 2\n",ord)
		edges = [ [i[2], ord[i[1]+1]] for i in enumerate(ord[1:end-1]) ]
		#println("edges\n",edges)
		triangles = [ prepend!(edge,nverts) for edge in edges ]
		#println("triangles\n",triangles)
		append!(out,triangles)
		#println("out\n",out)
		#println("V\n",V)
	end
	return V, out
end
