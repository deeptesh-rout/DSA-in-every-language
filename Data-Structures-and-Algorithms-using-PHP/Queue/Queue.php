<?php
class Queue {
	protected $size;
	protected $data;
	protected $front;
	protected $back;
	protected $capacity;
	
	Function __construct($cap=NULL) {
		$this->front = 0;
		$this->back = 0;
		$this->size = 0;
		$this->data = array ();
		if($cap == NULL)
			$this->capacity = 100;
		else
			$this->capacity = $cap;
	}
	public Function add($value) {
		if ($this->size >= $this->capacity) {
			echo ("Queue is Full.");
			return FALSE;
		} else {
			++ $this->size;
			$this->data [$this->back] = $value;
			$this->back = ((++ $this->back) % (($this->capacity - 1)));
		}
		return TRUE;
	}
	public Function remove() {
		$value = null;
		if (($this->size <= 0)) {
			echo ("Queue is empty.");
			return -1;
		} else {
			-- $this->size;
			$value = $this->data [$this->front];
			$this->front = ((++ $this->front) % ($this->capacity - 1));
		}
		return $value;
	}
	protected Function isEmpty() {
		return ($this->size == 0);
	}
	protected Function size() {
		return $this->size;
	}
	
}

$que = new Queue ();
for($i = 0; ($i < 20); ++ $i) {
	$que->add ( $i );
}
for($i = 0; ($i < 22); ++ $i) {
	echo ($que->remove ()."<br/>");
}
?>