# OCR-D Demos für DHd2024

## CLI Demos

* [00 - Installation](./cli-demo/00-installation)
* [01 - METS klonen](./cli-demo/01-mets-klonen)
* [02 - Einfacher Tesseract Workflow auf loewenthal1896](./cli-demo/02-tesseract)
* [03 - Einfacher Workflow mit Tessseract, Kraken und Calamari auf Prinzenraub](./cli-demo/03-prinzenraub/)
* [04 - Rudimentäres TEI erzeugen](./cli-demo/04-tei)

## OCR-D Network Demo

[workflow.txt](workflow.txt) enthält den `ocrd process` Workflow den wir ausführen möchten:

```sh
cis-ocropy-binarize      -I OCR-D-IMG                 -O OCR-D-BINPAGE             -P dpi 300
anybaseocr-crop          -I OCR-D-BINPAGE             -O OCR-D-SEG-PAGE-ANYOCR     -P dpi 300
cis-ocropy-denoise       -I OCR-D-SEG-PAGE-ANYOCR     -O OCR-D-DENOISE-OCROPY      -P dpi 300
cis-ocropy-deskew        -I OCR-D-DENOISE-OCROPY      -O OCR-D-DESKEW-OCROPY       -P level-of-operation page
tesserocr-segment-region -I OCR-D-DESKEW-OCROPY       -O OCR-D-SEG-BLOCK-TESSERACT -P dpi 300 -P padding 5.0  -P find_tables false
segment-repair           -I OCR-D-SEG-BLOCK-TESSERACT -O OCR-D-SEGMENT-REPAIR      -P plausibilize true       -P plausibilize_merge_min_overlap 0.7
cis-ocropy-clip          -I OCR-D-SEGMENT-REPAIR      -O OCR-D-CLIP
cis-ocropy-segment       -I OCR-D-CLIP                -O OCR-D-SEGMENT-OCROPY      -P dpi 300
cis-ocropy-dewarp        -I OCR-D-SEGMENT-OCROPY      -O OCR-D-DEWARP
tesserocr-recognize      -I OCR-D-DEWARP              -O OCR-D-OCR                 -P model Fraktur
```

[clean.sh](clean.sh) setzt den Zustand der Verarbeitung zurück.

[deploy_agents_workers.sh](deploy_agents_workers.sh) Startet den OCR-D Processing Server mit der Konfiguration [ps_config_with_workers.yml](ps_config_with_workers.yml)

[send_workflow_workers.sh](send_workflow_workers.sh) Schickt den Workflow an den Server und startet die Verarbeitung.

[check_workflow_status.sh](check_workflow_status.sh) fragt den Status des Workflows ab, [check_processing_job_log.sh](check_processing_job_log.sh) fragt den Status individueller Worker ab
