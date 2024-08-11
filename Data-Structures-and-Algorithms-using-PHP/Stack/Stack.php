<?php
class Stack {
	protected static $CAPACITY;
	protected $data;
	protected $top;
	public static Function __staticinit() {
		SELF::$CAPACITY = 1000;
	}
	Function __construct() {
		$this->top = - 1;
		$this->data = array ();
	}
	public Function size() {
		return ($this->top + 1);
	}
	public Function isEmpty() {
		return ($this->top == - 1);
	}
	public Function push($value) {
		++ $this->top;
		$this->data [$this->top] = $value;
	}
	public Function top() {
		if ($this->isEmpty ()) {
			echo ("StackEmptyException");
		}
		return $this->data [$this->top];
	}
	public Function pop() {
		if ($this->isEmpty ()) {
			echo ("StackEmptyException");
		}
		$topVal = $this->data [$this->top];
		-- $this->top;
		return $topVal;
	}
	public Function display() {
		For($i = $this->top; $i > - 1; -- $i) {
			echo (" " . $this->data [$i]);
		}
	}
}
Stack::__staticinit (); // initialize static vars For this class on load

$s = new Stack ();
For($i = 1; $i <= 100; ++ $i) {
	$s->push ( $i );
}
For($i = 1; ($i <= 50); ++ $i) {
	$s->pop ();
}
$s->display ();
?>