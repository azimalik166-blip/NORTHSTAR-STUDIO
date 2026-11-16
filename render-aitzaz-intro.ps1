param(
    [string] $PortraitPath = 'C:\Users\Mubasher Computer\AppData\Roaming\Code\agentSessionData\2092b6ec-2441-44be-bdcb-592dd41258dc\attachments\0d64e769-fcc9-43c5-aadd-8ffd86a5bf55\Confident Portrait with Warm Office Accents.png',
    [string] $OutputPath = (Join-Path $PSScriptRoot 'Aitzaz_Khan_Fiverr_Introduction.mp4'),
    [string] $VoiceName = 'Microsoft David Desktop'
)

$ErrorActionPreference = 'Stop'
$Width = 1920
$Height = 1080
$FramesPerScene = 219
$SceneDuration = 7.3
$TransitionDuration = 0.55
$Duration = 5 * $SceneDuration - 4 * $TransitionDuration
$TempDir = Join-Path $env:TEMP ('aitzaz-intro-' + [guid]::NewGuid().ToString('N'))

if (!(Test-Path -LiteralPath $PortraitPath)) {
    throw "Portrait image not found: $PortraitPath. Supply your own portrait with -PortraitPath."
}

$Ffmpeg = (Get-Command ffmpeg.exe -ErrorAction Stop).Source
$Ffprobe = (Get-Command ffprobe.exe -ErrorAction Stop).Source
Add-Type -AssemblyName System.Drawing

$script:Gfx = $null
$script:Bitmap = $null
$script:Ink = [System.Drawing.Color]::FromArgb(255, 242, 245, 251)
$script:Muted = [System.Drawing.Color]::FromArgb(255, 161, 174, 193)
$script:Violet = [System.Drawing.Color]::FromArgb(255, 168, 143, 255)
$script:Blue = [System.Drawing.Color]::FromArgb(255, 97, 169, 255)
$script:Coral = [System.Drawing.Color]::FromArgb(255, 248, 152, 126)

function New-Canvas([string] $Path, [int] $Variant = 0) {
    $script:Bitmap = New-Object System.Drawing.Bitmap($Width, $Height)
    $script:Gfx = [System.Drawing.Graphics]::FromImage($script:Bitmap)
    $script:Gfx.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $script:Gfx.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $script:Gfx.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $script:Gfx.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $start = [System.Drawing.Color]::FromArgb(255, 11, 18, 35)
    $finish = [System.Drawing.Color]::FromArgb(255, 26, 27, 55)
    if ($Variant -eq 1) {
        $finish = [System.Drawing.Color]::FromArgb(255, 20, 38, 71)
    } elseif ($Variant -eq 2) {
        $finish = [System.Drawing.Color]::FromArgb(255, 38, 25, 70)
    } elseif ($Variant -eq 3) {
        $finish = [System.Drawing.Color]::FromArgb(255, 18, 36, 64)
    }

    $bounds = New-Object System.Drawing.Rectangle(0, 0, $Width, $Height)
    $gradient = New-Object System.Drawing.Drawing2D.LinearGradientBrush($bounds, $start, $finish, 18.0)
    $script:Gfx.FillRectangle($gradient, $bounds)
    $gradient.Dispose()

    for ($i = 0; $i -lt 7; $i++) {
        $alpha = [int](10 - $i)
        $ringPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb($alpha, 145, 130, 244), 1.2)
        $offset = $i * 34
        $script:Gfx.DrawEllipse($ringPen, (1328 - $offset), (82 - $offset), (610 + ($i * 68)), (610 + ($i * 68)))
        $ringPen.Dispose()
    }

    for ($x = 72; $x -lt $Width; $x += 64) {
        $gridPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(9, 176, 195, 228), 1)
        $script:Gfx.DrawLine($gridPen, $x, 0, $x, $Height)
        $gridPen.Dispose()
    }

    Text-At 'AK   /   DIGITAL CRAFT' 111 64 16 $script:Muted $true
    $rulePen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(40, 190, 204, 225), 1)
    $script:Gfx.DrawLine($rulePen, 111, 111, 1809, 111)
    $rulePen.Dispose()
}

function Save-Canvas([string] $Path) {
    $script:Bitmap.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
    $script:Gfx.Dispose()
    $script:Bitmap.Dispose()
    $script:Gfx = $null
    $script:Bitmap = $null
}

function Fill-Rect([int] $X, [int] $Y, [int] $W, [int] $H, [System.Drawing.Color] $Color) {
    $brush = New-Object System.Drawing.SolidBrush($Color)
    $script:Gfx.FillRectangle($brush, $X, $Y, $W, $H)
    $brush.Dispose()
}

function Stroke-Rect([int] $X, [int] $Y, [int] $W, [int] $H, [System.Drawing.Color] $Color, [float] $Width = 1) {
    $pen = New-Object System.Drawing.Pen($Color, $Width)
    $script:Gfx.DrawRectangle($pen, $X, $Y, $W, $H)
    $pen.Dispose()
}

