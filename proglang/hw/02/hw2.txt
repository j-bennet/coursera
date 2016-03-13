(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
	s1 = s2

(* 1 a *)
fun all_except_option(s: string, l: string list) =
	case l of
		[] => NONE
		| x::xs => if same_string(x, s)
			then SOME(xs)
			else case all_except_option(s, xs) of
				SOME ts => SOME(x::ts)
				| _ => NONE

(* 1 b *)
fun get_substitutions1(l: string list list, s: string) =
	case l of
		[] => []
		| first::others => case all_except_option(s, first) of
			SOME xs => xs @ get_substitutions1(others, s)
			| _ => get_substitutions1(others, s)

(* 1 c *)
fun get_substitutions2(l: string list list, s: string) =
	let fun helper(lst: string list list, acc: string list) =
		case lst of
			[] => acc
			| first::others => case all_except_option(s, first) of
				SOME xs => helper(others, acc @ xs)
				| _ => helper(others, acc)
	in
		helper(l, [])
	end

(* 1 d *)
fun similar_names(lst: string list list, {first=f, last=l, middle=m}) =
	let fun helper(options: string list, acc: {first:string, last:string, middle:string} list) =
		case options of
			[] => acc
			| x::xs => helper(xs, acc @ [{first=x, last=l, middle=m}])
	in
		helper(get_substitutions2(lst, f), [{first=f, last=l, middle=m}])
	end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(*2 a *)
fun card_color(c: card) =
	case c of
		(Spades, _) => Black
		| (Clubs, _) => Black
		| (Diamonds, _) => Red
		| (Hearts, _) => Red

(*2 b *)
fun card_value(c: card) =
	case c of
		(_, Ace) => 11
		| (_, Num i) => i
		| (_, _) => 10

(*2 c *)
fun remove_card(cs: card list, c: card, e) =
	case cs of
		[] => raise e
		| x::xs => if x = c
			then xs
			else case remove_card(xs, c, e) of
				t::ts => x::t::ts
				| _ => raise e
(*2 d *)
fun all_same_color(cs: card list) =
	case cs of
		[] => true
		| _::[] => true
		| a::b::tail => card_color(a) = card_color(b) andalso all_same_color(b::tail)

(* 2 e *)
fun sum_cards(cs: card list) =
	let fun helper(l: card list, acc: int) =
		case l of
			[] => acc
			| x::xs => helper(xs, acc + card_value(x))
	in
		helper(cs, 0)
	end

(* 2 f *)
fun score(cs: card list, goal: int) =
	let val sum = sum_cards(cs)
	in
		let val pre = (if sum > goal then 3 * (sum - goal) else (goal - sum))
		in
			if all_same_color(cs)
			then pre div 2
			else pre
		end 
	end

(* 2 g *)
fun officiate(cs: card list, ms: move list, goal: int) =
	let fun helper(l: card list, held: card list, moves: move list) =
		case moves of
			[] => score(held, goal)
			| m::mvs => case m of
				Discard c => helper(l, remove_card(held, c, IllegalMove), mvs)
				| Draw => case l of
					[] => score(held, goal)
					| x::xs => let val helds = x::held
					in
						if sum_cards(helds) > goal
						then score(helds, goal)
						else helper(xs, helds, mvs)
					end
	in
		helper(cs, [], ms)
	end
