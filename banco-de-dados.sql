-- ============================================================
-- COLE TODO ESTE CONTEÚDO NO SQL EDITOR DO SUPABASE
-- ============================================================

-- TABELA: usuarios
create table if not exists usuarios (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  apelido text,
  funcao text,
  cor text default '#185FA5',
  senha text,
  criado_em timestamptz default now()
);

-- TABELA: clientes
create table if not exists clientes (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  codigo text,
  contato text,
  obs text,
  criado_em timestamptz default now()
);

-- TABELA: admissoes
create table if not exists admissoes (
  id uuid primary key default gen_random_uuid(),
  data_solicitacao date,
  data_admissao date,
  data_entrega date,
  auxiliar_id uuid references usuarios(id) on delete set null,
  responsavel_id uuid references usuarios(id) on delete set null,
  estagiaria_id uuid references usuarios(id) on delete set null,
  cliente_id uuid references clientes(id) on delete set null,
  empregado text not null,
  status text default 'Em andamento',
  observacao text,
  criado_por uuid references usuarios(id) on delete set null,
  criado_em timestamptz default now()
);

-- TABELA: historico
create table if not exists historico (
  id uuid primary key default gen_random_uuid(),
  admissao_id uuid,
  data_solicitacao date,
  data_admissao date,
  data_entrega date,
  auxiliar_id uuid,
  responsavel_id uuid,
  estagiaria_id uuid,
  cliente_id uuid,
  empregado text,
  status text default 'Concluída',
  observacao text,
  criado_por uuid,
  criado_em timestamptz,
  concluido_em timestamptz default now(),
  concluido_por uuid
);

-- Liberar acesso público (necessário para o HTML funcionar sem autenticação avançada)
alter table usuarios  enable row level security;
alter table clientes  enable row level security;
alter table admissoes enable row level security;
alter table historico enable row level security;

create policy "acesso total usuarios"  on usuarios  for all using (true) with check (true);
create policy "acesso total clientes"  on clientes  for all using (true) with check (true);
create policy "acesso total admissoes" on admissoes for all using (true) with check (true);
create policy "acesso total historico" on historico for all using (true) with check (true);
