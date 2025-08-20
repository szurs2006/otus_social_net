--
-- PostgreSQL database cluster dump
--

-- Started on 2025-08-20 11:15:00

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:VrKjDjT0Hxp3AKtQzc3pwA==$vsuQyZc0t4RGuCrpxSl9aJkoqRESMF1I1XHJofZcCGM=:E2nM9RQDXS7focbLsmL7iweRZFR+j43bB6KkKnaGWZ4=';

--
-- User Configurations
--

--
-- Databases
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+2)
-- Dumped by pg_dump version 16.4

-- Started on 2025-08-20 11:15:01

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

-- Completed on 2025-08-20 11:15:01

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+2)
-- Dumped by pg_dump version 16.4

-- Started on 2025-08-20 11:15:01

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
-- TOC entry 2 (class 3079 OID 16433)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16388)
-- Name: dialogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dialogs (
    from_user bigint NOT NULL,
    to_user bigint NOT NULL,
    dtext character varying,
    dist_key text,
    created_at timestamp with time zone DEFAULT now(),
    is_read boolean DEFAULT false NOT NULL
);


ALTER TABLE public.dialogs OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16394)
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
-- TOC entry 218 (class 1259 OID 16399)
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
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 218
-- Name: logins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logins_id_seq OWNED BY public.logins.id;


--
-- TOC entry 225 (class 1259 OID 16444)
-- Name: outbox; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.outbox (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    event_type text NOT NULL,
    aggregate_id text NOT NULL,
    payload jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    sent_at timestamp with time zone
);


ALTER TABLE public.outbox OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16400)
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
-- TOC entry 220 (class 1259 OID 16405)
-- Name: users_friends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_friends (
    id bigint NOT NULL,
    id_user integer NOT NULL,
    id_friend integer NOT NULL
);


ALTER TABLE public.users_friends OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16408)
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
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_friends_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_friends_id_seq OWNED BY public.users_friends.id;


--
-- TOC entry 222 (class 1259 OID 16409)
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
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 222
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 223 (class 1259 OID 16410)
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
-- TOC entry 224 (class 1259 OID 16416)
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
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 224
-- Name: users_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_posts_id_seq OWNED BY public.users_posts.id;


--
-- TOC entry 3239 (class 2604 OID 16417)
-- Name: logins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logins ALTER COLUMN id SET DEFAULT nextval('public.logins_id_seq'::regclass);


--
-- TOC entry 3240 (class 2604 OID 16418)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3241 (class 2604 OID 16419)
-- Name: users_friends id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_friends ALTER COLUMN id SET DEFAULT nextval('public.users_friends_id_seq'::regclass);


--
-- TOC entry 3242 (class 2604 OID 16420)
-- Name: users_posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_posts ALTER COLUMN id SET DEFAULT nextval('public.users_posts_id_seq'::regclass);


