CREATE DATABASE kinopoisk;

create table person
(
    id          bigint generated always as identity
        primary key,
    person_name text not null,
    surname     text not null
);

comment on table person is 'Все персоны кроме актеров главных ролей и актеров дубляжа';

alter table person
    owner to postgres;

create table film
(
    id                bigint generated always as identity
        primary key,
    film_name         text    not null,
    description       text,
    rating            real,
    number_of_rating  bigint,
    number_of_reviews integer,
    film_year         varchar(4) not null,
    country           text    not null,
    slogan            text,
    budget            bigint  not null,
    marketing         bigint  not null,
    "fees_in_USA"     bigint  not null,
    fees_in_world     bigint  not null,
    film_time         integer not null,
    director_id       bigint  not null
        constraint director_fkey
            references person,
    screenwriter_id   bigint  not null
        constraint screenwriter_fkey
            references person,
    producer_id       bigint  not null
        constraint producer_fkey
            references person,
    operator_id       bigint  not null
        constraint operator_fkey
            references person,
    composer_id       bigint  not null
        constraint composer_fkey
            references person,
    artist_id         bigint  not null
        constraint atrist_fkey
            references person,
    editor_id         bigint  not null
        constraint editor_fkey
            references person
);

alter table film
    owner to postgres;

create table audio
(
    id             integer generated always as identity
        primary key,
    audio_language text not null
);

alter table audio
    owner to postgres;

create table subtitles
(
    id                 integer generated always as identity
        primary key,
    subtitles_language text not null
);

alter table subtitles
    owner to postgres;

create table quality
(
    id            integer generated always as identity
        primary key,
    quality_value text   not null,
    film_id       bigint not null
        constraint film_fkey
            references film
);

comment on table quality is 'Качество видео';

alter table quality
    owner to postgres;

create table audience
(
    id              integer generated always as identity
        primary key,
    country         text   not null,
    audience_number bigint not null,
    film_id         bigint not null
        constraint film_fkey
            references film
);

alter table audience
    owner to postgres;

create table genre
(
    id         integer generated always as identity
        primary key,
    genre_name text not null
);

alter table genre
    owner to postgres;

create table "rating_MPAA"
(
    id                  integer generated always as identity
        primary key,
    "rating_MPAA_value" text   not null,
    film_id             bigint not null
        constraint film_fkey
            references film
);

alter table "rating_MPAA"
    owner to postgres;

create table role
(
    id           integer generated always as identity
        constraint roles_pkey
            primary key,
    role_name    text    not null,
    surname      text    not null,
    main_role    boolean not null,
    dubbing_role boolean not null
);

comment on table role is 'Актеры главных ролей и актеры озвучки';

alter table role
    owner to postgres;

create table film_roles
(
    id      bigint generated always as identity
        constraint "film-person_pkey"
            primary key,
    film_id bigint not null
        constraint film_fkey
            references film,
    role_id bigint not null
        constraint role_fkey
            references role
);

alter table film_roles
    owner to postgres;

create table distributor
(
    id               integer generated always as identity
        primary key,
    distributor_name text not null
);

comment on table distributor is 'Прокатчик';

alter table distributor
    owner to postgres;

create table premiere
(
    id              bigint generated always as identity
        primary key,
    premiere_date   timestamp not null,
    country         text      not null,
    distributor_id  integer
        constraint distributor_id
            references distributor,
    on_data_storage boolean   not null,
    film_id         bigint    not null
        constraint film_fkey
            references film
);

comment on table premiere is 'Даты премьер по странам ';

comment on column premiere.on_data_storage is 'На физическом носителе';

alter table premiere
    owner to postgres;

create table film_genre
(
    id         bigint generated always as identity
        primary key,
    film_id    bigint  not null
        constraint film_fkey
            references film,
    "genre-id" integer not null
        constraint genre_fkey
            references genre
);

alter table film_genre
    owner to postgres;

create table film_audio
(
    id       bigint generated always as identity
        primary key,
    film_id  bigint  not null
        constraint film_fkey
            references film,
    audio_id integer not null
        constraint audio_fkey
            references audio
);

alter table film_audio
    owner to postgres;

create table film_subtitles
(
    id           bigint generated always as identity
        primary key,
    film_id      bigint  not null
        constraint film_fkey
            references film,
    subtitles_id integer not null
        constraint subtitles_fkey
            references subtitles
);

alter table film_subtitles
    owner to postgres;

create table image
(
    id        bigint generated always as identity
        primary key,
    image_url text   not null,
    film_id   bigint not null
        constraint film_fkey
            references film
);

alter table image
    owner to postgres;

