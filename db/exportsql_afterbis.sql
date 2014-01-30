--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.4
-- Dumped by pg_dump version 9.2.2
-- Started on 2014-01-29 15:47:42 CET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 169 (class 1259 OID 44120)
-- Name: coupons; Type: TABLE; Schema: public; Owner: merciedgar; Tablespace: 
--

CREATE TABLE coupons (
    id integer NOT NULL,
    code character varying(255),
    event character varying(255),
    promoter character varying(255),
    distributed boolean DEFAULT false,
    account_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.coupons OWNER TO merciedgar;

--
-- TOC entry 168 (class 1259 OID 44118)
-- Name: coupons_id_seq; Type: SEQUENCE; Schema: public; Owner: merciedgar
--

CREATE SEQUENCE coupons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coupons_id_seq OWNER TO merciedgar;

--
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 168
-- Name: coupons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: merciedgar
--

ALTER SEQUENCE coupons_id_seq OWNED BY coupons.id;


--
-- TOC entry 2355 (class 2604 OID 44123)
-- Name: id; Type: DEFAULT; Schema: public; Owner: merciedgar
--

ALTER TABLE ONLY coupons ALTER COLUMN id SET DEFAULT nextval('coupons_id_seq'::regclass);


--
-- TOC entry 2361 (class 0 OID 44120)
-- Dependencies: 169
-- Data for Name: coupons; Type: TABLE DATA; Schema: public; Owner: merciedgar
--

COPY coupons (id, code, event, promoter, distributed, account_id, created_at, updated_at) FROM stdin;
5	6Z5OY5	BIS2014	Christophe	f	\N	2014-01-21 16:34:39.138686	2014-01-21 17:06:03.287872
9	ZGDAAI	BIS2014	Christophe	t	\N	2014-01-21 16:34:39.324048	2014-01-22 11:21:06.979817
2	SUNN8D	BIS2014	Christophe	t	\N	2014-01-21 16:34:39.100748	2014-01-22 11:21:10.28112
4	4VE35D	BIS2014	Christophe	t	\N	2014-01-21 16:34:39.127046	2014-01-22 11:21:15.420661
6	7YYPPY	BIS2014	Christophe	t	\N	2014-01-21 16:34:39.296501	2014-01-22 11:21:17.755398
7	LPIWEG	BIS2014	Christophe	t	\N	2014-01-21 16:34:39.307753	2014-01-22 11:21:20.489416
8	HKBTSP	BIS2014	Christophe	t	\N	2014-01-21 16:34:39.315961	2014-01-22 11:21:21.804205
10	MCFBWS	BIS2014	Christophe	t	\N	2014-01-21 16:34:39.333225	2014-01-22 12:12:49.354017
17	IPQECW	BIS2014	Christophe	f	\N	2014-01-22 12:33:00.715321	2014-01-22 12:33:00.715321
3	S65O2P	BIS2014	Christophe	t	\N	2014-01-21 16:34:39.116537	2014-01-22 12:33:30.269305
1	R323IV	BIS2014	Christophe	t	\N	2014-01-21 16:34:39.083588	2014-01-22 12:33:47.528705
11	8VN9QW	BIS2014	Christophe	t	\N	2014-01-22 12:33:00.657306	2014-01-22 13:55:19.790586
12	CWXWOK	BIS2014	Christophe	t	\N	2014-01-22 12:33:00.673758	2014-01-22 15:15:23.800301
13	XUR0O1	BIS2014	Christophe	t	\N	2014-01-22 12:33:00.683809	2014-01-22 17:00:29.474128
14	EY5PZ7	BIS2014	Christophe	t	\N	2014-01-22 12:33:00.691569	2014-01-22 17:52:32.999174
15	2YKXVA	BIS2014	Christophe	t	\N	2014-01-22 12:33:00.699837	2014-01-23 10:09:15.93857
20	IAAK8P	BIS2014	Christophe	t	\N	2014-01-22 12:33:00.738464	2014-01-23 11:23:24.212235
16	XNZCLV	BIS2014	Christophe	t	\N	2014-01-22 12:33:00.707613	2014-01-23 16:54:36.590797
18	T73MBM	BIS2014	Christophe	t	\N	2014-01-22 12:33:00.723138	2014-01-23 17:15:56.537706
19	2J0I0P	BIS2014	Christophe	t	\N	2014-01-22 12:33:00.730781	2014-01-23 17:16:22.495074
21	7OGPKX	BIS2014	Christophe	f	\N	2014-01-23 17:17:07.371662	2014-01-23 17:17:07.371662
22	86AK8X	BIS2014	Christophe	t	\N	2014-01-23 17:17:07.384138	2014-01-23 17:17:38.598044
\.


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 168
-- Name: coupons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: merciedgar
--

SELECT pg_catalog.setval('coupons_id_seq', 22, true);


--
-- TOC entry 2358 (class 2606 OID 44129)
-- Name: coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: merciedgar; Tablespace: 
--

ALTER TABLE ONLY coupons
    ADD CONSTRAINT coupons_pkey PRIMARY KEY (id);


--
-- TOC entry 2359 (class 1259 OID 44130)
-- Name: index_coupons_on_account_id; Type: INDEX; Schema: public; Owner: merciedgar; Tablespace: 
--

CREATE INDEX index_coupons_on_account_id ON coupons USING btree (account_id);


-- Completed on 2014-01-29 15:47:42 CET

--
-- PostgreSQL database dump complete
--

