const express = require('express');
const { exec } = require('child_process'); // Allows running shell commands

const app = express();
const PORT = 3000;

// This endpoint is vulnerable to Command Injection
app.get('/file-details', (req, res) => {
    // User provides a filename, e.g., /file-details?filename=test.txt
    const filename = req.query.filename;

    // DANGEROUS: The user-provided filename is put directly into a shell command.
    // An attacker could provide input like "test.txt; rm -rf /" to run other commands.
    const command = `ls -l ${filename}`;

    exec(command, (error, stdout, stderr) => {
        if (error) {
            return res.status(500).send(`Error: ${stderr}`);
        }
        res.send(`<pre>${stdout}</pre>`);
    });
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
