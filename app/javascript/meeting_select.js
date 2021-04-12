function list_select(meetingRecordSelected) {

  const meetingRecordAll = document.querySelectorAll('.meeting-record');

  meetingRecordAll.forEach(function(meetingRecord){
    meetingRecord.classList.remove('selected'); //一旦全てのmeetingRecordから、selectedを外す
    meetingRecordSelected.classList.add('selected'); //選択（クリック）したmeetingRecordにのみ、selectedを付与する
  })
  return meetingRecordSelected.getAttribute('id').replace('meeting-id-','').replace('transcript-id-',''); //選択（クリック）したRecordのid取得
}

function button_activate(target, targetlink, recordId, act) {

  const editBtn = document.getElementById('edit-btn');
  const deleteMeetingBtn = document.getElementById('delete-btn');
  const accessPermitBtn = document.getElementById('access-permit-btn');
  const showMeetingBtn = document.getElementById('show-meeting-btn');
  const showTranscriptBtn = document.getElementById('show-transcript-btn');
  const deleteTranscriptBtn = document.getElementById('delete-transcript-btn');
  //act == 1で活性化、0で不活性化
  if(act == 1){
    target.classList.remove('disabled');
    targetlink.removeAttribute("href");
    if(target == editBtn) {
      targetlink.setAttribute("href", `/meetings/${recordId}/edit`);
    }else if(target == deleteMeetingBtn) {
      targetlink.setAttribute('href', `/meetings/${recordId}`);
    }else if(target == accessPermitBtn) {
      targetlink.setAttribute('href', `/meetings/${recordId}/access_permits`);
    }else if(target == showMeetingBtn) {
      targetlink.setAttribute("href", `/meetings/${recordId}`);
    }else if(target == showTranscriptBtn) {
      targetlink.setAttribute("href", `/transcripts/${recordId}`);
    }else if(target == deleteTranscriptBtn) {
      targetlink.setAttribute("href", `/transcripts/${recordId}`);
    };
  }else{
    target.classList.add('disabled');
    targetlink.removeAttribute("href");
  };
}

function meetingSelect() {

  const meetingRecordCreate = document.querySelectorAll('.meeting-record-create');
  const meetingRecordShow = document.querySelectorAll('.meeting-record-show');
  const transcriptRecord = document.querySelectorAll('.transcript-record');
  const editBtn = document.getElementById('edit-btn');
  const editBtnLink = document.getElementById('edit_btn_link');
  const deleteMeetingBtn = document.getElementById('delete-btn');
  const deleteMeetingBtnLink = document.getElementById('delete_btn_link');
  const accessPermitBtn = document.getElementById('access-permit-btn');
  const accessPermitBtnLink = document.getElementById('access_permit_btn_link');
  const showMeetingBtn = document.getElementById('show-meeting-btn');
  const showMeetingBtnLink = document.getElementById('show_meeting_btn_link');
  const showTranscriptBtn = document.getElementById('show-transcript-btn');
  const showTranscriptBtnLink = document.getElementById('show_transcript_btn_link');
  const deleteTranscriptBtn = document.getElementById('delete-transcript-btn');
  const deleteTranscriptBtnLink = document.getElementById('delete_transcript_btn_link');

  //自分が作成した議事録を選択した場合
  meetingRecordCreate.forEach(function(meetingRecordSelected){
    meetingRecordSelected.addEventListener('click', function(){
      let recordId = list_select(meetingRecordSelected);
      //議事録:編集、削除、共有設定、閲覧ボタンが活性化
      button_activate(editBtn, editBtnLink, recordId, 1);
      button_activate(deleteMeetingBtn, deleteMeetingBtnLink, recordId, 1);
      button_activate(accessPermitBtn, accessPermitBtnLink, recordId, 1);
      button_activate(showMeetingBtn, showMeetingBtnLink, recordId, 1);
      //文字起こしデータ:閲覧、削除ボタンが不活性化
      button_activate(showTranscriptBtn, showTranscriptBtnLink, recordId, 0);
      button_activate(deleteTranscriptBtn, deleteTranscriptBtnLink, recordId, 0);
    })
  })

  //閲覧許可された議事録を選択した場合
  meetingRecordShow.forEach(function(meetingRecordSelected){
    meetingRecordSelected.addEventListener('click', function(){
      let recordId = list_select(meetingRecordSelected);
      //議事録:編集、削除、共有設定ボタン,文字起こしデータ:閲覧、削除ボタンが不活性化
      button_activate(editBtn, editBtnLink, recordId, 0);
      button_activate(deleteMeetingBtn, deleteMeetingBtnLink, recordId, 0);
      button_activate(accessPermitBtn, accessPermitBtnLink, recordId, 0);
      button_activate(showTranscriptBtn, showTranscriptBtnLink, recordId, 0);
      button_activate(deleteTranscriptBtn, deleteTranscriptBtnLink, recordId, 0);
      //議事録:閲覧ボタンが活性化
      button_activate(showMeetingBtn, showMeetingBtnLink, recordId, 1);
    })
  })

  //文字起こしデータを選択した場合
  transcriptRecord.forEach(function(meetingRecordSelected){
    meetingRecordSelected.addEventListener('click', function(){
      let recordId = list_select(meetingRecordSelected);
      //議事録:編集、削除、共有設定、閲覧ボタンが不活性化
      button_activate(editBtn, editBtnLink, recordId, 0);
      button_activate(deleteMeetingBtn, deleteMeetingBtnLink, recordId, 0);
      button_activate(accessPermitBtn, accessPermitBtnLink, recordId, 0);
      button_activate(showMeetingBtn, showMeetingBtnLink, recordId, 0);
      //文字起こしデータ:閲覧、削除ボタンが活性化
      button_activate(showTranscriptBtn, showTranscriptBtnLink, recordId, 1);
      button_activate(deleteTranscriptBtn, deleteTranscriptBtnLink, recordId, 1);
    })
  })
}

window.addEventListener('load', meetingSelect)