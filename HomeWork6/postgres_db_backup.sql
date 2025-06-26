--
-- PostgreSQL database cluster dump
--

-- Started on 2025-06-26 11:57:17

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:NTRTCAy39IL5r+esCsRozg==$+nkyiNiWeZB+P8WH6EiAy2AfQHv/FD4CkpXJBajiK+o=:HPC9umGr6j/FBHyvX/xwPHPvogUytdDBuZhCtCDAybU=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.4

-- Started on 2025-06-26 11:57:17

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

-- Completed on 2025-06-26 11:57:17

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.4

-- Started on 2025-06-26 11:57:17

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

--
-- TOC entry 3 (class 3079 OID 16440)
-- Name: citus; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citus WITH SCHEMA pg_catalog;


--
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION citus; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citus IS 'Citus distributed database';


--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: citus_columnar; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citus_columnar WITH SCHEMA pg_catalog;


--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION citus_columnar; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citus_columnar IS 'Citus Columnar extension';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 278 (class 1259 OID 17247)
-- Name: users_friends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_friends (
    id bigint NOT NULL,
    id_user integer NOT NULL,
    id_friend integer NOT NULL
);


ALTER TABLE public.users_friends OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 17252)
-- Name: users_posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_posts (
    id bigint NOT NULL,
    id_user integer NOT NULL,
    post character varying NOT NULL,
    post_created timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users_posts OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 25429)
-- Name: feed_posts; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.feed_posts AS
 SELECT uf.id_user,
    up.post,
    up.post_created
   FROM (public.users_posts up
     JOIN public.users_friends uf ON ((up.id_user = uf.id_friend)))
  ORDER BY up.post_created
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.feed_posts OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 17236)
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
-- TOC entry 276 (class 1259 OID 17241)
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
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 276
-- Name: logins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logins_id_seq OWNED BY public.logins.id;


--
-- TOC entry 277 (class 1259 OID 17242)
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
-- TOC entry 279 (class 1259 OID 17250)
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
-- TOC entry 3603 (class 0 OID 0)
-- Dependencies: 279
-- Name: users_friends_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_friends_id_seq OWNED BY public.users_friends.id;


--
-- TOC entry 280 (class 1259 OID 17251)
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
-- TOC entry 3604 (class 0 OID 0)
-- Dependencies: 280
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 282 (class 1259 OID 17258)
-- Name: users_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_posts_id_seq OWNER TO postgres;

--
-- TOC entry 3605 (class 0 OID 0)
-- Dependencies: 282
-- Name: users_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_posts_id_seq OWNED BY public.users_posts.id;


--
-- TOC entry 3417 (class 2604 OID 17259)
-- Name: logins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logins ALTER COLUMN id SET DEFAULT nextval('public.logins_id_seq'::regclass);


--
-- TOC entry 3418 (class 2604 OID 17260)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3419 (class 2604 OID 17261)
-- Name: users_friends id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_friends ALTER COLUMN id SET DEFAULT nextval('public.users_friends_id_seq'::regclass);


--
-- TOC entry 3420 (class 2604 OID 17262)
-- Name: users_posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_posts ALTER COLUMN id SET DEFAULT nextval('public.users_posts_id_seq'::regclass);


--
-- TOC entry 3586 (class 0 OID 17236)
-- Dependencies: 275
-- Data for Name: logins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logins (id, id_user, login, password) FROM stdin;
1	4	admin	12345qwerty
2	5	postgres	7ac60358d4f56501575fa9def6cc3bc3
3	6	pup	d1377c0281728bb8c20f8df217a7e094
\.


