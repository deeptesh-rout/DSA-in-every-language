<?php
Function BucketSort(&$arr, $lowerRange, $upperRange) {
	$range = ($upperRange - $lowerRange);
	$i = 0;
	$j = 0;
	$size = count ( $arr );
	$count = array ();
	
	For($i = 0; $i < $range; $i ++) {
		$count [$i] = 0;
	}
	For($i = 0; $i < $size; $i ++) {
		 $count [$arr [$i] - $lowerRange]++;
	}
	$i = 0;
	For($i = 0; $i < $range; $i ++) {
		For(; $count [$i] > 0; $count [$i] --) {
			$arr [$j ++] = ($i + $lowerRange);
		}
	}
}

$arr = array (
		23,
		24,
		22,
		21,
		25,
		25,
		27,
		28,
		21,
		21 
);
BucketSort ( $arr, 20, 30 );
For($i = 0; $i < count ( $arr ); $i ++) {
	echo ($arr [$i]);
}
?>