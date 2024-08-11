<?php
class Heap {
	protected static $CHPACITY;
	protected $size;
	protected $arr;
	protected $isMin;
	public static Function __staticinit() {
		SElF::$CHPACITY = 15;
	}
	Function size(){
		return $this->size;
	}
	Function comp($first, $second) {
		if ($this->isMin == TRUE)
			return $first < $second;
		else
			return $first > $second;
	}
	Function __construct($arrIn, $isMin) {
		if ($arrIn == NULL) {
			$this->arr = array (
					1 
			);
		} else {
			$this->arr = array ();
			array_push ( $this->arr, 1 );
			foreach ( $arrIn as $val )
				array_push ( $this->arr, $val );
		}
		if ($isMin == FALSE) {
			$this->isMin = FALSE;
		} else {
			$this->isMin = TRUE;
		}
		
		$this->size = $arrIn === null ? 0 :count( $arrIn );
		
		for($i = ( int ) ($this->size / 2); $i > 0; $i --) {
			$this->proclateDown ( $i );
		}
	}
	protected Function proclateDown($parent) {
		$lChild = (2 * $parent);
		$rChild = ($lChild + 1);
		$child = - 1;
		$temp = null;
		if ($lChild <= $this->size) {
			$child = $lChild;
		}
		if (($rChild <= $this->size) && $this->comp ( $this->arr [$rChild], $this->arr [$lChild] )) {
			$child = $rChild;
		}
		if (($child != - 1) && $this->comp ( $this->arr [$child], $this->arr [$parent] )) {
			$temp = $this->arr [$parent];
			$this->arr [$parent] = $this->arr [$child];
			$this->arr [$child] = $temp;
			$this->proclateDown ( $child );
		}
	}
	protected Function proclateUp($child) {
		$parent = ( int ) ($child / 2);
		$temp = null;
		if ($parent == 0) {
			return;
		}
		if ($this->comp ( $this->arr [$child], $this->arr [$parent] )) {
			$temp = $this->arr [$child];
			$this->arr [$child] = $this->arr [$parent];
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

$hp3 = new Heap ( $a, NULL );
foreach ( $a as $val )
	echo $hp3->remove () . " ";
$hp4 = new Heap ( $a, TRUE );
foreach ( $a as $val )
	echo $hp4->remove () . " ";
$hp5 = new Heap ( $a, FALSE );
foreach ( $a as $val )
	echo $hp5->remove () . " ";
?>