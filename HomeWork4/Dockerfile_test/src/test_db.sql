--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-10-24 16:36:14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 24614)
-- Name: logins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logins (
    id bigint NOT NULL,
    id_user integer NOT NULL,
    login character varying NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE public.logins OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24613)
-- Name: logins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logins_id_seq OWNER TO postgres;

--
-- TOC entry 4819 (class 0 OID 0)
-- Dependencies: 215
-- Name: logins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logins_id_seq OWNED BY public.logins.id;


--
-- TOC entry 218 (class 1259 OID 24623)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying NOT NULL,
    name_last character varying NOT NULL,
    date_birth timestamp with time zone NOT NULL,
    sex boolean,
    city character varying,
    interests character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24698)
-- Name: users_friends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_friends (
    id bigint NOT NULL,
    id_user integer NOT NULL,
    id_friend integer NOT NULL
);


ALTER TABLE public.users_friends OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24697)
-- Name: users_friends_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_friends_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_friends_id_seq OWNER TO postgres;

--
-- TOC entry 4820 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_friends_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_friends_id_seq OWNED BY public.users_friends.id;


--
-- TOC entry 217 (class 1259 OID 24622)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4821 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 220 (class 1259 OID 24655)
-- Name: users_posts; Type: TABLE; Schema: public; Owner: serg
--

CREATE TABLE public.users_posts (
    id bigint NOT NULL,
    id_user integer NOT NULL,
    post character varying NOT NULL,
    post_created timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users_posts OWNER TO serg;

--
-- TOC entry 219 (class 1259 OID 24654)
-- Name: users_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: serg
--

CREATE SEQUENCE public.users_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_posts_id_seq OWNER TO serg;

--
-- TOC entry 4822 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: serg
--

ALTER SEQUENCE public.users_posts_id_seq OWNED BY public.users_posts.id;


--
-- TOC entry 4649 (class 2604 OID 24617)
-- Name: logins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logins ALTER COLUMN id SET DEFAULT nextval('public.logins_id_seq'::regclass);


--
-- TOC entry 4650 (class 2604 OID 24626)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4653 (class 2604 OID 24701)
-- Name: users_friends id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_friends ALTER COLUMN id SET DEFAULT nextval('public.users_friends_id_seq'::regclass);


--
-- TOC entry 4651 (class 2604 OID 24658)
-- Name: users_posts id; Type: DEFAULT; Schema: public; Owner: serg
--

ALTER TABLE ONLY public.users_posts ALTER COLUMN id SET DEFAULT nextval('public.users_posts_id_seq'::regclass);


--
-- TOC entry 4807 (class 0 OID 24614)
-- Dependencies: 216
-- Data for Name: logins; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.logins VALUES (1, 4, 'admin', '12345qwerty');
INSERT INTO public.logins VALUES (2, 5, 'serg', '7ac60358d4f56501575fa9def6cc3bc3');
INSERT INTO public.logins VALUES (3, 6, 'pup', 'd1377c0281728bb8c20f8df217a7e094');


--
-- TOC entry 4809 (class 0 OID 24623)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Роберт', 'Абрамов', '2012-01-01 00:00:00+06', NULL, 'Воткинск', NULL);
INSERT INTO public.users VALUES (2, 'Александр', 'Абрамов', '1916-01-01 00:00:00+04:02:33', NULL, 'Домодедово', NULL);
INSERT INTO public.users VALUES (3, 'Илья', 'Абрамов', '1912-01-01 00:00:00+04:02:33', NULL, 'Севастополь', NULL);
INSERT INTO public.users VALUES (4, 'Даниил', 'Абрамов', '1918-01-01 00:00:00+03:45:05', NULL, 'Ржев', NULL);
INSERT INTO public.users VALUES (5, 'Лев', 'Абрамов', '2007-01-01 00:00:00+05', NULL, 'Когалым', NULL);
INSERT INTO public.users VALUES (6, 'Игорь', 'Абрамов', '2009-01-01 00:00:00+05', NULL, 'Дзержинск', NULL);
INSERT INTO public.users VALUES (7, 'Никита', 'Абрамов', '1981-01-01 00:00:00+05', NULL, 'Балашов', NULL);
INSERT INTO public.users VALUES (8, 'Юрий', 'Абрамов', '1935-01-01 00:00:00+05', NULL, 'Серпухов', NULL);
INSERT INTO public.users VALUES (9, 'Егор', 'Абрамов', '1962-01-01 00:00:00+05', NULL, 'Ногинск', NULL);
INSERT INTO public.users VALUES (10, 'Всеволод', 'Абрамов', '1906-01-01 00:00:00+04:02:33', NULL, 'Новомосковск', NULL);
INSERT INTO public.users VALUES (11, 'Демид', 'Абрамов', '1928-01-01 00:00:00+04', NULL, 'Обнинск', NULL);
INSERT INTO public.users VALUES (12, 'Александр', 'Абрамов', '1915-01-01 00:00:00+04:02:33', NULL, 'Омск', NULL);
INSERT INTO public.users VALUES (13, 'Лука', 'Абрамов', '1916-01-01 00:00:00+04:02:33', NULL, 'Лесосибирск', NULL);
INSERT INTO public.users VALUES (14, 'Дмитрий', 'Абрамов', '1986-01-01 00:00:00+05', NULL, 'Хасавюрт', NULL);
INSERT INTO public.users VALUES (15, 'Александр', 'Абрамов', '1923-01-01 00:00:00+04', NULL, 'Красноярск', NULL);
INSERT INTO public.users VALUES (16, 'Иван', 'Абрамов', '2002-01-01 00:00:00+05', NULL, 'Барнаул', NULL);
INSERT INTO public.users VALUES (17, 'Лука', 'Абрамов', '1986-01-01 00:00:00+05', NULL, 'Магадан', NULL);
INSERT INTO public.users VALUES (18, 'Георгий', 'Абрамов', '1994-01-01 00:00:00+05', NULL, 'Волжск', NULL);
INSERT INTO public.users VALUES (19, 'Александр', 'Абрамов', '1946-01-01 00:00:00+05', NULL, 'Энгельс', NULL);