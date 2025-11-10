-- Tabela de Clients

CREATE TABLE IF NOT EXISTS clients (
  id_cliente SERIAL PRIMARY KEY,
  nome_cliente VARCHAR(150) NOT NULL,
  tipo_cliente VARCHAR(2) CHECK (tipo_cliente IN ('PJ','PF')),
  cpf_cnpj VARCHAR(20) UNIQUE NOT NULL,
  segmento VARCHAR(150),
  email VARCHAR(50),
  telefone VARCHAR(20),
  uf VARCHAR(2),
  cidade VARCHAR(150),
  data_cadastro TIMESTAMP DEFAULT current_timestamp,
  status_cliente VARCHAR(20) DEFAULT 'Ativo'
)

CREATE INDEX idx_clients_status ON
clients(status_cliente)
CREATE INDEX idx_tipo_cliente ON 
clients(tipo_cliente)


-- Tabela de contatos
CREATE TABLE IF NOT EXISTS contatos (
  id_contato SERIAL PRIMARY KEY,
  id_cliente INT REFERENCES clients(id_cliente) ON DELETE CASCADE,
  nome_contato VARCHAR(50) NOT NULL,
  cargo VARCHAR(50) NOT NULL, 
  email VARCHAR(50),
  telefone VARCHAR(20),
  canal_preferido VARCHAR(50),
  data_criacao TIMESTAMP DEFAULT current_timestamp
)
CREATE INDEX idx_contato_cliente ON 
contatos(id_cliente)


-- Tabela de Oportunidades
CREATE TABLE IF NOT EXISTS oportunidades (
  id_oportunidade SERIAL PRIMARY KEY,
  id_cliente INT REFERENCES clients(id_cliente),
  titulo VARCHAR(150),
  valor_estimado NUMERIC(12,2), 
  fase_pipeline VARCHAR(50), 
  data_criacao TIMESTAMP DEFAULT CURRENT_DATE,
  data_fechamento TIMESTAMP,
  origem_oportunidade VARCHAR(150)
)
CREATE INDEX idx_oportunidade_cliente ON 
oportunidades(id_cliente)
CREATE INDEX idx_oportunidades_pipeline ON 
oportunidades(fase_pipeline)


-- Tabela de Interações
CREATE TABLE IF NOT EXISTS interacoes (
  id_interacao SERIAL PRIMARY KEY,
  id_cliente INT REFERENCES clients(id_cliente),
  id_contato INT REFERENCES contatos(id_contato), 
  tipo_interacao VARCHAR(50), 
  data_interacao timestamp DEFAULT current_timestamp,
  descricao VARCHAR(50),
  responsavel VARCHAR(100)
)
CREATE INDEX idx_interacoes_cliente ON 
interacoes(id_cliente) 
CREATE INDEX idx_interacoes_contato ON 
interacoes(id_contato)



-- Tabela de Contratos 
CREATE TABLE IF NOT EXISTS contratos ( 
  id_contrato SERIAL PRIMARY KEY,
  id_oportunidade INT REFERENCES oportunidades(id_oportunidade),
  numero_contrato VARCHAR(50) UNIQUE,
  data_inicio timestamp DEFAULT current_timestamp NOT NULL, 
  data_fim timestamp DEFAULT current_timestamp,
  valor_total NUMERIC(12,2) NOT NULL, 
  status_contrato VARCHAR(20) DEFAULT 'Ativo',
  tipo_contrato VARCHAR(50),
  observacoes TEXT
)
CREATE INDEX idx_contratos_status ON 
contratos(status_contrato)



-- Tabela de viagens 
