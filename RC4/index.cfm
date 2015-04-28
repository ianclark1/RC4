<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>RC4 Encryption Example</title>
	</head>
	
	<body>
		<h1>RC4 Encryption Example</h1>
		<cfparam name="form.plaintext" default="">
		<cfparam name="form.encryptedtext" default="">
		<cfparam name="form.decryptedtext" default="">
		<cfparam name="form.encryptionkey" default="EncKey">
		
		<cfset RC4 = createObject("component","RC4")>
		<cfif isDefined("form.rc4encrypt")>
			<cfset form.encryptedtext = RC4.rc4encrypt(form.plaintext,form.encryptionkey)>
		</cfif>
		<cfif isDefined("form.rc4decrypt") and len(form.encryptedtext)>
			<cfset form.decryptedtext = RC4.rc4decrypt(form.encryptedtext,form.encryptionkey)>
		</cfif>
		
		<cfform action="#cgi.SCRIPT_NAME#" method="post">
			<table cellpadding="4" cellspacing="4">
				<tr>
					<td>Encryption Key</td>
					<td>
						<cfinput type="text" name="encryptionkey" value="#form.encryptionkey#" size="50">
					</td>
				</tr>
				<tr>
					<td>Text to Encrypt</td>
					<td>
						<cfinput type="text" name="plaintext" value="#form.plaintext#" size="50">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" name="rc4encrypt" value="Encrypt Using RC4" />
					</td>
				</tr>
				<tr>
					<td>Encrypted Text</td>
					<td>
						<cfinput type="text" name="encryptedtext" value="#form.encryptedtext#" size="50">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" name="rc4decrypt" value="Decrypt Using RC4" />
					</td>
				</tr>
				<tr>
					<td>Decrypted Text</td>
					<td>
						<b><cfoutput>#form.decryptedtext#</cfoutput></b>
					</td>
				</tr>
			</table>
		</cfform>
		
	</body>
</html>