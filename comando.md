cd "C:\Users\Diego Pavez\Desktop\Oracle\varios\SR identifier"

# Outlook clasico:
powershell -ExecutionPolicy Bypass -File ".\buscar_sr_outlook.ps1"

# Nuevo Outlook / Microsoft Graph:
powershell -ExecutionPolicy Bypass -File ".\buscar_sr_graph.ps1"
