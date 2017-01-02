<?php

/**
 * @file plugins/themes/dainst/DsainstThemePlugin.inc.php
 *
 * Copyright (c) DAINST
 *
 * @class DainstThemePlugin
 * @ingroup plugins_themes_dainst
 *
 * @brief "Dainst" theme plugin
 */

import('classes.plugins.ThemePlugin');

class DainstThemePlugin extends ThemePlugin {

	
	/**
	 * Get the name of this plugin. The name must be unique within
	 * its category.
	 * @return String name of plugin
	 */
	function getName() {
		return 'DainstThemePlugin';
	}

	function getDisplayName() {
		return 'Dainst Theme';
	}

	function getDescription() {
		return 'Dainst layout';
	}

	function getStylesheetFilename() {
		return null; // does not work for some reason
	}

	/**
	 * registers a function to be called when page is displayed
	 * 
	 * (non-PHPdoc)
	 * @see PKPPlugin::register($category, $path)
	 */
	function register($category, $path) {
		if (parent::register($category, $path)) {		
			$this->addLocaleData();			
			HookRegistry::register('TemplateManager::display', array($this, 'dainstTemplate'));
			return true;
		}
		return false;
	}

	/**
	 * (non-PHPdoc)
	 * @see PKPPlugin::getTemplatePath()
	 */
	function getTemplatePath() {
		$basePath = dirname(dirname(dirname(dirname(__FILE__))));
		return "$basePath/" . $this->getPluginPath() . '/templates/';
	}
	
	function getFilePath() {
		return dirname(__FILE__);
	}

	/**
	 * 
	 * @param ref $smarty
	 * @param unknown $add
	 */
	function addHeadData(&$smarty, $add) {
		$additionalHeadData = $smarty->get_template_vars('additionalHeadData');
		$smarty->assign('additionalHeadData', $additionalHeadData."\n".$add);
	}
	
	/**
	 * 
	 * @param ref $smarty
	 * @return StdClass
	 */
	function getUser(&$smarty) {
		if (!defined('SESSION_DISABLE_INIT')) {
			$session =& Request::getSession();
			$loginUrl = Request::url(null, 'login', 'signIn');
			
			// if the page is not ssl enabled, and force_login_ssl is set, this flag will present a link instead of the form
			$forceSSL = false;
			if (Config::getVar('security', 'force_login_ssl')) {
				if (Request::getProtocol() != 'https') {
					$loginUrl = Request::url(null, 'login');
					$forceSSL = true;
				}
				$loginUrl = String::regexp_replace('/^http:/', 'https:', $loginUrl);
			}	
			
			return (object) array(
				"userName" 	=>	$session->getSessionVar('username'),
				"loginUrl" 	=>	$loginUrl,
				"forceSSL" 	=>	$forceSSL,
				"hasOtherJournals" => $smarty->get_template_vars('hasOtherJournals'),
				"signedInAs"	=> $session->getSessionVar('signedInAs')
			);
			
		}
	}
	
	
	private $_idaic;
	
	/**
	 * constructor
	 */
	function __construct() {		
		$this->theUrl = Request::getBaseUrl();
	}
	
