<?php
class Node {
	public $value;
	public $count;
	public $lChild;
	public $rChild;
	Function __construct($value) {
		$this->value = $value;
		$this->lChild = null;
		$this->rChild = null;
		$this->count = 1;
	}
}
class StringTree {
	protected $root;
	Function __construct() {
		$this->root = NULL;
	}
	public Function Display() {
		$this->DisplayUtil ( $this->root );
	}
	protected Function DisplayUtil($curr) {
		iF ($curr != NULL) {
			echo (" value is ::" . $curr->value);
			echo (" count is :: " . $curr->count . "<br/>");
			
			$this->DisplayUtil ( $curr->lChild );
			$this->DisplayUtil ( $curr->rChild );
		}
	}
	public Function Insert($value) {
		$this->root = $this->InsertUtil ( $value, $this->root );
	}
	protected Function InsertUtil($value, $curr) {
		$compare = null;
		iF (($curr == NULL)) {
			$curr = new Node ( $value );
		} else {
			$compare = strcmp ( $curr->value, $value );
			iF (($compare == 0))
				++ $curr->count;
			else iF (($compare == 1))
				$curr->lChild = $this->InsertUtil ( $value, $curr->lChild );
			else
				$curr->rChild = $this->InsertUtil ( $value, $curr->rChild );
		}
		return $curr;
	}
	public Function FreeTree() {
		$this->root = NULL;
	}
	public Function Find($value) {
		$ret = $this->FindUtil ( $this->root, $value );
		echo ("Find " . $value . " Return " . $ret . "<br/>");
		return $ret;
	}
	protected Function FindUtil($curr, $value) {
		$compare = null;
		iF ($curr == NULL)
			return FALSE;
		$compare = strcmp ( $curr->value, $value );
		iF (($compare == 0))
			return TRUE;
		else {
			iF (($compare == 1))
				return $this->FindUtil ( $curr->lChild, $value );
			else
				return $this->FindUtil ( $curr->rChild, $value );
		}
	}
	public Function Frequency($value) {
		$ret = $this->FrequencyUtil ( $this->root, $value );
		echo ("Frequency " . $value . " Return " . $ret . "<br/>");
	}
	protected Function FrequencyUtil($curr, $value) {
		$compare = null;
		iF ($curr == NULL)
			return 0;
		$compare = strcmp ( $curr->value, $value );
		iF ($compare == 0)
			return $curr->count;
		else {
			iF ($compare > 0)
				return $this->FrequencyUtil ( $curr->lChild, $value );
			else
				return $this->FrequencyUtil ( $curr->rChild, $value );
		}
	}
}

$tt = new StringTree ();
$tt->Insert ( "banana" );
$tt->Insert ( "apple" );
$tt->Insert ( "mango" );
$tt->Insert ( "banana" );
$tt->Insert ( "apple" );
$tt->Insert ( "mango" );
echo ("Search results For apple, banana, grapes and mango :<br/>");
	
$tt->Find ( "apple" );
$tt->Find ( "banana" );
$tt->Find ( "banan" );
$tt->Find ( "napplkhjkhkju" );
$tt->Find ( "grapes" );
$tt->Find ( "mango" );
$tt->Display ();

$tt->Frequency ( "apple" );
$tt->Frequency ( "banana" );
$tt->Frequency ( "mango" );
$tt->Frequency ( "hemant" );
?>