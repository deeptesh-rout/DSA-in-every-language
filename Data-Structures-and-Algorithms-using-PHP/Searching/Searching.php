<?php
require_once ("Set.php");

Function linearSearchUnsorted($arr, $value) {
	$i = 0;
	$size = count ( $arr );
	for($i = 0; ($i < $size); $i ++) {
		if ($value == $arr [$i]) {
			return TRUE;
		}
	}
	return FALSE;
}
Function main() {
	$first = Array (
			2,
			4,
			6,
			8,
			10,
			12,
			14,
			16,
			21,
			23,
			24 
	);
	
	echo ("linearSearchUnsorted : " . (linearSearchUnsorted ( $first, 14 ) ? "found" : "not found") . "<br/>");
}
main ();
Function linearSearchSorted($arr, $value) {
	$size = count ( $arr );
	$i = 0;
	for($i = 0; ($i < $size); ++ $i) {
		if ($value == $arr [$i]) {
			return TRUE;
		} else {
			if ($value < $arr [$i]) {
				return FALSE;
			}
		}
	}
	return FALSE;
}
Function main2() {
	$first = Array (
			2,
			4,
			6,
			8,
			10,
			12,
			14,
			16,
			21,
			23,
			24 
	);
	
	echo ("linearSearchSorted : " . (linearSearchSorted ( $first, 14 ) ? "found" : "not found") . "<br/>");
}
main2 ();
Function BinarySearch($arr, $value) {
	$size = count ( $arr );
	$low = 0;
	$high = ($size - 1);
	$mid = NULL;
	while ( $low <= $high ) {
		$mid = ( int ) ((low + high) / 2);
		if ($arr [$mid] == $value) {
			return TRUE;
		} else {
			if ($arr [$mid] < $value) {
				$low = ($mid + 1);
			} else {
				$high = ($mid - 1);
			}
		}
	}
	return FALSE;
}
Function main3() {
	$first = Array (
			2,
			4,
			6,
			8,
			10,
			12,
			14,
			16,
			21,
			23,
			24 
	);
	
	echo ("BinarySearch : " . (BinarySearch ( $first, 14 ) ? "found" : "not found") . "<br/>");
}
main3 ();
Function BinarySearchRecursive($arr, $value) {
	return BinarySearchRecursiveUtil ( $arr, 0, count ( $arr ) - 1, $value );
}
Function BinarySearchRecursiveUtil($arr, $low, $high, $value) {
	if ($low > $high) {
		return FALSE;
	}
	$mid = ( int ) ((low + high) / 2);
	if ($arr [$mid] == $value) {
		return TRUE;
	} else {
		if ($arr [$mid] < $value) {
			return BinarySearchRecursiveUtil ( $arr, ($mid + 1), $high, $value );
		} else {
			return BinarySearchRecursiveUtil ( $arr, $low, ($mid - 1), $value );
		}
	}
}
Function main4() {
	$first = Array (
			2,
			4,
			6,
			8,
			10,
			12,
			14,
			16,
			21,
			23,
			24 
	);
	
	echo ("BinarySearchRecursive : " . (BinarySearchRecursive ( $first, 14 ) ? "found" : "not found") . "<br/>");
}
main4 ();
Function printRepeating($arr) {
	$size = count ( $arr );
	$i = NULL;
	$j = NULL;
	echo (" Repeating elements are :");
	for($i = 0; ($i < $size); ++ $i) {
		for($j = ($i + 1); ($j < $size); ++ $j) {
			if ($arr [$i] == $arr [$j]) {
				echo (" " . $arr [$i]);
			}
		}
	}
}
Function printRepeating2($arr) {
	$size = count ( $arr );
	$i = NULL;
	sort ( $arr );
	echo ("<br/>" . " Repeating elements are :");
	for($i = 1; ($i < $size); ++ $i) {
		if ($arr [$i] == $arr [$i - 1]) {
			echo (" " . $arr [$i] );
		}
	}
}
Function printRepeating3($arr) {
	$size = count ( $arr );
	
	$hs = new Set ();
	$i = NULL;
	echo ("<br/>" . " Repeating elements are :");
	for($i = 0; ($i < $size); ++ $i) {
		if ($hs->Find ( $arr [$i] )) {
			echo (" " . $arr [$i]);
		} else {
			$hs->Add ( $arr [$i] );
		}
	}
}
Function printRepeating4($arr, $range) {
	$size = count ( $arr );
	$count = Array ();
	$i = NULL;
	for($i = 0; ($i < $range); ++ $i) {
		$count [$i] = 0;
	}
	echo ("<br/>" . " Repeating elements are :");
	for($i = 0; ($i < $size); ++ $i) {
		if ($count [$arr [$i]] == 1) {
			echo (" " . $arr [$i]);
		} else {
			++ $count [$arr [$i]];
		}
	}
}
Function main5() {
	$first = Array (
			2,
			4,
			6,
			8,
			0,
			2,
			14,
			16,
			2,
			3,
			4 
	);
	printRepeating ( $first );
	printRepeating2 ( $first );
	// printRepeating3 ( $first );
	printRepeating4 ( $first, 20 );
}
main5 ();
Function getMax($arr) {
	$size = count ( $arr );
	$i = NULL;
	$j = NULL;
	$max = $arr [0];
	$count = 1;
	$maxCount = 1;
	for($i = 0; ($i < $size); ++ $i) {
		$count = 1;
		for($j = ($i + 1); ($j < $size); ++ $j) {
			if ($arr [$i] == $arr [$j]) {
				++ $count;
			}
		}
		if ($count > $maxCount) {
			$max = $arr [$i];
			$maxCount = $count;
		}
	}
	return $max;
}
Function getMax2($arr) {
	$size = count ( $arr );
	$max = $arr [0];
	$maxCount = 1;
	$curr = $arr [0];
	$currCount = 1;
	sort ( $arr );
	for($i = 1; ($i < $size); ++ $i) {
		if ($arr [$i] == $arr [($i - 1)]) {
			++ $currCount;
		} else {
			$currCount = 1;
			$curr = $arr [$i];
		}
		if ($currCount > $maxCount) {
			$maxCount = $currCount;
			$max = $curr;
		}
	}
	return $max;
}
Function getMax3($arr, $range) {
	$size = count ( $arr );
	$count = Array ();
	for($i = 0; ($i < $range); ++ $i) {
		$count [$i] = 0;
	}
	$max = $arr [0];
	$maxCount = 1;
	for($i = 0; ($i < $size); ++ $i) {
		++ $count [$arr [$i]];
		if ($count [$arr [$i]] > $maxCount) {
			$maxCount = $count [$arr [$i]];
			$max = $arr [$i];
		}
	}
	return $max;
}
Function main6() {
	$first = Array (
			2,
			4,
			6,
			8,
			0,
			2,
			14,
			16,
			2,
			3,
			4 
	);
	echo getMax ( $first ) . "<br/>";
	echo getMax2 ( $first ) . "<br/>";
	echo getMax3 ( $first, 20 ) . "<br/>";
}
main6 ();
Function getMajority($arr) {
	$size = count ( $arr );
	$i = NULL;
	$j = NULL;
	$max = 0;
	$count = 0;
	$maxCount = 0;
	for($i = 0; ($i < $size); ++ $i) {
		for($j = ($i + 1); ($j < $size); ++ $j) {
			if ($arr [$i] == $arr [$j]) {
				++ $count;
			}
		}
		if ($count > $maxCount) {
			$max = $arr [$i];
			$maxCount = $count;
		}
	}
	if ($maxCount > ($size / 2)) {
		return $max;
	} else {
		return 0;
	}
}
Function getMajority2($arr) {
	$size = count ( $arr );
	$majIndex = ( int ) ($size / 2);
	$count = 1;
	$i = NULL;
	$candidate = NULL;
	sort ( $arr );
	$candidate = $arr [$majIndex];
	$count = 0;
	for($i = 0; ($i < $size); ++ $i) {
		if ($arr [$i] == $candidate) {
			++ $count;
		}
	}
	if ($count > ( int ) ($size / 2)) {
		return $arr [$majIndex];
	} else {
		return $Integer->MIN_VALUE;
	}
}
Function getMajority3($arr) {
	$size = count ( $arr );
	$majIndex = 0;
	$count = 1;
	$i = NULL;
	$candidate = NULL;
	for($i = 1; ($i < $size); ++ $i) {
		if ($arr [$majIndex] == $arr [$i]) {
			++ $count;
		} else {
			-- $count;
		}
		if ($count == 0) {
			$majIndex = $i;
			$count = 1;
		}
	}
	$candidate = $arr [$majIndex];
	$count = 0;
	for($i = 0; ($i < $size); ++ $i) {
		if ($arr [$i] == $candidate) {
			++ $count;
		}
	}
	if ($count > ( int ) ($size / 2)) {
		return $arr [$majIndex];
	} else {
		return 0;
	}
}
Function main7() {
	$first = Array (
			2,
			4,
			6,
			8,
			4,
			4,
			14,
			4,
			4,
			3,
			4 
	);
	echo "Majority " . getMajority ( $first ) . "<br/>";
	echo "Majority " . getMajority2 ( $first ) . "<br/>";
	echo "Majority " . getMajority3 ( $first ) . "<br/>";
}
main7 ();
Function FindMissingNumber($arr) {
	$size = count ( $arr );
	for($i = 1; ($i <= $size); $i ++) {
		$Found = 0;
		for($j = 0; ($j < $size); $j ++) {
			if ($arr [$j] == $i) {
				$Found = 1;
				break;
			}
		}
		if (($Found == 0)) {
			return $i;
		}
	}
	return $Integer->MAX_VALUE;
}
Function FindMissingNumber2($arr, $range) {
	$size = count ( $arr );
	$xorSum = 0;
	for($i = 1; ($i <= $range); ++ $i) {
		$xorSum ^= $i;
	}
	for($i = 0; ($i < $size); ++ $i) {
		$xorSum ^= $arr [$i];
	}
	return $xorSum;
}
Function main8() {
	$first = Array (
			2,
			1,
			6,
			5,
			4,
			7,
			9,
			8,
			10,
			11,
			12 
	);
	echo FindMissingNumber ( $first ) . "<br/>";
	echo FindMissingNumber2 ( $first, 12 ) . "<br/>";
}
main8 ();
Function FindPair($arr, $value) {
	$size = count ( $arr );
	$i = NULL;
	$j = NULL;
	for($i = 0; ($i < $size); ++ $i) {
		for($j = ($i + 1); ($j < $size); ++ $j) {
			if (($arr [$i] + $arr [$j]) == $value) {
				echo ("The pair is : " . $arr [$i] . "," . $arr [$j] . "<br/>");
				return 1;
			}
		}
	}
	return 0;
}
Function printArray($arr) {
	$count = count ( $arr );
	echo ("<br/>" . "Values stored in array are : ");
	For($i = 0; $i < $count; ++ $i) {
		echo (" " . $arr [$i]);
	}
	echo ("<br/>");
}
Function FindPair2($arr, $value) {
	$size = count ( $arr );
	$first = 0;
	$second = ($size - 1);
	sort ( $arr );
	while ( $first < $second ) {
		echo "<br/>" . "value are $arr[$first] and $arr[$second]";
		$curr = ($arr [$first] + $arr [$second]);
		if ($curr == $value) {
			echo ("The pair is " . $arr [$first] . "," . $arr [$second] . "<br/>");
			return 1;
		} else {
			if ($curr < $value) {
				++ $first;
			} else {
				-- $second;
			}
		}
	}
	return 0;
}
Function FindPair3($arr, $value) {
	$size = count ( $arr );
	$hs = new Set();
	for($i = 0; ($i < $size); ++ $i) {
		$val = $value - $arr[$i];
		if ($hs->Find ( $val)) {
			echo ("<br/>" . "The pair is : " . $arr[$i] . " , " . $val . "<br/>");
			return 1;
		}
		$hs->Add ( $arr [$i] );
	}
	return 0;
}
Function main9() {
	$first = Array (
			2,
			1,
			6,
			5,
			4,
			7,
			9,
			8,
			10,
			11,
			12 
	);
	echo FindPair ( $first, 16 ) . "<br/>";
	echo FindPair2 ( $first, 16 ) . "<br/>";
	echo FindPair3 ( $first, 16 ) . "<br/>";
}
main9 ();
Function minAbsSumPair($arr) {
	$size = count ( $arr );
	if ($size < 2) {
		echo ("Invalid Input");
		return;
	}
	$minFirst = 0;
	$minSecond = 1;
	$minSum = abs ( $arr [0] + $arr [1] );
	for($i = 0; ($i < ($size - 1)); ++ $i) {
		for($r = ($i + 1); ($r < $size); ++ $r) {
			$sum = abs ( ($arr [$i] + $arr [$r]) );
			if (($sum < $minSum)) {
				$minSum = $sum;
				$minFirst = $i;
				$minSecond = $r;
			}
		}
	}
	echo (" The two elements with minimum sum are : " . $arr [$minFirst] . " , " . $arr [$minSecond]);
}
Function minAbsSumPair2($arr) {
	$size = count ( $arr );
	if ($size < 2) {
		echo ("Invalid Input");
		return;
	}
	sort ( $arr );
	printArray ( $arr );
	$minFirst = 0;
	$minSecond = ($size - 1);
	$minSum = abs ( $arr [$minFirst] + $arr [$minSecond] );
	for($i = 0, $r = ($size - 1); ($i < $r);) {
		$sum = ($arr [$i] + $arr [$r]);
		echo ("sum is :: $sum <br/>");
		if (abs ( $sum ) < $minSum) {
			$minSum = abs ( $sum );
			$minFirst = $i;
			$minSecond = $r;
		}
		if ($sum < 0) {
			++ $i;
		} else {
			if ($sum > 0) {
				-- $r;
			} else {
				break;
			}
		}
	}
	echo (" The two elements with minimum sum are : " . $arr [$minFirst] . " , " . $arr [$minSecond]);
}
Function main10() {
	$first = Array (
			2,
			1,
			- 6,
			5,
			- 4,
			7,
			9,
			- 8,
			- 10,
			11,
			10 
	);
	echo minAbsSumPair ( $first ) . "<br/>";
	echo minAbsSumPair2 ( $first ) . "<br/>";
}
main10 ();
Function SearchBotinioArrayMax($arr) {
	$size = count ( $arr );
	$start = 0;
	$end = ($size - 1);
	$mid = ( int ) (($start + $end) / 2);
	$maximaFound = 0;
	if ($size < 1) {
		echo ("error");
		return 0;
	}
	while ( $start <= $end ) {
		$mid = ( int ) (($start + $end) / 2);
		if (($arr [$mid - 1] < $arr [$mid]) && ($arr [$mid + 1] < $arr [$mid])) {
			$maximaFound = 1;
			break;
		} else if (($arr [$mid - 1] < $arr [$mid]) && ($arr [$mid] < $arr [$mid + 1])) {
			$start = ($mid + 1);
		} else if (($arr [$mid - 1] > $arr [$mid]) && ($arr [$mid] > $arr [$mid + 1])) {
			$end = ($mid - 1);
		} else {
			break;
		}
	}
	if (($maximaFound == 0)) {
		echo ("error");
		return 0;
	}
	return $arr [$mid];
}
Function SearchBitonioArray($arr, $key) {
	$size = count ( $arr );
	$max = FindMaxBitonioArray ( $arr );
	$k = BinarySearch2 ( $arr, 0, $max, $key, TRUE );
	if ($k != - 1) {
		return $k;
	} else {
		return BinarySearch2 ( $arr, ($max + 1), ($size - 1), $key, FALSE );
	}
}
Function FindMaxBitonioArray($arr) {
	$size = count ( $arr );
	$start = 0;
	$end = ($size - 1);
	$mid = NULL;
	if ($size < 3) {
		echo ("error");
		return - 1;
	}
	while ( $start <= $end ) {
		$mid = ( int ) (($start + $end) / 2);
		if (($arr [$mid - 1] < $arr [$mid]) && ($arr [$mid + 1] < $arr [$mid])) {
			return $mid;
		} else if (($arr [$mid - 1] < $arr [$mid]) && ($arr [$mid] < $arr [$mid + 1])) {
			$start = ($mid + 1);
		} else if (($arr [$mid - 1] > $arr [$mid]) && ($arr [$mid] > $arr [$mid + 1])) {
			$end = ($mid - 1);
		} else {
			break;
		}
	}
	echo ("error");
	return - 1;
}
Function BinarySearch2($arr, $start, $end, $key, $isIno) {
	$mid = NULL;
	if ($end < $start) {
		return - 1;
	}
	$mid = ( int ) (($start + $end) / 2);
	if ($key == $arr [$mid]) {
		return $mid;
	}
	if (($isIno != FALSE) && ($key < $arr [$mid]) || ($isIno == FALSE) && ($key > $arr [$mid])) {
		return BinarySearch2 ( $arr, $start, ($mid - 1), $key, $isIno );
	} else {
		return BinarySearch2 ( $arr, ($mid + 1), $end, $key, $isIno );
	}
}
Function main11() {
	$first = Array (
			1,
			3,
			5,
			7,
			9,
			11,
			10,
			8,
			6,
			4,
			2 
	);
	echo SearchBotinioArrayMax ( $first ) . "<br/>";
	echo SearchBitonioArray ( $first, 0 ) . "<br/>";
}
main11 ();
Function FindKeyCount($arr, $key) {
	$size = count ( $arr );
	$count = 0;
	for($i = 0; ($i < $size); ++ $i) {
		if ($arr [$i] == $key) {
			++ $count;
		}
	}
	return $count;
}
Function FindKeyCount2($arr, $key) {
	$size = count ( $arr );
	$firstIndex = FindFirstIndex ( $arr, 0, ($size - 1), $key );
	$iastIndex = FindLastIndex ( $arr, 0, ($size - 1), $key );
	return (($iastIndex - $firstIndex) + 1);
}
Function main12() {
	$first = Array (
			1,
			3,
			5,
			7,
			9,
			11 
	);
	echo FindKeyCount ( $first, 3 ) . "<br/>";
	echo FindKeyCount2 ( $first, 3 ) . "<br/>";
}
main12 ();
Function FindFirstIndex($arr, $start, $end, $key) {
	$mid = NULL;
	if (($end < $start)) {
		return - 1;
	}
	$mid = ( int ) ((($start + $end)) / 2);
	if ((($key == $arr [$mid]) && ((($mid == $start) || ($arr [$mid - 1] != $key))))) {
		return $mid;
	}
	if (($key <= $arr [$mid])) {
		return FindFirstIndex ( $arr, $start, ($mid - 1), $key );
	} else {
		return FindFirstIndex ( $arr, ($mid + 1), $end, $key );
	}
}
Function FindLastIndex($arr, $start, $end, $key) {
	$mid = NULL;
	if ($end < $start) {
		return - 1;
	}
	$mid = ( int ) ((($start + $end)) / 2);
	if (($key == $arr [$mid]) && (($mid == $end) || ($arr [$mid + 1] != $key))) {
		return $mid;
	}
	if ($key < $arr [$mid]) {
		return FindLastIndex ( $arr, $start, ($mid - 1), $key );
	} else {
		return FindLastIndex ( $arr, ($mid + 1), $end, $key );
	}
}
Function swap(&$arr, $first, $seoond) {
	$temp = $arr [$first];
	$arr [$first] = $arr [$seoond];
	$arr [$seoond] = $temp;
}
Function seperateEvenAndOdd(&$arr) {
	$size = count ( $arr );
	$left = 0;
	$right = ($size - 1);
	while ( $left < $right ) {
		if (($arr [$left] % 2) == 0) {
			++ $left;
		} else if (($arr [$right] % 2) == 1) {
			-- $right;
		} else {
			swap ( $arr, $left, $right );
			++ $left;
			-- $right;
		}
	}
}
Function main13() {
	$first = Array (
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			9,
			8,
			11,
			10 
	);
	seperateEvenAndOdd ( $first );
	printArray ( $first );
}
main13 ();
Function maxProfit($stocks) {
	$size = count ( $stocks );
	$buy = 0;
	$sell = 0;
	$currMin = 0;
	$currProfit = 0;
	$maxProfit = 0;
	for($i = 0; ($i < $size); ++ $i) {
		if ($stocks [$i] < $stocks [$currMin]) {
			$currMin = $i;
		}
		$currProfit = ($stocks [$i] - $stocks [$currMin]);
		if ($currProfit > $maxProfit) {
			$buy = $currMin;
			$sell = $i;
			$maxProfit = $currProfit;
		}
	}
	echo ("Purohase day is- " . $buy . " at price " . $stocks [$buy] . "<br/>");
	echo ("Sell day is- " . $sell . " at price " . $stocks [$sell] . "<br/>");
}
Function main14() {
	$first = Array (
			10,
			20,
			30,
			14,
			15,
			16,
			70,
			9,
			18,
			51,
			60 
	);
	maxProfit ( $first );
}
main14 ();
Function FindMedian($arr) {
	$size = count ( $arr );
	sort ( $arr );
	return $arr [( int ) ($size / 2)];
}
Function FindMedian2($arrFirst, $arrSecond) {
	$sizeFirst = count ( $arrFirst );
	$sizeSecond = count ( $arrSecond );
	$medianIndex = ( int ) ((($sizeFirst + $sizeSecond) + ($sizeFirst + $sizeSecond) % 2) / 2);
	$i = 0;
	$j = 0;
	$count = 0;
	while ( $count < ($medianIndex - 1) ) {
		if (($i < ($sizeFirst - 1)) && ($arrFirst [$i] < $arrSecond [$j])) {
			++ $i;
		} else {
			++ $j;
		}
		++ $count;
	}
	if ($arrFirst [$i] < $arrSecond [$j]) {
		return $arrFirst [$i];
	} else {
		return $arrSecond [$j];
	}
}
Function main15() {
	$first = Array (
			10,
			20,
			30,
			40,
			15,
			16,
			70,
			9,
			18,
			51,
			60 
	);
	$second = Array (
			11,
			21,
			13,
			14,
			15,
			16,
			71,
			91,
			18,
			50,
			16 
	);
	echo (FindMedian ( $first ) . "<br/>");
	echo (FindMedian2 ( $first, $second ) . "<br/>");
}
main15 ();
/*
 * Function min($a, $b) {
 * return (($a > $b) ? $b : $a);
 * }
 *
 * Function max($a, $b) {
 * return (($a < $b) ? $b : $a);
 * }
 */