--
-- TOC entry 3396 (class 0 OID 16388)
-- Dependencies: 216
-- Data for Name: dialogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dialogs VALUES (5, 6, 'Что-то я тебя не помню', 'b42686315da93b1d3f8c85a005244288', '2025-05-26 09:00:55.977348+00', false);
INSERT INTO public.dialogs VALUES (5, 6, 'Ты меня с кем-то путаешь, я таким в школе не занимался', 'b42686315da93b1d3f8c85a005244288', '2025-05-26 09:07:13.582465+00', false);
INSERT INTO public.dialogs VALUES (5, 6, 'Я был примерным пай-мальчиком', 'b42686315da93b1d3f8c85a005244288', '2025-05-26 09:08:15.169046+00', false);
INSERT INTO public.dialogs VALUES (5, 6, 'Учился на отлично', 'b42686315da93b1d3f8c85a005244288', '2025-05-26 09:08:34.620755+00', false);
INSERT INTO public.dialogs VALUES (5, 6, 'Дак это был ты, понятно', 'b42686315da93b1d3f8c85a005244288', '2025-05-26 09:19:26.117467+00', false);
INSERT INTO public.dialogs VALUES (5, 6, 'Нам надо встеретиться и поговорить', 'b42686315da93b1d3f8c85a005244288', '2025-05-26 09:19:57.085356+00', false);
INSERT INTO public.dialogs VALUES (5, 6, 'Не, ругаться не буду, просто встретиться, вспомнить прошлое', 'b42686315da93b1d3f8c85a005244288', '2025-05-26 09:21:57.298603+00', false);
INSERT INTO public.dialogs VALUES (3, 6, 'Да, привет, почему у вокзала?', 'a1c5285851b5bbc79f967d85ff84f3a4', '2025-05-23 09:54:00.739937+00', false);
INSERT INTO public.dialogs VALUES (3, 6, 'Ага, ок, понял!', 'a1c5285851b5bbc79f967d85ff84f3a4', '2025-05-23 09:57:13.821511+00', false);
INSERT INTO public.dialogs VALUES (1, 6, 'МММ. сегодня не могу!', '291dd475d0224126a68550d7c406f3b1', '2025-05-23 10:10:51.159877+00', false);
INSERT INTO public.dialogs VALUES (1, 6, 'Много дел!', '291dd475d0224126a68550d7c406f3b1', '2025-05-23 10:11:03.64365+00', false);
INSERT INTO public.dialogs VALUES (1, 6, 'М.б. завтра', '291dd475d0224126a68550d7c406f3b1', '2025-05-23 10:11:17.983038+00', false);
INSERT INTO public.dialogs VALUES (3, 6, 'Приду, если получится..', 'a1c5285851b5bbc79f967d85ff84f3a4', '2025-05-23 10:15:18.977368+00', false);
INSERT INTO public.dialogs VALUES (3, 6, 'Также у вокзала?', 'a1c5285851b5bbc79f967d85ff84f3a4', '2025-05-23 10:15:32.879864+00', false);
INSERT INTO public.dialogs VALUES (6, 2, 'Сегодня, как и вчера, встречаемся у вокзала', '28efd832ac6f3fa5632f9776f5b3a637', '2025-05-23 10:06:32.170937+00', false);
INSERT INTO public.dialogs VALUES (6, 2, 'Придет третий!', '28efd832ac6f3fa5632f9776f5b3a637', '2025-05-23 10:06:51.210103+00', false);
INSERT INTO public.dialogs VALUES (6, 2, 'Думаю, да', '28efd832ac6f3fa5632f9776f5b3a637', '2025-05-23 10:07:50.552095+00', false);
INSERT INTO public.dialogs VALUES (6, 1, 'Сегодня приходи к вокзалу!', 'acdd163a762f841c6f8687b87dbb9592', '2025-05-23 10:09:51.059757+00', false);
INSERT INTO public.dialogs VALUES (6, 1, 'Будут второй и третий!', 'acdd163a762f841c6f8687b87dbb9592', '2025-05-23 10:10:09.541467+00', false);
INSERT INTO public.dialogs VALUES (6, 1, 'Они подтвердили!', 'acdd163a762f841c6f8687b87dbb9592', '2025-05-23 10:10:27.110814+00', false);
INSERT INTO public.dialogs VALUES (6, 1, 'Да, конечно, и завтра тоже встречаемся', 'acdd163a762f841c6f8687b87dbb9592', '2025-05-23 10:12:26.491863+00', false);
INSERT INTO public.dialogs VALUES (6, 2, 'Завтра тоже встречаемся, не удивляйся!!', '28efd832ac6f3fa5632f9776f5b3a637', '2025-05-23 10:13:57.794873+00', false);
INSERT INTO public.dialogs VALUES (6, 3, 'Привет, сегодня встречаемся у вокзала!', '3f05f60140d703c4956d9392cc6b5947', '2025-05-23 09:53:28.123878+00', false);
INSERT INTO public.dialogs VALUES (6, 3, 'Потому что мне так ближе от работы', '3f05f60140d703c4956d9392cc6b5947', '2025-05-23 09:54:38.707594+00', false);
INSERT INTO public.dialogs VALUES (6, 3, 'Договорились..', '3f05f60140d703c4956d9392cc6b5947', '2025-05-23 09:57:33.38257+00', false);
INSERT INTO public.dialogs VALUES (6, 3, 'И завтра тоже встречаемся!', '3f05f60140d703c4956d9392cc6b5947', '2025-05-23 10:14:49.388513+00', false);
INSERT INTO public.dialogs VALUES (6, 3, 'Да!!', '3f05f60140d703c4956d9392cc6b5947', '2025-05-23 10:15:46.814895+00', false);
INSERT INTO public.dialogs VALUES (2, 5, 'Созрели вишни в саду у тети Моти!', 'b7f1428b233718e0acaef609d317bad3', '2025-05-23 09:55:59.781031+00', false);
INSERT INTO public.dialogs VALUES (2, 6, 'Как интересно, я его знаю?!', 'd4671aff849ceb62af5e9417f9db61d2', '2025-05-23 10:07:24.229984+00', false);
INSERT INTO public.dialogs VALUES (2, 6, 'Очень хорошо!!', 'd4671aff849ceb62af5e9417f9db61d2', '2025-05-23 10:08:44.409665+00', false);
INSERT INTO public.dialogs VALUES (2, 6, 'Хорошо!!', 'd4671aff849ceb62af5e9417f9db61d2', '2025-05-23 10:14:17.724838+00', false);
INSERT INTO public.dialogs VALUES (6, 5, 'Привет, я тебя знаю!!', '57db4522f377eb0ba1c820ee53e6a0cd', '2025-05-26 08:59:03.712688+00', false);
INSERT INTO public.dialogs VALUES (6, 5, 'Похоже, мы вместе в школе учились.. ', '57db4522f377eb0ba1c820ee53e6a0cd', '2025-05-26 09:00:09.915951+00', false);
INSERT INTO public.dialogs VALUES (6, 5, 'Да как это? Ты не помнишь как мы в хим. подвал зазили?!', '57db4522f377eb0ba1c820ee53e6a0cd', '2025-05-26 09:05:27.288169+00', false);
INSERT INTO public.dialogs VALUES (6, 5, 'ДИ потом делали дымовухи', '57db4522f377eb0ba1c820ee53e6a0cd', '2025-05-26 09:06:21.490328+00', false);
INSERT INTO public.dialogs VALUES (6, 5, 'ААА, так ты это отличник-зануда с первой парты', '57db4522f377eb0ba1c820ee53e6a0cd', '2025-05-26 09:17:29.691089+00', false);
INSERT INTO public.dialogs VALUES (6, 5, 'Я тебе еще краской учебники залил', '57db4522f377eb0ba1c820ee53e6a0cd', '2025-05-26 09:18:15.350415+00', false);
INSERT INTO public.dialogs VALUES (6, 5, 'Ты еще долго не мог найти того, кто это сделал', '57db4522f377eb0ba1c820ee53e6a0cd', '2025-05-26 09:18:42.395223+00', false);
INSERT INTO public.dialogs VALUES (6, 5, 'Ругаться будешь? может не надо', '57db4522f377eb0ba1c820ee53e6a0cd', '2025-05-26 09:20:42.407111+00', false);
INSERT INTO public.dialogs VALUES (6, 5, 'Тогда давай, я за!', '57db4522f377eb0ba1c820ee53e6a0cd', '2025-05-26 09:22:36.119817+00', false);
INSERT INTO public.dialogs VALUES (10, 11, 'Привет, как дела?', '92f79736ce4676b9d41f8e962f12755e', '2025-08-19 07:36:32.547134+00', false);
INSERT INTO public.dialogs VALUES (11, 10, 'Дела идут - контора пишет', '71c32f6f259b896441a06ae591f8d340', '2025-08-19 10:56:34.210356+00', true);
INSERT INTO public.dialogs VALUES (11, 10, 'Но куда идут- не знаю...', '71c32f6f259b896441a06ae591f8d340', '2025-08-19 11:18:56.070325+00', true);
INSERT INTO public.dialogs VALUES (11, 10, 'Но да', '71c32f6f259b896441a06ae591f8d340', '2025-08-19 11:44:16.842062+00', true);
INSERT INTO public.dialogs VALUES (11, 10, 'Но да да да', '71c32f6f259b896441a06ae591f8d340', '2025-08-19 11:53:09.490359+00', true);
INSERT INTO public.dialogs VALUES (11, 12, 'From 11 to 12', '8f3126127eb89d00ac18990f07433553', '2025-08-20 06:05:01.829648+00', true);
INSERT INTO public.dialogs VALUES (11, 12, 'Еще раз 11 to 12', '8f3126127eb89d00ac18990f07433553', '2025-08-20 06:08:14.164555+00', true);
INSERT INTO public.dialogs VALUES (11, 12, 'Еще много много раз', '8f3126127eb89d00ac18990f07433553', '2025-08-20 06:09:06.745128+00', true);
INSERT INTO public.dialogs VALUES (11, 13, 'Еще много------много раз', 'cb99a384034bdc6babf1ffb315970e5a', '2025-08-20 06:10:32.212137+00', true);


