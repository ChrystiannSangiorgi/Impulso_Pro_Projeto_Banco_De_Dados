
-- Script SQL para criação do banco de dados Impulso Pro
-- ---
-- Tabelas Principais (PostgreSQL)
-- ---

CREATE TABLE Restaurante (
  ID_Restaurante SERIAL PRIMARY KEY,
  Nome_Restaurante VARCHAR(255) NOT NULL,
  CEP CHAR(9) NOT NULL
);

CREATE TABLE Departamento (
  ID_Departamento SERIAL PRIMARY KEY,
  Nome_Departamento VARCHAR(255) NOT NULL,
  UNIQUE (Nome_Departamento)
);

CREATE TABLE Cargo (
  ID_Cargo SERIAL PRIMARY KEY,
  Nome_Cargo VARCHAR(255) NOT NULL,
  ID_Departamento INT NOT NULL,
  FOREIGN KEY(ID_Departamento) REFERENCES Departamento (ID_Departamento)
);

CREATE TABLE Colaborador_Usuario (
  ID_Colaborador SERIAL PRIMARY KEY,
  Nome_colaborador VARCHAR(255) NOT NULL,
  Data_Nascimento DATE NOT NULL,
  Email VARCHAR(255) NOT NULL,
  Telefone VARCHAR(20) NOT NULL,
  Senha_Hash VARCHAR(255) NOT NULL,
  ID_Restaurante INT NOT NULL,
  ID_Cargo INT NOT NULL,
  UNIQUE (Email),
  FOREIGN KEY(ID_Restaurante) REFERENCES Restaurante (ID_Restaurante),
  FOREIGN KEY(ID_Cargo) REFERENCES Cargo (ID_Cargo)
);

-- ---
-- Tabelas de Treinamento e Sessões (PostgreSQL)
-- ---

CREATE TABLE Trilha_Treinamento (
  ID_Trilha SERIAL PRIMARY KEY,
  Nome_Trilha VARCHAR(255) NOT NULL,
  Conteudo_teorico TEXT
);

CREATE TABLE Treinamento (
  ID_Treinamento SERIAL PRIMARY KEY,
  Nome_Treinamento VARCHAR(255) NOT NULL,
  Categoria VARCHAR(100) NOT NULL,
  Descricao TEXT,
  ID_Trilha INT NOT NULL,
  FOREIGN KEY(ID_Trilha) REFERENCES Trilha_Treinamento (ID_Trilha)
);

CREATE TABLE Sessao_Equipe (
  ID_Sessao SERIAL PRIMARY KEY,
  Local_Treinamento VARCHAR(255) NOT NULL,
  ID_Treinamento INT NOT NULL,
  Nota_Avaliacao FLOAT NOT NULL,
  Data_treinamento DATE NOT NULL,
  Hora_treinamento TIME NOT NULL,
  CHECK (Nota_Avaliacao >= 0),
  FOREIGN KEY(ID_Treinamento) REFERENCES Treinamento (ID_Treinamento)
);

CREATE TABLE Desempenho_Sessao (
  ID_Desempenho SERIAL PRIMARY KEY,
  Progresso FLOAT NOT NULL,
  Feedback_Treinador TEXT,
  Feedback_Colaborador TEXT,
  Resultado_Final BOOLEAN NOT NULL,
  ID_Colaborador INT NOT NULL,
  ID_Sessao INT NOT NULL,
  FOREIGN KEY(ID_Colaborador) REFERENCES Colaborador_Usuario (ID_Colaborador),
  FOREIGN KEY(ID_Sessao) REFERENCES Sessao_Equipe (ID_Sessao)
);

-- ---
-- Tabelas de Permissão e Perfil (PostgreSQL)
-- ---

CREATE TABLE Permissao (
  ID_Permissao SERIAL PRIMARY KEY,
  Nome_Permissao VARCHAR(100) NOT NULL,
  Descricao_Permissao TEXT NOT NULL
);

CREATE TABLE Perfil (
  ID_Perfil SERIAL PRIMARY KEY,
  Nome_Perfil VARCHAR(100) NOT NULL,
  Descricao_perfil TEXT NOT NULL
);

-- ---
-- Tabelas de Junção (Muitos-para-Muitos) (PostgreSQL)
-- ---

CREATE TABLE Colaborador_Treinamento (
  ID_Colaborador INT NOT NULL,
  ID_Treinamento INT NOT NULL,
  PRIMARY KEY (ID_Colaborador, ID_Treinamento),
  FOREIGN KEY(ID_Colaborador) REFERENCES Colaborador_Usuario (ID_Colaborador),
  FOREIGN KEY(ID_Treinamento) REFERENCES Treinamento (ID_Treinamento)
);

CREATE TABLE Presenca_Sessao (
  ID_Colaborador INT NOT NULL,
  ID_Sessao INT NOT NULL,
  PRIMARY KEY (ID_Colaborador, ID_Sessao),
  FOREIGN KEY(ID_Colaborador) REFERENCES Colaborador_Usuario (ID_Colaborador),
  FOREIGN KEY(ID_Sessao) REFERENCES Sessao_Equipe (ID_Sessao)
);

CREATE TABLE Treinador_Sessao (
  ID_Colaborador_Treinador INT NOT NULL,
  ID_Sessao INT NOT NULL,
  PRIMARY KEY (ID_Colaborador_Treinador, ID_Sessao),
  FOREIGN KEY(ID_Colaborador_Treinador) REFERENCES Colaborador_Usuario (ID_Colaborador),
  FOREIGN KEY(ID_Sessao) REFERENCES Sessao_Equipe (ID_Sessao)
);

CREATE TABLE Perfil_Permissoes (
  ID_Perfil INT NOT NULL,
  ID_Permissao INT NOT NULL,
  PRIMARY KEY (ID_Perfil, ID_Permissao),
  FOREIGN KEY(ID_Perfil) REFERENCES Perfil (ID_Perfil),
  FOREIGN KEY(ID_Permissao) REFERENCES Permissao (ID_Permissao)
);

CREATE TABLE Colaborador_Perfil (
  ID_Colaborador INT NOT NULL,
  ID_Perfil INT NOT NULL,
  PRIMARY KEY (ID_Colaborador, ID_Perfil),
  FOREIGN KEY(ID_Colaborador) REFERENCES Colaborador_Usuario (ID_Colaborador),
  FOREIGN KEY(ID_Perfil) REFERENCES Perfil (ID_Perfil)
);