	/**
	 * show the idai-navbar!
	 * 
	 * registered as smarty block function
	 * 
	 * @param unknown $params
	 * 	subtitle - string: journal name
	 * @return string
	 */
	function getNavbar($params, $content, &$smarty, &$repeat) {
		
		if ($repeat == true) {
			return;
		}

		$session = $this->getUser($smarty);
		$journal =& Request::getJournal();

		// construct the navbar via the settings array
		$this->_idaic->settings['return']							= true;
		$this->_idaic->settings['logo']['text'] 					= '';
		$this->_idaic->settings['logo']['src'] 						= $this->theUrl . '/' . $this->pluginPath . '/img/logo_publications.jpg';
		$this->_idaic->settings['logo']['href'] 					= $this->theUrl;  
		$this->_idaic->settings['logo']['href2'] 					= $smarty->smartyUrl(array('page' => "index"));
		
		$this->_idaic->settings['search']['href']					= ($journal != null) ? $smarty->smartyUrl(array("page" => "search", "context" => $journal->getPath(), "op" => 'search')) : 'index.php/index/search/search?';
		$this->_idaic->settings['search']['name'] 					= "simpleQuery";
		$this->_idaic->settings['search']["params"] 				= array('searchField' => 'query');
		$this->_idaic->settings['search']["label"]					= strtoupper(AppLocale::translate("plugins.themes.dainst.search"));
		
		$this->_idaic->settings["user"]["name"] 					= (Validation::isLoggedIn()) ? $session->userName : '';
		
		$this->_idaic->settings['buttons']['login']['href'] 		= $smarty->smartyUrl(array("page" => "login", "op" => "signIn"));
		$this->_idaic->settings['buttons']['login']['label'] 		= AppLocale::translate("plugins.themes.dainst.signIn");
		unset($this->_idaic->settings['buttons']['login']['glyphicon']);
		$this->_idaic->settings['buttons']['register']['href'] 		= $smarty->smartyUrl(array("page" => "user", "op" => "register"));
		$this->_idaic->settings['buttons']['register']['label'] 	= AppLocale::translate("plugins.themes.dainst.signUp");
		
		
		$this->_idaic->settings['buttons']['usermenu']["glyphicon"]	= 'user';
		
		// (username) -> my journals
		if ($session->hasOtherJournals) {
			$this->_idaic->settings['buttons']['usermenu']["submenu"]["a"] = array(
				"label"	=>	AppLocale::translate("plugins.themes.dainst.myJournals"),
				"href"	=>	$smarty->smartyUrl(array('journal' => "index", 'page' => "user"))
			);
		}
		
		// (username) -> my profile
		$this->_idaic->settings['buttons']['usermenu']["submenu"]["b"] = array(
				"label"	=>	AppLocale::translate("plugins.themes.dainst.myProfile"),
				"href"	=>	$smarty->smartyUrl(array("page" => "user", "op" => "profile"))
		);

		// (username) -> logout
		$this->_idaic->settings['buttons']['usermenu']["submenu"]["logout"] = array(
				"label"	=>	AppLocale::translate("plugins.themes.dainst.logout"),
				"href"	=>	$smarty->smartyUrl(array("page" => "login", "op" => "signOut"))
		);
		if ($session->signedInAs) {
			$this->_idaic->settings['buttons']['usermenu']["submenu"]["z"] = array(
				"label"	=>	AppLocale::translate("plugins.themes.dainst.signOutAsUser"),
				"href"	=>	$smarty->smartyUrl(array('page' => "login", 'op' => "signOutAsUser"))
			);
		}
		
		unset($this->_idaic->settings['buttons']['zzzzcontact']);
		
		$this->_idaic->navbar($content);
	}
	
	/**
	 * show the idai-footer
	 *
	 * registered as  smarty function 
	 *
	 * @param array $params
	 * @return string
	 */
	function getFooter($params, &$smarty) {
		$this->_idaic->settings["footer_classes"] = array($params["mode"]);
		
		$this->_idaic->settings["footer_links"]["termsofuse"] = array(
			'label' => AppLocale::translate("plugins.themes.dainst.termsOfUse"), //'Terms of use',
			'moreinfo' => AppLocale::translate("plugins.themes.dainst.termsOfUseText")
		);
		
		$this->_idaic->settings["footer_links"]["contact"] = array(
			'text' => AppLocale::translate("plugins.themes.dainst.reportBugsTo"), // report Bugs to
			'label' => 'idai.publications@dainst.de',
			'href' => 'mailto:idai.publications@dainst.de'
		);
		
		$this->_idaic->settings["footer_links"]["imprint"] = array(
			'label' => AppLocale::translate("plugins.themes.dainst.imprint"), // report Bugs to
			'href' => 'http://www.dainst.org/impressum',
			'target' => '_blank'
		);
		
		
		$this->_idaic->settings['version']			= '';
		
		unset($this->_idaic->settings["footer_links"]['licence']);
		
		return $this->_idaic->footer();
	}
	
	/**
	 * show the pdf reader
	 * 
	 * registered as samrty function
	 * 
	 * @param array $params 
	 * 	file - full url to pdf file
	 * @param red $smarty
	 * @return string
	 */
	function getViewer($params, &$smarty) {
		$viewerSrc = $this->theUrl . '/plugins/themes/dainst/inc/dbv/viewer.html';
		return "<iframe id='dainstPdfViewer' onload='setViewerHeight()' src='$viewerSrc?file={$params['file']}&pubid={$params['article']}'></iframe>";
	} 
	
	
	
	function getHtaccessDebug() {
		return;
		echo "<pre style='max-height:150px'>";
		var_dump($_SERVER);
		echo "</pre>";
	}
	
	function getOJSFolder() {
		echo Config::getVar('dainst', 'ojsFolder');
	}
	function getOJSDomain() {
		echo Config::getVar('dainst', 'ojsDomain');
	}
	
