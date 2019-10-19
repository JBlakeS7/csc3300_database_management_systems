package require tdbc::mysql

tdbc::mysql::connection create db -database TTU -user root -password coursework
set stmt [db prepare {select * from students where LastName like 'D%'}]
#set stmt [db prepare {select * from students}] #For testing purposes
set results [$stmt allrows]

foreach row $results {
	foreach {ctnum tnum cfn fn cln ln cbdate bdate} $row {
  		puts [format "%-20s %-20s %-20s %s" $ctnum $cfn $cln $cbdate]
  		puts [format "%-20s %-20s %-20s %s" $tnum $fn $ln $bdate]
   	}
   	puts ""
}

db close

