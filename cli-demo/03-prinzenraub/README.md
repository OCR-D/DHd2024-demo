# Komplexere Workflows auf Prinzenraub-Beispiel

Im Folgenden wollen wir auf denselben Daten wie in den [folgenden Präsentationen von
OCR4all und eScriptorium](https://cloud.bib.uni-mannheim.de/s/Cz4FRpHAZiZiF37) arbeiten, speziell
dem Beispiel "01_Prinzenraub".

Wir wollen zwei Workflows durchführen, einmal denselben minimalen
tesseract-Workflow wie [in der vorherigen Demo](../02-tesseract) und einen
mit der tesseract-Segmentierung aber Erkennung durch Calamari (wie in ocr4all), bzw.
kraken (wie in eScriptorium).

Anschlließend wollen wir die Ergebnisse in `browse-ocrd` vergleichen.

## `ocrd process` Workflow Engine

Statt die Prozessoren direkt aufzurufen, verwenden wir die `ocrd process`
Workflow-Engine. Damit ist es möglich, eine Sequenz von Prozessor-Aufrufen
zu bündeln. `ocrd process` stellt sicher, dass die Verknüpfungen der Ein- und
Ausgabe-Dateigruppen konsistent ist und kann optional Speicherverbrauch und
Prozessierungszeiten messen.

## tesseract in `ocrd process`

Mit `ocrd process` sieht der Prozessor-Aufruf so aus:

```sh
ocrd process -l DEBUG -m prinzenraub/mets.xml                                                                       \
  "tesserocr-recognize -I OCR-D-IMG -O TESS -P segmentation_level region -P textequiv_level word -P model frak2021"
```

Da `-m/--mets` für alle Prozessorenaufrufe gleich ist, muss es nicht jedes mal angegeben werden. Zudem lassen wir
das beginnenden `ocrd-` weg, da auch das bei allen Prozesoren gleich ist.

**TIP**: Die Dateigruppe mit den Bildern heisst in diesem Beispiel `OCR-D-IMG` nicht `DEFAULT`

## calamari-workflow

**TIP**: Herunterladen des Modells für calamari mit `ocrd resmgr download ocrd-calamari-recognize qurator-gt4histocr-1.0`
**TIP**: Herunterladen des Modells für kraken mit `ocrd resmgr download ocrd-kraken-recognize digitue.mlmodel`

```sh
ocrd process -l DEBUG -m prinzenraub/mets.xml                                           \
  "tesserocr-segment  -I OCR-D-IMG -O OCR-D-SEG -P shrink_polygons true"                \
  "kraken-recognize   -I OCR-D-SEG -O KRAKEN  -P model digitue.mlmodel"               \
  "calamari-recognize -I OCR-D-SEG -O CALAMARI  -P checkpoint_dir  qurator-gt4histocr-1.0"
```

Wir verwenden:

* `ocrd-tesserocr-segment` Segmentierung mit tesseract, Bounding Boxes werden zu Polygonen umgerechnet
* `ocrd-kraken-recognize` Erkennung mit kraken und dem `digitue` Model
* `ocrd-calamari-recognize` um Texterkennung mit der Calamari Engine und dem `qurator-gt4histocr-1.0` Modell durchzuführen

Wenn beide Workflows durchgelaufen sind, finden wir die Endergebnisse in den Dateigruppen `TESS`, `KRAKEN` und `CALAMARI`.

Wir können wieder mit `browse-ocrd` vergleichen:
