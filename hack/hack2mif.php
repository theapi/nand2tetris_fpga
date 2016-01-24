#!/usr/bin/php

<?php
/**
 * Translates a .hack file to a Quartus .mif file
 */


if (empty($argv[1])) {
    echo "No file provided\n";
    exit();
}

$file = $argv[1];
if (!is_file($file)) {
    exit($file . " not found\n");
}

$info = pathinfo($file);
if ($info['extension'] != 'hack') {
    exit($file . " must be a .hack file \n");
}

$filename = $info['filename'];
$dir = $info['dirname'];
$output_file = $dir . '/' . $filename . '.mif';

$lines = file($file, FILE_IGNORE_NEW_LINES);

if (!$fp = fopen($output_file, "w")) {
    exit("unable to open input file: $file.\n");
}


// @todo change DEPTH when more program ram available.
$init = '
WIDTH=16;
DEPTH=8192;

ADDRESS_RADIX=UNS;
DATA_RADIX=BIN;

CONTENT BEGIN
';
write($fp, $init);

foreach( $lines as $i => $line) {
    $data = '    ' . $i . '  :   ' . $line . ";\n";
    write($fp, $data);
}

$end = '    [' . ++$i . '..8191]  :   0000000000000000;' . "\n";
$end .= "END;\n";
write($fp, $end);

fclose($fp);

function write($fp, $data) {
    echo $data;
    if (fwrite($fp, $data) === FALSE) {
        exit("Unable to write to output file.\n");
    }
}