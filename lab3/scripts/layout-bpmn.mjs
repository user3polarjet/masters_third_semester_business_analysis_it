import { readFile, writeFile } from 'node:fs/promises';
import { basename } from 'node:path';
import { layoutProcess } from 'bpmn-auto-layout';

const [, , inputPath, outputPath] = process.argv;

if (!inputPath || !outputPath) {
  console.error(`Usage: node ${basename(process.argv[1])} <input.bpmn> <output.bpmn>`);
  process.exit(1);
}

const diagramXml = await readFile(inputPath, 'utf8');
const layoutedXml = await layoutProcess(diagramXml);

await writeFile(outputPath, layoutedXml);