--
-- TOC entry 3588 (class 0 OID 17242)
-- Dependencies: 277
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, name_last, date_birth, sex, city, interests) FROM stdin;
1	Роберт	Абрамов	2011-12-31 18:00:00+00	\N	Воткинск	\N
2	Александр	Абрамов	1915-12-31 19:57:27+00	\N	Домодедово	\N
3	Илья	Абрамов	1911-12-31 19:57:27+00	\N	Севастополь	\N
4	Даниил	Абрамов	1917-12-31 20:14:55+00	\N	Ржев	\N
5	Лев	Абрамов	2006-12-31 19:00:00+00	\N	Когалым	\N
6	Игорь	Абрамов	2008-12-31 19:00:00+00	\N	Дзержинск	\N
7	Никита	Абрамов	1980-12-31 19:00:00+00	\N	Балашов	\N
8	Юрий	Абрамов	1934-12-31 19:00:00+00	\N	Серпухов	\N
9	Егор	Абрамов	1961-12-31 19:00:00+00	\N	Ногинск	\N
10	Всеволод	Абрамов	1905-12-31 19:57:27+00	\N	Новомосковск	\N
11	Демид	Абрамов	1927-12-31 20:00:00+00	\N	Обнинск	\N
12	Александр	Абрамов	1914-12-31 19:57:27+00	\N	Омск	\N
13	Лука	Абрамов	1915-12-31 19:57:27+00	\N	Лесосибирск	\N
14	Дмитрий	Абрамов	1985-12-31 19:00:00+00	\N	Хасавюрт	\N
15	Александр	Абрамов	1922-12-31 20:00:00+00	\N	Красноярск	\N
16	Иван	Абрамов	2001-12-31 19:00:00+00	\N	Барнаул	\N
17	Лука	Абрамов	1985-12-31 19:00:00+00	\N	Магадан	\N
18	Георгий	Абрамов	1993-12-31 19:00:00+00	\N	Волжск	\N
19	Александр	Абрамов	1945-12-31 19:00:00+00	\N	Энгельс	\N
20	Ярослав	Абрамов	1967-12-31 19:00:00+00	\N	Севастополь	\N
21	Платон	Абрамов	1929-12-31 20:00:00+00	\N	Искитим	\N
22	Тимофей	Абрамов	1908-12-31 19:57:27+00	\N	Лиски	\N
23	Мирослав	Абрамов	1999-12-31 19:00:00+00	\N	Челябинск	\N
24	Кирилл	Абрамов	1974-12-31 19:00:00+00	\N	Елец	\N
25	Евгений	Абрамов	1963-12-31 19:00:00+00	\N	Междуреченск	\N
26	Александр	Абрамов	1975-12-31 19:00:00+00	\N	Верхняя Пышма	\N
27	Роман	Абрамов	1993-12-31 19:00:00+00	\N	Ленинск-Кузнецкий	\N
28	Антон	Абрамов	1972-12-31 19:00:00+00	\N	Ижевск	\N
29	Николай	Абрамов	1944-12-31 19:00:00+00	\N	Красноярск	\N
30	Андрей	Абрамов	1979-12-31 19:00:00+00	\N	Южно-Сахалинск	\N
31	Савва	Абрамов	1931-12-31 19:00:00+00	\N	Томск	\N
32	Дмитрий	Абрамов	2007-12-31 19:00:00+00	\N	Бузулук	\N
33	Артём	Абрамов	2006-12-31 19:00:00+00	\N	Комсомольск-на-Амуре	\N
34	Егор	Абрамов	2011-12-31 18:00:00+00	\N	Ишим	\N
35	Богдан	Абрамов	1979-12-31 19:00:00+00	\N	Свободный	\N
36	Тимофей	Абрамов	1919-12-31 20:00:00+00	\N	Геленджик	\N
37	Кирилл	Абрамов	1930-12-31 19:00:00+00	\N	Бийск	\N
38	Владимир	Абрамов	1945-12-31 19:00:00+00	\N	Борисоглебск	\N
39	Никита	Абрамов	1945-12-31 19:00:00+00	\N	Калуга	\N
40	Кирилл	Абрамов	2006-12-31 19:00:00+00	\N	Евпатория	\N
41	Александр	Абрамов	1919-12-31 20:00:00+00	\N	Юрга	\N
42	Артемий	Абрамов	1935-12-31 19:00:00+00	\N	Мичуринск	\N
43	Никита	Абрамов	1991-12-31 20:00:00+00	\N	Клинцы	\N
44	Григорий	Абрамов	1909-12-31 19:57:27+00	\N	Ковров	\N
45	Даниил	Абрамов	1921-12-31 20:00:00+00	\N	Люберцы	\N
46	Иван	Абрамов	1954-12-31 19:00:00+00	\N	Сосновый Бор	\N
47	Константин	Абрамов	1926-12-31 20:00:00+00	\N	Дубна	\N
48	Тихон	Абрамов	1932-12-31 19:00:00+00	\N	Нижневартовск	\N
49	Максим	Абрамов	1910-12-31 19:57:27+00	\N	Новокузнецк	\N
50	Матвей	Абрамов	1927-12-31 20:00:00+00	\N	Раменское	\N
51	Богдан	Абрамов	1907-12-31 19:57:27+00	\N	Кириши	\N
52	Михаил	Абрамов	1957-12-31 19:00:00+00	\N	Раменское	\N
53	Георгий	Абрамов	2005-12-31 19:00:00+00	\N	Лысьва	\N
54	Михаил	Абрамов	2012-12-31 18:00:00+00	\N	Киселевск	\N
55	Тимофей	Абрамов	1962-12-31 19:00:00+00	\N	Сургут	\N
56	Александр	Абрамов	1904-12-31 19:57:27+00	\N	Вологда	\N
57	Тимур	Абрамов	1911-12-31 19:57:27+00	\N	Анапа	\N
58	Артём	Абрамов	1958-12-31 19:00:00+00	\N	Лесосибирск	\N
59	Роман	Абрамов	1985-12-31 19:00:00+00	\N	Красногорск	\N
60	Илья	Абрамов	1951-12-31 19:00:00+00	\N	Жуковский	\N
61	Елисей	Абрамов	1976-12-31 19:00:00+00	\N	Чита	\N
62	Лев	Абрамов	1961-12-31 19:00:00+00	\N	Новоуральск	\N
63	Константин	Абрамов	1996-12-31 19:00:00+00	\N	Геленджик	\N
64	Иван	Абрамов	1979-12-31 19:00:00+00	\N	Волгодонск	\N
65	Николай	Абрамов	1923-12-31 20:00:00+00	\N	Красноярск	\N
66	Георгий	Абрамов	1950-12-31 19:00:00+00	\N	Дмитров	\N
67	Александр	Абрамов	1937-12-31 19:00:00+00	\N	Гатчина	\N
68	Вячеслав	Абрамов	1925-12-31 20:00:00+00	\N	Красногорск	\N
69	Тихон	Абрамов	1984-12-31 19:00:00+00	\N	Липецк	\N
70	Даниил	Абрамов	1968-12-31 19:00:00+00	\N	Черкесск	\N
71	Пётр	Абрамов	1988-12-31 19:00:00+00	\N	Белогорск (Амурская область)	\N
72	Михаил	Абрамов	1910-12-31 19:57:27+00	\N	Орехово-Зуево	\N
73	Степан	Абрамов	2006-12-31 19:00:00+00	\N	Махачкала	\N
74	Всеволод	Абрамов	1942-12-31 19:00:00+00	\N	Кумертау	\N
75	Антон	Абрамов	1951-12-31 19:00:00+00	\N	Бийск	\N
76	Тимофей	Абрамов	1962-12-31 19:00:00+00	\N	Тула	\N
77	Артём	Абрамов	2008-12-31 19:00:00+00	\N	Россошь	\N
78	Ярослав	Абрамов	1967-12-31 19:00:00+00	\N	Минусинск	\N
79	Егор	Абрамов	1921-12-31 20:00:00+00	\N	Копейск	\N
80	Иван	Абрамов	1950-12-31 19:00:00+00	\N	Кумертау	\N
81	Ярослав	Абрамов	1905-12-31 19:57:27+00	\N	Белорецк	\N
82	Александр	Абрамов	1984-12-31 19:00:00+00	\N	Ставрополь	\N
83	Семён	Абрамов	1990-12-31 19:00:00+00	\N	Каспийск	\N
84	Арсений	Абрамов	1970-12-31 19:00:00+00	\N	Тихорецк	\N
85	Александр	Абрамов	1939-12-31 19:00:00+00	\N	Кузнецк	\N
86	Елисей	Абрамов	1966-12-31 19:00:00+00	\N	Тихорецк	\N
87	Матвей	Абрамов	1927-12-31 20:00:00+00	\N	Ставрополь	\N
88	Андрей	Абрамов	1928-12-31 20:00:00+00	\N	Ачинск	\N
89	Арсений	Абрамов	1925-12-31 20:00:00+00	\N	Донской	\N
90	Дмитрий	Абрамов	1911-12-31 19:57:27+00	\N	Выборг	\N
91	Евгений	Абрамов	1922-12-31 20:00:00+00	\N	Железногорск (Красноярский край)	\N
92	Михаил	Абрамов	1962-12-31 19:00:00+00	\N	Арзамас	\N
93	Максим	Абрамов	1942-12-31 19:00:00+00	\N	Санкт-Петербург	\N
94	Никита	Абрамов	2012-12-31 18:00:00+00	\N	Ставрополь	\N
95	Андрей	Абрамов	1905-12-31 19:57:27+00	\N	Златоуст	\N
96	Николай	Абрамов	1937-12-31 19:00:00+00	\N	Казань	\N
97	Лев	Абрамов	2003-12-31 19:00:00+00	\N	Биробиджан	\N
98	Матвей	Абрамов	1974-12-31 19:00:00+00	\N	Альметьевск	\N
99	Михаил	Абрамов	1907-12-31 19:57:27+00	\N	Горно-Алтайск	\N
100	Дмитрий	Абрамов	2002-12-31 19:00:00+00	\N	Бор	\N
\.


