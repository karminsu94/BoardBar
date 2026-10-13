'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "ac37042cb7a1951ea5652f910f75243b",
"assets/AssetManifest.bin.json": "144c42dec4c04569b2b41a4fc387f8b7",
"assets/AssetManifest.json": "3b6f7dd9c886955e8c8310edbfdca1ff",
"assets/assets/audio/minus1.MP3": "300d0ccf33b917d52349fd4a7b788c7e",
"assets/assets/audio/minus5-10.MP3": "52ee2eed857187efdb726afe61210b4f",
"assets/assets/audio/plus1.MP3": "bb7f47f133c50f799e0972b63c5c98ee",
"assets/assets/audio/plus10.MP3": "63a4a40da1d981d01c8eeac2d0e73068",
"assets/assets/audio/plus5.MP3": "922926c6f4308edbd16ef2868232a153",
"assets/assets/audio/ranking.MP3": "64c6fe4cbab676fe376d41e77e73430c",
"assets/assets/audio/score.MP3": "bbac7b592aa602b033c30caa9f83873d",
"assets/assets/audio/suspense_champion.MP3": "20d9e731ff9c5b580b3efea7fd8a6c81",
"assets/assets/audio/suspense_reveal.MP3": "609762257f235ca6b38d31608664c576",
"assets/assets/audio/suspense_trophy.MP3": "79c5e4bf19110240d1cf0e793cf51f9f",
"assets/assets/audio/timeUp.MP3": "6d771175ed69db2fae67410291c092d3",
"assets/assets/fonts/BoTa-2.otf": "c19f3171dd8e865bdc043dc38be3a562",
"assets/assets/fonts/NotoSansSC.ttf": "f713f710e227c817cff301001d1bbdac",
"assets/assets/fonts/PressStart2P-Regular.ttf": "ccb1dfce06ad3883f8e3b5ae011aa795",
"assets/assets/fonts/Roboto-VariableFont_wdth,wght.ttf": "3aa911d4a1e76c8946952fe744ce7434",
"assets/assets/logo/99d4f694a6575e66d6a81c017511fbea.png": "217a53bf868d0b0f9dbefb1c682f81f5",
"assets/assets/logo/ad0ad3c52d79673039a6995559186ff9.jpg": "1cc529a062895ecb2f28c40f976726a6",
"assets/assets/logo/app_icon.png": "aa83ae936d61ac8b515c03f3df698c13",
"assets/assets/logo/black-coin.png": "cb1515fd8fe113e34373762ffc206446",
"assets/assets/logo/brick-wall-dark.png": "5c948838dd2711464c9f4e24a3eed1af",
"assets/assets/logo/coin.png": "5cb9ed34a356bd754be58b47da807664",
"assets/assets/logo/coin1.png": "39743921c2b9ca025ef1f62121ae98a6",
"assets/assets/logo/coin2.png": "69eb3809970e29d6338dd831614e0a0e",
"assets/assets/logo/coin3.png": "ad236717a8c73b879e2ed944536c86d7",
"assets/assets/logo/crossword.png": "c9e116b863ef62007232ac7da811c51b",
"assets/assets/logo/dark-stripes.png": "9eedb724e199b7906c03e751d0e2259c",
"assets/assets/logo/dog-jumping1.png": "9a09cce6139feab6b9a18ee0286cb488",
"assets/assets/logo/dog-jumping2.png": "6e81fe2ca383203a40c0e582c726047e",
"assets/assets/logo/dog-sleeping.png": "5195a527b835aac38263adc136b8ad40",
"assets/assets/logo/ic_launcher.png": "bd96d7b8654f802a4e4305ef3f2aa8d1",
"assets/assets/logo/inspiration-geometry.png": "f10544eca8100262ce520c5192b6f65e",
"assets/assets/logo/min10.png": "d7ecd7e7081045fc696df21032d349f2",
"assets/assets/logo/min5.png": "cde72e9f6098aaa3f4cd986a4ebbb9b4",
"assets/assets/logo/padded-light.png": "70cda1e0ad16a50db275a26ca5011eae",
"assets/assets/logo/paper.png": "9e0f729525da91911897687d1874ea4c",
"assets/assets/logo/plus10.png": "196142afe5f9a82866429e86777f65a0",
"assets/assets/logo/plus5.png": "445baa4f88839bfcfffb579058d42d07",
"assets/assets/logo/running.png": "1f18a1faa520b3a2c253f64b18e86beb",
"assets/assets/logo/splash_logo.png": "217a53bf868d0b0f9dbefb1c682f81f5",
"assets/assets/logo/texture-0.png": "393a12a3e496a1f80123890b036c237a",
"assets/assets/logo/texture-1.png": "53c1ec5f96d716d4265e536f7576919e",
"assets/assets/logo/texture-2.png": "cce6e706dddf31753a783f17d5bd4dcc",
"assets/assets/logo/texture-3.png": "55315f6b7dc49fb27203791d9845e421",
"assets/assets/logo/texture-4.png": "1d37222ede63a69083d2a152e44cda63",
"assets/assets/logo/texture-41.png": "a604442174bb2d4619937a6550f1449f",
"assets/assets/logo/texture-42.png": "8bb232d29f3842db4cecd54785edf256",
"assets/assets/logo/texture-5.png": "612faee9e55bd929d88d0e6e5ac86faa",
"assets/assets/logo/texture-6.png": "890e30b79544c117b443f1d0675fd269",
"assets/assets/logo/texture-7.png": "ac1839b05d92a3c9818f9063ad10098e",
"assets/assets/logo/trophy.png": "84434956868dea9d1ad6f2cd445c0575",
"assets/assets/scriptIcon/brassBirmingham-poster.jpg": "8cb79f7549f8a036d0b4eebc1ab017e2",
"assets/assets/scriptIcon/harmonies-1.png": "c028f15437874a2246623434e28e1386",
"assets/assets/scriptIcon/harmonies-2.png": "c851aa000abc438fe59ef067d5d1f142",
"assets/assets/scriptIcon/harmonies-3.png": "dd658fa0f0d69fa5c6c87e007a74c960",
"assets/assets/scriptIcon/harmonies-4.png": "8a8bc14c4330bea6ebdd9a11aca3a2b2",
"assets/assets/scriptIcon/harmonies-5.png": "b58bdb393e63c31c13f07d719bfacf76",
"assets/assets/scriptIcon/harmonies-6.png": "0b5f7fcfa1a7f101f6bb52a1b8fb052d",
"assets/assets/scriptIcon/harmonies-7.png": "4693de37a79de8f34fa15331653864ac",
"assets/assets/scriptIcon/harmonies-poster.jpg": "cbcab50a1b0a4da0f81ff670b31b4960",
"assets/assets/scriptIcon/puertoRico-1.png": "8b096a9fa9416e112c623175a358ab37",
"assets/assets/scriptIcon/puertoRico-2.png": "ca65a48e681d1f17459d20bb6917a267",
"assets/assets/scriptIcon/puertoRico-3.png": "41181b18824dd8958af2d5225f4cbf6d",
"assets/assets/scriptIcon/puertoRico-4.png": "06ada7d5dd4b661ce24214c0eeb75357",
"assets/assets/scriptIcon/puertoRico-5.png": "ffb09f6f21f69bf87c61190de197919d",
"assets/assets/scriptIcon/puertoRico-poster.jpg": "75a092febb161dfed7d2872a5a950e6f",
"assets/assets/scriptIcon/season-1.png": "e2e5a0146a1f9c5a7128ffb41887d16d",
"assets/assets/scriptIcon/season-2.png": "91c20681a237998c79c78cb0d90277d0",
"assets/assets/scriptIcon/season-3.png": "157d92431a322ff0be1e901b12170964",
"assets/assets/scriptIcon/season-4.png": "4a6c2e16811f4b0de659c5a1eedc09d2",
"assets/assets/scriptIcon/season-poster.jpg": "3d8b9db7f9aaea54a5706ce6d96151f9",
"assets/assets/scriptIcon/theWhiteCastle-1.png": "ec8716abb27f0f66540fdb27a13137fc",
"assets/assets/scriptIcon/theWhiteCastle-2.png": "2e233203084b28aacd4663bde461b1c7",
"assets/assets/scriptIcon/theWhiteCastle-3.png": "b437265e5b236afd530f3c25d64abac7",
"assets/assets/scriptIcon/theWhiteCastle-4.png": "3680a0f7a3755487dcc3641c46653384",
"assets/assets/scriptIcon/theWhiteCastle-5.png": "b4832ddaa2d774ec6cca7a0ec0c13664",
"assets/assets/scriptIcon/theWhiteCastle-6.png": "93ce08018052a290e81646d5c9ae381f",
"assets/assets/scriptIcon/theWhiteCastle-7.png": "a8ab9c29030248f66b72b095a6d051ab",
"assets/assets/scriptIcon/theWhiteCastle-8.png": "27c0ce040e7e2adf04d498c85cea08db",
"assets/assets/scriptIcon/theWhiteCastle-poster.jpg": "033d7f5a4b48201d5d4e0b6c33fc3855",
"assets/assets/translations/en.json": "48b4b7c9a9d0afeb9c49a1881145ebc0",
"assets/assets/translations/zh.json": "83ebb6712be0460b92b0cbef95ee109f",
"assets/FontManifest.json": "3ba0154d27672230a041254a7da33139",
"assets/fonts/MaterialIcons-Regular.otf": "0aa53b6d62bd96332dd47a3f60c227a7",
"assets/NOTICES": "358485b2283665d2676a7a1ac06dbec0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/pubspec.yaml": "6f2e650ce981b4b32d029f93b3560304",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "fcb4c59db7b219c0a7ee388e5b9c5a5b",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "811c968d14ae4391ae4d2ace270cc133",
"icons/Icon-192.png": "aa83ae936d61ac8b515c03f3df698c13",
"icons/Icon-512.png": "59c93663d40f22208efdf6137e4a9d6b",
"icons/Icon-maskable-192.png": "aa83ae936d61ac8b515c03f3df698c13",
"icons/Icon-maskable-512.png": "59c93663d40f22208efdf6137e4a9d6b",
"index.html": "d2c35a1355aa2187e7a5e929249e3053",
"/": "d2c35a1355aa2187e7a5e929249e3053",
"main.dart.js": "a71dd75f53d1e338a064a6d82ceab97c",
"manifest.json": "9484cc808e5d1af86043e5fa0a4aee28",
"version.json": "4fd4eedcb440c3a2b433043f8216c87c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
