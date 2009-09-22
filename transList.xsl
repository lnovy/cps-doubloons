<?xml version="1.0" encoding="utf-8"?>
<!--
  Transaction list transformation template.

  cps-doubloons :: Doubloons of Czech pirate party

  Copyright (c) 2009 Lukáš Nový

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.

-->

<!-- SVN: $Id$ -->

<xsl:stylesheet version="1.0"
	xmlns:xml="http://www.w3.org/XML/1998/namespace"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fb="http://apps.facebook.com/ns/1.0"
	xmlns:php="http://php.net/xsl"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:exslt="http://exslt.org/common"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl php"
	>
	<xsl:output
		doctype-public="-//W3C//DTD XHTML 1.1//EN"
		doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
		media-type="text/html"
		method="xml"
		encoding="utf-8"
		indent="yes"
		version="1.0"
		/>
	<xsl:variable name="transactionTypes">
		<xsl:for-each select="exslt:node-set($transactionTypesUnsorted)//*">
			<xsl:sort select="string-length(./text())" order="ascending" data-type="number" />
			<xsl:copy-of select="." />
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="transactionTypesUnsorted">
		<span id="Bezhotovostní příjem">Incoming payment</span>
		<span id="Bezhotovostní platba">Outgoing payment</span>
		<span id="Vklad pokladnou">Cash deposit</span>
		<span id="Poplatek - platební karta">Debit card fee</span>
		<span id="Platba kartou">Card payment</span>
		<span id="Připsaný úrok">Credit interest</span>
		<span id="Odvod daně z úroků">Interest tax</span>
		<span id="Příjem převodem uvnitř záložny">Incoming in-house transfer</span>
		<span id="Platba převodem uvnitř záložny">Outgoing in-house transfer</span>
<!--		Bank statement printout
		Withdraw from ATM
		External advice fee
		Repeating transfer
		Use and administration od the Consumer Credit
		Loan payment
		Bonus transfer to client account

		Type of transaction (Encashment, Permanent encashment, Transfer, Incoming payment, Payment by a card, Automatic deposit / withdrawal to / from IRTD etc.). -->
	</xsl:variable>
	<xsl:template match="*" mode="unixTimestamp">
		<xsl:value-of select="php:functionString('PirateDateTime::printTS', .)" />
	</xsl:template>
	<xsl:template match="/">
		<style type="text/css">
