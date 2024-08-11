<?php
class Node {
	public $value;
	public $next;
	Function __construct($v, $n) {
		$this->value = $v;
		$this->next = $n;
	}
}
class LinkedList {
	protected $head;
	protected $size;
	Function __construct() {
		$this->size = 0;
		$this->head = NULL;
	}
	public Function size() {
		return $this->size;
	}
	//other methods.
}
?>