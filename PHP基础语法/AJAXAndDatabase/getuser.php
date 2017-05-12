<?php
echo "php代码";
$q=$_GET["q"];


$pdo = PDO('mysql:host=localhost;dbname=my_db;port=8889','root','root');
if (!$pdo)
 {
 die('Could not connect: ' );
 }else{
     
     echo "连接数据库成功";
 }



$sql="SELECT * FROM user WHERE id = '".$q."'";

 $result = $pdo->query($sql);

echo "<table border='1'>
<tr>
<th>Firstname</th>
<th>Lastname</th>
<th>Age</th>
<th>Hometown</th>
<th>Job</th>
</tr>";

//while($row = mysql_fetch_array($result))
// {
// echo "<tr>";
// echo "<td>" . $row['FirstName'] . "</td>";
// echo "<td>" . $row['LastName'] . "</td>";
// echo "<td>" . $row['Age'] . "</td>";
// echo "<td>" . $row['Hometown'] . "</td>";
// echo "<td>" . $row['Job'] . "</td>";
// echo "</tr>";
// }
//echo "</table>";
//
//mysql_close($con);
$pdo->colse();
?>

