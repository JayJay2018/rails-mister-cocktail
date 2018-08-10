import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('#banner-typed-text', {
    strings: ["All you need is a beer...", "Unless you can have two!"],
    typeSpeed: 50,
    loop: true
  });
}

export { loadDynamicBannerText };
