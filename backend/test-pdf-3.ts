import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const pdf = require('pdf-parse');

if (typeof pdf.default === 'function') {
    console.log('YES_DEFAULT_IS_FUNCTION');
} else {
    console.log('NO_DEFAULT_IS_NOT_FUNCTION');
    console.log('Type of default:', typeof pdf.default);
}
