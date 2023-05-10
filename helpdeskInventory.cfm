<!doctype html>
<html>
<!-- InstanceBegin template="/Templates/helpdeskInventoryTemplate.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta charset="UTF-8">
<!-- InstanceBeginEditable name="doctitle" -->
<title>Help Desk Inventory</title>
<!-- InstanceEndEditable -->
<!-- InstanceBeginEditable name="head" -->
<!--IMPORTS-START--> 
<!--BOOTSTRAP-5-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!--BOOTSTRAP-TABLE-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.21.3/dist/bootstrap-table.min.css">
<!--END-OF-BOOTSTRAP-TABLE--> 
<!--TABLE-FILTER--> 
<script src="bootstrap-table/dist/extensions/filter-control/bootstrap-table-filter-control.css"></script> 
<script src="bootstrap-table/dist/extensions/filter-control/bootstrap-table-filter-control.min.css"></script> 
<!--END-OF-TABLE-FILTER--> 
<!--MULTISELECT-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.14.0-beta2/css/bootstrap-select.min.css">
<!--END-OF-MULTISELECT--> 
<!--MY-CSS-->
<link rel="stylesheet" href="helpdeskInventory.css">
<!--END-OF-MY-CSS--> 

<!--IMPORTS-END--> 

<!--SCRIPT-START--> 
<script>
	$(function() {
		$('#deviceTable').bootstrapTable()
	})
</script> 
<!--SCRIPT-END-->
<!-- InstanceEndEditable -->
</head>
<body>
<!----QUERY-LIST-START--->
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
    SELECT tag_name, tag_description
	FROM TAG
	ORDER BY tag_name ASC;
</cfquery>
<cfquery name = "qGetTickets" dataSource = "helpdesk"> 
    SELECT ticket_num
	FROM TICKET
	ORDER BY ticket_num ASC;
</cfquery>
<!---QUERY-LIST-END---> 
<!--MAIN-START--------------------------------------------------------------------------------->

<div class="container-fluid" id="mainContainer">
<!--START-OF-CONTAINER-->
<div class="row" id="mainRow">
<!--START-OF-ROW-DIV-->
<nav class="navbar"> <!--START-OF-NAVBAR-->
  <div class="container-fluid"> <a class="navbar-brand" href="#"> <img src="lpsLogoWhite.png" alt="" width="50px" height="50px"> </a>
    <li class="nav-item"> <a class="nav-link" data-bs-toggle="modal" data-bs-target="#addLocationModal">
      <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-building-fill" viewBox="0 0 16 16">
        <path d="M3 0a1 1 0 0 0-1 1v14a1 1 0 0 0 1 1h3v-3.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5V16h3a1 1 0 0 0 1-1V1a1 1 0 0 0-1-1H3Zm1 2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm3.5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5ZM4 5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1ZM7.5 5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5Zm2.5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1ZM4.5 8h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5Zm2.5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm3.5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5Z"/>
      </svg>
      Locations</a></li>
    <li class="nav-item"> <a class="nav-link" data-bs-toggle="modal" data-bs-target="#addFleetModal">
      <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-collection-fill" viewBox="0 0 16 16">
        <path d="M0 13a1.5 1.5 0 0 0 1.5 1.5h13A1.5 1.5 0 0 0 16 13V6a1.5 1.5 0 0 0-1.5-1.5h-13A1.5 1.5 0 0 0 0 6v7zM2 3a.5.5 0 0 0 .5.5h11a.5.5 0 0 0 0-1h-11A.5.5 0 0 0 2 3zm2-2a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 0-1h-7A.5.5 0 0 0 4 1z"/>
      </svg>
      Fleets</a></li>
    <li class="nav-item"> <a class="nav-link" data-bs-toggle="modal" data-bs-target="#addRoleModal">
      <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-people-fill" viewBox="0 0 16 16">
        <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7Zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216ZM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"/>
      </svg>
      Roles</a></li>
    <li class="nav-item"> <a class="nav-link" data-bs-toggle="modal" data-bs-target="#addFundingModal">
      <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-currency-exchange" viewBox="0 0 16 16">
        <path d="M0 5a5.002 5.002 0 0 0 4.027 4.905 6.46 6.46 0 0 1 .544-2.073C3.695 7.536 3.132 6.864 3 5.91h-.5v-.426h.466V5.05c0-.046 0-.093.004-.135H2.5v-.427h.511C3.236 3.24 4.213 2.5 5.681 2.5c.316 0 .59.031.819.085v.733a3.46 3.46 0 0 0-.815-.082c-.919 0-1.538.466-1.734 1.252h1.917v.427h-1.98c-.003.046-.003.097-.003.147v.422h1.983v.427H3.93c.118.602.468 1.03 1.005 1.229a6.5 6.5 0 0 1 4.97-3.113A5.002 5.002 0 0 0 0 5zm16 5.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0zm-7.75 1.322c.069.835.746 1.485 1.964 1.562V14h.54v-.62c1.259-.086 1.996-.74 1.996-1.69 0-.865-.563-1.31-1.57-1.54l-.426-.1V8.374c.54.06.884.347.966.745h.948c-.07-.804-.779-1.433-1.914-1.502V7h-.54v.629c-1.076.103-1.808.732-1.808 1.622 0 .787.544 1.288 1.45 1.493l.358.085v1.78c-.554-.08-.92-.376-1.003-.787H8.25zm1.96-1.895c-.532-.12-.82-.364-.82-.732 0-.41.311-.719.824-.809v1.54h-.005zm.622 1.044c.645.145.943.38.943.796 0 .474-.37.8-1.02.86v-1.674l.077.018z"/>
      </svg>
      Funding</a></li>
  </div>
