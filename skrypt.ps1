$smtpServer = "smtp.something.com" #CHANGE SMTP 

# 25 or 587 MOSTLY FOR SMTP 
$smtpPort   = 587
$useSsl     = $false
$from       = "SendingAddress@domain.com" #PUT YOUR LOGIN/EMAIL SENDING HERE
$plainPassword = "PasswordInPlainTextLOL!" #PUT YOUR PASSWORD IN PLAINTEXT HERE (PLEASE USE NEWLY GENERATED, UNUSED MAIL)
$securePassword = ConvertTo-SecureString $plainPassword -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential($from, $securePassword)
$csvPath = ".\ExportData.csv"  # CHANGE PATH / PUT IN THE SAME FOLDER

if (-not (Test-Path $csvPath)) {
    Write-Host "ERROR: File ExportData.csv not found." -ForegroundColor Red
    exit 1
}

$users = Import-Csv -Path $csvPath

if (-not $users -or $users.Count -eq 0) {
    Write-Host "ERROR: CSV contains no data." -ForegroundColor Red
    exit 1
}

$emailColumnName = ($users[0].PSObject.Properties | Select-Object -First 1).Name
Write-Host "Detected email column: $emailColumnName" -ForegroundColor Green

# EMAIL THING!!!!!!!!!!! YOU CAN USE HTML HERE

$subject = "Very important subject please check quick!" #Input your subject here

$bodyTop = @"
Hi!<br>
<br>
Please quick see the new addedd features on our company website site link is here:<br> 
<br>
"@


$stopka = @"
<br>
<br>
<br>
Sincerely,<br
Someone<br>
Something something<br>
tel: +123 456 789<br>
company.website.com<br>
<br>
-------------------------------------------------------------------------------------------------------------------------------------------------------------<br>
The content of this message, including any attachments, contains information intended only for another address and may contain confidential and legally protected information. If you are not the intended recipient or if you receive it in error, you are hereby notified immediately to the sender by replying to this message, deleting the message in its entirety, not disclosing, reproducing, reusing, or using it in any way whatsoever, in whole or in part, in any directory..<br>
"@

$delaySeconds = 3 #I SUGGEST SENDING 1 every 3 seconds - try different values - depends on smtp provider

$summary = @()

Write-Host ""
Write-Host "=== SMTP sending started ===" -ForegroundColor Cyan
Write-Host ""

foreach ($u in $users) {

    $email = $u.$emailColumnName

    if ([string]::IsNullOrWhiteSpace($email)) {
        continue
    }

    $emailTrimmed = $email.Trim()
    $uid = ($emailTrimmed.Split("@")[0]).Trim().ToLower()

    $realLink    = "https://yourwebsite.com/?uid=$uid"
    $displayLink = "https://yourwebsite.com/"

    $bodyHtml = @"
<html>
<body style="font-family: Arial; white-space: pre-line;">
$bodyTop

<a href="$realLink">$displayLink</a>

$stopka
</body>
</html>
"@

    $status = "OK"
    $errorMsg = ""

    try {
        Send-MailMessage `
            -To $emailTrimmed `
            -From $from `
            -Subject $subject `
            -Body $bodyHtml `
            -BodyAsHtml `
            -SmtpServer $smtpServer `
            -Port $smtpPort `
            -UseSsl:$useSsl `
            -Credential $cred

        Write-Host "SENT OK -> $emailTrimmed (UID: $uid)" -ForegroundColor Green
    }
    catch {
        $status = "ERROR"
        $errorMsg = $_.Exception.Message
        Write-Host "SEND FAIL -> $emailTrimmed" -ForegroundColor Red
        Write-Host "ERROR: $errorMsg" -ForegroundColor DarkRed
    }

    $summary += [PSCustomObject]@{
        Email = $emailTrimmed
        UID   = $uid
        Link  = $realLink
        Status = $status
        Error  = $errorMsg
    }

    Start-Sleep -Seconds $delaySeconds
}

Write-Host ""
Write-Host "=== SUMMARY ===" -ForegroundColor Cyan
$summary | Format-Table -AutoSize

$reportPath = ".\raport_wysylki.csv"
$summary | Export-Csv -Path $reportPath -NoTypeInformation -Encoding UTF8

Write-Host ""
Write-Host ("Report saved to: " + $reportPath) -ForegroundColor Green
Write-Host ""
