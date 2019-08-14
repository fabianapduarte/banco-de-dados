use atividade;


-- Inserir dados
delimiter $
create procedure inserir_cliente(
	in nome varchar(50),
	in endereco varchar(50),
	in cidade varchar(50),
	in estado char(2),
	in sexo char(1),
	in datanascimento date,
	in cpf varchar(14),
	in email varchar(30)
)

begin
	insert into tb_cliente(nome, endereco, cidade, estado, sexo, datanascimento, cpf, email)
	values (nome, endereco, cidade, estado, sexo, datanascimento, cpf, email);
end
$


delimiter $
create procedure inserir_projeto (
	in descricao text,
	in datainicio date,
	in datafinal date
)

begin
	insert into tb_projeto(descricao, datainicio, datafinal)
	values (descricao, datainicio, datafinal);
end
$


delimiter $
create procedure inserir_cliente_projeto (
	in carga_horaria int(11)
)

begin
	insert into tb_cliente_projeto (carga_horaria)
	values (carga_horaria);
end
$

-- Excluir dados
delimiter $
create procedure excluir_cliente (id int)
begin
    delete from tb_cliente
    where codigo = id;
end
$


delimiter $
create procedure excluir_projeto (id int)
begin
    delete from tb_projeto
    where codigo = id;
end
$


delimiter $
create procedure excluir_cliente_projeto (id int)
begin
    delete from tb_cliente_projeto
    where codigo_cliente = id;
end
$


-- Alterar dados
delimiter $
create procedure alterar_cliente (
    in a varchar(50),
	in b varchar(50),
	in b varchar(50),
	in d char(2),
	in e char(1),
	in f date,
	in g varchar(14),
	in h varchar(30),
    in id int
)
begin
    update tb_cliente
    set nome = a, endereco = b, cidade = c, estado = d, sexo = e, datanascimento = f, cpf = g, email = h
    where codigo = id;
end
$


delimiter $
create procedure alterar_projeto (
    in d text,
	in di date,
	in df date,
    in id int
)
begin
    update tb_projeto
    set descricao = d, datainicio = di, datafinal = df
    where codigo = id;
end
$


delimiter $
create procedure alterar_cliente_projeto (
    in ch int,
    in id int
)
begin
    update tb_cliente_projeto
    set carga_horaria = ch
    where codigo = id;
end
$


-- Visão que seleciona o código, o nome e o e-mail de todos os clientes
