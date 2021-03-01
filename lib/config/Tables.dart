final String STATUS =
    "CREATE TABLE IF NOT EXISTS 'status' ( 'idStatus' INTEGER NOT NULL, 'status' TEXT, PRIMARY KEY ('idStatus' AUTOINCREMENT))";

final String CONDICOES =
    " CREATE TABLE IF NOT EXISTS 'condicoesFinanceiras' ('idCondicoesFinanceiras'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 'carencia'	INTEGER, 'vigencia'	INTEGER, 'valor'	INTEGER,'prazo_inicial'	INTEGER, 'prazo_final'	INTEGER)";

final String TIPO =
    "CREATE TABLE IF NOT EXISTS 'tipoContrato' ('idTipoContrato'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'tipo'	TEXT)";

final String ENDERECO =
    "CREATE TABLE IF NOT EXISTS 'endereco' ('idEndereco'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 'cidade'	TEXT NOT NULL, 'bairro'	TEXT NOT NULL, 'numero'	INTEGER NOT NULL, 'rua'	TEXT)";

final String CONTRATANTE =
    "CREATE TABLE IF NOT EXISTS 'contratante' ('idContratante'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'c_razaoSocial'	TEXT NOT NULL,'c_cnpj'	INTEGER NOT NULL,'c_telefone'	INTEGER NOT NULL,'c_endereco_idendereco'	INTEGER,FOREIGN KEY('c_endereco_idendereco') REFERENCES 'endereco'('idEndereco'))";

final String CONTRATADO =
    "CREATE TABLE IF NOT EXISTS 'contratado' ('idContratado'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'razaoSocial'	TEXT NOT NULL,'cnpj'	TEXT NOT NULL,'telefone'	INTEGER NOT NULL,'endereco_idendereco'	INTEGER,FOREIGN KEY('endereco_idendereco') REFERENCES 'endereco'('idEndereco'))";

final String CONTRATO =
    "CREATE TABLE IF NOT EXISTS 'contrato' ('idContrato'	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'contratante_idContratante'	INTEGER,'contratado_idContratado'	INTEGER,'condicoesFinanceiras_idCondicoesFinanceiras'	INTEGER,'status_idStatus'	INTEGER,'tipoContrato_idTipoContrato' INTEGER ,'data_criacao' INTEGER,FOREIGN KEY('tipoContrato_idTipoContrato') REFERENCES 'tipoContrato'('idTipoContrato'),FOREIGN KEY('status_idStatus') REFERENCES 'status'('idStatus'),FOREIGN KEY('condicoesFinanceiras_idCondicoesFinanceiras') REFERENCES 'condicoesFinanceiras'('idCondicoesFinanceiras'),FOREIGN KEY('contratante_idContratante') REFERENCES 'contratante'('idContratante'),FOREIGN KEY('contratado_idContratado') REFERENCES 'contratado'('idContratado'))";
