--
-- PostgreSQL database cluster dump
--
-- Modified

SET default_transaction_read_only = off;

CREATE TABLE favorited_twaats (
    who_id integer NOT NULL,
    twaat_id integer NOT NULL
);

CREATE TABLE follower (
    who_id integer NOT NULL,
    whom_id integer NOT NULL,
    deleted boolean DEFAULT false
);

CREATE TABLE twaat (
    id integer NOT NULL,
    user_id integer,
    parent_id integer,
    text character varying(256),
    img character varying(512),
    "timestamp" timestamp without time zone DEFAULT now(),
    favorited_count integer DEFAULT 0,
    deleted boolean DEFAULT false
);


CREATE SEQUENCE twaat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE users (
    id integer NOT NULL,
    full_name character varying(64) NOT NULL,
    email character varying(64) NOT NULL,
    password character varying NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now(),
    avatar character varying,
    description character varying(256)
);

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE users_id_seq OWNED BY users.id;

ALTER TABLE ONLY twaat ALTER COLUMN id SET DEFAULT nextval('twaat_id_seq'::regclass);

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);

COPY favorited_twaats (who_id, twaat_id) FROM stdin;
30	346
30	347
30	348
30	12
30	1
30	11
30	8
30	3
30	6
30	16
30	117
30	318
30	239
30	5
\.


COPY follower (who_id, whom_id, deleted) FROM stdin;
30	21	f
30	23	f
30	24	f
30	25	f
1	30	f
69	51	f
71	60	f
60	95	f
81	51	f
89	69	f
54	81	f
70	78	f
50	80	f
89	54	f
99	52	f
67	88	f
55	53	f
83	68	f
83	92	f
73	97	f
98	59	f
89	89	f
52	98	f
81	98	f
88	51	f
65	51	f
93	98	f
96	74	f
60	53	f
59	79	f
77	74	f
53	82	f
55	76	f
76	71	f
61	64	f
67	66	f
92	74	f
65	90	f
78	70	f
64	54	f
58	77	f
57	54	f
79	95	f
57	64	f
86	85	f
30	1	t
30	100	f
30	99	f
21	21	f
21	30	f
30	48	f
\.

