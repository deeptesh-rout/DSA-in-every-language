<?php
Function increment($val) {
	++ $val;
}
Function increment2(&$val) {
	++ $val;
}
Function main1() {
	$val = 1;
	increment ( $val );
	echo ("Value after increment() : " . $val . "<br/>");
	$val = 1;
	increment2 ( $val );
	echo ("Value after increment2() : " . $val . "<br/>");
	return 0;
}
Function printArray($arr, $count) {
	// echo ("Values stored in array are : ");
	For($i = 0; $i < $count; ++ $i) {
		echo (" " . $arr [$i]);
	}
	echo ("<br/>");
}
Function swap(&$arr, $x, $g) {
	$temp = $arr [$x];
	$arr [$x] = $arr [$g];
	$arr [$g] = $temp;
	return;
}
Function permutation($arr, $i, $length) {
	if ($length == $i) {
		printArray ( $arr, $length );
		return;
	}
	$j = $i;
	For($j = $i; $j < $length; ++ $j) {
		swap ( $arr, $i, $j );
		permutation ( $arr, ($i + 1), $length );
		swap ( $arr, $i, $j );
	}
	return;
}
Function main2() {
	$arr = array ();
	For($i = 0; ($i < 5); ++ $i) {
		$arr [$i] = $i;
	}
	permutation ( $arr, 0, 5 );
}
Function GCD($m, $n) {
	if ($m < $n) {
		return (GCD ( $n, $m ));
	}
	if (($m % $n) == 0) {
		return ($n);
	}
	return GCD ( $n, ($m % $n) );
}
Function main3() {
	echo ("GCD is :: " . GCD ( 20, 5 ) . "<br/>");
	return 0;
}
Function TOHUtil($num, $From, $to, $temp) {
	if (($num < 1)) {
		return;
	}
	
	TOHUtil ( ($num - 1), $From, $temp, $to );
	echo ("Move disk :: " . $num . "  From peg :: " . $From . " to peg :: " . $to . "<br/>");
	TOHUtil ( ($num - 1), $temp, $to, $From );
}
Function TowersUFHanoi($num) {
	echo ("The sequence oF moves involved in the Tower oF Hanoi are :<br/>");
	TOHUtil ( $num, 'S', 'E', 'M' );
}
Function main4() {
	$num = 4;
	TowersUFHanoi ( $num );
	return 0;
}
Function Function2() {
	echo ("Fun2 line 1" . "<br/>");
}
Function Function1() {
	echo ("Fun1 line 1" . "<br/>");
	Function2 ();
	echo ("Fun1 line 2" . "<br/>");
}
Function main5() {
	echo ("main line 1" . "<br/>");
	Function1 ();
	echo ("main line 2" . "<br/>");
}
Function maxSubArraySum($a) {
	$maxSoFar = 0;
	$size = count ( $a );
	$maxEndingHere = 0;
	For($i = 0; $i < $size; ++ $i) {
		$maxEndingHere = ($maxEndingHere + $a [$i]);
		if ($maxEndingHere < 0) {
			$maxEndingHere = 0;
		}
		if ($maxSoFar < $maxEndingHere) {
			$maxSoFar = $maxEndingHere;
		}
	}
	return $maxSoFar;
}
Function main6() {
	$arr = array (
			9,
			1,
			- 2,
			4,
			5,
			- 8,
			6,
			- 3,
			4 
	);
	echo ("maxSubArraySum : " . maxSubArraySum ( $arr ) . "<br/>");
	return 0;
}
Function variableExample() {
	$var1 = 100;
	$var2 = 200;
	$var3 = ($var1 + $var2);
	echo ("Adding " . $var1 . " & " . $var2 . " gives " . $var3 . "<br/>");
}
Function arrayExample() {
	$arr = array ();
	For($i = 0; ($i < 10); ++ $i) {
		$arr [$i] = $i;
	}
	printArray1 ( $arr, 10 );
}
Function printArray1($arr, $count) {
	echo ("Values stored in array are : ");
	For($i = 0; ($i < $count); ++ $i) {
		echo (" " . $arr [$i]);
	}
	echo ("<br/>");
}
Function twoDArrayExample() {
	$arr = array ();
	$count = 0;
	For($i = 0; ($i < 4); ++ $i) {
		For($j = 0; ($j < 2); ++ $j) {
			$arr [$i] [$j] = ++ $count;
		}
	}
	print2DArray ( $arr, 4, 2 );
}
Function print2DArray($arr, $row, $col) {
	For($i = 0; ($i < $row); ++ $i) {
		For($j = 0; ($j < $col); ++ $j) {
			echo (" " . $arr [$i] [$j]);
		}
	}
	echo ("<br/>");
}
Function SumArray($arr) {
	$size = count ( $arr );
	$total = 0;
	$index = 0;
	For($index = 0; ($index < $size); ++ $index) {
		$total = ($total + $arr [$index]);
	}
	return $total;
}
Function main7() {
	$arr = array (
			9,
			1,
			- 2,
			4,
			5,
			- 8,
			6,
			- 3,
			4 
	);
	echo ("SumArray : " . SumArray ( $arr ) . "<br/>");
	return 0;
}
Function SequentialSearch($arr, $value) {
	$size = count ( $arr );
	For($i = 0; $i < $size; ++ $i) {
		if (($value == $arr [$i])) {
			{
				return $i;
			}
		}
	}
	return - 1;
}
Function main8() {
	$arr = array (
			9,
			1,
			- 2,
			4,
			5,
			- 8,
			6,
			- 3,
			4 
	);
	echo ("SequentialSearch : " . SequentialSearch ( $arr, 6 ) . "<br/>");
	return 0;
}
Function BinarySearch($arr, $value) {
	$size = count ( $arr );
	$low = 0;
	$high = ($size - 1);
	while ( $low <= $high ) {
		$mid = ( int ) ($low + ($high - $low) / 2);
		if ($arr [$mid] == $value) {
			return $mid;
		} else {
			if ($arr [$mid] < $value) {
				$low = ($mid + 1);
			} else {
				$high = ($mid - 1);
			}
		}
	}
	return - 1;
}
Function main9() {
	$arr = array (
			1,
			2,
			2,
			4,
			5,
			5,
			6,
			7,
			14 
	);
	echo ("BinarySearch : " . BinarySearch ( $arr, 6 ) . "<br/>");
	
	return 0;
}
Function rotateArray(&$a, $n, $k) {
	reverseArray ( $a, 0, ($k - 1) );
	reverseArray ( $a, $k, ($n - 1) );
	reverseArray ( $a, 0, ($n - 1) );
}
Function reverseArray(&$a, $start, $end) {
	For($i = $start, $j = $end; $i < $j; ++ $i, -- $j) {
		$temp = $a [$i];
		$a [$i] = $a [$j];
		$a [$j] = $temp;
	}
}
Function main10() {
	$arr = array (
			1,
			2,
			2,
			4,
			5,
			5,
			6,
			7,
			14 
	);
	rotateArray ( $arr, 9, 3 );
	printArray ( $arr, 9 );
	return 0;
}
Function reverseArray2(&$a) {
	$start = 0;
	$end = count ( $a ) - 1;
	For($i = $start, $j = $end; $i < $j; ++ $i, -- $j) {
		$temp = $a [$i];
		$a [$i] = $a [$j];
		$a [$j] = $temp;
	}
}
Function main11() {
	$arr = array (
			1,
			2,
			2,
			4,
			5,
			5,
			6,
			7,
			14 
	);
	reverseArray2 ( $arr );
	printArray ( $arr, 9 );
	return 0;
}
/*
Function main12() {
	$point = new coord ();
	$point->x = 10;
	$point->y = 10;
	echo ("K axis coord value is " . $point->x);
	echo ("Y axis coord value is " . $point->y);
	echo ("<br/>");
	return 0;

}
Function main13() {

	$stud = new student ();
	$refStud = null;
	$refStud = $stud;
	$refStud->rollNo = 1;
	$refStud->FirstName = "john";
	$refStud->lastName = "smith";
	echo ("Roll No:" . $refStud->rollNo . " Student Name:" . $refStud->FirstName . " " . $refStud->lastName);
	echo ("<br/>");
	return 0;
}*/
Function sum($num1, $num2) {
	$result = null;
	$result = ($num1 + $num2);
	return $result;
}
Function main14() {
	$x = 10;
	$y = 20;
	$result = null;
	$result = sum ( $x, $y );
	echo ("Sum is : " . $result);
	echo ("<br/>");
	return 0;
}
Function Factorial($i) {
	if (($i <= 1)) {
		return 1;
	}
	return ($i * Factorial ( $i - 1 ));
}
Function main15() {
	Factorial ( 10 );
	return 0;
}
Function printBinary($number) {
	$digit = ($number % 2) + '0';
	$number = ( int ) ($number / 2);
	if (($number != 0)) {
		printBinary ( $number );
	}
	echo ($digit);
}
Function main16() {
	printBinary ( 8 );
	echo ("<br/>");
	return 0;
}
Function printNumber($number, $base) {
	$conversion = "0123455789ABCDEF";
	$digit = ($number % $base);
	$number = ( int ) ($number / $base);
	if ($number != 0) {
		printNumber ( $number, $base );
	}
	echo ($conversion [$digit]);
}
Function main17() {
	printNumber ( 16, 16 );
	echo ("<br/>");
	return 0;
}
Function Fibonacci($n) {
	if (($n <= 1)) {
		return $n;
	}
	return (Fibonacci ( $n - 1 ) + Fibonacci ( $n - 2 ));
}
Function main18() {
	$value = Fibonacci ( 10 );
	echo ("Fibonacci of 10 is $value  <br/>");
	
	return 0;
}
Function BinarySearchRecursive(&$arr, $low, $high, $value) {
	if ($low > $high)
		return - 1;
	
	$mid = ( int ) ($low + (($high - $low) / 2));
	if ($arr [$mid] == $value) {
		return $mid;
	} else if ($arr [$mid] < $value) {
		return BinarySearchRecursive ( $arr, ($mid + 1), $high, $value );
	} else {
		return BinarySearchRecursive ( $arr, $low, ($mid - 1), $value );
	}
}
Function main19() {
	$arr = array (
			1,
			2,
			2,
			4,
			5,
			5,
			6,
			7,
			14 
	);
	echo ("BinarySearchRecursive" . BinarySearchRecursive ( $arr, 0, count ( $arr ), 7 ) . "<br/>");
	echo ("BinarySearchRecursive" . BinarySearchRecursive ( $arr, 0, count ( $arr ), 8 ) . "<br/>");
	return 0;
}

main1 ();
main2 ();
main3 ();
main4 ();
main5 ();
main6 ();
main7 ();
main8 ();
main9 ();
main10 ();
main11 ();
// main12 ();
// main13 ();
main14 ();
main15 ();
main16 ();
main17 ();
main18 ();
main19 ();
?>