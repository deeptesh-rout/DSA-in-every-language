<?php
Function less($valuel, $value2) {
	return ($valuel < $value2);
}
Function more($valuel, $value2) {
	return ($valuel > $value2);
}
Function BubbleSort(&$arr) {
	$size = count ( $arr );
	$i = null;
	$j = null;
	$temp = null;
	For($i = 0; $i < ($size - 1); ++ $i) {
		For($j = 0; $j < (($size - $i) - 1); ++ $j) {
			iF (more ( $arr [$j], $arr [($j + 1)] )) {
				$temp = $arr [$j];
				$arr [$j] = $arr [($j + 1)];
				$arr [($j + 1)] = $temp;
			}
		}
	}
}
Function BubbleSort2(&$arr) {
	$size = count ( $arr );
	$i = null;
	$j = null;
	$temp = null;
	$swapped = 1;
	For($i = 0; $i < ($size - 1) && ($swapped == 1); ++ $i) {
		$swapped = 0;
		For($j = 0; $j < ($size - $i - 1); ++ $j) {
			iF (more ( $arr [$j], $arr [$j + 1] )) {
				$temp = $arr [$j];
				$arr [$j] = $arr [$j + 1];
				$arr [$j + 1] = $temp;
				$swapped = 1;
			}
		}
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
BubbleSort ( $arr );
For($i = 0; $i < count ( $arr ); ++ $i) {
	echo ($arr [$i] . " ");
}
?>