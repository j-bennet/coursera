(* Dan Grossman, Coursera PL, HW2 Provided Tests *)

(* These are just two tests for problem 2; you will want more.

   Naturally these tests and your tests will use bindings defined 
   in your solution, in particular the officiate function, 
   so they will not type-check if officiate is not defined.
 *)

val cards1 = [(Clubs,Jack),(Spades,Num(8))]
val cards2 = [(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)]
val cards3 = [(Clubs,Ace),(Diamonds,King)]

val t1a_01 = (all_except_option("a", []) = NONE);
val t1a_02 = (all_except_option("a", ["b", "c"]) = NONE);
val t1a_03 = (all_except_option("a", ["b", "a", "c"]) = SOME(["b", "c"]));

val t2a_01 = (get_substitutions1([["Fred","Fredrick"], ["Elizabeth","Betty"], ["Freddie","Fred","F"]], "Fred") = ["Fredrick", "Freddie", "F"]);
val t2a_02 = (get_substitutions1([["Fred","Fredrick"], ["Jeff","Jeffrey"], ["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey", "Geoff", "Jeffrey"]);

val t3a_01 = (get_substitutions2([["Fred","Fredrick"], ["Elizabeth","Betty"], ["Freddie","Fred","F"]], "Fred") = ["Fredrick", "Freddie", "F"]);
val t3a_02 = (get_substitutions2([["Fred","Fredrick"], ["Jeff","Jeffrey"], ["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey", "Geoff", "Jeffrey"]);

val t4a_02 = (similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) = 
	[{first="Fred", last="Smith", middle="W"}, 
	 {first="Fredrick", last="Smith", middle="W"}, 
	 {first="Freddie", last="Smith", middle="W"}, 
	 {first="F", last="Smith", middle="W"}]);

val t2a_01 = (card_color((Clubs, Ace)) = Black);
val t2a_02 = (card_color((Spades, Ace)) = Black);
val t2a_03 = (card_color((Hearts, Ace)) = Red);
val t2a_03 = (card_color((Diamonds, Ace)) = Red);

val t2b_01 = (card_value((Diamonds, Ace)) = 11);
val t2b_02 = (card_value((Diamonds, Num(8))) = 8);
val t2b_03 = (card_value((Diamonds, Jack)) = 10);

val t2c_01 = (remove_card([(Clubs,Ace), (Spades,Ace), (Clubs,Ace), (Spades,Ace)], (Spades,Ace), IllegalMove) = [(Clubs,Ace), (Clubs,Ace), (Spades,Ace)]);
val t2c_02 = (remove_card([(Clubs,Ace), (Clubs,Ace), (Spades,Ace), (Clubs,Ace), (Spades,Ace)], (Spades,Ace), IllegalMove) = [(Clubs,Ace), (Clubs,Ace), (Clubs,Ace), (Spades,Ace)]);
val t2c_03 = (remove_card([(Clubs,Ace), (Spades,Ace), (Clubs,Ace), (Spades,Ace)], (Spades,Num(8)), IllegalMove) handle IllegalMove => []) = [];

val t2d_01 = (all_same_color([(Clubs,Num(6)), (Clubs,Num(7)), (Spades,Num(8)), (Clubs,Queen), (Spades,Ace)]) = true);
val t2d_02 = (all_same_color([(Clubs,Num(6)), (Hearts,Num(7)), (Spades,Num(8)), (Clubs,Queen), (Spades,Ace)]) = false);
val t2d_03 = (all_same_color([]) = true);
val t2d_04 = (all_same_color([(Spades,Ace)]) = true);
val t2d_05 = all_same_color([(Diamonds,Ace), (Spades,Ace), (Clubs,Ace)]) = false

val t2e_01 = (sum_cards([(Hearts, Ace)]) = 11);
val t2e_02 = (sum_cards([]) = 0);
val t2e_03 = (sum_cards([(Hearts, Queen), (Spades, Num(6))]) = 16);
val t2e_04 = sum_cards(cards1)=18
val t2e_05 = sum_cards(cards2)=44
val t2e_06 = sum_cards(cards3)=21

val t2f_01 = score([(Clubs,Ace),(Diamonds,King)], 21) = 0
val t2f_02 = score([(Clubs,Ace),(Diamonds,King)], 25) = 4
val t2f_03 = score([(Clubs,Ace),(Diamonds,King)], 17) = 12
val t2f_04 = score([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], 44) = 0
val t2f_05 = score([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], 48) = 2
val t2f_06 = score([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], 40) = 6
val t2f_07 = score([(Clubs,Ace), (Spades,Ace), (Clubs,Ace), (Spades,Ace)], 42) = 3
val t2f_08 = score([(Diamonds,Ace), (Spades,Ace), (Clubs,Ace)], 30) = 9

val t2g_00 = (officiate([(Clubs, Jack), (Spades, Num(8))], [Draw, Discard(Hearts, Jack)], 42) handle IllegalMove => 9999) = 9999;
val t2g_01 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], [Draw,Draw,Draw,Draw,Draw],42)=3

val t2g_02 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], [Draw,Draw,Draw,Draw,Draw],30)=4
val t2g_03 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], [Draw,Draw,Draw,Draw,Draw],22)=16
val t2g_04 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], [Draw,Draw,Draw,Draw,Draw],100)=28
val t2g_05 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], [Draw,Draw,Draw,Draw,Draw],44)=0


val t2g_06 = officiate([(Diamonds,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], [Draw,Draw,Draw,Draw,Draw],30)=9

val t2g_07 = officiate([(Clubs,Ace),(Hearts,Ace),(Clubs,Ace),(Spades,Ace)], [Draw,Draw,Draw,Draw,Draw],22)=33
val t2g_08 = officiate([(Clubs,Ace),(Spades,Ace),(Diamonds,Ace),(Spades,Ace)], [Draw,Draw,Draw,Draw,Draw],100)=56
val t2g_09 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Hearts,Ace)], [Draw,Draw,Draw,Draw,Draw],44)=0

fun provided_test1() = (* correct behavior: raise IllegalMove *)
    let val cards = [(Clubs,Jack),(Spades,Num(8))]
	val moves = [Draw,Discard(Hearts,Jack)]
    in
	officiate(cards,moves,42)
    end

fun provided_test2() = (* correct behavior: return 3 *)
    let val cards = [(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)]
	val moves = [Draw,Draw,Draw,Draw,Draw]
    in
 	officiate(cards,moves,42)
    end

val prov1 = (provided_test1() handle IllegalMove => 9999) = 9999
val prov2 = provided_test2() = 3

