<?php
class Node {
	public $data;
	public $isLastChar;
	public $left;
	public $equal;
	public $right;
	Function __construct($d){
		$this->data = $d;
		$this->left = NULL;
		$this->equal = NULL;
		$this->right = NULL;
		$this->isLastChar = false;
	}
}
class TST {
	protected $root;
	Function __construct() {
		$this->root = NULL;
	}
	public Function insert_String($word) {
		$this->root = $this->insert_Node_String_I ( $this->root, $word, 0 );
	}
	protected Function insert_Node_String_I($curr, $word, $wordIndex) {
		if ($curr == NULL)
			$curr = new Node( $word [$wordIndex] );
		if ($word [$wordIndex] < $curr->data)
			$curr->left = $this->insert_Node_String_I ( $curr->left, $word, $wordIndex );
		else if ($word [$wordIndex] > $curr->data)
			$curr->right = $this->insert_Node_String_I ( $curr->right, $word, $wordIndex );
		else {
			if ($wordIndex < (strlen ( $word ) - 1))
				$curr->equal = $this->insert_Node_String_I ( $curr->equal, $word, ($wordIndex + 1) );
			else
				$curr->isLastChar = true;
		}
		return $curr;
	}
	protected Function Find_Node_String_I($curr, $word, $wordIndex) {
		if ($curr == NULL)
			return false;
		if ($word [$wordIndex] < $curr->data)
			return $this->Find_Node_String_I ( $curr->left, $word, $wordIndex );
		else if ($word [$wordIndex] > $curr->data)
			return $this->Find_Node_String_I ( $curr->right, $word, $wordIndex );
		else {
			if ($wordIndex == (strlen ( $word ) - 1))
				return $curr->isLastChar;
			
			return $this->Find_Node_String_I ( $curr->equal, $word, ($wordIndex + 1) );
		}
	}
	public Function Find_String($word) {
		$ret = $this->Find_Node_String_I ( $this->root, $word, 0 );
		echo ("$word :: ");
		if ($ret)
			echo ("Found <br/>");
		else
			echo ("Not Found<br/>");
		return $ret;
	}
}

$tt = new TST();
$tt->insert_String ( "banana" );
$tt->insert_String ( "apple" );
$tt->insert_String ( "mango" );
echo ("\nSearch results For apple, banana, grapes and mango :<br/>");
$tt->Find_String ( "apple" );
$tt->Find_String ( "banana" );
$tt->Find_String ( "mango" );
$tt->Find_String ( "grapes" );
?>