--
-- TOC entry 3397 (class 0 OID 16394)
-- Dependencies: 217
-- Data for Name: logins; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.logins VALUES (1, 4, 'admin', '12345qwerty');
INSERT INTO public.logins VALUES (2, 5, 'postgres', '7ac60358d4f56501575fa9def6cc3bc3');
INSERT INTO public.logins VALUES (3, 6, 'pup', 'd1377c0281728bb8c20f8df217a7e094');


--
-- TOC entry 3405 (class 0 OID 16444)
-- Dependencies: 225
-- Data for Name: outbox; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.outbox VALUES ('2ee5002f-6574-4d5f-84ec-32b1aaaac201', 'message_read', '10', '{"delta": -1, "id_to_user": "10", "message_id": 1755600994.210356}', '2025-08-20 05:20:25.703175+00', '2025-08-20 06:05:58.934303+00');
INSERT INTO public.outbox VALUES ('a6d121bd-b82e-496e-92ec-6974b27f60fe', 'message_created', '12', '{"delta": 1, "id_to_user": "12", "id_from_user": "11", "message_created_at": 1755669901.829648}', '2025-08-20 06:05:01.829648+00', '2025-08-20 06:06:35.273252+00');
INSERT INTO public.outbox VALUES ('40e311bf-b0f3-4bc4-9b5b-e6d0b7560682', 'message_created', '12', '{"delta": 1, "id_to_user": "12", "id_from_user": "11", "message_created_at": 1755670094.164555}', '2025-08-20 06:08:14.164555+00', '2025-08-20 06:08:14.265524+00');
INSERT INTO public.outbox VALUES ('09cee963-3d79-4b2f-8720-297bfc633a5e', 'message_created', '12', '{"delta": 1, "id_to_user": "12", "id_from_user": "11", "message_created_at": 1755670146.745128}', '2025-08-20 06:09:06.745128+00', '2025-08-20 06:09:07.006279+00');
INSERT INTO public.outbox VALUES ('a4077b31-3afc-41f7-b293-468416625d5a', 'message_read', '12', '{"delta": -1, "id_to_user": "12", "message_id": 1755669901.829648}', '2025-08-20 06:09:24.707336+00', '2025-08-20 06:09:32.054791+00');
INSERT INTO public.outbox VALUES ('02086f91-2d69-4ae0-842e-bd2f12864054', 'message_read', '12', '{"delta": -1, "id_to_user": "12", "message_id": 1755670094.164555}', '2025-08-20 06:09:31.882324+00', '2025-08-20 06:09:32.056358+00');
INSERT INTO public.outbox VALUES ('8752819e-c991-4fff-a582-615e59279b12', 'message_read', '12', '{"delta": -1, "id_to_user": "12", "message_id": 1755670146.745128}', '2025-08-20 06:09:31.891061+00', '2025-08-20 06:09:32.057419+00');
INSERT INTO public.outbox VALUES ('88f2de16-9ac2-487a-9bb4-41d86bfaa1a9', 'message_created', '13', '{"delta": 1, "id_to_user": "13", "id_from_user": "11", "message_created_at": 1755670232.212137}', '2025-08-20 06:10:32.212137+00', '2025-08-20 06:10:32.437907+00');
INSERT INTO public.outbox VALUES ('c3496fcf-9f06-454e-a140-88d7a481d262', 'message_read', '13', '{"delta": -1, "id_to_user": "13", "message_id": 1755670232.212137}', '2025-08-20 06:10:47.443437+00', '2025-08-20 06:10:47.462513+00');


