function progress_bar() {
  
  const transcriptRecords = document.querySelectorAll('.transcript-record');
  
  transcriptRecords.forEach(function(transcriptRecord){
    let recordId = transcriptRecord.getAttribute('id').replace('transcript-id-','');
    let progressBar = document.getElementById(`progress-id-${recordId}`);
    progressBar.setAttribute("value", 20);

  })
}

window.addEventListener('load', progress_bar)