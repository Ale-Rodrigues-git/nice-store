# NICE Store — Streetwear by Japan

App de e-commerce de roupas streetwear desenvolvido em Flutter, com integração ao Firebase para autenticação e banco de dados.

---

## Telas

- **Login** — autenticação com email e senha via Firebase Auth
- **Cadastro** — criação de conta com nome, email e senha
- **Home** — catálogo de produtos com busca
- **Carrinho** — gerenciamento de itens selecionados
- **Favoritos** — produtos salvos pelo usuário
- **Perfil** — dados do usuário logado
- **Busca** — pesquisa de produtos por nome

---

## Tecnologias

- [Flutter](https://flutter.dev/) 3.x
- [Firebase Auth](https://firebase.google.com/products/auth) — autenticação de usuários
- [Cloud Firestore](https://firebase.google.com/products/firestore) — banco de dados
- [Provider](https://pub.dev/packages/provider) — gerenciamento de estado
- [HTTP](https://pub.dev/packages/http) — consumo de API externa

---

## Estrutura do projeto

```
lib/
├── main.dart
├── firebase_options.dart
└── src/
    ├── app.dart
    ├── auth/
    │   ├── app_user.dart
    │   ├── auth_controller.dart
    │   └── auth_repository.dart
    ├── cart/
    │   ├── cart_controller.dart
    │   └── cart_item.dart
    ├── catalog/
    │   ├── catalog_controller.dart
    │   ├── fake_store_repository.dart
    │   └── product.dart
    ├── favorites/
    │   └── favorites_controller.dart
    ├── screens/
    │   ├── cart_screen.dart
    │   ├── favorites_screen.dart
    │   ├── home_screen.dart
    │   ├── login_screen.dart
    │   ├── profile_screen.dart
    │   ├── search_screen.dart
    │   ├── shop_shell.dart
    │   └── signup_screen.dart
    ├── theme/
    │   └── nice_theme.dart
    └── widgets/
        ├── nice_logo.dart
        ├── primary_button.dart
        ├── product_card.dart
        └── social_button.dart
```

---

## Como rodar o projeto

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado
- [Android Studio](https://developer.android.com/studio) com emulador configurado
- Conta no [Firebase](https://firebase.google.com/)

### Passos

**1. Clone o repositório**
```bash
git clone https://github.com/seu-usuario/nice-store.git
cd nice-store
```

**2. Instale as dependências**
```bash
flutter pub get
```

**3. Configure o Firebase**

Instale o FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

Configure o projeto Firebase:
```bash
flutterfire configure
```

Isso vai gerar o arquivo `firebase_options.dart` automaticamente.

**4. Rode o app**
```bash
flutter run
```

---

## Configuração do Firebase

### Firebase Auth
Ative o provedor **Email/Senha** no console do Firebase em:
`Authentication > Sign-in method > Email/Senha`

### Firestore
Crie o banco no modo de teste em:
`Firestore Database > Criar banco de dados`

Regras recomendadas para desenvolvimento:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

---

## Equipe

Desenvolvido como projeto de e-commerce streetwear.

---

## Licença

Este projeto é de uso acadêmico/pessoal.