	/**
	 * 
	 * @param unknown $hookName
	 * @param unknown $params
	 * @return boolean
	 */
	function dainstTemplate($hookName, $params) {

		$tpl 	= $params[1];
		$smarty = $params[0];
		$journal =& Request::getJournal();
		$templateMgr =& TemplateManager::getManager();
				
		// cache cleansing
		$templateMgr->caching = 0;
		$templateMgr->cache_lifetime = 0;
		$templateMgr->clear_all_cache();
		$templateMgr->clear_compiled_tpl(); //*/
		
		//debug
		//$templateMgr->debugging = false;
		
		//url
		$thePath = $this->theUrl . '/' . $this->pluginPath;
		
		// create the idai compontents php object
		
		require_once($this->getFilePath() . '/idai-components-php/idai-components.php');
		$this->_idaic = new \idai\components(array('return'	=>	true));
		
		// the idai-stylesheets and stuff
		$this->_idaic->settings["scripts"]["jquery"]["include"] = false;
		$this->_idaic->settings["scripts"]["bootstrap"]["include"] = false;
		$this->addHeadData($smarty, $this->_idaic->header("$thePath/idai-components-php/"));
		$this->addHeadData($smarty, "<link rel='stylesheet' href='$thePath/dainst.css' type='text/css' />");
		$this->addHeadData($smarty, "<link rel='stylesheet' href='$thePath/dainstColors.css' type='text/css' />");
		if($tpl == 'article/article.tpl') {
			$this->addHeadData($smarty, "<link rel='stylesheet' href='$thePath/inc/leaflet/leaflet.css' type='text/css' />");
			$this->addHeadData($smarty, "<script src='$thePath/inc/leaflet/leaflet.js'></script>");		
			$this->addHeadData($smarty, "<script src='$thePath/js/daian.js'></script>");
		}
		$this->addHeadData($smarty, "<script src='$thePath/js/jquery-fixDataFn.js'></script>");
		
		// the colorsheme color
		$dainstcicolor = ($journal) ? $this->getSetting($journal->getId(), 'dainstcicolor') : 'components'; 
		$templateMgr->assign('dainstcicolor', $dainstcicolor);
		
		// register functions for idai-components-php
		$smarty->register_block("idai_navbar", array($this, "getNavbar"));
		$smarty->register_function("idai_footer", array($this, "getFooter"));
		$smarty->register_function("pdf_viewer", array($this, "getViewer"));
		$smarty->register_function("getHtaccessDebug", array($this, "getHtaccessDebug"));
		$smarty->register_function("getOJSFolder", array($this, "getOJSFolder"));
		$smarty->register_function("getOJSDomain", array($this, "getOJSDomain"));
		$smarty->register_function("debugPubIDSettings", array($this, "debugPubIDSettings"));
		
		// register function for in-frontpage-archieve
		$smarty->register_function("journal_archive", array($this, "getArchive"));
			
		// override the default templates 
		array_unshift($smarty->template_dir, $this->getTemplatePath());
		
		//}

		return false;


		/*
		 * so könnte man den output selber filtern 
		 * $smarty->register_outputfilter(array(&$this, 'xxx'));
		 */
		//
		

	}
	
	function getArchive($params, &$templateMgr) {
		//archive_without_header.tpl

		
		$journal =& Request::getJournal();
		$issueDao =& DAORegistry::getDAO('IssueDAO');
		import('classes.handler.Handler');
		$IssueHandler = new PKPHandler();
		$rangeInfo = $IssueHandler::getRangeInfo('issues');
		
		$publishedIssuesIterator = $issueDao->getPublishedIssues($journal->getId(), $rangeInfo);
		
		import('classes.file.PublicFileManager');
		$publicFileManager = new PublicFileManager();
		$coverPagePath = Request::getBaseUrl() . '/';
		$coverPagePath .= $publicFileManager->getJournalFilesPath($journal->getId()) . '/';
		
		$templateMgr =& TemplateManager::getManager();
		$templateMgr->assign('coverPagePath', $coverPagePath);
		$templateMgr->assign('locale', AppLocale::getLocale());
		$templateMgr->assign('primaryLocale', $journal->getPrimaryLocale());
		$templateMgr->assign_by_ref('issues', $publishedIssuesIterator);
		$templateMgr->assign('helpTopicId', 'user.currentAndArchives');
		$templateMgr->display('issue/archive_without_header.tpl');
	}
	
	
	/**
	 * Get the available management verbs.
	 * @return array key-value pairs
	 */
	function getManagementVerbs() {
		return array(array('settings', 'Settings'));
	}
	
