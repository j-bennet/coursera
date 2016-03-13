fun is_older(d1: int * int * int, d2: int * int * int) =
	(#1 d1 < #1 d2)
	orelse ((#1 d1 = #1 d2) andalso (#2 d1 < #2 d2))
	orelse ((#1 d1 = #1 d2) andalso (#2 d1 = #2 d2) andalso (#3 d1 < #3 d2))

fun number_in_month(dates: (int * int * int) list, month: int) =
    if null dates
    then 0
    else if (#2 (hd dates) = month)
    then 1 + number_in_month(tl dates, month)
    else number_in_month(tl dates, month)

fun number_in_months(dates: (int * int * int) list, months: int list) =
    if null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)

fun dates_in_month(dates: (int * int * int) list, month: int) =
    if null dates
    then []
    else if (#2 (hd dates) = month)
    then (hd dates) :: dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)

fun dates_in_months(dates: (int * int * int) list, months: int list) =
    if null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)
		       
fun get_nth(xs: string list, n: int) =
    if n <= 0
    then ""
    else if n = 1
    then hd xs
    else get_nth(tl xs, n - 1)

fun date_to_string(date: int * int * int) =
    get_nth(["January","February","March","April","May","June","July","August","September","October","November","December"], #2 date) ^
    	" " ^ (Int.toString (#3 date)) ^
    	", " ^ (Int.toString (#1 date));

fun number_before_reaching_sum(sum: int, xs: int list) =
    if null xs orelse (hd xs) >= sum
    then 0
    else 1 + number_before_reaching_sum(sum - (hd xs), tl xs)
			       
fun what_month(d_of_y: int) =
    1 + number_before_reaching_sum(d_of_y, [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])

fun month_range(day1: int, day2: int) =
    if day1 > day2
    then []
    else what_month(day1) :: month_range(day1 + 1, day2)

fun oldest(xs: (int * int * int) list) =
    if null xs then NONE
    else
	let
	    fun max_date(t: int * int * int, xs: (int * int * int) list) =
		if null xs
		then SOME(t)
		else
		    let val txs = tl xs
		    in
			if null txs andalso is_older(t, hd xs)
			then SOME(t)
			else if null txs
			then SOME(hd xs)
			else if is_older(t, hd xs)
			then max_date(t, txs)
			else max_date(hd xs, txs)
		    end
	in
	    max_date(hd xs, tl xs)
	end

