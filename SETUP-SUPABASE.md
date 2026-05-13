# GymLog — Guida Setup Supabase

## 1. Crea il progetto Supabase (gratis)

1. Vai su **https://supabase.com** → Sign up (o Sign in)
2. Clicca **"New project"**
3. Scegli un nome (es. "gymlog"), una password per il database, e la regione più vicina (EU West)
4. Aspetta ~2 minuti che il progetto si crei

## 2. Crea la tabella

1. Nel menu a sinistra clicca **"SQL Editor"**
2. Clicca **"New query"**
3. Incolla tutto il contenuto del file **`supabase-setup.sql`**
4. Clicca **"Run"** (in basso a destra)
5. Dovresti vedere "Success. No rows returned" — è corretto

## 3. Prendi le chiavi API

1. Nel menu a sinistra clicca **"Settings"** (icona ingranaggio)
2. Poi **"API"** nella sezione "Project Settings"
3. Copia:
   - **Project URL** → es. `https://abcdefgh.supabase.co`
   - **anon public** key → la chiave lunga che inizia con `eyJ...`

## 4. Inseriscile nel codice

Apri **`index.html`** e trova queste due righe in cima allo script:

```js
const SUPABASE_URL  = 'https://IL_TUO_PROGETTO.supabase.co';
const SUPABASE_ANON = 'IL_TUO_ANON_KEY';
```

Sostituiscile con i tuoi valori reali. Esempio:

```js
const SUPABASE_URL  = 'https://abcdefgh.supabase.co';
const SUPABASE_ANON = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

## 5. Configura la conferma email (opzionale)

Di default Supabase richiede la conferma email. Per disabilitarla (utile per test):

1. **Settings** → **Authentication** → **Email**
2. Disattiva "Confirm email"

Se la lasci attiva, chi si registra riceverà una mail di conferma prima di poter accedere.

## 6. Configura il Redirect URL

1. **Settings** → **Authentication** → **URL Configuration**
2. In "Site URL" metti l'URL del tuo sito su Cloudflare Pages, es:
   `https://gymlog.pages.dev`

## 7. Deploy

Carica tutti i file su GitHub come prima:
- `index.html` (con le chiavi Supabase inserite)
- `manifest.webmanifest`
- `sw.js`
- `icons/` (cartella con le 4 icone)
- Il file `supabase-setup.sql` non serve nel deploy, è solo per il setup

Cloudflare Pages fa il deploy automaticamente.

## Come funziona

- Ogni utente si registra con email e password
- I dati (schede, esercizi, sessioni) vengono salvati su Supabase nel cloud
- Una copia locale resta in localStorage per velocità e uso offline
- Ogni utente vede SOLO i propri dati (grazie a Row Level Security)
- Se sei offline, l'app funziona dalla cache locale; appena torni online, i dati si sincronizzano
