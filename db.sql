CREATE DATABASE kinopoisk;

CREATE TABLE person
(
    id          bigint GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    person_name text NOT NULL,
    surname     text NOT NULL
);

COMMENT ON TABLE person IS 'Все персоны кроме актеров главных ролей и актеров дубляжа';

ALTER TABLE person
    OWNER TO postgres;

CREATE TABLE film
(
    id                bigint GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    film_name         text       NOT NULL,
    description       text,
    rating            real,
    number_of_rating  bigint,
    number_of_reviews integer,
    film_year         varchar(4) NOT NULL,
    country           text       NOT NULL,
    slogan            text,
    budget            bigint     NOT NULL,
    marketing         bigint     NOT NULL,
    "fees_in_USA"     bigint     NOT NULL,
    fees_in_world     bigint     NOT NULL,
    film_time         integer    NOT NULL,
    director_id       bigint     NOT NULL
        CONSTRAINT director_fkey
            REFERENCES person,
    screenwriter_id   bigint     NOT NULL
        CONSTRAINT screenwriter_fkey
            REFERENCES person,
    producer_id       bigint     NOT NULL
        CONSTRAINT producer_fkey
            REFERENCES person,
    operator_id       bigint     NOT NULL
        CONSTRAINT operator_fkey
            REFERENCES person,
    composer_id       bigint     NOT NULL
        CONSTRAINT composer_fkey
            REFERENCES person,
    artist_id         bigint     NOT NULL
        CONSTRAINT atrist_fkey
            REFERENCES person,
    editor_id         bigint     NOT NULL
        CONSTRAINT editor_fkey
            REFERENCES person
);

ALTER TABLE film
    OWNER TO postgres;

CREATE TABLE audio
(
    id             integer GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    audio_language text NOT NULL
);

ALTER TABLE audio
    OWNER TO postgres;

CREATE TABLE subtitles
(
    id                 integer GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    subtitles_language text NOT NULL
);

ALTER TABLE subtitles
    OWNER TO postgres;

CREATE TABLE quality
(
    id            integer GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    quality_value text   NOT NULL,
    film_id       bigint NOT NULL
        CONSTRAINT film_fkey
            REFERENCES film
);

COMMENT ON TABLE quality IS 'Качество видео';

ALTER TABLE quality
    OWNER TO postgres;

CREATE TABLE audience
(
    id              integer GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    country         text   NOT NULL,
    audience_number bigint NOT NULL,
    film_id         bigint NOT NULL
        CONSTRAINT film_fkey
            REFERENCES film
);

ALTER TABLE audience
    OWNER TO postgres;

CREATE TABLE genre
(
    id         integer GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    genre_name text NOT NULL
);

ALTER TABLE genre
    OWNER TO postgres;

CREATE TABLE "rating_MPAA"
(
    id                  integer GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    "rating_MPAA_value" text   NOT NULL,
    film_id             bigint NOT NULL
        CONSTRAINT film_fkey
            REFERENCES film
);

ALTER TABLE "rating_MPAA"
    OWNER TO postgres;

CREATE TABLE role
(
    id           integer GENERATED ALWAYS AS IDENTITY
        CONSTRAINT roles_pkey
            PRIMARY KEY,
    role_name    text    NOT NULL,
    surname      text    NOT NULL,
    main_role    boolean NOT NULL,
    dubbing_role boolean NOT NULL
);

COMMENT ON TABLE role IS 'Актеры главных ролей и актеры озвучки';

ALTER TABLE role
    OWNER TO postgres;

CREATE TABLE film_roles
(
    id      bigint GENERATED ALWAYS AS IDENTITY
        CONSTRAINT "film-person_pkey"
            PRIMARY KEY,
    film_id bigint NOT NULL
        CONSTRAINT film_fkey
            REFERENCES film,
    role_id bigint NOT NULL
        CONSTRAINT role_fkey
            REFERENCES role
);

ALTER TABLE film_roles
    OWNER TO postgres;

CREATE TABLE distributor
(
    id               integer GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    distributor_name text NOT NULL
);

COMMENT ON TABLE distributor IS 'Прокатчик';

ALTER TABLE distributor
    OWNER TO postgres;

CREATE TABLE premiere
(
    id              bigint GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    premiere_date   timestamp NOT NULL,
    country         text      NOT NULL,
    distributor_id  integer
        CONSTRAINT distributor_id
            REFERENCES distributor,
    on_data_storage boolean   NOT NULL,
    film_id         bigint    NOT NULL
        CONSTRAINT film_fkey
            REFERENCES film
);

COMMENT ON TABLE premiere IS 'Даты премьер по странам ';

COMMENT ON COLUMN premiere.on_data_storage IS 'На физическом носителе';

ALTER TABLE premiere
    OWNER TO postgres;

CREATE TABLE film_genre
(
    id         bigint GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    film_id    bigint  NOT NULL
        CONSTRAINT film_fkey
            REFERENCES film,
    "genre-id" integer NOT NULL
        CONSTRAINT genre_fkey
            REFERENCES genre
);

ALTER TABLE film_genre
    OWNER TO postgres;

CREATE TABLE film_audio
(
    id       bigint GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    film_id  bigint  NOT NULL
        CONSTRAINT film_fkey
            REFERENCES film,
    audio_id integer NOT NULL
        CONSTRAINT audio_fkey
            REFERENCES audio
);

ALTER TABLE film_audio
    OWNER TO postgres;

CREATE TABLE film_subtitles
(
    id           bigint GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    film_id      bigint  NOT NULL
        CONSTRAINT film_fkey
            REFERENCES film,
    subtitles_id integer NOT NULL
        CONSTRAINT subtitles_fkey
            REFERENCES subtitles
);

ALTER TABLE film_subtitles
    OWNER TO postgres;

CREATE TABLE image
(
    id        bigint GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,
    image_url text   NOT NULL,
    film_id   bigint NOT NULL
        CONSTRAINT film_fkey
            REFERENCES film
);

ALTER TABLE image
    OWNER TO postgres;

