<?php

$pdo=new PDO('mysql:host=localhost;dbname=my_db;port=8889','root','root');
 $pdo->exec('set names utf8');
if(!pod){
    echo "数据库连接失败"."<br>";
}else{
    
    echo"数据库连接成功"."<br>";
}
//$sql=<<<EOF
//         create table IF NOT EXISTS Student(
//                 numberId int AUTO_INCREMENT,
//                 PRIMARY KEY(numberId),
//                 name varchar(20),
//                 age int=);
// EOF;
 // $res=$pdo->exec($sql);
//  
//     
//  if($res){
//      
//      echo "创建成功";
//  }else{
//   echo "创建表不成功";
//  }

//$sql = "SELECT * FROM Persons ";
//
//$result = $pdo->query($sql);

$delete=$pod->prepare("delete from Persons where id=1");  
$delete->execute();  






//  $pod->close();
?>