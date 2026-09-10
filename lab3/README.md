# Lab 3 BPMN Workspace

This folder is a local JavaScript package environment for BPMN rendering.

## Setup

Install local tools:

```bash
npm install
```

The tools are installed into `node_modules/` inside this folder.

## Render a BPMN File

If the BPMN file already has BPMN-DI layout coordinates:

```bash
npm run render -- input.bpmn:diagram.svg
```

If the BPMN file has process semantics but no layout information:

```bash
npm run layout -- input.bpmn layouted.bpmn
npm run render -- layouted.bpmn:diagram.svg
```

`npm run layout` uses the local wrapper in `scripts/layout-bpmn.mjs`, because the installed `bpmn-auto-layout` package exposes a JavaScript API rather than a CLI binary.

If `bpmn-to-image` reports that Chrome is missing, allow Puppeteer's install script and rebuild it:

```bash
npm install-scripts approve puppeteer
npm rebuild puppeteer
```
