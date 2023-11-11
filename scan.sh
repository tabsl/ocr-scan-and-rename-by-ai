#!/bin/bash

# https://github.com/tabsl/ocr-scan-and-rename-by-ai/
# execute: /.scan.sh . (argument: directory)

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'


if [ "$#" -ne 1 ]; then
    echo -e "${RED}Verwendung: $0 <Verzeichnis>${NC}"
    exit 1
fi

DIR=$1

if [ ! -d "$DIR" ]; then
    echo -e "${RED}Das Verzeichnis '$DIR' existiert nicht.${NC}"
    exit 1
fi

DONE_DIR="$DIR/done"
mkdir -p "$DONE_DIR"

find "$DIR" -maxdepth 1 -type f \( -iname '*.pdf' -o -iname '*.jpg' -o -iname '*.png' \) | while read FILE; do
    echo -e "${BLUE}$FILE${NC}"

    OCR_TEXT=""
    echo -e "${YELLOW}Starte OCR-Erkennung ...${NC}"
    if [[ "$FILE" == *.pdf ]]; then
        pdftoppm "$FILE" "${FILE%.*}" -png -f 1 -singlefile
        IMAGE="${FILE%.*}.png"
        if [ -f "$IMAGE" ]; then
            OCR_TEXT=$(tesseract "$IMAGE" - -l deu 2>/dev/null)
            rm "$IMAGE"
        fi
    elif [[ "$FILE" == *.jpg ]] || [[ "$FILE" == *.png ]]; then
        OCR_TEXT=$(tesseract "$FILE" - -l deu 2>/dev/null)
    fi
    
    if [ -n "$OCR_TEXT" ]; then
    	#echo -e "${GREEN}$OCR_TEXT${NC}"
    	echo -e "${GREEN}OCR erfolgreich${NC}"
    	echo -e "${YELLOW}Starte KI-Anfrage ...${NC}"
        RESPONSE=$(curl -s -X POST http://localhost:1234/v1/chat/completions \
        -H "Content-Type: application/json" \
        -d @- <<EOF
{
  "messages": [ 
    { "role": "system", "content": "Generiere mir aus dem folgenden Inhalt einer Datei bitte einen dazu passenden Dateinamen, der den Inhalt der Datei möglichst kurz zusammenfasst, verwende nicht mehr als 120 Zeichen dafür." },
    { "role": "user", "content": "Hier der Dateiinhalt: $OCR_TEXT" }
  ], 
  "temperature": 0, 
  "max_tokens": -1, 
  "stream": false
}
EOF
        )

        # Überprüfe den Exit-Status von jq und verarbeite die Antwort
        CONTENT=$(echo "$RESPONSE" | jq -r '.choices[0].message.content' 2>&1)
        JQ_EXIT_CODE=$?

        if [ $JQ_EXIT_CODE -eq 0 ]; then
            if [ -z "$CONTENT" ]; then
                echo -e "${RED}Keine Daten erhalten${NC}"
                continue
            fi
            #echo -e "${YELLOW}$CONTENT${NC}"
            CLEANED_CONTENT=$(echo "$CONTENT" | sed 's/\.[a-zA-Z0-9]*//g')	# dateiendung
    		CLEANED_CONTENT=$(echo "$CLEANED_CONTENT" | sed 's/[^a-zA-Z0-9 ]/ /g' | tr -s ' ')	# sonderzeichen
    		CLEANED_CONTENT=$(echo "$CLEANED_CONTENT" | tr -s ' ')	# mehrere leerzeichen
    		CLEANED_CONTENT=$(echo "$CLEANED_CONTENT" | sed -E 's/([a-z])([A-Z])/\1 \2/g')	# leerzeichen bei wörtern einfügen
    		CLEANED_CONTENT=$(echo "$CLEANED_CONTENT" | sed 's/^ *//;s/ *$//')	# leerzeichen anfang/ende
    
            CONTENT_LENGTH=${#CLEANED_CONTENT}

            if [ $CONTENT_LENGTH -gt 15 ] && [ $CONTENT_LENGTH -lt 100 ]; then
                echo -e "${GREEN}$CLEANED_CONTENT ($CONTENT )${NC}"
                
                NEW_FILENAME="${DONE_DIR}/${CLEANED_CONTENT}.pdf"
				if mv "$FILE" "$NEW_FILENAME"; then
					echo -e "${GREEN}'$FILE' wurde erfolgreich zu '$NEW_FILENAME' umbenannt und verschoben${NC}"
				else
					echo -e "${RED}Fehler beim Umbenennen und Verschieben der Datei '${FILE}'${NC}"
				fi
                
            else
                echo -e "${RED}Ergebnis ($CONTENT_LENGTH) nicht zwischen 15 - 100 Zeichen${NC}"
            fi
        else
            echo -e "${RED}Parsen der JSON-Daten: $CONTENT${NC}" >&2
        fi
    else
        echo -e "${RED}OCR-Verarbeitung von '$FILE' fehlgeschlagen oder keine Texterkennung möglich.${NC}"
    fi
done