function Round-Rect([int] $X, [int] $Y, [int] $W, [int] $H, [int] $Radius, [System.Drawing.Color] $Color, [bool] $Outline = $false) {
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $diameter = $Radius * 2
    $path.AddArc($X, $Y, $diameter, $diameter, 180, 90)
    $path.AddArc(($X + $W - $diameter), $Y, $diameter, $diameter, 270, 90)
    $path.AddArc(($X + $W - $diameter), ($Y + $H - $diameter), $diameter, $diameter, 0, 90)
    $path.AddArc($X, ($Y + $H - $diameter), $diameter, $diameter, 90, 90)
    $path.CloseFigure()
    if ($Outline) {
        $pen = New-Object System.Drawing.Pen($Color, 2)
        $script:Gfx.DrawPath($pen, $path)
        $pen.Dispose()
    } else {
        $brush = New-Object System.Drawing.SolidBrush($Color)
        $script:Gfx.FillPath($brush, $path)
        $brush.Dispose()
    }
    $path.Dispose()
}

function Text-At([string] $Value, [int] $X, [int] $Y, [float] $Size, [System.Drawing.Color] $Color, [bool] $Bold = $false, [bool] $Monospace = $false) {
    if ($Bold) {
        $style = [System.Drawing.FontStyle]::Bold
    } else {
        $style = [System.Drawing.FontStyle]::Regular
    }
    if ($Monospace) {
        $family = New-Object System.Drawing.FontFamily('Consolas')
    } else {
        $family = New-Object System.Drawing.FontFamily('Segoe UI')
    }
    $font = New-Object System.Drawing.Font($family, $Size, $style, [System.Drawing.GraphicsUnit]::Pixel)
    $brush = New-Object System.Drawing.SolidBrush($Color)
    $layout = New-Object System.Drawing.RectangleF([float]$X, [float]$Y, 1700.0, 700.0)
    $format = New-Object System.Drawing.StringFormat
    $format.Trimming = [System.Drawing.StringTrimming]::EllipsisWord
    $script:Gfx.DrawString($Value, $font, $brush, $layout, $format)
    $format.Dispose()
    $brush.Dispose()
    $font.Dispose()
    $family.Dispose()
}

function Draw-Tag([string] $Label, [int] $X, [int] $Y, [System.Drawing.Color] $Accent) {
    $tagBackground = [System.Drawing.Color]::FromArgb(28, $Accent.R, $Accent.G, $Accent.B)
    Round-Rect $X $Y 290 39 15 $tagBackground
    $dotBrush = New-Object System.Drawing.SolidBrush($Accent)
    $script:Gfx.FillEllipse($dotBrush, ($X + 16), ($Y + 15), 8, 8)
    $dotBrush.Dispose()
    Text-At $Label ($X + 34) ($Y + 9) 15 $script:Ink $true
}

function Draw-Photo([string] $Path, [int] $X, [int] $Y, [int] $W, [int] $H) {
    $image = [System.Drawing.Image]::FromFile($Path)
    $sourceAspect = $image.Width / [double]$image.Height
    $destAspect = $W / [double]$H
    if ($sourceAspect -gt $destAspect) {
        $sourceW = [float]($image.Height * $destAspect)
        $sourceX = [float](($image.Width - $sourceW) / 2)
        $sourceRect = New-Object System.Drawing.RectangleF($sourceX, 0, $sourceW, [float]$image.Height)
    } else {
        $sourceH = [float]($image.Width / $destAspect)
        $sourceY = [float](($image.Height - $sourceH) / 2)
        $sourceRect = New-Object System.Drawing.RectangleF(0, $sourceY, [float]$image.Width, $sourceH)
    }

    $clipPath = New-Object System.Drawing.Drawing2D.GraphicsPath
    $r = 28
    $d = $r * 2
    $clipPath.AddArc($X, $Y, $d, $d, 180, 90)
    $clipPath.AddArc(($X + $W - $d), $Y, $d, $d, 270, 90)
    $clipPath.AddArc(($X + $W - $d), ($Y + $H - $d), $d, $d, 0, 90)
    $clipPath.AddArc($X, ($Y + $H - $d), $d, $d, 90, 90)
    $clipPath.CloseFigure()

    $state = $script:Gfx.Save()
    $script:Gfx.SetClip($clipPath)
    $destRect = New-Object System.Drawing.RectangleF([float]$X, [float]$Y, [float]$W, [float]$H)
    $script:Gfx.DrawImage($image, $destRect, $sourceRect, [System.Drawing.GraphicsUnit]::Pixel)
    $script:Gfx.Restore($state)

    $borderPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(104, 173, 155, 255), 3)
    $script:Gfx.DrawPath($borderPen, $clipPath)
    $borderPen.Dispose()
    $clipPath.Dispose()
    $image.Dispose()
}

