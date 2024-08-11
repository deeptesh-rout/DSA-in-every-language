<?php
class Node {
	public $value;
	public $next;
	Function __construct($v, $n) {
		$this->value = $v;
		$this->next = $n;
	}
}
class CircularLinkedList {
	protected $tail;
	protected $size;
	Function __construct() {
		$this->size = 0;
		$this->tail = NULL;
	}
	public Function size() {
		return $this->size;
	}
	public Function isEmpty() {
		return ($this->size == 0);
	}
	public Function peek() {
		if ($this->isEmpty ()) {
			echo ("EmptyListException");
			return NULL;
		}
		return $this->tail->next->value;
	}
	public Function addTail($value) {
		$temp = new Node ( $value, NULL );
		if ($this->isEmpty ()) {
			$this->tail = $temp;
			$temp->next = $temp;
		} else {
			$temp->next = $this->tail->next;
			$this->tail->next = $temp;
			$this->tail = $temp;
		}
		++ $this->size;
	}
	public Function addHead($value) {
		$temp = new Node ( $value, NULL );
		if ($this->isEmpty ()) {
			$this->tail = &$temp;
			$temp->next = &$temp;
		} else {
			$temp->next = $this->tail->next;
			$this->tail->next = &$temp;
		}
		++ $this->size;
	}
	public Function removeHead() {
		if ($this->isEmpty ()) {
			echo ("EmptyListException");
			return NULL;
		}
		$value = $this->tail->next->value;
		if ($this->tail == $this->tail->next)
			$this->tail = NULL;
		else
			$this->tail->next = $this->tail->next->next;
		-- $this->size;
		return $value;
	}
	public Function removeNode($key) {
		if ($this->isEmpty ()) {
			echo ("EmptyListException");
			return FALSE;
		}
		$prev = $this->tail;
		$curr = $this->tail->next;
		$head = $this->tail->next;
		if ($curr->value == $key) {
			if ($curr == $curr->next)
				$this->tail = NULL;
			else
				$this->tail->next = $this->tail->next->next;
			-- $this->size;
			return TRUE;
		}
		$prev = $curr;
		$curr = $curr->next;
		while ( $curr != $head ) {
			if ($curr->value == $key) {
				if ($curr == $this->tail)
					$this->tail = $prev;
				$prev->next = $curr->next;
				-- $this->size;
				return TRUE;
			}
			$prev = $curr;
			$curr = $curr->next;
		}
		return FALSE;
	}
	public Function copyListReversed() {
		$cl = new CircularLinkedList ();
		$curr = $this->tail->next;
		$head = $curr;
		if ($curr != NULL) {
			$cl->addHead ( $curr->value );
			$curr = $curr->next;
		}
		while ( $curr != $head ) {
			$cl->addHead ( $curr->value );
			$curr = $curr->next;
		}
	}
	public Function copyList() {
		$cl = new CircularLinkedList ();
		$curr = $this->tail->next;
		$head = $curr;
		if ($curr != NULL) {
			$cl->addTail ( $curr->value );
			$curr = $curr->next;
		}
		while ( $curr != $head ) {
			$cl->addTail ( $curr->value );
			$curr = $curr->next;
		}
	}
	public Function isPresent($data) // [int data]
{
		$temp = $this->tail;
		For($i = 0; ($i < $this->size); ++ $i) {
			if ($temp->value == $data)
				return TRUE;
			$temp = $temp->next;
		}
		return FALSE;
	}
	public Function FreeList() {
		$this->tail = NULL;
		$this->size = 0;
	}
	public Function display() {
		$temp = $this->tail;
		echo ("<br/>");
		for($i = 0; $i < $this->size; $i ++) {
			echo ($temp->value . " ");
			$temp = $temp->next;
		}
	}
}

$ll = new CircularLinkedList ();
$ll->addHead ( 1 );
$ll->display ();
$ll->addHead ( 2 );
$ll->display ();
$ll->addHead ( 3 );
$ll->display ();
$ll->addHead ( 1 );
$ll->display ();
$ll->addHead ( 2 );
$ll->display ();
$ll->addHead ( 3 );
$ll->display ();
echo ("length ::" . $ll->size ());
$ll->display ();
?>