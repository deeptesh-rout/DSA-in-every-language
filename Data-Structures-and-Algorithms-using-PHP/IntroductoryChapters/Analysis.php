<?php
Function Fun1($n) {
	$m = 0;
	For($i = 0; ($i < $n); ++ $i)
	$m += 1;
	return $m;
}

Function Fun2($n) {
	$i = null;
	$j = null;
	$m = 0;
	For($i = 0; ($i < $n); ++ $i)
	For($j = 0; ($j < $n); ++ $j)
	$m += 1;
	return $m;
}

Function Fun3($n)
{
	$i = null;
	$j = null;
	$m = 0;
	For($i = 0; ($i < $n); ++ $i)
	For($j = 0; ($j < $i); ++ $j)
	$m += 1;
	return $m;
}

Function Fun4($n)
{
	$i = null;
	$m = 0;
	$i = 1;
	while ( ($i < $n) ) {
		$m += 1;
		$i = ($i * 2);
	}
	return $m;
}

Function Fun5($n)
{
	$i = null;
	$m = 0;
	$i = $n;
	while ( $i >= 1 ) {
		$m += 1;
		$i = ($i / 2);
	}
	return $m;
}

Function Fun6($n)
{
	$i = null;
	$j = null;
	$k = null;
	$m = 0;
	For($i = 0; ($i < $n); ++ $i)
	For($j = 0; ($j < $n); ++ $j)
	For($k = 0; ($k < $n); ++ $k)
	$m += 1;
	return $m;
}

Function Fun7($n)
{
	$i = null;
	$j = null;
	$k = null;
	$m = 0;
	For($i = 0; ($i < $n); ++ $i)
	For($j = 0; ($j < $n); ++ $j)
	$m += 1;

	For($i = 0; ($i < $n); ++ $i)
	For($k = 0; ($k < $n); ++ $k)
	$m += 1;
	return $m;
}

Function Fun8($n)
{
	$i = null;
	$j = null;
	$m = 0;
	For($i = 0; ($i < $n); ++ $i)
	For($j = 0; ($j < $n ); ++ $j) // Math->sqrt
	$m += 1;
	return $m;
}

Function Fun9($n)
{
	$i = null;
	$j = null;
	$m = 0;
	For($i = $n; ($i >= 1); $i /= 2)
	For($j = 0; ($j < $i); ++ $j)
	$m += 1;
	return $m;
}

Function Fun10($n) 
{
	$i = null;
	$j = null;
	$m = 0;
	For($i = 0; ($i < $n); ++ $i)
	For($j = $i; ($j > 0); -- $j)
	$m += 1;
	return $m;
}

Function Fun11($n) // [int n]
{
	$i = null;
	$j = null;
	$k = null;
	$m = 0;
	For($i = 0; ($i < $n); ++ $i)
	For($j = $i; ($j < $n); ++ $j)
	For($k = ($j + 1); ($k < $n); ++ $k)
	$m += 1;
	return $m;
}

Function Fun12($n) 
{
	$i = null;
	$j = null;
	$m = 0;
	For($i = 0; ($i < $n); ++ $i)
	For($j = 0; ($j < $n); ++ $j)
	$m += 1;
	return $m;
}

Function Fun13($n) 
{
	$i = null;
	$j = null;
	$m = 0;
	For($i = 1; ($i < $n); $i *= 2)
	For($j = 0; ($j < $i); ++ $j)
	$m += 1;

	return $m;
}

echo Fun1(100) . "<br/>";
echo Fun2(100) . "<br/>";
echo Fun3(100) . "<br/>";
echo Fun4(100) . "<br/>";
echo Fun5(100) . "<br/>";
echo Fun6(100) . "<br/>";
echo Fun7(100) . "<br/>";
echo Fun8(100) . "<br/>";
echo Fun9(100) . "<br/>";
echo Fun10(100) . "<br/>";
echo Fun11(100) . "<br/>";
echo Fun12(100) . "<br/>";
echo Fun13(100) . "<br/>";
?>