--
-- TOC entry 3399 (class 0 OID 16400)
-- Dependencies: 219
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Роберт', 'Абрамов', '2011-12-31 18:00:00+00', NULL, 'Воткинск', NULL);
INSERT INTO public.users VALUES (2, 'Александр', 'Абрамов', '1915-12-31 19:57:27+00', NULL, 'Домодедово', NULL);
INSERT INTO public.users VALUES (3, 'Илья', 'Абрамов', '1911-12-31 19:57:27+00', NULL, 'Севастополь', NULL);
INSERT INTO public.users VALUES (4, 'Даниил', 'Абрамов', '1917-12-31 20:14:55+00', NULL, 'Ржев', NULL);
INSERT INTO public.users VALUES (5, 'Лев', 'Абрамов', '2006-12-31 19:00:00+00', NULL, 'Когалым', NULL);
INSERT INTO public.users VALUES (6, 'Игорь', 'Абрамов', '2008-12-31 19:00:00+00', NULL, 'Дзержинск', NULL);
INSERT INTO public.users VALUES (7, 'Никита', 'Абрамов', '1980-12-31 19:00:00+00', NULL, 'Балашов', NULL);
INSERT INTO public.users VALUES (8, 'Юрий', 'Абрамов', '1934-12-31 19:00:00+00', NULL, 'Серпухов', NULL);
INSERT INTO public.users VALUES (9, 'Егор', 'Абрамов', '1961-12-31 19:00:00+00', NULL, 'Ногинск', NULL);
INSERT INTO public.users VALUES (10, 'Всеволод', 'Абрамов', '1905-12-31 19:57:27+00', NULL, 'Новомосковск', NULL);
INSERT INTO public.users VALUES (11, 'Демид', 'Абрамов', '1927-12-31 20:00:00+00', NULL, 'Обнинск', NULL);
INSERT INTO public.users VALUES (12, 'Александр', 'Абрамов', '1914-12-31 19:57:27+00', NULL, 'Омск', NULL);
INSERT INTO public.users VALUES (13, 'Лука', 'Абрамов', '1915-12-31 19:57:27+00', NULL, 'Лесосибирск', NULL);
INSERT INTO public.users VALUES (14, 'Дмитрий', 'Абрамов', '1985-12-31 19:00:00+00', NULL, 'Хасавюрт', NULL);
INSERT INTO public.users VALUES (15, 'Александр', 'Абрамов', '1922-12-31 20:00:00+00', NULL, 'Красноярск', NULL);
INSERT INTO public.users VALUES (16, 'Иван', 'Абрамов', '2001-12-31 19:00:00+00', NULL, 'Барнаул', NULL);
INSERT INTO public.users VALUES (17, 'Лука', 'Абрамов', '1985-12-31 19:00:00+00', NULL, 'Магадан', NULL);
INSERT INTO public.users VALUES (18, 'Георгий', 'Абрамов', '1993-12-31 19:00:00+00', NULL, 'Волжск', NULL);
INSERT INTO public.users VALUES (19, 'Александр', 'Абрамов', '1945-12-31 19:00:00+00', NULL, 'Энгельс', NULL);
INSERT INTO public.users VALUES (20, 'Ярослав', 'Абрамов', '1967-12-31 19:00:00+00', NULL, 'Севастополь', NULL);
INSERT INTO public.users VALUES (21, 'Платон', 'Абрамов', '1929-12-31 20:00:00+00', NULL, 'Искитим', NULL);
INSERT INTO public.users VALUES (22, 'Тимофей', 'Абрамов', '1908-12-31 19:57:27+00', NULL, 'Лиски', NULL);
INSERT INTO public.users VALUES (23, 'Мирослав', 'Абрамов', '1999-12-31 19:00:00+00', NULL, 'Челябинск', NULL);
INSERT INTO public.users VALUES (24, 'Кирилл', 'Абрамов', '1974-12-31 19:00:00+00', NULL, 'Елец', NULL);
INSERT INTO public.users VALUES (25, 'Евгений', 'Абрамов', '1963-12-31 19:00:00+00', NULL, 'Междуреченск', NULL);
INSERT INTO public.users VALUES (26, 'Александр', 'Абрамов', '1975-12-31 19:00:00+00', NULL, 'Верхняя Пышма', NULL);
INSERT INTO public.users VALUES (27, 'Роман', 'Абрамов', '1993-12-31 19:00:00+00', NULL, 'Ленинск-Кузнецкий', NULL);
INSERT INTO public.users VALUES (28, 'Антон', 'Абрамов', '1972-12-31 19:00:00+00', NULL, 'Ижевск', NULL);
INSERT INTO public.users VALUES (29, 'Николай', 'Абрамов', '1944-12-31 19:00:00+00', NULL, 'Красноярск', NULL);
INSERT INTO public.users VALUES (30, 'Андрей', 'Абрамов', '1979-12-31 19:00:00+00', NULL, 'Южно-Сахалинск', NULL);
INSERT INTO public.users VALUES (31, 'Савва', 'Абрамов', '1931-12-31 19:00:00+00', NULL, 'Томск', NULL);
INSERT INTO public.users VALUES (32, 'Дмитрий', 'Абрамов', '2007-12-31 19:00:00+00', NULL, 'Бузулук', NULL);
INSERT INTO public.users VALUES (33, 'Артём', 'Абрамов', '2006-12-31 19:00:00+00', NULL, 'Комсомольск-на-Амуре', NULL);
INSERT INTO public.users VALUES (34, 'Егор', 'Абрамов', '2011-12-31 18:00:00+00', NULL, 'Ишим', NULL);
INSERT INTO public.users VALUES (35, 'Богдан', 'Абрамов', '1979-12-31 19:00:00+00', NULL, 'Свободный', NULL);
INSERT INTO public.users VALUES (36, 'Тимофей', 'Абрамов', '1919-12-31 20:00:00+00', NULL, 'Геленджик', NULL);
INSERT INTO public.users VALUES (37, 'Кирилл', 'Абрамов', '1930-12-31 19:00:00+00', NULL, 'Бийск', NULL);
INSERT INTO public.users VALUES (38, 'Владимир', 'Абрамов', '1945-12-31 19:00:00+00', NULL, 'Борисоглебск', NULL);
INSERT INTO public.users VALUES (39, 'Никита', 'Абрамов', '1945-12-31 19:00:00+00', NULL, 'Калуга', NULL);
INSERT INTO public.users VALUES (40, 'Кирилл', 'Абрамов', '2006-12-31 19:00:00+00', NULL, 'Евпатория', NULL);
INSERT INTO public.users VALUES (41, 'Александр', 'Абрамов', '1919-12-31 20:00:00+00', NULL, 'Юрга', NULL);
INSERT INTO public.users VALUES (42, 'Артемий', 'Абрамов', '1935-12-31 19:00:00+00', NULL, 'Мичуринск', NULL);
INSERT INTO public.users VALUES (43, 'Никита', 'Абрамов', '1991-12-31 20:00:00+00', NULL, 'Клинцы', NULL);
INSERT INTO public.users VALUES (44, 'Григорий', 'Абрамов', '1909-12-31 19:57:27+00', NULL, 'Ковров', NULL);
INSERT INTO public.users VALUES (45, 'Даниил', 'Абрамов', '1921-12-31 20:00:00+00', NULL, 'Люберцы', NULL);
INSERT INTO public.users VALUES (46, 'Иван', 'Абрамов', '1954-12-31 19:00:00+00', NULL, 'Сосновый Бор', NULL);
INSERT INTO public.users VALUES (47, 'Константин', 'Абрамов', '1926-12-31 20:00:00+00', NULL, 'Дубна', NULL);
INSERT INTO public.users VALUES (48, 'Тихон', 'Абрамов', '1932-12-31 19:00:00+00', NULL, 'Нижневартовск', NULL);
INSERT INTO public.users VALUES (49, 'Максим', 'Абрамов', '1910-12-31 19:57:27+00', NULL, 'Новокузнецк', NULL);
INSERT INTO public.users VALUES (50, 'Матвей', 'Абрамов', '1927-12-31 20:00:00+00', NULL, 'Раменское', NULL);
INSERT INTO public.users VALUES (51, 'Богдан', 'Абрамов', '1907-12-31 19:57:27+00', NULL, 'Кириши', NULL);
INSERT INTO public.users VALUES (52, 'Михаил', 'Абрамов', '1957-12-31 19:00:00+00', NULL, 'Раменское', NULL);
INSERT INTO public.users VALUES (53, 'Георгий', 'Абрамов', '2005-12-31 19:00:00+00', NULL, 'Лысьва', NULL);
INSERT INTO public.users VALUES (54, 'Михаил', 'Абрамов', '2012-12-31 18:00:00+00', NULL, 'Киселевск', NULL);
INSERT INTO public.users VALUES (55, 'Тимофей', 'Абрамов', '1962-12-31 19:00:00+00', NULL, 'Сургут', NULL);
INSERT INTO public.users VALUES (56, 'Александр', 'Абрамов', '1904-12-31 19:57:27+00', NULL, 'Вологда', NULL);
INSERT INTO public.users VALUES (57, 'Тимур', 'Абрамов', '1911-12-31 19:57:27+00', NULL, 'Анапа', NULL);
INSERT INTO public.users VALUES (58, 'Артём', 'Абрамов', '1958-12-31 19:00:00+00', NULL, 'Лесосибирск', NULL);
INSERT INTO public.users VALUES (59, 'Роман', 'Абрамов', '1985-12-31 19:00:00+00', NULL, 'Красногорск', NULL);
INSERT INTO public.users VALUES (60, 'Илья', 'Абрамов', '1951-12-31 19:00:00+00', NULL, 'Жуковский', NULL);
INSERT INTO public.users VALUES (61, 'Елисей', 'Абрамов', '1976-12-31 19:00:00+00', NULL, 'Чита', NULL);
INSERT INTO public.users VALUES (62, 'Лев', 'Абрамов', '1961-12-31 19:00:00+00', NULL, 'Новоуральск', NULL);
INSERT INTO public.users VALUES (63, 'Константин', 'Абрамов', '1996-12-31 19:00:00+00', NULL, 'Геленджик', NULL);
INSERT INTO public.users VALUES (64, 'Иван', 'Абрамов', '1979-12-31 19:00:00+00', NULL, 'Волгодонск', NULL);
INSERT INTO public.users VALUES (65, 'Николай', 'Абрамов', '1923-12-31 20:00:00+00', NULL, 'Красноярск', NULL);
INSERT INTO public.users VALUES (66, 'Георгий', 'Абрамов', '1950-12-31 19:00:00+00', NULL, 'Дмитров', NULL);
INSERT INTO public.users VALUES (67, 'Александр', 'Абрамов', '1937-12-31 19:00:00+00', NULL, 'Гатчина', NULL);
INSERT INTO public.users VALUES (68, 'Вячеслав', 'Абрамов', '1925-12-31 20:00:00+00', NULL, 'Красногорск', NULL);
INSERT INTO public.users VALUES (69, 'Тихон', 'Абрамов', '1984-12-31 19:00:00+00', NULL, 'Липецк', NULL);
INSERT INTO public.users VALUES (70, 'Даниил', 'Абрамов', '1968-12-31 19:00:00+00', NULL, 'Черкесск', NULL);
INSERT INTO public.users VALUES (71, 'Пётр', 'Абрамов', '1988-12-31 19:00:00+00', NULL, 'Белогорск (Амурская область)', NULL);
INSERT INTO public.users VALUES (72, 'Михаил', 'Абрамов', '1910-12-31 19:57:27+00', NULL, 'Орехово-Зуево', NULL);
INSERT INTO public.users VALUES (73, 'Степан', 'Абрамов', '2006-12-31 19:00:00+00', NULL, 'Махачкала', NULL);
INSERT INTO public.users VALUES (74, 'Всеволод', 'Абрамов', '1942-12-31 19:00:00+00', NULL, 'Кумертау', NULL);
INSERT INTO public.users VALUES (75, 'Антон', 'Абрамов', '1951-12-31 19:00:00+00', NULL, 'Бийск', NULL);
INSERT INTO public.users VALUES (76, 'Тимофей', 'Абрамов', '1962-12-31 19:00:00+00', NULL, 'Тула', NULL);
INSERT INTO public.users VALUES (77, 'Артём', 'Абрамов', '2008-12-31 19:00:00+00', NULL, 'Россошь', NULL);
INSERT INTO public.users VALUES (78, 'Ярослав', 'Абрамов', '1967-12-31 19:00:00+00', NULL, 'Минусинск', NULL);
INSERT INTO public.users VALUES (79, 'Егор', 'Абрамов', '1921-12-31 20:00:00+00', NULL, 'Копейск', NULL);
INSERT INTO public.users VALUES (80, 'Иван', 'Абрамов', '1950-12-31 19:00:00+00', NULL, 'Кумертау', NULL);
INSERT INTO public.users VALUES (81, 'Ярослав', 'Абрамов', '1905-12-31 19:57:27+00', NULL, 'Белорецк', NULL);
INSERT INTO public.users VALUES (82, 'Александр', 'Абрамов', '1984-12-31 19:00:00+00', NULL, 'Ставрополь', NULL);
INSERT INTO public.users VALUES (83, 'Семён', 'Абрамов', '1990-12-31 19:00:00+00', NULL, 'Каспийск', NULL);
INSERT INTO public.users VALUES (84, 'Арсений', 'Абрамов', '1970-12-31 19:00:00+00', NULL, 'Тихорецк', NULL);
INSERT INTO public.users VALUES (85, 'Александр', 'Абрамов', '1939-12-31 19:00:00+00', NULL, 'Кузнецк', NULL);
INSERT INTO public.users VALUES (86, 'Елисей', 'Абрамов', '1966-12-31 19:00:00+00', NULL, 'Тихорецк', NULL);
INSERT INTO public.users VALUES (87, 'Матвей', 'Абрамов', '1927-12-31 20:00:00+00', NULL, 'Ставрополь', NULL);
INSERT INTO public.users VALUES (88, 'Андрей', 'Абрамов', '1928-12-31 20:00:00+00', NULL, 'Ачинск', NULL);
INSERT INTO public.users VALUES (89, 'Арсений', 'Абрамов', '1925-12-31 20:00:00+00', NULL, 'Донской', NULL);
INSERT INTO public.users VALUES (90, 'Дмитрий', 'Абрамов', '1911-12-31 19:57:27+00', NULL, 'Выборг', NULL);
INSERT INTO public.users VALUES (91, 'Евгений', 'Абрамов', '1922-12-31 20:00:00+00', NULL, 'Железногорск (Красноярский край)', NULL);
INSERT INTO public.users VALUES (92, 'Михаил', 'Абрамов', '1962-12-31 19:00:00+00', NULL, 'Арзамас', NULL);
INSERT INTO public.users VALUES (93, 'Максим', 'Абрамов', '1942-12-31 19:00:00+00', NULL, 'Санкт-Петербург', NULL);
INSERT INTO public.users VALUES (94, 'Никита', 'Абрамов', '2012-12-31 18:00:00+00', NULL, 'Ставрополь', NULL);
INSERT INTO public.users VALUES (95, 'Андрей', 'Абрамов', '1905-12-31 19:57:27+00', NULL, 'Златоуст', NULL);
INSERT INTO public.users VALUES (96, 'Николай', 'Абрамов', '1937-12-31 19:00:00+00', NULL, 'Казань', NULL);
INSERT INTO public.users VALUES (97, 'Лев', 'Абрамов', '2003-12-31 19:00:00+00', NULL, 'Биробиджан', NULL);
INSERT INTO public.users VALUES (98, 'Матвей', 'Абрамов', '1974-12-31 19:00:00+00', NULL, 'Альметьевск', NULL);
INSERT INTO public.users VALUES (99, 'Михаил', 'Абрамов', '1907-12-31 19:57:27+00', NULL, 'Горно-Алтайск', NULL);
INSERT INTO public.users VALUES (100, 'Дмитрий', 'Абрамов', '2002-12-31 19:00:00+00', NULL, 'Бор', NULL);


