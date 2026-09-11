$sifre = ConvertTo-SecureString "Ilk.Sifre2026!" -AsPlainText -Force

Import-Csv "C:\AD-Scripts\yeni-kullanicilar.csv" | ForEach-Object {
    New-ADUser `
        -Name "$($_.Ad) $($_.Soyad)" `
        -GivenName $_.Ad `
        -Surname $_.Soyad `
        -SamAccountName $_.KullaniciAdi `
        -UserPrincipalName "$($_.KullaniciAdi)@corp.local" `
        -Path "OU=Departmanlar,DC=corp,DC=local" `
        -AccountPassword $sifre `
        -ChangePasswordAtLogon $true `
        -Enabled $true

    Add-ADGroupMember -Identity $_.Departman -Members $_.KullaniciAdi

    Write-Host "Olusturuldu: $($_.KullaniciAdi) ($($_.Departman))"
}
