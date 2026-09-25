[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Install-Module dbatools -Scope AllUsers -Force -AllowClobber

Import-Module dbatools -Verbose

Set-DbatoolsConfig -FullName sql.connection.trustcert -Value $true -Register

#Export-DbaInstance -SqlInstance GPAWSDBMFGP001 -Path C:\temp\ -Force
