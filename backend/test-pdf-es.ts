import pdf from 'pdf-parse';
import * as pdfStar from 'pdf-parse';

console.log('Default Import Type:', typeof pdf);
console.log('Star Import Type:', typeof pdfStar);
console.log('Default Import:', pdf);
console.log('Star Import Keys:', Object.keys(pdfStar));

try {
    if (typeof pdf === 'function') {
        console.log('Default import IS A FUNCTION');
    }
    if (typeof pdfStar === 'function') {
        console.log('Star import IS A FUNCTION');
    }
    if (typeof pdfStar.default === 'function') {
        console.log('Star.default IS A FUNCTION');
    }
} catch (e) {
    console.log(e);
}
