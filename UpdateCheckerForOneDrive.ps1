# Mail relay settings (The local server configured to send an e-mail).
$SMTPSERVER = "IP4AddressOrDNSName"
$MAILFROM = "Account Name Here <account@domain.here>"
$MAILTO = "account@domain.here"

$OneDriveWebpage = Invoke-WebRequest https://support.microsoft.com/en-us/office/onedrive-release-notes-845dcf18-f921-435e-bf28-4e24b95e5fc0
$StrangeSpace = [char] 0x00A0
$WebpageContent = $OneDriveWebpage.Content -replace $StrangeSpace, " "
If ($WebpageContent -match "Download OneDrive for Windows</a> - Version \d{1,5}.\d{1,5}.\d{1,5}.\d{1,5} [(]" + (Get-Date).AddMonths(0).AddDays(0).tostring(“MMMM dd, yyyy"))`
   -or ($WebpageContent -match "Download OneDrive for Windows</a> - Version \d{1,5}.\d{1,5}.\d{1,5}.\d{1,5} [(]" + (Get-Date).AddMonths(0).AddDays(-1).tostring(“MMMM dd, yyyy"))
{
    Send-MailMessage -To "$MAILTO" -From "$MAILFROM" -Subject "Possible OneDrive Update Available" -Body "Please check https://support.microsoft.com/en-us/office/onedrive-release-notes-845dcf18-f921-435e-bf28-4e24b95e5fc0 to see if OneDrive updates are available." -SmtpServer "$SMTPSERVER"
}
