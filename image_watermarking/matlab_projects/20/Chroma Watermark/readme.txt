Simple watermark embedding system

by Krzysztof Parobczak
Military University of Technology
Warsaw, Poland
2010

Simple and easy to use application for embedding
and extracting hidden data in images.
Application implements simple author algoritm
using least significant bits of chroma components
of image pixels for injecting watermark data.


Usage instruction:

A. RUNNING APPLICATION
1. Extract all files from archive in separate directory.
2. change current working folder in Matlab where extracted
   files are.
3. Enter 'guide' command in main Matlab window.
4. Choose "Open Existing GUI" and browse for mainform.fig file.
5. Run application.

B. EMBEDDING DATA
1. Load image (currently only fixed size of 400x300 is supported);
   sample images are provided within archive.
2. Enter text data to embed in image and click "Embed data" button

C. EXTRACTING DATA
1. Load image with embedded data (immediately after embedding, image is auto-loaded)
2. Click "Read data" button
3. Result is displayed in "Read data" text area


Limitations:

1. Currently only fixed size of images (400x300) is supported
2. Implemented algorithm isn't robust against compression;
   at future time adding error correction scheme is planned;
   meantime 2-bit or even 3-bit (quality degradating) LSB embedding
   is proposed
3. Because of manipulating chroma components, only color images
   are supported (no grayscale images or pure white for example)
4. Supported input image formats are JPG and BMP. Output images are
   generated in BMP format. Also in current working directory only!