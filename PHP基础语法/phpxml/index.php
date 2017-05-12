<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <h1>初始化 XML 解析器</h1>
        <?php
        $parser = xml_parser_create();
        
        function start($parser,$element_name,$element_attrs) {
            switch ($element_name) {
                case "NOTE":
                echo "-- note -- <br/>";
                    break;
                case "TO":
                echo "to:";
                break;
                case "FROM":
                echo "from:";   
                break;
                case "HEADING":
                echo "heading:";
                break;
                case "BODY":
                echo "Message:";
                break;
                default:
                    break;
            }
        }
        
        
        function stop($parser,$element_name) {
            echo "<br/>";
        }
        
        function char($parser,$data) {
            echo $data; 
        }
        
        xml_set_element_handler($parser, "start", "stop");
        xml_set_character_data_handler($parser, "char");
        //open xml file
        $fp = fopen("test.txt", "r");
       //read data
       while ($data = fread($fp, 4096)){
           xml_parse($parser,$data,feof($fp)) or 
  die (sprintf("XML Error: %s at line %d", 
  xml_error_string(xml_get_error_code($parser)),
  xml_get_current_line_number($parser)));
       }
       
       xml_parser_free($parser);
        // put your code here
        ?>
    </body>
</html>
