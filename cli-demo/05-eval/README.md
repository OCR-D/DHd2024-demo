# Evaluationen mit OCR-D

In diesem Abschnitt wollen wir OCR-D Daten und Werkzeuge anwenden, um die
Erkennungsqualität einer OCR zu beurteilen.

## OCR-D Ground Truth

Wir laden dazu ein Werk, für das im Rahmen von OCR-D Ground Truth erstellt
wurde - d.h. für das wir das "perfekte", weil manuel erstellte, Ergebnis
vorliegen haben.

Wir wählen ein Beispiel aus der [OCR-D GT mit vorliegender
Transkription](https://github.com/OCR-D/gt_structure_text/releases).

Konkret `luz_blitz_1784` weil das relativ viel Text enthält und typische OCR-Probleme zeigt.

## OCRD-ZIP herunterladen

Wir kopieren den Link https://github.com/OCR-D/gt_structure_text/releases/download/v1.1.9/luz_blitz_1784.ocrd.zip
aus den Releases von https://github.com/OCR-D/gt_structure_text.

OCRD-ZIP ist ein Austauschformat auf der Basis von [BagIt](https://de.wikipedia.org/wiki/BagIt).
Im Wesentlichen handelt es sich um eine ZIP-Datei, die neben dem OCR-D Workspace
(in `/data`) auch noch Prüfsummen und andere Metadaten enthält, die aber für
diesen Anwendungsfall nicht relevant sind.

Mit `wget` laden wir das Werk herunter, mit `unzip` entpacken wir den `data`
Ordner und benennen ihn passend um:

```sh
wget https://github.com/OCR-D/gt_structure_text/releases/download/v1.1.9/luz_blitz_1784.ocrd.zip
unzip luz_blitz_1784.ocrd.zip 'data/*'
mv data luz_blitz_1784
cd luz_blitz_1784
```

## OCR mit tesseract

Wir führen wieder die basale OCR mit tesseract durch wie in den vorherigen
Demos. Da wir allerdings vorsegmentierte GT haben in der Dateigruppe
`OCR-D-GT-SEG-LINE`, verwenden wir diese Dateigruppe statt der Dateigruppe
`OCR-D-IMG`/`DEFAULLT` die nur die Bilder enthält:

```sh
> ocrd-tesserocr-recognize     \
  -m mets.xml                  \
  -l DEBUG                     \
  -I OCR-D-GT-SEG-LINE         \
  -O TESS                      \
  -P segmentation_level region \
  -P textequiv_level word      \
  -P model frak2021
```

## Visuell Vergleichen mit `browse-ocrd`

```
browse-ocrd mets.xml
```

## Evaluation mit `ocrd-cor-asv-evaluate`

Wir wollen die erstellte OCR mit der GT vergleichen, d.h. die
Zeichenfehlerrate, Wortfehlerrate und Verwechslungstabelle erheben. Dafür
verwenden wir den Prozessor `ocrd-cor-asv-ann-evaluate`, der diese
Werte pro Seite und dokumentweit erheben kann.

In diesem Fall besteht die `-I`-Eingabe-Dateigruppe aus zwei Dateigruppen,
zuerst die GT (`OCR-D-GT-SEG-LINE`), dann die OCR (`TESS`):

```
> ocrd-cor-asv-ann-evaluate   \
  -I OCR-D-GT-SEG-LINE,TESS   \
  -O EVAL                     \
  -P histogram true           \
  -P confusion 100            \
  -P metric Levenshtein
```

Wir können nun die dokumentweiten Ergebnisse in der JSON-Datei `EVAL/EVAL.json` betrachten.

(folgender Block für bessere Lesbarkeit von Verwechslungstabelle/Histogramm nachbearbeitet):

```json
{
  "TESS,OCR-D-GT-SEG-LINE": {
    "num-lines": 110,
    "num-words": 689,
    "num-chars": 4441,
    "char-error-rate-mean": 0.029497860842152668,
    "char-error-rate-varia": 0.001438307276092175,
    "word-error-rate-mean": 0.10885341074020319,
    "word-error-rate-varia": 0.02516570217367106,
    "confusion": (
      (23, ('⸗', '-')),
      (5, ('ſ', 's')),
      (3, ('b', 'd')),
      (2, ('u', 'uͤ')),
      (2, ('.', '-')),
      (2, ('N', '*')),
      (2, ('un', 'n')),
      (2, (';', ',')),
      (2, ('3', 'z')),
      (2, ('E', 'e')),
      (2, ('ü', 'uͤ')),
      (2, ('—', '-')),
      (2, (' i', 'i')),
      (1, ('g', 'z')),
      (1, ('8', 'z')),
      (1, ('üͤ', 'uͤ')),
      (1, ('n ', ' ')),
      (1, ('n', 'm')),
      (1, ('ſ', 'j')),
      (1, ('u', 'zu')),
      (1, ('V ', ' ')),
      (1, (' ', 'u')),
      (1, (' ', 's ')),
      (1, ('8', 'e')),
      (1, (' ſ', 'ſ')),
      (1, ('ri', 'i')),
      (1, ('ec', 'c')),
      (1, ('', 'ſ')),
      (1, ('ö', 'oͤ')),
      (1, ('B', 'K')),
      (1, ('U', 'u')),
      (1, ('i', 'Si')),
      (1, ('R', 'K')),
      (1, ('9', 'g')),
      (1, ('D', 'd')),
      (1, ('o', 'oͤ')),
      (1, ('X', '*')),
      (1, (' ', 'u ')),
      (1, ('u', 'i')),
      (1, ('m', 'i')),
      (1, (' ', '* ')),
      (1, ('1', '*')),
      (1, (' ', ' ')),
      (1, ('9', '*')),
      (1, ('tr', 'r')),
      (1, ('t', 'i')),
      (1, (' ', '*** ')),
      (1, ('m', 'n')),
      (1, (' ', '**')),
      (1, ('“', ' ')),
      (1, ('i', 'l')),
      (1, ('nun', 'n')),
      (1, (' ', ' *')),
      (1, ('/', ',')),
      (1, ('P', 'e')),
      (1, ('14', '4')),
      (1, ('li', 'i')),
      (1, (' ', '- ')),
      (1, ('ea', 'a')),
      (1, ('I ', ' ')),
      (1, (' ', '. ')),
      (1, ('äͤ', 'aͤ')),
      (1, ('.', 'c.')),
      (1, ('2', 'ꝛ')),
      (1, ('e', 'c')),
      (1, ('z', 'ꝛ')),
      (1, ('d', 'z')),
      (1, ('⸗', ',')),
      (1, ('Jͤ', 'J')),
      (1, ('s', 'z')),
      (1, (' N', 'N')),
      (1, (' R', 'R')),
      (1, ('8', '.')),
      (1, ('38', '8')),
      (1, (' z', 'z')),
      (1, ('O', 'n')),
      (1, ('e', 'r')),
      (1, ('ü', 'u')),
      (1, ('Uu', 'u')),
      (1, ('kt', 't')),
      (1, ('6', 'z')),
      (1, (' ', 't'))],
      120
    ),
    "histogram": {
      '': (0, 0),
      ' ': (583, 577),
      ')': (4, 6),
      '*': (0, 12),
      ',': (71, 75),
      '-': (1, 29),
      '.': (45, 45),
      '/': (1, 0),
      '1': (8, 6),
      '2': (1, 0),
      '3': (3, 0),
      '4': (2, 2),
      '6': (2, 1),
      '7': (2, 2),
      '8': (5, 2),
      '9': (2, 0),
      ';': (15, 12),
      'A': (7, 7),
      'B': (17, 16),
      'C': (13, 13),
      'D': (12, 11),
      'E': (12, 10),
      'F': (19, 19),
      'G': (20, 20),
      'H': (13, 13),
      'I': (4, 3),
      'J': (6, 6),
      'K': (14, 16),
      'L': (9, 9),
      'M': (26, 26),
      'N': (8, 6),
      'O': (6, 5),
      'P': (11, 10),
      'R': (17, 15),
      'S': (25, 26),
      'T': (3, 3),
      'U': (8, 6),
      'V': (3, 2),
      'W': (17, 17),
      'X': (1, 0),
      '': (1, 0),
      'a': (207, 208),
      'b': (59, 56),
      'c': (108, 110),
      'd': (151, 154),
      'e': (636, 636),
      'f': (41, 41),
      'g': (97, 97),
      'h': (159, 159),
      'i': (224, 226),
      'j': (3, 4),
      'k': (20, 19),
      'l': (154, 154),
      'm': (80, 79),
      'n': (358, 357),
      'o': (85, 86),
      'p': (12, 12),
      'r': (297, 297),
      's': (43, 48),
      't': (204, 203),
      'u': (177, 180),
      'v': (23, 23),
      'w': (33, 33),
      'x': (3, 2),
      'y': (5, 5),
      'z': (43, 50),
      '·': (1, 0),
      'ß': (21, 21),
      'ä': (1, 0),
      'ö': (2, 0),
      'ü': (4, 0),
      'ſ': (129, 124),
      'ͤ': (41, 46),
      '—': (2, 0),
      '“': (1, 0),
      '⸗': (24, 0),
      'ꝛ': (0, 2)
    }
  }
}

```