COPY twaat (id, user_id, parent_id, text, img, "timestamp", favorited_count, deleted) FROM stdin;
238	67	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut	\N	2016-10-05 11:23:25.425731	0	\N
15	30	\N	What happens if I have veery long text? <strong> Even with some html? </strong> 	\N	2016-09-28 11:49:37.086273	72	\N
12	1	\N	Nonii, pushattu liveen ja livena ollaan :)	\N	2016-09-28 11:37:32.743238	8	\N
9	1	1	second	\N	2016-09-26 10:41:19.489024	47	\N
14	30	\N	Latest update!	\N	2016-09-28 11:46:42.895625	95	\N
1	1	\N	I am the first twaat, hello world	\N	2016-09-26 10:38:36.81689	5	\N
240	95	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus.	\N	2016-10-05 11:23:25.425731	0	\N
241	73	\N	Lorem ipsum	\N	2016-10-05 11:23:25.425731	0	\N
11	30	\N	123	\N	2016-09-28 11:04:39.564401	11	\N
13	30	\N	123	\N	2016-09-28 11:46:35.180395	89	\N
242	81	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu	\N	2016-10-05 11:23:25.425731	0	\N
243	68	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur	\N	2016-10-05 11:23:25.425731	0	\N
244	86	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu	\N	2016-10-05 11:23:25.425731	0	\N
245	89	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus.	\N	2016-10-05 11:23:25.425731	0	\N
246	88	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna	\N	2016-10-05 11:23:25.425731	0	\N
247	91	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed	\N	2016-10-05 11:23:25.425731	0	\N
248	88	\N	Lorem ipsum dolor sit	\N	2016-10-05 11:23:25.43041	0	\N
249	59	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec	\N	2016-10-05 11:23:25.43041	0	\N
250	55	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut	\N	2016-10-05 11:23:25.43041	0	\N
251	71	\N	Lorem ipsum dolor sit amet, consectetuer	\N	2016-10-05 11:23:25.43041	0	\N
252	78	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus.	\N	2016-10-05 11:23:25.43041	0	\N
253	93	\N	Lorem ipsum dolor sit amet,	\N	2016-10-05 11:23:25.43041	0	\N
254	58	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut	\N	2016-10-05 11:23:25.43041	0	\N
255	57	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer	\N	2016-10-05 11:23:25.43041	0	\N
256	94	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis	\N	2016-10-05 11:23:25.43041	0	\N
257	98	\N	Lorem	\N	2016-10-05 11:23:25.43041	0	\N
258	55	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing	\N	2016-10-05 11:23:25.431328	0	\N
259	91	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper.	\N	2016-10-05 11:23:25.431328	0	\N
260	98	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna	\N	2016-10-05 11:23:25.431328	0	\N
261	63	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis	\N	2016-10-05 11:23:25.431328	0	\N
262	69	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit.	\N	2016-10-05 11:23:25.431328	0	\N
263	59	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus.	\N	2016-10-05 11:23:25.431328	0	\N
264	65	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit.	\N	2016-10-05 11:23:25.431328	0	\N
265	73	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu	\N	2016-10-05 11:23:25.431328	0	\N
266	96	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus.	\N	2016-10-05 11:23:25.431328	0	\N
267	73	\N	Lorem ipsum dolor	\N	2016-10-05 11:23:25.431328	0	\N
268	84	\N	Lorem ipsum dolor sit amet,	\N	2016-10-05 11:23:25.432144	0	\N
269	92	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et	\N	2016-10-05 11:23:25.432144	0	\N
270	86	\N	Lorem ipsum dolor sit amet, consectetuer	\N	2016-10-05 11:23:25.432144	0	\N
271	81	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et	\N	2016-10-05 11:23:25.432144	0	\N
272	50	\N	Lorem ipsum	\N	2016-10-05 11:23:25.432144	0	\N
273	52	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam	\N	2016-10-05 11:23:25.432144	0	\N
274	84	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing	\N	2016-10-05 11:23:25.432144	0	\N
275	56	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet	\N	2016-10-05 11:23:25.432144	0	\N
276	90	\N	Lorem ipsum	\N	2016-10-05 11:23:25.432144	0	\N
277	60	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed	\N	2016-10-05 11:23:25.432144	0	\N
278	84	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit.	\N	2016-10-05 11:23:25.43289	0	\N
279	67	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor.	\N	2016-10-05 11:23:25.43289	0	\N
280	97	\N	Lorem ipsum dolor	\N	2016-10-05 11:23:25.43289	0	\N
281	92	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper.	\N	2016-10-05 11:23:25.43289	0	\N
8	25	\N	Lorem dolor sit amet, consect foo Bar	\N	2016-09-26 10:41:19.488624	2	\N
10	30	\N	123	\N	2016-09-28 11:02:57.126665	65	\N
3	1	1	second	\N	2016-09-26 10:38:36.818353	17	\N
239	100	\N	Lorem ipsum dolor	\N	2016-10-05 11:23:25.425731	1	\N
341	30	\N	231	\N	2016-10-14 20:04:17.715139	0	f
6	25	\N	Lorem ipsum dolor sit amet, consect	\N	2016-09-26 10:41:19.487775	36	\N
117	30	\N	ok	\N	2016-10-03 17:46:30.77479	1	\N
5	1	\N	I am the first twaat, hello world	\N	2016-09-26 10:41:19.487002	40	\N
343	30	\N	clx;zcxlz;l,xz;clxzczxclk	\N	2016-10-14 20:04:41.20712	0	f
345	30	\N	c	\N	2016-10-14 20:07:21.095858	0	f
346	30	\N	666\r\n	\N	2016-10-14 20:07:52.450749	0	f
347	30	\N	c	\N	2016-10-15 18:40:36.290849	0	f
348	30	\N	x	\N	2016-10-15 18:40:56.771621	1	f
282	71	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et	\N	2016-10-05 11:23:25.43289	0	\N
283	80	\N	Lorem ipsum	\N	2016-10-05 11:23:25.43289	0	\N
284	87	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus.	\N	2016-10-05 11:23:25.43289	0	\N
285	62	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer	\N	2016-10-05 11:23:25.43289	0	\N
286	62	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et	\N	2016-10-05 11:23:25.43289	0	\N
287	97	\N	Lorem ipsum dolor sit	\N	2016-10-05 11:23:25.43289	0	\N
288	93	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor.	\N	2016-10-05 11:23:25.43384	0	\N
289	85	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et	\N	2016-10-05 11:23:25.43384	0	\N
290	50	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et	\N	2016-10-05 11:23:25.43384	0	\N
291	61	\N	Lorem	\N	2016-10-05 11:23:25.43384	0	\N
292	72	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper.	\N	2016-10-05 11:23:25.43384	0	\N
293	90	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing	\N	2016-10-05 11:23:25.43384	0	\N
294	53	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et	\N	2016-10-05 11:23:25.43384	0	\N
295	60	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer	\N	2016-10-05 11:23:25.43384	0	\N
296	64	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet	\N	2016-10-05 11:23:25.43384	0	\N
297	88	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur	\N	2016-10-05 11:23:25.43384	0	\N
298	88	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit.	\N	2016-10-05 11:23:25.434714	0	\N
299	50	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing	\N	2016-10-05 11:23:25.434714	0	\N
300	76	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut	\N	2016-10-05 11:23:25.434714	0	\N
301	78	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing	\N	2016-10-05 11:23:25.434714	0	\N
302	78	\N	Lorem ipsum dolor sit amet, consectetuer	\N	2016-10-05 11:23:25.434714	0	\N
303	72	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper.	\N	2016-10-05 11:23:25.434714	0	\N
304	87	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at	\N	2016-10-05 11:23:25.434714	0	\N
305	65	\N	Lorem ipsum dolor sit amet, consectetuer	\N	2016-10-05 11:23:25.434714	0	\N
306	92	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing	\N	2016-10-05 11:23:25.434714	0	\N
307	58	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis	\N	2016-10-05 11:23:25.434714	0	\N
308	57	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer	\N	2016-10-05 11:23:25.435589	0	\N
309	92	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna	\N	2016-10-05 11:23:25.435589	0	\N
310	58	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing	\N	2016-10-05 11:23:25.435589	0	\N
311	68	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit.	\N	2016-10-05 11:23:25.435589	0	\N
312	87	\N	Lorem ipsum dolor	\N	2016-10-05 11:23:25.435589	0	\N
313	98	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer	\N	2016-10-05 11:23:25.435589	0	\N
314	83	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis	\N	2016-10-05 11:23:25.435589	0	\N
315	51	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing	\N	2016-10-05 11:23:25.435589	0	\N
316	54	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at	\N	2016-10-05 11:23:25.435589	0	\N
317	94	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur	\N	2016-10-05 11:23:25.435589	0	\N
319	55	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer	\N	2016-10-05 11:23:25.436539	0	\N
320	68	\N	Lorem	\N	2016-10-05 11:23:25.436539	0	\N
321	91	\N	Lorem ipsum dolor sit amet,	\N	2016-10-05 11:23:25.436539	0	\N
322	54	\N	Lorem ipsum dolor sit amet, consectetuer	\N	2016-10-05 11:23:25.436539	0	\N
323	51	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus.	\N	2016-10-05 11:23:25.436539	0	\N
324	71	\N	Lorem	\N	2016-10-05 11:23:25.436539	0	\N
325	90	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus.	\N	2016-10-05 11:23:25.436539	0	\N
326	77	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed	\N	2016-10-05 11:23:25.436539	0	\N
327	97	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam	\N	2016-10-05 11:23:25.436539	0	\N
328	78	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut	\N	2016-10-05 11:23:25.437325	0	\N
329	63	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis	\N	2016-10-05 11:23:25.437325	0	\N
330	72	\N	Lorem	\N	2016-10-05 11:23:25.437325	0	\N
331	75	\N	Lorem ipsum	\N	2016-10-05 11:23:25.437325	0	\N
332	50	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut	\N	2016-10-05 11:23:25.437325	0	\N
333	50	\N	Lorem ipsum	\N	2016-10-05 11:23:25.437325	0	\N
334	68	\N	Lorem	\N	2016-10-05 11:23:25.437325	0	\N
335	71	\N	Lorem ipsum dolor sit amet, consectetuer	\N	2016-10-05 11:23:25.437325	0	\N
336	61	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur	\N	2016-10-05 11:23:25.437325	0	\N
337	56	\N	Lorem ipsum	\N	2016-10-05 11:23:25.437325	0	\N
318	100	\N	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed	\N	2016-10-05 11:23:25.436539	1	\N
342	30	\N	dsadsa	\N	2016-10-14 20:04:33.006782	0	f
344	30	\N	3	\N	2016-10-14 20:07:18.63555	0	f
16	30	\N	What happens if I have veery long text? <strong> Even with some html? </strong> What happens if I have veery long text? <strong> Even with some html? </strong> What happens if I have veery long text? <strong> Even with some html? </strong> 	\N	2016-09-28 11:49:40.464954	27	\N
338	30	\N	foobaar lleee	\N	2016-10-14 19:35:35.932298	0	f
339	30	\N	foobaar lleee	\N	2016-10-14 19:36:31.698093	0	f
349	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 20:45:54.892874	0	f
350	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 20:46:10.563878	0	f
351	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 20:46:29.367222	0	f
352	30	318	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed	\N	2016-10-15 20:50:15.041318	0	f
353	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 20:52:08.223639	0	f
354	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 20:55:11.796246	0	f
355	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:00:49.584699	0	f
356	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:05:53.782056	0	f
357	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:06:10.618218	0	f
358	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:06:20.378363	0	f
359	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:06:57.357726	0	f
360	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:07:27.897359	0	f
361	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:08:43.291745	0	f
362	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:09:19.939672	0	f
363	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:10:12.669816	0	f
364	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:15:38.971107	0	f
365	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:16:00.940509	0	f
366	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:19:59.762128	0	f
367	30	318	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed	\N	2016-10-15 21:21:21.33919	0	f
368	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:22:21.202518	0	f
369	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:22:49.427126	0	f
370	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:23:31.015779	0	f
371	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:24:08.800244	0	f
372	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:25:02.957681	0	f
373	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:25:41.49931	0	f
374	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:26:19.038858	0	f
375	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:26:50.713723	0	f
376	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:27:59.856476	0	f
377	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:29:26.353851	0	f
7	21	\N	Lorem dolor sit amet, consect	\N	2016-09-26 10:41:19.488232	77	\N
378	30	\N	d	\N	2016-10-15 21:36:09.224841	0	f
379	30	7	Lorem dolor sit amet, consect	\N	2016-10-15 21:36:12.272851	0	f
380	30	\N	x	\N	2016-10-15 23:17:37.452519	0	f
\.

