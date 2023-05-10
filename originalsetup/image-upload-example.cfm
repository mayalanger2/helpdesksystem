<!DOCTYPE html>

<!--- THIS IS JUST A SWITCH TO TURN THE APP ON AND OFF --->
<cfset request.online = "y">

<!--- THIS IS ALLOWS A URL VARIABLE TO FORCE THE APP ON IF IT'S BEEN TURNED OFF --->
<cfif isDefined("url.online") and url.online EQ "y">
	<cfset request.online = "y">
</cfif>

<!--- HERE WE SEE IF THERE'S A FORM WITH A PHOTO ATTACHED --->
<cfif isDefined("form.profilePhoto") and form.profilePhoto NEQ "">

	<!--- WE NEED TO TELL THE APPLICATION WHERE TO SAVE THE IMAGE --->
	<cfset variables.serverRootDirectory = "/opt/jrun4/servers/mnt/ybpics/">

	<!--- WE USE THE JUST-CREATED VARIABLE ALONG WITH OTHER FORM DATA TO NAME FILE --->
	<!--- WE DON'T WANT TO LOSE ANYTHING IN THIS APP, SO 'MAKEUNIQUE' IS ON --->
	<cffile action = "upload" fileField = "profilePhoto" destination = "#variables.serverRootDirectory#/#form.school#/SeniorPhotos/#lcase(form.lname)#_#lcase(form.fname)#.jpg" accept = "image/jpg,image/jpeg,image/pjpeg" nameConflict = "makeUnique">
	
	<!--- WE HAVE A TEXT LOG OF EVERYTHING UPLOADED.  THIS CREATES THE ENTRY --->
	<cfset logMessage = "#lcase(form.lname)#_#lcase(form.fname)#.jpg, #form.school#, #cgi.remote_addr#, #dateformat(now(),'yyyy-mm-dd')# #timeformat(now(),'HH:mm:ss')#">
	
	<!--- THIS SAVES THE ENTRY TO THE LOG --->
	<cffile action="append" file="/websites/www.lps.org/apps/yearbookupload/uploadLog.txt" output="#logMessage#">
	
	<!--- IF ALL WENT WELL, WE RELOAD THIS PAGE WITH A URL VARIABLE INDICATING THE IMAGE WAS UPLOADED--->
	<cflocation url="index.html?uploaded=y" addtoken="no">

</cfif>

<html lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>LPS Yearbook Photo Uploader</title>
<link rel="stylesheet" href="css/reset.css" />
<link rel="stylesheet" href="css/text.css" />
<link rel="stylesheet" href="css/960.css" />
<link rel="stylesheet" href="css/formalize.css" />
<script src="httpS://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
<script src="js/jquery.formalize.js"></script>

<style type="text/css">
	/* forms.css */
label {font-weight:bold;}
fieldset {padding:1.4em;margin:0 0 1.5em 0;border:1px solid #ccc;}
legend {font-weight:bold;font-size:1.2em;}
input[type=text], input[type=password], input.text, input.title, textarea, select {background-color:#fff;border:1px solid #bbb;}
input[type=text]:focus, input[type=password]:focus, input.text:focus, input.title:focus, textarea:focus, select:focus {border-color:#666;}
input[type=text], input[type=password], input.text, input.title, textarea, select {margin:0.5em 0;}
input.text, input.title {width:300px;padding:5px;}
input.title {font-size:1.5em;}
textarea {width:390px;height:250px;padding:5px;}
input[type=checkbox], input[type=radio], input.checkbox, input.radio {position:relative;top:.25em;}
form.inline {line-height:3;}
form.inline p {margin-bottom:0;}
.error, .notice, .success {padding:.8em;margin-bottom:1em;border:2px solid #ddd;}
.error {background:#FBE3E4;color:#8a1f11;border-color:#FBC2C4;}
.notice {background:#FFF6BF;color:#514721;border-color:#FFD324;}
.success {background:#E6EFC2;color:#264409;border-color:#C6D880;}
.error a {color:#8a1f11;}
.notice a {color:#514721;}
.success a {color:#264409;}
</style>
</head>
<body>

<div class="container_12">
  
  <div class="grid_6 prefix_3 suffix_3" style="margin-top:2em;">
    
  	<h1>Yearbook Photo Uploader</h1>
  
  		<cfif request.online EQ "n">
  
  			<!--- HERE IS THE MESSAGE SHOWN IF THE APPLICATION IS OFF --->
 			<p style="font-size:2em;color:#900;">The LPS Yearbook Photo Uploader is temporarily offline while some improvements are made. We plan to be back online soon. Thank you for your patience.</p> 

			<cfelse>
  
		<!--- IF THE APPLICATION IS ON, THEY ARE PRESENTED THE UPLOAD FORM --->

		<!--- FIRST, IF THEY JUST UPLOADED SOMETHING THEY GET A MESSAGE SAYING IT WORKED --->
		<cfif isDefined("url.uploaded") and url.uploaded EQ "y">

			<p class="success">Your image was uploaded! Thank You!</p>

		</cfif>
  
  		<p style="font-weight:bold;color:#900;">Please complete ALL fields.</p>
  		<p>Select the yearbook photo from your computer and then submit. Your file will be uploaded and made available to the yearbook team at the student's school.</p>
        
      	<!--- SINCE WE ARE UPLOADING AN ATTACHMENT WE HAVE TO SET THE ENCYTYPE TO MULTIPART --->
      	<form method="post" action="<cfoutput>#cgi.script_name#</cfoutput>" enctype="multipart/form-data">

			<p style="margin-top:0;padding-top:0;">

				<fieldset><legend>Student Information</legend>
					<p class="quiet" style="font-style:italic;color:#666;">Client/Network information will be stored along with file.</p>
					<p><label for="fname">Student First Name</label><br>
						<input type="text" id="fname" name="fname" required>
					</p>

					<p><label for="fname">Student Last Name</label><br>
						<input type="text" id="lname" name="lname" required>
					</p>

					<p><label for="school">Student's Home School</label><br>
						<select id="school" name="school" required>
							<option value="" >SELECT A SCHOOL</option>
							<optgroup value="0" label="LPS High Schools">
								<option value="LES">East High School</option>
								<option value="LHS">Lincoln High School</option>
								<option value="LNE">Northeast High School</option>
								<option value="LNS">North Star High School</option>
								<option value="LSE">Southeast High School</option>
								<option value="LSW">Southwest High School</option>
							</optgroup>
						</select>
					</p>
				</fieldset>

				<fieldset><legend>Student Photo</legend>
					<p><label for="profilePhoto">Choose Your Photo</label><br>
						<span style="font-style:italic;color:#666;">Only JPG files are allowed</span><br>
						<input type="file" name="profilePhoto" size="20" required>
					</p>
				</fieldset>

				<p>
					<button type="submit" name="upload" id="upload" class="positive">Upload Your Photo</button>
				</p>
			</div>
		</form>

	</cfif>
	</p>
</div>
  
<div class="clear"></div>
</div>
<!-- end .container_12 -->

  <!-- end .grid_8.pull_8 -->
  <div class="clear"></div>
</div>
<!-- end .container_16 -->
</body>
</html>