create table kinopoisk.person
(
    id          bigint generated always as identity
        primary key,
    person_name text not null,
    surname     text not null
);

comment on table kinopoisk.person is 'Все персоны кроме актеров главных ролей и актеров дубляжа';

alter table kinopoisk.person
    owner to postgres;

create table kinopoisk.film
(
    id                bigint generated always as identity
        primary key,
    film_name         text    not null,
    description       text,
    rating            real,
    number_of_rating  bigint,
    number_of_reviews integer,
    film_year         integer not null,
    country           text    not null,
    slogan            text,
    budget            bigint  not null,
    marketing         bigint  not null,
    "fees_in_USA"     bigint  not null,
    fees_in_world     bigint  not null,
    film_time         integer not null,
    director_id       bigint  not null
        constraint director_fkey
            references kinopoisk.person,
    screenwriter_id   bigint  not null
        constraint screenwriter_fkey
            references kinopoisk.person,
    producer_id       bigint  not null
        constraint producer_fkey
            references kinopoisk.person,
    operator_id       bigint  not null
        constraint operator_fkey
            references kinopoisk.person,
    composer_id       bigint  not null
        constraint composer_fkey
            references kinopoisk.person,
    artist_id         bigint  not null
        constraint atrist_fkey
            references kinopoisk.person,
    editor_id         bigint  not null
        constraint editor_fkey
            references kinopoisk.person
);

alter table kinopoisk.film
    owner to postgres;

create table kinopoisk.audio
(
    id             integer generated always as identity
        primary key,
    audio_language text not null
);

alter table kinopoisk.audio
    owner to postgres;

create table kinopoisk.subtitles
(
    id                 integer generated always as identity
        primary key,
    subtitles_language text not null
);

alter table kinopoisk.subtitles
    owner to postgres;

create table kinopoisk.quality
(
    id            integer generated always as identity
        primary key,
    quality_value text   not null,
    film_id       bigint not null
        constraint film_fkey
            references kinopoisk.film
);

comment on table kinopoisk.quality is 'Качество видео';

alter table kinopoisk.quality
    owner to postgres;

create table kinopoisk.audience
(
    id              integer generated always as identity
        primary key,
    country         text   not null,
    audience_number bigint not null,
    film_id         bigint not null
        constraint film_fkey
            references kinopoisk.film
);

alter table kinopoisk.audience
    owner to postgres;

create table kinopoisk.genre
(
    id         integer generated always as identity
        primary key,
    genre_name text not null
);

alter table kinopoisk.genre
    owner to postgres;

create table kinopoisk."rating_MPAA"
(
    id                  integer generated always as identity
        primary key,
    "rating_MPAA_value" text   not null,
    film_id             bigint not null
        constraint film_fkey
            references kinopoisk.film
);

alter table kinopoisk."rating_MPAA"
    owner to postgres;

create table kinopoisk.role
(
    id           integer generated always as identity
        constraint roles_pkey
            primary key,
    role_name    text    not null,
    surname      text    not null,
    main_role    boolean not null,
    dubbing_role boolean not null
);

comment on table kinopoisk.role is 'Актеры главных ролей и актеры озвучки';

alter table kinopoisk.role
    owner to postgres;

create table kinopoisk.film_roles
(
    id      bigint generated always as identity
        constraint "film-person_pkey"
            primary key,
    film_id bigint not null
        constraint film_fkey
            references kinopoisk.film,
    role_id bigint not null
        constraint role_fkey
            references kinopoisk.role
);

alter table kinopoisk.film_roles
    owner to postgres;

create table kinopoisk.distributor
(
    id               integer generated always as identity
        primary key,
    distributor_name text not null
);

comment on table kinopoisk.distributor is 'Прокатчик';

alter table kinopoisk.distributor
    owner to postgres;

create table kinopoisk.premiere
(
    id              bigint generated always as identity
        primary key,
    premiere_date   timestamp not null,
    country         text      not null,
    distributor_id  integer
        constraint distributor_id
            references kinopoisk.distributor,
    on_data_storage boolean   not null,
    film_id         bigint    not null
        constraint film_fkey
            references kinopoisk.film
);

comment on table kinopoisk.premiere is 'Даты премьер по странам ';

comment on column kinopoisk.premiere.on_data_storage is 'На физическом носителе';

alter table kinopoisk.premiere
    owner to postgres;

create table kinopoisk.film_genre
(
    id         bigint generated always as identity
        primary key,
    film_id    bigint  not null
        constraint film_fkey
            references kinopoisk.film,
    "genre-id" integer not null
        constraint genre_fkey
            references kinopoisk.genre
);

alter table kinopoisk.film_genre
    owner to postgres;

create table kinopoisk.film_audio
(
    id       bigint generated always as identity
        primary key,
    film_id  bigint  not null
        constraint film_fkey
            references kinopoisk.film,
    audio_id integer not null
        constraint audio_fkey
            references kinopoisk.audio
);

alter table kinopoisk.film_audio
    owner to postgres;

create table kinopoisk.film_subtitles
(
    id           bigint generated always as identity
        primary key,
    film_id      bigint  not null
        constraint film_fkey
            references kinopoisk.film,
    subtitles_id integer not null
        constraint subtitles_fkey
            references kinopoisk.subtitles
);

alter table kinopoisk.film_subtitles
    owner to postgres;

create table kinopoisk.image
(
    id        bigint generated always as identity
        primary key,
    image_url text   not null,
    film_id   bigint not null
        constraint film_fkey
            references kinopoisk.film
);

alter table kinopoisk.image
    owner to postgres;

