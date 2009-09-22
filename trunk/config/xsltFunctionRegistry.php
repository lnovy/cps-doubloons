<?php

$r = new ArrayObject(array(
	'PirateDateTime::printTS',
	'PirateGold::printMoney',
	)
);

echo serialize($r);
?>
