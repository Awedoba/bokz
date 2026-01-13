import fs from 'fs';
import path from 'path';

async function uploadBook() {
    const filePath = 'c:\\Users\\sever\\OneDrive\\Documents\\code\\work\\bokz\\backend\\uploads\\test_book.txt';
    const fileContent = fs.readFileSync(filePath);
    const blob = new Blob([fileContent], { type: 'text/plain' });

    const formData = new FormData();
    formData.append('file', blob, 'test_book.txt');

    try {
        // First, we need to login to get a token
        const loginResponse = await fetch('http://localhost:3001/api/auth/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                email: 'doguxyfo@mailinator.com',
                password: 'Pa$$w0rd!'
            })
        });

        if (!loginResponse.ok) {
            throw new Error(`Login failed: ${loginResponse.statusText}`);
        }

        const loginData = await loginResponse.json();
        const token = loginData.tokens.accessToken;
        console.log('Got token:', token);

        const response = await fetch('http://localhost:3001/api/books', {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`
            },
            body: formData,
        });

        if (response.ok) {
            const data = await response.json();
            console.log('Upload success:', data);
        } else {
            console.error('Upload failed:', response.status, response.statusText);
            const text = await response.text();
            console.error('Response:', text);
        }
    } catch (error) {
        console.error('Error:', error);
    }
}

uploadBook();
