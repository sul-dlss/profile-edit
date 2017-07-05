<?php

/**
 * Reached via HTTP POST to /server/updateTemplateRefs
 * Requires a POST parameter 'template'
 * Adds 'template' to the list of template references on the server,
 * if the template is not already present in the list
*/

if(!$_SERVER['REQUEST_METHOD'] === 'POST'){
    die("Request is not post");
    return 405;
}

if (isset($_POST["reset"])) {
  if ($_POST["reset"] === 'TRUE')
  {

    $filename = '../../templateRefs/templateRefs';
    include 'profile.php';
    $profiledir = '../../profiles';
    $profiles = scandir($profiledir);
    $cleanList = [];
    foreach($profiles as $profile){
      if($profile != '.' && $profile != '..'){
        $pf = file_get_contents($profiledir . '/' . $profile);
        $js = json_decode($pf);
        $resourceTemplates = $js->Profile->resourceTemplates;
        foreach ($resourceTemplates as $rt){
          array_push($cleanList, $rt->id);
        }
      }
    }

    $newjson = implode("\n",$cleanList);
    file_put_contents($filename,$newjson,true);

    return 200;
  } else {
    $filename = '../../templateRefs/templateRefs';
    $list = file($filename);
    $cleanList = [];

    $newItem = $_POST["template"];

    foreach($list as $item) {
      $cleanItem = trim(preg_replace('/\s\s+/', '', $item));
      array_push($cleanList, $cleanItem);
      if(strcmp($cleanItem, $newItem) == 0) {
        return 200;
      }
    }

    array_push($cleanList, $newItem);

    file_put_contents($filename, print_r(implode("\n", $cleanList), true));

  }

}

?>
