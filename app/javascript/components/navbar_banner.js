import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('#banner-typed-text', {
    strings: ["a cocktail!", "a good sip!", "love!"],
    typeSpeed: 30,
    loop: true
  });
}

export { loadDynamicBannerText };