	/**
	 * Manage the theme.
	 * @param $verb string management action
	 */
	function manage($verb) {
		if ($verb != 'settings') return false;
		
		$journal =& Request::getJournal();
		$journalId = ($journal ? $journal->getId() : CONTEXT_ID_NONE);
		$templateMgr =& TemplateManager::getManager();
		
		$templateMgr->register_function('plugin_url', array(&$this, 'smartyPluginUrl'));
		$templateMgr->setCacheability(CACHEABILITY_MUST_REVALIDATE);
		
		$this->import('DainstThemeSettingsForm');
		$form = new DainstThemeSettingsForm($this, $journalId);
		if (Request::getUserVar('save')) {
			$form->readInputData();
			if ($form->validate()) {
				$form->execute();
				Request::redirect(null, 'manager', 'plugin', array('themes', 'DainstThemePlugin', 'settings'));
			} else {
				$this->setBreadCrumbs(true);
				$form->display();
			}
		} else {
			$this->setBreadCrumbs(true);
			$form->initData();
			$form->display();
		}

		return true;
		
	}
	
	
	/**
	 * Set the page's breadcrumbs, given the plugin's tree of items
	 * to append.
	 * @param $subclass boolean
	 */
	function setBreadcrumbs($isSubclass = false) {
		$templateMgr =& TemplateManager::getManager();
		$pageCrumbs = array(
				array(
						Request::url(null, 'user'),
						'navigation.user'
				),
				array(
						Request::url(null, 'manager'),
						'user.role.manager'
				)
		);
		$pageCrumbs[] = array(
				Request::url(null, 'manager', 'plugins'),
				'manager.plugins'
		);
		$pageCrumbs[] = array(
				Request::url(null, 'manager', 'plugins', 'themes'),
				'plugins.categories.themes'
		);
	
		$templateMgr->assign('pageHierarchy', $pageCrumbs);
	}
	
	/**
	 * Extend the {url ...} smarty to support this plugin.
	 * @param $params array
	 * @param $smarty object reference
	 * @return string
	 */
	function smartyPluginUrl($params, &$smarty) {
		$path = array($this->getCategory(), $this->getName());
		if (is_array($params['path'])) {
			$params['path'] = array_merge($path, $params['path']);
		} elseif (!empty($params['path'])) {
			$params['path'] = array_merge($path, array($params['path']));
		} else {
			$params['path'] = $path;
		}
	
		if (!empty($params['id'])) {
			$params['path'] = array_merge($params['path'], array($params['id']));
			unset($params['id']);
		}
		return $smarty->smartyUrl($params, $smarty);
	}
	
	
	/**
	 * some debuig stuff...
	 */
	function debugPubIDSettings($params) {
		ob_start();
		echo "<h4>Debug</h4>";
		$puo = $params['pubObject'];
		//echo "<pre>", print_r($puo, 1), "</pre>";
		echo "<ul>";
		echo "<li>pupId type: ". get_class($puo) . '</li>';
		foreach ($puo->_data as $attr => $val) {
			if (substr($attr, 0 , 6) == 'pub-id') {
				echo "<li>$attr: $val</li>";
			}
		}
		echo "</ul>";
		
		import('classes.issue.Issue');
		import('classes.article.Article');
		import('classes.article.ArticleGalley');
		import('classes.article.SuppFile');
		$testIssue = new Issue();
		$testArticle = new Article();
		$testGalley = new ArticleGalley();
		$testSuppFile = new SuppFile();
		$test = array(
			'this' => $puo, 
			'issue' => $testIssue, 
			'article' => $testArticle, 
			'galley' => $testGalley, 
			'suppfile' => $testSuppFile
		);
	
		echo "<ul>";
		$journalDao =& DAORegistry::getDAO('JournalDAO');
		$journalResults = $journalDao->getJournals();
		foreach ($journalResults->records as $result) {	
			echo "<li><b>" . $result["path"] . ' (' . $result["journal_id"] . ")</b>";
			$pubIdPlugins =& PluginRegistry::loadCategory('pubIds', false, $result["journal_id"]);
			echo "<ul>";
			foreach ($pubIdPlugins as $pubIdPlugin) {
				echo "<li>" . $pubIdPlugin->getName() . ' -> ' . $pubIdPlugin->getPubIdFullName();
	
				echo "<ul>";
				foreach ($test as $tt =>  $t) {
					echo "<li>" . $tt . ': ' . ($pubIdPlugin->isEnabled($t, $result["journal_id"]) ? '<b>true</b>' : 'false') . '</li>';
				}
				echo "</ul>";
				echo '</li>';
			}
			echo "</ul>";
			echo "</li>";
		}
		return ob_get_clean();
	}

}

?>
