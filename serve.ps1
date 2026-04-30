$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:3000/")
$listener.Start()
Write-Host "Serving at http://localhost:3000/"
while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    $req = $ctx.Request
    $res = $ctx.Response
    $path = $req.Url.LocalPath.TrimStart('/')
    if ($path -eq "" -or $path -eq "axon_hub_app.html") {
        $file = "C:\Users\brentsmith\Documents\GitHub\axon_hub_app.html"
        $content = [System.IO.File]::ReadAllBytes($file)
        $res.ContentType = "text/html; charset=utf-8"
        $res.ContentLength64 = $content.Length
        $res.OutputStream.Write($content, 0, $content.Length)
    } else {
        $res.StatusCode = 404
    }
    $res.OutputStream.Close()
}
