-- Criação do banco de dados
create database biblioteca;
use biblioteca;

-- Tabela para autores
create table autores (
    idAutor int auto_increment primary key,
    nomeAutor varchar(100) not null
);

-- Tabela para editoras
create table editoras (
    idEditora int auto_increment primary key,
    nomeEditora varchar(100) not null,
    localizacao varchar(100)
);

-- Tabela para gêneros dos livros
create table generos (
    idGenero int auto_increment primary key,
    nomeGenero varchar(50) not null
);

-- Tabela para livros
create table livros (
    idLivro int auto_increment primary key,
    titulo varchar(255) not null,
    idAutor int,
    idEditora int,
    idGenero int,
    anoPublicacao int,
    foreign key (idAutor) references autores(idAutor),
    foreign key (idEditora) references editoras(idEditora),
    foreign key (idGenero) references generos(idGenero)
);

-- Tabela para leitores
create table leitores (
    idLeitor int auto_increment primary key,
    nomeLeitor varchar(100) not null,
    dataNascimento date,
    email varchar(100)
);

-- Tabela para empréstimos
create table emprestimos (
    idEmprestimo int auto_increment primary key,
    idLivro int,
    idLeitor int,
    dataEmprestimo date,
    dataDevolucao date,
    foreign key (idLivro) references livros(idLivro),
    foreign key (idLeitor) references leitores(idLeitor)
);

-- Inserção de autores
insert into autores (nomeAutor) values
    ('Machado de Assis'),
    ('Clarice Lispector'),
    ('José Saramago'),
    ('Gabriel Garcia Marquez'),
    ('J.K. Rowling'),
    ('George Orwell'),
    ('Agatha Christie'),
    ('Haruki Murakami'),
    ('Jane Austen'),
    ('Stephen King');

-- Inserção de editoras
insert into editoras (nomeEditora, localizacao) values
    ('Companhia das Letras', 'São Paulo'),
    ('Editora Record', 'Rio de Janeiro'),
    ('Editora Leya', 'Lisboa'),
    ('Penguin Random House', 'Nova York'),
    ('Bloomsbury', 'Londres'),
    ('Houghton Mifflin Harcourt', 'Boston'),
    ('HarperCollins', 'Londres'),
    ('Kodansha', 'Tóquio'),
    ('Vintage', 'Nova York'),
    ('Scribner', 'Nova York');

-- Inserção de gêneros de livros
insert into generos (nomeGenero) values
    ('Ficção'),
    ('Mistério'),
    ('Romance'),
    ('Fantasia'),
    ('Distopia'),
    ('Suspense'),
    ('Aventura'),
    ('História'),
    ('Sci-Fi'),
    ('Clássico');

-- Inserção de livros
insert into livros (titulo, idAutor, idEditora, idGenero, anoPublicacao) values
    ('Dom Casmurro', 1, 1, 3, 1899),
    ('A Hora da Estrela', 2, 2, 3, 1977),
    ('Ensaio sobre a Cegueira', 3, 3, 1, 1995),
    ('Cem Anos de Solidão', 4, 4, 3, 1967),
    ('Harry Potter e a Pedra Filosofal', 5, 5, 4, 1997),
    ('1984', 6, 6, 5, 1949),
    ('Assassinato no Expresso do Oriente', 7, 7, 2, 1934),
    ('Norwegian Wood', 8, 8, 6, 1987),
    ('Orgulho e Preconceito', 9, 9, 3, 1813),
    ('O Iluminado', 10, 10, 2, 1977);

-- Inserção de leitores
insert into leitores (nomeLeitor, dataNascimento, email) values
    ('Ana Silva', '1990-05-15', 'ana@email.com'),
    ('João Santos', '1985-09-20', 'joao@email.com'),
    ('Maria Oliveira', '1998-02-10', 'maria@email.com'),
    ('Pedro Almeida', '1982-11-30', 'pedro@email.com'),
    ('Carla Rodrigues', '2000-07-25', 'carla@email.com'),
    ('Ricardo Pereira', '1976-04-18', 'ricardo@email.com'),
    ('Camila Souza', '1995-08-05', 'camila@email.com'),
    ('Fernando Lima', '1989-01-22', 'fernando@email.com'),
    ('Isabela Gonçalves', '1993-12-02', 'isabela@email.com'),
    ('Lucas Marques', '1997-06-12', 'lucas@email.com');

-- Inserção de empréstimos
insert into emprestimos (idLivro, idLeitor, dataEmprestimo, dataDevolucao) values
    (1, 1, '2023-08-01', '2023-08-15'),
    (2, 2, '2023-08-03', '2023-08-17'),
    (3, 3, '2023-08-05', '2023-08-20'),
    (4, 4, '2023-08-07', '2023-08-22'),
    (5, 5, '2023-08-09', '2023-08-24'),
    (6, 6, '2023-08-11', '2023-08-26'),
    (7, 7, '2023-08-13', '2023-08-28'),
    (8, 8, '2023-08-15', '2023-08-30'),
    (9, 9, '2023-08-17', '2023-09-03'),
    (10, 10, '2023-08-19', '2023-09-05');
    
-- consultas
select livros.titulo, autores.nomeAutor, editoras.nomeEditora
from livros
inner join autores on livros.idAutor = autores.idAutor
inner join editoras on livros.idEditora = editoras.idEditora;

select titulo, anoPublicacao
from livros
where anoPublicacao > 1950;

select count(*) as total_emprestados
from emprestimos;

select titulo, anoPublicacao
from livros
order by anoPublicacao;

select autores.nomeAutor, count(livros.idLivro) as total_livros
from autores
inner join livros on autores.idAutor = livros.idAutor
group by autores.nomeAutor
order by total_livros desc
limit 3;
