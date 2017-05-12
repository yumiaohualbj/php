

    <?php
        $servername = "localhost";
        $username ="root";
        $pass = "root";
        $port ="8889";
        $dbname = "my_db";
        
        //------第一种方法mysqli面向对象-------
        //创建连接
     
        $conn = new  mysqli($servername, $username, $pass, $dbname, $port);
      
        //检测连接
        if($conn->connect_error){
            
            echo "连接失败";
            die("连接失败:".$conn->connect_error);
        }else{
            
             echo "连接成功";
        }
        
       //预处理
       $sql = "SELECT * FROM USERS1 WHERE  firstname='yu'";

        $result = $conn->query($sql);
     
        foreach ($result as $key => $value) {
            foreach ($value as $key1 => $value1) {
                echo $value1."<br>";
            }
}
$conn->close();     
//if ($conn->query($sql) === TRUE) {
//    echo "mysqli插入记录成功";
//} else {
//    echo "数据插入错误: " . $conn->error;
//}

        
        
        
        
        
        
 
//  try {
//     $conn1 = new PDO("mysql:host=$servername;dbname=$dbname",$username,$pass);
//         // 设置 PDO 错误模式，用于抛出异常
//    $conn1->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
//    $sql1 = "INSERT INTO USER2(firstname,lastname,email)VALUES('yu','miaohua','yumiaohua@163.com') ";
//
//  
//     $conn1->exec($sql1);
//     echo "p'd插入记录成功";
//} catch (Exception $exc) {
//    echo $exc->getTraceAsString();
//}


?>


