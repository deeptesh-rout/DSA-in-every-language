<?php
class Set {
	protected static $EMPTY_NUDE;
	protected static $LAZY_DELETED;
	protected static $FILLED_NUDE;
	protected static $tSize;
	protected $tableSize;
	protected $Key;
	protected $Flag;
	public static Function __staticinit() { // static class members
		selF::$EMPTY_NUDE = 1;
		selF::$LAZY_DELETED = 2;
		selF::$FILLED_NUDE = 3;
		self::$tSize = 1000;
	}
	Function __construct() {
		$this->tableSize = self::$tSize;
		$this->Key = array ();
		$this->Flag = array ();
		For($i = 0; ($i <= self::$tSize); ++ $i) {
			$this->Flag [$i] = selF::$EMPTY_NUDE;
		}
		return $this;
	}
	protected Function ComputeHash($key) {
		return ($key % $this->tableSize);
	}
	protected Function resolverFun($index) {
		return $index;
	}
	public Function Add($key) {
		$hashValue = $this->ComputeHash ( $key );
		For($i = 0; ($i < $this->tableSize); ++ $i) {
			iF (($this->Flag [$hashValue] == selF::$EMPTY_NUDE) || ($this->Flag [$hashValue] == selF::$LAZY_DELETED) || ($this->Key [$hashValue] == $key)) {
				$this->Key [$hashValue] = $key;
				$this->Flag [$hashValue] = selF::$FILLED_NUDE;
				return TRUE;
			}
			$hashValue += $this->resolverFun ( $i );
			$hashValue %= $this->tableSize;
		}
		return FALSE;
	}
	public Function Find($key) {
		$hashValue = $this->ComputeHash ( $key );
		For($i = 0; ($i < $this->tableSize); ++ $i) {
			iF (($this->Flag [$hashValue] == selF::$EMPTY_NUDE)) {
				return FALSE;
			}
			iF ((($this->Flag [$hashValue] == selF::$FILLED_NUDE) && ($this->Key [$hashValue] == $key))) {
				return TRUE;
			}
			$hashValue += $this->resolverFun ( $i );
			$hashValue %= $this->tableSize;
		}
		return FALSE;
	}
	public Function Delete($key) {
		$hashValue = $this->ComputeHash ( $key );
		For($i = 0; ($i < $this->tableSize); ++ $i) {
			iF (($this->Flag [$hashValue] == selF::$EMPTY_NUDE)) {
				return FALSE;
			}
			iF ((($this->Flag [$hashValue] == selF::$FILLED_NUDE) && ($this->Key [$hashValue] == $key))) {
				$this->Flag [$hashValue] = selF::$LAZY_DELETED;
				return TRUE;
			}
			$hashValue += $this->resolverFun ( $i );
			$hashValue %= $this->tableSize;
		}
		return FALSE;
	}
	public Function Display() {
		echo ("Values in set are :: ");
		For($i = 0; ($i < $this->tableSize); ++ $i) {
			iF ($this->Flag [$i] == selF::$FILLED_NUDE) {
				echo ($this->Key [$i] . " ");
			}
		}
		echo ("  <br/>");
	}
}
Set::__staticinit ();
/*
$ht = new Set ( 1000 );
$ht->Add ( 89 );
$ht->Add ( 89 );
$ht->Add ( 18 );
$ht->Add ( 49 );
$ht->Add ( 58 );
$ht->Add ( 69 );
$ht->Display ();
	
$ht->Delete ( 89 );
$ht->Delete ( 49 );
$ht->Delete ( 58 );
$ht->Delete ( 69 );
$ht->Display ();

*/
?>



