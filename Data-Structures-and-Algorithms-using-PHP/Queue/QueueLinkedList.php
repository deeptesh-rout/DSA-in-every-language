<?php
class Node {
	public $value;
	public $next;
	Function __construct($v, $n) {
		$this->value = $v;
		$this->next = $n;
	}
}
class Queue {
	protected $head;
	protected $tail;
	protected $size;
	Function __construct() {
		$this->head = NULL;
		$this->tail = NULL;
		$this->size = 0;
	}
	public Function size() {
		return $this->size;
	}
	public Function isEmpty() {
		return ($this->size == 0);
	}
	public Function peek() {
		if ($this->isEmpty ())
			echo ("StackEmptyException");
		return $this->head->value;
	}
	public Function push($value) {
		$temp = new Node ( $value, NULL );
		if ($this->head == NULL)
			$this->head = $this->tail = $temp;
		else {
			$this->tail->next = $temp;
			$this->tail = $temp;
		}
		++ $this->size;
	}
	public Function pop() {
		if ($this->isEmpty ())
			echo ("StackEmptyException");
		$value = $this->head->value;
		$this->head = $this->head->next;
		-- $this->size;
		return $value;
	}
	public Function display() {
		$temp = $this->head;
		while ( $temp != NULL ) {
			echo ($temp->value . " ");
			$temp = $temp->next;
		}
		echo ("<br/>");
	}
}

$q = new Queue ();
for($i = 1; ($i <= 100); ++ $i) {
	$q->push ( $i );
}
for($i = 1; ($i <= 50); ++ $i) {
	$q->pop ();
}
$q->display ();
?>



