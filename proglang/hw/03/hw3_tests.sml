use "hw3.sml";

val p1 = TupleP([ConstP 12, Variable "var1", ConstructorP("constr1", Wildcard)])
val p2 = TupleP([Variable "var", Wildcard, TupleP([Variable "var", Wildcard, TupleP([Variable "var", Wildcard])])])
val p3 = TupleP([Variable "var1", Wildcard, TupleP([Variable "var2", Wildcard, TupleP([Variable "var3", Wildcard])])])

val t01_01 = only_capitals([]) = []
val t01_02 = only_capitals(["aaa", "bbb", "ccc"]) = []
val t01_03 = only_capitals(["aaa", "Bbb", "ccc"]) = ["Bbb"]
val t01_04 = only_capitals(["Aaa", "Bbb", "Ccc"]) = ["Aaa", "Bbb", "Ccc"]

val t02_01 = longest_string1([]) = ""
val t02_02 = longest_string1(["a"]) = "a"
val t02_03 = longest_string1(["a", "bb", "c"]) = "bb"
val t02_04 = longest_string1(["a", "b", "cc"]) = "cc"
val t02_05 = longest_string1(["a", "bb", "cc"]) = "bb"

val t03_01 = longest_string2([]) = ""
val t03_02 = longest_string2(["a"]) = "a"
val t03_03 = longest_string2(["a", "bb", "c"]) = "bb"
val t03_04 = longest_string2(["a", "b", "cc"]) = "cc"
val t03_05 = longest_string2(["a", "bb", "cc"]) = "cc"

val t04_01 = longest_string3([]) = ""
val t04_02 = longest_string3(["a"]) = "a"
val t04_03 = longest_string3(["a", "bb", "c"]) = "bb"
val t04_04 = longest_string3(["a", "b", "cc"]) = "cc"
val t04_05 = longest_string3(["a", "bb", "cc"]) = "bb"

val t05_01 = longest_string4([]) = ""
val t05_02 = longest_string4(["a"]) = "a"
val t05_03 = longest_string4(["a", "bb", "c"]) = "bb"
val t05_04 = longest_string4(["a", "b", "cc"]) = "cc"
val t05_05 = longest_string4(["a", "bb", "cc"]) = "cc"

val t06_01 = longest_capitalized(["a", "bb", "C"]) = "C"
val t06_02 = longest_capitalized(["Aaa", "Bb", "Cc"]) = "Aaa"
val t06_03 = longest_capitalized(["A", "bb", "cc"]) = "A"

val t07_01 = rev_string("a") = "a"
val t07_02 = rev_string("abc") = "cba"
val t07_03 = rev_string("") = ""

val t08_01 = (first_answer (fn x => if x > 0 then SOME(x) else NONE) [~1, ~2, 1, 2]) = 1
val t08_02 = ((first_answer (fn x => if x > 0 then SOME(x) else NONE) [~1, ~2, ~3]) handle NoAnswer => 9999) = 9999

val t09_01 = (all_answers (fn x => if List.length(x) > 0 then SOME(x) else NONE) []) = SOME([])
val t09_02 = (all_answers (fn x => if List.length(x) > 0 then SOME(x) else NONE) [[1], [2]]) = SOME([1, 2])
val t09_03 = (all_answers (fn x => if List.length(x) > 0 then SOME(x) else NONE) [[], [2]]) = NONE

val t9a_01 = count_wildcards(p1) = 1
val t9a_02 = count_wildcards(p2) = 3
val t9a_03 = count_wildcards(UnitP) = 0

val t9b_01 = count_wild_and_variable_lengths p1 = 5;
val t9b_02 = count_wild_and_variable_lengths UnitP = 0;
val t9b_03 = count_wild_and_variable_lengths p2 = 12;

val t9c_01 = count_some_var("var1", p1) = 1;
val t9c_02 = count_some_var("whatever", UnitP) = 0;
val t9c_03 = count_some_var("var", p2) = 3;

val t10_01 = check_pat(TupleP [Variable "my_var", Variable "my_var"]) = false
val t10_02 = check_pat(TupleP [Variable "my_var", UnitP, Wildcard, Variable "my_var"]) = false
val t10_03 = check_pat(TupleP [Variable "my_var", UnitP, Wildcard, Variable "other_var"]) = true

val t11_01 = match(Const 16, Wildcard) = SOME []
val t11_02 = match(Const 16, ConstP 16) = SOME []
val t11_03 = match(Constructor("my_constructor", Const 13), ConstructorP("my_constructor", Variable "my_var")) = SOME [("my_var", Const 13)]
val t11_04 = match(Tuple [Const 13, Const 17], TupleP [Variable "my_var", Variable "other_var"]) = SOME [("my_var", Const 13), ("other_var", Const 17)]

val t12_01 = first_match (Const 16) [UnitP, Wildcard, Variable "my_var"] = SOME []
val t12_02 = first_match (Const 16) [UnitP, Variable "my_var", Wildcard] = SOME [("my_var", Const 16)]
val t12_03 = first_match (Const 16) [UnitP, ConstP 32, ConstructorP ("my_constructor", Variable "my_var")] = NONE
