<?php
Function Merge(&$arr, &$tempArray, $lowerIndex, $middleIndex, $upperIndex) {
	$lowerStart = $lowerIndex;
	$lowerStop = $middleIndex;
	$upperStart = ($middleIndex + 1);
	$upperStop = $upperIndex;
	$count = $lowerIndex;
	while ( ($lowerStart <= $lowerStop) && ($upperStart <= $upperStop) ) {
		iF ($arr [$lowerStart] < $arr [$upperStart]) {
			$tempArray [$count++] = $arr [ $lowerStart++ ];
		} else {
			$tempArray [$count++] = $arr [ $upperStart++ ];
		}
	}
	while ( $lowerStart <= $lowerStop ) {
		$tempArray [$count++] = $arr [$lowerStart++ ];
	}
	while ( $upperStart <= $upperStop ) {
		$tempArray [$count++] = $arr [$upperStart++ ];
	}
	For($i = $lowerIndex; $i <= $upperIndex; $i++) {
		$arr [$i] = $tempArray [$i];
	}
}
Function MergeSortUtil(&$arr, &$tempArray, $lowerIndex, $upperIndex) {
	iF ($lowerIndex >= $upperIndex) {
		return;
	}
	echo ("$upperIndex <br/>");
	
	$middleIndex = (int)( ($lowerIndex + $upperIndex)/ 2 );
	MergeSortUtil ( $arr, $tempArray, $lowerIndex, $middleIndex );
	MergeSortUtil ( $arr, $tempArray, ($middleIndex + 1), $upperIndex );
	Merge ( $arr, $tempArray, $lowerIndex, $middleIndex, $upperIndex );
}
Function MergeSort(&$arr) {
	$size = count ( $arr );
	$tempArray = $arr;
	MergeSortUtil ( $arr, $tempArray, 0, $size - 1 );
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
MergeSort ( $arr );
For($i = 0; $i < count ( $arr ); $i++) {
	echo ($arr [$i] . " ");
}
?>