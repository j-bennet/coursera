fun silly1(z: int) =
    let
	val x = if z > 0 then z else 34
	val y = x + z + 9
    in
	if x > y then x * 2 else y * y
    end

fun silly3() =
    let
	val x = (let val x = 5 in x + 10 end);
    in
	(x, let val x = 2 in x end, let val x = 10 in let val x = 2 in x end end)
	    
    end
