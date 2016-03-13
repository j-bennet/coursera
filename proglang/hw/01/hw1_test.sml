(* is_older *)
val t1_01 = is_older((2001, 1, 1), (2002, 2, 2));
val t1_02 = is_older((2002, 1, 2), (2002, 2, 2));
val t1_03 = not(is_older((2002, 2, 1), (2002, 1, 2)));
val t1_04 = not(is_older((2002, 1, 1), (2002, 1, 1)));

(* number_in_month *)
val t2_01 = (number_in_month([(2000, 2, 1)], 2) = 1);
val t2_02 = (number_in_month([(2000, 1, 1), (2000, 2, 1), (2000, 2, 5)], 2) = 2);
val t2_03 = (number_in_month([(2000, 1, 1)], 2) = 0);
val t2_04 = (number_in_month([], 2) = 0);

(* number_in_months *)
val t3_01 = (number_in_months([], [2]) = 0);
val t3_02 = (number_in_months([(2000, 1, 1)], [2]) = 0);
val t3_03 = (number_in_months([(2000, 1, 1)], [1]) = 1);
val t3_04 = (number_in_months([(2000, 1, 1), (2000, 2, 1)], [1, 2]) = 2);
val t3_05 = (number_in_months([(2000, 1, 1), (2000, 2, 1)], [2]) = 1);

(* dates_in_month *)
val t4_01 = (dates_in_month([], 2) = []);
val t4_02 = (dates_in_month([(2000, 1, 1)], 2) = []);
val t4_03 = (dates_in_month([(2000, 1, 1)], 1) = [(2000, 1, 1)]);
val t4_04 = (dates_in_month([(2000, 1, 1), (2000, 2, 1)], 2) = [(2000, 2, 1)]);
val t4_05 = (dates_in_month([(2000, 1, 1), (2000, 2, 1)], 1) = [(2000, 1, 1)]);

(* dates_in_months *)
val t5_01 = (dates_in_months([], [2]) = []);
val t5_02 = (dates_in_months([(2000, 1, 1)], [2]) = []);
val t5_03 = (dates_in_months([(2000, 1, 1)], [1]) = [(2000, 1, 1)]);
val t5_04 = (dates_in_months([(2000, 1, 1), (2000, 2, 1)], [2]) = [(2000, 2, 1)]);
val t5_05 = (dates_in_months([(2000, 1, 1), (2000, 1, 2), (2000, 2, 1)], [1]) = [(2000, 1, 1), (2000, 1, 2)]);

(* get_nth *)
val t6_01 = (get_nth(["1"], 1) = "1");
val t6_02 = (get_nth(["1", "2", "3"], 2) = "2");
val t6_03 = (get_nth(["1", "2", "3", "4"], 3) = "3");
val t6_04 = (get_nth(["1", "2", "3", "4"], 4) = "4");

(* date_to_string *)
val t7_01 = (date_to_string((2001, 1, 20)) = "January 20, 2001");
val t7_02 = (date_to_string((2012, 12, 5)) = "December 5, 2012");

(* number_before_reaching_sum *)
val t8_01 = (number_before_reaching_sum(1, [1, 1, 1, 1, 1]) = 0);
val t8_02 = (number_before_reaching_sum(2, [1, 1, 1, 1, 1]) = 1);
val t8_03 = (number_before_reaching_sum(3, [1, 1, 1, 1, 1]) = 2);
val t8_04 = (number_before_reaching_sum(4, [1, 1, 1, 1, 1]) = 3);

(*what_month *)
val t9_01 = (what_month(1) = 1);
val t9_02 = (what_month(31) = 1);
val t9_03 = (what_month(32) = 2);
val t9_04 = (what_month(59) = 2);
val t9_05 = (what_month(60) = 3);

(* month_range *)
val t10_01 = (month_range(30, 33) = [1, 1, 2, 2]);
val t10_02 = (month_range(30, 30) = [1]);
val t10_03 = (month_range(30, 29) = []);
val t10_04 = (month_range(1, 31) = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]);
val t10_05 = (month_range(32, 59) = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]);
val t10_06 = (month_range(85, 145) = [3,3,3,3,3,3,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5]);

(* oldest *)
val t11_01 = (oldest([]) = NONE);
val t11_02 = (oldest([(2001, 1, 1)]) = SOME((2001, 1, 1)));
val t11_03 = (oldest([(2001, 1, 1), (2003, 1, 1), (2002, 1, 1)]) = SOME((2001, 1, 1)));
val t11_04 = (oldest([(2012, 1, 1), (2011, 1, 1), (2002, 1, 1)]) = SOME((2002, 1, 1)));
val t11_05 = (oldest([(~4, 2, 3), (2, 2, 3), (5, 2, 3), (~3, 2, 3)]) = SOME((~4, 2, 3)));