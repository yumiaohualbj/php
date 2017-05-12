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
        <h1>加载和输出xml</h1>
        <h2>load()加载xml文件,saveXML()函数把内部xml文档放入一个字符串内,我们可以进行输出</h2>
        <?php
//        $xmlDoc = new DOMDocument();
//        $xmlDoc->load("test.xml");
//        print $xmlDoc->saveXML();
        ?>
         <h1>循环xml</h1>
         <?php
            $xmlDoc = new DOMDocument();
$xmlDoc->load("test.xml");

$x = $xmlDoc->documentElement;
foreach ($x->childNodes AS $item)
  {
  print $item->nodeName . " = " . $item->nodeValue . "<br />";
  }
  
  $xml = simplexml_load_file("test.xml");

echo $xml->getName() . "<br />";

foreach($xml->children() as $child)
  {
  echo $child->getName() . ": " . $child . "<br />";
  }
         ?>
    </body>
</html>
