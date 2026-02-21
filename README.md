# smart_dio_client_pro

Production-ready Flutter networking client built on Dio.

![pub version](https://img.shields.io/pub/v/smart_dio_client_pro)
![pub points](https://img.shields.io/pub/points/smart_dio_client_pro)
![likes](https://img.shields.io/pub/likes/smart_dio_client_pro)
![popularity](https://img.shields.io/pub/popularity/smart_dio_client_pro)
![license](https://img.shields.io/github/license/ajaykawa/smart_dio_client_pro)

---

## ✨ Features

✔ GET, POST, PUT, DELETE
✔ Multipart upload with progress
✔ Auto token refresh
✔ Secure token storage
✔ Global loader support
✔ API caching & offline mode
✔ GetX-ready BaseController
✔ Error handling & retry
✔ Clean architecture
✔ Production-ready interceptors

---

## 📸 Preview

> Adding screenshots increases trust & downloads.

Create folder:

```
screenshots/
```

Add images and reference:

<img src="screenshots/loader.png" width="250">

---

## 📦 Installation

Add dependency:

```yaml
dependencies:
  smart_dio_client_pro: ^1.0.0
```

Run:

```bash
flutter pub get
```

---

## ⚡ Initialization

```dart
final api = DioClient(baseUrl: "https://api.example.com");

await TokenManager.loadTokens();
```

---

## 🔐 Save Tokens

```dart
await TokenManager.saveTokens(
  accessToken: token,
  refreshToken: refresh,
);
```

---

## 📡 API Requests

### GET

```dart
final data = await api.get("/orders");
```

### POST

```dart
await api.post("/login", data: {...});
```

### PUT

```dart
await api.put("/profile", data: {...});
```

### DELETE

```dart
await api.delete("/order/1");
```

---

## 📤 Upload with Progress

```dart
api.multipartUpload(
  "/upload",
  filePaths: {"file": path},
  onProgress: (sent, total) {
    print((sent / total) * 100);
  },
);
```

---

## ⚡ Enable Caching

```dart
api.get("/products", cache: true);
```

---

## 🧠 GetX Controller Example

```dart
class HomeController extends BaseController {
  final api = DioClient(baseUrl: baseUrl);

  void fetchOrders() async {
    try {
      showLoader();
      final data = await api.get("/orders");
      hideLoader();
    } catch (e) {
      handleError(e);
    }
  }
}
```

---

## 🏗 Architecture

```
lib/
├── core/
├── auth/
├── cache/
├── ui/
└── getx/
```

---

## 🤝 Contributing

Pull requests are welcome.

If you'd like to improve this package, feel free to fork and submit a PR.

---

## 📄 License

MIT License © Ajay Kawa

---
