<?php
abstract class Shape {
	abstract Function area();
	abstract Function perimeter();
}
class Circle extends Shape {
	protected $radius;
	Function __construct($r) {
		$this->radius = $r;
	}
	public Function setRadius($r) {
		$this->radius = $r;
	}
	public Function area() {
		return (pi () * pow ( $this->radius, 2 ));
	}
	public Function perimeter() {
		return ((2 * pi ()) * $this->radius);
	}
}
class Rectangle extends Shape {
	protected $width;
	protected $length;
	Function __construct($w, $l) {
		$this->width = $w;
		$this->length = $l;
	}
	public Function setwidth($w) {
		$this->width = $w;
	}
	public Function setLength($l) {
		$this->length = $l;
	}
	public Function area() {
		return ($this->width * $this->length);
	}
	public Function perimeter() {
		return (2 * (($this->width + $length)));
	}
}

$r = new Rectangle ( 5, 5 );
echo ($r->area () . "<br/>");
$c = new Circle ( 4 );
echo ($c->area () . "<br/>");
?>