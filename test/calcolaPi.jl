@everywhere function calcola_pi(N::Int64)
    
    n_nel_cerchio = 0  # conta i punti nel cerchio
    for i = 1:N
        x = rand() * 2 - 1  # distribuzione uniforme su x
        y = rand() * 2 - 1  # distribuzione uniforme su y

        r2 = x*x + y*y  # quardato della distanza dal centro
        if r2 < 1.0
            n_nel_cerchio += 1
        end
    end

    return n_nel_cerchio / N * 4.0    
end

function calcolo_parallelo_pi(N::Int; ncores::Int=4) 
    
      # compute sum of pi's estimated among all cores in parallel
somma_delle_pi = @parallel (+) for i=1:ncores calcola_pi(ceil(Int, N / ncores))
end
     return somma_delle_pi / ncores # average value 
end


@timev calcolo_parallelo_pi(40000000000,8)
