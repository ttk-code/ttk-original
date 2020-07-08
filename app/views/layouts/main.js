/**
 * selectorに該当するタブを表示する
 */
const showTab = (selector) => {
  // 引数selectorの中身をコンソールで確認する
  console.log(selector);

  // 一度すべての.tabs-menu liからactiveクラスを削除する
  $('.tabs-menu li').removeClass('active');
  // .tabs-menu liのうち、selectorに該当するものにだけactiveクラスを付ける
  $(`.tabs-menu a[href="${selector}"]`)
    .parent('li')
    .addClass('active');

  // 一度すべての.tabs-content > sectionを非表示にする
  $('.tabs-content > section').hide();
  // .tabs-content > sectionのうち、selectorに該当するものだけを表示する
  $(selector).show();
};

// タブがクリックされたらコンテンツを表示
$('.tabs-menu a').on('click', (e) => {
  // hrefへのページ遷移を止める
  e.preventDefault();

  // hrefの値を受け取った後、showTab()関数に渡す。e.targetはクリックされたタブ（.tabs-menu a）を表す
  const selector = $(e.target).attr('href');
  showTab(selector);
});

// 初期状態として1番目のタブを表示
showTab('#tabs-1');