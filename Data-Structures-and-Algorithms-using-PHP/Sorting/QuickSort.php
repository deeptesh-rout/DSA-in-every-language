<?php
Function less($valuel, $value2) {
	return ($valuel < $value2);
}
Function more($valuel, $value2) {
	return ($valuel > $value2);
}
Function swap(&$arr, $First, $second) {
	$temp = $arr [$First];
	$arr [$First] = $arr [$second];
	$arr [$second] = $temp;
}
Function QuickSort(&$arr) {
	$size = count ( $arr );
	QuickSortUtil ( $arr, 0, $size - 1 );
}
Function QuickSortUtil(&$arr, $lower, $upper) {
	iF (($upper <= $lower))
		return;
	$pivot = $arr [$lower];
	$start = $lower;
	$stop = $upper;
	while ( ($lower < $upper) ) {
		while ( (($arr [$lower] <= $pivot) && ($lower < $upper)) ) {
			++ $lower;
		}
		while ( (($arr [$upper] > $pivot) && ($lower <= $upper)) ) {
			-- $upper;
		}
		iF (($lower < $upper)) {
			swap ( $arr, $upper, $lower );
		}
	}
	swap ( $arr, $upper, $start );
	QuickSortUtil ( $arr, $start, ($upper - 1) );
	QuickSortUtil ( $arr, ($upper + 1), $stop );
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
QuickSort ( $arr );
For($i = 0; $i < count ( $arr ); ++ $i) {
	echo ($arr [$i] . " ");
}
?>