#transactionList {
	margin-left: 0px;
	margin-right: 0px;
	width: 100%;
	display: block;
}
#transactionFrame dl {
	display: inline-block;
	margin: 0.2em 0;
	padding: 0;
	width: 40%;
}
.dlLeft {
	border-left: 2em solid transparent;
}
dl.dlRight {
	float: right;
	clear: right;
}
#transactionFrame dt {
	display: block;
	margin: 0 0 0 0;
	padding: 0.5em;
	border-top: 1px solid #999;
	font-weight: bold;
}
#transactionFrame dd {
	display: block;
	margin: 0 0 0 0;
	padding: 0.5em;
	border-top: 1px solid #999;
	text-align: center;
}
#viewName {
	font-size: 130%;
	font-weight: bold;
	display: block;
}
#transactionList thead th,
#transactionList tfoot th,
#transactionFrame dt {
	background: #526EA6 none repeat scroll 0 0;
	border: solid 1px;
	border-color: #254588 #254588 #526EA6;
	color: white;
	padding: 4px;
	font-size:11px;
	text-align: center;
	opacity: 0.7;
}
#transactionList
#transactionList th,
#transactionList td {
	text-align: left;
	vertical-align: top;
	padding:2px 8px 3px 9px;
}
#transactionList tfoot td,
#transactionList tbody .transactionAmount,
#transactionList tbody .transactionKS,
#transactionList tbody .transactionSS,
#transactionList tbody .transactionVS {
	text-align: right;
}
#transactionList td.transactionType,
#transactionList td.transactionOtherParty {
	width: 25%;
}
#transactionList tfoot td {
	vertical-align: middle;
}
#transactionList td.transactionNote,
#transactionList th.transactionNote
{
	display: none;
}
#transactionList .groupOfTwo1,
#transactionFrame dd {
	background: #eceff6;
	opacity: 0.7;
}
#transactionList .groupOfTwo2  {
	background: #f7f7f7;
	opacity: 0.7;
}
.transactionDetails table {
	width: 100%;
}
.transactionDetails td {
	width: 80%;
	text-align: left!important;
	vertical-align: top;
}
.transactionDetails th {
	width: 40%;
	text-align: right!important;
	padding-right: 2em;
	vertical-align: top;
}
.transactionDetails tr.transactionNote {
	display: table-row;
}
#cpsMain {
	background: url(http://krtek.net/cpsdonation/back4.png) no-repeat;
	background-attachment: scroll;
	background-position: 0px 270px;
}
div.dlRight div {
	float: right;
}
		</style>
		<div id="cpsMain">
				<a href="http://www.ceskapiratskastrana.cz/pages/podporte-nas/financni-dary.php">
					<fb:intl>Donate</fb:intl>
				</a> |
				<a href="http://apps.facebook.com/add.php?api_key=32c3fa6625699d3e64bcf7c1029814d6&amp;next=http://apps.facebook.com/cpsdonation/provoke.php">
					<fb:intl>I'm a vet</fb:intl>!
				</a> | 
				<a href="http://apps.facebook.com/add.php?api_key=32c3fa6625699d3e64bcf7c1029814d6">
					<fb:intl>Add this app</fb:intl>
				</a> | (<fb:intl>new!</fb:intl>)
				<a href="http://www.ceskapiratskastrana.cz/pages/homepage/volebni-program.php">
					<fb:intl>Election programme</fb:intl>
				</a> |
				<a href="http://www.ceskapiratskastrana.cz/pages/podporte-nas/prodej-tricek.php">
					<fb:intl>Buy a shirt</fb:intl>
				</a> |
				<a href="https://www.ceskapiratskastrana.cz/forum">
					<fb:intl>Enter discussion forum</fb:intl>
				</a> |
				<a href="http://www.ceskapiratskastrana.cz/pages/tiskovy-servis/otazky-a-odpovedi.php">
					<fb:intl>FAQ</fb:intl>
				</a> |
				<a href="http://www.ceskapiratskastrana.cz">
					www.ceskapiratskastrana.cz
				</a>
<span style="float:right">
	<!-- ČPS zveřejňuje své finance na síti Facebook -->
	<fb:add-section-button section="profile" />
</span>
	<div style="clear: both; height: 10px;" />
		<xsl:variable name="tInfo" select="/html/body/div[0]/tr/td[3]" />
		<div id="transactionFrame" class="cpsFrame">
			<span style="float:right">
				<fb:share-button class="meta">
					<meta name="title" content="ČPS zveřejňuje své finance na síti Facebook" />
					<meta name="description" content="Přidejte si aplikaci na svůj profil nebo příspěj na volební kauci!" />.
					<link rel="target_url" href="http://www.facebook.com/pages/ceska-piratska-strana/109323929038?v=app_106891249555" />
					<link rel="image_src" href="http://krtek.net/cpsdonation/logo.png" />
				</fb:share-button>
			</span>
			<div style="clear: both;" />
			<dl id="accInfo" class="dlRight">
				<dt class="accNum">
					<fb:intl description="Bank account number and type">Account</fb:intl>
				</dt>
				<dd class="accNum">
					2100048174/2010 - <fb:intl>Transparent account</fb:intl>
				</dd>
			</dl>
			<dl class="dlRight">
				<dt class="accOwner">
					<fb:intl>Account owner</fb:intl>
				</dt>
				<dd class="accOwner">
					Česká pirátská strana
				</dd>
			</dl>
<!--			<dl style="display: none">
				<dt class="accName">
					<fb:intl>Account name</fb:intl>
				</dt>
				<dd class="accName">
					Česká pirátská strana
				</dd>
				<dt class="accCreation">
					<fb:intl>Date of creation</fb:intl>
				</dt>
				<dd class="accCreation">
					<fb:date t="{php:functionString('PirateDateTime::printTS', //xhtml:span[@class    = 'main_header_row_text'][6])}" format="verbose" tz="Europe/Prague" />
				</dd>
				<dt class="accPeriod">
					<fb:intl description="Account transaction from period">Period</fb:intl>
				</dt>
				<dd class="accPeriod">
					<fb:intl>{periodFrom} – {periodTo}
						<fb:intl-token name="periodFrom">
							<fb:date t="{php:functionString('PirateDateTime::printTS', //xhtml:span[@class    = 'main_header_row_text'][7])}" format="long_numeric" tz="Europe/Prague" />
						</fb:intl-token>
						<fb:intl-token name="periodTo">
						<fb:date t="{php:functionString('PirateDateTime::printTS', //xhtml:span[@class    = 'main_header_row_text'][7], 1)}" format="long_numeric" tz="Europe/Prague" />
						</fb:intl-token>
					</fb:intl>
				</dd>
			</dl>-->
