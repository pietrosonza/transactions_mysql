create table lost_product (
	nomeProduto varchar(30),
    marcaProduto varchar(30),
    categoriaProduto varchar(30),
    valorProduto float,
    avaliacaoProduto float);
    drop table lost_product;


delimiter %
/*
 Procedure para inserir um novo produto, se for da categoria eletronico ele irá adicionar
 na base. Após verificará se o valor é maior ou igual a 10000, se for ele dará rollback.
 O item que não for add, será armazenado em uma tabela auxiliar
*/
create procedure test_procedure ( v_pNome varchar(40),
							      v_marca varchar(30),
								  v_categoria varchar(30),
                                  v_valor float,
                                  v_avaliacao float)

case 
	when v_categoria = "Eletronico" then
		START TRANSACTION;
        set @@autocommit = 0;
        select @idProduto:= max(idProduto) + 1 from produto;
        insert into produto values (@idProduto, v_pNome, v_marca, v_categoria, v_valor, v_avaliacao);
        case
			when v_valor > 10000 then 
				select @error := "Item não registrado por exceder o valor da promoção" as "Erro";
				rollback;
            else 
				commit;
            end case;
            
	when v_categoria <> "Eletronico" then
		select @error := "Item não registrado por não ser da categoria da promoção" as "Erro";
        insert into lost_product values (v_pNome, v_marca, v_categoria, v_valor, v_avaliacao);
	end case;
	
    
end %
delimiter ;

