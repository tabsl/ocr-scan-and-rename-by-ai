# Dateien mit OCR auslesen und Dateinamen anhand KI umbennen

Dieses Script ermöglicht das Auslesen (PDF/JPG/PNG) von Text mittels OCR. Dieser Text wird an eine lokale KI gesendet und aufbereitert. Danach wird (im besten Fall ;-)) ein sinnvoller Dateiname zurückgegeben. Abschließend wir die Datei umbennant und in den `done`-Order verschoben.

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


---


# Read files with OCR and rename using AI

This script enables reading text (PDF/JPG/PNG) using OCR. The text is sent to a local AI and processed. Then, in the best case ;-), a meaningful filename is returned. Finally, the file is renamed and moved to the `done` folder.

## Application
Run `./scan.sh .` (the parameter specifies the directory from which the files should be read)

```
./scan 11-11-2023 0002 35.pdf
Starting OCR detection ...
OCR successful
Starting AI request ...
Continental Insurance Increase ( ContinentalVersicherung_Erhöhung.txt )
'./scan 11-11-2023 0002 35.pdf' was successfully renamed to './done/Continental Insurance Increase.pdf' and moved

./scan 11-11-2023 0002 7.pdf
Starting OCR detection ...
OCR successful
Starting AI request ...
Data Protection Declaration Financial Advisor ( Datenschutzerklärung_Finanzberater.txt )
'./scan 11-11-2023 0002 7.pdf' was successfully renamed to './done/Data Protection Declaration Financial Advisor.pdf' and moved

...
```

## Installation (macOS)
1. Clone repo: `git clone https://github.com/tabsl/ocr-scan-and-rename-by-ai.git`
2. Install Homebrew: https://brew.sh
3. Install Poppler: `brew install poppler`
4. Install Tesseract: `brew install tesseract`
5. Install Tesseract DE language pack: `brew install tesseract-lang`
6. Install LM-Studio: https://lmstudio.ai
7. Download LLM via LM-Studio: https://huggingface.co/TheBloke/vicuna-13B-v1.5-16K-GGUF/blob/main/vicuna-13b-v1.5-16k.Q4_K_M.gguf

## Configuration
1. `chmod +x ./scan.sh`
2. Start LM-Studio (Local Inference Server) with the respective LLM
