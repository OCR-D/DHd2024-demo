# Installation von OCR-D

Die Installation von OCR-D wird detailliert im [Setup Guide](https://ocr-d.de/en/setup) beschrieben.

Grundsätzlich gilt:

* Wir empfehlen die Verwendung von
  [Docker](https://ocr-d.de/en/setup#ocrd_all-via-docker), das
  plattformübergreifend (Windows, Linux, OSX) verfügbar ist und keine
  Anpassungen am Host-System erfordert
* Die Kernkomponenten und die meisten Prozessoren funktionieren nativ in Linux
  und OSX.
* Einige Prozessoren sind aufgrund von Abhängigkeiten zu bestimmten Versionen
  von Tensorflow (einem Framework für maschinelles Lernen) mit Python maximal
  3.8 kompatibel

## OCR-D in WSL

WSL (Window Subsystem for Linux) ist eine Technologie, die Linux mehr oder
minder nahtlos in Microsoft Windows integriert.

Die Kommandozeilen- und Netzwerkschnittstellen von OCR-D sind mit WSL1 und WSL2
kompatibel. Nach dem Einrichten von WSL kann die [native
Installation](https://ocr-d.de/en/setup#ocrd_all-natively) ausgeführt werden.

`browse-ocrd` kann in WSL2 direkt [nach
Installation](https://github.com/hnesk/browse-ocrd?tab=readme-ov-file#native-tested-on-ubuntu-18042004)
ausgeführt werden.

