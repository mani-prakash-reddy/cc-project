const dropzone = document.querySelector('.dropzone');
const fileInput = document.getElementById('file-upload');
const previewImage = document.getElementById('preview');
const predictButton = document.getElementById('predict-button');
const predictionResult = document.getElementById('prediction-result');

// handle drag and drop events
dropzone.addEventListener('dragover', (event) => {
  event.preventDefault();
  dropzone.classList.add('dragging');
});

dropzone.addEventListener('dragleave', (event) => {
  event.preventDefault();
  dropzone.classList.remove('dragging');
});

dropzone.addEventListener('drop', (event) => {
  event.preventDefault();
  const files = event.dataTransfer.files;
  if (files.length > 1) {
    alert('Please only upload one image at a time.');
    return;
  }
  handleFile(files[0]);
});

// handle file input click
fileInput.addEventListener('change', (event) => {
  const files = event.target.files;
  if (files.length > 1) {
    alert('Please only upload one image at a time.');
    return;
  }
  handleFile(files[0]);
});

// handle file upload and prediction
function handleFile(file) {
  if (!file.type.startsWith('image/')) {
    alert('Please upload an image file.');
    return;
  }

  const reader = new FileReader();
  reader.onload = (event) => {
    previewImage.src = event.target.result;
    previewImage.style.display = 'block';
  };
  reader.readAsDataURL(file);

  predictButton.addEventListener('click', (event) => {
    predictButton.disabled = true;

    const data = new FormData();
    data.append('file', file);

    fetch('http://127.0.0.1/predict', {
      method: 'POST',
      body: data,
    })
      .then((response) => response.json())
      .then((data) => {
		predictionResult.innerHTML = data['result'];
		predictButton.disabled = false;
	  });	
  });
}