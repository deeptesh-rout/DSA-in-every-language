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
	public Function isEmpty() {
		return ($this->size == 0);
	}
	public Function peek() {
		if ($this->isEmpty ())
			echo ("EmptyListException");
		return $this->head->value;
	}
	public Function addHead($value) {
		$this->head = new Node ( $value, $this->head );
		 ++ $this->size;
	}
	public Function addTail($value) {
		$newNode = new Node ( $value, NULL );
		$curr = $this->head;
		if ($this->head == NULL) {
			$this->head = $newNode;
		}
		while ( $curr->next != NULL ) {
			$curr = $curr->next;
		}
		$curr->next = $newNode;
		++ $this->size;
		
	}
	public Function removeHead() {
		if ($this->isEmpty ())
			echo ("EmptyListException");
		$value = $this->head->value;
		$this->head = $this->head->next;
		-- $this->size;
		return $value;
	}
	public Function isPresent($data) {
		$temp = $this->head;
		while ( $temp != NULL ) {
			if ($temp->value == $data)
				return TRUE;
			$temp = $temp->next;
		}
		return FALSE;
	}
	public Function deleteNode($delValue) {
		$temp = $this->head;
		if ($this->isEmpty ())
			return FALSE;
		if ($delValue == $this->head->value) {
			$this->head = $this->head->next;
			-- $this->size;
			return TRUE;
		}
		while ( $temp->next != NULL ) {
			if ($temp->next->value == $delValue) {
				$temp->next = $temp->next->next;
				-- $this->size;
				return TRUE;
			}
			$temp = $temp->next;
		}
		return FALSE;
	}
	public Function deleteNodes($delValue) {
		$currNode = $this->head;
		$nextNode = NULL;
		while ( ($currNode != NULL) && ($currNode->value == $delValue) ) {
			$this->head = $currNode->next;
			$currNode = $this->head;
			-- $this->size;
		}
		while ( ($currNode != NULL) ) {
			$nextNode = $currNode->next;
			if (($nextNode != NULL) && ($nextNode->value == $delValue)) {
				$currNode->next = $nextNode->next;
				-- $this->size;
			} else {
				$currNode = $nextNode;
			}
		}
	}
	public Function reverseRecurseUtil($currentNode, $nextNode) {
		$ret = NULL;
		if ($currentNode == NULL)
			return NULL;
		if ($currentNode->next == NULL) {
			$currentNode->next = $nextNode;
			return $currentNode;
		}
		$ret = $this->reverseRecurseUtil ( $currentNode->next, $currentNode );
		$currentNode->next = $nextNode;
		return $ret;
	}
	public Function reverseRecurse() {
		$this->head = $this->reverseRecurseUtil ( $this->head, NULL );
	}
	public Function reverse() {
		$curr = $this->head;
		$prev = NULL;
		$next = NULL;
		while ( $curr != NULL ) {
			$next = $curr->next;
			$curr->next = $prev;
			$prev = $curr;
			$curr = $next;
		}
		$this->head = $prev;
	}
	public Function copyListReversed() {
		$tempNode = NULL;
		$tempNode2 = NULL;
		$curr = $this->head;
		while ( $curr != NULL ) {
			$tempNode2 = new Node ( $curr->value, $tempNode );
			$curr = $curr->next;
			$tempNode = $tempNode2;
		}
		$ll2 = new LinkedList ();
		$ll2->head = $tempNode;
		return $ll2;
	}
	public Function copyList() {
		$headNode = NULL;
		$tailNode = NULL;
		$tempNode = NULL;
		$curr = $this->head;
		if ($curr == NULL)
			return NULL;
		$headNode = new Node ( $curr->value, NULL );
		$tailNode = $headNode;
		$curr = $curr->next;
		while ( $curr != NULL ) {
			$tempNode = new Node ( $curr->value, NULL );
			$tailNode->next = $tempNode;
			$tailNode = $tempNode;
			$curr = $curr->next;
		}
		$ll2 = new LinkedList ();
		$ll2->head = $headNode;
		return $ll2;
	}
	public Function compareList($ll) {
		return $this->compareListUtil ( $this->head, $ll->head );
	}
	public Function compareListUtil($head1, $head2) {
		if (($head1 == NULL) && ($head2 == NULL))
			return TRUE;
		else if ((($head1 == NULL) || ($head2::NULL)) || ($head1->value != $head2->value))
			return FALSE;
		else
			return $this->compareListUtil ( $head1->next, $head2->next );
	}
	public Function FindLength() {
		$curr = $this->head;
		$count = 0;
		while ( $curr != NULL ) {
			++ $count;
			$curr = $curr->next;
		}
		return $count;
	}
	public Function nthNodeFromBegining($index) {
		if (($index > $this->size ()) || ($index < 1))
			return $Integer->MAX_VALUE;
		$count = 0;
		$curr = $this->head;
		while ( ($curr != NULL) && ($count < ($index - 1)) ) {
			++ $count;
			$curr = $curr->next;
		}
		return $curr->value;
	}
	public Function nthNodeFromEnd($index) {
		$size = $this->FindLength ();
		$startIndex = NULL;
		if (($size != 0) && ($size < $index)) {
			return $Integer->MAX_VALUE;
		}
		$startIndex = ($size - $index + 1);
		return $this->nthNodeFromBegining ( $startIndex );
	}
	public Function nthNodeFromEnd2($index) {
		$count = 1;
		$forward = $this->head;
		$curr = $this->head;
		while ( ($forward != NULL) && ($count <= $index) ) {
			++ $count;
			$forward = $forward->next;
		}
		if ($forward == NULL)
			return $Integer->MAX_VALUE;
		while ( $forward != NULL ) {
			$forward = $forward->next;
			$curr = $curr->next;
		}
		return $curr->value;
	}
	public Function FindIntersection($head, $head2) {
		$l1 = 0;
		$l2 = 0;
		$tempHead = $head;
		$tempHead2 = $head2;
		while ( $tempHead != NULL ) {
			++ $l1;
			$tempHead = $tempHead->next;
		}
		while ( ($tempHead2 != NULL) ) {
			++ $l2;
			$tempHead2 = $tempHead2->next;
		}
		$diff = NULL;
		if (($l1 < l2)) {
			$temp = $head;
			$head = $head2;
			$head2 = $temp;
			$diff = ($l2 - $l1);
		} else {
			$diff = ($l1 - $l2);
		}
		for(; ($diff > 0); -- $diff) {
			$head = $head->next;
		}
		while ( $head != $head2 ) {
			$head = $head->next;
			$head2 = $head2->next;
		}
		return $head;
	}
	public Function FreeList() {
		$this->head = NULL;
		$this->size = 0;
	}
	public Function display() {
		$temp = $this->head;
		while ( $temp != NULL ) {
			echo ($temp->value . " ");
			$temp = $temp->next;
		}
		echo ("<br/>");
	}
	public Function sortedInsert($value) {
		$newNode = new Node ( $value, NULL );
		$curr = $this->head;
		if (($curr == NULL) || ($curr->value > $value)) {
			$newNode->next = NULL;
			$this->head = $newNode;
			return;
		}
		while ( ($curr->next != NULL) && ($curr->next->value < $value) ) {
			$curr = $curr->next;
		}
		$newNode->next = $curr->next;
		$curr->next = $newNode;
		++ $this->size;
		
	}
	public Function removeDuplicate() {
		$curr = $this->head;
		while ( $curr != NULL ) {
			if (($curr->next != NULL) && ($curr->value == $curr->next->value)) {
				-- $this->size;
				$curr->next = $curr->next->next;
			} else {
				$curr = $curr->next;
			}
		}
	}
	public Function makeLoop() {
		$temp = $this->head;
		while ( $temp != NULL ) {
			if ($temp->next == NULL) {
				$temp->next = $this->head;
				return;
			}
			$temp = $temp->next;
		}
	}
	public Function loopDetect() {
		$slowPtr = NULL;
		$fastPtr = NULL;
		$slowPtr = $fastPtr = $this->head;
		while ( ($fastPtr->next != NULL) && ($fastPtr->next->next != NULL) ) {
			$slowPtr = $slowPtr->next;
			$fastPtr = $fastPtr->next->next;
			if ($slowPtr == $fastPtr) {
				echo ("loop Found");
				return TRUE;
			}
		}
		echo ("loop not Found");
		return FALSE;
	}
	public Function reverseListLoopDetect() {
		$tempHead = $this->head;
		$this->reverse ();
		if ($tempHead == $this->head) {
			$this->reverse ();
			echo ("loop Found");
			return TRUE;
		} else {
			$this->reverse ();
			echo ("loop not Found");
			return FALSE;
		}
	}
	public Function loopTypeDetect() {
		$slowPtr = NULL;
		$fastPtr = NULL;
		$slowPtr = $fastPtr = $this->head;
		while ( ($fastPtr->next != NULL) && ($fastPtr->next->next != NULL) ) {
			if (($this->head == $fastPtr->next) || ($this->head == $fastPtr->next->next)) {
				echo ("circular list loop Found");
				return 2;
			}
			$slowPtr = $slowPtr->next;
			$fastPtr = $fastPtr->next->next;
			if ($slowPtr == $fastPtr) {
				echo ("loop Found");
				return 1;
			}
		}
		echo ("loop not Found");
		return 0;
	}
	public Function loopPointDetect() {
		$slowPtr = NULL;
		$fastPtr = NULL;
		$slowPtr = $fastPtr = $this->head;
		while ( ($fastPtr->next != NULL) && ($fastPtr->next->next != NULL) ) {
			$slowPtr = $slowPtr->next;
			$fastPtr = $fastPtr->next->next;
			if ($slowPtr == $fastPtr) {
				return $slowPtr;
			}
		}
		return NULL;
	}
	public Function removeLoop() {
		$loopPoint = $this->loopPointDetect ();
		if ($loopPoint == NULL)
			return;
		$firstPtr = $this->head;
		if ($loopPoint == $this->head) {
			while ( $firstPtr->next != $this->head )
				$firstPtr = $firstPtr->next;
			$firstPtr->next = NULL;
			return;
		}
		$secondPtr = $loopPoint;
		while ( $firstPtr->next != $secondPtr->next ) {
			$firstPtr = $firstPtr->next;
			$secondPtr = $secondPtr->next;
		}
		$secondPtr->next = NULL;
	}
}

