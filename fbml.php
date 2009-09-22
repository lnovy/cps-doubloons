<?php
/**
 * Profile Boxes.
 *
 * cps-doubloons :: Doubloons of Czech pirate party
 *
 * PHP versions 5
 *
 * Copyright (c) 2009 Lukáš Nový
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * @package   cpsDoubloons
 * @author    Lukáš Nový <pirat@neasy.cz>
 * @copyright 2009 Lukáš Nový
 * @license   http://www.opensource.org/licenses/gpl-3.0.html GPL
 * @version   SVN: $Id$
 * @filesource
 * @link      http://www.krtek.net
 */



require_once 'libs/PirateGold.php';

if (!@in_array('p', $_GET))
	$p = 'narrow';
else
	$p = @$_GET['p'];

	$tsum = file_get_contents('sum.txt');
	preg_match_all('/\d/', $tsum, $m);
	setlocale(LC_MONETARY, 'cs_CZ.UTF-8');
	$tsum = PirateGold::printMoney($tsum, 0, 210000);
//	$tsum = trim(substr($tsum, 0, -5));
	$sum = implode($m[0])/100 + 210000;
	$tneed = PirateGold::printMoney("210 000,00");
	$need = 210000;
	$perc = floor($sum*100/$need);

if ($p == 'narrow') {
	print <<<_END_NARROW_
	<div nostyle="width: 110px; float: right; margin: 0px; padding: 0px; vertical-align: middle;">
     <img src="http://krtek.net/cpsdonation/badgelogocolor.png"  style="height: 2em; float: right;"/>
	<b><a href="http://www.facebook.com/pages/eska-piratska-strana/109323929038?v=app_106891249555">Česká pirátská strana</a></b><br />
	<i style="font-size: 80%">Internet je naše moře!</i><br />
	<p style="margin-top: 8px;">
		Chceš nam dat svuj hlas? Přispěj na kauci pro volby v&nbsp;říjnu 2009!
	</p>
	<div style="clear: both; padding: 3px; margin-top: 0px; border: 1px solid #ccc; background: #f7f7f7; position: relative;">
		<div style="position: relative; padding: 0px 6px 0px 0px">
			<div style="margin: 0px; padding: 3px; border: rgb(0,64,0) 1px solid; background: #3b5998; width: 100%; text-align: center; vertical-align: middle; color: white; font-size: 80%">
				>100 %
			</div>
		</div>
	</div>
	<div style="clear: both;" />
	<div style="height: 0.5em; clear: both;" />
		<span style="float:left; clear: both;">Lhůta kauce:</span><b style="display: inline-block; float:right;">26.8.2009</b><br />
		<span style="float:left; clear: both;">Potřebujeme:</span><b style="display: inline-block; float: right;">$tneed Kč</b><br />
		<span style="float:left; clear: both;">Vybráno:</span><b style="display: inline-block; float: right;">$tsum Kč</b><br />

	</div>

	<div style="clear: both;"></div>

	<div style="clear: both; padding-top: 2em; text-align: center;" id='container'>
	<div style="margin-left: auto; margin-right: auto;">
	<fb:add-section-button section="profile" />
	</div>
	<!--
			<input type="button" value="Vstoupit" class="inputsubmit" onclick="Animation(document.getElementById('container')).to('height', '0px').to('width', '0px').to('opacity', 0).blind().hide().ease(Animation.ease.end).go(); return false;" />
			<input type="button" value="Přispět" class="inputsubmit" onclick="alert(facebook.fbml.refreshRefUrl('http://www.krtek.net/cpsdonation/progress.php')); return 0;"/>
	</div>
	-->
_END_NARROW_;
} elseif ($p == 'wide') {
	print "Wide box not supported yet...";
} else {
	include "profile.php";
}
?>
<fb:subtitle seeallurl="http://www.facebook.com/pages/ceska-piratska-strana/109323929038?v=app_106891249555" >
	Stav k <fb:date t="<?php print time();  ?>" format="long_numeric" />
</fb:subtitle>
