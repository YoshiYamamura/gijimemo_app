function move(source, destination) {
  let array = new Array();
  let num = 0;
  //selectedされている要素数num、インデックスiを数える
  for(let i = 0; i < source.childElementCount; i++){
    if(source.getElementsByTagName('option')[i].selected){
      array[num] = i;
      num++;
    }
  }
  //selectedされていた要素を移動する
  for(i = 0; i < num; i++){
    let moveValue = source.children[array[i]-i];
    destination.appendChild(moveValue);
  }
  return num;
}

function set_token(XHR) {
  let token = document.getElementsByName('csrf-token').item(0).content;
  XHR.setRequestHeader('X-CSRF-Token',token);
}

function accessPermitsSelect() {

  const searchUserForm = document.getElementById('search-user-form');
  const selectBox1 = document.getElementById('s1');
  const selectBox2 = document.getElementById('s2');
  const rightBtn = document.getElementById('right-btn');
  const leftBtn = document.getElementById('left-btn');
  const submitBtn = document.getElementById('submit-btn');
  const userCount = document.getElementById('select-user-number');

  //ユーザー検索フォーム
  searchUserForm.addEventListener('keyup', function(){
    let input = this.value;
    for(let i = 0; i < selectBox1.childElementCount; i++){
      let user = selectBox1.children[i];
      if(selectBox1.getElementsByTagName('option')[i].innerHTML.match(input)){
        user.removeAttribute("style","display:none;");
      }else{
        user.setAttribute("style","display:none;");
      }
    }
  })

  //右移動ボタン
  rightBtn.addEventListener('click', function(){
    let add_user_num = move(selectBox1, selectBox2);
    userCount.innerHTML = +userCount.innerHTML + add_user_num;
  })

  //左移動ボタン
  leftBtn.addEventListener('click', function(){
    let remove_user_num = move(selectBox2, selectBox1);
    userCount.innerHTML = +userCount.innerHTML - remove_user_num;
  })

  //保存ボタン
  submitBtn.addEventListener('click', function(e){
    e.preventDefault();
    
    const formData = new FormData();
    let array = new Array();
    //selectBox2に並ぶ全ユーザーのuser_idを付ける
    for(let i = 0; i < selectBox2.childElementCount; i++){
      array[i] = selectBox2.children[i].value;
    }
    formData.append('user_id', array);
    //tokenを付けてリクエスト送信
    const XHR = new XMLHttpRequest();
    XHR.open("POST", "access_permits", true);
    set_token(XHR);
    XHR.send(formData);
    //トップページに遷移
    window.location.href = "/";
  })
}
if(document.URL.match(/access_permits/)){
  window.addEventListener('load', accessPermitsSelect)
}