<?php
/**
 * Provocation.
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
require_once 'config/keys';

$fb = $facebook = new Facebook($appapikey, $appsecret);

if (array_key_exists("do_send", $_GET) and is_numeric($_POST['milions'])) {

	$user_id = $fb->require_login();
	$att = array();
	$actl = array(
		array('text' => 'Také podpořit',
			'href' => 'http://www.facebook.com/Ceska.piratska.strana'),
	);

	try {
		$fb->api_client->stream_publish(", {$_POST['job']} z {$_POST['place']},  právě poslal(a) částku {$_POST['milions']} miliónů dublonů na podporu „pirátům” ve volbách.", $att, $actl);
?>
<h1>Děkujeme…</h1>
<?php
	} catch (Exception $e) {
		print "<fb:error><fb:message>Přístup odmítnut</fb:message>Povolte prosím aplikaci publikovat zprávy na Vaši Zeď</fb:error>";
	}
} else {
	$user_id = $fb->require_login();
	if (array_key_exists("do_send", $_GET)) {
		print "<fb:error><fb:message>Chybé zadání</fb:message>Zadejte prosím rozumnou číselnou částku</fb:error>";
	}
?>
<style type="text/css">
#sml input,
#sml select {
	border: 1px solid #333;
	font-size: 11px;
	padding: 1px;
}
#sml dt {
	display: inline-block;
	clear: both;
	float: left;
	width: 20em;
	height: 3em;
	vertical-align: middle;
	text-align: right;
	color: #333;
}
#sml dt span{
	vertical-align: middle;
	line-height: 3em;
	color: #333;
}
#sml dd span{
	vertical-align: middle;
	line-height: 3em;
	color: #333;
}
#sml dd {
	clear: right;
	width: 25em;
	float: left;
	height: 3em;
	margin-left: 3em;
	vertical-align: middle;
	color: #333;
}

#sml dl {
	display: block;
	width: 100%;
	clear: both;
}
</style>
<h1>Prohlášení dárce</h1><br /><br />
<p>
	Z důvodů absolutní transparentnosti odešlete prosím následující formulář jako akt prohlášení se za dárce:
</p>
<div style="border: 1px solid #999" id="sml">
<p>
<form method="POST" action="http://apps.facebook.com/cpsdonation/provoke.php?do_send" promptpermission="publish_stream" style="display: inline-block">
<dl class="sml">
<dt><span>Tímto já, občan ČR,</span></dt>
	<dd><span><fb:name uid="<?php print $user_id; ?>" useyou="false" />,</span></dd>
</dl>
<dl>
	<dt><span>veřejně jakožto</span></dt>
	<dd>
	<span>
	<select name="job">
		<option value="veterinář">veterinář</option>
		<option value="archeolog">archeolog</option>
		<option value="pokladní">pokladní</option>
		<option value="řidič taxislužby">řidič taxislužby</option>
		<option value="žena v domácnosti">žena v domácnosti</option>
		<option value="učitelka matematiky">učitelka matematiky</option>
		<option value="revizor MHD">revizor MHD</option>
		<option value="zedník">zedník</option>
		<option value="vrchní čísník">vrchní čísník</option>
	</select>
	</span>
	</dd>
</dl>
<dl>
<dt><span>pochazejíc z</span></dt>
	<dd>
	<span>
	<input name="place" size="10" value="Brna">
	</span>
	</input>
	</dd>
</dl>
<dl>
<dt><span>daruji částku</span></dt>
	<dd>
	<span>
	<input name="milions" value="11" size="3"/></span>
	<span>milionů dublonů </span>
	</dd>
</dl>
<dl>
	<dt>
	<span>jakožto svou</span>
	</dt>
	<dd><span>podporu „pirátům.“</span>
	</dd>
</dl>
<dl>
	<dt></dt>
	<dd>
	<input type="submit" value="Darovat" />
	<!--fb:submit>Darovat</fb:submit-->
	</dd>
</dl>

</form>
</p>
</div>
<?php
}

?>
