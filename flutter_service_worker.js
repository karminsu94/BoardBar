'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "9e630b72d32e59721a22dde6f1227049",
"assets/AssetManifest.bin.json": "434eee3d7a69a8d4749f0b1547dbd0b7",
"assets/AssetManifest.json": "dab4a10785d49257f98ebb73e7aa827a",
"assets/assets/audio/minus1.MP3": "300d0ccf33b917d52349fd4a7b788c7e",
"assets/assets/audio/minus5-10.MP3": "52ee2eed857187efdb726afe61210b4f",
"assets/assets/audio/plus1.MP3": "0d2796fef0b035a97cc74c7386a308ab",
"assets/assets/audio/plus10.MP3": "dbb825718ddae8b7866a25c6b7dfc53c",
"assets/assets/audio/plus5.MP3": "ec63ac558ce99d827adda91ebd44fbfe",
"assets/assets/audio/ranking.MP3": "64c6fe4cbab676fe376d41e77e73430c",
"assets/assets/audio/score.MP3": "bbac7b592aa602b033c30caa9f83873d",
"assets/assets/audio/timeUp.MP3": "6d771175ed69db2fae67410291c092d3",
"assets/assets/fonts/PressStart2P-Regular.ttf": "ccb1dfce06ad3883f8e3b5ae011aa795",
"assets/assets/fonts/Roboto-VariableFont_wdth,wght.ttf": "3aa911d4a1e76c8946952fe744ce7434",
"assets/assets/logo/99d4f694a6575e66d6a81c017511fbea.png": "217a53bf868d0b0f9dbefb1c682f81f5",
"assets/assets/logo/ad0ad3c52d79673039a6995559186ff9.jpg": "1cc529a062895ecb2f28c40f976726a6",
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
"assets/assets/logo/inspiration-geometry.png": "f10544eca8100262ce520c5192b6f65e",
"assets/assets/logo/min10.png": "d7ecd7e7081045fc696df21032d349f2",
"assets/assets/logo/min5.png": "cde72e9f6098aaa3f4cd986a4ebbb9b4",
"assets/assets/logo/padded-light.png": "70cda1e0ad16a50db275a26ca5011eae",
"assets/assets/logo/paper.png": "9e0f729525da91911897687d1874ea4c",
"assets/assets/logo/plus10.png": "196142afe5f9a82866429e86777f65a0",
"assets/assets/logo/plus5.png": "445baa4f88839bfcfffb579058d42d07",
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
"assets/FontManifest.json": "d65d76b735303c9ec50bdcd2f0e31e16",
"assets/fonts/MaterialIcons-Regular.otf": "3344488d772ba15801363d0e671eb76f",
"assets/NOTICES": "20d2944e990c3c992b382d91aec8c92e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "fcb4c59db7b219c0a7ee388e5b9c5a5b",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "0f9edbbc822afdd216b87b657851560f",
"icons/Icon-192.png": "aa83ae936d61ac8b515c03f3df698c13",
"icons/Icon-512.png": "59c93663d40f22208efdf6137e4a9d6b",
"icons/Icon-maskable-192.png": "aa83ae936d61ac8b515c03f3df698c13",
"icons/Icon-maskable-512.png": "59c93663d40f22208efdf6137e4a9d6b",
"index.html": "d2c35a1355aa2187e7a5e929249e3053",
"/": "d2c35a1355aa2187e7a5e929249e3053",
"main.dart.js": "738d3c9133316890597aba8f6ec6387b",
"manifest.json": "9484cc808e5d1af86043e5fa0a4aee28",
"version.json": "8443ed4d3534525017966bbd77ebb268"};
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
