<?php

/**
 * @file plugins/themes/custom/CustomThemeSettingsForm.inc.php
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class CustomThemeSettingsForm
 * @ingroup plugins_generic_customTheme
 *
 * @brief http://195.37.232.186/ojs/index.php/chiron/manager/plugin/themes/DainstThemePlugin/settings
 */

import('lib.pkp.classes.form.Form');

class DainstThemeSettingsForm extends Form {

	/** @var $journalId int */
	var $journalId;

	/** @var $plugin object */
	var $plugin;

	/**
	 * Constructor
	 * @param $plugin object
	 * @param $journalId int
	 */
	function DainstThemeSettingsForm(&$plugin, $journalId) {
		$this->journalId = $journalId;
		$this->plugin =& $plugin;
		$templateMgr =& TemplateManager::getManager();
		$templateMgr->assign('colorz', $this->getDainstColors());
		$templateMgr->assign('colorsel',$plugin->getSetting($journalId, 'dainstcicolor'));
		parent::Form($plugin->getTemplatePath() . 'dainstThemeForm.tpl');

	}

	
	function getDainstColors() {
		$colorsfile = realpath($this->plugin->getTemplatePath() . '../') . '/dainstColors.css';
		$css = file_get_contents($colorsfile);
		$result = array();
		if($css === FALSE) {
			return $result;
		}
        preg_match_all( '/(?ims)([a-z0-9\s\.\:#_\-@,]+)\{([^\}]*)\}/', $css, $arr);

        foreach ($arr[0] as $i => $x){
            $selector = trim($arr[1][$i]);
            $rules = explode(';', trim($arr[2][$i]));
            $rules_arr = array('background-color' => '', 'alias' => '');
            foreach ($rules as $strRule){
                $bg = '';
                if (!empty($strRule)){
                    $rule = explode(":", $strRule);
                    
                    $rules_arr[trim($rule[0])] = trim($rule[1]);
                }
            }

            $selectors = explode(',', trim($selector));
            foreach ($selectors as $strSel){
                if (substr($strSel, 1, 12) == 'dainstColor.') {
                    $result[substr($strSel, 13)] = $rules_arr;
                }
            }
        }
		return $result;
	}
	
	
	/**
	 * Display the form
	 */
	function display() {
		
		return parent::display();
	}

	/**
	 * Initialize form data.
	 */
	function initData() {
		$journalId = $this->journalId;
		$plugin =& $this->plugin;

		$this->_data = array(
			'dainstcicolor' => $plugin->getSetting($journalId, 'dainstcicolor')
		);
	}

	/**
	 * Assign form data to user-submitted data.
	 */
	function readInputData() {
		$this->readUserVars(array('dainstcicolor'));
	}

	/**
	 * Save settings. 
	 */
	function execute() {
		$plugin =& $this->plugin;
		$journalId = $this->journalId;
		var_dump($this->_data);
		
		$plugin->updateSetting($journalId, 'dainstcicolor', $this->_data['dainstcicolor'], 'string');
		
	}
	

	

}

?>