$ll = new LinkedList ();
$ll->addHead ( 3 );
$ll->addHead ( 2 );
$ll->addHead ( 2 );
$ll->addHead ( 2 );
$ll->addHead ( 1 );
$ll->addHead ( 1 );
$ll->addHead ( 3 );
$ll->addHead ( 2 );
$ll->addHead ( 2 );
$ll->addHead ( 2 );
$ll->addHead ( 1 );
$ll->addHead ( 1 );

$ll->display ();
$ll->removeDuplicate();
$ll->display ();
echo ("length :: " . $ll->size()."<br/>");
$ll->sortedInsert ( 2 );
$ll->sortedInsert ( 3 );
echo ("length :: " . $ll->size()."<br/>");
echo ("length :: " . $ll->FindLength()."<br/>");

$ll->display ();
// $ll->reverse();
// $ll->display ();

// $ll->makeLoop();
// echo ($ll->loopDetect()? "found" : "not found");
// echo ($ll->isPresent ( 2) ? "found" : "not found");
// $ll->FreeList ();
// echo ($ll->isEmpty()?"empty":"not empty");

// $ll->display ();
// echo ($ll->nthNodeFromBegining ( 2 ) . "<br/>");
// echo ($ll->nthNodeFromEnd ( 2 ) . "<br/>");
// echo ($ll->nthNodeFromEnd2 ( 2 ) . "<br/>");
// $ll->deleteNode(2);
// $ll->deleteNodes(3);
// echo ("length is :: " . $ll->FindLength());
// $ll2 = $ll->copyListReversed();
// $ll->display();
// $ll2->display();
// $ll2 = $ll->copyList ();
// $ll->FreeList ();
// $ll2->FreeList();
// $ll2->display ();
?>