</nav>
<!--END-OF-NAVBAR-->
<div class="col leftCol"> <!--START-OF-LEFT-COL-->
  <div class="leftColHeader card-text-center"> <!--START-OF-LEFT-COL-HEADER-->
    
    <div class="card-header"> <!--START-OF-CARD-HEADER--> 
      <!-- InstanceBeginEditable name="cardHeaderEdit" -->
      <ul class="nav nav-pills card-header-pills navPillsColor">
        <li class="nav-item">
          <button class="nav-link active" id="device-tab" data-bs-toggle="tab" type="button" role="tab" data-bs-target="#deviceTab">Add Device</button>
        </li>
        <li class="nav-item">
          <button class="nav-link" id="user-tab" data-bs-toggle="tab" type="button" role="tab" data-bs-target="#userTab">Add User</button>
        </li>
        <li class="nav-item">
          <button class="nav-link" id="owns-tab" data-bs-toggle="tab" type="button" role="tab" data-bs-target="#ownsTab">Check Out Device</button>
        </li>
        <li class="nav-item">
          <button class="nav-link" id="ticket-tab" data-bs-toggle="tab" type="button" role="tab" data-bs-target="#ticketTab">Submit Tickets</button>
        </li>
        <li class="nav-item">
          <button class="nav-link" id="tag-tab" data-bs-toggle="tab" type="button" role="tab" data-bs-target="#tagTab">Pin Tags</button>
        </li>
        <li class="nav-item">
          <button class="nav-link" id="requistion-tab" data-bs-toggle="tab" type="button" role="tab" data-bs-target="#requisitionTab">Add Requisition</button>
        </li>
      </ul>
      <!-- InstanceEndEditable --> </div>
    <!--END-OF-CARD-HEADER-->
    
    <div class="card-body tab-content"> <!--START-OF-CARD-BODY--> 
      <!-- InstanceBeginEditable name="cardBodyEdit" -->
      <cfif (isDefined("form.addDeviceSerial") and form.addDeviceSerial NEQ "") AND (isDefined("form.addDeviceAsset") and form.addDeviceAsset NEQ "")>
        <cftry>
          <cfquery datasource="Helpdesk">
				  INSERT INTO DEVICE(device_serial, device_asset, location_name, device_mac_address, model_name, os_name, fleet_name, funding_name, role_name, requisition_name, device_status, device_description, user_username, device_edrrp) VALUES ('#form.addDeviceSerial#','#form.addDeviceAsset#', '#form.addDeviceLocation#', '#form.addDeviceMAC#', '#form.addDeviceModel#', '#form.addDeviceOS#', '#form.addDeviceFleet#', '#form.addDeviceFunding#', '#form.addDeviceRole#', '#form.addDeviceRequisition#', '#form.addDeviceStatus#', '#form.addDeviceDescription#', null, '0');
				</cfquery>
          <cflocation url="#cgi.script_name#?" addtoken="no">
          <cfcatch type="all">
            <cflocation url="#cgi.script_name#?success=n" addtoken="no">
          </cfcatch>
        </cftry>
        <cfelse>
      </cfif>
      <div id="deviceTab" class="tab-pane fade show active" role="tabpanel"> <!--START-OF-DEVICE-TAB-->
        <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
          <!--START-OF-FORM-->
          <h3>Device Information</h3>
          <div class="row">
            <div class="col">
              <label for="addDeviceSerial" class="form-label">Serial Number*</label>
              <input type="text" id="addDeviceSerial" name="addDeviceSerial" class="form-control" placeholder="54KJJH2" required>
            </div>
            <div class="col">
              <label for="addDeviceAsset" class="form-label">Asset Tag*</label>
              <input type="text" id="addDeviceAsset" name="addDeviceAsset"  class="form-control" placeholder="336340" required>
            </div>
          </div>
          <div class="row">
            <div class="col">
              <label for="addDeviceLocation" class="form-label">Location*</label>
              <select class="form-select"  name="addDeviceLocation" id="addDeviceLocation">
                <cfloop query="qGetLocations">
                  <option value="<cfoutput>#qGetLocations.location_name#</cfoutput>"><cfoutput>#qGetLocations.location_name# - #qGetLocations.location_address#</cfoutput></option>
                </cfloop>
              </select>
            </div>
            <div class="col">
              <label for="addDeviceMac" class="form-label">MAC Address</label>
              <input type="text" id="addDeviceMac" name="addDeviceMAC" class="form-control" placeholder="50:9A:4C:44:55:7A">
            </div>
          </div>
          <div class="row">
            <div class="col">
              <label for="addDeviceModel" class="form-label">Model*</label>
              <select class="form-select" name ="addDeviceModel" id="addDeviceModel">
                <cfloop query="qGetModels">
                  <option value="<cfoutput>#qGetModels.model_name#</cfoutput>"><cfoutput>#qGetModels.model_name#</cfoutput></option>
                </cfloop>
              </select>
            </div>
            <div class="col">
              <label for="addDeviceOS" class="form-label">Operating System*</label>
              <select class="form-select" name="addDeviceOS" id="addDeviceOS">
                <cfloop query="qGetOS">
                  <option value="<cfoutput>#qGetOS.os_name#</cfoutput>"><cfoutput>#qGetOS.os_name#</cfoutput></option>
                </cfloop>
              </select>
            </div>
          </div>
          <div class="row">
            <div class="col">
              <label for="addDeviceFleet" class="form-label">Fleet Name</label>
              <select class="form-select" name="addDeviceFleet" id="addDeviceFleet">
                <cfloop query="qGetFleets">
                  <option value="<cfoutput>#qGetFleets.fleet_name#</cfoutput>"><cfoutput>#qGetFleets.fleet_name#</cfoutput></option>
                </cfloop>
              </select>
            </div>
            <div class="col">
              <label for="addDeviceFunding" class="form-label">Funding Source</label>
              <select class="form-select" name="addDeviceFunding" id="addDeviceFunding">
                <cfloop query="qGetFundings">
                  <option value="<cfoutput>#qGetFundings.funding_name#</cfoutput>"><cfoutput>#qGetFundings.funding_name#</cfoutput></option>
                </cfloop>
              </select>
            </div>
            <div class="col">
              <label for="addDeviceRole" class="form-label">Role</label>
              <select class="form-select" name="addDeviceRole" id="addDeviceRole">
                <cfloop query="qGetRoles">
                  <option value="<cfoutput>#qGetRoles.role_name#</cfoutput>"><cfoutput>#qGetRoles.role_name#</cfoutput></option>
                </cfloop>
              </select>
            </div>
          </div>
          <div class="row">
            <div class="col">
              <label for="addDeviceRequisition" class="form-label">Requisition</label>
              <select class="form-select" name="addDeviceRequisition" id="addDeviceRequisition">
                <cfloop query="qGetRequisitions">
                  <option value="<cfoutput>#qGetRequisitions.requisition_name#</cfoutput>"><cfoutput>#qGetRequisitions.requisition_name#</cfoutput></option>
                </cfloop>
              </select>
            </div>
            <div class="col">
              <label for="addDeviceStatus" class="form-label">Device Status*</label>
              <select class="form-select" name="addDeviceStatus" id="addDeviceStatus">
                <option selected value="checked in">Checked In</option>
                <option value="checked out">Checked Out</option>
                <option value="deploying">Deploying</option>
                <option value="surplused">Surplused</option>
                <option value="sold">Sold</option>
              </select>
            </div>
            <div class="col">
              <label for="addDeviceDescription" class="form-label">Device Description</label>
              <textarea class="form-control" name="addDeviceDescription" id="addDeviceDescription"></textarea>
            </div>
          </div>
          <div class="row">
            <button type="submit" name="submitAddDevice" class="btn btn-yes btn-form">-Add Device-</button>
          </div>
        </form>
        <!--END-OF-FORM--> 
      </div>
      <!--END-OF-DEVICE-TAB-->
      
      <cfif (isDefined("form.addUserUsername") and form.addUserUsername NEQ "") AND (isDefined("form.addUserFirstName") and form.addUserFirstName NEQ "") AND (isDefined("form.addUserLastName") and form.addUserLastName NEQ "")>
        <cftry>
          <cfquery datasource="Helpdesk">
					INSERT INTO USER(user_username, user_first_name, user_last_name) VALUES ('#form.addUserUsername#','#form.addUserFirstName#', '#form.addUserLastName#');
				</cfquery>
          <cflocation url="#cgi.script_name#" addtoken="no">
          <cfcatch type="all">
            <cflocation url="#cgi.script_name#?success=n" addtoken="no">
          </cfcatch>
        </cftry>
      </cfif>
      <div id="userTab" class="tab-pane fade" role="tabpanel"> <!--START-OF-USER-TAB-->
        <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
          <!---START-OF-USER-FORM--->
          <h3>User Information</h3>
          <div class="row">
            <div class="col">
              <label for="addUserUsername" class="form-label">LPS Username*</label>
              <input type="text" name="addUserUsername" id="addUserUsername" class="form-control" placeholder="jdoe5" required>
            </div>
          </div>
          <div class="row">
            <div class="col">
              <label for="addUserFirstName" class="form-label">First Name</label>
              <input type="text" name="addUserFirstName" id="addUserFirstName" class="form-control" placeholder="John">
            </div>
            <div class="col">
              <label for="addUserLastName" class="form-label">Last Name</label>
              <input type="text" name="addUserLastName" id="addUserLastName" class="form-control" placeholder="Doe">
            </div>
          </div>
          <div class="row">
            <button type="submit" name="submitAddUser" class="btn btn-yes btn-form">-Add User-</button>
          </div>
        </form>
        <!---END-OF-USER-FORM---> 
      </div>
      <!--END-OF-USER-TAB-->
      
      <cfif (isDefined("form.addOwnsUser") and form.addOwnsUser NEQ "")>
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
          <cflocation url="#cgi.script_name#" addtoken="no">
          <cfcatch type="all">
            <cflocation url="#cgi.script_name#?success=n" addtoken="no">
          </cfcatch>
        </cftry>
      </cfif>
      <div id="ownsTab" class="tab-pane fade" role="tabpanel"><!--START-OF-OWNS-TAB-->
        <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
          <!---START-OF-OWNS-FORM--->
          <h3>Device Ownership</h3>
          <div class="row">
            <div class="col-5">
              <label for="addOwnsUser" class="form-label">LPS Username*</label>
              <select class="form-select" name="addOwnsUser" id="addOwnsUser">
                <cfloop query="qGetUsers">
                  <option value="<cfoutput>#qGetUsers.user_username#</cfoutput>"><cfoutput>#qGetUsers.user_username# - #qGetUsers.user_first_name#, #qGetUsers.user_last_name#</cfoutput></option>
                </cfloop>
              </select>
            </div>
            <div class="col-6">
              <label for="addOwnsDevice" class="form-label">Associated Device*</label>
              <select class="form-select" name="addOwnsDevice" id="addOwnsDevice">
                <cfloop query="qGetDevices">
                  <option value="<cfoutput>#qGetDevices.device_serial#</cfoutput>"><cfoutput>#qGetDevices.device_asset# - #qGetDevices.device_serial#</cfoutput></option>
                </cfloop>
              </select>
            </div>
            <div class="col-1">
              <div style="display: flex; align-items: center; justify-content: center; padding: 0px;">
                <label class="form-label" for="addOwnsEDRRP">EDRRP*</label>
              </div>
              <div class="form-check"> <span style="display: flex; align-items: center; justify-content: center; padding: 0px;">
                <input class="form-check-input customCheckbox" type="checkbox" value="1" name="addOwnsEDRRP" id="addOwnsEDRRP">
                </span> </div>
            </div>
          </div>
          <div class="row">
            <div class="col">
              <label for="addOwnsStatus" class="form-label">Device Status*</label>
              <select class="form-select" name="addOwnsStatus" id="addOwnsStatus">
                <option selected value="checked in">Checked In</option>
                <option value="checked out">Checked Out</option>
                <option value="deploying">Deploying</option>
                <option value="surplused">Surplused</option>
                <option value="sold">Sold</option>
              </select>
            </div>
          </div>
          <div class="row">
            <button type="submit" class="btn btn-yes btn-form" name="submitOwns">-Check Out Device-</button>
          </div>
        </form>
        <!---END-OF-OWNS-FORM---> 
      </div>
      <!--END-OF-OWNS-TAB-->
      
      <cfif (isDefined("form.addSubmitTicket") and form.addSubmitTicket NEQ "")>
        <cftry>
          <cfloop list='#form.addSubmitTicket#' index="ticketNum">
            <cfquery datasource="Helpdesk">
					INSERT INTO SUBMIT(ticket_num, device_serial)
					VALUES ( <cfqueryparam value="#ticketNum#"/>, '#form.addSubmitDevice#');
				  </cfquery>
          </cfloop>
          <cflocation url="#cgi.script_name#" addtoken="no">
          <cfcatch type="all">
            <cflocation url="#cgi.script_name#?success=n" addtoken="no">
          </cfcatch>
        </cftry>
        <cfelse>
      </cfif>
      <div id="ticketTab" class="tab-pane fade" role="tabpanel"><!--START-OF-TICKET-TAB-->
        <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
          <!--START-OF-SUBMIT-FORM-->
          <h3>Submit Tickets</h3>
          <div class="row">
            <div class="col">
              <label for="addSubmitDevice" class="form-label">Associated Device*</label>
              <select class="form-select" name="addSubmitDevice" id="addSubmitDevice">
                <cfloop query="qGetDevices">
                  <option value="<cfoutput>#qGetDevices.device_serial#</cfoutput>"><cfoutput>#qGetDevices.device_asset# - #qGetDevices.device_serial#</cfoutput></option>
                </cfloop>
              </select>
            </div>
            <div class="col">
              <div class="row">
                <label for="addSubmitTicket" class="form-label">Ticket Name(s)*</label>
                <div class="col-10">
                  <select class="selectpicker" name="addSubmitTicket" data-style="multiselectColor" multiple id="addSubmitTicket" data-live-search="true">
                    <cfloop query="qGetTickets">
                      <option value="<cfoutput>#qGetTickets.ticket_num#</cfoutput>"><cfoutput>#qGetTickets.ticket_num#</cfoutput></option>
                    </cfloop>
                  </select>
                </div>
                <div class="col-2" style="display: flex; align-items: center; justify-content: center; padding: 0px;">
                  <button type="button" class="btn btn-sm btn-yes" data-bs-toggle="modal" data-bs-target="#addTicketModal" style="margin: 0 !important;"> <span style="display: inline-flex; gap: 5px; align-items: center;"> <span style="display: flex; align-items: center; justify-content: center; padding: 5px;">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ticket-perforated-fill" viewBox="0 0 15 15">
                    <path d="M0 4.5A1.5 1.5 0 0 1 1.5 3h13A1.5 1.5 0 0 1 16 4.5V6a.5.5 0 0 1-.5.5 1.5 1.5 0 0 0 0 3 .5.5 0 0 1 .5.5v1.5a1.5 1.5 0 0 1-1.5 1.5h-13A1.5 1.5 0 0 1 0 11.5V10a.5.5 0 0 1 .5-.5 1.5 1.5 0 1 0 0-3A.5.5 0 0 1 0 6V4.5Zm4-1v1h1v-1H4Zm1 3v-1H4v1h1Zm7 0v-1h-1v1h1Zm-1-2h1v-1h-1v1Zm-6 3H4v1h1v-1Zm7 1v-1h-1v1h1Zm-7 1H4v1h1v-1Zm7 1v-1h-1v1h1Zm-8 1v1h1v-1H4Zm7 1h1v-1h-1v1Z"/>
                  </svg>
                  </span> <span>+</span></span> </button>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <button type="submit" name="submitSubmit" class="btn btn-yes btn-form">-Submit Tickets-</button>
          </div>
        </form>
        <!--END-OF-SUBMIT-FORM--> 
      </div>
      <!--END-OF-TICKET-TAB-->
      
      <cfif (isDefined("form.addPinTag") and form.addPinTag NEQ "")>
        <cftry>
          <cfloop list='#form.addPinTag#' index="tagName">
            <cfquery datasource="Helpdesk">
					INSERT INTO PIN(tag_name, device_serial)
					VALUES ( <cfqueryparam value="#tagName#"/>, '#form.addPinDevice#');
				  </cfquery>
          </cfloop>
          <cflocation url="#cgi.script_name#" addtoken="no">
          <cfcatch type="all">
            <cflocation url="#cgi.script_name#?success=n" addtoken="no">
          </cfcatch>
        </cftry>
        <cfelse>
      </cfif>
      <div id="tagTab" class="tab-pane fade" role="tabpanel"> 
        <!--START-OF-TAG-TAB-->
        <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
          <!--START-OF-TAG-FORM-->
          <h3>Tag Devices</h3>
          <div class="row">
            <div class="col">
              <label for="addPinDevice" class="form-label">Associated Device*</label>
              <select class="form-select" name = "addPinDevice" id="addPinDevice">
                <cfloop query="qGetDevices">
                  <option value="<cfoutput>#qGetDevices.device_serial#</cfoutput>"><cfoutput>#qGetDevices.device_asset# - #qGetDevices.device_serial#</cfoutput></option>
                </cfloop>
              </select>
            </div>
            <div class="col">
              <div class="row">
                <label for="addPinTag" class="form-label">Tag Name(s)*</label>
                <div class="col-10">
                  <select class="selectpicker" name="addPinTag" data-style="multiselectColor" multiple id="addPinTag" data-live-search="true">
                    <cfloop query="qGetTags">
                      <option value="<cfoutput>#qGetTags.tag_name#</cfoutput>"><cfoutput>#qGetTags.tag_name#</cfoutput></option>
                    </cfloop>
                  </select>
                </div>
                <div class="col-2" style="display: flex; align-items: center; justify-content: center; padding: 0px;">
                  <button type="button" class="btn btn-sm btn-yes" data-bs-toggle="modal" data-bs-target="#addTagModal" style="margin: 0 !important;"> <span style="display: inline-flex; gap: 5px; align-items: center;"> <span style="display: flex; align-items: center; justify-content: center; padding: 5px;">
                  <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-tag-fill" viewBox="0 0 16 16">
                    <path d="M2 1a1 1 0 0 0-1 1v4.586a1 1 0 0 0 .293.707l7 7a1 1 0 0 0 1.414 0l4.586-4.586a1 1 0 0 0 0-1.414l-7-7A1 1 0 0 0 6.586 1H2zm4 3.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
                  </svg>
                  </span> <span>+</span></span> </button>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <button type="submit" name="submitPin" class="btn btn-yes btn-form">-Pin Tags-</button>
          </div>
        </form>
        <!--END-OF-TAG-FORM--> 
      </div>
      <!--END-OF-TAG-TAB-->
      
      <cfif (isDefined("form.addRequisitionName") and form.addRequisitionName NEQ "")>
        <cftry>
          <cfquery datasource="Helpdesk">
				  INSERT INTO REQUISITION(requisition_name, user_username, requisition_date) VALUES ('#form.addRequisitionName#','#form.addRequisitionUser#', '#form.addRequisitionDate#');
				</cfquery>
          <cflocation url="#cgi.script_name#" addtoken="no">
          <cfcatch type="all">
            <cflocation url="#cgi.script_name#?success=n" addtoken="no">
          </cfcatch>
        </cftry>
      </cfif>
      <div id="requisitionTab" class="tab-pane fade" role="tabpanel"> <!--START-OF-REQUISITION-TAB-->
        <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
          <!--START-OF-REQUISITION-FORM-->
          <h3>Requisition Information</h3>
          <div class="row">
            <div class="col">
              <label for="addRequisitionName" class="form-label">Requisition Number*</label>
              <input type="number" name="addRequisitionName" id="addRequisitionName" class="form-control" placeholder="40529" required>
            </div>
          </div>
          <div class="row">
            <div class="col">
              <label for="addRequisitionUser" class="form-label">Requestor/User*</label>
              <select class="form-select" name="addRequisitionUser" id="addRequisitionUser">
                <cfloop query="qGetUsers">
                  <option value="<cfoutput>#qGetUsers.user_username#</cfoutput>"><cfoutput>#qGetUsers.user_username# - #qGetUsers.user_first_name#, #qGetUsers.user_last_name#</cfoutput></option>
                </cfloop>
              </select>
            </div>
            <div class="col">
              <label for="addRequisitionDate" class="form-label">Requisition Date*</label>
              <input type="date" class="form-control" name="addRequisitionDate" id="addRequisitionDate" required/>
            </div>
          </div>
          <div class="row">
            <button type="submit" name="submitAddRequisition" class="btn btn-yes btn-form">-Add Requisition-</button>
          </div>
        </form>
        <!--END-OF-REQUISITION-FORM--> 
      </div>
      <!--END-OF-REQUISITION-TAB--> 
      
      <!-- InstanceEndEditable --> </div>
    <!--END-OF-CARD-BODY--> 
    
  </div>
  <!--END-OF-LEFT-COL-HEADER-->
  
  <div id="deviceToolbar"> <!--START-OF-TOOLBAR--> 
  </div>
  <!--END-OF-TOOLBAR--> 
  
  <!--START-OF-TABLE-->
  <table data-toggle="table" id="deviceTable" data-toolbar="#deviceToolbar" data-search="true" data-show-refresh="true" data-click-to-select="true" data-id-field="id" data-show-columns="true" data-filter-control="true" data-show-search-clear-button="true" data-filter-control-multiple-search="true" data-filter-control-multiple-search-delimiter="|" data-pagination="true" data-page-size="5">
    <thead>
      <!--TABLE-HEAD-->
      <tr>
        <th data-align="center">#</th>
        <th data-align="center">Actions</th>
        <!-- InstanceBeginEditable name="tableHeadEdit" -->
        <th data-filter-control="input">Serial</th>
        <th data-filter-control="input">Asset</th>
        <th data-field="tableDeviceUser" data-filter-control="input">User</th>
        <th data-field="tableDeviceStatus" data-filter-control="select" data-align="center">Status</th>
        <th data-field="tableDeviceModel" data-filter-control="select">Model</th>
        <th data-field="tableDeviceLocation" data-filter-control="select">Location</th>
        <th data-field="tableDeviceTags" data-filter-control="input" data-title-tooltip="Use | to seperate multiple tags ex. ashley'sdesk|maya'sdesk">Tags</th>
        <!-- InstanceEndEditable --> </tr>
    </thead>
    <!--END-OF-TABLE-HEAD-->
    
    <tbody>
      <!--TABLE-BODY--> 
    <!-- InstanceBeginEditable name="tableBodyEdit" -->
    <cfset deviceNum = 1>
    <cfloop query=#qGetDevices#>
      <tr>
        <td><cfoutput>#deviceNum#</cfoutput></td>
        <td><div class="d-grid gap-2">
            <button type="button" onclick="location.href='<cfoutput>#cgi.script_name#</cfoutput>?device=<cfoutput>#qGetDevices.device_serial#</cfoutput>'" class="btn btn-sm btn-neutral" style="margin: 0;">Edit</button>
            <!---<button type="button" class="btn btn-sm btn-no" data-bs-toggle="modal" data-bs-target="#deleteModal" style="margin: 0;">Delete</button>---> 
          </div></td>
        <td><cfoutput>#qGetDevices.device_serial#</cfoutput></td>
        <td><cfoutput>#qGetDevices.device_asset#</cfoutput></td>
        <td><cfoutput>#qGetDevices.user_username#</cfoutput></td>
        <td><cfoutput>#qGetDevices.device_status#</cfoutput></td>
        <td><cfoutput>#qGetDevices.model_name#</cfoutput></td>
        <td><cfoutput>#qGetDevices.location_name#</cfoutput></td>
        <td><cfset deviceCurrent = #qGetDevices.device_serial#>
          <cfquery name = "qGetPins" dataSource = "helpdesk">
					SELECT PIN.tag_name, device_serial, tag_color
					FROM PIN INNER JOIN TAG ON PIN.tag_name=TAG.tag_name
					WHERE device_serial = '#deviceCurrent#'
					ORDER BY PIN.tag_name ASC;
				</cfquery>
          <cfloop query=#qGetPins#>
            <span class="badge rounded-pill deviceTag" style="background-color: #<cfoutput>#qGetPins.tag_color#</cfoutput> !important;" name="deviceTag"><cfoutput>#qGetPins.tag_name#</cfoutput></span>
          </cfloop></td>
      </tr>
      <cfset deviceNum = deviceNum + 1>
    </cfloop>
    <!-- InstanceEndEditable -->
    </tbody>
    
    
    <!--END-OF-TABLE-BODY-->
    
  </table>
  <!--END-OF-TABLE--> 
