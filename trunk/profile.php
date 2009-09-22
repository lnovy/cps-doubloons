<?php
/**
 * Profile Tab.
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


require_once 'php/facebook.php';
require_once "libs/PirateTransformer.php";
require_once "libs/PirateDateTime.php";
require_once "libs/PirateGold.php";
require_once "config/keys";


$fb = $facebook = new Facebook($appapikey, $appsecret);
if (@array_key_exists('locale', $fb->fb_params))
	setlocale(LC_ALL, $fb->fb_params['locale'] . ".UTF-8");
else
	setlocale(LC_ALL, "en_US.UTF-8");

$fbml = file_get_contents("default.fbml");

try {
	if ($fb->user)
		$fb->api_client->profile_setFBML(null, $fb->user, $fbml , null, null, $fbml);
} catch (Exception $e)
	{}
try {
	if ($fb->canvas_user)
		$fb->api_client->profile_setFBML(null, $fb->canvas_user, $fbml , null, null, $fbml);
} catch (Exception $e)
	{}
try {
	if ($fb->profile_user)
		$fb->api_client->profile_setFBML(null, $fb->profile_user, $fbml , null, null, $fbml);
} catch (Exception $e)
	{}

if (file_exists($fn = 'cache/transList-' . md5($fb->fb_params['locale']))) {
	readfile($fn);
} else {
	ignore_user_abort(true);
	set_time_limit(0);
	$xp = new PirateTransformer();
	print $c = $xp->transform("transList.xhtml", "transList.xsl");
	$f = fopen($fn, "w");
	fputs($f, $c);
	fclose($f);
}
?>
