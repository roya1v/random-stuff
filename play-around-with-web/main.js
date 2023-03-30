const { createClient } = require("webdav");



// Get directory contents
const directoryItems = await client.getDirectoryContents("/");
console.log('JS loaded')

var button = document.getElementById('submit-button')

var fileSelector = document.getElementById('formFile')

button.onclick = function() {
  console.log(fileSelector.files[0])
  const client = createClient(
    "https://webdav.example.com/marie123",
    {
        username: "marie",
        password: "myS3curePa$$w0rd"
    }
);
}