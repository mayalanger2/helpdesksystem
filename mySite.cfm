<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>testColdfusion</title>
</head>
<body>
<cfquery name = "qGetUsers" dataSource = "helpdesk"> 
    SELECT user_username, user_first_name, user_last_name
	FROM USER
	WHERE user_username != 'Unknown'
	ORDER BY user_username ASC;
</cfquery>
<cfquery name = "qGetLocations" dataSource = "helpdesk"> 
    SELECT location_name, location_address
	FROM LOCATION
	ORDER BY location_name ASC;
</cfquery>
<cfquery name = "qGetModels" dataSource = "helpdesk"> 
    SELECT model_name
	FROM MODEL
	ORDER BY model_name ASC;
</cfquery>
<cfquery name = "qGetOS" dataSource = "helpdesk"> 
    SELECT os_name
	FROM OPERATINGSYSTEM
	ORDER BY os_name ASC;
</cfquery>
<cfquery name = "qGetFleets" dataSource = "helpdesk"> 
    SELECT fleet_name
	FROM FLEET
	ORDER BY fleet_name ASC;
</cfquery>
<cfquery name = "qGetFundings" dataSource = "helpdesk"> 
    SELECT funding_name
	FROM FUNDING
	ORDER BY funding_name ASC;
</cfquery>
<cfquery name = "qGetRoles" dataSource = "helpdesk"> 
    SELECT role_name
	FROM ROLE
	ORDER BY role_name ASC;
</cfquery>
<cfquery name = "qGetRequisitions" dataSource = "helpdesk"> 
    SELECT requisition_name
	FROM REQUISITION
	ORDER BY requisition_name DESC;
</cfquery>
<cfquery name = "qGetDevices" dataSource = "helpdesk"> 
    SELECT device_serial, device_asset, location_name, device_mac_address, model_name, os_name, fleet_name, funding_name, role_name, requisition_name, device_status, device_description, user_username, device_edrrp
	FROM DEVICE
	ORDER BY device_asset ASC;
</cfquery>
<cfquery name = "qGetTags" dataSource = "helpdesk"> 
    SELECT tag_name
	FROM TAG
	ORDER BY tag_name ASC;
</cfquery>
<cfquery name = "qGetTickets" dataSource = "helpdesk"> 
    SELECT ticket_num
	FROM TICKET
	ORDER BY ticket_num ASC;
</cfquery>

<!--isDefined evaluates a string value to determine whether the variable named in it exists.-->
<cfif (isDefined("form.addUserUsername") and form.addUserUsername NEQ "") AND (isDefined("form.addUserFirstName") and form.addUserFirstName NEQ "") AND (isDefined("form.addUserLastName") and form.addUserLastName NEQ "")>
  <cftry>
    <cfquery datasource="Helpdesk">
          INSERT INTO USER(user_username, user_first_name, user_last_name) VALUES ('#form.addUserUsername#','#form.addUserFirstName#', '#form.addUserLastName#');
    </cfquery>
    <cflocation url="#cgi.script_name#?success=y" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
</cfif>
<cfif (isDefined("form.addRequisitionName") and form.addRequisitionName NEQ "")>
  <cftry>
    <cfquery datasource="Helpdesk">
          INSERT INTO REQUISITION(requisition_name, user_username, requisition_date) VALUES ('#form.addRequisitionName#','#form.addRequisitionUser#', '#form.addRequisitionDate#');
    </cfquery>
    <cflocation url="#cgi.script_name#?success=y" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
</cfif>
<cfif (isDefined("form.addDeviceSerial") and form.addDeviceSerial NEQ "") AND (isDefined("form.addDeviceAsset") and form.addDeviceAsset NEQ "")>
  <cftry>
    <cfquery datasource="Helpdesk">
          INSERT INTO DEVICE(device_serial, device_asset, location_name, device_mac_address, model_name, os_name, fleet_name, funding_name, role_name, requisition_name, device_status, device_description, user_username, device_edrrp) VALUES ('#form.addDeviceSerial#','#form.addDeviceAsset#', '#form.addDeviceLocation#', '#form.addDeviceMAC#', '#form.addDeviceModel#', '#form.addDeviceOS#', '#form.addDeviceFleet#', '#form.addDeviceFunding#', '#form.addDeviceRole#', '#form.addDeviceRequisition#', '#form.addDeviceStatus#', '#form.addDeviceDescription#', null, '0');
    </cfquery>
    <cflocation url="#cgi.script_name#?success=y" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
  <cfelse>
  <cfoutput>FAIL</cfoutput>
