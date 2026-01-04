import { PDFParse } from 'pdf-parse';

console.log('Type of PDFParse:', typeof PDFParse);

try {
    // Mock buffer
    const buffer = Buffer.from('test');
    console.log('PDFParse is likely the function we need');
} catch (e) {
    console.log('Error:', e);
}