<!--			<dl id="balanceLast" class="dlLeft">
				<dt>
					<fb:intl>
						Account balance on {date}
						<fb:intl-token name="date">
							<fb:date t="{php:functionString('PirateDateTime::printTS', //xhtml:tr[@class = 'header_row'][1]/xhtml:td)}"  format="long_numeric" tz="Europe/Prague" />
						</fb:intl-token>
					</fb:intl>
				</dt>
				<dd>
					<xsl:value-of select="php:functionString('PirateGold::printMoney', //xhtml:tr[@class = 'even_row'][1]/xhtml:td)" />
				</dd>
			</dl>-->
			<dl id="balanceNow" class="dlRight">
				<dt>
					<fb:intl>
						Account balance on {date}
						<fb:intl-token name="date">
							<fb:date t="{php:functionString('PirateDateTime::printTS', //xhtml:table/xhtml:tr[1]/xhtml:td[3]/xhtml:table[@class='table_prm']/xhtml:tr[@class = 'header_row']/xhtml:td)}" format="long_numeric" tz="Europe/Prague" />
						</fb:intl-token>
					</fb:intl>
				</dt>
				<dd>
					<xsl:value-of select="php:functionString('PirateGold::printMoney', //xhtml:table/xhtml:tr[1]/xhtml:td[3]/xhtml:table   [@class='table_prm']/xhtml:tr[@class = 'even_row']/xhtml:td)" />
				</dd>
			</dl>
			<dl id="hoffman" class="dlRight">
				<dt>
					S laskavým svolením publikujeme
				</dt>
				<dd style="padding: 0px;">
				<fb:mp3 src="http://www.ceskapiratskastrana.cz/media/Ivan_Hoffman-Cesti_pirati.mp3" title="Cesti pirati" album="Cesti pirati" artist="Ivan Hoffman"  width="294" height="14" />
				</dd>
			</dl>
			<div style="padding: 0px 2%; margin: 10px -2%; border: 1px solid #ccc; background: #f7f7f7; position: relative; width: 55%; display: inline-block; opacity: 0.7; overflow: ">
