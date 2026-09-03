$file = "C:\Users\brentsmith\Downloads\axon_hub_app.html"
$port = 3000
$url = "http://localhost:$port/"

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($url)
$listener.Start()

Write-Host "Axon Hub running at $url"
Write-Host "Press Ctrl+C to stop."

Start-Process $url

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $content = [System.IO.File]::ReadAllBytes($file)
    $context.Response.ContentType = "text/html"
    $context.Response.ContentLength64 = $content.Length
    $context.Response.OutputStream.Write($content, 0, $content.Length)
    $context.Response.OutputStream.Close()
}
