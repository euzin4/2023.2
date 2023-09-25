A partir do banco de dados (Dojo), construa 4 gatilhos para as seguintes funcionalidades:

1- Armazenar o histórico de alterações dos salários. Ou seja, deve ser criado uma tabela adicional para 
armazenar o usuário que fez a alteração, data, salário antigo e o novo salário.

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

create table alt_dep (nome varchar(50), data timestamp, dep_id_mod int, acao varchar(10));

drop trigger tg_alt_dep on empregados;
drop function fnc_alt_dep();

create or replace function fnc_alt_dep() returns trigger as $$
	begin
		if (TG_OP='INSERT') then
			insert into alt_dep values(current_user, now(), NEW.dep_id, 'insert');
			return NEW;
		elseif (TG_OP='UPDATE') then
			insert into alt_dep values(current_user, now(), OLD.dep_id, 'update');
			return NEW;
		elseif (TG_OP='DELETE') then
			insert into alt_dep values(current_user, now(), OLD.dep_id, 'delete');
		end if;
		return NULL;
	end
$$ language plpgsql;

CREATE TRIGGER tg_alt_dep AFTER INSERT OR UPDATE OR DELETE ON departamentos FOR EACH ROW EXECUTE PROCEDURE fnc_alt_dep();

3- Evite a inserção ou atualização de um salário do  empregado que seja maior do que seu chefe. 

4- Faça um trigger para armazenar o total de salário pagos em cada departamento. Caso um novo empregado 
seja adicionado (ou atualizado), o total gasto no departamento deve ser atualizado.

