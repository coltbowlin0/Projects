/*=====gid event======*/
const gid_paramValue = getParameterByName('gid', window.location.href);
if (gid_paramValue !== "" && gid_paramValue !== null) {
    console.log("gid= " + gid_paramValue)
    sendEventToGA('gid', {
        value: gid_paramValue
    });
    sendEventToGA('gid_' + gid_paramValue);
}
/*=====gid event======*/
/*=====preview home page======*/
const urlParams = new URLSearchParams(window.location.search);
if (urlParams.has('preview')) {
    document.querySelectorAll('.game-item').forEach(item => {
        const index = item.getAttribute('data-index');
        if (index > 0) {
            const label = document.createElement('div');
            label.className = 'index-label';
            label.textContent = `#${index}`;
            item.appendChild(label);
        }

    });
}
/*=====preview home page======*/

/*=====click event======*/
function handleClick(element) {
    let event_value = element.getAttribute('data-event_value');
    let event_name = element.getAttribute('data-event_name');
    if (event_name === null)
        return;
    let eventParams = {
        value: event_value
    };
    console.log("event: " + event_name + "__" + event_value)
    sendEventToGA(event_name, eventParams);
    sendEventToGA(event_name + "__" + event_value);
}
/*=====click event======*/
window.addEventListener('DOMContentLoaded', function () {
  // Delegation: bắt tất cả click trên phần tử có data-event_name
  document.addEventListener('click', function (e) {
    const el = e.target.closest('[data-event_name]');
    if (!el) return;
    // gọi lại hàm hiện tại để gửi event
    // không ngăn chặn hành vi mặc định (link vẫn điều hướng)
    try {
      handleClick(el);
    } catch (err) {
      console.warn('handleClick error', err);
    }
  });
});
/*=====get param from href url======*/
function getParameterByName(name, url = window.location.href) {
    name = name.replace(/[\[\]]/g, '\\$&');
    const regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)');
    const results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}
/*=====get param from href url======*/
/*=====tracking browser======*/
window.addEventListener("DOMContentLoaded", (function () {
    const isPWA = window.matchMedia('(display-mode: standalone)').matches
        || window.navigator.standalone;
    if (isPWA) {
        sendEventToGA('detect_usage_', {
            value: 'pwa'
        });
        sendEventToGA('detect_usage_pwa');
        console.log("pwa")
    } else {
        sendEventToGA('detect_usage_', {
            value: 'browser'
        });
        sendEventToGA('detect_usage_browser');
        console.log("browser")
    }
}));
/*=====tracking browser======*/