function meetingSelect() {

  const meetingRecordAll = document.querySelectorAll('.meeting-record');
  const editBtn = document.getElementById('edit-btn');
  const editBtnLink = document.getElementById('edit_btn_link');
  const deleteBtn = document.getElementById('delete-btn');
  const deleteBtnLink = document.getElementById('delete_btn_link');
  const showBtn = document.getElementById('show-btn');
  const showBtnLink = document.getElementById('show_btn_link');

  meetingRecordAll.forEach(function(meetingRecordSelected){
    meetingRecordSelected.addEventListener('click', function(){
      meetingRecordAll.forEach(function(meetingRecord){
        //一旦全てのmeetingRecordから、selectedを外す
        meetingRecord.classList.remove('selected');
        //選択（クリック）したmeetingRecordにのみ、selectedを付与する
        meetingRecordSelected.classList.add('selected');
        //選択（クリック）したmeetingRecordのid取得
        let recordId = meetingRecordSelected.getAttribute('id').replace('meeting-id-','');
        //編集、削除、閲覧ボタンが活性化
        editBtn.classList.remove('disabled');
        deleteBtn.classList.remove('disabled');
        showBtn.classList.remove('disabled');
        //編集、削除、閲覧ボタンのリンク設定
        editBtnLink.removeAttribute("href");
        editBtnLink.setAttribute("href", `/meetings/${recordId}/edit`);
        deleteBtnLink.removeAttribute("href");
        deleteBtnLink.setAttribute('href', `/meetings/${recordId}`);
        showBtnLink.removeAttribute("href");
        showBtnLink.setAttribute("href", `/meetings/${recordId}`);
      })
    })
  })
}

window.addEventListener('load', meetingSelect)