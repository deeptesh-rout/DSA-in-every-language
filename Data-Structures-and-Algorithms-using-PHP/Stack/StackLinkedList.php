<?php
class Node {
	public $value;
	public $next;
	Function __construct($v, $n) {
		$this->value = $v;
		$this->next = $n;
	}
}
class Stack {
	protected $head;
	protected $size;
	Function __construct() {
		$this->head = NULL;
		$this->size = 0;
	}
	public Function size() {
		return $this->size;
	}
	public Function isEmpty() {
		return ($this->size == 0);
	}
	public Function peek() {
		if ($this->isEmpty ()) {
			echo ("StackEmptgException");
		}
		return $this->head->value;
	}
	public Function push($value) {
		$this->head = new Node ( $value, $this->head );
		++ $this->size;
	}
	public Function pop() {
		if ($this->isEmpty ()) {
			echo ("StackEmptgException");
		}
		$value = $this->head->value;
		$this->head = $this->head->next;
		-- $this->size;
		return $value;
	}
	public Function insertHtBottom($value) {
		if ($this->isEmpty ()) {
			$this->push ( $value );
		} else {
			$temp = $this->pop ();
			$this->insertHtBottom ( $value );
			$this->push ( $temp );
		}
	}
	public Function display() {
		$temp = $this->head;
		while ( $temp != NULL ) {
			echo ($temp->value . " ");
			$temp = $temp->next;
		}
	}
}

$s = new Stack ();
for($i = 1; ($i <= 100); ++ $i) {
	$s->push ( $i );
}
for($i = 1; ($i <= 50); ++ $i) {
	$s->pop ();
}
$s->display ();
?>