function Draw-Laptop([int] $X, [int] $Y, [int] $W, [int] $H) {
    Round-Rect $X $Y $W $H 22 ([System.Drawing.Color]::FromArgb(255, 19, 26, 43)) $true
    Round-Rect ($X + 17) ($Y + 17) ($W - 34) ($H - 34) 12 ([System.Drawing.Color]::FromArgb(255, 10, 15, 28))
    Fill-Rect ($X + 17) ($Y + 17) ($W - 34) 48 ([System.Drawing.Color]::FromArgb(255, 25, 34, 53))
    foreach ($i in 0..2) {
        $dotColors = @($script:Coral, $script:Violet, $script:Blue)
        $dotBrush = New-Object System.Drawing.SolidBrush($dotColors[$i])
        $script:Gfx.FillEllipse($dotBrush, ($X + 36 + $i * 19), ($Y + 35), 8, 8)
        $dotBrush.Dispose()
    }

    Text-At 'resources/views/home.blade.php' ($X + 135) ($Y + 29) 13 $script:Muted $false $true
    Fill-Rect ($X + 18) ($Y + 66) 120 102 ([System.Drawing.Color]::FromArgb(255, 15, 21, 36))
    Text-At 'EXPLORER' ($X + 33) ($Y + 84) 12 $script:Muted $true $true
    Text-At 'app' ($X + 33) ($Y + 115) 12 $script:Blue $false $true
    Text-At 'routes' ($X + 47) ($Y + 140) 12 $script:Ink $false $true

    $lineX = $X + 170
    $lineY = $Y + 95
    for ($i = 0; $i -lt 7; $i++) {
        $lineWidth = @(210, 348, 268, 315, 188, 292, 224)[$i]
        $lineColor = if ($i % 3 -eq 0) { $script:Violet } elseif ($i % 3 -eq 1) { $script:Blue } else { $script:Muted }
        $lineBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(182, $lineColor.R, $lineColor.G, $lineColor.B))
        Round-Rect $lineX ($lineY + $i * 29) $lineWidth 9 4 ([System.Drawing.Color]::FromArgb(182, $lineColor.R, $lineColor.G, $lineColor.B))
        $lineBrush.Dispose()
    }

    $baseY = $Y + $H
    $baseLeft = $X - 34
    $baseRight = $X + $W + 34
    $baseBottomRight = $X + $W + 4
    $baseBottomLeft = $X - 4
    $baseBottomY = $baseY + 32
    $basePath = New-Object System.Drawing.Drawing2D.GraphicsPath
    [System.Drawing.Point[]]$basePoints = @(
        [System.Drawing.Point]::new($baseLeft, $baseY),
        [System.Drawing.Point]::new($baseRight, $baseY),
        [System.Drawing.Point]::new($baseBottomRight, $baseBottomY),
        [System.Drawing.Point]::new($baseBottomLeft, $baseBottomY)
    )
    $basePath.AddPolygon($basePoints)
    $baseBounds = [System.Drawing.Rectangle]::new($baseLeft, $baseY, ($W + 68), 32)
    $baseBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($baseBounds, [System.Drawing.Color]::FromArgb(255, 112, 121, 145), [System.Drawing.Color]::FromArgb(255, 50, 59, 79), 90.0)
    $script:Gfx.FillPath($baseBrush, $basePath)
    $baseBrush.Dispose()
    $basePath.Dispose()
    Round-Rect ($X + [int]($W * 0.39)) ($baseY + 5) ([int]($W * 0.22)) 4 2 ([System.Drawing.Color]::FromArgb(100, 19, 26, 43))
}

