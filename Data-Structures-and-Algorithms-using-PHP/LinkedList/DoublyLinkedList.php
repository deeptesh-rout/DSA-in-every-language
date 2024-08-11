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
class DoublyLinkedList {
	protected $head; // Node
	protected $tail; // Node
	protected $size; // int
	Function __construct() {
		$this->size = 0;
		$this->head = NULL;
		$this->tail = NULL;
	}
	public Function size() {
		return $this->size;
	}
	public Function isEmpty() {
		return ($this->size == 0);
	}
	public Function peek() {
		iF ($this->isEmpty ())
			echo ("EmptyListException");
		return $this->head->value;
	}
	public Function addHead($value) {
		$newNode = new Node ( $value, NULL, NULL );
		iF ($this->size == 0) {
			$this->tail = $this->head = $newNode;
		} else {
			$this->head->prev = $newNode;
			$newNode->next = $this->head;
			$this->head = $newNode;
		}
		++ $this->size;
	}
	public Function addTail($value) {
		$newNode = new Node ( $value, NULL, NULL );
		iF ($this->size == 0) {
			$this->head = $this->tail = $newNode;
		} else {
			$newNode->prev = $this->tail;
			$this->tail->next = $newNode;
			$this->tail = $newNode;
		}
		++ $this->size;
	}
	public Function removeHead() {
		iF ($this->isEmpty ())
			echo ("EmptyListException");
		$value = $this->head->value;
		$this->head = $this->head->next;
		iF ($this->head == NULL)
			$this->tail = NULL;
		else
			$this->head->prev = NULL;
		-- $this->size;
		return $value;
	}
	public Function removeNode($key) {
		$curr = $this->head;
		iF ($curr == NULL)
			return FALSE;
		iF ($curr->value == $key) {
			$this->head = $this->head->next;
			-- $this->size;
			iF (($this->head != NULL))
				$this->head = NULL;
			else
				$this->tail = NULL;
			return TRUE;
		}
		while ( $curr->next != NULL ) {
			iF ($curr->next->value == $key) {
				$curr->next = $curr->next->next;
				iF ($curr->next == NULL)
					$this->tail = $curr;
				else
					$curr->next = $curr;
				-- $this->size;
				return TRUE;
			}
			$curr = $curr->next;
		}
		return FALSE;
	}
	public Function isPresent($key) {
		$temp = $this->head;
		while ( $temp != NULL ) {
			iF ($temp->value == $key)
				return TRUE;
			$temp = $temp->next;
		}
		return FALSE;
	}
	public Function FreeList() {
		$this->head = NULL;
		$this->tail = NULL;
		$this->size = 0;
	}
	public Function display() {
		$temp = $this->head;
		while ( $temp != NULL ) {
			echo ($temp->value . " ");
			$temp = $temp->next;
		}
		echo "<br/>";
	}
	protected Function sortedInsert($value) {
		$temp = new Node ( $value );
		$curr = $this->head;
		iF ($curr == NULL) {
			$this->head = $temp;
			$this->tail = $temp;
		}
		iF ($this->head->value <= $value) {
			$temp->next = $this->head;
			$this->head->prev = $temp;
			$this->head = $temp;
		}
		while ( ($curr->next != NULL) && ($curr->next->value > $value) ) {
			$curr = $curr->next;
		}
		iF ($curr->next == NULL) {
			$this->tail = $temp;
			$temp->prev = $curr;
			$curr->next = $temp;
		} else {
			$temp->next = $curr->next;
			$temp->prev = $curr;
			$curr->next = $temp;
			$temp->next->prev = $temp;
		}
	}
	protected Function reverseList() {
		$curr = $this->head;
		$tempNode = null;
		while ( $curr != NULL ) {
			$tempNode = $curr->next;
			$curr->next = $curr->prev;
			$curr->prev = $tempNode;
			iF ($curr->prev == NULL) {
				$this->tail = $this->head;
				$this->head = $curr;
				return;
			}
			$curr = $curr->prev;
		}
		return;
	}
	protected Function removeDuplicate() {
		$curr = $this->head;
		$deleteMe = null;
		while ( $curr != NULL ) {
			iF (($curr->next != NULL) && ($curr->value == $curr->next->value)) {
				$deleteMe = $curr->next;
				$curr->next = $deleteMe->next;
				$curr->next->prev = $curr;
				iF (($deleteMe == $this->tail)) {
					$this->tail = $curr;
				}
			} else {
				$curr = $curr->next;
			}
		}
	}
	protected Function copyListReversed() {
		$dll = new DoublyLinkedList ();
		$curr = $this->head;
		while ( $curr != NULL ) {
			$dll->addHead ( $curr->value );
			$curr = $curr->next;
		}
		return $dll;
	}
	protected Function copyList() {
		$dll = new DoublyLinkedList ();
		$curr = $this->head;
		while ( $curr != NULL ) {
			$dll->addTail ( $curr->value );
			$curr = $curr->next;
		}
		return $dll;
	}
}

$ll = new DoublyLinkedList ();
$ll->addHead ( 1 );
$ll->addHead ( 2 );
$ll->addHead ( 3 );
$ll->addHead ( 4 );
$ll->addHead ( 5 );
$ll->addHead ( 5 );
$ll->display ();
$ll->removeHead ();
$ll->display ();
$ll->freeList ();
$ll->display ();
echo ($ll->isEmpty () ? "empty" : "not empty")."<br/>";
$ll->addHead ( 11 );
$ll->addHead ( 21 );
$ll->addHead ( 31 );
$ll->addHead ( 41 );
$ll->addHead ( 51 );
$ll->addHead ( 51 );
$ll->display ();
?>