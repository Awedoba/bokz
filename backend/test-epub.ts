import EPubDefault from 'epub2';
import * as EPubStar from 'epub2';
import { createRequire } from 'module';

const require = createRequire(import.meta.url);
const EPubRequire = require('epub2');

console.log('Default Import Type:', typeof EPubDefault);
console.log('Star Import Type:', typeof EPubStar);
console.log('Require Import Type:', typeof EPubRequire);

console.log('Default Import keys:', Object.keys(EPubDefault || {}));
console.log('Star Import keys:', Object.keys(EPubStar || {}));
console.log('Require Import keys:', Object.keys(EPubRequire || {}));

if (typeof EPubDefault === 'function') {
    console.log('Default Import is likely the constructor');
} else {
    console.log('EPubDefault.EPub:', EPubDefault?.EPub);
}

if (typeof EPubRequire === 'function') {
    console.log('Require Import is likely the constructor');
} else {
    console.log('EPubRequire.EPub:', EPubRequire?.EPub);
}
