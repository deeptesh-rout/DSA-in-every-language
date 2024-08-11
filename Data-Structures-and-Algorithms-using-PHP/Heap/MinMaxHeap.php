<?php
require_once ("Heap2.php");
class MedianHeap {
	protected $minHeap;
	protected $maxHeap;
	Function __construct() {
		$this->minHeap = new Heap ( NULL, True );
		$this->maxHeap = new Heap ( NULL, False );
	}
	public Function insert($value) {
		if (($this->maxHeap->size () == 0) || ($this->maxHeap->peek () >= $value)) {
			$this->maxHeap->add ( $value );
		} else {
			$this->minHeap->add ( $value );
		}
		if ($this->maxHeap->size () > ($this->minHeap->size () + 1)) {
			$value = $this->maxHeap->remove ();
			$this->minHeap->add ( $value );
		}
		if ($this->minHeap->size () > ($this->maxHeap->size () + 1)) {
			$value = $this->minHeap->remove ();
			$this->maxHeap->add ( $value );
		}
	}
	public Function getMedian() {
		if ((($this->maxHeap->size () == 0) && ($this->minHeap->size () == 0)))
			return 99999;
		if (($this->maxHeap->size () == $this->minHeap->size ()))
			return ((($this->maxHeap->peek () + $this->minHeap->peek ())) / 2);
		else if (($this->maxHeap->size () > $this->minHeap->size ()))
			return $this->maxHeap->peek ();
		else
			return $this->minHeap->peek ();
	}
}

$arr = array (
		1,
		9,
		2,
		8,
		3,
		7,
		4,
		5,
		5,
		1,
		9,
		2,
		8,
		3,
		7,
		4,
		5,
		5,
		10,
		10
);
$hp = new MedianHeap ();
For($i = 0; ($i < 20); ++ $i) {
	$hp->insert ( $arr [$i] );
	echo ("Median after insertion of " . $arr [$i] . " is " . $hp->getMedian ()."<br/>");
}
?>