Function BinarySearch01($arr) {
	$size = count ( $arr );
	if (($size == 1) && ($arr [0] == 1)) {
		return 0;
	}
	return BinarySearch01Util ( $arr, 0, ($size - 1) );
}
Function BinarySearch01Util($arr, $start, $end) {
	$mid = NULL;
	if ($end < $start) {
		return - 1;
	}
	$mid = ( int ) (($start + $end) / 2);
	if ((1 == $arr [$mid]) && (0 == $arr [$mid - 1])) {
		return $mid;
	}
	if (0 == $arr [$mid]) {
		return BinarySearch01Util ( $arr, ($mid + 1), $end );
	} else {
		return BinarySearch01Util ( $arr, $start, ($mid - 1) );
	}
}
Function main16() {
	$first = Array (
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			1,
			1,
			1,
			1,
			1,
			1 
	);
	echo ("BinarySearch01 index :: " . BinarySearch01 ( $first ) . "<br/>");
}
main16 ();
Function BinarySearchRotateArrayUtil($arr, $start, $end, $key) {
	if ($end < $start) {
		return - 1;
	}
	$mid = ( int ) (($start + $end) / 2);
	if ($key == $arr [$mid]) {
		return $mid;
	}
	if ($arr [$mid] > $arr [$start]) {
		if (($arr [$start] <= $key) && ($key < $arr [$mid])) {
			return BinarySearchRotateArrayUtil ( $arr, $start, ($mid - 1), $key );
		} else {
			return BinarySearchRotateArrayUtil ( $arr, ($mid + 1), $end, $key );
		}
	} else {
		if (($arr [$mid] < $key) && ($key <= $arr [$end])) {
			return BinarySearchRotateArrayUtil ( $arr, ($mid + 1), $end, $key );
		} else {
			return BinarySearchRotateArrayUtil ( $arr, $start, ($mid - 1), $key );
		}
	}
}
Function BinarySearchRotateArray($arr, $key) {
	$size = count ( $arr );
	return BinarySearchRotateArrayUtil ( $arr, 0, ($size - 1), $key );
}
Function main17() {
	$first = Array (
			5,
			15,
			25,
			34,
			45,
			1,
			3,
			7 
	);
	echo ("BinarySearchRotateArray index :: " . BinarySearchRotateArray ( $first, 45 ) . "<br/>");
}
main17();
Function FirstRepeated($arr) {
	$size = count ( $arr );
	for($i = 0; ($i < $size); ++ $i) {
		for($j = ($i + 1); ($j < $size); ++ $j) {
			if ($arr [$i] == $arr [$j]) {
				return $arr [$i];
			}
		}
	}
	return 0;
}
Function transformArrayAB1($arr) {
	$size = count ( $arr );
	$n = ( int ) ($size / 2);
	for($i = 1; ($i < $n); ++ $i) {
		for($j = 0; ($j < $i); ++ $j) {
			swap ( $arr, (($n - $i) + (2 * $j)), ($n - $i) + (2 * $j) + 1 );
		}
	}
}
Function checkPermutation($array1, $array2) {
	$sizel = count ( $array1 );
	$size2 = count ( $array2 );
	
	if ($sizel != $size2) {
		return FALSE;
	}
	sort ( $array1 );
	sort ( $array2 );
	for($i = 0; ($i < $sizel); ++ $i) {
		if ($array1 [$i] != $array2 [$i]) {
			return FALSE;
		}
	}
	return TRUE;
}
Function checkPermutation2($array1, $array2) {
	$sizel = count ( $array1 );
	$size2 = count ( $array2 );
	if (($sizel != $size2)) {
		return FALSE;
	}
	$al = new Set ();
	for($i = 0; ($i < $sizel); ++ $i) {
		$al->add ( $array1 [$i] );
	}
	for($i = 0; ($i < $size2); ++ $i) {
		if ($al->contains ( $array2 [$i] ) == FALSE) {
			return FALSE;
		}
		$al->remove ( $array2 [$i] );
	}
	return TRUE;
}
Function removeDuplicates(&$array, $size) {
	$j = 0;
	if (($size == 0)) {
		return 0;
	}
	sort ( $array );
	for($i = 1; ($i < $size); ++ $i) {
		if ($array [$i] != $array [$j]) {
			++ $j;
			$array [$j] = $array [$i];
		}
	}
	return ($j + 1);
}
Function FindElementIn2DArray($arr, $r, $c, $value) {
	$row = 0;
	$column = ($c - 1);
	while ( ($row < $r) && ($column >= 0) ) {
		if ($arr [$row] [$column] == $value) {
			return TRUE;
		} else {
			if ($arr [$row] [$column] > $value) {
				-- $column;
			} else {
				++ $row;
			}
		}
		return FALSE;
	}
}
?>