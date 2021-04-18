<# 
.NAME
    ad-ps1-csv
.DESCRIPTION
    Criacao de Usuarios via PowerShell com CSV
.EXAMPLE
    PS C:\> .\criar-usurios-ad.ps1
.NOTES
    Name: Marcos Henrique
	E-mail: marcos@100security.com.br
.LINK
    WebSite: http://www.100security.com.br
	Facebook: https://www.facebook.com/seguranca.da.informacao
	Twitter: https://twitter.com/100Security
	GitHub: https://www.github.com/100security
	Youtube: https://www.youtube.com/user/videos100security
#>

Import-Module Activedirectory

#--- Variaveis
$arquivo = "novos-usuarios.csv"
$empresa = "100SECURITY"
$site = "www.100security.com.br"
$OU = "OU=Novos Usuarios,DC=100security,DC=local"

#-- Cria os usuarios com base em um arquivo CSV

$dados = Import-csv $arquivo -Delimiter ","

foreach ($usuarios in $dados){

 New-ADUser -SamAccountName $usuarios.Usuario `
 -AccountPassword (ConvertTo-SecureString "$usuarios.Senha" -AsPlainText -Force) `
 -Name $usuarios.NomeCompleto `
 -GivenName $usuarios.Nome `
 -Surname $usuarios.Sobrenome `
 -DisplayName $usuarios.NomeCompleto `
 -EmailAddress $usuarios.Email `
 -Title $usuarios.Cargo `
 -OfficePhone $usuarios.Telefone `
 -mobile $usuarios.Celular `
 -Office $usuarios.Unidade `
 -Department $usuarios.Departamento `
 -Description $usuarios.Departamento `
 -City $usuarios.Cidade `
 -State $usuarios.Estado `
 -Company $empresa `
 -HomePage $site `
 -UserPrincipalName $usuarios.UserPrincipalName `
 -ChangePasswordAtLogon $true `
 -Enabled $true `
 -Path $OU

 #-- Adiciona os Usuarios em grupos padrao
 Add-ADGroupMember -Identity INTERNET -Members $usuarios.Usuario
 Add-ADGroupMember -Identity VPN -Members $usuarios.Usuario
 Add-ADGroupMember -Identity $usuarios.GrupoArea -Members $usuarios.Usuario
 }

#-- Cria apenas o Usuario : marcos
# New-ADUser -SamAccountName "marcos" `
# -Name "Marcos Henrique" `
# -GivenName "Marcos" `
# -Surname "Henrique" `
# -UserPrincipalName "marcos@100security.local" `
# -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd" -Force) `
# -ChangePasswordAtLogon $true `
# -Enabled $true