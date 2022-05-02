# escape=`

FROM dwolla/registrator:0.4.1-0.20200107203841-4322fe00304d-6-nanoserver-1809-amd64
SHELL ["cmd", "/S", "/C"]
COPY entrypoint.bat C:/entrypoint.bat

# Running as ContainerAdministrator is needed to add routes for accessing the AWS metadata and credentials APIs.
USER ContainerAdministrator
ENTRYPOINT ["C:\\Windows\\System32\\cmd.exe", "/k", "C:\\entrypoint.bat"]