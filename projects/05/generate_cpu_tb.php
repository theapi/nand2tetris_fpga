<?php

$contents = file('CPU.cmp');
foreach ($contents as $line) {
  $cols = explode('|', $line); 

  if (count($cols) == 11) {
    $num = trim($cols[1]);
    if (is_numeric($num)) {
      //var_dump($cols);
      print "instruction = 16'b$cols[3];\n";
      print "#4 assert_cpu(16'd".trim($cols[2]).", 16'b".trim($cols[3]).", 1'b".trim($cols[4]).", ";
      
      if (trim($cols[5]) == '*******') {
        print "16'dx, ";
      } else {
        if (trim($cols[5]) < 0) print "-";
        print "16'd".trim($cols[5], "- \t\n\r\0\x0B").", ";
      }
      
      print "1'b".trim($cols[6]).", 16'd".trim($cols[7]).", 16'd".trim($cols[8]).", ";
      if (trim($cols[9]) < 0) print "-";
      print "16'd".trim($cols[9], "- \t\n\r\0\x0B").");\n\n";
    }
  }
}