--
-- TOC entry 3589 (class 0 OID 17247)
-- Dependencies: 278
-- Data for Name: users_friends; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_friends (id, id_user, id_friend) FROM stdin;
1	1	2
2	1	3
\.


--
-- TOC entry 3592 (class 0 OID 17252)
-- Dependencies: 281
-- Data for Name: users_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_posts (id, id_user, post, post_created) FROM stdin;
1	2	Есть у нас бананы !!	2025-06-10 06:19:45.877817+00
2	2	И даже ананасы !!	2025-06-10 06:19:45.888915+00
3	2	И апельсины !!	2025-06-10 06:20:23.776202+00
4	2	Заказывайте !!	2025-06-10 06:20:56.621993+00
5	3	Сегодня очень хороший день!	2025-06-10 07:50:19.529269+00
6	3	Сегодня очень хороший день!	2025-06-19 12:06:02.87774+00
7	3	Все время идет дождь!	2025-06-19 12:06:06.086055+00
\.


--
-- TOC entry 3606 (class 0 OID 0)
-- Dependencies: 276
-- Name: logins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logins_id_seq', 1, false);


--
-- TOC entry 3607 (class 0 OID 0)
-- Dependencies: 279
-- Name: users_friends_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_friends_id_seq', 2, true);


--
-- TOC entry 3608 (class 0 OID 0)
-- Dependencies: 280
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 3609 (class 0 OID 0)
-- Dependencies: 282
-- Name: users_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_posts_id_seq', 7, true);


--
-- TOC entry 3422 (class 1259 OID 25435)
-- Name: index_feed_posts; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_feed_posts ON public.feed_posts USING btree (id_user);


--
-- TOC entry 3594 (class 0 OID 25429)
-- Dependencies: 283 3596
-- Name: feed_posts; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: postgres
--

REFRESH MATERIALIZED VIEW public.feed_posts;


-- Completed on 2025-06-26 11:57:17

--
-- PostgreSQL database dump complete
--

-- Completed on 2025-06-26 11:57:17

--
-- PostgreSQL database cluster dump complete
--

