# Einfacher OCR Workflow mit tesseract

## Prozessoren in OCR-D

Ein _Prozessor_ im Kontext von OCR-D ist eine Software, die einen oder mehrere
Schritte im OCR-Workflow abbildet und ein einheitliches, von [OCR-D
vorgegebenes Inteface](https://ocr-d.de/en/spec/cli) implementiert. Das bedeutet
dass die Aufrufe aller Prozessoren in OCR-D dem gleichen Schema folgt. Einzig
in der Parameterisierung unterscheiden sich die Aufrufe. Das bedeutet, dass wenn
man verstanden hat, wie ein Prozessor funktioniert, man alle anderen Prozessoren
mit wenig Lernaufwand ebenfalls nutzen kann.

Auch die (später [vorgestellte](https://github.com/OCR-D/DHd2024-demo)) [OCR-D
Netzwerkerweiterung](https://ocr-d.de/en/spec/web_api) "spricht" mit demselben
Interface mit den Prozessoren, d.h. ein Workflow der auf der Kommandozeile
funktioniert, kann direkt nachgenutzt werden für massenhafte Prozessierung.

## Anatomie eines Prozessor-Aufrufs

Die relevanten prozessorübergreifenden Optionen und die prozessorspezifischen
Parameter für den Aufruf eines Prozessors kann in der `--help` Ausgabe eines
Prozessors nachgelesen werden.

Die wichtigsten prozessorübergreifenden Optionen sind

* `-m` / `--mets`: Pfad zur METS-Datei aus der Daten gelesen/geschrieben werden
* `-I` / `--input-file-grp`: Die Quell-Dateigruppe in METS, aus der Daten gelesen werden
* `-O` / `--output-file-grp`: Die Ziel-Dateigruppe in METS, in die Daten geschrieben werden
* `-g` / `--page-id`: Optional eine Einschränkung auf bestimmte Seiten-ID(s)
* `-P FELD WERT`: Setzen von prozessorspezifischem Parameter `FELD` auf Wert `WERT`
* `-l LOGLEVEL`: Kann auf `DEBUG` gesetzt werden, um besser nachzuvollziehen, was der Prozessor tut

Alle Prozessoren auf der Kommandozeile haben die Form `ocrd-<PROJEKT>-<VERB>`, wobei `VERB` einen Hinweis
gibt, welche Funktion im Workflow der Prozessor innehat.

Beispiele:

* `ocrd-olena-binarize`: Binarisieren mit der OLENA Implementierung
* `ocrd-eynollah-segment`: Segmentierung mit der eynollah Implementierung
* `ocrd-tesserocr-recognize`: Texterkennung mit der tesseract Erkennung

## Verarbeitung mit tesseract

Jetzt wo wir einen Workspace mit Bildern [haben](../01-mets-klonen/README.md),
können wir einen minimalistischen OCR-Workflow starten, als Grundlage für
spätere, komplexere Workflows.

Wir verwenden dazu den `ocrd-tesserocr-recognize` Prozessor, das die
weitverbreitete Open Source OCR-Engine
[tesseract](https://github.com/tesseract-ocr/tesseract/) einbindet.

```sh
ocrd-tesserocr-recognize       \
  -m loewenthal1896/mets.xml   \
  -l DEBUG                     \
  -I DEFAULT                   \
  -O TESS                      \
  -P segmentation_level region \
  -P textequiv_level word      \
  -P model frak2021
```

Wir teilen dem Prozessor mit, wo die METS-Datei liegt, dass aus `DEFAULT`
gelesen und in `TESS` geschrieben werden soll.

Die Parameter bedeuten:

* `-P textequiv_level word`: Es soll bis auf Wortebene segmentiert und erkannt werden
* `-P segmentation_level region`: Es soll in einem Schritt von Regionen bis auf Zeilenebene segmentiert werden.
* `-P model frak2021`: Es soll das `frak2021` Modell für Frakturschrift verwendet werden

## OCR-D Resource Manager

Der erste Durchlauf schlägt fehl mit einer Fehermeldung

```
Exception: configured model frak2021 is not installed
```

Das bedeutet dass das ausgewählte Modell nicht auf der Maschine vorhanden ist. Wir müssen es mit dem OCR-D Resource Manager herunterladen:

```sh
> ocrd resmgr download ocrd-tesserocr-recognize frak2021.traineddata
[...]
... INFO ocrd.cli.resmgr - Installed resource https://ub-backup.bib.uni-mannheim.de/~stweil/tesstrain/frak2021/tessdata_best/frak2021-0.905.traineddata under /home/kba/.pyenv/versions/3.8-dev/envs/venv3.8-dev/share/tessdata/frak2021.traineddata
... INFO ocrd.cli.resmgr - Use in parameters as 'frak2021'
```

Im OCR-D Resource Manager sind eine Vielzahl von Modellen und Konfigurationen
für diverse Prozessoren verfügbar, die mit `ocrd resmgr download` installiert
werden können.

Mit `ocrd resmgr list-available` werden [alle verfügbaren Resourcen für alle Prozessoren](./resources_available.txt) ausgegeben.

Mehr Informationen zum OCR-D Resource manager über `ocrd resmgr --help` und [auf der OCR-D Website](https://ocr-d.de/en/models).

## Ergebnis

Jetzt können wir den Befehl erneut ausführen und wenn der Prozess durchgelaufen ist, sehen wir die folgenden zusätzlichen Dateien im Workspace:

```
loewenthal1896/TESS
loewenthal1896/TESS/FILE_0001_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0001_TESS.xml
loewenthal1896/TESS/FILE_0002_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0002_TESS.xml
loewenthal1896/TESS/FILE_0003_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0003_TESS.xml
loewenthal1896/TESS/FILE_0004_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0004_TESS.xml
loewenthal1896/TESS/FILE_0005_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0005_TESS.xml
loewenthal1896/TESS/FILE_0006_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0006_TESS.xml
loewenthal1896/TESS/FILE_0007_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0007_TESS.xml
loewenthal1896/TESS/FILE_0008_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0008_TESS.xml
loewenthal1896/TESS/FILE_0009_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0009_TESS.xml
loewenthal1896/TESS/FILE_0010_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0010_TESS.xml
loewenthal1896/TESS/FILE_0011_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0011_TESS.xml
loewenthal1896/TESS/FILE_0012_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0012_TESS.xml
loewenthal1896/TESS/FILE_0013_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0013_TESS.xml
loewenthal1896/TESS/FILE_0014_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0014_TESS.xml
loewenthal1896/TESS/FILE_0015_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0015_TESS.xml
loewenthal1896/TESS/FILE_0016_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0016_TESS.xml
loewenthal1896/TESS/FILE_0017_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0017_TESS.xml
loewenthal1896/TESS/FILE_0018_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0018_TESS.xml
loewenthal1896/TESS/FILE_0019_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0019_TESS.xml
loewenthal1896/TESS/FILE_0020_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0020_TESS.xml
loewenthal1896/TESS/FILE_0021_TESS.IMG-BIN.png
loewenthal1896/TESS/FILE_0021_TESS.xml
```

Es gibt eine neue Dateigruppe `TESS`, im Ordner sind für jede Seite zwei
Dateien, einemal das binarisierte Bild (`*.IMG-BIN.png`) und das Ergebnis der
Erkennung als PAGE-XML (`*.xml`)

Wir können das Ergebnis nun mit `browse-ocrd` betrachten:

```
browse-ocrd loewenthal1896/mets.xml
```
