# ICDTRA Website Server on Port 3000
$port = 3000
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")

try {
    $listener.Start()
    Write-Host "ICDTRA Website Server Started!" -ForegroundColor Green
    Write-Host "Server running on: http://localhost:$port" -ForegroundColor Yellow
    Write-Host "Main Page: http://localhost:$port/ICDTRA.html" -ForegroundColor Cyan
    Write-Host "Direct Access: http://localhost:$port/" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Opening ICDTRA.html in browser..." -ForegroundColor Magenta
    Start-Process "http://localhost:$port/ICDTRA.html"
    Write-Host ""
    Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Red
    Write-Host "=================================================" -ForegroundColor Magenta

    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $requestPath = $request.Url.LocalPath
        
        # Default to ICDTRA.html if accessing root
        if ($requestPath -eq "/") { 
            $requestPath = "/ICDTRA.html" 
        }
        
        $filePath = Join-Path $PWD ($requestPath.TrimStart('/') -replace '%20', ' ')
        
        Write-Host "📄 Request: $requestPath -> $([System.IO.Path]::GetFileName($filePath))" -ForegroundColor Gray
        
        if (Test-Path $filePath -PathType Leaf) {
            $content = [System.IO.File]::ReadAllBytes($filePath)
            
            # Set appropriate content type
            $extension = [System.IO.Path]::GetExtension($filePath).ToLower()
            switch ($extension) {
                ".html" { $response.ContentType = "text/html; charset=utf-8" }
                ".css"  { $response.ContentType = "text/css; charset=utf-8" }
                ".js"   { $response.ContentType = "application/javascript; charset=utf-8" }
                ".png"  { $response.ContentType = "image/png" }
                ".jpg"  { $response.ContentType = "image/jpeg" }
                ".jpeg" { $response.ContentType = "image/jpeg" }
                ".gif"  { $response.ContentType = "image/gif" }
                ".ico"  { $response.ContentType = "image/x-icon" }
                ".mp4"  { $response.ContentType = "video/mp4" }
                default { $response.ContentType = "application/octet-stream" }
            }
            
            $response.StatusCode = 200
            $response.ContentLength64 = $content.Length
            $response.OutputStream.Write($content, 0, $content.Length)
            Write-Host "✅ Served: $([System.IO.Path]::GetFileName($filePath))" -ForegroundColor Green
        } else {
            $response.StatusCode = 404
            $notFound = "404 - File Not Found: $requestPath"
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($notFound)
            $response.ContentType = "text/html; charset=utf-8"
            $response.ContentLength64 = $buffer.Length
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
            Write-Host "Not Found: $requestPath" -ForegroundColor Red
        }
        
        $response.Close()
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    if ($listener.IsListening) {
        $listener.Stop()
    }
    Write-Host "Server stopped." -ForegroundColor Yellow
}