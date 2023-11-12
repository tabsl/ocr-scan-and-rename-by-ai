# OCR scan and rename by AI

Dieses Script ermöglicht das Auslesen (PDF/JPG/PNG) von Text mittels OCR. Diese Informationen werden an eine lokale KI gesendet, aufbereiter und es wird ein "sinnvoller" Dateinamen zurückgegeben. Anschließend wir die Datei entsprechend umbennant und in einen extra Order verschoben.

## Anwendung
`./scan.sh .` ausführen (Parameter gibt Verzeichnis an, aus welchem die Dateien eingelesen werden sollen)

```
./scan 11-11-2023 0002 35.pdf
Starte OCR-Erkennung ...
OCR erfolgreich
Starte KI-Anfrage ...
Continentale Versicherung Erhöhung ( ContinentaleVersicherung\_Erhöhung.txt )
'./scan 11-11-2023 0002 35.pdf' wurde erfolgreich zu './done/Continentale Versicherung Erhöhung.pdf' umbenannt und verschoben

./scan 11-11-2023 0002 7.pdf
Starte OCR-Erkennung ...
OCR erfolgreich
Starte KI-Anfrage ...
Datenschutzerklärung Finanzberater ( Datenschutzerklärung\_Finanzberater.txt )
'./scan 11-11-2023 0002 7.pdf' wurde erfolgreich zu './done/Datenschutzerklärung Finanzberater.pdf' umbenannt und verschoben

...
```

## Installation (macOS)
1. Repo klonen: `git clone https://github.com/tabsl/ocr-scan-and-rename-by-ai.git`
1. Homebrew installieren: https://brew.sh
2. Poppler installieren: `brew install poppler`
3. Tesseract installieren: `brew install tesseract`
4. Tesseract DE-Langpack installieren: `brew install tesseract-lang `
5. LM-Studio installieren: https://lmstudio.ai
6. LLM über LM-Sudio downloaden: https://huggingface.co/TheBloke/vicuna-13B-v1.5-16K-GGUF/blob/main/vicuna-13b-v1.5-16k.Q4_K_M.gguf

## Konfiguration
1. `chmod +x ./scan.sh`
2. LM-Studio (Local Inference Server) mit entsprechendem LLM starten
