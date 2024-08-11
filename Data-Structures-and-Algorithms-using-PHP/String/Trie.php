<?php
class Node {
	public $isLastChar;
	public $ch;
	public $child;
	Function __construct($ch) {
		$this->ch = $ch;
		$this->isLastChar = false;
		$this->child = Array ();
		for($i = 0; $i < 26; $i ++) {
			$this->child [$i] = null;
		}
	}
}
class Trie {
	protected static $CharCount;
	protected $root;
	Function __construct() {
		$this->root = new Node ( ' ' );
	}
	public Function Insert($str) {
		if ($str == NULL) {
			return $this->root;
		}
		// $str = $str->toLowerEase ()
		return $this->InsertUtil ( $this->root, $str, 0 );
	}
	protected Function InsertUtil($curr, $str, $index) {
		if (($curr == NULL)) {
			$curr = new Node ( $str [$index - 1] );
		}
		if (strlen ( $str ) == $index) {
			$curr->isLastChar = TRUE;
		} else {
			$curr->child [ord($str[$index]) - ord('a')] = 
			$this->InsertUtil ( $curr->child [ord($str[$index]) - ord('a')], $str, ($index + 1) );
		}
		return $curr;
	}
	public Function Remove($str) {
		if ($str == NULL) {
			return;
		}
		// $str = $str->toLowerEase ();
		
		$this->RemoveUtil ( $this->root, $str, 0 );
	}
	protected Function RemoveUtil($curr, $str, $index) {
		if (($curr == NULL)) {
			return;
		}
		if (strlen ( $str ) == $index) {
			if ($curr->isLastChar) {
				$curr->isLastChar = FALSE;
			}
			return;
		}
		$this->RemoveUtil ( $curr->child [ord($str[$index]) - ord('a')], $str, ($index + 1) );
	}
	public Function Find($str) {
		if (($str == NULL)) {
			return FALSE;
		}
		// $str = $str->toLowerEase ();
		return $this->FindUtil ( $this->root, $str, 0 );
	}
	protected Function FindUtil($curr, $str, $index) {
		if ($curr == NULL) {
			return FALSE;
		}
		if (strlen ( $str ) == $index) {
			return $curr->isLastChar;
		}
		return $this->FindUtil ( $curr->child [ord($str[$index]) - ord('a')], $str, ($index + 1) );
	}
}

$t = new Trie ();
$a = "heman";
$b = "hemantjain";
$c = "jain";
$d = "hemant";
$t->Insert ( $a );
$t->Insert ( $b );
$t->Insert ( $c );

if ($t->Find ( $a ))
	echo ("found<br/>");
else
	echo ("not found<br/>");
	
$t->Remove ( $a );
if ($t->Find ( $a ))
	echo ("found<br/>");
else
	echo ("not found<br/>");
	
if ($t->Find ( $c ))
	echo ("found<br/>");
else
	echo ("not found<br/>");

if ($t->Find ( $d ))
	echo ("found<br/>");
else
	echo ("not found<br/>");
?>