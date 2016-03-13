exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

fun only_capitals(xs) =
	List.filter (fn x => Char.isUpper(String.sub(x, 0))) xs

fun longest_string1(xs) =
	List.foldl (fn (x, acc) => if String.size x > String.size acc then x else acc) "" xs

fun longest_string2(xs) =
	List.foldl (fn (x, acc) => if String.size x >= String.size acc then x else acc) "" xs

fun longest_string_helper f xs =
	List.foldl (fn (x, acc) => if f(String.size x, String.size acc) then x else acc) "" xs

val longest_string3 = fn xs =>
	longest_string_helper (fn (x, acc) => x > acc) xs

val longest_string4 = fn xs =>
	longest_string_helper (fn (x, acc) => x >= acc) xs

val longest_capitalized = fn xs =>
	(longest_string1 o only_capitals) xs

fun rev_string(s) =
	(String.implode o List.rev o String.explode) s

fun first_answer f xs =
	case xs of
	[] => raise NoAnswer
	| x::xs' => case f(x) of
		SOME(t) => t
		| _ => first_answer f xs' 

fun all_answers f xs =
	let fun helper(acc, lst) =
		case lst of
		[] => SOME(acc)
		| y::ys => case f(y) of
			NONE => NONE
			| SOME t => helper(acc @ t, ys)
	in
		helper([], xs)
	end

fun count_wildcards p =
	g (fn x => 1) (fn x => 0) p

fun count_wild_and_variable_lengths p =
	g (fn x => 1) (fn x => String.size x) p

fun count_some_var(v, p) =
	g (fn x => 0) (fn x => if x = v then 1 else 0) p

fun check_pat p =
	let
	fun all_vars p =
		case p of
    		Wildcard             => []
    		| Variable x         => [x]
    		| TupleP ps          => List.foldl (fn (p, i) => (all_vars p) @ i) [] ps
    		| ConstructorP(_, p) => all_vars p
    		| _                  => []
	fun repeats xs =
		case xs of
			[] => false
			| x::xs' => List.exists (fn s => s = x) xs' orelse repeats xs'
	in
		not(repeats(all_vars p))
	end

fun match(v, p) =
	let fun match_const(pat) =
		case v of
			Const c => if (c = pat) then SOME [] else NONE
			| _ => NONE
	fun match_constructor(name, pat) =
		case v of
			Constructor(vname, v') => if (name = vname) then match(v', pat) else NONE
			| _ => NONE
	fun match_tuple(ps) =
		case v of
			Tuple vs => if (List.length ps) = (List.length vs)
				then all_answers match (ListPair.zip(vs, ps))
				else NONE
			| _ => NONE
	fun match_unit() =
		case v of
			Unit => SOME []
			| _ => NONE
	in
	case p of
		Wildcard => SOME []
		| Variable s => SOME [(s, v)]
		| UnitP => match_unit()
		| ConstP s => match_const(s)
		| ConstructorP(name, pat) => match_constructor(name, pat)
		| TupleP ps => match_tuple(ps)
	end

fun first_match v ps =
	SOME(first_answer (fn(p) => match(v, p)) ps)
	handle NoAnswer => NONE