</cfif>
<cfif (isDefined("form.addOwnsStatus") and form.addOwnsStatus NEQ "")>
  <cftry>
    <cfif isDefined("form.addOwnsEDRRP")>
      <cfset edrrpStatus = 1>
      <cfelse>
      <cfset edrrpStatus = 0>
    </cfif>
    <cfquery datasource="Helpdesk">
        UPDATE DEVICE
		SET device_status = '#form.addOwnsStatus#', user_username = '#form.addOwnsUser#', device_edrrp = '#edrrpStatus#'
		WHERE device_serial = '#form.addOwnsDevice#';
    </cfquery>
    <cflocation url="#cgi.script_name#?success=y" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
  <cfelse>
</cfif>
<cfif (isDefined("form.addPinTags") and form.addPinTags NEQ "")>
  <cftry>
    <cfloop list='#form.addPinTags#' index="tagName">
      <cfquery datasource="Helpdesk">
        INSERT INTO PIN(tag_name, device_serial)
		VALUES ( <cfqueryparam value="#tagName#"/>, '#form.addPinDevice#');
    	</cfquery>
    </cfloop>
    <cflocation url="#cgi.script_name#?success=y" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
  <cfelse>
</cfif>
<cfif (isDefined("form.addSubmitTicket") and form.addSubmitTicket NEQ "")>
  <cftry>
    <cfloop list='#form.addSubmitTicket#' index="ticketNum">
      <cfquery datasource="Helpdesk">
        INSERT INTO SUBMIT(ticket_num, device_serial)
		VALUES ( <cfqueryparam value="#ticketNum#"/>, '#form.addSubmitDevice#');
    	</cfquery>
    </cfloop>
    <cflocation url="#cgi.script_name#?success=y" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
  <cfelse>
</cfif>
<cfif isDefined("url.success") and url.success EQ "y">
  <div style="background-color:green;padding:10px;border-radius:5px;">
    <p style="color:white;">Good Job! You did it!</p>
  </div>
  <cfelseif isDefined("url.success") and url.success EQ "n">
  <div style="background-color:red;padding:10px;border-radius:5px;">
    <p style="color:white;">Bad Job! You didn't do it!</p>
  </div>
  <cfelse>
</cfif>
<cfif (isDefined("form.addTagName") and form.addTagName NEQ "")>
  <cftry>
    <cfquery datasource="Helpdesk">
          INSERT INTO TAG(tag_name, tag_description) VALUES ('#form.addTagName#','#form.addTagDescription#');
    </cfquery>
    <cflocation url="#cgi.script_name#?success=y" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
</cfif>
<cfif (isDefined("form.addTicketNum") and form.addTicketNum NEQ "")>
  <cftry>
    <cfquery datasource="Helpdesk">
          INSERT INTO TICKET(ticket_num) VALUES ('#form.addTicketNum#');
    </cfquery>
    <cflocation url="#cgi.script_name#?success=y" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
</cfif>
	  
	  
<cfif isDefined("url.success") and url.success EQ "y">
  <div style="background-color:green;padding:10px;border-radius:5px;">
    <p style="color:white;">Good Job! You did it!</p>
  </div>
  <cfelseif isDefined("url.success") and url.success EQ "n">
  <div style="background-color:red;padding:10px;border-radius:5px;">
    <p style="color:white;">Bad Job! You didn't do it!</p>
  </div>
  <cfelse>
</cfif>

<!--cgi.script_name = Virtual path to the script that is executing; used for self-referencing URLs.
it's the path to the script that's currently executing.  When users continue, the path to the new page becomes the
new value of cgi.script_name, which is in general different from that of the perevious page.  It's the interpreted pathname of the current CGI (relative to the document root)--> 
<!--ex. <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post">-->
<form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
  <input type="text" name = "addUserUsername" placeholder="username here" required>
  <input type="text" name = "addUserFirstName" placeholder="firstname here">
  <input type="text" name = "addUserLastName" placeholder="lastname here">
  <button type="submit"> ADD USER </button>
</form>
<form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
  <input type="number" name = "addRequisitionName" placeholder="name here" required>
  <select name = "addRequisitionUser">
    <cfloop query="qGetUsers">
      <option value="<cfoutput>#qGetUsers.user_username#</cfoutput>"><cfoutput>#qGetUsers.user_username# - #qGetUsers.user_first_name#, #qGetUsers.user_last_name#</cfoutput></option>
    </cfloop>
  </select>
  <input type="date" name = "addRequisitionDate" required>
  <button type="submit" name="submitAddRequisition"> ADD REQUISTION </button>
