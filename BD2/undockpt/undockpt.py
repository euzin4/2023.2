import json
import psycopg2

with open("/home/aluno/Imagens/undoredo/metadado.json") as dadosini:    #le todo o arquivo em "dadosini"
    dicionario = json.load(dadosini)    #salva os dados em um formato manipulavel
    #id0=dicionario["INITIAL"]["id"][0]
    #id1=dicionario["INITIAL"]["id"][1]
    #a0=dicionario["INITIAL"]["A"][0]    #salva um dado especifico em uma variavel
    #a1=dicionario["INITIAL"]["A"][1]
    #b0=dicionario["INITIAL"]["B"][0]
    #b1=dicionario["INITIAL"]["B"][1]

# Função para criar conexão no banco
def conecta_db():
  con = psycopg2.connect(host='localhost', 
                         database='undoredo',
                         user='postgres', 
                         password='postgres')
  return con

# Função para criar tabela no banco
def exec_sql(sql):
  con = conecta_db()
  cur = con.cursor()
  cur.execute(sql)
  con.commit()
  con.close()

# Dropando a tabela caso ela já exista
sql = 'DROP TABLE IF EXISTS public.tabela'
exec_sql(sql)
# Criando a tabela
sql = '''CREATE TABLE public.tabela 
      ( id int,
        a int,
        b int
      )'''
exec_sql(sql)
#resetando os dados da tabela
#n=0
#for d in dicionario["INITIAL"]["id"]:
#  id=dicionario["INITIAL"]["id"][n]
#  a=dicionario["INITIAL"]["A"][n]
#  b=dicionario["INITIAL"]["B"][n]
#  sql = '''insert into tabela (id,a,b) values(%s,%s,%s);'''
#  n+=1
sql = """insert into tabela select * from json_populate_recordset(NULL::tabela, '{}');""".format(dicionario)
exec_sql(sql)
