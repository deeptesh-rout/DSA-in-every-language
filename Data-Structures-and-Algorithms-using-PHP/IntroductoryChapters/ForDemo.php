<?php

Function main1() {
	$numbers = array (
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10 
	);
	$sum = 0;
	Foreach ( $numbers as $n ) {
		$sum += $n;
	}
	echo ("Sum is :: " . $sum . "<br/>");
}

Function main2() {
	$numbers = array (
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10 
	);
	$sum = 0;
	For($i = 0; $i < count ( $numbers ); ++ $i) {
		$sum += $numbers [$i];
	}
	echo ("Sum is :: " . $sum . "<br/>");
}

Function main()
{
	$numbers = array (
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10 
	);
	$sum = 0;
	$i = 0;
	while ( $i < count ( $numbers ) ) {
		$sum += $numbers [$i];
		++ $i;
	}
	echo ("Sum is :: " . $sum . "<br/>");
}

main ();
main1 ();
main2 ();
?>