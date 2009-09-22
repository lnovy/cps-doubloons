<?php
/**
 * Money printing class.
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

class PirateGold {
	public static function printMoney($money, $i = 0, $bias = 0) {
		preg_match_all("/(\-?\d(\d| )*,\d+)\s*([A-Z]*)/", $money, $m);
		$currency = $m[3][$i];
		$m = (float)strtr($m[1][$i], array("," => ".", " " => ""));
		return money_format('%!.2i', $m + $bias) . " "  . $currency;
	}

	public static function getFract($val, $tot, $valBias = 0, $totBias = 0) {
		preg_match_all("/(\-?\d(\d| )*,\d+)\s*([A-Z]*)/", $tot, $m);
		$currency = $m[3][0];
		$t = $totBias + (float)strtr($m[1][0], array("," => ".", " " => ""));

		preg_match_all("/(\-?\d(\d| )*,\d+)\s*([A-Z]*)/", $val, $m);
		$currency = $m[3][0];
		$v = $valBias + (float)strtr($m[1][0], array("," => ".", " " => ""));

		return floor($v*100/$t);
	}
}

?>
