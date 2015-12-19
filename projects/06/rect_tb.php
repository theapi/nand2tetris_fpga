<?php

$contents = file('Rect.hack');
print "#2 im_we = 1;\n";
foreach ($contents as $i => $line) {
  print "#2\n";
  print "im_address = 15'd" . $i . ";\n";
  print "im_d = 16'b" . trim($line) . ";\n\n";

}
print "#2 im_we = 0;\n";

