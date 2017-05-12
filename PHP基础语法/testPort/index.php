


        <?php
        
            $data = array(
            "tid" => 100, 
            "name" => "测试",
            "site" => "www.huangyibiao.com");

            $response = array( 
            "code"  => 200, 
            "message" => "success for request",
            "data"  => $data,
            );

//
//             for($i = 0 ; $i< count($response); $i++){
//                 
//                 echo $response["code"];
//             }
            
//foreach ($response as $key => $value) {
//    echo "key = ".$key.",value=".$value."<br>";
//} 

            echo json_encode($response);
    
        // put your code here
        ?>
 