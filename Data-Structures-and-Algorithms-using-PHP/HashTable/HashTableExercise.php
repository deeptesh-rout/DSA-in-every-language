<?php
require_once ("Set.php");
require_once ("Counter.php");

Function main() {
	$First = "hello";
	$second = "elloh";
	$third = "world";
	echo ("isAnagram : " . (isAnagram ( $First, $second )?"true":"false"));
	echo ("<br/>");
	echo ("isAnagram : " . (isAnagram ( $First, $third )?"true":"false"));
	echo ("<br/>");
	RemoveDuplicate ( $First );
	echo ($First);
	echo ("<br/>");
	
	$arr = array (
			1,
			2,
			3,
			5,
			5,
			7,
			8,
			9,
			10 
	);
	echo ("FindMissing" . FindMissing ( $arr, 1, 10 ));
	echo ("<br/>");
	$arr1 = array (
			1,
			2,
			3,
			4,
			5,
			5,
			4,
			7,
			8,
			9,
			10 
	);
	printRepeating ( $arr1 );
	echo ("<br/>");
	
	printFirstRepeating ( $arr1 );
}
main();

Function isAnagram($str1, $str2) {
	$sizel = strlen ( $str1 );
	$size2 = strlen ( $str2 );
	if ($sizel != $size2)
		return FALSE;
	$cm = new Counter ();
	$length = strlen ( $str1 );
	for($i = 0; $i < $length; $i ++) {
		$cm->Add ( ord ( $str1 [$i] ) );
	}
	$length = strlen ( $str2 );
	for($i = 0; $i < $length; $i ++) {
		if ($cm->Delete ( ord ( $str2 [$i] ) ) == FALSE)
			return FALSE;
	}
	return TRUE;
}
Function RemoveDuplicate(&$str) {
	$index = 0;
	$hs = new Set ();
	$length = strlen ( $str );
	for($i = 0; $i < $length; $i ++) {
		if ($hs->Find ( ord ( $str [$i] ) ) == FALSE) {
			$str [$index ++] = $str [$i];
			$hs->Add ( ord ( $str [$i] ) );
		}
	}
	$str [$index] = '\0';
}
Function FindMissing($arr, $start, $end) {
	$hs = new Set ();
	foreach ( $arr as $i ) {
		$hs->Add ( $i );
	}
	for($curr = $start; ($curr <= $end); ++ $curr) {
		if ($hs->Find ( $curr ) == FALSE)
			return $curr;
	}
	return $end + 10;
}
Function printRepeating($arr) {
	$hs = new Set ();
	echo ("Repeating elements are:");
	foreach ( $arr as $val ) {
		if ($hs->Find ( $val ))
			echo ((" " . $val));
		else
			$hs->Add ( $val );
	}
}
Function printFirstRepeating($arr) {
	$i = null;
	$size = count ( $arr );
	$hs = new Counter ();
	for($i = 0; ($i < $size); ++ $i) {
		$hs->Add ( $arr [$i] );
	}
	for($i = 0; ($i < $size); ++ $i) {
		$hs->Delete ( $arr [$i] );
		if ($hs->Find ( $arr [$i] )) {
			echo ("First Repeating number is : " . $arr [$i]);
			return;
		}
	}
}
Function hornerHash($key, $tableSize) {
	$size = count ( $key );
	$h = 0;
	$i = null;
	for($i = 0; ($i < $size); ++ $i) {
		$h = (((32 * $h) + $key [$i]) % $tableSize);
	}
	return $h;
}