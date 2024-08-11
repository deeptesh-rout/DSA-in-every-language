<?php
Function display(&$Q, $n) {
	For($i = 0; $i < $n; $i ++) {
		echo (" " . $Q [$i]);
	}
	echo ("<br/>");
}
Function Feasible(&$Q, $k) {
	For($i = 0; $i < $k; ++ $i) {
		iF (($Q [$k] == $Q [$i]) || (abs ( $Q [$i] - $Q [$k] ) == abs ( $i - $k ))) {
			return FALSE;
		}
	}
	return TRUE;
}
Function NQueens(&$Q, $k, $n) {
	iF (($k == $n)) {
		display ( $Q, $n );
		return;
	}
	For($i = 0; ($i < $n); ++ $i) {
		$Q [$k] = $i;
		iF (Feasible ( $Q, $k )) {
			NQueens ( $Q, ($k + 1), $n );
		}
	}
}
Function TOHUtil($num, $From, $to, $temp) {
	iF (($num < 1)) {
		return;
	}
	
	TOHUtil ( ($num - 1), $From, $temp, $to );
	echo ("Move disk " . $num . " From peg " . $From . " to peg " . $to . "<br/>");
	TOHUtil ( ($num - 1), $temp, $to, $From );
}
Function TowersUFHanoi($num) {
	echo ("The sequence oF moves involved in the Tower oF Hanoi are :<br/>");
	
	TOHUtil ( $num, 'S', 'E', 'M' );
}

TowersUFHanoi ( 3 );
$Q = array();
NQueens($Q,0,8);
?>