</form>
<br>
<form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
  <input type="text" name = "addDeviceSerial" placeholder="Serial Here" required>
  <input type="number" name = "addDeviceAsset" placeholder="Asset Here" required>
  <select name = "addDeviceLocation">
    <cfloop query="qGetLocations">
      <option value="<cfoutput>#qGetLocations.location_name#</cfoutput>"><cfoutput>#qGetLocations.location_name# - #qGetLocations.location_address#</cfoutput></option>
    </cfloop>
  </select>
  <input type="text" name = "addDeviceMAC" placeholder="MAC Here">
  <select name = "addDeviceModel">
    <cfloop query="qGetModels">
      <option value="<cfoutput>#qGetModels.model_name#</cfoutput>"><cfoutput>#qGetModels.model_name#</cfoutput></option>
    </cfloop>
  </select>
  <select name = "addDeviceOS">
    <cfloop query="qGetOS">
      <option value="<cfoutput>#qGetOS.os_name#</cfoutput>"><cfoutput>#qGetOS.os_name#</cfoutput></option>
    </cfloop>
  </select>
  <select name = "addDeviceFleet">
    <cfloop query="qGetFleets">
      <option value="<cfoutput>#qGetFleets.fleet_name#</cfoutput>"><cfoutput>#qGetFleets.fleet_name#</cfoutput></option>
    </cfloop>
  </select>
  <select name = "addDeviceFunding">
    <cfloop query="qGetFundings">
      <option value="<cfoutput>#qGetFundings.funding_name#</cfoutput>"><cfoutput>#qGetFundings.funding_name#</cfoutput></option>
    </cfloop>
  </select>
  <select name = "addDeviceRole">
    <cfloop query="qGetRoles">
      <option value="<cfoutput>#qGetRoles.role_name#</cfoutput>"><cfoutput>#qGetRoles.role_name#</cfoutput></option>
    </cfloop>
  </select>
  <select name = "addDeviceRequisition">
    <cfloop query="qGetRequisitions">
      <option value="<cfoutput>#qGetRequisitions.requisition_name#</cfoutput>"><cfoutput>#qGetRequisitions.requisition_name#</cfoutput></option>
    </cfloop>
  </select>
  <select name = "addDeviceStatus">
    <option value="checked in">checked in</option>
    <option value="checked out">checked out</option>
    <option value="deploying">deploying</option>
    <option value="sold">sold</option>
    <option value="surplused">surplused</option>
  </select>
  <textarea name = "addDeviceDescription"></textarea>
  <button type="submit" name="submitAddDevice"> ADD DEVICE </button>
</form>
<form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
  <select name = "addOwnsDevice">
    <cfloop query="qGetDevices">
      <option value="<cfoutput>#qGetDevices.device_serial#</cfoutput>"><cfoutput>#qGetDevices.device_asset# - #qGetDevices.device_serial#</cfoutput></option>
    </cfloop>
  </select>
  <select name = "addOwnsUser">
    <cfloop query="qGetUsers">
      <option value="<cfoutput>#qGetUsers.user_username#</cfoutput>"><cfoutput>#qGetUsers.user_username# - #qGetUsers.user_first_name#, #qGetUsers.user_last_name#</cfoutput></option>
    </cfloop>
  </select>
  <input type="checkbox" name = "addOwnsEDRRP" value="1">
  <select name = "addOwnsStatus">
    <option value="checked in">checked in</option>
    <option value="checked out">checked out</option>
    <option value="deploying">deploying</option>
    <option value="sold">sold</option>
    <option value="surplused">surplused</option>
  </select>
  <button type="submit" name="submitOwns"> CHECK OUT </button>
</form>
<form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
  <select name = "addPinDevice">
    <cfloop query="qGetDevices">
      <option value="<cfoutput>#qGetDevices.device_serial#</cfoutput>"><cfoutput>#qGetDevices.device_asset# - #qGetDevices.device_serial#</cfoutput></option>
    </cfloop>
  </select>
  <select name = "addPinTags" multiple>
    <cfloop query="qGetTags">
      <option value="<cfoutput>#qGetTags.tag_name#</cfoutput>"><cfoutput>#qGetTags.tag_name#</cfoutput></option>
    </cfloop>
  </select>
  <button type="submit" name="submitPin"> ADD TAGS </button>
</form>
<form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
  <select name = "addSubmitDevice">
    <cfloop query="qGetDevices">
      <option value="<cfoutput>#qGetDevices.device_serial#</cfoutput>"><cfoutput>#qGetDevices.device_asset# - #qGetDevices.device_serial#</cfoutput></option>
    </cfloop>
  </select>
  <select name = "addSubmitTickets" multiple>
    <cfloop query="qGetTickets">
      <option value="<cfoutput>#qGetTickets.ticket_num#</cfoutput>"><cfoutput>#qGetTickets.ticket_num#</cfoutput></option>
    </cfloop>
  </select>
  <button type="submit" name="submitSubmit"> ADD TICKETS </button>
</form>
<form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
  <input type="text" name = "addTagName" placeholder="tag here" required>
  <textarea name = "addTagDescription"></textarea>
  <button type="submit"> ADD TAG </button>
</form>
<form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
  <input type="number" name = "addTicketNum" placeholder="ticket here" required>
  <button type="submit"> ADD TICKET </button>
</form>
</body>
</html>
