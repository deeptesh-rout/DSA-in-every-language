<?php
class Node {
	public $value;
	public $next;
	public $prev;
	Function __construct($v) {
		$this->value = $v;
		$this->next = NULL;
		$this->prev = NULL;
	}
}
class DoublyCircularLinkedList {
	protected $head; // Node
	protected $tail; // Node
	protected $size; // int
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
	public Function peekHead() {
		if ($this->isEmpty ())
			echo ("EmptyListException");
		return $this->head->value;
	}
	public Function addHead($value) {
		$newNode = new Node ( $value, NULL, NULL );
		if ($this->size == 0) {
			$this->tail = $this->head = $newNode;
			$newNode->next = $newNode;
			$newNode->prev = $newNode;
		} else {
			$newNode->next = $this->head;
			$newNode->prev = $this->head->prev;
			$this->head->prev = $newNode;
			$newNode->prev->next = $newNode;
			$this->head = $newNode;
		}
		++ $this->size;
	}
	public Function addTail($value) {
		$newNode = new Node ( $value, NULL, NULL );
		if ($this->size == 0) {
			$this->head = $this->tail = $newNode;
			$newNode->next = $newNode;
			$newNode->prev = $newNode;
		} else {
			$newNode->next = $this->tail->next;
			$newNode->prev = $this->tail;
			$this->tail->next = $newNode;
			$newNode->next->prev = $newNode;
			$this->tail = $newNode;
		}
		++ $this->size;
	}
	public Function removeHead() {
		if ($this->size == 0)
			echo ("EmptyListException");
		$value = $this->head->value;
		-- $this->size;
		if ($this->size == 0) {
			$this->head = NULL;
			$this->tail = NULL;
			return $value;
		}
		$next = $this->head->next;
		$next->prev = $this->tail;
		$this->tail->next = $next;
		$this->head = $next;
		return $value;
	}
	public Function removeTail() {
		if ($this->size == 0)
			echo ("EmptyListException");
		$value = $this->tail->value;
		-- $this->size;
		if ($this->size == 0) {
			$this->head = NULL;
			$this->tail = NULL;
			return $value;
		}
		$prev = $this->tail->prev;
		$prev->next = $this->head;
		$this->head->prev = $prev;
		$this->tail = $prev;
		return $value;
	}
	public Function isPresent($key) {
		$temp = $this->head;
		if ($this->head == NULL)
			return FALSE;
		do {
			if ($temp->value == $key)
				return TRUE;
			$temp = $temp->next;
		} while ( $temp != $this->head );
		return FALSE;
	}
	public Function FreeList() {
		$this->head = NULL;
		$this->tail = NULL;
		$this->size = 0;
	}
	public Function display() {
		if ($this->isEmpty ()) {
			return;
		}
		$temp = $this->head;
		do {
			echo (" " . $temp->value);
			$temp = $temp->next;
		} while ( $temp != $this->head );
		echo ("<br/>");
	}
}

$ll = new DoublyCircularLinkedList ();
$ll->addHead ( 1 );
$ll->addHead ( 2 );
$ll->addHead ( 3 );
$ll->addHead ( 4 );
$ll->addHead ( 5 );
$ll->addHead ( 5 );
$ll->display ();
$ll->removeHead ();
$ll->freeList ();
$ll->display ();
$ll->addHead ( 11 );
$ll->addHead ( 21 );
$ll->addHead ( 31 );
$ll->addHead ( 41 );
$ll->addHead ( 51 );
$ll->addHead ( 51 );
$ll->display ();
?>