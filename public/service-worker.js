/* Service Worker — Matriz de Programación APS (PWA) */
const CACHE = "matriz-aps-v1";
const ASSETS = [
  "./", "./index.html", "./manifest.json",
  "./icon-192.png", "./icon-512.png", "./apple-touch-icon.png"
];

self.addEventListener("install", (e) => {
  e.waitUntil(
    caches.open(CACHE).then((c) => c.addAll(ASSETS)).then(() => self.skipWaiting())
  );
});

self.addEventListener("activate", (e) => {
  e.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener("fetch", (e) => {
  const req = e.request;
  if (req.method !== "GET") return;
  const url = new URL(req.url);

  // Nunca cachear tráfico de Firebase/Firestore/Google (debe ir siempre a la red)
  if (/(firestore|googleapis|gstatic|firebaseio|firebaseapp|identitytoolkit)\./.test(url.host)) return;

  // Navegaciones (HTML): network-first para tener siempre la última versión, con fallback offline
  if (req.mode === "navigate") {
    e.respondWith(
      fetch(req).then((res) => {
        const clone = res.clone();
        caches.open(CACHE).then((c) => c.put("./index.html", clone));
        return res;
      }).catch(() => caches.match("./index.html"))
    );
    return;
  }

  // Resto de assets del mismo origen: cache-first
  if (url.origin === location.origin) {
    e.respondWith(
      caches.match(req).then((hit) => hit || fetch(req).then((res) => {
        if (res && res.status === 200) {
          const clone = res.clone();
          caches.open(CACHE).then((c) => c.put(req, clone));
        }
        return res;
      }))
    );
  }
});