--
-- TOC entry 3400 (class 0 OID 16405)
-- Dependencies: 220
-- Data for Name: users_friends; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3403 (class 0 OID 16410)
-- Dependencies: 223
-- Data for Name: users_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 218
-- Name: logins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logins_id_seq', 1, false);


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_friends_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_friends_id_seq', 1, false);


--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 222
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 224
-- Name: users_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_posts_id_seq', 1, false);


--
-- TOC entry 3249 (class 2606 OID 16452)
-- Name: outbox outbox_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.outbox
    ADD CONSTRAINT outbox_pkey PRIMARY KEY (id);


--
-- TOC entry 3247 (class 2606 OID 16422)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3250 (class 1259 OID 16453)
-- Name: outbox_unsent_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX outbox_unsent_idx ON public.outbox USING btree (sent_at) WHERE (sent_at IS NULL);


--
-- TOC entry 3251 (class 2606 OID 16423)
-- Name: dialogs fk_from_user_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dialogs
    ADD CONSTRAINT fk_from_user_user_id FOREIGN KEY (from_user) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 3252 (class 2606 OID 16428)
-- Name: dialogs fk_to_user_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dialogs
    ADD CONSTRAINT fk_to_user_user_id FOREIGN KEY (to_user) REFERENCES public.users(id) NOT VALID;


-- Completed on 2025-08-20 11:15:01

--
-- PostgreSQL database dump complete
--

-- Completed on 2025-08-20 11:15:01

--
-- PostgreSQL database cluster dump complete
--

