--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.4

-- Started on 2025-06-10 12:31:11

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
-- TOC entry 3580 (class 0 OID 17236)
-- Dependencies: 275
-- Data for Name: logins; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.logins VALUES (1, 4, 'admin', '12345qwerty');
INSERT INTO public.logins VALUES (2, 5, 'postgres', '7ac60358d4f56501575fa9def6cc3bc3');
INSERT INTO public.logins VALUES (3, 6, 'pup', 'd1377c0281728bb8c20f8df217a7e094');


--
-- TOC entry 3582 (class 0 OID 17242)
-- Dependencies: 277
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
-- TOC entry 3583 (class 0 OID 17247)
-- Dependencies: 278
-- Data for Name: users_friends; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users_friends VALUES (1, 1, 2);


--
-- TOC entry 3586 (class 0 OID 17252)
-- Dependencies: 281
-- Data for Name: users_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users_posts VALUES (1, 2, 'Есть у нас бананы !!', '2025-06-10 06:19:45.877817+00');
INSERT INTO public.users_posts VALUES (2, 2, 'И даже ананасы !!', '2025-06-10 06:19:45.888915+00');
INSERT INTO public.users_posts VALUES (3, 2, 'И апельсины !!', '2025-06-10 06:20:23.776202+00');
INSERT INTO public.users_posts VALUES (4, 2, 'Заказывайте !!', '2025-06-10 06:20:56.621993+00');


--
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 276
-- Name: logins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logins_id_seq', 1, false);


--
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 279
-- Name: users_friends_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_friends_id_seq', 1, true);


--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 280
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 282
-- Name: users_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_posts_id_seq', 4, true);


-- Completed on 2025-06-10 12:31:11

--
-- PostgreSQL database dump complete
--

