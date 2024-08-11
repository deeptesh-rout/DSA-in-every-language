<?php

Function more($valuel, $value2) {
	return ($valuel > $value2);
}

Function InsertionSort(&$arr)
{
	$size = count($arr);
	$temp = null;
	$j = null;
	For($i = 1; ($i < $size); ++ $i) {
		$temp = $arr [$i];
		For($j = $i; (($j > 0) && more( $arr [($j - 1)], $temp )); -- $j) {
			$arr [$j] = $arr [$j - 1];
		}
		$arr [$j] = $temp;
	}
}

$arr = array (
		9,
		1,
		8,
		2,
		7,
		3,
		6,
		4,
		5 
);
InsertionSort ( $arr );
For($i = 0; $i < count ( $arr ); ++ $i) {
	echo ($arr [$i] . " ");
}
?>