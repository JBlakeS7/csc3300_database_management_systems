<?php
	$con = mysql_connect('localhost', 'root', 'coursework')
		or die('Could not connect: ' . mysql_error());
	#echo 'Connected';
	mysql_select_db('TTU') or die ("could not select database");

	$query = "select TNumber , CourseID, count(CourseID) as numAttmt, min(Grade) as 'BestGrade' from students natural join grades group by TNumber desc, CourseID having numAttmt > 1";
	$result = mysql_query($query) or die("query failed: " . mysql_error());

	$tnum = " ";
	echo "<table border= \"1\">\n";
	while ($line = mysql_fetch_array($result, MYSQL_ASSOC))
	{
		echo "\t<tr>\n";

		#My failed attempt to get it to not repeat values in output
#		for($i = 0; $i < 5; $i++)
#		{
#			if($i == 0 && $result[$i] != $tnum)
#			{
#				$tnum = $result[$i];
#				echo "\t\t<td>$tnum</td>\n";
#			}
#			elseif($i==0)
#			{
#				echo "\t\t<td> </td>\n";
#			}
#			else
#			{
#				echo "\t\t<td>$result[$i]</td>\n";
#			}			
#		}

		foreach ($line as $col_value) 
		{

			echo "\t\t<td>$col_value</td>\n";
		}
		echo "\t</tr>\n";
	}

	echo "</table>\n";

	mysql_free_result($result);
	mysql_close();
?>