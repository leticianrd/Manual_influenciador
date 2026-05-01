-- =============================================
-- MANUAL INFLUENCIADOR — Setup Supabase
-- Cole este SQL em: Supabase > SQL Editor > Run
-- =============================================

-- 1. Tabela de perfis dos usuários
create table if not exists public.profiles (
  id uuid references auth.users on delete cascade primary key,
  name text,
  email text,
  created_at timestamp with time zone default now()
);

-- 2. Tabela de progresso dos módulos
create table if not exists public.progress (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users on delete cascade not null,
  module_id integer not null,
  completed boolean default false,
  completed_at timestamp with time zone default now(),
  unique(user_id, module_id)
);

-- 3. Habilitar Row Level Security (RLS)
alter table public.profiles enable row level security;
alter table public.progress enable row level security;

-- 4. Políticas de acesso — profiles
create policy "Usuário vê seu próprio perfil"
  on public.profiles for select
  using (auth.uid() = id);

create policy "Usuário cria seu próprio perfil"
  on public.profiles for insert
  with check (auth.uid() = id);

create policy "Usuário atualiza seu próprio perfil"
  on public.profiles for update
  using (auth.uid() = id);

-- 5. Políticas de acesso — progress
create policy "Usuário vê seu próprio progresso"
  on public.progress for select
  using (auth.uid() = user_id);

create policy "Usuário insere seu próprio progresso"
  on public.progress for insert
  with check (auth.uid() = user_id);

create policy "Usuário atualiza seu próprio progresso"
  on public.progress for update
  using (auth.uid() = user_id);

-- 6. Trigger: cria perfil automaticamente ao registrar
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, email, name)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data->>'name', split_part(new.email, '@', 1))
  );
  return new;
end;
$$ language plpgsql security definer;

create or replace trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
