<?php
Function more($valuel, $value2) {
	return ($valuel > $value2);
}
Function SelectionSort(&$arr) {
	$size = count ( $arr );
	$i = null;
	$j = null;
	$max = null;
	$temp = null;
	For($i = 0; $i < ($size - 1); ++ $i) {
		$max = 0;
		For($j = 1; ($j < (($size - 1) - $i)); ++ $j) {
			iF ($arr [$j] > $arr [$max]) {
				$max = $j;
			}
		}
		$temp = $arr [($size - 1) - $i];
		$arr [($size - 1) - $i] = $arr [$max];
		$arr [$max] = $temp;
	}
}
Function SelectionSort2(&$arr) {
	$size = count ( $arr );
	$i = null;
	$j = null;
	$min = null;
	$temp = null;
	For($i = 0; $i < ($size - 1); ++ $i) {
		$min = $i;
		For($j = ($i + 1); ($j < $size); ++ $j) {
			iF ($arr [$j] < $arr [$min]) {
				$min = $j;
			}
		}
		$temp = $arr [$i];
		$arr [$i] = $arr [$min];
		$arr [$min] = $temp;
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
SelectionSort ( $arr );
For($i = 0; $i < count ( $arr ); ++ $i) {
	echo ($arr [$i] . " ");
}
?>