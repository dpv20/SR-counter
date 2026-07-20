# AGENT.md — SR Identifier

App para detectar **SRs** (Service Requests) en los correos de Outlook y mantener un registro acumulado en CSV. Usa `ultimo.txt` como marcador de "desde cuándo buscar", de modo que cada corrida solo procesa correos nuevos.

---

## Qué hace

`buscar_sr_graph.ps1` se conecta a Outlook vía **Microsoft Graph API** (nuevo Outlook), recorre todas las carpetas de correo desde la fecha en `ultimo.txt`, extrae los números de SR (patrón `4-XXXXXXXXXX`) y actualiza los CSV.

**Sincronización entre PCs (opcional):** si usas la app desde varios computadores, corre `pull.ps1` **antes** de buscar (para traer los CSV/`ultimo.txt` más recientes) y `push.ps1` **después** (para subir los cambios). Son scripts aparte, independientes de los de búsqueda. Requieren que la carpeta sea un repo git con remoto configurado.

> También existe `buscar_sr_outlook.ps1` para el **Outlook clásico** (COM). Hace lo mismo pero contra el Outlook de escritorio en vez de Graph. El paso a paso de abajo es idéntico; solo cambia el script.

---

## Paso a paso

### 1. Abrir PowerShell en la carpeta
```powershell
cd "C:\Users\Diego Pavez\Desktop\Oracle\varios\SR identifier"
```

### 2. Traer lo último desde Git
Si trabajas desde varios computadores, sincroniza antes de buscar:
```powershell
powershell -ExecutionPolicy Bypass -File ".\pull.ps1"
```

### 3. Correr el script de búsqueda (nuevo Outlook / Graph)
```powershell
powershell -ExecutionPolicy Bypass -File ".\buscar_sr_graph.ps1"
```
(Para Outlook clásico: `.\buscar_sr_outlook.ps1`)

### 4. Autenticarse
- La primera corrida instala los módulos `Microsoft.Graph.Authentication` y `Microsoft.Graph.Mail` si faltan.
- Se pide login con **device code**: abre el navegador, ingresa el código y autoriza el permiso `Mail.Read`.
- Una vez autenticado, la sesión queda cacheada para las siguientes corridas.

### 5. El script busca automáticamente
- Lee la fecha de inicio desde `ultimo.txt` (si no existe, busca desde ayer).
- Recorre todas las carpetas y subcarpetas de correo en el rango `[ultimo.txt → ahora]`.
- Detecta SRs con los patrones `SR 4-XXXXXXXXXX` y números sueltos de 10 dígitos.

### 6. Revisar los resultados
Al terminar imprime en consola:
- Carpetas revisadas y cantidad de correos.
- Total de SRs únicos encontrados.
- **SRs NUEVOS** (los que no estaban antes en `todos_sr.csv`) marcados con `** NUEVO **` en verde.

### 7. Subir los cambios a Git
Después de buscar, sube los CSV/`ultimo.txt` actualizados:
```powershell
powershell -ExecutionPolicy Bypass -File ".\push.ps1"
```
`push.ps1` hace `add` + `commit` + `push` de `resultados_sr_outlook.csv`, `old.csv`, `todos_sr.csv` y `ultimo.txt`. Si no hubo cambios, no hace nada.

---

## Archivos que se actualizan

| Archivo | Rol | Cuándo se escribe |
|---|---|---|
| `ultimo.txt` | Marcador de fecha "desde cuándo buscar". Una sola línea `yyyy-MM-dd HH:mm:ss`. | Al final de cada corrida se guarda la fecha/hora actual. |
| `resultados_sr_outlook.csv` | Resultado de **esta** corrida. Columnas: `SR, New, Fecha, Asunto, Carpeta`. | Se sobrescribe cada corrida. |
| `old.csv` | Copia del `resultados_sr_outlook.csv` de la corrida **anterior** (backup). | Se sobrescribe con el resultado previo antes de generar el nuevo. |
| `todos_sr.csv` | Registro **histórico acumulado** de todos los SRs vistos. Columnas: `SR, PrimeraVez, Asunto`. | Se agregan solo los SR que no existían aún. |

Un SR se considera **nuevo** si no está en `todos_sr.csv`.

---

## Cómo obtener "los últimos SRs"

Los últimos SRs detectados están en **`resultados_sr_outlook.csv`** (última corrida). Los marcados con `New = true` son los que aparecieron por primera vez.

Flujo típico para conseguir los últimos valores:
1. Correr `buscar_sr_graph.ps1` (usa `ultimo.txt` como punto de partida).
2. Mirar la salida en consola o abrir `resultados_sr_outlook.csv`.
3. Filtrar `New = true` para ver solo los SR nuevos desde la última vez.

> **Importante sobre `ultimo.txt`:** define la ventana de búsqueda. Si quieres re-escanear un rango más amplio, edita `ultimo.txt` con una fecha anterior antes de correr el script. Cada corrida lo re-escribe con la hora actual, así que corridas consecutivas no repiten correos ya vistos.

---

## Notas / troubleshooting

- **PowerShell 5.1 (`EventSourceException`):** el script ya incluye el fix (`SetSwitch` de EventSource) y un fallback que verifica `Get-MgContext` aunque la conexión lance excepción.
- **No conecta a Graph:** volver a correr el script desde tu propio PowerShell para re-autenticar (`Connect-MgGraph -Scopes "Mail.Read"`).
- **Correos HTML:** el cuerpo se limpia de tags y se decodifica antes de buscar patrones, para no perder SRs incrustados en el HTML.


## Responde con los SRs en un bloque de código copiable. Formato por línea: `SR 4-XXXXXXXXXX| Fecha| Asunto`. El pipe va pegado al valor anterior (sin espacio antes) para que al hacer doble-click en el número se seleccione limpio. Marca los nuevos con ** NUEVO ** al final de la línea.