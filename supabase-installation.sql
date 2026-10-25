-- ============================================================
--  Les outils de Daniel — installation de la base Supabase
--  À coller en entier dans Supabase > SQL Editor > New query, puis « Run ».
--  Peut être relancé sans risque.
-- ============================================================

-- 1. Table des outils (une ligne par outil, la fiche complète est dans « data »)
create table if not exists public.outils (
  id          uuid primary key default gen_random_uuid(),
  data        jsonb not null,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

-- 2. Sécurité : seules les personnes connectées (comptes créés par vous) lisent et modifient
alter table public.outils enable row level security;

drop policy if exists "outils lecture"     on public.outils;
drop policy if exists "outils ajout"       on public.outils;
drop policy if exists "outils modification" on public.outils;
drop policy if exists "outils suppression" on public.outils;

create policy "outils lecture"      on public.outils for select to authenticated using (true);
create policy "outils ajout"        on public.outils for insert to authenticated with check (true);
create policy "outils modification" on public.outils for update to authenticated using (true) with check (true);
create policy "outils suppression"  on public.outils for delete to authenticated using (true);

-- 3. Synchronisation en direct entre le téléphone et l'ordinateur
do $$ begin
  alter publication supabase_realtime add table public.outils;
exception when duplicate_object then null; end $$;

-- 4. Espace privé pour les photos, notices, vues éclatées et factures (20 Mo max par fichier)
insert into storage.buckets (id, name, public, file_size_limit)
values ('documents', 'documents', false, 20971520)
on conflict (id) do update set public = false, file_size_limit = 20971520;

drop policy if exists "documents lecture"     on storage.objects;
drop policy if exists "documents ajout"       on storage.objects;
drop policy if exists "documents modification" on storage.objects;
drop policy if exists "documents suppression" on storage.objects;

create policy "documents lecture"      on storage.objects for select to authenticated using (bucket_id = 'documents');
create policy "documents ajout"        on storage.objects for insert to authenticated with check (bucket_id = 'documents');
create policy "documents modification" on storage.objects for update to authenticated using (bucket_id = 'documents');
create policy "documents suppression"  on storage.objects for delete to authenticated using (bucket_id = 'documents');

-- 5. Reprise de l'outil déjà saisi : meuleuse Ryobi EAG2023CN
insert into public.outils (data)
select '{
  "designation": "Meuleuse d''angle 230 mm",
  "categorie": "Électroportatif",
  "marque": "Ryobi",
  "modele": "EAG2023CN",
  "reference": "EAG2023CN",
  "motsCles": "disqueuse 2000W 230 mm 9 pouces filaire M14 6000 tr/min",
  "specs": "2000 W · disque Ø230 mm · 6000 tr/min à vide · axe M14 · env. 6 kg",
  "lieu": "garage", "emplacement": "",
  "statut": "disponible", "pretA": "", "pretDate": "", "retourPrevu": "",
  "dateAchat": "", "prix": null, "garantieMois": null,
  "noticeUrl": "https://www.manualslib.com/download/657683/Ryobi-Eag2023cn.html",
  "eclateUrl": "",
  "liensWeb": [
    {"titre": "Notice EAG2023CN (ManualsLib)", "url": "https://www.manualslib.com/download/657683/Ryobi-Eag2023cn.html"},
    {"titre": "Fiche Ryobi EAG2023RG (version voisine)", "url": "https://www.ryobi.com.au/products/details/2000w-angle-grinder-kit-230mm-eag2023rg"}
  ],
  "completeNote": "Aucune vue éclatée publique trouvée pour ce modèle : demander au SAV Ryobi si besoin de pièces.",
  "accessoires": [
    {"nom": "Carter de protection", "possede": true},
    {"nom": "Poignée auxiliaire", "possede": true},
    {"nom": "Clé de serrage (W2024)", "possede": true},
    {"nom": "Meule à ébarber Ø230 (AGD2024)", "possede": true},
    {"nom": "Disque à tronçonner métal Ø230", "possede": true},
    {"nom": "Disque diamant Ø230", "possede": true},
    {"nom": "Coffret de rangement", "possede": true}
  ],
  "entretien": [], "consommables": "",
  "notes": "Localisation, date d''achat et garantie à vérifier.",
  "photo": null, "notice": null, "eclate": null, "facture": null,
  "historique": [], "createdAt": 1793000000000, "updatedAt": 1793000000000
}'::jsonb
where not exists (select 1 from public.outils where data->>'modele' = 'EAG2023CN');
