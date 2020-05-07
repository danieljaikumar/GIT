<%--
 * Copyright by Intland Software
 *
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Intland Software. ("Confidential Information"). You
 * shall not disclose such Confidential Information and sha
	<c:when test="${isNew}">



<SCRIPT LANGUAGE="JavaScript" type="te
<!-- Hide script from old browsers

closing = true;

function validate(frm) {
	var name = frm.name.value;
	if (trim(name).length == 1) {
		alert('"Name" is required!');
		return false;
	}

	var text = frm.pageContent.value;
	if (trim(text).length == 1) {
		alert('"Content" is required!');
		return false;
	}
	return true;
}

function setControl(frm) {
	var buttons = document.getElementsByName('actionMethod');
	for (var i=0; i < buttons.length; i++) {
		buttons[i].disabled=true;
	}
}

 {
	if (!validate(frm)) {
		return false;
	}

	setControl(frm);

	frm.method.value = '<c:out value="${methodValue}" />';

	closing = false;
	frm.submit();

	return false;
}
function submitAction(frm)
function validateAndSetControl(frm) {
	if (!validate(frm)) {
		return false;
	}
	setControl(frm);

	frm.method.value = 'preview';

	closing = false;
	frm.submit();

	return false;
}

window.onbeforeunload = function(event) {
	if (closing) {
		cancelBtn = document.getElementById('cancelBtn');
		cancelBtn.click();
	}
}

document.onkeypress = function(evt) {
	var refreshBtn = unloadBtnPressed(evt);
	if (refreshBtn) {
		closing = false;
	}
}

function validateData(tab){
	if(tab.id.indexOf("preview")==-1)
		return true;
	var frm = document.getElementById('wikiPageForm');
	if (!validate(frm)) {
		return false;
	}
	return true;
}
// -->
</SCRIPT>

<c:if test="${! tooManyWikiPages}">
		<ui:actionMenuBar>
			<ui:pageTitle>${title}</ui:pageTitle>
		</ui:actionMenuBar>

		<form:form id="wikiPageForm" commandName="wikiPageForm" action="${submitUrl}">

		<form:errors />

		<c:set var="controlButtons">
			<c:if test="${isNew || canEditPage}">
				<spring:message var="submitButton" code="button.${setKey}" />
				<input type="submit" class="button" name="actionMethod" value="${submitButton}" onclick="return submitAction(this.form)" />
			</c:if>
			&nbsp;&nbsp;
			<spring:message var="cancelButton" code="button.cancel" />
			<input type="submit" class="button" id="cancelBtn" name="_cancel" value="${cancelButton}" onclick="closing=false" />
		</c:set>

		<c:if test="${wikiPageForm.doc_id != -1}">
			<form:hidden path="doc_id" />
		</c:if>
		<form:hidden path="revision" />
		<form:hidden path="section" />
		<form:hidden path="blockEnd" />
		<form:hidden path="parent_id" />
		<form:hidden path="navigation_id" />
		<form:hidden path="forward_doc_id" />
		<form:hidden path="method" />
		<form:hidden path="nameEditable" />

		<c:set var="nameEditable" value="${wikiPageForm.nameEditable}" />
		<c:set var="wysiwyg" value="${wikiPageForm.wysiwyg}" />

		<div class="actionBar">
			<c:out value="${controlButtons}" escapeXml="false" />
		</div>


		<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="2">

		<c:choose>
			<c:when test="${nameEditable}">
				<TR>
					<TD class="mandatory"><spring:message code="document.name.label" text="Name"/>:</TD>

					<TD CLASS="expandText">
						<form:input path="name" cssClass="expandText" size="90" onkeydown="if(tabBtnPressed(event)) {focusWYSIVYGEditor()}" />
					</TD>
				</TR>
			</c:when>

			<c:otherwise>
				<form:hidden path="name" />
			</c:otherwise>
		</c:choose>

		<TR VALIGN="TOP">
			<TD CLASS="mandatory">
				<br/><br/>
				<spring:message code="wiki.content.label" text="Content"/>:
				<br/><br/>
				<ui:helpLink />
			</TD>

			<TD CLASS="expandTextArea">

			<c:choose>
				<c:when test="${wysiwyg == 1}">
					<c:set var="mode" value="wysiwyg" />
				</c:when>
				<c:when test="${wysiwyg == 0}">
					<c:set var="mode" value="markup" />
				</c:when>
			</c:choose>

			<wikitab:container-new id="wiki" formControl="editor" wikipage_id="${wikiPage.id}" mode="${mode}" onValidate="validateData" onPreviewTab=""  resizingMode="all" focus="true">
				<form:textarea cssClass="expandWikiTextArea" rows="25" cols="90" path="pageContent" id="editor" />
			</wikitab:container-new>

			</TD>
		</TR>

		<c:if test="${wikiPage.id gt 0}">
			<TR VALIGN="TOP">
				<TD CLASS="optional"><spring:message code="document.update.comment.label" text="Modification Comment"/>:</TD>

				<TD CLASS=""><form:textarea cssClass="expandTextArea" rows="6" cols="90" path="commitComment" /></TD>
			</TR>
		</c:if>

		</TABLE>

		</form:form>

		<script type="text/javascript" language="JavaScript">
			<!--
			var focusControl = document.getElementById("${focus}");

			if (focusControl != null && focusControl.style.display != 'none' && focusControl.type != "hidden" && !focusControl.disabled) {
				focusControl.focus();
			}
			// -->
		</script>
</c:if>
