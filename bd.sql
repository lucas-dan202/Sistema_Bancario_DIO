-- criação de BD para o cenário de E-commerce
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(30),
        constraint unique_cpf_cliente unique(CPF)
);
alter table clients auto_increment = 1;

-- criar tabela produto
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(10) not null,
        classification_kids bool default false,
        category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
        avaliação float default 0,
        size varchar(10)
);

-- criar tabela pedido
create table orders(
		idOrder int auto_increment primary key,
        idOrderClient int,
        orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
        orderDescription varchar(255),
        sendValue float default 10,
        paymentCash bool default false,
        constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
        on update cascade
);

-- criar tabela estoque
create table productStorage(
		idProdStorage int auto_increment primary key,
        storageLocation varchar(255),
        quantify int default 0
);

-- criar tabela fornecedor
create table supplier(
		idSupplier int auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char(15) not null,
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);
        
-- criar tabela vendedor
create table seller(
		idSeller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15),
        CPF char(9),
        location varchar(255),
        contact char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique (CPF)
);

create table productSeller(
		idPseller int,
        idPproduct int,
        prodQuantity int default 1,
        primary key (idPseller, idPproduct),
        constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
        constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

create table productOrder(
		idPOproduct int,
        idPOorder int,
        poQuantity int default 1,
        poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
        primary key (idPOproduct, idPOorder),
        constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
        constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
		idLproduct int,
        idLstorage int,
        location varchar(255) not null,
        primary key (idLproduct, idLstorage),
        constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
        constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
		idPsSupplier int,
        idPsProduct int,
        quantity int not null,
        primary key (idPsSupplier, idPsProduct),
        constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
        constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

-- Inserir clientes
insert into clients(Fname, Minit, Lname, CPF, Address) values
    ('John', 'A', 'Doe', '12345678901', '123 Main St'),
    ('Jane', 'B', 'Smith', '98765432109', '456 Elm St');

-- Inserir produtos
insert into product(Pname, classification_kids, category, avaliação, size) values
    ('Smartphone', false, 'Eletrônico', 4.5, 'Medium'),
    ('Camiseta', true, 'Vestimenta', 3.8, 'Large');

-- Inserir fornecedores
insert into supplier(SocialName, CNPJ, contact) values
    ('TechSuppliers', '12345678901234', '98765432101'),
    ('FashionWholesalers', '98765432102345', '12345678901');

-- Inserir vendedores
insert into seller(SocialName, AbstName, CNPJ, CPF, location, contact) values
    ('ElectronicsRUs', 'E. R. Us', '12345678901', '987654321', '456 Tech St', '98765432101');

-- Inserir pedidos
insert into orders(idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
    (1, 'Em processamento', 'Pedido de smartphone', 10, false),
    (2, 'Confirmado', 'Pedido de camiseta', 5, true);