SELECT pg_catalog.setval('twaat_id_seq', 380, true);

COPY users (id, full_name, email, password, "timestamp", avatar, description) FROM stdin;
1	miro sorja	miro.sorja@mail.com	salasana	2016-09-17 19:54:40.685972	\N	\N
21	full name	asd@asd	asd	2016-09-17 23:01:28.980461	\N	\N
23	Kalle Niemi	kalle.niemi@email.com	passw0rd	2016-09-18 16:06:21.187143	\N	\N
24	Matti Niemi	matti.niemi@email.com	passw0rd	2016-09-18 16:08:40.809134	\N	\N
25	Sami Niemi	sami.niemi@email.com	passw0rd	2016-09-18 16:08:40.812219	\N	\N
46	Rhonda Hayes	tellus.eu.augue@nostra.edu	LLB55WDX8SQ	2016-10-05 11:16:03.045943	\N	augue eu tellus. Phasellus elit pede, malesuada vel, venenatis vel, faucibus id, libero.
47	Hunter Zimmerman	Morbi@habitantmorbitristique.net	VMJ70DWC9OP	2016-10-05 11:16:03.045943	\N	id nunc interdum feugiat. Sed nec metus facilisis lorem tristique aliquet. Phasellus fermentum
48	Marshall Fernandez	nec.urna.suscipit@AliquamnislNulla.com	HCJ15TTM8UT	2016-10-05 11:16:03.045943	\N	facilisis facilisis, magna tellus faucibus leo, in lobortis tellus justo sit amet nulla.
49	Beverly Tate	elementum@mauris.co.uk	MRY97GNE3KA	2016-10-05 11:16:03.045943	\N	nisl. Quisque fringilla euismod enim. Etiam gravida molestie arcu. Sed eu nibh vulputate
50	Brent Garza	Suspendisse.aliquet.molestie@arcuMorbisit.edu	QHG48BPG0AI	2016-10-05 11:16:03.045943	\N	auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus.
51	Garth Frost	fames.ac.turpis@ultricesposuere.org	PYS91NDO1IT	2016-10-05 11:16:03.045943	\N	condimentum eget, volutpat ornare, facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean gravida
52	Andrew Torres	purus.accumsan.interdum@consequatpurusMaecenas.ca	YQK15KHA0FR	2016-10-05 11:16:03.045943	\N	Praesent luctus. Curabitur egestas nunc sed libero. Proin sed turpis nec mauris blandit
53	Raymond Velasquez	Aenean.eget.magna@Proinvel.ca	ALH43EGC0YY	2016-10-05 11:16:03.045943	\N	eu dolor egestas rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at,
54	Imelda Kemp	tincidunt.aliquam.arcu@egetmassaSuspendisse.net	WSC73AGF2DQ	2016-10-05 11:16:03.045943	\N	eu, ultrices sit amet, risus. Donec nibh enim, gravida sit amet, dapibus id,
55	Cedric Koch	mauris.sit@risus.edu	VQE70BJD0WG	2016-10-05 11:16:03.045943	\N	est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis
56	Rashad Sargent	ac@enimnectempus.edu	CXU42TIX4QF	2016-10-05 11:16:03.045943	\N	In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis
57	Alan Cannon	eget.metus@anteNunc.org	GKX09DAU2VK	2016-10-05 11:16:03.045943	\N	Quisque imperdiet, erat nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus
58	Teagan Spence	sociis@nuncInat.com	BJE58BIZ4MH	2016-10-05 11:16:03.045943	\N	lorem ac risus. Morbi metus. Vivamus euismod urna. Nullam lobortis quam a felis
59	Caldwell Bowman	nibh.lacinia.orci@liberoMorbi.co.uk	HIW73AIV7IX	2016-10-05 11:16:03.045943	\N	nibh enim, gravida sit amet, dapibus id, blandit at, nisi. Cum sociis natoque
60	Rafael Bentley	eu.ultrices@ametfaucibusut.co.uk	WSW86VDL0ZL	2016-10-05 11:16:03.045943	\N	ullamcorper. Duis cursus, diam at pretium aliquet, metus urna convallis erat, eget tincidunt
61	Kane Vasquez	ullamcorper.velit.in@Lorem.co.uk	YGD20IZI5PI	2016-10-05 11:16:03.045943	\N	pede. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
62	Xenos Mcdonald	nec@ipsum.org	YQE34BMX0AS	2016-10-05 11:16:03.045943	\N	nunc interdum feugiat. Sed nec metus facilisis lorem tristique aliquet. Phasellus fermentum convallis
63	Ariana Fields	Sed.dictum@Maurisvestibulumneque.net	RZB24FKC0PT	2016-10-05 11:16:03.045943	\N	hendrerit. Donec porttitor tellus non magna. Nam ligula elit, pretium et, rutrum non,
64	Tanya Skinner	est.mauris.rhoncus@eget.net	OPM26XPP2RW	2016-10-05 11:16:03.045943	\N	vulputate mauris sagittis placerat. Cras dictum ultricies ligula. Nullam enim. Sed nulla ante,
65	Eric Kramer	pretium.aliquet.metus@Phasellus.co.uk	VFW03GEI0QQ	2016-10-05 11:16:03.045943	\N	lobortis, nisi nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut semper
66	Fuller Pickett	Mauris.non.dui@posuere.net	SHM89URA3KZ	2016-10-05 11:16:03.045943	\N	in sodales elit erat vitae risus. Duis a mi fringilla mi lacinia mattis.
67	Matthew Young	aliquet@ipsum.org	OLN04HYN3OF	2016-10-05 11:16:03.045943	\N	Duis elementum, dui quis accumsan convallis, ante lectus convallis est, vitae sodales nisi
68	Gabriel Wooten	neque.pellentesque@egetdictumplacerat.com	FYB76WWA8KU	2016-10-05 11:16:03.045943	\N	tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris
30	123	123	123	2016-09-18 16:10:06.227456	\N	\N
69	Nissim Knapp	a@nonmagna.co.uk	SIJ09LGT1DX	2016-10-05 11:16:03.045943	\N	Fusce diam nunc, ullamcorper eu, euismod ac, fermentum vel, mauris. Integer sem elit,
70	Elvis Holman	ridiculus.mus@nibhAliquam.org	PZP70DFH0MK	2016-10-05 11:16:03.045943	\N	interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh dolor, nonummy ac,
71	Aaron Barton	tellus.sem.mollis@Donecvitae.org	WGG55EUJ4FG	2016-10-05 11:16:03.045943	\N	non massa non ante bibendum ullamcorper. Duis cursus, diam at pretium aliquet, metus
72	Raphael Garrison	Donec@necleo.net	PYN27MUM8GR	2016-10-05 11:16:03.045943	\N	fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies sem magna nec
73	Brent Fry	non.enim.Mauris@elitpedemalesuada.ca	IRH95CCU0GG	2016-10-05 11:16:03.045943	\N	Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec
74	Jermaine George	tincidunt.nibh.Phasellus@Nunc.net	UDJ98JFD9LI	2016-10-05 11:16:03.045943	\N	feugiat nec, diam. Duis mi enim, condimentum eget, volutpat ornare, facilisis eget, ipsum.
75	Laurel Dorsey	nunc.est.mollis@eutelluseu.org	INJ17SSY3PH	2016-10-05 11:16:03.045943	\N	natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec dignissim magna
76	Michael Nieves	id.enim@nonloremvitae.org	LZJ39IKV6IV	2016-10-05 11:16:03.045943	\N	mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut, pellentesque eget, dictum
77	Dylan Anthony	hendrerit.neque.In@Suspendisse.net	YEH50BRZ5AM	2016-10-05 11:16:03.045943	\N	In ornare sagittis felis. Donec tempor, est ac mattis semper, dui lectus rutrum
78	Alexis Decker	lectus.Nullam@laoreetipsum.ca	ISW92KNI3WR	2016-10-05 11:16:03.045943	\N	risus. Morbi metus. Vivamus euismod urna. Nullam lobortis quam a felis ullamcorper viverra.
79	Samuel Fleming	primis@magnis.net	JWP94BBF2SO	2016-10-05 11:16:03.045943	\N	orci. Ut sagittis lobortis mauris. Suspendisse aliquet molestie tellus. Aenean egestas hendrerit neque.
80	Noelani Meyer	In@commodoauctor.net	FVU23OKN9TR	2016-10-05 11:16:03.045943	\N	mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo
81	Baker Morin	bibendum@ullamcorper.org	OAM26VAX1WS	2016-10-05 11:16:03.045943	\N	vitae erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus
82	Lyle Barrera	Nullam.feugiat@lacusMaurisnon.edu	JLA88QAK5GQ	2016-10-05 11:16:03.045943	\N	erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus ligula. Aliquam erat
83	Lev Farley	Fusce@euismod.org	KZM68MAR0OV	2016-10-05 11:16:03.045943	\N	faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas. Duis ac arcu. Nunc
84	Suki Woodard	consequat.dolor@mattisIntegereu.ca	HKR26DZH8UR	2016-10-05 11:16:03.045943	\N	gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras
85	Alana Haynes	a@mollis.co.uk	DZI48KOF8LR	2016-10-05 11:16:03.045943	\N	elit pede, malesuada vel, venenatis vel, faucibus id, libero. Donec consectetuer mauris id
86	Kaden Ruiz	Donec.porttitor.tellus@Integer.ca	KDT90ECY0CW	2016-10-05 11:16:03.045943	\N	lacinia at, iaculis quis, pede. Praesent eu dui. Cum sociis natoque penatibus et
87	Evangeline Baldwin	magna.nec.quam@leoCrasvehicula.edu	QSF93BNX3AZ	2016-10-05 11:16:03.045943	\N	Sed eu nibh vulputate mauris sagittis placerat. Cras dictum ultricies ligula. Nullam enim.
88	Brent Black	et.libero.Proin@ligula.net	ARN01WCD7NB	2016-10-05 11:16:03.045943	\N	rutrum urna, nec luctus felis purus ac tellus. Suspendisse sed dolor. Fusce mi
89	Cora Crosby	eu.turpis@acfacilisis.com	FQS64DBX5KK	2016-10-05 11:16:03.045943	\N	libero est, congue a, aliquet vel, vulputate eu, odio. Phasellus at augue id
90	Denise Watson	arcu@Donecfelis.com	TNA14CSU6UP	2016-10-05 11:16:03.045943	\N	semper, dui lectus rutrum urna, nec luctus felis purus ac tellus. Suspendisse sed
91	Montana William	Duis.at@massa.edu	YMC16KGC4WM	2016-10-05 11:16:03.045943	\N	molestie. Sed id risus quis diam luctus lobortis. Class aptent taciti sociosqu ad
92	Ryan Chan	nibh@sociisnatoque.com	VRK05IGV8DO	2016-10-05 11:16:03.045943	\N	consequat, lectus sit amet luctus vulputate, nisi sem semper erat, in consectetuer ipsum
93	Louis Reynolds	fringilla.euismod@imperdietullamcorperDuis.ca	LMR42TQT3IU	2016-10-05 11:16:03.045943	\N	aliquet vel, vulputate eu, odio. Phasellus at augue id ante dictum cursus. Nunc
94	Lareina Elliott	elit.pharetra@turpisvitae.co.uk	CCQ34NNB3QT	2016-10-05 11:16:03.045943	\N	Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at
95	Ulysses Mendoza	Class.aptent.taciti@ipsumCurabiturconsequat.edu	BNZ51AHQ2VQ	2016-10-05 11:16:03.045943	\N	eu nulla at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero
96	Quentin Browning	Nunc.mauris.Morbi@risusodio.co.uk	DMA56RSE6BT	2016-10-05 11:16:03.949166	\N	iaculis, lacus pede sagittis augue, eu tempor erat neque non quam. Pellentesque habitant
97	Garrett Rosales	vitae.odio@egestasDuis.net	TEY11YDH1IR	2016-10-05 11:16:03.949166	\N	est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis
98	Mariam Abbott	eu.sem@purus.co.uk	ZRZ64HNI0TE	2016-10-05 11:16:03.949166	\N	lectus. Nullam suscipit, est ac facilisis facilisis, magna tellus faucibus leo, in lobortis
99	Tyler Cobb	ultrices.a@nasceturridiculusmus.net	DTW50KUE8IM	2016-10-05 11:16:03.949166	\N	fermentum convallis ligula. Donec luctus aliquet odio. Etiam ligula tortor, dictum eu, placerat
100	Nelle Townsend	vulputate@scelerisquescelerisque.ca	NLR31YDR1XE	2016-10-05 11:16:03.949166	\N	felis purus ac tellus. Suspendisse sed dolor. Fusce mi lorem, vehicula et, rutrum
101	Michael Patton	non.enim.commodo@justoProin.co.uk	TRY88CVP8WX	2016-10-05 11:16:03.949166	\N	Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing
102	Brianna Shields	non.dapibus.rutrum@eutempor.com	GNS92HDM8LF	2016-10-05 11:16:03.949166	\N	orci sem eget massa. Suspendisse eleifend. Cras sed leo. Cras vehicula aliquet libero.
103	Tatum Powell	vitae.sodales.at@mollisPhaselluslibero.ca	ETF18ASW5MW	2016-10-05 11:16:03.949166	\N	elit elit fermentum risus, at fringilla purus mauris a nunc. In at pede.
104	Olga Pace	orci@interdumligulaeu.net	CDL21ZPP0HA	2016-10-05 11:16:03.949166	\N	posuere cubilia Curae; Phasellus ornare. Fusce mollis. Duis sit amet diam eu dolor
105	Margaret Turner	consectetuer@lectusrutrumurna.edu	RGY55LJI1ZZ	2016-10-05 11:16:03.949166	\N	ridiculus mus. Donec dignissim magna a tortor. Nunc commodo auctor velit. Aliquam nisl.
106	Uriel Benjamin	aliquet@Sedet.net	ZPX06BOX6PU	2016-10-05 11:16:03.949166	\N	felis eget varius ultrices, mauris ipsum porta elit, a feugiat tellus lorem eu
107	August Blackwell	est@feugiatplaceratvelit.edu	JKI75BWV7HB	2016-10-05 11:16:03.949166	\N	metus. In lorem. Donec elementum, lorem ut aliquam iaculis, lacus pede sagittis augue,
108	Emerson Sears	lorem@auctor.org	JAR21BWR1HI	2016-10-05 11:16:03.949166	\N	accumsan neque et nunc. Quisque ornare tortor at risus. Nunc ac sem ut
109	Hall Atkinson	lectus.Cum.sociis@semperet.edu	UAB55DVI3BA	2016-10-05 11:16:03.949166	\N	Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices
110	Quinn Soto	lacus.Nulla.tincidunt@atarcuVestibulum.org	GXL81WRP0FD	2016-10-05 11:16:03.949166	\N	ornare sagittis felis. Donec tempor, est ac mattis semper, dui lectus rutrum urna,
111	Harrison Roy	Mauris@viverraDonec.org	SDP68YFK0GG	2016-10-05 11:16:03.949166	\N	quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac
112	Edan Calhoun	nec.enim.Nunc@lacusAliquamrutrum.co.uk	PDC68BKT0NN	2016-10-05 11:16:03.949166	\N	dui. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
113	Scarlett Fox	consequat.purus@inconsectetuer.net	PBT43MPW4XX	2016-10-05 11:16:03.949166	\N	eu tempor erat neque non quam. Pellentesque habitant morbi tristique senectus et netus
114	Magee Jordan	mauris.rhoncus@gravidasagittisDuis.ca	VAF06QCT9YI	2016-10-05 11:16:03.949166	\N	ante dictum cursus. Nunc mauris elit, dictum eu, eleifend nec, malesuada ut, sem.
115	Diana Richard	Lorem.ipsum.dolor@sollicitudinadipiscing.net	SLW74DSF4FE	2016-10-05 11:16:03.949166	\N	hendrerit a, arcu. Sed et libero. Proin mi. Aliquam gravida mauris ut mi.
116	Piper Hunter	Nunc.commodo.auctor@sapienimperdietornare.ca	LFA07KXY1EJ	2016-10-05 11:16:03.949166	\N	ac libero nec ligula consectetuer rhoncus. Nullam velit dui, semper et, lacinia vitae,
117	Oscar Santiago	ullamcorper.eu.euismod@non.net	ELG72PVL1UT	2016-10-05 11:16:03.949166	\N	In mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris
118	Aladdin Andrews	elit.pede@lectusante.co.uk	SPR68TBO7YY	2016-10-05 11:16:03.949166	\N	odio, auctor vitae, aliquet nec, imperdiet nec, leo. Morbi neque tellus, imperdiet non,
119	Brooke Howell	enim.Curabitur.massa@leoinlobortis.ca	FIJ24HEE9MZ	2016-10-05 11:16:03.949166	\N	sem elit, pharetra ut, pharetra sed, hendrerit a, arcu. Sed et libero. Proin
120	Juliet Hammond	urna.nec@gravida.ca	LQF41COH5LK	2016-10-05 11:16:03.949166	\N	risus. Donec nibh enim, gravida sit amet, dapibus id, blandit at, nisi. Cum
121	Ciara Suarez	Proin@Maecenasornareegestas.edu	NJH19KSM0OR	2016-10-05 11:16:03.949166	\N	consectetuer adipiscing elit. Etiam laoreet, libero et tristique pellentesque, tellus sem mollis dui,
122	Callie Randall	mauris.erat@velarcueu.net	EEA20ICR3OS	2016-10-05 11:16:03.949166	\N	facilisi. Sed neque. Sed eget lacus. Mauris non dui nec urna suscipit nonummy.
123	Keane Suarez	tristique.pellentesque@quis.com	YRT78XIW4OD	2016-10-05 11:16:03.949166	\N	ipsum sodales purus, in molestie tortor nibh sit amet orci. Ut sagittis lobortis
124	Eve Mcintosh	tempor.lorem@Integersemelit.org	QOB17OJD8KT	2016-10-05 11:16:03.949166	\N	Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies
125	Yardley Moss	magna.Ut@loremluctus.co.uk	SQG60SHA3GQ	2016-10-05 11:16:03.949166	\N	Maecenas malesuada fringilla est. Mauris eu turpis. Nulla aliquet. Proin velit. Sed malesuada
126	Tanner Harrington	porttitor.interdum@loremsitamet.edu	MOY23GAJ0GG	2016-10-05 11:16:03.949166	\N	parturient montes, nascetur ridiculus mus. Donec dignissim magna a tortor. Nunc commodo auctor
127	Kylee Nichols	hendrerit@Quisquepurus.ca	ZFD39SJH4RX	2016-10-05 11:16:03.949166	\N	Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;
128	Cameron Gillespie	leo.Cras.vehicula@accumsansed.edu	WBO51PUE5LP	2016-10-05 11:16:03.949166	\N	orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam
129	Alec Ellison	placerat.orci@vestibulummassa.edu	YCG23IGE8QI	2016-10-05 11:16:03.949166	\N	rutrum lorem ac risus. Morbi metus. Vivamus euismod urna. Nullam lobortis quam a
130	Alisa Carlson	amet.lorem.semper@blanditviverraDonec.edu	PTT57VRG7YJ	2016-10-05 11:16:03.949166	\N	placerat. Cras dictum ultricies ligula. Nullam enim. Sed nulla ante, iaculis nec, eleifend
131	Deborah Flores	nibh@posuere.com	EZZ97FZR6BB	2016-10-05 11:16:03.949166	\N	ipsum dolor sit amet, consectetuer adipiscing elit. Aliquam auctor, velit eget laoreet posuere,
132	Patricia Sanders	mauris.Morbi.non@vulputatemaurissagittis.co.uk	PRS60YQT8RS	2016-10-05 11:16:03.949166	\N	sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut,
133	Giacomo Calhoun	elit@gravida.org	NCB24OIU7UG	2016-10-05 11:16:03.949166	\N	imperdiet nec, leo. Morbi neque tellus, imperdiet non, vestibulum nec, euismod in, dolor.
134	Kennan Nieves	Nullam.velit@orcitincidunt.org	AFL71EDG0FI	2016-10-05 11:16:03.949166	\N	Nullam vitae diam. Proin dolor. Nulla semper tellus id nunc interdum feugiat. Sed
135	Keely Hurley	orci.luctus@variusorciin.org	ARC18IVW5YG	2016-10-05 11:16:03.949166	\N	aliquet. Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper
136	Steven Burgess	mus.Proin.vel@imperdietullamcorperDuis.org	PTB26IAE0TC	2016-10-05 11:16:03.949166	\N	faucibus lectus, a sollicitudin orci sem eget massa. Suspendisse eleifend. Cras sed leo.
137	Dorothy Torres	vitae.erat.Vivamus@eratvitaerisus.edu	PPZ71WOL6NQ	2016-10-05 11:16:03.949166	\N	auctor vitae, aliquet nec, imperdiet nec, leo. Morbi neque tellus, imperdiet non, vestibulum
138	Murphy Dunlap	conubia.nostra@ami.com	AWZ70GAQ0TG	2016-10-05 11:16:03.949166	\N	ut ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris
139	Ariana Wallace	faucibus.id@eget.net	YIQ17WTE3KF	2016-10-05 11:16:03.949166	\N	volutpat ornare, facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean gravida nunc sed
140	Germane Mckay	tempus@aliquamarcuAliquam.edu	QFC07XVD4LJ	2016-10-05 11:16:03.949166	\N	non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate
141	Rama Allen	cursus@tinciduntneque.org	ZYY57YTK4ZG	2016-10-05 11:16:03.949166	\N	eros. Nam consequat dolor vitae dolor. Donec fringilla. Donec feugiat metus sit amet
142	Ingrid Bates	malesuada@nequenon.com	FND72GJX2BU	2016-10-05 11:16:03.949166	\N	cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim
143	Jayme Jarvis	est.tempor.bibendum@nequesedsem.net	PQH78EVJ5AD	2016-10-05 11:16:03.949166	\N	molestie in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed
144	Jackson Ward	commodo@auctornon.ca	NIH60PWJ0QI	2016-10-05 11:16:03.949166	\N	iaculis aliquet diam. Sed diam lorem, auctor quis, tristique ac, eleifend vitae, erat.
145	Judah Jensen	non@Proin.org	BUT32ZZW7IF	2016-10-05 11:16:03.949166	\N	varius orci, in consequat enim diam vel arcu. Curabitur ut odio vel est
155	ok	ok	ok	2016-10-12 15:35:35.076991	\N	\N
156	horse	horse	horse	2016-10-12 15:36:30.865673	\N	\N
158	mm	mmm	mm	2016-10-12 15:37:31.079558	\N	\N
\.

