# Update Checker for OneDrive

As you may know from my respository for the Logon Screen Installer, I have to manually find and deploy later versions of the OneDrive client as we were having difficulty with the client automatically updating to the new version, just spending time thinking about it but not really doing anything. Well, to ensure the version we use doesn't expire and force us to update, we have a group policy attribute to defere the automatic upgrading requirements of the client to the older version of the client, tried and still trusted on the Enterprise ring.

For those wondering where that setting is in Group Policy...<br>
`Computer Configuration -> Policies -> Administrative Templates -> OneDrive`<br>
`Set the sync client update ring`<br>
`Update Ring: Enterprise`

Anyway, that's all well and good making sure that we don't have to be so prompt to install the latest version right there and then... but it only delays the requirement, and we need to find a way to ensure we update before we possibly run into this problem again. So I made a PowerShell script which will e-mail me using our SMTP relay server if one is discovered... if you don't have one setup it's relatively straightforward have a look here https://docs.microsoft.com/en-us/iis/application-frameworks/install-and-configure-php-on-iis/configure-smtp-e-mail-in-iis-7-and-above.

The powershell script I made is run as a sheduled task, and will look on Microsoft's OneDrive client webpage (https://support.microsoft.com/en-us/office/onedrive-release-notes-845dcf18-f921-435e-bf28-4e24b95e5fc0) to find out if there has been a new general release the day it's run and the day previous. If there has been a new client for Windows on either of those days, it will e-mail you using the mail relay you have previously setup.

The file called `UpdateCheckerForOneDrive.ps1`.

The key three values to change for your setup are...<br>
`$SMTPSERVER = "IP4AddressOrDNSName"`<br>
`$MAILFROM = "Account Name Here <account@domain.here>"`<br>
`$MAILTO = "account@domain.here"`
