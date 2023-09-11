A partir do banco de dados (Dojo), construa 4 gatilhos para as seguintes funcionalidades:

1- Armazenar o histórico de alterações dos salários. Ou seja, deve ser criado uma tabela adicional para armazenar o usuário que fez a alteração, data, salário antigo e o novo salário.

create table alt_sal (nome varchar(50), data timestamp, old_sal float, new_sal float);

drop trigger tg_alt_sal on empregados;
drop function alt_salario();

create function alt_salario() returns trigger as $$
	begin
		insert into alt_sal values(current_user, now(), OLD.salario, NEW.salario);
		return NEW;
	end
$$ LANGUAGE plpgsql;

create trigger tg_alt_sal before update on empregados for each row execute procedure alt_salario();


2- Armazenar o histórico de alterações do departamento. 



3- Evite a inserção ou atualização de um salário do  empregado que seja maior do que seu chefe. 

4- Faça um trigger para armazenar o total de salário pagos em cada departamento. Caso um novo empregado seja adicionado (ou atualizado), o total gasto no departamento deve ser atualizado.


