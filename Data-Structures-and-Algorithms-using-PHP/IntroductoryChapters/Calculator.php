<?php
class Calculator {
	protected $value;
	Function __construct($val = NULL) {
		if ($val == NULL)
			$this->value = 0;
		else
			$this->value = $val;
	}
	public Function reset() {
		$this->value = 0;
	}
	public Function getValue() {
		return $this->value;
	}
	public Function add($data) {
		$this->value += $data;
	}
	public Function increment() {
		$this->value += 1;
	}
	public Function subtract($data) {
		$this->value -= $data;
	}
	public Function decrement() {
		$this->value -= 1;
	}
}

$ct = new Calculator(30);
$ct->add(50);$ct->subtract(10);$ct->increment();
echo ($ct->getValue());
?>
