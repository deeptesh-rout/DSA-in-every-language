<?php
abstract class BulbInterface {
	abstract Function turnOn();
	abstract Function turnOff();
	abstract Function isOnFun();
}
class Bulb extends BulbInterface {
	// Class Variables
	protected static $TotalBulbCount = 0;
	
	// Instance Variables
	protected $isOn;
	
	// Constructor
	Function __construct() {
		SElF::$TotalBulbCount ++;
		$this->isOn = false;
	}
	
	// Class Method
	public static Function getBulbCount() {
		return SElF::$TotalBulbCount;
	}
	
	// Instance Method
	public Function turnOn() {
		$this->isOn = true;
	}
	
	// Instance Method
	public Function turnOff() {
		$this->isOn = false;
	}
	
	// Instance Method
	public Function isOnFun() {
		return $this->isOn;
	}
}
class AdvanceBulb extends Bulb {
	// Instance Variables
	protected $intensity;
	
	// Constructor
	Function __construct() {
		$this->intensity = 1;
	}
	
	// Instance Method
	public Function setIntersity($i) {
		$this->intensity = $i;
	}
}

$b = new Bulb ();
if ($b->isOnFun ())
	echo ("bulb is en return : true<br/>");
else
	echo ("bulb is en return : false<br/>");
$b->turnOn ();
if ($b->isOnFun ())
	echo ("bulb is en return : true<br/>");
else
	echo ("bulb is en return : false<br/>");
$c = new Bulb ();
$d = new Bulb ();
echo ("bulb count is : " . Bulb::getBulbCount () . "<br/>");
?>