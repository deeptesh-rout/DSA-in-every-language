<?php
class StrStr {
	public Function BruteForceSearch($text, $pattern) {
		$i = 0;
		$j = 0;
		$n = strlen ( $text );
		$m = strlen ( $pattern );
		while ( $i <= ($n - $m) ) {
			$j = 0;
			while ( ($j < $m) && ($pattern [$j] == $text [$i + $j]) ) {
				$j ++;
			}
			if ($j == $m) {
				return ($i);
			}
			$i ++;
		}
		return - 1;
	}
	public Function RobinKarp($text, $pattern) {
		$n = strlen ( $text );
		$m = strlen ( $pattern );
		$i = 0;
		$j = 0;
		$prime = 101;
		$powm = 1;
		$TextHash = 0;
		$PatternHash = 0;
		if (($m == 0) || ($m > $n)) {
			return - 1;
		}
		for($i = 0; ($i < ($m - 1)); ++ $i) {
			$powm = (($powm << 1) % $prime);
		}
		for($i = 0; $i < $m; ++ $i) {
			$PatternHash = ((($PatternHash << 1) + ord($pattern[$i])) % $prime);
			$TextHash = ((($TextHash << 1) + ord($text [$i])) % $prime);
		}
		for($i = 0; $i <= ($n - $m); ++ $i) {
			if (($TextHash == $PatternHash)) {
				for($j = 0; $j < $m; ++ $j) {
					if ($text [$i + $j] != $pattern [$j]) {
						break;
					}
				}
				if ($j == $m)
					return $i;
			}
			$TextHash = (((($TextHash - (ord($text[$i]) * $powm)) << 1) + ord($text[$i + $m])) % $prime);
			if ($TextHash < 0) {
				$TextHash = ($TextHash + $prime);
			}
		}
		return - 1;
	}
	protected Function KMPPreprocess($pattern, &$ShiftArr) {
		$m = strlen ( $pattern );
		$i = 0;
		$j = - 1;
		$ShiftArr [$i] = - 1;
		while ( ($i < $m) ) {
			while ( ($j >= 0) && ($pattern [$i] != $pattern [$j]) ) {
				$j = $ShiftArr [$j];
			}
			++ $i;
			++ $j;
			$ShiftArr [$i] = $j;
		}
	}
	public Function KMP($text, $pattern) {
		$i = 0;
		$j = 0;
		$n = strlen ( $text );
		$m = strlen ( $pattern );
		$ShiftArr = array ();
		$this->KMPPreprocess ( $pattern, $ShiftArr );
		while ( $i < $n ) {
			while ( ($j >= 0) && ($text [$i] != $pattern [$j]) ) {
				$j = $ShiftArr [$j];
			}
			++ $i;
			++ $j;
			if ($j == $m) {
				return ($i - $m);
			}
		}
		return - 1;
	}
	public Function KMPFindCount($text, $pattern) {
		$i = 0;
		$j = 0;
		$count = 0;
		$n = strlen ( $text );
		$m = strlen ( $pattern );
		$ShiftArr = array ();
		$this->KMPPreprocess ( $pattern, $ShiftArr );
		while ( $i < $n ) {
			while ( ($j >= 0) && ($text [$i] != $pattern [$j]) ) {
				$j = $ShiftArr [$j];
			}
			++ $i;
			++ $j;
			if ($j == $m) {
				++ $count;
				$j = $ShiftArr [$j];
			}
		}
		return $count;
	}
}

$st1 = "hello, world!";
$st2 = "world";
$algo = new StrStr ();
echo ("BruteForceSearch return : " . $algo->BruteForceSearch ( $st1, $st2 ) . "<br/>");
echo ("RobinKarp return : " . $algo->RobinKarp ( $st1, $st2 ) . "<br/>");
echo ("KMP return : " . $algo->KMP ( $st1, $st2 ) . "<br/>");
echo ("KMP return : " . $algo->KMPFindCount ( $st1, $st2 ) . "<br/>");
?>