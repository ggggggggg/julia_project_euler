sudoku1 = transpose(reshape(int(split(join(split("003020600
900305001
001806400
008102900
700000008
006708200
002609500
800203009
005010300")),"")),(9,9)))
solved_sudoku = transpose(reshape(int(split(join(split("362714598
179258463
584396127
426831975
918475632
735629814
251947386
843162759
697583241")),"")),(9,9)))

function read_sudoku(fstream)
    sudoku = Dict()
    q = 0
    r = 10
    for line in split(readall(fstream))
        r == 10 ? (q+=1;sudoku[q]=zeros(Int,(9,9));r=1) : 0
        if length(line) == 9
            sudoku[q][r,:] = int(split(line,""))
            r+=1
        end
    end
return sudoku
end
sudoku_dict = open(read_sudoku, "sudoku.txt")

function get_box(sudoku, x, y)
    box_x = div(x-1,3)*3+[1:3]
    box_y = div(y-1,3)*3+[1:3]
    return reshape(sudoku[box_x, box_y],(1,9))
end

function get_lines(sudoku, x, y)
    return [sudoku[x,:] transpose(sudoku[:,y])]
end

function get_forbid(sudoku, x, y)
    return unique([get_lines(sudoku, x, y) get_box(sudoku,x,y)])
end

function by_number(sudoku, n)
    canbe = ones(Int, (9,9))
    moves = Dict()
    for x=1:9, y=1:9
        if sudoku[x,y] == n
            canbe[x,:] = 0
            canbe[:,y] = 0
            box_x = div(x-1,3)*3+[1:3]
            box_y = div(y-1,3)*3+[1:3]
            canbe[box_x, box_y] = 0
        end
    end
    for x = 1:9
        if sum(canbe[x,:]) == 1
            y = find(canbe[x,:])[1]
            sudoku[x,y]==0 ? moves[(x,y)] = n : 0
        end
    end
    for y = 1:9
        if sum(canbe[:,y]) == 1
            x = find(canbe[:,y])[1]
            sudoku[x,y]==0 ? moves[(x,y)] = n : 0
        end
    end
    for xx = 0:2, yy = 0:2
        box_x, box_y = xx*3+[1:3], yy*3+[1:3]
        if sum(canbe[box_x, box_y]) == 1
            i = find(canbe[box_x, box_y])[1]
            x = 3*xx + mod(i-1,3) + 1
            y = 3*yy + div(i-1,3) + 1
            #println("$(xx, yy) $i $(x,y)")
            sudoku[x,y]==0 ? moves[(x,y)] = n : 0
        end
    end
return moves
end

function by_numbers(sudoku)
    moves = Dict()
    for n = 1:9
        moves = merge(moves, by_number(sudoku, n))
    end
return moves
end

function get_values(sudoku, x, y)
    if sudoku[x,y] == 0
        forbid = get_forbid(sudoku, x,y)
        values = setdiff([1:9], forbid)
        return values
    else
        return sudoku[x,y]
    end
end

function can_place(sudoku, x, y, n)
    return contains(get_values(sudoku,x,y),n)
end

function sudoku_solved(sudoku)
    verbose = false
    ref_a = [1:9]
    for x=1:9
        if length(symdiff(ref_a, sudoku[x,:])) != 0
            verbose ? println("problem for x=$x, $(sudoku[x,:])") : 0
            return false
        end
    end
    for y=1:9
        if length(symdiff(ref_a, sudoku[:,y])) != 0
            verbose ? println("problem for y=$y, $(sudoku[:,y])") : 0
            return false
        end
    end
    for x=1:3, y=1:3
        if length(symdiff(ref_a, get_box(sudoku,x,y))) != 0
            verbose ? println("problem for box x,y=$(x,y), $(get_box(sudoku,x,y)))") : 0
            return false
        end
    end
return true
end

function get_moves(sudoku)
    moves = Dict()
    guesses = Dict()
    for x=1:9, y=1:9
        if sudoku[x,y] == 0
            values = get_values(sudoku, x,y)
            if length(values) == 1
                if values[1] != sudoku[x,y]
                    moves[(x,y)] = values[1]
                end
            elseif length(values) > 1
                guesses[(x,y)] = values
            else
                throw(error("invalid sudoku at $(x,y)"))
            end
        end
    end
    moves = merge(moves, by_numbers(sudoku))
return moves, guesses
end

function get_moves_only(sudoku)
    moves = Dict()
    guesses = Dict()
    for x=1:9, y=1:9
        if sudoku[x,y] == 0
            values = get_values(sudoku, x,y)
            if length(values) == 1
                if values[1] != sudoku[x,y]
                    moves[(x,y)] = values[1]
                end
            elseif length(values) > 1
                #guesses[(x,y)] = values
            else
                #throw(error("invalid sudoku at $(x,y)"))
            end
        end
    end
    moves = merge(moves, by_numbers(sudoku))
return moves
end

function make_moves(sudoku, moves)
    sc = copy(sudoku)
    for ((x,y), value) in moves
        sc[x,y] = value
    end
return sc
end

function make_guess(sudoku, guesses)
    num_guesses = int([length(values) for ((x,y), values) in guesses])
    guess_order = sortperm(num_guesses)
    gkeys = collect(keys(guesses))
    for q in guess_order
        (x,y), values = (gkeys[q], guesses[gkeys[q]])
        for value in values
            #println("guess $(x,y) = $value")
            sc = copy(sudoku)
            sc[x,y] = value
            produce(sc)
        end
    end
end

function make_guess_list(guesses)
    num_guesses = int([length(values) for ((x,y), values) in guesses])
    guess_order = sortperm(num_guesses)
    gkeys = collect(keys(guesses))
    for q in guess_order
        (x,y), values = (gkeys[q], guesses[gkeys[q]])
        for value in values
            #println("guess $(x,y) = $value")
            sc = copy(sudoku)
            sc[x,y] = value
            produce(sc)
        end
    end
end

function ssolve(sudoku)
    moves, guesses = get_moves(sudoku)
    if length(moves) > 0
        return ssolve(make_moves(sudoku, moves))
    elseif length(guesses) > 0
        guessed = Task(()->make_guess(sudoku, guesses))
        q = 0
        for guessed_sudoku in guessed
#            q+=1
            #println("guess $q for $(length(find(sudoku)))")
            try
#                return ssolve(guessed_sudoku)
            end
        end
#        throw(error("ran out of guesses"))
    else
        if sudoku_solved(sudoku)
#            return sudoku
        elseif length(find(sudoku)) < 81
#            println("ran out of guesses but only filled $(length(find(sudoku))) slots")
#            throw((error("wtf"))
        else
#            throw(error("invalid solution"))
        end
    end
end

function do_all_moves(sudoku)
    for j = 1:81
        moves = get_moves_only(sudoku)
        if length(moves) > 0
            sudoku = make_moves(sudoku, moves)
        else
            return sudoku
        end
    end
    throw(error("made it through 81 loops of doing moves"))
end

x = 1
y = 1

function isolve(sudoku)
    strack = zeros(Int,83)
    sudokus = zeros(Int, (82,9,9))
    #sudokus[1,:] = sudoku_dict[45]
    sudokus[1,:] = sudoku
    q, revert_q, start_q = 2,[2],2
    guess_q = []
    while q<=82
        start_q = q
        x = mod(q-2,9)+1
        y = div(q-2,9)+1
        #println("$(q,strack[q])")
        sudokus[q,:,:] = sudokus[q-1,:,:]
        if sudoku_solved(reshape(sudokus[q,:,:], (9,9)))
            println("solved at q=$q")
            return reshape(sudokus[q,:,:], (9,9))
        elseif sudokus[q,x,y] > 0 && q < 82
            q+=1
        elseif strack[q] < 9 && q < 82
            strack[q] += 1
            if can_place(reshape(sudokus[q,:,:], (9,9)), x,y,strack[q])
                sudokus[q,x,y] = strack[q]
                sudokus[q,:] = do_all_moves(reshape(sudokus[q,:,:], (9,9)))
                push!(revert_q,q)
                q+=1
            end
        else
            q = pop!(revert_q)
            #println("reverting to $q")
            strack[q+1:end] = 0
        end
    end
    throw(error("didn't solve"))
end

start_time = time()
#function ignore()
    total = 0
    sudoku = []
    solved = []
    q=0
    for q = 1:50
        println("sudoku $q")
        #println(isolve(sudoku_dict[1]))
        solved = isolve(sudoku_dict[q])
        total += sum(solved[1,1:3].*[100 10 1])
    end

    println(total)
    println(time()-start_time)
#end
