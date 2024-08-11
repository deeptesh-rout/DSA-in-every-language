<?php
Function matchExpUtil($exp, $str, $i, $j) {
	if (($i == strlen ( $exp )) && ($j == strlen ( $str ))) {
		return TRUE;
	}
	if ((($i == strlen ( $exp )) && ($j != strlen ( $str ))) || (($i != strlen ( $exp )) && ($j == strlen ( $str )))) {
		return FALSE;
	}
	if (($exp [$i] == '?') || ($exp [$i] == $str [$j])) {
		return matchExpUtil ( $exp, $str, ($i + 1), ($j + 1) );
	}
	if ($exp [$i] == '*') {
		return ((matchExpUtil ( $exp, $str, ($i + 1), $j ) || matchExpUtil ( $exp, $str, $i, ($j + 1) )) || matchExpUtil ( $exp, $str, ($i + 1), ($j + 1) ));
	}
	return FALSE;
}
Function matchExp($exp, $str) {
	return matchExpUtil ( $exp, $str, 0, 0 );
}
Function main1() {
	$exp = "*world";
	$str = "hello world";
	echo ((matchExp ( $exp, $str )) ? "found" : "not found");
}
main1 ();
echo("<br/>");

Function match($source, $pattern) {
	$sourceLen = strlen ( $source );
	$patternLen = strlen ( $pattern );
	$iPattern = 0;
	for($iSource = 0; ($iSource < $sourceLen); ++ $iSource) {
		if (($source [$iSource] == $pattern [$iPattern])) {
			++ $iPattern;
		}
		if (($iPattern == $patternLen)) {
			return 1;
		}
	}
	return 0;
}
Function main2() {
	$exp = "world";
	$str = "hello woyyyyyrlxxxxxxxd";
	echo ((match ( $str, $exp )) ? "found" : "not found");
}
main2 ();
echo("<br/>");

Function isPrime($n) {
	$answer = ((($n > 1) ? TRUE : FALSE));
	for($i = 2; (($i * $i) < $n); $i ++) {
		if ((($n % $i) == 0)) {
			$answer = FALSE;
			break;
		}
	}
	return $answer;
}
Function main3() {
	$n = 101;
	echo ((isPrime ( $n )) ? "true" : "false");
}
main3 ();
echo("<br/>");

Function myAtoi($str) {
	$value = 0;
	$size = strlen ( $str );
	for($i = 0; ($i < $size); ++ $i) {
		$ch = $str [$i];
		$value = (($value << 3) + ($value << 1) + ($ch - '0'));
	}
	return $value;
}
Function main4() {
	$n = "101";
	echo (myAtoi ( $n ));
}
main4();
echo("<br/>");

Function isUniqueChar($str) {
	$bitarr = Array ();
	for($i = 0; ($i < 26); $i ++) {
		$bitarr [$i] = 0;
	}
	$size = strlen ( $str );
	for($i = 0; ($i < $size); $i ++) {
		$c = $str [$i];
		echo ("(" . $c . ")");
		if (('A' <= $c) && ('Z' >= $c)) {
			$c = ord ( $c ) - ord ( 'A' );
		} else if (('a' <= $c) && ('z' >= $c)) {
			$c = ord ( $c ) - ord ( 'a' );
		} else {
			echo ("Unknown Char!<br/>");
			return FALSE;
		}
		echo ("(" . $c . ")");
		
		if (($bitarr [$c] != 0)) {
			echo ("Duplicate detected!<br/>");
			return FALSE;
		}
		$bitarr [$c] = 1;
	}
	echo ("No duplicate detected!<br/>");
	return TRUE;
}
echo (isUniqueChar ( "helol" ) ? "unique" : "duplicate");
echo("<br/>");

Function isPermutation($s1, $s2) {
	$lenArr = Array ();
	$length1 = strlen ( $s1 );
	$length2 = strlen ( $s2 );
	if ($length1 != $length2) {
		echo ("is permutation return False<br/>");
		return FALSE;
	}
	for($i = 0; ($i < 256); ++ $i) {
		$lenArr [$i] = 0;
	}
	for($i = 0; ($i < $length1); ++ $i) {
		$ch = $s1 [$i];
		++ $lenArr [ord ( $ch )];
		$ch = $s2 [$i];
		-- $lenArr [ord ( $ch )];
	}
	for($i = 0; ($i < $length1); ++ $i) {
		if ($lenArr [$i] != 0) {
			echo ("is permutation return False<br/>");
			return FALSE;
		}
	}
	echo ("is permutation return true<br/>");
	return TRUE;
}
echo (isPermutation("hello","elhl") ? "true" : "false");
echo("<br/>");

Function isPalindrome($str) {
	$i = 0;
	$j = (strlen ( $str ) - 1);
	while ( ($i < $j) == ($str [$i] == $str [$j]) ) {
		++ $i;
		-- $j;
	}
	if ($i < $j) {
		echo ("String is not a Palindrome");
		return FALSE;
	} else {
		echo ("String is a Palindrome");
		return TRUE;
	}
}
isPalindrome ( "applelaelppa" );
echo("<br/>");

Function pow2($base, $exp) {
	$value = 0;
	if ($exp == 0) {
		return (1);
	} else {
		if (($exp % 2) == 0) {
			$value = pow2 ( $base, ( int ) ($exp / 2) );
			return ($value * $value);
		} else {
			$value = pow2 ( $base, ( int ) ($exp / 2) );
			return ($base * $value * $value);
		}
	}
}
echo ("power :: " . pow2 ( 4, 4 ));
echo("<br/>");

Function myStrcmp($a, $b) {
	$index = 0;
	$len1 = strlen ( $a );
	$len2 = strlen ( $b );
	$minlen = $len1;
	if ($len1 > $len2) {
		$minlen = $len2;
	}
	while ( ($index < $minlen) && ($a [$index] == $b [$index]) ) {
		++ $index;
	}
	if (($index == $len1) && ($index == $len2)) {
		return 0;
	} else {
		if (($len1 == $index)) {
			return - 1;
		} else {
			if (($len2 == $index)) {
				return 1;
			} else {
				return (ord ( $a [$index] ) - ord ( $b [$index] ));
			}
		}
	}
}
echo (myStrcmp("cpplez", "cpplewww"));
echo("<br/>");

Function reverseString(&$a) {
	$lower = 0;
	$upper = (strlen ( $a ) - 1);
	$tempChar = null;
	while ( $lower < $upper ) {
		$tempChar = $a [$lower];
		$a [$lower] = $a [$upper];
		$a [$upper] = $tempChar;
		++ $lower;
		-- $upper;
	}
}
Function main7() {
	$st = "hello";
	reverseString ( $st );
	echo ($st);
}
main7();
echo("<br/>");

Function reverseString2(&$a, $lower, $upper) {
	$tempChar = null;
	while ( ($lower < $upper) ) {
		$tempChar = $a [$lower];
		$a [$lower] = $a [$upper];
		$a [$upper] = $tempChar;
		++ $lower;
		-- $upper;
	}
}
Function reversewords(&$a) {
	$length = strlen ( $a );
	$upper = - 1;
	$lower = 0;
	for($i = 0; ($i <= $length); $i ++) {
		if (($i == $length) || ($a [$i] == ' ')) {
			
			reverseString2 ( $a, $lower, $upper );
			$lower = ($i + 1);
			$upper = $i;
		} else {
			$upper ++;
		}
	}
	reverseString2 ( $a, 0, ($length - 1) );
}
Function main8() {
	$st = "hello world how are you";
	reversewords ( $st );
	echo ($st);
}
main8 ();

?>