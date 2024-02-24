# Konvertieren nach TEI

Wie in der
[Einführung](https://docs.google.com/presentation/d/1aZ6hxMBuA5eICvaRU-7WxPIEVA-XqDJmOIEi8WWhUhc/edit#slide=id.g2bb8e35bdb2_0_16)
angesprochen, gibt es keinen perfekten Weg von OCR zur Digitalen Edition in TEI.

Da dies aber ein häufiges Desiderat ist, hier eine Demonstration wie wir aus
PAGE-XML zumindest ein basales TEI produzieren können als Arbeitsgrundlage für
weitere Schritte.

Wir verwenden dafür ein XSLT-Skript von Dario Kampkaspar und Matthias Boenig, das
auf GitHub verfügbar ist:

```sh
git clone https://github.com/tboenig/page2tei
```

Zudem müssen wir Saxon, eine XSLT Engine, herunterladen

```sh
wget https://sourceforge.net/projects/saxon/files/Saxon-HE/9.9/SaxonHE9-9-1-6J.zip
unzip SaxonHE9-9-1-6J.zip saxon9he.jar
```

Wir starten die Konvertierung, indem wir die METS-XML als Quelle angeben und
eine Datei `prinzenraub-tei.xml` als Zieldatei, sowie die Dateigruppe, die wir
als Quelle verwenden wollen als Paramter `PAGEXML` übergeben:

```sh
java -jar saxon9he.jar                      \
  -xsl:page2tei/page2tei-0.xsl              \
  -s:../03-prinzenraub/prinzenraub/mets.xml \
  -o:prinzenraub-tei.xml                    \
  PAGEprogram=OCRD                          \
  PAGEXML=CALAMARI
```
