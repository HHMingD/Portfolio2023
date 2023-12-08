'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".dart_tool/chrome-device/Default/arbitration_service_config.json": "4e4d178365f9b62dcf62cdfea4d03c5f",
".dart_tool/chrome-device/Default/Asset%20Store/assets.db/000003.ldb": "8c6f7e35d397aca4c737ac0ff2fe1d95",
".dart_tool/chrome-device/Default/Asset%20Store/assets.db/000006.ldb": "32cca3dcdeaaeb651c303713921d571b",
".dart_tool/chrome-device/Default/Asset%20Store/assets.db/000007.log": "6072d6aa007b8132d649de844c95565f",
".dart_tool/chrome-device/Default/Asset%20Store/assets.db/CURRENT": "46295cac801e5d4857d09837238a6394",
".dart_tool/chrome-device/Default/Asset%20Store/assets.db/LOCK": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/Asset%20Store/assets.db/LOG": "ea1df2550e5eeeed1e0cdce9c4565e4d",
".dart_tool/chrome-device/Default/Asset%20Store/assets.db/LOG.old": "38bba385fbe95968f350ffcd7eee24bf",
".dart_tool/chrome-device/Default/Asset%20Store/assets.db/MANIFEST-000001": "952df7b508f82c155e171070ac6280cb",
".dart_tool/chrome-device/Default/AssistanceHome/AssistanceHomeSQLite": "40b18ec43db334e7b3f6295c7626f28d",
".dart_tool/chrome-device/Default/AssistanceHome/AssistanceHomeSQLite-journal": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/AutofillStrikeDatabase/LOCK": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/AutofillStrikeDatabase/LOG": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/AutofillStrikeDatabase/LOG.old": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/Bookmarks": "210def00158f7b77f255bc79becdb927",
".dart_tool/chrome-device/Default/Bookmarks.bak": "210def00158f7b77f255bc79becdb927",
".dart_tool/chrome-device/Default/BudgetDatabase/LOCK": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/BudgetDatabase/LOG": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/BudgetDatabase/LOG.old": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/Collections/collectionsSQLite": "29c9af42d59ba452c914d337f83778d8",
".dart_tool/chrome-device/Default/Collections/collectionsSQLite-journal": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/commerce_subscription_db/LOCK": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/commerce_subscription_db/LOG": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/databases/Databases.db": "98643af1ca5c0fe03ce8c687189ce56b",
".dart_tool/chrome-device/Default/databases/Databases.db-journal": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/DIPS": "25ff7e08cb3461ca97c8af38c97eb2a2",
".dart_tool/chrome-device/Default/DIPS-journal": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/discounts_db/LOCK": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/discounts_db/LOG": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/Download%20Service/EntryDB/LOCK": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/Download%20Service/EntryDB/LOG": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/Edge%20Profile%20Picture.png": "ede0174fc63f55a0c4b2f5d174b7df0e",
".dart_tool/chrome-device/Default/EdgeCoupons/coupons_data.db/000003.log": "4930c001da44fbf15cf52f2c96078808",
".dart_tool/chrome-device/Default/EdgeCoupons/coupons_data.db/CURRENT": "46295cac801e5d4857d09837238a6394",
".dart_tool/chrome-device/Default/EdgeCoupons/coupons_data.db/LOCK": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/EdgeCoupons/coupons_data.db/LOG": "7cf5346f83f017caf54521b4246ed4d8",
".dart_tool/chrome-device/Default/EdgeCoupons/coupons_data.db/MANIFEST-000001": "5af87dfd673ba2115e2fcf5cfdb727ab",
".dart_tool/chrome-device/Default/EdgeEDrop/EdgeEDropSQLite.db": "cf7760533536e2af66ea68bc3561b74d",
".dart_tool/chrome-device/Default/EdgeEDrop/EdgeEDropSQLite.db-journal": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/EdgeHubAppUsage/EdgeHubAppUsageSQLite.db": "575f5a2a5a2800bd4a5dbdf6ae768cb3",
".dart_tool/chrome-device/Default/EdgeHubAppUsage/EdgeHubAppUsageSQLite.db-journal": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/EdgePushStorageWithConnectTokenAndKey/000003.log": "e9b2247c50d8fcb271b01895b97a0a39",
".dart_tool/chrome-device/Default/EdgePushStorageWithConnectTokenAndKey/CURRENT": "46295cac801e5d4857d09837238a6394",
".dart_tool/chrome-device/Default/EdgePushStorageWithConnectTokenAndKey/LOCK": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/EdgePushStorageWithConnectTokenAndKey/LOG": "f5e0c7bf4e3e5afd2766a0e1195c2eae",
".dart_tool/chrome-device/Default/EdgePushStorageWithConnectTokenAndKey/LOG.old": "d41d8cd98f00b204e9800998ecf8427e",
".dart_tool/chrome-device/Default/EdgePushStorageWithConnectTokenAndKey/MANIFEST-000001": "5af87dfd673ba2115e2fcf5cfdb727ab",
".dart_tool/chrome-device/Default/EntityExtraction/domains_config.json": "263e1ccd610cbe069876d02bf097244b",
".dart_tool/dartpad/web_plugin_registrant.dart": "7ed35bc85b7658d113371ffc24d07117",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/app.dill": "46f4b57afe5fc309bd52c657b41b2d94",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/app.dill.deps": "f4b5e1cc0c3d9b002345c7ce34818aff",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/dart2js.d": "d6550442551397d77521c1c171080eef",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/dart2js.stamp": "f394336184137787907e6a2326a191d6",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/flutter_assets.d": "c2144105cdff5c628dd2d7610a5cdbd4",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/gen_localizations.stamp": "436d2f2faeb7041740ee3f49a985d62a",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/main.dart": "3dfaf3d5955ae8cba575d0a898472671",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/main.dart.js": "8b225e5777f1e80135fe3fc6e8a88b99",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/main.dart.js.deps": "c84e5f6dbf22cb6c80b6ce38abf51ecd",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/outputs.json": "fa66b7fce1c74f85528a9ef9ba08a150",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/service_worker.d": "b58da577f77c102b7f02652783c51f93",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/web_entrypoint.stamp": "04168b0df983728751659d2b503b1210",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/web_plugin_registrant.dart": "7ed35bc85b7658d113371ffc24d07117",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/web_release_bundle.stamp": "26e72c705d8751ad88b6c1df7781f586",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/web_resources.d": "0fac55e84fdc46ba502aa4542bfcdb60",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/web_service_worker.stamp": "fec40778e0841aaf1328c3e35ff5ac7e",
".dart_tool/flutter_build/454a5e2164abef7478624a0ecea2a689/web_static_assets.stamp": "83c2f4a0efcd9d46035cf817480af005",
".dart_tool/package_config.json": "a7510affbf1b559cf6361db2b42de50d",
".dart_tool/package_config_subset": "8016e6ab2453b5e83649dd537fdc5947",
".dart_tool/version": "7c575311bdae58017ac4074ce3d5323f",
".idea/libraries/Dart_SDK.xml": "3dc1ebc2a545ef5afcd5802d4c19a0dc",
".idea/libraries/KotlinJavaRuntime.xml": "de38cfadca3106f8aff5ab15dd81692f",
".idea/modules.xml": "d01dc7d2bd0f888c72eadbf051796f94",
".idea/runConfigurations/main_dart.xml": "0ecf958af289efc3fc1927aa27a8442f",
".idea/workspace.xml": "25155dfb2368a7e35e1ebbecd505a418",
"analysis_options.yaml": "9e65f4b9beebb674c0dc252f70a5c177",
"assets/AssetManifest.bin": "3bd13d3d15b302e4dbba6bd9613e6443",
"assets/AssetManifest.json": "1d50a124f6473c6e41e853ad5f066d9a",
"assets/FontManifest.json": "d0c9a8961322d0a9b49afe76e58537a1",
"assets/fonts/MaterialIcons-Regular.otf": "4ecb23a89727318289ef744936081fd1",
"assets/fonts/Montserrat-Black.ttf": "55e37a35525c63e130e76d588f2f5e8d",
"assets/fonts/Montserrat-Bold.ttf": "d14ad1035ae6da4e5a71eca362a8d696",
"assets/fonts/Montserrat-ExtraBold.ttf": "dc2f156b60f53c591fc0d2b98cbf01bf",
"assets/fonts/Montserrat-ExtraLight.ttf": "d88fa2ca46d05df6986d2eaeafee2225",
"assets/fonts/Montserrat-Light.ttf": "a17f43cc60643d965636985afc00a221",
"assets/fonts/Montserrat-Medium.ttf": "aca6287f22eef510c1e622c97bb1e1e1",
"assets/fonts/Montserrat-Regular.ttf": "34de1239b12123b85ff1a68b58835a1f",
"assets/fonts/Montserrat-SemiBold.ttf": "7ffeec2b4edb434d393875ffbe633c30",
"assets/fonts/Montserrat-Thin.ttf": "426a4b74bf1d6920508384899bfb695b",
"assets/fonts/Museo%2520100.otf": "33a575361bfd16adc5838e80c8449884",
"assets/fonts/Museo%2520300.otf": "8334c5ba90dbe7e5316c6817ed0c9cde",
"assets/fonts/Museo%2520500.otf": "032337e82232f53e67317d5f6680d729",
"assets/fonts/Museo%2520700.otf": "1087c6a9da22ebf924be80a001a84d2f",
"assets/fonts/Museo%2520900.otf": "848c37ef6bfe989e9d1c509e674423e0",
"assets/imageplaceholder.png": "85a1d089e7581eba59635c5fabf4c139",
"assets/linkedin_logo60px.png": "5e856c76158881db5d302b011892ed9e",
"assets/NOTICES": "84514d34483ec65c7f8257525150da6a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "7153276d32335f1b518a4d7e0d604ca2",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "a5d7457fda15b7622c14f432ba63039a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "b72c617acdf2227c8b1413215f620711",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"build/446211e9e78b406b8e72f85b32198365/gen_dart_plugin_registrant.stamp": "436d2f2faeb7041740ee3f49a985d62a",
"build/446211e9e78b406b8e72f85b32198365/gen_localizations.stamp": "436d2f2faeb7041740ee3f49a985d62a",
"build/446211e9e78b406b8e72f85b32198365/_composite.stamp": "436d2f2faeb7041740ee3f49a985d62a",
"build/a46f85df11ed3d278105635939097b84.cache.dill.track.dill": "56e6c7553268ac39329efa7265a59bd6",
"build/flutter_assets/AssetManifest.bin": "693635b5258fe5f1cda720cf224f158c",
"build/flutter_assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"build/flutter_assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"build/flutter_assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"build/flutter_assets/NOTICES": "16efe4c3173ff79a25b67501e326e21c",
"build/flutter_assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"build/flutter_assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"build/last_build_run.json": "d81b60490e550d13d5643dc672178fb2",
"build/web/assets/AssetManifest.bin": "693635b5258fe5f1cda720cf224f158c",
"build/web/assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"build/web/assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"build/web/assets/fonts/MaterialIcons-Regular.otf": "65e21b5db78a7c132bbb04776ec9c399",
"build/web/assets/NOTICES": "dc54efecfaef8b079e042dd439f8c2ef",
"build/web/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"build/web/assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"build/web/canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"build/web/canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"build/web/canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"build/web/canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"build/web/canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"build/web/canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"build/web/canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"build/web/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"build/web/flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"build/web/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"build/web/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"build/web/icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"build/web/icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"build/web/index.html": "36f89d495342804ee2cf903c53effb91",
"/": "ffffa2a440c978446e26feb4b45ff6c8",
"build/web/main.dart.js": "8b225e5777f1e80135fe3fc6e8a88b99",
"build/web/manifest.json": "46da308e64bf9e35c0d48d9fe309c2e7",
"build/web/version.json": "c00f200db791955d03aed010c55282fb",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "4f61da833e20f739afbebf52376b19da",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"howard_portfolio_2023.iml": "f9bf5c490675c84d098e6772a6f2a796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "ba407ba34abb7792a3524d49d6a55e0a",
"lib/app_theme.dart": "0c44f2eb4eeb80b410b3fdb5b45a01c2",
"lib/class.dart": "9d68adc20d49271aa07b3459b67a25aa",
"lib/firebase_options.dart": "d335b07a2e982c3f43580927497ffc12",
"lib/json_parse.dart": "dfe8dc6a693e242675913a5261a235af",
"lib/main.dart": "30e4e4dc8eb9ff767119202c3c59638b",
"lib/network.dart": "07ba59c84b493321a17bd02c7f276d38",
"main.dart.js": "c5ac22f3cecdd25f9f05059364ddb840",
"manifest.json": "7020d1f1338de1bcb3b7f590fd395900",
"pubspec.lock": "63e38741c419a3830a33f998e7895fdd",
"pubspec.yaml": "f9cf8ea6c97c19316240b711540a920d",
"README.md": "c21478c35161825453056ac796d7b55c",
"test/widget_test.dart": "652722623af585c5eea7ece49d59449e",
"version.json": "7d00e9c89f236e2feb70afe866c80bc5",
"web/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"web/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"web/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"web/icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"web/icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"web/index.html": "ffffa2a440c978446e26feb4b45ff6c8",
"web/manifest.json": "46da308e64bf9e35c0d48d9fe309c2e7"};
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