SELECT pg_catalog.setval('users_id_seq', 158, true);


ALTER TABLE ONLY favorited_twaats
    ADD CONSTRAINT favorited_twaats_pkey PRIMARY KEY (who_id, twaat_id);

ALTER TABLE ONLY follower
    ADD CONSTRAINT follower_pkey PRIMARY KEY (who_id, whom_id);

ALTER TABLE ONLY twaat
    ADD CONSTRAINT twaat_pkey PRIMARY KEY (id);

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);

ALTER TABLE ONLY favorited_twaats
    ADD CONSTRAINT favorited_twaats_twaat_id_fkey FOREIGN KEY (twaat_id) REFERENCES twaat(id);

ALTER TABLE ONLY favorited_twaats
    ADD CONSTRAINT favorited_twaats_who_id_fkey FOREIGN KEY (who_id) REFERENCES users(id);

ALTER TABLE ONLY follower
    ADD CONSTRAINT follower_who_id_fkey FOREIGN KEY (who_id) REFERENCES users(id);

ALTER TABLE ONLY follower
    ADD CONSTRAINT follower_whom_id_fkey FOREIGN KEY (whom_id) REFERENCES users(id);

ALTER TABLE ONLY twaat
    ADD CONSTRAINT twaat_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES twaat(id);


--
-- Name: twaat_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sorja
--

ALTER TABLE ONLY twaat
    ADD CONSTRAINT twaat_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);
