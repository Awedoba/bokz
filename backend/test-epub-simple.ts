import EPub from 'epub2';
console.log('Type of EPub:', typeof EPub);
if (typeof EPub === 'object') {
    console.log('Keys:', Object.keys(EPub));
}
