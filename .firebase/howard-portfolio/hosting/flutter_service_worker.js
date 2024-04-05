'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "7d00e9c89f236e2feb70afe866c80bc5",
"index.html": "2ffa4487fb1fa016b45b7a603991620d",
"/": "5f4aa9123bb4c23d60db74b7681f39e7",
"test/widget_test.dart": "86c18fce24913fe4569274236767d15c",
"main.dart.js": "1e0e601d52ee815acac9b1ddab078365",
"web/index.html": "5f4aa9123bb4c23d60db74b7681f39e7",
"web/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"web/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"web/icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"web/icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"web/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"web/manifest.json": "040abcbfd11a4e2e84b11c889d7b60b2",
"pubspec.lock": "63e38741c419a3830a33f998e7895fdd",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"README.md": "8d716398ba648cef477321111fa9eee6",
"favicon.png": "4f61da833e20f739afbebf52376b19da",
"pubspec.yaml": "af08f51ca3f89634ea4ea5dffab126d6",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "36fd798b883ac19667ba69b68271a4a1",
"lib/json_parse.dart": "e79fe8ceb52e616f2df62936afc096c7",
"lib/firebase_options.dart": "a5e4bbafc50e32361ac65d2c6a14d496",
"lib/class.dart": "50458d97dfa9b16db7560a8863b5cc27",
"lib/network.dart": "3a3cba4b67e9bd26caac598b94f05875",
"lib/main.dart": "ac8734992f655f0a9ca621f646a772f4",
"lib/app_theme.dart": "5c395b289f7bbf0d11a43f0ce0ed4741",
"analysis_options.yaml": "66d03d7647c8e438164feaf5b922d44a",
"assets/AssetManifest.json": "1d50a124f6473c6e41e853ad5f066d9a",
"assets/imageplaceholder.png": "85a1d089e7581eba59635c5fabf4c139",
"assets/NOTICES": "bf1478bdf88b03b1faaf572185cd7e3d",
"assets/FontManifest.json": "d0c9a8961322d0a9b49afe76e58537a1",
"assets/linkedin_logo60px.png": "5e856c76158881db5d302b011892ed9e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "9ac8b34745d4e78bf0bfa497e1b94033",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "a6bc82e22e5b4bdfafc520a1a7735794",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "d89769da0f660f3df397ed8dc110d92f",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "3bd13d3d15b302e4dbba6bd9613e6443",
"assets/fonts/Museo%2520500.otf": "032337e82232f53e67317d5f6680d729",
"assets/fonts/Museo%2520700.otf": "1087c6a9da22ebf924be80a001a84d2f",
"assets/fonts/Montserrat-Medium.ttf": "aca6287f22eef510c1e622c97bb1e1e1",
"assets/fonts/Museo%2520300.otf": "8334c5ba90dbe7e5316c6817ed0c9cde",
"assets/fonts/Museo%2520100.otf": "33a575361bfd16adc5838e80c8449884",
"assets/fonts/Montserrat-Light.ttf": "a17f43cc60643d965636985afc00a221",
"assets/fonts/Montserrat-ExtraLight.ttf": "d88fa2ca46d05df6986d2eaeafee2225",
"assets/fonts/Montserrat-Thin.ttf": "426a4b74bf1d6920508384899bfb695b",
"assets/fonts/Montserrat-Bold.ttf": "d14ad1035ae6da4e5a71eca362a8d696",
"assets/fonts/Montserrat-SemiBold.ttf": "7ffeec2b4edb434d393875ffbe633c30",
"assets/fonts/Montserrat-ExtraBold.ttf": "dc2f156b60f53c591fc0d2b98cbf01bf",
"assets/fonts/Montserrat-Black.ttf": "55e37a35525c63e130e76d588f2f5e8d",
"assets/fonts/Montserrat-Regular.ttf": "34de1239b12123b85ff1a68b58835a1f",
"assets/fonts/MaterialIcons-Regular.otf": "279838524873724ccc8c6a4c116d3aee",
"assets/fonts/Museo%2520900.otf": "848c37ef6bfe989e9d1c509e674423e0",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
