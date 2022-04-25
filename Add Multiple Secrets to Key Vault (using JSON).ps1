# Open connection to Azure Account
Connect-AzAccount

# Input AZ Key Vault Name
$KV_Name = ""

# Input directory for JSON Secrets File
$JSON_Secrets_File = ".json"


# Get JSON Content from secrets file
$JSON = Get-Content -Raw -Path $JSON_Secrets_File | ConvertFrom-Json

# Write each secret from JSON File to Azure Key Vault
$JSON | Select-Object -Property secret_name, secret_value | ForEach-Object {

    # Convert the Secret to Hash Value
    $secretvalue = ConvertTo-SecureString $_.secret_value -AsPlainText -Force

    # Write Secret to Key Vault
    $secret = Set-AzKeyVaultSecret -VaultName $KV_Name -Name $_.secret_name -SecretValue $secretvalue

    Write-Host "Done - " $_.secret_name
}

Write-Host "Written All Secrets to Key Vault"