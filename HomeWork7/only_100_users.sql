--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-11-05 17:54:37

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
-- TOC entry 219 (class 1259 OID 24654)
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
-- TOC entry 4822 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
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
-- Name: users_posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_posts ALTER COLUMN id SET DEFAULT nextval('public.users_posts_id_seq'::regclass);


--
-- TOC entry 4807 (class 0 OID 24614)
-- Dependencies: 216
-- Data for Name: logins; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.logins VALUES (1, 4, 'admin', '12345qwerty');
INSERT INTO public.logins VALUES (2, 5, 'postgres', '7ac60358d4f56501575fa9def6cc3bc3');
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
INSERT INTO public.users VALUES (20, 'Ярослав', 'Абрамов', '1968-01-01 00:00:00+05', NULL, 'Севастополь', NULL);
INSERT INTO public.users VALUES (21, 'Платон', 'Абрамов', '1930-01-01 00:00:00+04', NULL, 'Искитим', NULL);
INSERT INTO public.users VALUES (22, 'Тимофей', 'Абрамов', '1909-01-01 00:00:00+04:02:33', NULL, 'Лиски', NULL);
INSERT INTO public.users VALUES (23, 'Мирослав', 'Абрамов', '2000-01-01 00:00:00+05', NULL, 'Челябинск', NULL);
INSERT INTO public.users VALUES (24, 'Кирилл', 'Абрамов', '1975-01-01 00:00:00+05', NULL, 'Елец', NULL);
INSERT INTO public.users VALUES (25, 'Евгений', 'Абрамов', '1964-01-01 00:00:00+05', NULL, 'Междуреченск', NULL);
INSERT INTO public.users VALUES (26, 'Александр', 'Абрамов', '1976-01-01 00:00:00+05', NULL, 'Верхняя Пышма', NULL);
INSERT INTO public.users VALUES (27, 'Роман', 'Абрамов', '1994-01-01 00:00:00+05', NULL, 'Ленинск-Кузнецкий', NULL);
INSERT INTO public.users VALUES (28, 'Антон', 'Абрамов', '1973-01-01 00:00:00+05', NULL, 'Ижевск', NULL);
INSERT INTO public.users VALUES (29, 'Николай', 'Абрамов', '1945-01-01 00:00:00+05', NULL, 'Красноярск', NULL);
INSERT INTO public.users VALUES (30, 'Андрей', 'Абрамов', '1980-01-01 00:00:00+05', NULL, 'Южно-Сахалинск', NULL);
INSERT INTO public.users VALUES (31, 'Савва', 'Абрамов', '1932-01-01 00:00:00+05', NULL, 'Томск', NULL);
INSERT INTO public.users VALUES (32, 'Дмитрий', 'Абрамов', '2008-01-01 00:00:00+05', NULL, 'Бузулук', NULL);
INSERT INTO public.users VALUES (33, 'Артём', 'Абрамов', '2007-01-01 00:00:00+05', NULL, 'Комсомольск-на-Амуре', NULL);
INSERT INTO public.users VALUES (34, 'Егор', 'Абрамов', '2012-01-01 00:00:00+06', NULL, 'Ишим', NULL);
INSERT INTO public.users VALUES (35, 'Богдан', 'Абрамов', '1980-01-01 00:00:00+05', NULL, 'Свободный', NULL);
INSERT INTO public.users VALUES (36, 'Тимофей', 'Абрамов', '1920-01-01 00:00:00+04', NULL, 'Геленджик', NULL);
INSERT INTO public.users VALUES (37, 'Кирилл', 'Абрамов', '1931-01-01 00:00:00+05', NULL, 'Бийск', NULL);
INSERT INTO public.users VALUES (38, 'Владимир', 'Абрамов', '1946-01-01 00:00:00+05', NULL, 'Борисоглебск', NULL);
INSERT INTO public.users VALUES (39, 'Никита', 'Абрамов', '1946-01-01 00:00:00+05', NULL, 'Калуга', NULL);
INSERT INTO public.users VALUES (40, 'Кирилл', 'Абрамов', '2007-01-01 00:00:00+05', NULL, 'Евпатория', NULL);
INSERT INTO public.users VALUES (41, 'Александр', 'Абрамов', '1920-01-01 00:00:00+04', NULL, 'Юрга', NULL);
INSERT INTO public.users VALUES (42, 'Артемий', 'Абрамов', '1936-01-01 00:00:00+05', NULL, 'Мичуринск', NULL);
INSERT INTO public.users VALUES (43, 'Никита', 'Абрамов', '1992-01-01 00:00:00+04', NULL, 'Клинцы', NULL);
INSERT INTO public.users VALUES (44, 'Григорий', 'Абрамов', '1910-01-01 00:00:00+04:02:33', NULL, 'Ковров', NULL);
INSERT INTO public.users VALUES (45, 'Даниил', 'Абрамов', '1922-01-01 00:00:00+04', NULL, 'Люберцы', NULL);
INSERT INTO public.users VALUES (46, 'Иван', 'Абрамов', '1955-01-01 00:00:00+05', NULL, 'Сосновый Бор', NULL);
INSERT INTO public.users VALUES (47, 'Константин', 'Абрамов', '1927-01-01 00:00:00+04', NULL, 'Дубна', NULL);
INSERT INTO public.users VALUES (48, 'Тихон', 'Абрамов', '1933-01-01 00:00:00+05', NULL, 'Нижневартовск', NULL);
INSERT INTO public.users VALUES (49, 'Максим', 'Абрамов', '1911-01-01 00:00:00+04:02:33', NULL, 'Новокузнецк', NULL);
INSERT INTO public.users VALUES (50, 'Матвей', 'Абрамов', '1928-01-01 00:00:00+04', NULL, 'Раменское', NULL);
INSERT INTO public.users VALUES (51, 'Богдан', 'Абрамов', '1908-01-01 00:00:00+04:02:33', NULL, 'Кириши', NULL);
INSERT INTO public.users VALUES (52, 'Михаил', 'Абрамов', '1958-01-01 00:00:00+05', NULL, 'Раменское', NULL);
INSERT INTO public.users VALUES (53, 'Георгий', 'Абрамов', '2006-01-01 00:00:00+05', NULL, 'Лысьва', NULL);
INSERT INTO public.users VALUES (54, 'Михаил', 'Абрамов', '2013-01-01 00:00:00+06', NULL, 'Киселевск', NULL);
INSERT INTO public.users VALUES (55, 'Тимофей', 'Абрамов', '1963-01-01 00:00:00+05', NULL, 'Сургут', NULL);
INSERT INTO public.users VALUES (56, 'Александр', 'Абрамов', '1905-01-01 00:00:00+04:02:33', NULL, 'Вологда', NULL);
INSERT INTO public.users VALUES (57, 'Тимур', 'Абрамов', '1912-01-01 00:00:00+04:02:33', NULL, 'Анапа', NULL);
INSERT INTO public.users VALUES (58, 'Артём', 'Абрамов', '1959-01-01 00:00:00+05', NULL, 'Лесосибирск', NULL);
INSERT INTO public.users VALUES (59, 'Роман', 'Абрамов', '1986-01-01 00:00:00+05', NULL, 'Красногорск', NULL);
INSERT INTO public.users VALUES (60, 'Илья', 'Абрамов', '1952-01-01 00:00:00+05', NULL, 'Жуковский', NULL);
INSERT INTO public.users VALUES (61, 'Елисей', 'Абрамов', '1977-01-01 00:00:00+05', NULL, 'Чита', NULL);
INSERT INTO public.users VALUES (62, 'Лев', 'Абрамов', '1962-01-01 00:00:00+05', NULL, 'Новоуральск', NULL);
INSERT INTO public.users VALUES (63, 'Константин', 'Абрамов', '1997-01-01 00:00:00+05', NULL, 'Геленджик', NULL);
INSERT INTO public.users VALUES (64, 'Иван', 'Абрамов', '1980-01-01 00:00:00+05', NULL, 'Волгодонск', NULL);
INSERT INTO public.users VALUES (65, 'Николай', 'Абрамов', '1924-01-01 00:00:00+04', NULL, 'Красноярск', NULL);
INSERT INTO public.users VALUES (66, 'Георгий', 'Абрамов', '1951-01-01 00:00:00+05', NULL, 'Дмитров', NULL);
INSERT INTO public.users VALUES (67, 'Александр', 'Абрамов', '1938-01-01 00:00:00+05', NULL, 'Гатчина', NULL);
INSERT INTO public.users VALUES (68, 'Вячеслав', 'Абрамов', '1926-01-01 00:00:00+04', NULL, 'Красногорск', NULL);
INSERT INTO public.users VALUES (69, 'Тихон', 'Абрамов', '1985-01-01 00:00:00+05', NULL, 'Липецк', NULL);
INSERT INTO public.users VALUES (70, 'Даниил', 'Абрамов', '1969-01-01 00:00:00+05', NULL, 'Черкесск', NULL);
INSERT INTO public.users VALUES (71, 'Пётр', 'Абрамов', '1989-01-01 00:00:00+05', NULL, 'Белогорск (Амурская область)', NULL);
INSERT INTO public.users VALUES (72, 'Михаил', 'Абрамов', '1911-01-01 00:00:00+04:02:33', NULL, 'Орехово-Зуево', NULL);
INSERT INTO public.users VALUES (73, 'Степан', 'Абрамов', '2007-01-01 00:00:00+05', NULL, 'Махачкала', NULL);
INSERT INTO public.users VALUES (74, 'Всеволод', 'Абрамов', '1943-01-01 00:00:00+05', NULL, 'Кумертау', NULL);
INSERT INTO public.users VALUES (75, 'Антон', 'Абрамов', '1952-01-01 00:00:00+05', NULL, 'Бийск', NULL);
INSERT INTO public.users VALUES (76, 'Тимофей', 'Абрамов', '1963-01-01 00:00:00+05', NULL, 'Тула', NULL);
INSERT INTO public.users VALUES (77, 'Артём', 'Абрамов', '2009-01-01 00:00:00+05', NULL, 'Россошь', NULL);
INSERT INTO public.users VALUES (78, 'Ярослав', 'Абрамов', '1968-01-01 00:00:00+05', NULL, 'Минусинск', NULL);
INSERT INTO public.users VALUES (79, 'Егор', 'Абрамов', '1922-01-01 00:00:00+04', NULL, 'Копейск', NULL);
INSERT INTO public.users VALUES (80, 'Иван', 'Абрамов', '1951-01-01 00:00:00+05', NULL, 'Кумертау', NULL);
INSERT INTO public.users VALUES (81, 'Ярослав', 'Абрамов', '1906-01-01 00:00:00+04:02:33', NULL, 'Белорецк', NULL);
INSERT INTO public.users VALUES (82, 'Александр', 'Абрамов', '1985-01-01 00:00:00+05', NULL, 'Ставрополь', NULL);
INSERT INTO public.users VALUES (83, 'Семён', 'Абрамов', '1991-01-01 00:00:00+05', NULL, 'Каспийск', NULL);
INSERT INTO public.users VALUES (84, 'Арсений', 'Абрамов', '1971-01-01 00:00:00+05', NULL, 'Тихорецк', NULL);
INSERT INTO public.users VALUES (85, 'Александр', 'Абрамов', '1940-01-01 00:00:00+05', NULL, 'Кузнецк', NULL);
INSERT INTO public.users VALUES (86, 'Елисей', 'Абрамов', '1967-01-01 00:00:00+05', NULL, 'Тихорецк', NULL);
INSERT INTO public.users VALUES (87, 'Матвей', 'Абрамов', '1928-01-01 00:00:00+04', NULL, 'Ставрополь', NULL);
INSERT INTO public.users VALUES (88, 'Андрей', 'Абрамов', '1929-01-01 00:00:00+04', NULL, 'Ачинск', NULL);
INSERT INTO public.users VALUES (89, 'Арсений', 'Абрамов', '1926-01-01 00:00:00+04', NULL, 'Донской', NULL);
INSERT INTO public.users VALUES (90, 'Дмитрий', 'Абрамов', '1912-01-01 00:00:00+04:02:33', NULL, 'Выборг', NULL);
INSERT INTO public.users VALUES (91, 'Евгений', 'Абрамов', '1923-01-01 00:00:00+04', NULL, 'Железногорск (Красноярский край)', NULL);
INSERT INTO public.users VALUES (92, 'Михаил', 'Абрамов', '1963-01-01 00:00:00+05', NULL, 'Арзамас', NULL);
INSERT INTO public.users VALUES (93, 'Максим', 'Абрамов', '1943-01-01 00:00:00+05', NULL, 'Санкт-Петербург', NULL);
INSERT INTO public.users VALUES (94, 'Никита', 'Абрамов', '2013-01-01 00:00:00+06', NULL, 'Ставрополь', NULL);
INSERT INTO public.users VALUES (95, 'Андрей', 'Абрамов', '1906-01-01 00:00:00+04:02:33', NULL, 'Златоуст', NULL);
INSERT INTO public.users VALUES (96, 'Николай', 'Абрамов', '1938-01-01 00:00:00+05', NULL, 'Казань', NULL);
INSERT INTO public.users VALUES (97, 'Лев', 'Абрамов', '2004-01-01 00:00:00+05', NULL, 'Биробиджан', NULL);
INSERT INTO public.users VALUES (98, 'Матвей', 'Абрамов', '1975-01-01 00:00:00+05', NULL, 'Альметьевск', NULL);
INSERT INTO public.users VALUES (99, 'Михаил', 'Абрамов', '1908-01-01 00:00:00+04:02:33', NULL, 'Горно-Алтайск', NULL);
INSERT INTO public.users VALUES (100, 'Дмитрий', 'Абрамов', '2003-01-01 00:00:00+05', NULL, 'Бор', NULL);
