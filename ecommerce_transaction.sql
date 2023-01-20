use ecommerce;

select @@autocommit;
set @@autocommit = 0;

START transaction;

    select @idProduto:= max(idProduto) +1
    from produto;
    
	-- Inserindo novos produtos
	insert into produto values (@idProduto, 'Placa de Video', 'NVidia', 'Eletronico', 8000, 5),
							   (@idProduto + 1, 'Processador i12', 'Intel', 'Eletronico', 12000, 5);
    
    -- Diminuindo os preços de eletronicos em 15%
	update produto set valor = valor * 0.85 where categoria = "Eletronico";

    -- deletando os eletrononicos cujo valores são maiores que de 10000
    delete from produto where categoria = "Eletronico" AND valor >= 10000;
 
    rollback;
	commit;