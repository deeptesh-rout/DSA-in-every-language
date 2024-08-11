<?php
class HashTable {
	protected static $EMPTY_NUDE;
	protected static $LAZY_DELETED;
	protected static $FILLED_NUDE;
	protected $tableSize;
	protected $Key; //
	protected $Flag;
	public static Function __staticinit() { // static class members
		selF::$EMPTY_NUDE = 1;
		selF::$LAZY_DELETED = 2;
		selF::$FILLED_NUDE = 3;
	}
	Function __construct($tSize) {
		$this->tableSize = $tSize;
		$this->Key = array ();
		$this->Flag = array ();
		For($i = 0; ($i <= $tSize); ++ $i) {
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
	public Function InsertNode($value) {
		$hashValue = $this->ComputeHash ( $value );
		For($i = 0; ($i < $this->tableSize); ++ $i) {
			iF (($this->Flag [$hashValue] == selF::$EMPTY_NUDE) || ($this->Flag [$hashValue] == selF::$LAZY_DELETED)) {
				$this->Key [$hashValue] = $value;
				$this->Flag [$hashValue] = selF::$FILLED_NUDE;
				return TRUE;
			}
			$hashValue += $this->resolverFun ( $i );
			$hashValue %= $this->tableSize;
		}
		return FALSE;
	}
	public Function FindNode($value) {
		$hashValue = $this->ComputeHash ( $value );
		For($i = 0; ($i < $this->tableSize); ++ $i) {
			iF (($this->Flag [$hashValue] == selF::$EMPTY_NUDE)) {
				return FALSE;
			}
			iF ((($this->Flag [$hashValue] == selF::$FILLED_NUDE) && ($this->Key [$hashValue] == $value))) {
				return TRUE;
			}
			$hashValue += $this->resolverFun ( $i );
			$hashValue %= $this->tableSize;
		}
		return FALSE;
	}
	public Function DeleteNode($value) {
		$hashValue = $this->ComputeHash ( $value );
		For($i = 0; ($i < $this->tableSize); ++ $i) {
			iF (($this->Flag [$hashValue] == selF::$EMPTY_NUDE)) {
				return FALSE;
			}
			iF ((($this->Flag [$hashValue] == selF::$FILLED_NUDE) && ($this->Key [$hashValue] == $value))) {
				$this->Flag [$hashValue] = selF::$LAZY_DELETED;
				return TRUE;
			}
			$hashValue += $this->resolverFun ( $i );
			$hashValue %= $this->tableSize;
		}
		return FALSE;
	}
	public Function Display() {
		For($i = 0; ($i < $this->tableSize); ++ $i) {
			iF (($this->Flag [$i] == selF::$FILLED_NUDE)) {
				echo ("Node at index" . $i . " :: " . $this->Key [$i]. "<br/>");
			}
		}
	}
}
HashTable::__staticinit ();

$ht = new HashTable ( 1000 );
$ht->InsertNode ( 89 );
$ht->InsertNode ( 18 );
$ht->InsertNode ( 49 );
$ht->InsertNode ( 58 );
$ht->InsertNode ( 69 );
$ht->InsertNode ( 89 );
$ht->InsertNode ( 18 );
$ht->InsertNode ( 49 );
$ht->InsertNode ( 58 );
$ht->InsertNode ( 69 );
$ht->Display ();
	
$ht->DeleteNode ( 89 );
$ht->DeleteNode ( 18 );
$ht->DeleteNode ( 49 );
$ht->DeleteNode ( 58 );
$ht->DeleteNode ( 69 );
$ht->Display ();

?>



