import { EPub } from 'epub2';
console.log('Type of Named EPub:', typeof EPub);
try {
    const instance = new EPub('./test.epub');
    console.log('Instance created');
} catch (e) {
    console.log('Error creating instance:', e.message);
}
