<?php
class QueueUsingStack {
	protected $stk1;
	protected $stk2;
	Function __construct() {
		$this->stk1 = Array ();
		$this->stk2 = Array ();
	}
	public Function add($value) {
		array_push ( $this->stk1, $value );
	}
	public Function remove() {
		$value = null;
		
		if (count ( $this->stk2 ) != 0) {
			return array_pop ( $this->stk2 );
		}
		while ( count ( $this->stk1 ) != 0 ) {
			$value = array_pop ( $this->stk1 );
			array_push ( $this->stk2, $value );
		}
		if (count ( $this->stk2 ) == 0)
		{
			echo ("Stack empty error <br/>");
		}
		else{
			return array_pop ( $this->stk2 );
		}
	}
}

$que = new QueueUsingStack ();
$que->add ( 1 );
$que->add ( 11 );
$que->add ( 111 );
echo ($que->remove ());
$que->add ( 2 );
$que->add ( 21 );
$que->add ( 211 );
echo ($que->remove ());
echo ($que->remove ());
echo ($que->remove ());
echo ($que->remove ());
echo ($que->remove ());
echo ($que->remove ());
?>