<!--				<xsl:variable name="perc" select="php:functionString('PirateGold::getFract', //xhtml:table/xhtml:tr[1]/xhtml:td[3]/xhtml:table[@class='table_prm']/xhtml:tr[@class = 'even_row']/xhtml:td, '210000,00 CZK', 195000)" />
				<div style="margin: 3px auto 3px 3px; padding: 3px; border: rgb(0,64,0) 1px solid; background: #3b5998; width: {$perc}%; text-align: center; vertical-align: middle; color: white; font-size: 80%;">
					<xsl:value-of select="$perc" /> %
				</div>-->
				<div style="margin: 3px auto 3px 3px; padding: 3px; border: rgb(0,64,0) 1px solid; background: #3b5998; width: 100%; text-align: center; vertical-align: middle; color: white; font-size: 80%;">
					&gt;100 %
				</div>
			</div>
	<div style="height: 0.5em; display: inline-block; width: 50%; margin-left: 5%; margin-top: 15px;">
		<span style="float:left; clear: both;"><fb:intl>Deadline:</fb:intl></span><b style="display: inline-block; float:right;">26.8.2009</b><br />
		<span style="float:left; clear: both;"><fb:intl>Needed for election bail:</fb:intl></span><b style="display: inline-block; float: right;">
					<xsl:value-of select="php:functionString('PirateGold::printMoney', '  210 000,00 CZK ')" />
		</b><br />
		<span style="float:left; clear: both;"><fb:intl>Collected:</fb:intl></span><b style="display: inline-block; float: right;">
					<xsl:value-of select="php:functionString('PirateGold::printMoney', //xhtml:table/xhtml:tr[1]/xhtml:td[3]/xhtml:table   [@class='table_prm']/xhtml:tr[@class = 'even_row']/xhtml:td, 0, 210000)" />
		</b><br />

	</div>
			<!--<div style="font-size: 140%; text-align: center; padding: 10px; color: #dd3c10; display: inline-block; width: 55%; font-weight: bold; margin-top: 30px;">
				<a href="http://www.ceskapiratskastrana.cz/pages/podporte-nas/financni-dary.php" style="color: #dd3c10;"><fb:intl>Pirates need you! Donate! Deadline is comming!</fb:intl></a>
			</div>-->
			<div style="font-size: 140%; text-align: center; padding: 10px; color: #10dd3c; display: inline-block; width: 55%; font-weight: bold; margin-top: 30px;">
				<a href="http://www.ceskapiratskastrana.cz/pages/podporte-nas/financni-dary.php" style="color: #10dd3c;"><fb:intl>You made it! A huge Thank You to all who donated!</fb:intl></a>
			</div>
			<div style="clear: both; padding-top: 10px;" />
			<span id="viewName">
				<fb:intl>Account transaction list</fb:intl>
			</span>
			<table id="transactionList">
				<thead>
					<tr class="header">
						<th class="transactionDate"><fb:intl description="column header">Date</fb:intl></th><!-- Date when the transaction was realized. -->
						<th class="transactionAmount"><fb:intl description="column header">Amount</fb:intl></th><!-- Transaction amount. -->
						<th class="transactionType"><fb:intl description="column header">Type</fb:intl></th><!-- Type of transaction (Encashment, Permanent encashment, Transfer, Incoming payment, Payment by a card, Automatic deposit / withdrawal to / from IRTD etc.). -->
