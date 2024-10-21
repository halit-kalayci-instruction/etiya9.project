@echo off
chcp 65001>nul

setlocal enabledelayedexpansion

echo Mevcut container'lar durduruluyor...
podman compose -f podman-compose.yml down >nul 2>&1

set /p arg="Lütfen bir argüman girin: Eğer yeni değişiklikler varsa 1, kod hala aynı ise 2 giriniz: "

if "%arg%"=="1" (
    echo "Yeni değişiklikler uygulanarak sistem ayağa kaldırılıyor.. lütfen bekleyiniz.."
    podman compose -f podman-compose.yml up --build -d >nul 2>&1
    echo.
    echo "İşlem tamamlandı. Port bilgileri çekiliyor, lütfen bekleyiniz..."
    goto :check_ports
)

if "%arg%"=="2" (
    echo "Sistem ayağa kaldırılıyor.. lütfen bekleyiniz.."
    podman compose -f podman-compose.yml up -d >nul 2>&1
    echo.
    echo "İşlem tamamlandı. Port bilgileri çekiliyor, lütfen bekleyiniz..."
    goto :check_ports
)

echo "Geçersiz argüman. Lütfen 1 veya 2 girin."
pause
exit /b 1

:check_ports
:: Container'ların başlaması için bir bekleme süresi (gerekirse ayarlayın)
timeout /t 5 /nobreak >nul

:: Frontend ve backend portlarını dinamik olarak alıyoruz
for /f "tokens=2 delims=: " %%a in ('podman ps --filter "name=front" --format "{{.Ports}}"') do (
    for /f "tokens=1 delims=->" %%b in ("%%a") do set FRONTEND_PORT=%%b
)

for /f "tokens=2 delims=: " %%a in ('podman ps --filter "name=gateway" --format "{{.Ports}}"') do (
    for /f "tokens=1 delims=->" %%b in ("%%a") do set BACKEND_PORT=%%b
)

:: Eğer portlar boşsa hata ile karşılaşmamak için bir kontrol yapıyoruz
if "%FRONTEND_PORT%"=="" (
    echo "Frontend portu bulunamadı."
    exit /b 1
)

if "%BACKEND_PORT%"=="" (
    echo "Backend gateway portu bulunamadı."
    exit /b 1
)
:: Port bilgilerini ekrana renkli olarak yazdırıyoruz
powershell -Command "& {Write-Host 'Frontend portu: %FRONTEND_PORT%' -ForegroundColor Red}"
powershell -Command "& {Write-Host 'Backend gateway portu: %BACKEND_PORT%' -ForegroundColor Green}"

powershell -Command "& {Write-Host 'Frontend : http://localhost:%FRONTEND_PORT%' -ForegroundColor Red}"
powershell -Command "& {Write-Host 'Backend : http://localhost:%BACKEND_PORT%/swagger-ui/index.html' -ForegroundColor Green}"


pause
exit /b 0