</div>
<!--END-OF-LEFT-COL--> 

<!--<div class="col rightCol d-none d-xl-block d-xxl-block">--><!--START-OF-RIGHT-COL-->
<div class="col rightCol d-xl-block d-xxl-block">
<!-- InstanceBeginEditable name="rightColEdit" -->
<cfquery name = "qGetFirstDevice" dataSource = "helpdesk"> 
		  SELECT device_serial, device_asset, location_name, device_mac_address, model_name, os_name, fleet_name, funding_name, role_name, requisition_name, device_status, device_description, user_username, device_edrrp
		  FROM DEVICE
		  LIMIT 1;
		</cfquery>
<cfif isDefined("url.device") and url.device NEQ "">
  <cfset url.device = "#url.device#">
  <cfset deviceCurrent = '#url.device#'>
  <cfelse>
  <cfset deviceCurrent = '#qGetFirstDevice.device_serial#'>
</cfif>
<div id="deviceDetails"> <!--START-OF-DEVICE-DETAILS--> 
  <!--<img src="LPS Logo - just the L.png" class="card-img-top" alt="...">-->
  <div class="card card-body" id="deviceDetailsCard"> <span style="display: inline-flex; gap: 5px; align-items: center;"> <span style="display: flex; align-items: center; justify-content: center; background-color: #6c757d; padding: 5px; border-radius: 5px; box-shadow: rgba(6, 24, 44, 0.4) 0px 0px 0px 2px, rgba(6, 24, 44, 0.65) 0px 4px 6px -1px, rgba(255, 255, 255, 0.08) 0px 1px 0px inset;"> <!--START-OF-CARD-BODY-->
    
    <cfquery name = "qGetEditDevice" dataSource = "helpdesk"> 
			  SELECT device_serial, device_asset, DEVICE.location_name, device_mac_address, model_name, os_name, fleet_name, funding_name, role_name, requisition_name, device_status, device_description, user_username, device_edrrp, device_tma
			  FROM DEVICE
			  WHERE device_serial = '#deviceCurrent#'
			  ORDER BY device_asset ASC;
		  </cfquery>
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#f5f5f4" class="bi bi-laptop" viewBox="0 0 16 16">
      <cfif #qGetEditDevice.os_name# eq "iOS">
        <path d="M12 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h8zM4 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H4z"/>
        <path d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
        <cfelseif #qGetEditDevice.os_name# eq "tvOS">
        <path d="M2.5 13.5A.5.5 0 0 1 3 13h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zM13.991 3l.024.001a1.46 1.46 0 0 1 .538.143.757.757 0 0 1 .302.254c.067.1.145.277.145.602v5.991l-.001.024a1.464 1.464 0 0 1-.143.538.758.758 0 0 1-.254.302c-.1.067-.277.145-.602.145H2.009l-.024-.001a1.464 1.464 0 0 1-.538-.143.758.758 0 0 1-.302-.254C1.078 10.502 1 10.325 1 10V4.009l.001-.024a1.46 1.46 0 0 1 .143-.538.758.758 0 0 1 .254-.302C1.498 3.078 1.675 3 2 3h11.991zM14 2H2C0 2 0 4 0 4v6c0 2 2 2 2 2h12c2 0 2-2 2-2V4c0-2-2-2-2-2z"/>
        <cfelse>
        <path d="M13.5 3a.5.5 0 0 1 .5.5V11H2V3.5a.5.5 0 0 1 .5-.5h11zm-11-1A1.5 1.5 0 0 0 1 3.5V12h14V3.5A1.5 1.5 0 0 0 13.5 2h-11zM0 12.5h16a1.5 1.5 0 0 1-1.5 1.5h-13A1.5 1.5 0 0 1 0 12.5z"/>
      </cfif>
    </svg>
    </span> <span style="font-size: 24px; margin-left: 5px;">Edit Device</span> </span>
    <cfquery name = "qGetEditPins" dataSource = "helpdesk"> 
			  SELECT device_serial, tag_name
			  FROM PIN
			  WHERE device_serial = '#deviceCurrent#'
			  ORDER BY tag_name ASC;
		  </cfquery>
    <cfquery name = "qGetEditLocations" dataSource = "helpdesk"> 
			  SELECT location_name, location_address
			  FROM LOCATION
			  ORDER BY CASE WHEN location_name = '#qGetEditDevice.location_name#' THEN 0 ELSE 1 END, location_name ASC;
		  </cfquery>
    <cfquery name = "qGetEditUsers" dataSource = "helpdesk"> 
			  SELECT user_username, user_first_name, user_last_name
			  FROM USER
			  ORDER BY CASE WHEN user_username = '#qGetEditDevice.user_username#' THEN 0 ELSE 1 END, user_username ASC;
		  </cfquery>
    <cfquery name = "qGetEditModels" dataSource = "helpdesk"> 
			  SELECT model_name
			  FROM MODEL
			  ORDER BY CASE WHEN model_name = '#qGetEditDevice.model_name#' THEN 0 ELSE 1 END, model_name ASC;
		  </cfquery>
    <cfquery name = "qGetEditOS" dataSource = "helpdesk"> 
			  SELECT os_name
			  FROM OPERATINGSYSTEM
			  ORDER BY CASE WHEN os_name = '#qGetEditDevice.os_name#' THEN 0 ELSE 1 END, os_name ASC;
		  </cfquery>
    <cfquery name = "qGetEditFleets" dataSource = "helpdesk"> 
			  SELECT fleet_name
			  FROM FLEET
			  ORDER BY CASE WHEN fleet_name = '#qGetEditDevice.fleet_name#' THEN 0 ELSE 1 END, fleet_name ASC;
		  </cfquery>
    <cfquery name = "qGetEditFundings" dataSource = "helpdesk"> 
			  SELECT funding_name
			  FROM FUNDING
			  ORDER BY CASE WHEN funding_name = '#qGetEditDevice.funding_name#' THEN 0 ELSE 1 END, funding_name ASC;
		  </cfquery>
    <cfquery name = "qGetEditRoles" dataSource = "helpdesk"> 
			  SELECT role_name
			  FROM ROLE
			  ORDER BY CASE WHEN role_name = '#qGetEditDevice.role_name#' THEN 0 ELSE 1 END, role_name ASC;
		  </cfquery>
    <cfquery name = "qGetEditRequisitions" dataSource = "helpdesk"> 
			  SELECT requisition_name
			  FROM REQUISITION
			  ORDER BY CASE WHEN requisition_name = '#qGetEditDevice.requisition_name#' THEN 0 ELSE 1 END, requisition_name ASC;
		  </cfquery>
    <cfif (isDefined("form.editDeviceSerial") and form.editDeviceSerial NEQ "") AND (isDefined("form.editDeviceAsset") and form.editDeviceAsset NEQ "") AND (isDefined("form.submitEditDevice"))>
      <cftry>
        <cfset editDeviceEDRRP = 0>
        <cfif (isDefined("form.editDeviceEDRRP"))>
          <cfset editDeviceEDRRP = 1>
          <cfelse>
        </cfif>
        <cfquery datasource="Helpdesk">
						UPDATE DEVICE
						SET device_serial = '#form.editDeviceSerial#', device_asset='#form.editDeviceAsset#', location_name='#form.editDeviceLocation#', device_mac_address='#form.editDeviceMAC#', model_name='#form.editDeviceModel#', os_name='#form.editDeviceOS#', fleet_name='#form.editDeviceFleet#', funding_name='#editDeviceFunding#', role_name='#form.editDeviceRole#', requisition_name='#form.editDeviceRequisition#', device_status='#form.editDeviceStatus#', device_description='#form.editDeviceDescription#', user_username='#form.editDeviceUser#', device_edrrp='#editDeviceEDRRP#', device_tma='#form.editDeviceTMA#' WHERE device_serial='#form.editDeviceSerial#';
					</cfquery>
        <cfif (isDefined("form.editSubmitTickets") and form.editSubmitTickets NEQ "")>
          <cftry>
            <cfquery datasource="Helpdesk">
								DELETE FROM SUBMIT
								WHERE (device_serial='#form.editDeviceSerial#')
							</cfquery>
            <cfloop list='#form.editSubmitTickets#' index="ticketNum">
              <cfquery datasource="Helpdesk">
									INSERT INTO SUBMIT(ticket_num, device_serial)
									VALUES (<cfqueryparam value="#ticketNum#"/>, '#form.editDeviceSerial#');
								</cfquery>
            </cfloop>
            <cfcatch type="all">
            </cfcatch>
          </cftry>
          <cfelse>
        </cfif>
        <cfif (isDefined("form.editPinTags") and form.editPinTags NEQ "")>
          <cftry>
            <cfquery datasource="Helpdesk">
								DELETE FROM PIN
								WHERE (device_serial='#form.editDeviceSerial#');
							</cfquery>
            <cfloop list='#form.editPinTags#' index="tagName">
              <cfquery datasource="Helpdesk">
									INSERT INTO PIN(tag_name, device_serial)
									VALUES (<cfqueryparam value="#tagName#"/>, '#form.editDeviceSerial#');
								</cfquery>
            </cfloop>
            <cfcatch type="all">
            </cfcatch>
          </cftry>
          <cfelse>
        </cfif>
        <cflocation url="#cgi.script_name#?success=y" addtoken="no">
        <cfcatch type="all">
          <cflocation url="#cgi.script_name#?success=n" addtoken="no">
        </cfcatch>
      </cftry>
      <cfelse>
    </cfif>
    <cfif isDefined("form.deleteDevice")>
      <cftry>
        <cfquery datasource="Helpdesk">
						DELETE FROM DEVICE
				  WHERE device_serial='#form.editDeviceSerial#';
				   </cfquery>
        <cflocation url="#cgi.script_name#?success=y" addtoken="no">
        <cfcatch type="all">
          <cflocation url="#cgi.script_name#?success=n" addtoken="no">
        </cfcatch>
      </cftry>
      <cfelse>
    </cfif>
    <!--START-OF-EDIT-FORM-->
    <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
    <label for="editDeviceSerial" class="form-label">Serial Number*</label>
    <input type="text" name="editDeviceSerial" id="editDeviceSerial" class="form-control" value="<cfoutput>#qGetEditDevice.device_serial#</cfoutput>">
    <label for="editDeviceAsset" class="form-label">Asset Tag*</label>
    <input type="number" name="editDeviceAsset" id="editDeviceAsset" class="form-control" value="<cfoutput>#qGetEditDevice.device_asset#</cfoutput>">
    <label class="form-label" for="editDeviceLocation">Location*</label>
    <select class="form-select" name="editDeviceLocation" id="editDeviceLocation">
      <cfloop query="qGetEditLocations">
        <option value="<cfoutput>#qGetEditLocations.location_name#</cfoutput>"><cfoutput>#qGetEditLocations.location_name# - #qGetEditLocations.location_address#</cfoutput></option>
      </cfloop>
    </select>
    <div class="row">
      <div class="col">
        <label for="editDeviceUser" class="form-label">User</label>
        <select class="form-select" name="editDeviceUser" id="editDeviceUser">
          <cfloop query="qGetEditUsers">
            <option value="<cfoutput>#qGetEditUsers.user_username#</cfoutput>"><cfoutput>#qGetEditUsers.user_username# - #qGetEditUsers.user_first_name# #qGetEditUsers.user_last_name#</cfoutput></option>
          </cfloop>
        </select>
      </div>
      <cfscript>
					deviceStatus = "#qGetEditDevice.device_status#";
					statusArray=["Checked In","Checked Out","Deploying","Surplused","Sold"];
					ArrayDelete(statusArray, #deviceStatus#);
					ArrayInsertAt(statusArray, 1, #deviceStatus#);
				</cfscript>
      <div class="col">
        <label class="form-label" for="editDeviceStatus">Status*</label>
        <select class="form-select" name="editDeviceStatus" id="editDeviceStatus">
          <cfloop array="#statusArray#" index="i" item="status">
            <option value="<cfoutput>#status#</cfoutput>"><cfoutput><cfoutput>#status#</cfoutput></cfoutput></option>
          </cfloop>
        </select>
      </div>
    </div>
    <div class="row">
      <div class="col-9">
        <label class="form-label" for="editDeviceTMA">Current TMA*</label>
        <input type="text" name="editDeviceTMA" id="editDeviceTMA" class="form-control" value="<cfoutput>#qGetEditDevice.device_tma#</cfoutput>" placeholder="CS-15255">
      </div>
      <div class="col-3">
        <div style="display: flex; align-items: center; justify-content: center; padding: 0px;">
          <label class="form-label" for="editDeviceEDRRP">EDRRP*</label>
        </div>
        <cfif #qGetEditDevice.device_edrrp# eq 1>
          <cfset deviceCurrentEDRRP = "checked">
          <cfelse>
          <cfset deviceCurrentEDRRP = "">
        </cfif>
        <div class="form-check"> <span style="display: flex; align-items: center; justify-content: center; padding: 0px;">
          <input class="form-check-input customCheckbox" type="checkbox" name="editDeviceEDRRP" id="editDeviceEDRRP" value="1" <cfoutput>#deviceCurrentEDRRP#</cfoutput>>
          </span> </div>
      </div>
    </div>
    <label for="editDeviceMAC" class="form-label">MAC Address</label>
    <input type="text" name="editDeviceMAC" id="editDeviceMAC" class="form-control" value="<cfoutput>#qGetEditDevice.device_mac_address#</cfoutput>" placeholder="50:9A:4C:44:55:7A">
    <label for="editDeviceModel" class="form-label">Model*</label>
    <select class="form-select" name="editDeviceModel" id="editDeviceModel">
      <cfloop query="qGetEditModels">
        <option value="<cfoutput>#qGetEditModels.model_name#</cfoutput>"><cfoutput>#qGetEditModels.model_name#</cfoutput></option>
      </cfloop>
    </select>
    <label for="editDeviceOS" class="form-label">Operating System*</label>
    <select class="form-select" name="editDeviceOS" id="editDeviceOS">
      <cfloop query="qGetEditOS">
        <option value="<cfoutput>#qGetEditOS.os_name#</cfoutput>"><cfoutput>#qGetEditOS.os_name#</cfoutput></option>
      </cfloop>
    </select>
    <div class="row">
      <div class="col">
        <label for="editDeviceFleet" class="form-label">Fleet Name</label>
        <select class="form-select" name="editDeviceFleet" id="editDeviceFleet">
          <cfloop query="qGetEditFleets">
            <option value="<cfoutput>#qGetEditFleets.fleet_name#</cfoutput>"><cfoutput>#qGetEditFleets.fleet_name#</cfoutput></option>
          </cfloop>
        </select>
      </div>
      <div class="col">
        <label for="editDeviceFunding" class="form-label">Funding Source</label>
        <select class="form-select" name="editDeviceFunding" id="editDeviceFunding">
          <cfloop query="qGetEditFundings">
            <option value="<cfoutput>#qGetEditFundings.funding_name#</cfoutput>"><cfoutput>#qGetEditFundings.funding_name#</cfoutput></option>
          </cfloop>
        </select>
      </div>
    </div>
    <label for="editDeviceRole" class="form-label">Role</label>
    <select class="form-select" name="editDeviceRole" id="editDeviceRole">
      <cfloop query="qGetEditRoles">
        <option value="<cfoutput>#qGetEditRoles.role_name#</cfoutput>"><cfoutput>#qGetEditRoles.role_name#</cfoutput></option>
      </cfloop>
    </select>
    <label for="editDeviceRequisition" class="form-label">Requisition</label>
    <select class="form-select" name="editDeviceRequisition" id="editDeviceRequisition">
      <cfloop query="qGetEditRequisitions">
        <option value="<cfoutput>#qGetEditRequisitions.requisition_name#</cfoutput>"><cfoutput>#qGetEditRequisitions.requisition_name#</cfoutput></option>
      </cfloop>
    </select>
    <label for="editDeviceDescription" class="form-label" >Description</label>
    <textarea class="form-control" name="editDeviceDescription" id="editDeviceDescription" value="<cfoutput>#qGetEditDevice.device_description#</cfoutput>"><cfoutput>#qGetEditDevice.device_description#</cfoutput></textarea>
    <cfquery name = "qGetPins" dataSource = "helpdesk">
				SELECT PIN.tag_name, device_serial
				FROM PIN INNER JOIN TAG ON PIN.tag_name=TAG.tag_name
				WHERE device_serial = '#deviceCurrent#'
				ORDER BY PIN.tag_name ASC;
			</cfquery>
    <cfquery name = "qGetSubmits" dataSource = "helpdesk">
				SELECT SUBMIT.ticket_num, device_serial
				FROM SUBMIT INNER JOIN TICKET ON SUBMIT.ticket_num=TICKET.ticket_num
				WHERE device_serial = '#deviceCurrent#'
				ORDER BY SUBMIT.ticket_num ASC;
			</cfquery>
    <label for="editSubmitTickets" class="form-label">Tickets:
      <cfloop query="qGetSubmits">
        <cfoutput>#qGetSubmits.ticket_num#</cfoutput>,
      </cfloop>
    </label>
    <select class="selectpicker" data-style="multiselectColor" multiple name="editSubmitTickets" id="editSubmitTickets" data-live-search="true">
      <cfloop query="qGetTickets">
        <option value="<cfoutput>#qGetTickets.ticket_num#</cfoutput>"><cfoutput>#qGetTickets.ticket_num#</cfoutput></option>
      </cfloop>
    </select>
    <label for="editPinTags" class="form-label">Tags:
      <cfloop query="qGetPins">
        <cfoutput>#qGetPins.tag_name#</cfoutput>,
      </cfloop>
    </label>
    <select class="selectpicker" data-style="multiselectColor" multiple name="editPinTags" id="editPinTags" data-live-search="true">
      <cfloop query="qGetTags">
        <option value="<cfoutput>#qGetTags.tag_name#</cfoutput>"><cfoutput>#qGetTags.tag_name#</cfoutput></option>
      </cfloop>
    </select>
    <hr>
    <div class="d-grid gap-2 col-12 mx-auto">
      <button type="submit" name="submitEditDevice" class="btn btn-yes btn-form">-Apply Changes-</button>
      <button type="button" name="deleteEditDevice" data-bs-toggle="modal" data-bs-target="#deleteModal" class="btn btn-no btn-form">-Delete Device-</button>
    </div>
    <!--DELETE-MODAL-START--> 
    <!---#deviceCurrent#--->
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" id="deleteModal">
    <div class="modal-dialog modal-dialog-centered modal-fullscreen-lg-down" role="document">
    <div class="modal-content">
    <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
      <div class="modal-header border-0" style="background-color: #d02030 !important;"> <span style="display: inline-flex; gap: 5px; align-items: center;"> <span style="display: flex; align-items: center; justify-content: center; padding: 5px; background-color: #aa1f2e; border-radius: 5px; color: #fafaf0"> <!--START-OF-CARD-BODY-->
        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-trash-fill" viewBox="0 0 16 16">
          <path d="M2.5 1a1 1 0 0 0-1 1v1a1 1 0 0 0 1 1H3v9a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V4h.5a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H10a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1H2.5zm3 4a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5zM8 5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7A.5.5 0 0 1 8 5zm3 .5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 1 0z"/>
        </svg>
        </span> <span class="modalHeadTitle">Delete Device <cfoutput>#qGetEditDevice.device_serial#</cfoutput>?</span></span> </div>
      <div class="modal-body">This record will be permanently deleted from our list of devices. This will delete any TMA/DLT records associated with the device as well.  This will also remove it from the list of devices in a certain tag.  If an error was made, we suggest instead editing the record.</div>
      <div class="modal-footer border-0">
        <button type="button" class="btn btn-neutral btn-form" data-bs-dismiss="modal">Cancel</button>
        <button type="submit" class="btn btn-no btn-form" name="deleteDevice" style="margin-left: 5px;">Delete Device</button>
      </div>
    </form>
  </div>
</div>
</div>
<!--END-OF-DELETE MODAL-->
</form>
<!--END-OF-EDIT-FORM-->
</div>
<!--END-OF-CARD-BODY-->
</div>
<!--END-OF-DEVICE-DETAILS--> 
<!-- InstanceEndEditable -->
</div>
<!--END-OF-RIGHT-COL-->

</div>
<!--END-OF-ROW-DIV-->
</div>
<!--END-OF-CONTAINER--> 

<!-- InstanceBeginEditable name="modalEdit" --> 
<!--ADD-LOCATION-MODAL-START-->
<cfif (isDefined("form.addLocationName") and form.addLocationName NEQ "") AND (isDefined("form.addLocationAddress") and form.addLocationAddress NEQ "")>
  <cftry>
    <cfquery datasource="Helpdesk">
          INSERT INTO LOCATION(location_name, location_address) VALUES ('#form.addLocationName#','#form.addLocationAddress#');
    </cfquery>
    <cflocation url="#cgi.script_name#" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
</cfif>
<div class="modal fade" id="addLocationModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-dialog-centered modal-fullscreen-lg-down" role="document">
    <div class="modal-content">
      <div class="modal-header border-0"> <span style="display: inline-flex; gap: 5px; align-items: center;"> <span style="display: flex; align-items: center; justify-content: center; padding: 5px; background-color: #1c503e; border-radius: 5px; color: #fafaf0"> <!--START-OF-CARD-BODY-->
        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-building-fill" viewBox="0 0 16 16">
          <path d="M3 0a1 1 0 0 0-1 1v14a1 1 0 0 0 1 1h3v-3.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5V16h3a1 1 0 0 0 1-1V1a1 1 0 0 0-1-1H3Zm1 2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm3.5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5ZM4 5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1ZM7.5 5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5Zm2.5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1ZM4.5 8h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5Zm2.5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1Zm3.5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5Z"/>
        </svg>
        </span> <span class="modalHeadTitle">Add Locations</span></span> </div>
      <div class="modal-body">
      Please submit the new Location's full name.
      <hr>
      <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
        <label for="addLocationName" class="form-label">Location Name*</label>
        <input type="text" name="addLocationName" id="addLocationName" class="form-control" placeholder="Lincoln High School">
        <label for="addLocationAddress" class="form-label" style="margin-top: 2%;">Location Address*</label>
        <input type="text" name="addLocationAddress" id="addLocationAddress" class="form-control" placeholder="2229 J St, Lincoln, NE 68510">
        </div>
        <div class="modal-footer border-0">
          <button type="button" class="btn btn-neutral btn-form" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-yes btn-form" name="submitLocation" style="margin-left: 5px;">Add New Location</button>
          <table class="table table-hover modal-table table-sm">
            <thead>
              <tr>
                <th scope="col">Location Name</th>
                <th scope="col">Location Address</th>
              </tr>
            </thead>
            <tbody>
              <cfloop query="qGetLocations">
                <tr>
                  <td><cfoutput>#qGetLocations.location_name#</cfoutput></td>
                  <td><cfoutput>#qGetLocations.location_address#</cfoutput></td>
                </tr>
              </cfloop>
            </tbody>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<!--ADD-LOCATION-MODAL-END--> 

<!--ADD-FLEET-MODAL-START-->
<cfif (isDefined("form.addFleetName") and form.addFleetName NEQ "")>
  <cftry>
    <cfquery datasource="Helpdesk">
          INSERT INTO FLEET(fleet_name, fleet_description) VALUES ('#form.addFleetName#','#form.addFleetDescription#');
    </cfquery>
    <cflocation url="#cgi.script_name#" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
</cfif>
<div class="modal fade" id="addFleetModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-dialog-centered modal-fullscreen-lg-down" role="document">
    <div class="modal-content">
      <div class="modal-header border-0"> <span style="display: inline-flex; gap: 5px; align-items: center;"> <span style="display: flex; align-items: center; justify-content: center; padding: 5px; background-color: #1c503e; border-radius: 5px; color: #fafaf0"> <!--START-OF-CARD-BODY-->
        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-collection-fill" viewBox="0 0 16 16">
          <path d="M0 13a1.5 1.5 0 0 0 1.5 1.5h13A1.5 1.5 0 0 0 16 13V6a1.5 1.5 0 0 0-1.5-1.5h-13A1.5 1.5 0 0 0 0 6v7zM2 3a.5.5 0 0 0 .5.5h11a.5.5 0 0 0 0-1h-11A.5.5 0 0 0 2 3zm2-2a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 0-1h-7A.5.5 0 0 0 4 1z"/>
        </svg>
        </span> <span class="modalHeadTitle">Add Fleets</span></span> </div>
      <div class="modal-body">
      Please submit the new Fleet's full name.  A fleet is the "group" the machine belongs to.
      <hr>
      <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
        <label for="addFleetName" class="form-label">Fleet Name*</label>
        <input type="text" name="addFleetName" id="addFleetName" class="form-control" placeholder="Building Purchased">
        <label for="addFleetDescription" class="form-label" style="margin-top: 2%;">Fleet Description</label>
        <textarea class="form-control" name="addFleetDescription" id="addFleetDescription"></textarea>
        </div>
        <div class="modal-footer border-0">
          <button type="button" class="btn btn-neutral btn-form" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-yes btn-form" name="submitFleet" data-bs-toggle="modal" style="margin-left: 5px;">Add New Fleet</button>
          <table class="table table-hover modal-table table-sm">
            <thead>
              <tr>
                <th scope="col">Fleet Name</th>
                <th scope="col">Fleet Description</th>
              </tr>
            </thead>
            <tbody>
              <cfquery name = "qGetManageFleets" dataSource = "helpdesk"> 
    SELECT fleet_name, fleet_description
	FROM FLEET
	WHERE fleet_name != 'Unknown'
	ORDER BY fleet_name ASC;
</cfquery>
              <cfloop query="qGetManageFleets">
                <tr>
                  <td><cfoutput>#qGetManageFleets.fleet_name#</cfoutput></td>
                  <td><cfoutput>#qGetManageFleets.fleet_description#</cfoutput></td>
                </tr>
              </cfloop>
            </tbody>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<!--ADD-FLEET-MODAL-END--> 

<!--ADD-ROLE-MODAL-START-->
<cfif (isDefined("form.addRoleName") and form.addRoleName NEQ "")>
  <cftry>
    <cfquery datasource="Helpdesk">
          INSERT INTO ROLE(role_name, role_description) VALUES ('#form.addRoleName#','#form.addRoleDescription#');
    </cfquery>
    <cflocation url="#cgi.script_name#" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
</cfif>
<div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-dialog-centered modal-fullscreen-lg-down" role="document">
    <div class="modal-content">
      <div class="modal-header border-0"> <span style="display: inline-flex; gap: 5px; align-items: center;"> <span style="display: flex; align-items: center; justify-content: center; padding: 5px; background-color: #1c503e; border-radius: 5px; color: #fafaf0"> <!--START-OF-CARD-BODY-->
        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-people-fill" viewBox="0 0 16 16">
          <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7Zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216ZM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"/>
        </svg>
        </span> <span class="modalHeadTitle">Add Roles</span></span> </div>
      <div class="modal-body">
      Please submit the new Role's full name.
      <hr>
      <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
        <label for="addRoleName" class="form-label">Role Name*</label>
        <input type="text" name="addRoleName" id="addRoleName" class="form-control" placeholder="Staff">
        <label for="addRoleDescription" class="form-label" style="margin-top: 2%;">Role Description</label>
        <textarea class="form-control" name="addRoleDescription" id="addRoleDescription"></textarea>
        </div>
        <div class="modal-footer border-0">
          <button type="button" class="btn btn-neutral btn-form" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-yes btn-form" name="submitRole" data-bs-toggle="modal" style="margin-left: 5px;">Add New Role</button>
          <table class="table table-hover modal-table table-sm">
            <thead>
              <tr>
                <th scope="col">Role Name</th>
                <th scope="col">Role Description</th>
              </tr>
            </thead>
            <tbody>
              <cfquery name = "qGetManageRoles" dataSource = "helpdesk"> 
    SELECT role_name, role_description
	FROM ROLE
	WHERE role_name != 'Unknown'
	ORDER BY role_name ASC;
</cfquery>
              <cfloop query="qGetManageRoles">
                <tr>
                  <td><cfoutput>#qGetManageRoles.role_name#</cfoutput></td>
                  <td><cfoutput>#qGetManageRoles.role_description#</cfoutput></td>
                </tr>
              </cfloop>
            </tbody>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<!--ADD-ROLE-MODAL-END--> 

<!--ADD-FUNDING-MODAL-START-->
<cfif (isDefined("form.addFundingName") and form.addFundingName NEQ "")>
  <cftry>
    <cfquery datasource="Helpdesk">
          INSERT INTO FUNDING(funding_name, funding_description) VALUES ('#form.addFundingName#','#form.addFundingDescription#');
    </cfquery>
    <cflocation url="#cgi.script_name#" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
</cfif>
<div class="modal fade" id="addFundingModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-dialog-centered modal-fullscreen-lg-down" role="document">
    <div class="modal-content">
      <div class="modal-header border-0"> <span style="display: inline-flex; gap: 5px; align-items: center;"> <span style="display: flex; align-items: center; justify-content: center; padding: 5px; background-color: #1c503e; border-radius: 5px; color: #fafaf0"> <!--START-OF-CARD-BODY-->
        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-currency-exchange" viewBox="0 0 16 16">
          <path d="M0 5a5.002 5.002 0 0 0 4.027 4.905 6.46 6.46 0 0 1 .544-2.073C3.695 7.536 3.132 6.864 3 5.91h-.5v-.426h.466V5.05c0-.046 0-.093.004-.135H2.5v-.427h.511C3.236 3.24 4.213 2.5 5.681 2.5c.316 0 .59.031.819.085v.733a3.46 3.46 0 0 0-.815-.082c-.919 0-1.538.466-1.734 1.252h1.917v.427h-1.98c-.003.046-.003.097-.003.147v.422h1.983v.427H3.93c.118.602.468 1.03 1.005 1.229a6.5 6.5 0 0 1 4.97-3.113A5.002 5.002 0 0 0 0 5zm16 5.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0zm-7.75 1.322c.069.835.746 1.485 1.964 1.562V14h.54v-.62c1.259-.086 1.996-.74 1.996-1.69 0-.865-.563-1.31-1.57-1.54l-.426-.1V8.374c.54.06.884.347.966.745h.948c-.07-.804-.779-1.433-1.914-1.502V7h-.54v.629c-1.076.103-1.808.732-1.808 1.622 0 .787.544 1.288 1.45 1.493l.358.085v1.78c-.554-.08-.92-.376-1.003-.787H8.25zm1.96-1.895c-.532-.12-.82-.364-.82-.732 0-.41.311-.719.824-.809v1.54h-.005zm.622 1.044c.645.145.943.38.943.796 0 .474-.37.8-1.02.86v-1.674l.077.018z"/>
        </svg>
        </span> <span class="modalHeadTitle">Add Funding Sources</span></span> </div>
      <div class="modal-body">
      Please submit the new Funding Source's full name.  The funding is who pays for fleets.
      <hr>
      <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
        <label for="addFundingName" class="form-label">Funding Source Name*</label>
        <input type="text" name="addFundingName" id="addFundingName" class="form-control" placeholder="Federal Programs">
        <label for="addFundingDescription" class="form-label" style="margin-top: 2%;">Funding Source Description</label>
        <textarea class="form-control" name="addFundingDescription" id="addFundingDescription"></textarea>
        </div>
        <div class="modal-footer border-0">
          <button type="button" class="btn btn-neutral btn-form" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" name="submitFunding" class="btn btn-yes btn-form" data-bs-toggle="modal" style="margin-left: 5px;">Add New Funding Source</button>
          <table class="table table-hover modal-table table-sm">
            <thead>
              <tr>
                <th scope="col">Funding Name</th>
                <th scope="col">Funding Description</th>
              </tr>
            </thead>
            <tbody>
              <cfquery name = "qGetManageFundings" dataSource = "helpdesk"> 
    SELECT funding_name, funding_description
	FROM FUNDING
	WHERE funding_name != 'Unknown'
	ORDER BY funding_name ASC;
</cfquery>
              <cfloop query="qGetManageRoles">
                <tr>
                  <td><cfoutput>#qGetManageFundings.funding_name#</cfoutput></td>
                  <td><cfoutput>#qGetManageFundings.funding_description#</cfoutput></td>
                </tr>
              </cfloop>
            </tbody>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<!--ADD-FUNDING-MODAL-END--> 

<!--ADD-TAG-MODAL-START-->
<cfif (isDefined("form.addTagName") and form.addTagName NEQ "")>
  <cftry>
    <cfquery datasource="Helpdesk">
          INSERT INTO TAG(tag_name, tag_description, tag_color) VALUES ('#form.addTagName#','#form.addTagDescription#','#form.addTagColor#');
    </cfquery>
    <cflocation url="#cgi.script_name#" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
</cfif>
<div class="modal fade" id="addTagModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-dialog-centered modal-fullscreen-lg-down" role="document">
    <div class="modal-content">
      <div class="modal-header border-0"> <span style="display: inline-flex; gap: 5px; align-items: center;"> <span style="display: flex; align-items: center; justify-content: center; padding: 5px; background-color: #1c503e; border-radius: 5px; color: #fafaf0"> <!--START-OF-CARD-BODY-->
        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-tag-fill" viewBox="0 0 16 16">
          <path d="M2 1a1 1 0 0 0-1 1v4.586a1 1 0 0 0 .293.707l7 7a1 1 0 0 0 1.414 0l4.586-4.586a1 1 0 0 0 0-1.414l-7-7A1 1 0 0 0 6.586 1H2zm4 3.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
        </svg>
        </span> <span class="modalHeadTitle">Add Tags</span></span> </div>
      <div class="modal-body">
      Please submit a name for this Tag.  Each tag has a unique name, so duplicates will not be accepted.  Please avoid spaces to limit the amount of duplicate tags.
      <hr>
      <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
        <!--START-OF-TAG-FORM-->
        <label for="addTagName" class="form-label">Tag Name*</label>
        <input type="text" name="addTagName" id="addTagName" class="form-control" placeholder="ashley'sdesk" required>
        <label for="addTagDescription" class="form-label" style="margin-top: 2%;">Tag Description</label>
        <textarea class="form-control" name="addTagDescription" id="addTagDescription"></textarea>
        <label for="addTagColor" class="form-label" style="margin-top: 2%;">Tag Color*</label>
        <select class="form-select" name="addTagColor" id="addTagColor">
          <option value="c8102e">Red</option>
          <option value="3d6da7">Blue</option>
          <option value="6dba4c">Green</option>
          <option value="eb8000">Orange</option>
          <option value="4b2a71">Purple</option>
        </select>
        </div>
        <div class="modal-footer border-0">
          <button type="button" class="btn btn-neutral btn-form" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" name="submitTag" class="btn btn-yes btn-form" style="margin-left: 5px;">Add New Tag</button>
        </div>
      </form>
      <!--END-OF-TAG-FORM--> 
    </div>
  </div>
</div>
<!--ADD-TAG-MODAL-END--> 

<!--ADD-TICKET-MODAL-START-->
<cfif (isDefined("form.addTicketNum") and form.addTicketNum NEQ "")>
  <cftry>
    <cfquery datasource="Helpdesk">
          INSERT INTO TICKET(ticket_num) VALUES ('#form.addTicketNum#');
    </cfquery>
    <cflocation url="#cgi.script_name#" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
</cfif>
<div class="modal fade" id="addTicketModal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-dialog-centered modal-fullscreen-lg-down" role="document">
    <div class="modal-content">
      <div class="modal-header border-0"> <span style="display: inline-flex; gap: 5px; align-items: center;"> <span style="display: flex; align-items: center; justify-content: center; padding: 5px; background-color: #1c503e; border-radius: 5px; color: #fafaf0"> <!--START-OF-CARD-BODY-->
        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-ticket-perforated-fill" viewBox="0 0 16 16">
          <path d="M0 4.5A1.5 1.5 0 0 1 1.5 3h13A1.5 1.5 0 0 1 16 4.5V6a.5.5 0 0 1-.5.5 1.5 1.5 0 0 0 0 3 .5.5 0 0 1 .5.5v1.5a1.5 1.5 0 0 1-1.5 1.5h-13A1.5 1.5 0 0 1 0 11.5V10a.5.5 0 0 1 .5-.5 1.5 1.5 0 1 0 0-3A.5.5 0 0 1 0 6V4.5Zm4-1v1h1v-1H4Zm1 3v-1H4v1h1Zm7 0v-1h-1v1h1Zm-1-2h1v-1h-1v1Zm-6 3H4v1h1v-1Zm7 1v-1h-1v1h1Zm-7 1H4v1h1v-1Zm7 1v-1h-1v1h1Zm-8 1v1h1v-1H4Zm7 1h1v-1h-1v1Z"/>
        </svg>
        </span> <span class="modalHeadTitle">Add Tickets</span></span> </div>
      <div class="modal-body">
      Please submit the Ticket's number.
      <hr>
      <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post" enctype="multipart/form-data">
        <label for="addTicketNumber" class="form-label">Ticket Number*</label>
        <input type="number" name="addTicketNum" id="addTicketNumber" class="form-control" placeholder="254983" required>
        </div>
        <div class="modal-footer border-0">
          <button type="button" class="btn btn-neutral btn-form" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" name="submitTicket" class="btn btn-yes btn-form" style="margin-left: 5px;">Add New Ticket</button>
        </div>
      </form>
    </div>
  </div>
</div>
<!--ADD-TICKET-MODAL-END--> 

<!-- InstanceEndEditable --> 

<!--MAIN-END---------------------------------------------------------------------------------> 
<!-- InstanceBeginEditable name="endImports" --> 
<!--IMPORTS-START--> 
<!--BOOTSTRAP-TABLE--> 
<script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script> 
<script src="https://unpkg.com/bootstrap-table@1.21.3/dist/bootstrap-table.min.js"></script> 
<!--BOOTSTRAP-TABLE-END--> 
<!--BOOTSTRAP-TABLE-FILTER--> 
<script src="bootstrap-table/dist/extensions/filter-control/bootstrap-table-filter-control.js"></script> 
<script src="bootstrap-table/dist/extensions/filter-control/bootstrap-table-filter-control.min.js"></script> 
<!--BOOTSTRAP-TABLE-FILTER-END--> 
<!--MULTI-SELECT--> 
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.14.0-beta2/js/bootstrap-select.min.js"></script> 
<!--END-OF-MULTI-SELECT--> 
<!--IMPORTS-END--> 
<script>
	var tooltipList1 = [].slice.call(document.querySelectorAll('[data-bs-toggle = "tooltip"]'))  
	var tooltipList2 = tooltipList1.map(function (tooltipTriggerfun) {  
  	return new bootstrap.Tooltip(tooltipTriggerfun)  
	})  
</script> 
<!-- InstanceEndEditable -->
</body>
<!-- InstanceEnd -->
</html>
