<?php
Function isBalancedParenthesis($expn) {
	$stk = Array ();
	$size = strlen ( $expn );
	for($i = 0; $i < $size; $i ++) {
		$ch = $expn [$i];
		switch ($ch) {
			case '{' :
			case '[' :
			case '(' :
				array_push ( $stk, $ch );
				break;
			case '}' :
				if (array_pop ( $stk ) != '{') {
					return FALSE;
				}
				break;
			case ']' :
				if (array_pop ( $stk ) != '[') {
					return FALSE;
				}
				break;
			case ')' :
				if (array_pop ( $stk ) != '(') {
					return FALSE;
				}
				break;
		}
	}
	
	return (count ( $stk ) == 0);
}
Function main1() {
	$expn = "{()}[";
	$value = isBalancedParenthesis ( $expn ) ? "Balanced" : "UnBalanced";
	echo ("<br/> Given Expn:" . $expn);
	echo ("<br/> Result after isBalancedParenthesis:" . $value);
}
Function insertAtBottom(&$stk, $value) {
	if (count ( $stk ) == 0) {
		array_push ( $stk, $value );
	} else {
		$out = array_pop ( $stk );
		insertAtBottom ( $stk, $value );
		array_push ( $stk, $out );
	}
}
Function main2() {
	$stk = Array ();
	insertAtBottom ( $stk, 1 );
	insertAtBottom ( $stk, 2 );
	insertAtBottom ( $stk, 3 );
	echo array_pop ( $stk );
	echo array_pop ( $stk );
	echo array_pop ( $stk );
}
Function reverseStack(&$stk) {
	if (count ( $stk ) == 0) {
		return;
	} else {
		$value = array_pop ( $stk );
		reverseStack ( $stk );
		insertAtBottom ( $stk, $value );
	}
}
Function main3() {
	$stk = Array ();
	array_push ( $stk, 1 );
	array_push ( $stk, 2 );
	array_push ( $stk, 3 );
	reverseStack ( $stk );
	echo array_pop ( $stk );
	echo array_pop ( $stk );
	echo array_pop ( $stk );
}
Function postFixEvaluate($expn) { // / tokenizer code needed.
	$stk = Array ();
	$token = strtok ( $expn, " \n\t" );
	while ( $token != false ) {
		if (is_numeric ( $token )) {
			array_push ( $stk, $token );
		} else {
			$num1 = array_pop ( $stk );
			$num2 = array_pop ( $stk );
			
			switch ($token) {
				case '+' :
					array_push ( $stk, $num1 + $num2 );
					break;
				case '-' :
					array_push ( $stk, $num1 - $num2 );
					break;
				case '*' :
					array_push ( $stk, $num1 * $num2 );
					break;
				case '/' :
					array_push ( $stk, $num1 / $num2 );
					break;
			}
		}
		$token = strtok ( " \n\t" );
	}
	return array_pop ( $stk );
}
Function main4() {
	$expn = "6 5 2 3 + 8 * + 3 + *";
	$value = postFixEvaluate ( $expn );
	echo ("<br/> Given PostFixExpn: " . $expn . "<br/>");
	echo ("<br/> Result after evaluation: " . $value . "<br/>");
}
Function precedence($x) {
	if ($x == '(') {
		return (0);
	}
	if (($x == '+') || ($x == '-')) {
		return (1);
	}
	if ((($x == '*') || ($x == '/')) || ($x == '%'))
		return (2);
	if ($x == '^') {
		return (3);
	}
	return (4);
}
Function printArray($arr) {
	$count = count ( $arr );
	For($i = 0; $i < $count; ++ $i) {
		echo (" " . $arr [$i]);
	}
	echo ("<br/>");
}
Function infixToPostfix($expn) {
	$stk = Array ();
	$output = "";
	$out = null;
	$size = strlen ( $expn );
	for($i = 0; $i < $size; $i ++) {
		$ch = $expn [$i];
		if (($ch <= '9') && ($ch >= '0')) {
			$output = $output . $ch;
		} else {
			switch ($ch) {
				case '+' :
				case '-' :
				case '*' :
				case '/' :
				case '%' :
				case '^' :
					while ( count ( $stk ) != 0 ) {
						$cnt = count ( $stk );
						if (precedence ( $ch ) <= precedence ( $stk [$cnt - 1] )) {
							$out = array_pop ( $stk );
							$output = ($output . " " . $out);
						} else
							break;
					}
					array_push ( $stk, $ch );
					$output = ($output . " ");
					break;
				case '(' :
					array_push ( $stk, $ch );
					break;
				case ')' :
					while ( (count ( $stk ) != 0) && (($out = array_pop ( $stk )) != '(') ) {
						$output = ($output . " " . $out . " ");
					}
					break;
			}
		}
	}
	while ( count ( $stk ) != 0 ) {
		$out = array_pop ( $stk );
		$output = ($output . $out . " ");
	}
	return $output;
}
Function main5() {
	$expn = "10+((8))*5/(15-4)";
	$value = infixToPostfix ( $expn );
	echo ("<br/> InFixExpn: " . $expn);
	echo ("<br/> PostFixExpn: " . $value);
}
Function infixToPrefix($expn) {
	reverseString ( $expn );
	replaceParanthesis ( $expn );
	$expn = infixToPostfix ( $expn );
	reverseString ( $expn );
	return $expn;
}
Function replaceParanthesis(&$a) {
	$lower = 0;
	$upper = (strlen ( $a ) - 1);
	while ( $lower <= $upper ) {
		if ($a [$lower] == '(') {
			$a [$lower] = ')';
		} else if ($a [$lower] == ')') {
			$a [$lower] = '(';
		}
		++ $lower;
	}
}
Function reverseString(&$expn) {
	$lower = 0;
	$upper = (strlen ( $expn ) - 1);
	$tempChar = null;
	while ( $lower <= $upper ) {
		$tempChar = $expn [$lower];
		$expn [$lower] = $expn [$upper];
		$expn [$upper] = $tempChar;
		++ $lower;
		-- $upper;
	}
}
Function main6() {
	$expn = "10+((3))*5/(16-4)";
	$value = infixToPrefix ( $expn );
	echo ("<br/> Expression: " . $expn);
	echo ("<br/> PreFix Expn: " . $value);
}
Function StockSpanRange($arr) {
	$SR = Array ();
	$SR [0] = 1;
	for($i = 1; $i < count ( $arr ); $i ++) {
		$SR [$i] = 1;
		for($j = ($i - 1); (($j >= 0) && ($arr [$i] >= $arr [$j])); $j --) {
			$SR [$i] ++;
		}
	}
	return $SR;
}
Function StockSpanRange2($arr) {
	$stk = Array ();
	$SR = Array ();
	array_push ( $stk, 0 );
	$SR [0] = 1;
	for($i = 1; $i < count ( $arr ); $i ++) {
		while ( (count ( $stk ) != 0) && ($arr [count ( $stk ) - 1] <= $arr [$i]) ) {
			array_pop ( $stk );
		}
		$SR [$i] = (count ( $stk ) == 0) ? ($i + 1) : ($i - $stk [count ( $stk ) - 1]);
		array_push ( $stk, $i );
	}
	return $SR;
}
Function main7() {
	$arr = array (
			70,
			60,
			50,
			40,
			30,
			45,
			55,
			65,
			90 
	);
	echo ("<br/> StockSpanRange : ");
	printArray ( StockSpanRange ( $arr ) );
	echo ("<br/>");
	echo ("StockSpanRange2 : ");
	printArray ( StockSpanRange2 ( $arr ) );
	echo ("<br/>");
	return 0;
}
Function GetMaxArea($arr) {
	$size = count ( $arr );
	$maxArea = - 1;
	$currArea = null;
	$minHeight = 0;
	for($i = 1; ($i < $size); ++ $i) {
		$minHeight = $arr [$i];
		for($j = ($i - 1); $j >= 0; -- $j) {
			if ($minHeight > $arr [$j]) {
				$minHeight = $arr [$j];
			}
			$currArea = ($minHeight * (($i - $j) + 1));
			if ($maxArea < $currArea) {
				$maxArea = $currArea;
			}
		}
	}
	return $maxArea;
}
Function GetMaxArea2($arr) {
	$size = count ( $arr );
	$stk = Array ();
	$maxArea = 0;
	$top = null;
	$topArea = null;
	$i = 0;
	while ( ($i < $size) ) {
		while ( ($i < $size) && (count ( $stk ) == 0 || ($arr [$stk [count ( $stk ) - 1]] <= $arr [$i])) ) {
			array_push ( $stk, $i );
			++ $i;
		}
		while ( count ( $stk ) != 0 && (($i == $size) || ($arr [$stk [count ( $stk ) - 1]] > $arr [$i])) ) {
			$top = $stk [count ( $stk ) - 1];
			array_pop ( $stk );
			$topArea = ($arr [$top] * ((count ( $stk ) == 0) ? $i : (($i - $stk [count ( $stk ) - 1]) - 1)));
			if (($maxArea < $topArea)) {
				$maxArea = $topArea;
			}
		}
	}
	return $maxArea;
}
Function main8() {
	$arr = array (
			7,
			6,
			5,
			4,
			4,
			1,
			6,
			3,
			2 
	);
	echo ("GetMaxArea : " . GetMaxArea ( $arr ) . "<br/>");
	echo ("GetMaxArea2 : " . GetMaxArea2 ( $arr ) . "<br/>");
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
?>