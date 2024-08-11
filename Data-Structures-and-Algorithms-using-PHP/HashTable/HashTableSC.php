<?php
class Node {
	public $value;
	public $next;
	Function __construct($v, $n) {
		$this->value = $v;
		$this->next = $n;
	}
}
class HashTableSE {
	protected $tableSize;
	protected $listArray;
	Function __construct() {
		$this->tableSize = 512;
		$this->listArray = array ();
		For($i = 0; ($i < $this->tableSize); ++ $i) {
			$this->listArray [$i] = NULL;
		}
	}
	protected Function ComputeHash($key) {
		$hashValue = $key;
		return ($hashValue % $this->tableSize);
	}
	protected Function resolverFun($i) {
		return $i;
	}
	protected Function resolverFun2($i) {
		return ($i * $i);
	}
	public Function insert($value) {
		$index = $this->ComputeHash ( $value );
		$this->listArray [$index] = new Node ( $value, $this->listArray [$index] );
	}
	public Function delete($value) {
		$index = $this->ComputeHash ( $value );
		$nextNode = null;
		$head = $this->listArray [$index];
		iF (($head != NULL) && ($head->value == $value)) {
			$this->listArray [$index] = $head->next;
			return TRUE;
		}
		while ( $head != NULL ) {
			$nextNode = $head->next;
			iF (($nextNode != NULL) && ($nextNode->value == $value)) {
				$head->next = $nextNode->next;
				return TRUE;
			} else {
				$head = $nextNode;
			}
		}
		return FALSE;
	}
	public Function display() {
		For($i = 0; ($i < $this->tableSize); ++ $i) {
			echo ("Printing For index value :: " . $i . "List oF value : ");
			$head = $this->listArray [$i];
			while ( $head != NULL ) {
				echo ($head->value);
				$head = $head->next;
			}
		}
	}
	public Function Find($value) {
		$index = $this->ComputeHash ( $value );
		$head = $this->listArray [$index];
		while ( $head != NULL ) {
			iF (($head->value == $value)) {
				return TRUE;
			}
			$head = $head->next;
		}
		return FALSE;
	}
}

$ht = new HashTableSE ();
For($i = 100; ($i < 110); ++ $i) {
	$ht->insert ( $i );
}
echo ("search 100 :: " . $ht->Find ( 100 ));
echo ("remove 100 :: " . $ht->delete ( 100 ));
echo ("search 100 :: " . $ht->Find ( 100 ));
echo ("remove 100 :: " . $ht->delete ( 100 ));
?>