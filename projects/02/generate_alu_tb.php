<?php

$tst = file('ALU.tst');
$cmp = file('ALU.cmp');

$count = 0;

foreach ($tst as $tst_num => $tst_line) {
  // start at $tst_num == 12
  if ($tst_num < 12) continue;
  
  $tst_line = preg_replace('!\s+!', ' ', $tst_line);
  $cols = explode(' ', $tst_line);
  
  if (trim($cols[0]) == '//') {
    print "\n" . $tst_line . "\n";
  }
  
  if (trim($cols[0]) == 'set') {
    $val = trim($cols[2]);
    $val = str_replace(",", ";", $val);
    if (strlen($val) > 2) {
      $val = str_replace("%", "16'", $val);
    }
    print trim($cols[1]) . " = " . $val . "\n";
  }
  
  if (trim($cols[0]) == 'eval,') {
    $count++;
    $targets = explode('|', $cmp[$count]);
    print "#2 assert_alu(16'b" . trim($targets[9]) . ", 1'b" . trim($targets[10]) . ", 1'b" . trim($targets[11]) . ");\n\n";
    //print $cmp[$count] . "\n";
  }
}

/*
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
*/

