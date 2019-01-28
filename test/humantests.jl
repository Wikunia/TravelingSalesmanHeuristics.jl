# This file contains "tests for humans:" functions you might use to reassure
# yourself that the heuristics are working properly or chose a heuristic for your
# particular problem. The functions in this file are not run by Travis and this file
# requires several packages (such as Gadfly) not listed in the REQUIRE.
using TravelingSalesmanHeuristics
using Distances, Random

# compare some heuristics
function compareHeuristics(;n = 20)
	seed = Random.seed!(10)
	
	file_name = "tsp_280_1"
	f = open("./test/data/" * file_name);
	lines = readlines(f)
	n = length(lines)
	
	pts = zeros(2, n)
	
	for i = 1:n
		x_str, y_str = split(lines[i])
		pts[:,i] = [parse(Float64, x_str), parse(Float64, y_str)]
	end

	dm = pairwise(Euclidean(), pts, pts)
	# println("Simple lower bound: $(lowerbound(dm))")
	# singlenn_no2opt = nearest_neighbor(dm, do2opt = false)
	# println("Single start nearest neighbor without 2-opt has cost $(singlenn_no2opt[2])")
	sym_time_start = time()
	singlenn_2opt_sym = nearest_neighbor(dm, do2opt = true, firstcity=1, sym=true)
	sym_time = time()-sym_time_start
	println("Single start nearest neighbor with 2-opt has cost $(singlenn_2opt_sym[2])")
	asym_time_start = time()
	singlenn_2opt_asym = nearest_neighbor(dm, do2opt = true, firstcity=1, sym=false)
	asym_time = time()-asym_time_start
	println("Single start nearest neighbor with 2-opt has cost $(singlenn_2opt_asym[2])")
	println("Symmetric is $(asym_time/sym_time) times faster")
	# repnn_no2opt = repetitive_heuristic(dm, nearest_neighbor, do2opt = false)
	# println("Multi start nearest neighbor without 2-opt has cost $(repnn_no2opt[2])")
	# @time repnn_2opt = repetitive_heuristic(dm, nearest_neighbor, do2opt = true, firs)
	# println("Multi start nearest neighbor with 2-opt has cost $(repnn_2opt[2])")
	# singleci_no2opt = cheapest_insertion(dm, do2opt = false)
	# println("Single start cheapest insert without 2-opt has cost $(singleci_no2opt[2])")
	# @time singleci_2opt = cheapest_insertion(dm, do2opt = true, firstcity=1)
	# println("Single start cheapest insert with 2-opt has cost $(singleci_2opt[2])")
	# multici_no2opt = repetitive_heuristic(dm, cheapest_insertion, do2opt = false)
	# println("Multi start cheapest insert without 2-opt has cost $(multici_no2opt[2])")
	# @time multici_2opt = repetitive_heuristic(dm, cheapest_insertion, do2opt = true)
	# println("Multi start cheapest insert with 2-opt has cost $(multici_2opt[2])")
	#=
	simanneal = simulated_annealing(dm)
	println("Simulated annealing with default arguments has cost $(simanneal[2])")
	=#
end


compareHeuristics(n=280)