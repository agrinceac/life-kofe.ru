<?php
namespace core\utils;
class Utils
{
	use \core\traits\RequestHandler;

	// return full current link with $data add
	public static function getFullLink($data = null)
	{
		$link = "http://".$this->getSERVER()['SERVER_NAME'].$this->getSERVER()['REQUEST_URI'];
		if (!isset($data)) return $link;
		if (!empty($this->getSERVER()['QUERY_STRING'])) $link .= '&'.$data;
		else $link .= '?'.$data;
		return $link;
	}

	static public function trimUcWords($value) {
		return str_replace(' ', '', ucwords($value));
	}

	public static function removeLinkQueryParts($remove_parts)
	{
		$parts = explode('&',$this->getSERVER()['QUERY_STRING']);
		$remove_parts = explode(',',$remove_parts);
		$parts_new = array_udiff($parts, $remove_parts,"\core\utils\Utils::compareFunc");
		$link = $this->getSERVER()['PHP_SELF'].'?';
		foreach ($parts_new as $parts) {
			if (!empty($parts)) $link .= $parts.'&';
		}
		$link = substr($link,0,-1);
		return $link;
	}

	private static function compareFunc($a, $b)
	{
		if (preg_match("/($b)=[^&]*/",$a)) return 0;
		return ($a > $b)? 1:-1;
	}

	public static function daysToUnix($data)
	{
		return $data * 86400 ;
	}

	public static function daysFromUnix($data)
	{
		return $data / 86400 ;
	}

	public static function isEmail($email)
	{
		return (!empty($email) && preg_match("/^[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]{2,4}$/i", $email)) ? true : false;
	}

	public static function translit($str)
	{
		$tr = array(
			"А"=>"A", "Б"=>"B", "В"=>"V", "Г"=>"G", "Д"=>"D", "Е"=>"E", "Ж"=>"J", "З"=>"Z",
			"И"=>"I", "Й"=>"Y", "К"=>"K", "Л"=>"L", "М"=>"M", "Н"=>"N",	"О"=>"O", "П"=>"P",
			"Р"=>"R", "С"=>"S", "Т"=>"T", "У"=>"U", "Ф"=>"F", "Х"=>"H", "Ц"=>"TS","Ч"=>"CH",
			"Ш"=>"SH","Щ"=>"SCH","Ъ"=>"","Ы"=>"YI","Ь"=>"","Э"=>"E",
			"Ю"=>"YU","Я"=>"YA",
			"а"=>"a", "б"=>"b", "в"=>"v", "г"=>"g", "д"=>"d", "е"=>"e", "ж"=>"j", "з"=>"z",
			"и"=>"i", "й"=>"y", "к"=>"k", "л"=>"l", "м"=>"m", "н"=>"n",	"о"=>"o", "п"=>"p",
			"р"=>"r", "с"=>"s", "т"=>"t", "у"=>"u", "ф"=>"f", "х"=>"h", "ц"=>"ts","ч"=>"ch",
			"ш"=>"sh","щ"=>"sch","ъ"=>"y","ы"=>"yi","ь"=>"","э"=>"e",
			"ю"=>"yu","я"=>"ya",
			" "=>"_", "/"=>"_/_", "%"=>"_prcnt_", "?"=>"_qstn_", "("=>"_", ")"=>"_", "'"=>"", "№"=>"_nr_", "–"=>"_"
		);
		return strtr($str,$tr);
	}

	public static function getDistinctFileSize($fileSize)
	{
		$arr = array ("b", "Kb", "Mb", "Gb", "Tb");
		$step=0;
		while ($fileSize>=1024){
			$fileSize/=1024;
			$step++;
		}
		return round ($fileSize, 2).' '.$arr[$step];
	}

	public static function declension($int, $expr){
		settype($int, "integer");
		$count = $int % 100;
		if ($count >= 5 && $count <= 20) {
			$result = $expr['2'];
		} else {
				$count = $count % 10;
				if ($count == 1) {
				  $result = $expr['0'];
				} elseif ($count >= 2 && $count <= 4) {
				  $result = $expr['1'];
				} else {
				  $result = $expr['2'];
				}
		}
		return $result;
	  }

	public function textSlice($smallerText, $biggerText){
		return substr($biggerText, sizeof($smallerText), sizeof($biggerText));
	}

	public static function ragp($url) { // remove all GET-parameters from URL
	  return preg_replace('/^([^?]+)(\?.*?)?(#.*)?$/', '$1$3', $url);
	}

	public static function sgp($url, $varname, $value) // substitute get parameter
	{
		$url = strpos($url, '?') ? $url : $url.'?';
		if (is_array($varname)) {
			foreach ($varname as $i => $n) {
			   $v = (is_array($value))
					 ? ( isset($value[$i]) ? $value[$i] : NULL )
					 : $value;
			   $url = sgp($url, $n, $v);
			}
			return $url;
		}

		preg_match('/^([^?]+)(\?.*?)?(#.*)?$/', $url, $matches);
		$gp = (isset($matches[2])) ? $matches[2] : ''; // GET-parameters
		if (!$gp) return $url;

		$pattern = "/([?&])$varname=.*?(?=&|#|\z)/";
		if (preg_match($pattern, $gp)) {
			$substitution = ($value !== '') ? "\${1}$varname=" . preg_quote($value) : '';
			$newgp = preg_replace($pattern, $substitution, $gp); // new GET-parameters
			$newgp = preg_replace('/^&/', '?', $newgp);
		}
		else    {
			$s = ($gp) ? '&' : '?';
			$newgp = $gp.$s.$varname.'='.$value;
		}

		$anchor = (isset($matches[3])) ? $matches[3] : '';
		$newurl = $matches[1].$newgp.$anchor;
		return $newurl;
	}

	public static function rgp($url, $param)	// remove get parameter
	{
		$url = preg_replace('/(&|\?)'.preg_quote($param).'=[^&]*$/', '', $url);
		$url = preg_replace('/(&|\?)'.preg_quote($param).'=[^&]*&/', '$1', $url);
		return $url;
	}

	public static function getCountableObjectPropertiesString($objects, $property)
	{
		if(is_array($objects)){
			if(empty($objects))
				return '';
		}
		if(is_object($objects)){
			if(!$objects->count())
				return '';
		}
		$string = '';
		foreach($objects as $object)
			$string .= $object->$property.',';
		return substr($string, 0, strlen($string)-1);
	}
}
?>