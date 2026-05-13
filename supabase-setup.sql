-- ═══════════════════════════════════════════════════════════
--  GymLog — Setup Supabase
--  Esegui questo SQL nel SQL Editor di Supabase
--  (Dashboard → SQL Editor → New query → incolla → Run)
-- ═══════════════════════════════════════════════════════════

-- 1. Tabella: una riga per utente con tutti i dati come JSON
CREATE TABLE IF NOT EXISTS user_data (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  data    JSONB NOT NULL DEFAULT '{}'::jsonb,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2. Abilita Row Level Security (ogni utente vede solo i suoi dati)
ALTER TABLE user_data ENABLE ROW LEVEL SECURITY;

-- 3. Policy: l'utente può leggere solo la propria riga
CREATE POLICY "Users can read own data"
  ON user_data FOR SELECT
  USING (auth.uid() = user_id);

-- 4. Policy: l'utente può inserire solo la propria riga
CREATE POLICY "Users can insert own data"
  ON user_data FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- 5. Policy: l'utente può aggiornare solo la propria riga
CREATE POLICY "Users can update own data"
  ON user_data FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Fatto! La tabella è pronta.
-- Ogni utente potrà vedere e modificare solo i propri dati.
