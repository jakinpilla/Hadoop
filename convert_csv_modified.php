# step1 : modifying "convert_csv.php"

<?php
$fp_in = fpopen("u.data", "r");
$fp_out = fopen("movies.csv", "w+");

while($str = fgets($fp_in, 1024)) {
	$str_array = split("\t", $str);
	$outs = $str_array[0]."\t".$str_array[1]."\t".$str_array[3];
	fputs($fp_out, $outs);
};

fclose($fp_in);
fclose($fp_out);
?>

