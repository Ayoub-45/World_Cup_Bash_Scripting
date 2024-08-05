--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12 (Ubuntu 14.12-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.12 (Ubuntu 14.12-0ubuntu0.22.04.1)

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
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    year integer NOT NULL,
    round character varying NOT NULL,
    winner_id integer NOT NULL,
    opponent_id integer NOT NULL,
    winner_goals integer NOT NULL,
    opponent_goals integer NOT NULL
);


ALTER TABLE public.games OWNER TO postgres;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO postgres;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO postgres;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games (game_id, year, round, winner_id, opponent_id, winner_goals, opponent_goals) FROM stdin;
33	2018	Final	283	284	4	2
34	2018	Third Place	285	286	2	0
35	2018	Semi-Final	284	286	2	1
36	2018	Semi-Final	283	285	1	0
37	2018	Quarter-Final	284	287	3	2
38	2018	Quarter-Final	286	288	2	0
39	2018	Quarter-Final	285	289	2	1
40	2018	Quarter-Final	283	290	2	0
41	2018	Eighth-Final	286	291	2	1
42	2018	Eighth-Final	288	292	1	0
43	2018	Eighth-Final	285	293	3	2
44	2018	Eighth-Final	289	294	2	0
45	2018	Eighth-Final	284	295	2	1
46	2018	Eighth-Final	287	296	2	1
47	2018	Eighth-Final	290	297	2	1
48	2018	Eighth-Final	283	298	4	3
49	2014	Final	299	298	1	0
50	2014	Third Place	300	289	3	0
51	2014	Semi-Final	298	300	1	0
52	2014	Semi-Final	299	289	7	1
53	2014	Quarter-Final	300	301	1	0
54	2014	Quarter-Final	298	285	1	0
55	2014	Quarter-Final	289	291	2	1
56	2014	Quarter-Final	299	283	1	0
57	2014	Eighth-Final	289	302	2	1
58	2014	Eighth-Final	291	290	2	0
59	2014	Eighth-Final	283	303	2	0
60	2014	Eighth-Final	299	304	2	1
61	2014	Eighth-Final	300	294	2	1
62	2014	Eighth-Final	301	305	2	1
63	2014	Eighth-Final	298	292	1	0
64	2014	Eighth-Final	285	306	2	1
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teams (team_id, name) FROM stdin;
283	France
284	Croatia
285	Belgium
286	England
287	Russia
288	Sweden
289	Brazil
290	Uruguay
291	Colombia
292	Switzerland
293	Japan
294	Mexico
295	Denmark
296	Spain
297	Portugal
298	Argentina
299	Germany
300	Netherlands
301	Costa Rica
302	Chile
303	Nigeria
304	Algeria
305	Greece
306	United States
\.


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.games_game_id_seq', 64, true);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 306, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: games opponent_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT opponent_fk FOREIGN KEY (opponent_id) REFERENCES public.teams(team_id);


--
-- Name: games winner_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT winner_fk FOREIGN KEY (winner_id) REFERENCES public.teams(team_id);


--
-- PostgreSQL database dump complete
--

