# Komplexere Workflows auf Prinzenraub-Beispiel

Im Folgenden wollen wir auf denselben Daten wie in den [folgenden Präsentationen von
OCR4all und eScriptorium](https://cloud.bib.uni-mannheim.de/s/Cz4FRpHAZiZiF37) arbeiten, speziell
dem Beispiel "01_Prinzenraub".

Wir wollen zwei Workflows durchführen, einmal denselben minimalen
tesseract-Workflow wie [in der vorherigen Demo](../02-tesseract) und einen
etwas komplexeren und realistischeren. Anschlließend wollen wir die Ergebnisse
in `browse-ocrd` vergleichen.

## `ocrd process` Workflow Engine

Statt die Prozessoren direkt aufzurufen, verwenden wir die `ocrd process`
Workflow-Engine. Damit ist es möglich, eine Sequenz von Prozessor-Aufrufen
zu bündeln. `ocrd process` stellt sicher, dass die Verknüpfungen der Ein- und
Ausgabe-Dateigruppen konsistent ist und kann optional Speicherverbrauch und
Prozessierungszeiten messen.

## tesseract in `ocrd process`

Mit `ocrd process` sieht der vorherige Prozessor-Aufruf so aus:

```sh
ocrd process -m loewenthal1896/mets.xml \
  "tesserocr-recognize -I DEFAULT -O TESS -P segmentation_level region -P textequiv_level word -P model frak2021"
```

Da `-m/--mets` für alle Prozessorenaufrufe gleich ist, muss es nicht jedes mal angegeben werden. Zudem lassen wir
das beginnenden `ocrd-` weg, da auch das bei allen Prozesoren gleich ist.

## komplexerer workflow


```sh
ocrd process \
  "cis-ocropy-binarize -I DEFAULT -O OCR-D-BIN" \
  "anybaseocr-crop -I OCR-D-BIN -O OCR-D-CROP" \
  "skimage-binarize -I OCR-D-CROP -O OCR-D-BIN2 -P method li" \
  "skimage-denoise -I OCR-D-BIN2 -O OCR-D-BIN-DENOISE -P level-of-operation page" \
  "tesserocr-deskew -I OCR-D-BIN-DENOISE -O OCR-D-BIN-DENOISE-DESKEW -P operation_level page" \
  "cis-ocropy-segment -I OCR-D-BIN-DENOISE-DESKEW -O OCR-D-SEG -P level-of-operation page" \
  "cis-ocropy-dewarp -I OCR-D-SEG -O OCR-D-SEG-LINE-RESEG-DEWARP" \
  "calamari-recognize -I OCR-D-SEG-LINE-RESEG-DEWARP -O CALAMARI -P checkpoint_dir qurator-gt4histocr-1.0"
```

Wir verwenden:

* `ocrd-cis-ocropy` Binarisierung als Grundlage für das Cropping
* `ocrd-anybaseocr-crop` zum Zurechtschneiden des Bildes
* `ocrd-skimage-binarize` zum erneuten Binarisieren auf dem gecroppten Bild
* `ocrd-skimage-denoise` zum Entfernen von "Fliegendreck" und ähnlichen Artefakten
* `ocrd-tesserocr-deskew` um das Bild geradezurücken
* `ocrd-cis-ocropy-segment` eine schnelle heuristische Segmentierung auf der Basis von ocropy
* `ocrd-cis-ocropy-dewarp` um etwaige Wellen und Verzerrungen zu normalisieren
* `ocrd-calamari-recognize` um Texterkennung mit der Calamari Engine und dem `qurator-gt4histocr-1.0` Modell durchzuführen

Wenn beide Workflows durchgelaufen sind, finden wir die Endergebnisse in den Dateigruppen `TESS` und `CALAMARI`.

Wir können wieder mit `browse-ocrd` vergleichen:


