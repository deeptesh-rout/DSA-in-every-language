<?php
Function swap(&$arr, $first, $second) {
	$temp = $arr [$first];
	$arr [$first] = $arr [$second];
	$arr [$second] = $temp;
}
Function quickSelect(&$arr, $lower, $upper, $k) {
	if ($upper <= $lower)
		return;
	$pivot = $arr [$lower];
	$start = $lower;
	$stop = $upper;
	while ( $lower < $upper ) {
		while ( ($arr [$lower] <= $pivot) && ($lower < $upper) ) {
			++ $lower;
		}
		while ( ($arr [$upper] > $pivot) && ($lower <= $upper) ) {
			-- $upper;
		}
		if ($lower < $upper) {
			swap ( $arr, $upper, $lower );
		}
	}
	swap ( $arr, $upper, $start );
	if ($k < $upper)
		quickSelect ( $arr, $start, ($upper - 1), $k );
	if ($k > $upper)
		quickSelect ( $arr, ($upper + 1), $stop, $k );
}
Function quickSelectWrapper(&$arr, $k) {
	quickSelect ( $arr, 0, (count ( $arr ) - 1), $k - 1 ); // Kth element at k-1 index.
	return $arr [$k - 1];
}

$arr = Array (
		3,
		4,
		2,
		1,
		6,
		5,
		9,
		8,
		10,
		7 
);
	
echo ("value at index 7 is : " . quickSelectWrapper ( $arr, 7 ));
?>



