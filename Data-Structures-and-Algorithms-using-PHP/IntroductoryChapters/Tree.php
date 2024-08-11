<?php
class Node {
	public $value;
	public $lChild;
	public $rChild;
	Function __construct($v) {
		$this->value = $v;
		$this->lChild = NULL;
		$this->rChild = NULL;
	}
}
class Tree {
	protected $root; // Node
	Function __construct() {
		$this->root = NULL;
	}
	//Other tree methods.
}
?>