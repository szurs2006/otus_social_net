--
-- PostgreSQL database cluster dump
--

-- Started on 2025-08-19 15:10:17

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:wBZMtrHl14l/z/mdQBUEEA==$DLhmkYZ5YySQZknA+uqGqJ21Odhq/E3ndLIimnnfLMA=:hBsk6E+iI60AZtWXOOoAkdmzVSSMvIQsuZMmfDh78yk=';

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

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+2)
-- Dumped by pg_dump version 16.4

-- Started on 2025-08-19 15:10:17

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

-- Completed on 2025-08-19 15:10:18

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

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+2)
-- Dumped by pg_dump version 16.4

-- Started on 2025-08-19 15:10:18

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
-- TOC entry 216 (class 1259 OID 16394)
-- Name: processed_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.processed_events (
    event_id uuid NOT NULL,
    processed_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.processed_events OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16388)
-- Name: unread_counters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unread_counters (
    user_id bigint NOT NULL,
    unread_count bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.unread_counters OWNER TO postgres;

--
-- TOC entry 3356 (class 0 OID 16394)
-- Dependencies: 216
-- Data for Name: processed_events; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3355 (class 0 OID 16388)
-- Dependencies: 215
-- Data for Name: unread_counters; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3211 (class 2606 OID 16399)
-- Name: processed_events processed_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.processed_events
    ADD CONSTRAINT processed_events_pkey PRIMARY KEY (event_id);


--
-- TOC entry 3209 (class 2606 OID 16393)
-- Name: unread_counters unread_counters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unread_counters
    ADD CONSTRAINT unread_counters_pkey PRIMARY KEY (user_id);


-- Completed on 2025-08-19 15:10:18

--
-- PostgreSQL database dump complete
--

-- Completed on 2025-08-19 15:10:18

--
-- PostgreSQL database cluster dump complete
--

