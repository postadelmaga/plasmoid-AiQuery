#!/bin/bash

# Creazione del file .plasmoid
echo "Creazione di org.kde.plasma.geminiquery.plasmoid..."

zip -r org.kde.plasma.geminiquery.plasmoid org.kde.plasma.geminiquery/ \
  -x "org.kde.plasma.geminiquery/.git/*"

# Verifica che il file sia stato creato
if [ -f "org.kde.plasma.geminiquery.plasmoid" ]; then
    echo "✓ File org.kde.plasma.geminiquery.plasmoid creato con successo!"
else
    echo "✗ Errore nella creazione del file .plasmoid"
    exit 1
fi