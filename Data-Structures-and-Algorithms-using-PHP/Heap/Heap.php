<?php
class Heap {
	protected static $CHPACITY;
	protected $size;
	protected $arr;
	public static Function __staticinit() {
		SElF::$CHPACITY = 15;
	}
	Function __construct($arrIn ) {
		if ($arrIn == null) {
			$this->arr = array (1);
		} else {
			$this->arr = array ();
			array_push ( $this->arr, 1 );
			foreach ( $arrIn as $val )
				array_push ( $this->arr, $val );
		}
		$this->size = $arrIn === null ? 0 :count( $arrIn );
		
		for($i = ( int ) ($this->size / 2); $i > 0; $i --) {
			$this->proclateDown ( $i );
		}
	}
	protected Function proclateDown($position) {
		$lChild = (2 * $position);
		$rChild = ($lChild + 1);
		$small = - 1;
		$temp = null;
		if ($lChild <= $this->size) {
			$small = $lChild;
		}
		if (($rChild <= $this->size) && (($this->arr [$rChild] - $this->arr [$lChild]) < 0)) {
			$small = $rChild;
		}
		if (($small != - 1) && (($this->arr [$small] - $this->arr [$position]) < 0)) {
			$temp = $this->arr [$position];
			$this->arr [$position] = $this->arr [$small];
			$this->arr [$small] = $temp;
			$this->proclateDown ( $small );
		}
	}
	protected Function proclateUp($position) {
		$parent = ( int ) ($position / 2);
		$temp = null;
		if ($parent == 0) {
			return;
		}
		if (($this->arr [$parent] - $this->arr [$position]) > 0) {
			$temp = $this->arr [$position];
			$this->arr [$position] = $this->arr [$parent];
			$this->arr [$parent] = $temp;
			$this->proclateUp ( $parent );
		}
	}
	public Function add($value) {
		$this->arr [++ $this->size] = $value;
		$this->proclateUp ( $this->size );
	}
	public Function remove() {
		if ($this->isEmpty ()) {
			throw new llegalStateException ();
		}
		$value = $this->arr [1];
		$this->arr [1] = $this->arr [$this->size];
		-- $this->size;
		$this->proclateDown ( 1 );
		return $value;
	}
	public Function display() {
		for($i = 1; $i <= $this->size; $i ++) {
			echo (" " . $this->arr [$i]);
		}
		echo "<br/>";
	}
	protected Function isMinHeap($arr, $size) {
		for($i = 0; $i <= (($size - 2) / 2); $i ++) {
			if (((2 * $i) + 1) < $sizeN) {
				if ($arr [$i] > $arr [((2 * $i) + 1)]) {
					return FALSE;
				}
			}
			if (((2 * $i) + 2) < $sizeN) {
				if ($arr [$i] > $arr [(2 * $i) + 2]) {
					return FALSE;
				}
			}
		}
		return TRUE;
	}
	protected Function isMaxHeap($arr, $size) {
		for($i = 0; ($i <= ((($size - 2)) / 2)); $i ++) {
			if (((2 * $i) + 1) < $sizeN) {
				if ($arr [$i] < $arr [(2 * $i) + 1]) {
					return FALSE;
				}
			}
			if (((2 * $i) + 2) < $sizeN) {
				if ($arr [$i] < $arr [(2 * $i) + 2])
					return FALSE;
			}
		}
		return TRUE;
	}
	public Function isEmpty() {
		return ($this->size == 0);
	}
	public Function peek() {
		if ($this->isEmpty ()) {
			throw new llegalStateException ();
		}
		return $this->arr [1];
	}
	public static Function heapSort(&$array) {
		$hp = new Heap ( $array );
		for($i = 0; $i < count ( $array ); $i ++) {
			$array [$i] = $hp->remove ();
		}
	}
}

Heap::__staticinit ();

$a = array (
		1,
		9,
		5,
		7,
		8,
		0,
		2,
		4,
		5,
		10 
);

$hp = new Heap ( $a );
foreach ( $a as $val )
	echo $hp->remove () . " ";
echo "<br/>";
$hp2 = new Heap ( NULL );
$hp2->add ( 1 );
$hp2->add ( 9 );
$hp2->add ( 5 );
$hp2->add ( 7 );
$hp2->add ( 8 );
$hp2->add ( 0 );
$hp2->add ( 2 );
$hp2->add ( 4 );
$hp2->add ( 5 );
$hp2->add ( 10 );
foreach ( $a as $val )
	echo $hp2->remove () . " ";
?>