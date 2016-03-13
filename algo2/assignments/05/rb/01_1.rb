require 'sqlite3'

$n = 25
MAX_INT = (2**(0.size * 8 - 2) - 1)

#begin
    db = SQLite3::Database.open "tsp.db"
    db.execute "create table if not exists paths(
        s integer not null,
        j integer not null,
        v real not null,
        primary key(s, j))"
    
    puts "-- table created"
	
	stmt = db.prepare("insert into paths values (?, ?, ?)")
    
    puts "-- stmt prepared"
    
    for s in 0..2**$n
    	for j in 0...$n
    		stmt.execute s, j, MAX_INT
    		#puts "-- inserted #{s}, #{j}, #{MAX_INT}"
    	end
    end

	stmt = db.prepare "select count(*) from paths"
    rs = stm.execute
	while (row = rs.next) do
        puts "Inserted: #{row}"
    end
            
#rescue SQLite3::Exception => e 
#    puts "Exception occured"
#    puts e
#ensure
#    db.close if db
#end