function New-MusicTrack([string] $Path, [int] $Seconds) {
    $source = @'
using System;
using System.IO;
public static class IntroMusic {
    public static void Write(string path, int seconds, int rate) {
        int frames = seconds * rate;
        using (var stream = new FileStream(path, FileMode.Create, FileAccess.Write)) {
            using (var writer = new BinaryWriter(stream)) {
                writer.Write(new char[] {'R','I','F','F'});
                writer.Write(36 + frames * 4);
                writer.Write(new char[] {'W','A','V','E'});
                writer.Write(new char[] {'f','m','t',' '});
                writer.Write(16); writer.Write((short)1); writer.Write((short)2);
                writer.Write(rate); writer.Write(rate * 4); writer.Write((short)4); writer.Write((short)16);
                writer.Write(new char[] {'d','a','t','a'}); writer.Write(frames * 4);
                double[][] chords = new double[][] {
                    new double[] {146.83, 220.00, 293.66, 369.99},
                    new double[] {116.54, 174.61, 233.08, 293.66},
                    new double[] {87.31, 130.81, 174.61, 220.00},
                    new double[] {130.81, 196.00, 261.63, 329.63}
                };
                int[] melody = new int[] {2,3,1,2, 0,2,3,1, 2,1,3,2, 1,3,2,0};
                for (int i = 0; i < frames; i++) {
                    double t = (double)i / rate;
                    int section = ((int)(t / 8.0)) % 4;
                    double inSection = t % 8.0;
                    double blend = Math.Max(0.0, Math.Min(1.0, (inSection - 6.45) / 1.55));
                    double[] current = chords[section];
                    double[] next = chords[(section + 1) % 4];
                    double pad = 0.0;
                    double[] amp = new double[] {0.25, 0.15, 0.115, 0.065};
                    for (int n = 0; n < 4; n++) {
                        double f1 = current[n];
                        double f2 = next[n];
                        double phase1 = 2.0 * Math.PI * f1 * t;
                        double phase2 = 2.0 * Math.PI * f2 * t;
                        pad += amp[n] * ((1.0 - blend) * Math.Sin(phase1) + blend * Math.Sin(phase2));
                        pad += amp[n] * 0.18 * Math.Sin(2.0 * Math.PI * (f1 * 2.003) * t);
                    }
                    double beat = t % 1.25;
                    int note = melody[((int)(t / 1.25)) % melody.Length];
                    double pluck = Math.Exp(-beat * 2.65) * 0.065 *
                        (Math.Sin(2.0 * Math.PI * current[note] * 2.0 * t) +
                         0.28 * Math.Sin(2.0 * Math.PI * current[note] * 4.01 * t));
                    double pulse = 0.83 + 0.17 * Math.Sin(2.0 * Math.PI * t / 5.0);
                    double fadeIn = Math.Min(1.0, t / 1.4);
                    double fadeOut = Math.Min(1.0, (seconds - t) / 2.0);
                    double value = Math.Max(-0.88, Math.Min(0.88, (pad + pluck) * pulse * fadeIn * fadeOut * 0.32));
                    short sample = (short)(value * 32767.0);
                    writer.Write(sample);
                    writer.Write((short)(sample * 0.97));
                }
            }
        }
    }
}
'@
    Add-Type -TypeDefinition $source
    [IntroMusic]::Write($Path, $Seconds, 48000)
}

function New-VoiceTrack([string] $Path) {
    Add-Type -AssemblyName System.Speech
    $synthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer

    try {
        $voice = $synthesizer.GetInstalledVoices() |
            Where-Object { $_.VoiceInfo.Name -eq $VoiceName } |
            Select-Object -First 1

        if (!$voice) {
            $availableVoices = ($synthesizer.GetInstalledVoices() | ForEach-Object { $_.VoiceInfo.Name }) -join ', '
            throw "Narration voice '$VoiceName' is not installed. Available voices: $availableVoices."
        }

        $narration = "Hello everyone! My name is Aitzaz Khan, and I'm a PHP and Laravel Developer. " +
            'I specialize in creating modern, responsive, and user-friendly websites. ' +
            'I work with PHP, Laravel, MySQL, HTML, CSS, JavaScript, and Bootstrap. ' +
            "Whether you need a custom website, responsive design, database integration, or website improvements, I'm here to help. " +
            'I believe in clean code, quality work, and clear communication. ' +
            "Let's turn your ideas into reality. Thank you for visiting my Fiverr profile!"

        $synthesizer.SelectVoice($VoiceName)
        $synthesizer.Rate = 2
        $synthesizer.SetOutputToWaveFile($Path)
        $synthesizer.Speak($narration)
    } finally {
        $synthesizer.Dispose()
    }
}

function Invoke-Encoder([string[]] $Arguments, [string] $Step) {
    & $Ffmpeg @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "FFmpeg failed while $Step (exit code $LASTEXITCODE)."
    }
}

