create table contactos (
  id_u number(20),
    --constraint contactos_fk1 references usuarios(id_u),
  contacto number(20),
    --constraint contactos_fk2 references ser_visible(contacto),

    constraint contactos_pk primary key(id_u,contacto)
);
alter table contactos add constraint contactos_fk1 foreign key(id_u) references usuarios;
alter table contactos add constraint contactos_fk2 foreign key(contacto) references usuarios(id_u);
alter table contactos add constraint contactos_ck1 check(id_u!=contacto);

create table ser_visible (
  id_u number(20),
  contacto number(20),
  pid number(20) constraint ser_visible_fk2 references post,
  constraint ser_visible_pk primary key (id_u,contacto,pid),
  constraint ser_visible_fk1 foreign key (id_u,contacto) references contactos
);

create table usuarios (
  id_u number(20) constraint usuarios_pk primary key,
  usuario varchar2(30) constraint usuarios_nn1 not null constraint usuarios_uk1 unique,
  e_mail varchar2(60) constraint usuarios_nn2 not null constraint usuarios_uk2 unique,
  nombre varchar2(30) constraint usuarios_nn3 not null,
  apellido1 varchar2(30),
  apellido2 varchar2(30),
  passw varchar2(100) constraint usuarios_nn4 not null
);


create table post (
  id_u number(20) constraint post_fk1 references usuarios constraint post_nn1 not null,
  pid number(20) constraint post_pk primary key,
  texto varchar2(1000) constraint post_nn2 not null,
  pid_rel number(20) constraint post_fk2 references post,
  publicacion date constraint post_nn3 not null,
  duracion interval day to second constraint post_nn4 not null
);
alter table post modify publicacion constraint post_ck2 check(publicacion>to_date('02/02/2017','dd/mm/yyyy'));
alter table post drop constraint post_ck1;
alter table post modify duracion constraint post_ck1 check (duracion>interval '30' minute);