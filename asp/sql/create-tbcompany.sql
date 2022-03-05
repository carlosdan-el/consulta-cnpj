CREATE TABLE tbCompany (
	Id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  RazaoSocial VARCHAR(50) NOT NULL,
  Cnpj VARCHAR(14) NOT NULL UNIQUE,
  Logadouro VARCHAR(150) NOT NULL,
  Numero VARCHAR(10),
  Complemento VARCHAR(50),
  Municipio VARCHAR(50) NOT NULL,
  Uf VARCHAR(2) NOT NULL
)