<!--						<th class="transactionKS"><fb:intl description="column header">KS</fb:intl></th>--><!-- Variable symbol, that was used during a transaction. It identifies the transaction more closely (e.g. invoice number, insurance policy number, contract number, birth number etc.). -->
						<th class="transactionVS"><fb:intl description="column header">VS</fb:intl></th><!-- Constant symbol, that was used during a transaction. It identifies the transaction more closely. -->
						<!--<th class="transactionSS"><fb:intl description="column header">SS</fb:intl></th>--><!-- Specific symbol, that was used during a transaction. It identifies the transaction more closely. -->
						<th class="transactionOtherParty"><fb:intl description="column header">Transaction account</fb:intl></th><!-- Name of the account to which the given movement in the account relates. It does not need to be completed. In respect of a payment card transaction there is stated a number of such payment card by which the transaction was made. -->
						<!--<th class="transactionNote"><fb:intl description="column header">Note</fb:intl></th>--><!-- This note more closely specifies the movement in the account - e.g. name of a retailer when paying by a payment card, charge definition, message from the sender of the payment. In respect of payments placed by you there is attached a wording that you included within the box "Message for me" or "Note"- this wording cannot be adjusted once the payment was made. -->
						<th><fb:intl>Details</fb:intl></th>
					</tr>
				</thead>
				<tbody>
					<xsl:apply-templates select="//xhtml:table[@class='table_prm' and position() = 2]/xhtml:tr[position() != 1 and position() != last()]" mode="transaction"/>
				</tbody>
				<tfoot>
					<xsl:apply-templates select="//xhtml:table[@class='table_prm' and position() = 2]/xhtml:tr[position() = last()]" mode="footer"/>
				</tfoot>
			</table>
			<xsl:apply-templates select="//xhtml:table[@class='table_prm' and position() = 2]/xhtml:tr[position() != 1 and position() != last()]" mode="dialog"/>
		</div>
		</div>
	</xsl:template>
	<xsl:template match="xhtml:tr" mode="dialog">
		<fb:dialog id="dialog{position()}">
			<fb:dialog-title><fb:intl>Transaction details</fb:intl></fb:dialog-title>
			<fb:dialog-content>
				<table class="transactionDetails">
					<tr class="transactionDate">
						<th>
							<fb:intl>Date</fb:intl>
						</th>
						<td>
							<fb:date t="{php:functionString('PirateDateTime::printTS', xhtml:td[1])}" format="verbose" tz="Europe/Prague" />
						</td>
					</tr>
					<tr>
						<xsl:variable name="doubloons" select="php:functionString('PirateGold::printMoney', xhtml:td[2])" />
						<xsl:choose>
							<xsl:when test="contains($doubloons,'-')">
								<xsl:attribute name="class">transactionAmount negativeAmount</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="class">transactionAmount</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<th>
							<fb:intl>Amount</fb:intl>
						</th>
						<td>
							<xsl:value-of select="$doubloons" />
						</td>
					</tr>
					<tr class="transactionType">
						<th>
							<fb:intl>Type</fb:intl>
						</th>
						<td class="transactionType">
							<fb:intl description="transaction type">
								<xsl:value-of select="exslt:node-set($transactionTypes)//*[contains(current()/xhtml:td[3], @id)]" />
							</fb:intl>
						</td>
					</tr>
					<tr class="transactionKS">
						<th>
							<fb:intl>Constant symbol</fb:intl>
						</th>
						<td>
							<xsl:value-of select="xhtml:td[4]" />
						</td>
					</tr>
					<tr class="transactionVS">
						<th>
							<fb:intl>Variable symbol</fb:intl>
						</th>
						<td>
							<xsl:value-of select="xhtml:td[5]" />
						</td>
					</tr>
					<tr class="transactionSS">
						<th>
							<fb:intl>Specific symbol</fb:intl>
						</th>
						<td>
							<xsl:value-of select="xhtml:td[6]" />
						</td>
					</tr>
					<tr class="transactionOtherParty">
						<th>
							<fb:intl>Transaction account</fb:intl>
						</th>
						<td>
							<xsl:value-of select="xhtml:td[7]" />
						</td>
					</tr>
					<tr class="transactionNote">
						<th>
							<fb:intl>Note</fb:intl>
						</th>
						<td>
							<xsl:value-of select="xhtml:td[8]" />
						</td>
					</tr>
				</table>
			</fb:dialog-content>
			<fb:dialog-button type="button" value="Close" close_dialog="1">
				<fb:fbml-attribute name="value"><fb:intl>Close</fb:intl></fb:fbml-attribute>
			</fb:dialog-button>
		</fb:dialog>
	</xsl:template>
	<xsl:template match="xhtml:tr" mode="footer">
		<tr id="transactionSummary">
			<th colspan="1"><fb:intl>Sum</fb:intl></th>
			<td colspan="1">
				<xsl:value-of select="php:functionString('PirateGold::printMoney', xhtml:td[2])" />
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="xhtml:tr" mode="transaction">
		<tr id="transaction{position()}" class="groupOfTwo{position() mod 2 + 1}">
			<td class="transactionDate" style="width: 5%; text-align:center;">
					<fb:date t="{php:functionString('PirateDateTime::printTS', xhtml:td[1])}" format="long_numeric" tz="Europe/Prague" />
			</td>
			<td style="width: 10%">
				<xsl:variable name="doubloons" select="php:functionString('PirateGold::printMoney', xhtml:td[2])" />
				<xsl:choose>
					<xsl:when test="contains($doubloons,'-')">
						<xsl:attribute name="class">transactionAmount negativeAmount</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">transactionAmount</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$doubloons" />
			</td>
			<td class="transactionType">
				<fb:intl description="transaction type">
					<xsl:value-of select="exslt:node-set($transactionTypes)//*[contains(current()/xhtml:td[3], @id)]" />
				</fb:intl>
			</td>
<!--			<td class="transactionKS">
				<xsl:value-of select="xhtml:td[4]" />
			</td>-->
			<td class="transactionVS" style="width: 5%">
				<xsl:value-of select="xhtml:td[5]" />
			</td>
<!--			<td class="transactionSS">
				<xsl:value-of select="xhtml:td[6]" />
			</td>-->
			<td class="transactionOtherParty">
				<xsl:value-of select="xhtml:td[7]" />
			</td>
<!--			<td class="transactionNote">
				<xsl:value-of select="xhtml:td[8]" />
			</td>-->
			<th style="text-align: center; vertical-align: middle; width: 5%">
				<a href="#" clicktoshowdialog="dialog{position()}">
					<fb:intl>Show&#160;details</fb:intl>
				</a>
			</th>
		</tr>
	</xsl:template>
</xsl:stylesheet>
