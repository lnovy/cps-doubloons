<?php
/**
 * XSL transformation class.
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

define("CONFIG_PATH", "file:///home/lnovy/htdocs/krtek.net/index1/cpsdonation/config/");
define("DEFAULT_XSR_URI", CONFIG_PATH . "/xsltFunctionRegistry");

class PirateTransformer {
	protected $registry = null;
	protected $xp = null;
	protected $xslt = null;
	protected $ixml = null;
	protected $oxml = null;

	public static function getDefaultXFR() {
		$r = new ArrayObject(unserialize(file_get_contents(DEFAULT_XSR_URI)));
		return $r;
	}

	public function __construct($registry = null ) {
		putenv("XML_CATALOG_FILES=/etc/xml/catalog");
		$this->registry = ($registry === null?self::getDefaultXFR():new ArrayObject($registry));
	}

	public function loadXSLT($uri) {
		$xslt = new DOMDocument();
		$xslt->load($uri);
		$this->xslt = $xslt;
	}

	public function loadInputXML($uri) {
		$xml = new DOMDocument();
		$xml->resolveExternals = true;
		$xml->substituteEntities = true;
		$xml->load($uri);
		$this->ixml = $xml;
	}

	protected function setupProcessor() {
		$this->xp = new XsltProcessor();
		if ($this->registry !== null)
			$this->xp->registerPHPFunctions($this->registry);
		$this->xp->importStylesheet($this->xslt);
	}

	public function transform($xmlUri = null, $xsltUri = null) {
		if ($xmlUri !== null)
			$this->loadInputXML($xmlUri);
		if ($xsltUri !== null)
			$this->loadXSLT($xsltUri);
		$this->setupProcessor();
		$this->oxml = $this->xp->transformToDoc($this->ixml);
		return $this->oxml->saveXML();
	}
}

?>
