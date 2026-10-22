-- NEXORA STUDIO / 2026-10-22
-- Run once in Supabase Dashboard > SQL Editor.
-- Auth is provided by Supabase email Magic Links.

create extension if not exists pgcrypto;

create table if not exists public.profiles (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid not null references auth.users(id) on delete cascade,
    slug text not null unique check (slug ~ '^[a-z0-9][a-z0-9-]{2,35}$'),
    category text not null check (category in ('academic','business','creator','community')),
    is_published boolean not null default false,
    content jsonb not null default '{}'::jsonb,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint content_size_limit check (octet_length(content::text) < 250000)
);

create index if not exists profiles_owner_idx on public.profiles(owner_id);
create index if not exists profiles_published_idx on public.profiles(slug) where is_published = true;

alter table public.profiles enable row level security;

-- Prevent untrusted users reading someone else's drafts.
drop policy if exists profiles_select_public_or_owner on public.profiles;
create policy profiles_select_public_or_owner on public.profiles
for select to anon, authenticated
using (is_published = true or (select auth.uid()) = owner_id);

drop policy if exists profiles_insert_owner on public.profiles;
create policy profiles_insert_owner on public.profiles
for insert to authenticated
with check ((select auth.uid()) = owner_id);

drop policy if exists profiles_update_owner on public.profiles;
create policy profiles_update_owner on public.profiles
for update to authenticated
using ((select auth.uid()) = owner_id)
with check ((select auth.uid()) = owner_id);

drop policy if exists profiles_delete_owner on public.profiles;
create policy profiles_delete_owner on public.profiles
for delete to authenticated
using ((select auth.uid()) = owner_id);

create or replace function public.profiles_set_updated_at()
returns trigger language plpgsql set search_path = '' as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_profiles_updated_at on public.profiles;
create trigger set_profiles_updated_at
before update on public.profiles
for each row execute function public.profiles_set_updated_at();

-- Note: This MVP uses a compressed image stored in content JSONB.
-- Production should migrate uploads to a private/write-controlled Storage bucket.
