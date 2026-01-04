import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const pdf = require('pdf-parse');

console.log('Is pdf a function?', typeof pdf === 'function');
console.log('Is pdf.default a function?', typeof pdf.default === 'function');

if (typeof pdf.default === 'function') {
    console.log('pdf.default seems to be main function');
}

console.log('Keys:', Object.keys(pdf));