New-Item -ItemType Directory -Path $TempDir | Out-Null
try {
    $images = @()
    for ($i = 0; $i -lt 5; $i++) {
        $images += Join-Path $TempDir ("scene-{0}.png" -f $i)
    }

    # Scene 1: a restrained code editor vignette alongside the supplied portrait.
    New-Canvas $images[0] 0
    Draw-Tag 'PERSONAL INTRODUCTION' 116 153 $script:Violet
    Text-At "Hi, I'm" 115 236 70 $script:Ink $false
    Text-At 'Aitzaz Khan' 108 325 111 $script:Ink $true
    Fill-Rect 116 484 96 5 $script:Coral
    Text-At 'PHP & LARAVEL DEVELOPER' 116 528 25 $script:Violet $true
    Text-At 'Thoughtful code. Polished digital experiences.' 116 590 23 $script:Muted $false
    Draw-Laptop 866 677 526 286
    Draw-Photo $PortraitPath 1511 261 263 337
    Text-At 'A thoughtful approach to every build.' 1473 638 16 $script:Muted $false
    Save-Canvas $images[0]

    # Scene 2: responsive concept website with real-looking desktop and phone mockups.
    New-Canvas $images[1] 1
    Draw-Tag 'BUILT FOR REAL SCREENS' 116 153 $script:Blue
    Text-At 'One website.' 115 229 61 $script:Ink $true
    Text-At 'Every screen.' 115 305 61 $script:Violet $true
    Text-At 'Designed for every screen.' 119 407 22 $script:Muted

    Round-Rect 536 307 994 545 25 ([System.Drawing.Color]::FromArgb(255, 16, 23, 39))
    Round-Rect 553 324 960 507 12 ([System.Drawing.Color]::FromArgb(255, 250, 249, 246))
    Fill-Rect 553 324 960 38 ([System.Drawing.Color]::FromArgb(255, 235, 237, 242))
    foreach ($i in 0..2) {
        $dotColors = @($script:Coral, $script:Violet, $script:Blue)
        $dotBrush = New-Object System.Drawing.SolidBrush($dotColors[$i])
        $script:Gfx.FillEllipse($dotBrush, (571 + $i * 17), 338, 8, 8)
        $dotBrush.Dispose()
    }
    Round-Rect 658 334 521 20 9 ([System.Drawing.Color]::FromArgb(255, 221, 224, 232))

    Fill-Rect 554 363 958 69 ([System.Drawing.Color]::FromArgb(255, 255, 255, 255))
    Text-At 'FORM & FUNCTION' 591 386 17 ([System.Drawing.Color]::FromArgb(255, 28, 42, 63)) $true
    Text-At 'STUDIO     ABOUT     SERVICES     CONTACT' 1092 388 12 ([System.Drawing.Color]::FromArgb(255, 77, 89, 107)) $true
    Fill-Rect 554 432 958 328 ([System.Drawing.Color]::FromArgb(255, 239, 237, 229))
    Text-At 'DESIGN WITH' 627 504 19 ([System.Drawing.Color]::FromArgb(255, 88, 98, 109)) $true
    Text-At 'purpose.' 622 537 67 ([System.Drawing.Color]::FromArgb(255, 28, 42, 63)) $true
    Text-At 'A thoughtful digital home for a brand with a point of view.' 630 630 17 ([System.Drawing.Color]::FromArgb(255, 82, 91, 100))
    Round-Rect 629 680 178 46 3 ([System.Drawing.Color]::FromArgb(255, 30, 48, 73))
    Text-At 'EXPLORE THE STUDIO' 648 694 12 $script:Ink $true
    Fill-Rect 1208 468 246 259 ([System.Drawing.Color]::FromArgb(255, 200, 190, 168))
    Round-Rect 1231 486 198 220 2 ([System.Drawing.Color]::FromArgb(255, 181, 169, 147))
    Fill-Rect 1261 516 139 16 ([System.Drawing.Color]::FromArgb(122, 240, 233, 213))
    Fill-Rect 1261 547 102 11 ([System.Drawing.Color]::FromArgb(120, 239, 231, 211))
    Round-Rect 1261 604 100 30 2 ([System.Drawing.Color]::FromArgb(255, 43, 58, 68))

    $base = New-Object System.Drawing.Drawing2D.LinearGradientBrush((New-Object System.Drawing.Rectangle(490, 853, 1065, 39)), [System.Drawing.Color]::FromArgb(255, 111, 119, 139), [System.Drawing.Color]::FromArgb(255, 50, 59, 77), 90.0)
    $script:Gfx.FillPolygon($base, @(
        (New-Object System.Drawing.Point(490, 853)),
        (New-Object System.Drawing.Point(1572, 853)),
        (New-Object System.Drawing.Point(1515, 878)),
        (New-Object System.Drawing.Point(546, 878))
    ))
    $base.Dispose()
    Round-Rect 1309 502 208 424 28 ([System.Drawing.Color]::FromArgb(255, 13, 17, 26))
    Round-Rect 1319 515 188 396 20 ([System.Drawing.Color]::FromArgb(255, 246, 245, 239))
    Round-Rect 1370 519 88 17 8 ([System.Drawing.Color]::FromArgb(255, 13, 17, 26))
    Text-At 'F&F' 1340 569 15 ([System.Drawing.Color]::FromArgb(255, 38, 50, 67)) $true
    Fill-Rect 1338 609 149 130 ([System.Drawing.Color]::FromArgb(255, 233, 226, 212))
    Text-At 'Good ideas.' 1338 762 20 ([System.Drawing.Color]::FromArgb(255, 32, 45, 62)) $true
    Text-At 'Built with care.' 1338 789 16 ([System.Drawing.Color]::FromArgb(255, 94, 103, 113))
    Round-Rect 1338 833 101 36 2 ([System.Drawing.Color]::FromArgb(255, 38, 51, 70))
    Text-At 'DISCOVER' 1357 845 12 $script:Ink $true
    Text-At 'DESKTOP' 573 910 12 $script:Muted $true
    Text-At 'MOBILE' 1374 948 12 $script:Muted $true
    Save-Canvas $images[1]

    # Scene 3: seven accurate, individually labeled technology badges.
    New-Canvas $images[2] 2
    Draw-Tag 'TECHNOLOGY STACK' 116 153 $script:Violet
    Text-At 'The right tools.' 116 228 67 $script:Ink $true
    Text-At 'Built with intention.' 116 311 43 $script:Violet $false
    Text-At 'Modern, dependable building blocks for elegant business websites.' 119 392 21 $script:Muted

    $tech = @(
        @{Name='PHP'; Mark='php'; Color=$script:Violet; X=220; Y=504},
        @{Name='Laravel'; Mark='L'; Color=$script:Coral; X=640; Y=504},
        @{Name='MySQL'; Mark='SQL'; Color=$script:Blue; X=1060; Y=504},
        @{Name='HTML'; Mark='5'; Color=$script:Coral; X=1480; Y=504},
        @{Name='CSS'; Mark='3'; Color=$script:Blue; X=430; Y=759},
        @{Name='JavaScript'; Mark='JS'; Color=$script:Violet; X=850; Y=759},
        @{Name='Bootstrap'; Mark='B'; Color=$script:Coral; X=1270; Y=759}
    )
    foreach ($item in $tech) {
        $cardColor = [System.Drawing.Color]::FromArgb(21, $item.Color.R, $item.Color.G, $item.Color.B)
        $outlineColor = [System.Drawing.Color]::FromArgb(66, $item.Color.R, $item.Color.G, $item.Color.B)
        Round-Rect $item.X $item.Y 220 180 19 ([System.Drawing.Color]::FromArgb(220, 22, 27, 46))
        Round-Rect $item.X $item.Y 220 180 19 $outlineColor $true
        $badgeFill = [System.Drawing.Color]::FromArgb(28, $item.Color.R, $item.Color.G, $item.Color.B)
        $badgeLine = [System.Drawing.Color]::FromArgb(116, $item.Color.R, $item.Color.G, $item.Color.B)
        $badgePen = New-Object System.Drawing.Pen($badgeLine, 2)
        $badgeBrush = New-Object System.Drawing.SolidBrush($badgeFill)
        $script:Gfx.FillEllipse($badgeBrush, ($item.X + 75), ($item.Y + 19), 70, 70)
        $script:Gfx.DrawEllipse($badgePen, ($item.X + 75), ($item.Y + 19), 70, 70)
        $badgeBrush.Dispose()
        $badgePen.Dispose()
        $markSize = if ($item.Mark.Length -gt 2) { 23 } else { 31 }
        Text-At $item.Mark ($item.X + 84) ($item.Y + 36) $markSize $item.Color $true
        $nameSize = if ($item.Name.Length -gt 8) { 19 } else { 22 }
        Text-At $item.Name ($item.X + 24) ($item.Y + 112) $nameSize $script:Ink $true
        Fill-Rect ($item.X + 24) ($item.Y + 155) 172 2 ([System.Drawing.Color]::FromArgb(42, $item.Color.R, $item.Color.G, $item.Color.B))
    }
    Save-Canvas $images[2]

    # Scene 4: legible service list paired with a stylized, non-branded code window.
    New-Canvas $images[3] 3
    Draw-Tag 'WEB DEVELOPMENT' 116 153 $script:Blue
    Text-At 'Good thinking.' 116 229 58 $script:Ink $true
    Text-At 'Clean builds.' 116 298 58 $script:Violet $true
    Text-At 'Considered design. Reliable code. A clearer path to launch.' 119 381 20 $script:Muted

    Round-Rect 116 471 716 447 18 ([System.Drawing.Color]::FromArgb(255, 16, 22, 38))
    Fill-Rect 116 471 716 56 ([System.Drawing.Color]::FromArgb(255, 25, 34, 53))
    foreach ($i in 0..2) {
        $dotColors = @($script:Coral, $script:Violet, $script:Blue)
        $dotBrush = New-Object System.Drawing.SolidBrush($dotColors[$i])
        $script:Gfx.FillEllipse($dotBrush, (140 + $i * 21), 494, 9, 9)
        $dotBrush.Dispose()
    }
    Text-At 'website.blade.php' 653 488 14 $script:Muted $false $true
    $codeRows = @(
        @('01', 'Route::get', $script:Violet, 160),
        @('02', '  ->name', $script:Blue, 125),
        @('03', 'Illuminate\View\View', $script:Muted, 205),
        @('04', 'return view', $script:Coral, 145),
        @('05', 'ContactMessage::create', $script:Violet, 220),
        @('06', 'request()->validate', $script:Blue, 185),
        @('07', 'Schema::create', $script:Coral, 135),
        @('08', 'response()->redirect', $script:Muted, 208),
        @('09', 'php artisan migrate', $script:Violet, 168),
        @('10', 'Laravel. Built for your next step.', $script:Blue, 220)
    )
    for ($i = 0; $i -lt $codeRows.Count; $i++) {
        Text-At $codeRows[$i][0] 150 (555 + $i * 33) 15 ([System.Drawing.Color]::FromArgb(255, 102, 117, 139)) $false $true
        Text-At $codeRows[$i][1] 212 (555 + $i * 33) 17 $codeRows[$i][2] $false $true
        Round-Rect 520 (561 + $i * 33) $codeRows[$i][3] 7 3 ([System.Drawing.Color]::FromArgb(65, $script:Muted.R, $script:Muted.G, $script:Muted.B))
    }

    $services = @(
        @{Title='Custom Website Development'; Sub='Thoughtful, made to fit'; Mark='01'; C=$script:Violet},
        @{Title='Responsive Design'; Sub='Clear on every screen'; Mark='02'; C=$script:Blue},
        @{Title='MySQL Integration'; Sub='Data connected with care'; Mark='03'; C=$script:Coral},
        @{Title='Website Improvements'; Sub='Refine, update, improve'; Mark='04'; C=$script:Violet}
    )
    for ($i = 0; $i -lt $services.Count; $i++) {
        $rowY = 480 + $i * 120
        Round-Rect 925 $rowY 802 101 13 ([System.Drawing.Color]::FromArgb(20, 229, 235, 246))
        Round-Rect 925 $rowY 802 101 13 ([System.Drawing.Color]::FromArgb(45, 194, 205, 228)) $true
        Round-Rect 948 ($rowY + 21) 56 56 14 ([System.Drawing.Color]::FromArgb(35, $services[$i].C.R, $services[$i].C.G, $services[$i].C.B))
        Text-At $services[$i].Mark 961 ($rowY + 38) 17 $services[$i].C $true
        Text-At $services[$i].Title 1033 ($rowY + 22) 23 $script:Ink $true
        Text-At $services[$i].Sub 1035 ($rowY + 59) 15 $script:Muted
        Text-At '>' 1757 ($rowY + 35) 22 $services[$i].C $true
    }
    Save-Canvas $images[3]

    # Scene 5: understated final card with the supplied photo and clear call to action.
    New-Canvas $images[4] 0
    Draw-Tag 'LET YOUR NEXT IDEA TAKE SHAPE' 116 153 $script:Coral
    Text-At "LET'S BUILD YOUR" 113 294 75 $script:Ink $true
    Text-At 'WEBSITE TOGETHER!' 111 386 73 $script:Violet $true
    Fill-Rect 118 516 101 5 $script:Coral
    Text-At 'Aitzaz Khan' 117 574 39 $script:Ink $true
    Text-At 'PHP & Laravel Developer' 120 632 24 $script:Muted
    Text-At 'Custom websites, thoughtful design, reliable development.' 120 693 19 $script:Muted
    Draw-Photo $PortraitPath 1481 251 294 372
    Round-Rect 1454 661 351 77 13 ([System.Drawing.Color]::FromArgb(31, 154, 142, 235))
    Text-At 'VOICEOVER READY' 1481 677 16 $script:Violet $true
    Text-At 'Add your own recorded introduction.' 1481 704 13 $script:Muted
    Fill-Rect 113 898 1691 1 ([System.Drawing.Color]::FromArgb(42, 190, 204, 225))
    Text-At 'PHP  /  LARAVEL  /  MYSQL  /  WEB DESIGN' 116 925 14 $script:Muted $true
    Text-At 'PROFESSIONAL INTRODUCTION' 1490 925 14 $script:Muted $true
    Save-Canvas $images[4]

    $audio = Join-Path $TempDir 'ambient-music.wav'
    $voiceTrack = Join-Path $TempDir 'voice-over.wav'
    New-MusicTrack $audio 36
    New-VoiceTrack $voiceTrack

    $voiceDuration = [double](& $Ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $voiceTrack)
    if ($LASTEXITCODE -ne 0) {
        throw 'Could not verify the synthesized voice-over.'
    }
    if ($voiceDuration -gt ($Duration - 1.0)) {
        throw "The generated narration is too long ($([math]::Round($voiceDuration, 1)) seconds) for the video; choose a faster voice or shorten the script."
    }

    $arguments = New-Object System.Collections.Generic.List[string]
    $arguments.Add('-y')
    $arguments.Add('-hide_banner')
    for ($i = 0; $i -lt 5; $i++) {
        $arguments.Add('-loop')
        $arguments.Add('1')
        $arguments.Add('-framerate')
        $arguments.Add('30')
        $arguments.Add('-i')
        $arguments.Add($images[$i])
    }
    $arguments.Add('-i')
    $arguments.Add($audio)
    $arguments.Add('-i')
    $arguments.Add($voiceTrack)

    $graph = New-Object System.Collections.Generic.List[string]
    for ($i = 0; $i -lt 5; $i++) {
        if ($i -eq 0) {
            $zoom = "min(zoom+0.00014,1.031)"
            $horizontal = 'iw/2-(iw/zoom/2)+2*sin(on/35)'
        } elseif ($i -eq 1) {
            $zoom = '1.035-on*0.00013'
            $horizontal = 'iw/2-(iw/zoom/2)+2*sin(on/39)'
        } elseif ($i -eq 2) {
            $zoom = "min(zoom+0.00013,1.029)"
            $horizontal = 'iw/2-(iw/zoom/2)+3*sin(on/48)'
        } elseif ($i -eq 3) {
            $zoom = '1.032-on*0.00012'
            $horizontal = 'iw/2-(iw/zoom/2)+2*sin(on/42)'
        } else {
            $zoom = "min(zoom+0.00011,1.023)"
            $horizontal = 'iw/2-(iw/zoom/2)+2*sin(on/53)'
        }
        $graph.Add("[$i`:v]zoompan=z='$zoom':x='$horizontal':y='ih/2-(ih/zoom/2)':d=1:s=${Width}x${Height}:fps=30,trim=duration=${SceneDuration},setpts=PTS-STARTPTS,setsar=1[v$i]")
    }
    for ($i = 1; $i -lt 5; $i++) {
        $left = if ($i -eq 1) { 'v0' } else { "x$($i - 1)" }
        $offset = [math]::Round(($i * ($SceneDuration - $TransitionDuration)), 3)
        $graph.Add("[$left][v$i]xfade=transition=fade:duration=$TransitionDuration`:offset=$offset[x$i]")
    }
    $graph.Add("[x4]fade=t=out:st=33.25:d=1,format=yuv420p[vout]")
    $graph.Add("[5:a]atrim=duration=$Duration,asetpts=PTS-STARTPTS,afade=t=in:st=0:d=1.3,afade=t=out:st=32.25:d=2,aresample=48000[music]")
    $graph.Add("[6:a]aresample=48000,volume=1.7,afade=t=in:st=0:d=0.15[voice]")
    $graph.Add("[music][voice]amix=inputs=2:duration=first:dropout_transition=0:weights='1 1':normalize=0,alimiter=limit=0.95:level=false[aout]")

    $arguments.Add('-filter_complex')
    $arguments.Add(($graph -join ';'))
    $arguments.Add('-map')
    $arguments.Add('[vout]')
    $arguments.Add('-map')
    $arguments.Add('[aout]')
    $arguments.Add('-t')
    $arguments.Add([string]$Duration)
    $arguments.Add('-c:v')
    $arguments.Add('libx264')
    $arguments.Add('-preset')
    $arguments.Add('veryfast')
    $arguments.Add('-crf')
    $arguments.Add('21')
    $arguments.Add('-profile:v')
    $arguments.Add('high')
    $arguments.Add('-level:v')
    $arguments.Add('4.0')
    $arguments.Add('-r')
    $arguments.Add('30')
    $arguments.Add('-pix_fmt')
    $arguments.Add('yuv420p')
    $arguments.Add('-c:a')
    $arguments.Add('aac')
    $arguments.Add('-b:a')
    $arguments.Add('128k')
    $arguments.Add('-movflags')
    $arguments.Add('+faststart')
    $arguments.Add('-metadata')
    $arguments.Add('title=Aitzaz Khan | PHP & Laravel Developer')
    $arguments.Add('-metadata')
    $arguments.Add('comment=Portfolio introduction video with offline synthesized narration; voice is not a recording or clone of Aitzaz Khan.')
    $arguments.Add($OutputPath)

    Invoke-Encoder $arguments.ToArray() 'rendering the video'

    $videoInfo = & $Ffprobe -v error -select_streams v:0 -show_entries stream=codec_name,width,height,r_frame_rate -show_entries format=duration,size -of default=noprint_wrappers=1 $OutputPath
    if ($LASTEXITCODE -ne 0) {
        throw "Could not verify the rendered MP4 at $OutputPath."
    }

    $fileInfo = Get-Item -LiteralPath $OutputPath
    if ($fileInfo.Length -ge 50MB) {
        throw "The rendered MP4 exceeds the 50 MB limit ($([math]::Round($fileInfo.Length / 1MB, 2)) MB)."
    }
    Write-Output 'Intro video successfully rendered and verified.'
    Write-Output "File: $OutputPath"
    Write-Output "Size: $([math]::Round($fileInfo.Length / 1MB, 2)) MB"
    Write-Output "Duration: $([math]::Round([double]($videoInfo | Select-String 'duration=' | ForEach-Object { $_.ToString().Split('=')[1] }), 1)) seconds"
    Write-Output "Offline synthesized narration: $([math]::Round($voiceDuration, 1)) seconds ($VoiceName; not Aitzaz Khan's own recording)."
    Write-Output ($videoInfo -join [Environment]::NewLine)
} finally {
    if ($script:Gfx) { $script:Gfx.Dispose() }
    if ($script:Bitmap) { $script:Bitmap.Dispose() }
    if (Test-Path -LiteralPath $TempDir) {
        Remove-Item -LiteralPath $TempDir -Recurse -Force
    }
}
