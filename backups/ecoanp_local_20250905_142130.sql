--
-- PostgreSQL database dump
--

\restrict hOUxAX1QJViCalhPQQ7CCfgihwrZw0GmJyp1KdjQghb1qzRdRUz5eRRsQFwfIbX

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

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
-- Name: timescaledb; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS timescaledb WITH SCHEMA public;


--
-- Name: EXTENSION timescaledb; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION timescaledb IS 'Enables scalable inserts and complex queries for time-series data (Community Edition)';


--
-- Name: ai_engine; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA ai_engine;


--
-- Name: analytics; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA analytics;


--
-- Name: plpython3u; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpython3u WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpython3u; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpython3u IS 'PL/Python3U untrusted procedural language';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public;


--
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: influx_hist; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.influx_hist (
    ts timestamp with time zone NOT NULL,
    tag_name text NOT NULL,
    value double precision NOT NULL,
    qc smallint DEFAULT 0,
    meta jsonb DEFAULT '{}'::jsonb
);


--
-- Name: _direct_view_2; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._direct_view_2 AS
 SELECT public.time_bucket('00:01:00'::interval, ts) AS bucket,
    tag_name,
    count(*) AS n,
    avg(value) AS avg,
    sum(value) AS sum,
    min(value) AS min,
    max(value) AS max,
    (array_agg(value ORDER BY ts DESC))[1] AS last,
    (array_agg(value ORDER BY ts))[1] AS first,
    ((array_agg(value ORDER BY ts DESC))[1] - (array_agg(value ORDER BY ts))[1]) AS diff
   FROM public.influx_hist
  GROUP BY (public.time_bucket('00:01:00'::interval, ts)), tag_name;


--
-- Name: _direct_view_3; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._direct_view_3 AS
 SELECT public.time_bucket('00:05:00'::interval, ts) AS bucket,
    tag_name,
    count(*) AS n,
    avg(value) AS avg,
    sum(value) AS sum,
    min(value) AS min,
    max(value) AS max,
    (array_agg(value ORDER BY ts DESC))[1] AS last,
    (array_agg(value ORDER BY ts))[1] AS first,
    ((array_agg(value ORDER BY ts DESC))[1] - (array_agg(value ORDER BY ts))[1]) AS diff
   FROM public.influx_hist
  GROUP BY (public.time_bucket('00:05:00'::interval, ts)), tag_name;


--
-- Name: _direct_view_4; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._direct_view_4 AS
 SELECT public.time_bucket('01:00:00'::interval, ts) AS bucket,
    tag_name,
    count(*) AS n,
    avg(value) AS avg,
    sum(value) AS sum,
    min(value) AS min,
    max(value) AS max,
    (array_agg(value ORDER BY ts DESC))[1] AS last,
    (array_agg(value ORDER BY ts))[1] AS first,
    ((array_agg(value ORDER BY ts DESC))[1] - (array_agg(value ORDER BY ts))[1]) AS diff
   FROM public.influx_hist
  GROUP BY (public.time_bucket('01:00:00'::interval, ts)), tag_name;


--
-- Name: _direct_view_5; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._direct_view_5 AS
 SELECT public.time_bucket('1 day'::interval, ts) AS bucket,
    tag_name,
    count(*) AS n,
    avg(value) AS avg,
    sum(value) AS sum,
    min(value) AS min,
    max(value) AS max,
    (array_agg(value ORDER BY ts DESC))[1] AS last,
    (array_agg(value ORDER BY ts))[1] AS first,
    ((array_agg(value ORDER BY ts DESC))[1] - (array_agg(value ORDER BY ts))[1]) AS diff
   FROM public.influx_hist
  GROUP BY (public.time_bucket('1 day'::interval, ts)), tag_name;


--
-- Name: _direct_view_6; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._direct_view_6 AS
 SELECT public.time_bucket('00:10:00'::interval, ts) AS bucket,
    tag_name,
    count(*) AS n,
    avg(value) AS avg,
    sum(value) AS sum,
    min(value) AS min,
    max(value) AS max,
    (array_agg(value ORDER BY ts DESC))[1] AS last,
    (array_agg(value ORDER BY ts))[1] AS first,
    ((array_agg(value ORDER BY ts DESC))[1] - (array_agg(value ORDER BY ts))[1]) AS diff
   FROM public.influx_hist
  GROUP BY (public.time_bucket('00:10:00'::interval, ts)), tag_name;


--
-- Name: _materialized_hypertable_2; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._materialized_hypertable_2 (
    bucket timestamp with time zone NOT NULL,
    tag_name text,
    n bigint,
    avg double precision,
    sum double precision,
    min double precision,
    max double precision,
    last double precision,
    first double precision,
    diff double precision
);


--
-- Name: _materialized_hypertable_3; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._materialized_hypertable_3 (
    bucket timestamp with time zone NOT NULL,
    tag_name text,
    n bigint,
    avg double precision,
    sum double precision,
    min double precision,
    max double precision,
    last double precision,
    first double precision,
    diff double precision
);


--
-- Name: _materialized_hypertable_4; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._materialized_hypertable_4 (
    bucket timestamp with time zone NOT NULL,
    tag_name text,
    n bigint,
    avg double precision,
    sum double precision,
    min double precision,
    max double precision,
    last double precision,
    first double precision,
    diff double precision
);


--
-- Name: _materialized_hypertable_5; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._materialized_hypertable_5 (
    bucket timestamp with time zone NOT NULL,
    tag_name text,
    n bigint,
    avg double precision,
    sum double precision,
    min double precision,
    max double precision,
    last double precision,
    first double precision,
    diff double precision
);


--
-- Name: _materialized_hypertable_6; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._materialized_hypertable_6 (
    bucket timestamp with time zone NOT NULL,
    tag_name text,
    n bigint,
    avg double precision,
    sum double precision,
    min double precision,
    max double precision,
    last double precision,
    first double precision,
    diff double precision
);


--
-- Name: _partial_view_2; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._partial_view_2 AS
 SELECT public.time_bucket('00:01:00'::interval, ts) AS bucket,
    tag_name,
    count(*) AS n,
    avg(value) AS avg,
    sum(value) AS sum,
    min(value) AS min,
    max(value) AS max,
    (array_agg(value ORDER BY ts DESC))[1] AS last,
    (array_agg(value ORDER BY ts))[1] AS first,
    ((array_agg(value ORDER BY ts DESC))[1] - (array_agg(value ORDER BY ts))[1]) AS diff
   FROM public.influx_hist
  GROUP BY (public.time_bucket('00:01:00'::interval, ts)), tag_name;


--
-- Name: _partial_view_3; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._partial_view_3 AS
 SELECT public.time_bucket('00:05:00'::interval, ts) AS bucket,
    tag_name,
    count(*) AS n,
    avg(value) AS avg,
    sum(value) AS sum,
    min(value) AS min,
    max(value) AS max,
    (array_agg(value ORDER BY ts DESC))[1] AS last,
    (array_agg(value ORDER BY ts))[1] AS first,
    ((array_agg(value ORDER BY ts DESC))[1] - (array_agg(value ORDER BY ts))[1]) AS diff
   FROM public.influx_hist
  GROUP BY (public.time_bucket('00:05:00'::interval, ts)), tag_name;


--
-- Name: _partial_view_4; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._partial_view_4 AS
 SELECT public.time_bucket('01:00:00'::interval, ts) AS bucket,
    tag_name,
    count(*) AS n,
    avg(value) AS avg,
    sum(value) AS sum,
    min(value) AS min,
    max(value) AS max,
    (array_agg(value ORDER BY ts DESC))[1] AS last,
    (array_agg(value ORDER BY ts))[1] AS first,
    ((array_agg(value ORDER BY ts DESC))[1] - (array_agg(value ORDER BY ts))[1]) AS diff
   FROM public.influx_hist
  GROUP BY (public.time_bucket('01:00:00'::interval, ts)), tag_name;


--
-- Name: _partial_view_5; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._partial_view_5 AS
 SELECT public.time_bucket('1 day'::interval, ts) AS bucket,
    tag_name,
    count(*) AS n,
    avg(value) AS avg,
    sum(value) AS sum,
    min(value) AS min,
    max(value) AS max,
    (array_agg(value ORDER BY ts DESC))[1] AS last,
    (array_agg(value ORDER BY ts))[1] AS first,
    ((array_agg(value ORDER BY ts DESC))[1] - (array_agg(value ORDER BY ts))[1]) AS diff
   FROM public.influx_hist
  GROUP BY (public.time_bucket('1 day'::interval, ts)), tag_name;


--
-- Name: _partial_view_6; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._partial_view_6 AS
 SELECT public.time_bucket('00:10:00'::interval, ts) AS bucket,
    tag_name,
    count(*) AS n,
    avg(value) AS avg,
    sum(value) AS sum,
    min(value) AS min,
    max(value) AS max,
    (array_agg(value ORDER BY ts DESC))[1] AS last,
    (array_agg(value ORDER BY ts))[1] AS first,
    ((array_agg(value ORDER BY ts DESC))[1] - (array_agg(value ORDER BY ts))[1]) AS diff
   FROM public.influx_hist
  GROUP BY (public.time_bucket('00:10:00'::interval, ts)), tag_name;


--
-- Name: dagster_vec; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dagster_vec (
    id bigint NOT NULL,
    embedding public.vector(3)
);


--
-- Name: dagster_vec_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dagster_vec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dagster_vec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dagster_vec_id_seq OWNED BY public.dagster_vec.id;


--
-- Name: influx_agg_10m; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.influx_agg_10m AS
 SELECT bucket,
    tag_name,
    n,
    avg,
    sum,
    min,
    max,
    last,
    first,
    diff
   FROM _timescaledb_internal._materialized_hypertable_6;


--
-- Name: influx_agg_1d; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.influx_agg_1d AS
 SELECT bucket,
    tag_name,
    n,
    avg,
    sum,
    min,
    max,
    last,
    first,
    diff
   FROM _timescaledb_internal._materialized_hypertable_5;


--
-- Name: influx_agg_1h; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.influx_agg_1h AS
 SELECT bucket,
    tag_name,
    n,
    avg,
    sum,
    min,
    max,
    last,
    first,
    diff
   FROM _timescaledb_internal._materialized_hypertable_4;


--
-- Name: influx_agg_1m; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.influx_agg_1m AS
 SELECT bucket,
    tag_name,
    n,
    avg,
    sum,
    min,
    max,
    last,
    first,
    diff
   FROM _timescaledb_internal._materialized_hypertable_2;


--
-- Name: influx_agg_5m; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.influx_agg_5m AS
 SELECT bucket,
    tag_name,
    n,
    avg,
    sum,
    min,
    max,
    last,
    first,
    diff
   FROM _timescaledb_internal._materialized_hypertable_3;


--
-- Name: influx_daily_stats; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.influx_daily_stats AS
 SELECT public.time_bucket('1 day'::interval, ts) AS bucket,
    tag_name,
    count(*) AS readings_count,
    avg(value) AS avg_value,
    min(value) AS min_value,
    max(value) AS max_value,
    stddev(value) AS stddev_value,
    avg(qc) AS avg_qc
   FROM public.influx_hist
  GROUP BY (public.time_bucket('1 day'::interval, ts)), tag_name
  ORDER BY (public.time_bucket('1 day'::interval, ts)) DESC, tag_name;


--
-- Name: influx_hourly_stats; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.influx_hourly_stats AS
 SELECT public.time_bucket('01:00:00'::interval, ts) AS bucket,
    tag_name,
    count(*) AS readings_count,
    avg(value) AS avg_value,
    min(value) AS min_value,
    max(value) AS max_value,
    stddev(value) AS stddev_value,
    avg(qc) AS avg_qc
   FROM public.influx_hist
  GROUP BY (public.time_bucket('01:00:00'::interval, ts)), tag_name
  ORDER BY (public.time_bucket('01:00:00'::interval, ts)) DESC, tag_name;


--
-- Name: influx_latest; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.influx_latest AS
 SELECT DISTINCT ON (tag_name) tag_name,
    value,
    ts,
    qc,
    meta
   FROM public.influx_hist
  ORDER BY tag_name, ts DESC;


--
-- Name: influx_latest_status; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.influx_latest_status AS
 SELECT DISTINCT ON (tag_name) tag_name,
    value AS latest_value,
    ts AS latest_reading,
    qc AS latest_qc,
    meta
   FROM public.influx_hist
  ORDER BY tag_name, ts DESC;


--
-- Name: influx_qc_rule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.influx_qc_rule (
    tag_name text NOT NULL,
    min_val double precision,
    max_val double precision,
    max_step double precision,
    max_gap_seconds integer DEFAULT 120,
    allow_negative boolean DEFAULT true,
    enabled boolean DEFAULT true,
    meta jsonb DEFAULT '{}'::jsonb,
    warn_min double precision,
    warn_max double precision,
    crit_min double precision,
    crit_max double precision,
    roc_max_per_min double precision,
    spike_zscore double precision,
    deadband_pct double precision
);


--
-- Name: influx_tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.influx_tag (
    key text NOT NULL,
    tag_id text,
    tag_name text NOT NULL,
    tag_type text NOT NULL,
    unit text,
    meta jsonb DEFAULT '{}'::jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: system_stats; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.system_stats AS
 SELECT 'Database Size'::text AS metric,
    pg_size_pretty(pg_database_size(current_database())) AS value
UNION ALL
 SELECT 'Active Connections'::text AS metric,
    (count(*))::text AS value
   FROM pg_stat_activity
  WHERE (pg_stat_activity.state = 'active'::text)
UNION ALL
 SELECT 'TimescaleDB Chunks'::text AS metric,
    (count(*))::text AS value
   FROM timescaledb_information.chunks
UNION ALL
 SELECT 'TimescaleDB Hypertables'::text AS metric,
    (count(*))::text AS value
   FROM timescaledb_information.hypertables;


--
-- Name: vec_smoke; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vec_smoke (
    id bigint NOT NULL,
    embedding public.vector(3)
);


--
-- Name: vec_smoke_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vec_smoke_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vec_smoke_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vec_smoke_id_seq OWNED BY public.vec_smoke.id;


--
-- Name: dagster_vec id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dagster_vec ALTER COLUMN id SET DEFAULT nextval('public.dagster_vec_id_seq'::regclass);


--
-- Name: vec_smoke id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vec_smoke ALTER COLUMN id SET DEFAULT nextval('public.vec_smoke_id_seq'::regclass);


--
-- Data for Name: hypertable; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.hypertable (id, schema_name, table_name, associated_schema_name, associated_table_prefix, num_dimensions, chunk_sizing_func_schema, chunk_sizing_func_name, chunk_target_size, compression_state, compressed_hypertable_id, status) FROM stdin;
1	public	influx_hist	_timescaledb_internal	_hyper_1	1	_timescaledb_functions	calculate_chunk_interval	0	0	\N	0
2	_timescaledb_internal	_materialized_hypertable_2	_timescaledb_internal	_hyper_2	1	_timescaledb_functions	calculate_chunk_interval	0	0	\N	0
3	_timescaledb_internal	_materialized_hypertable_3	_timescaledb_internal	_hyper_3	1	_timescaledb_functions	calculate_chunk_interval	0	0	\N	0
4	_timescaledb_internal	_materialized_hypertable_4	_timescaledb_internal	_hyper_4	1	_timescaledb_functions	calculate_chunk_interval	0	0	\N	0
5	_timescaledb_internal	_materialized_hypertable_5	_timescaledb_internal	_hyper_5	1	_timescaledb_functions	calculate_chunk_interval	0	0	\N	0
6	_timescaledb_internal	_materialized_hypertable_6	_timescaledb_internal	_hyper_6	1	_timescaledb_functions	calculate_chunk_interval	0	0	\N	0
\.


--
-- Data for Name: chunk; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.chunk (id, hypertable_id, schema_name, table_name, compressed_chunk_id, dropped, status, osm_chunk, creation_time) FROM stdin;
\.


--
-- Data for Name: chunk_column_stats; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.chunk_column_stats (id, hypertable_id, chunk_id, column_name, range_start, range_end, valid) FROM stdin;
\.


--
-- Data for Name: dimension; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.dimension (id, hypertable_id, column_name, column_type, aligned, num_slices, partitioning_func_schema, partitioning_func, interval_length, compress_interval_length, integer_now_func_schema, integer_now_func) FROM stdin;
1	1	ts	timestamp with time zone	t	\N	\N	\N	604800000000	\N	\N	\N
2	2	bucket	timestamp with time zone	t	\N	\N	\N	6048000000000	\N	\N	\N
3	3	bucket	timestamp with time zone	t	\N	\N	\N	6048000000000	\N	\N	\N
4	4	bucket	timestamp with time zone	t	\N	\N	\N	6048000000000	\N	\N	\N
5	5	bucket	timestamp with time zone	t	\N	\N	\N	6048000000000	\N	\N	\N
6	6	bucket	timestamp with time zone	t	\N	\N	\N	6048000000000	\N	\N	\N
\.


--
-- Data for Name: dimension_slice; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.dimension_slice (id, dimension_id, range_start, range_end) FROM stdin;
\.


--
-- Data for Name: chunk_constraint; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.chunk_constraint (chunk_id, dimension_slice_id, constraint_name, hypertable_constraint_name) FROM stdin;
\.


--
-- Data for Name: compression_chunk_size; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.compression_chunk_size (chunk_id, compressed_chunk_id, uncompressed_heap_size, uncompressed_toast_size, uncompressed_index_size, compressed_heap_size, compressed_toast_size, compressed_index_size, numrows_pre_compression, numrows_post_compression, numrows_frozen_immediately) FROM stdin;
\.


--
-- Data for Name: compression_settings; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.compression_settings (relid, compress_relid, segmentby, orderby, orderby_desc, orderby_nullsfirst, index) FROM stdin;
\.


--
-- Data for Name: continuous_agg; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.continuous_agg (mat_hypertable_id, raw_hypertable_id, parent_mat_hypertable_id, user_view_schema, user_view_name, partial_view_schema, partial_view_name, direct_view_schema, direct_view_name, materialized_only, finalized) FROM stdin;
2	1	\N	public	influx_agg_1m	_timescaledb_internal	_partial_view_2	_timescaledb_internal	_direct_view_2	t	t
3	1	\N	public	influx_agg_5m	_timescaledb_internal	_partial_view_3	_timescaledb_internal	_direct_view_3	t	t
4	1	\N	public	influx_agg_1h	_timescaledb_internal	_partial_view_4	_timescaledb_internal	_direct_view_4	t	t
5	1	\N	public	influx_agg_1d	_timescaledb_internal	_partial_view_5	_timescaledb_internal	_direct_view_5	t	t
6	1	\N	public	influx_agg_10m	_timescaledb_internal	_partial_view_6	_timescaledb_internal	_direct_view_6	t	t
\.


--
-- Data for Name: continuous_agg_migrate_plan; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.continuous_agg_migrate_plan (mat_hypertable_id, start_ts, end_ts, user_view_definition) FROM stdin;
\.


--
-- Data for Name: continuous_agg_migrate_plan_step; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.continuous_agg_migrate_plan_step (mat_hypertable_id, step_id, status, start_ts, end_ts, type, config) FROM stdin;
\.


--
-- Data for Name: continuous_aggs_bucket_function; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.continuous_aggs_bucket_function (mat_hypertable_id, bucket_func, bucket_width, bucket_origin, bucket_offset, bucket_timezone, bucket_fixed_width) FROM stdin;
2	public.time_bucket(interval,timestamp with time zone)	00:01:00	\N	\N	\N	t
3	public.time_bucket(interval,timestamp with time zone)	00:05:00	\N	\N	\N	t
4	public.time_bucket(interval,timestamp with time zone)	01:00:00	\N	\N	\N	t
5	public.time_bucket(interval,timestamp with time zone)	1 day	\N	\N	\N	t
6	public.time_bucket(interval,timestamp with time zone)	00:10:00	\N	\N	\N	t
\.


--
-- Data for Name: continuous_aggs_hypertable_invalidation_log; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.continuous_aggs_hypertable_invalidation_log (hypertable_id, lowest_modified_value, greatest_modified_value) FROM stdin;
1	-9223372036854775808	9223372036854775807
\.


--
-- Data for Name: continuous_aggs_invalidation_threshold; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.continuous_aggs_invalidation_threshold (hypertable_id, watermark) FROM stdin;
1	-210866803200000000
\.


--
-- Data for Name: continuous_aggs_materialization_invalidation_log; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.continuous_aggs_materialization_invalidation_log (materialization_id, lowest_modified_value, greatest_modified_value) FROM stdin;
2	-9223372036854775808	9223372036854775807
3	-9223372036854775808	9223372036854775807
4	-9223372036854775808	9223372036854775807
5	-9223372036854775808	9223372036854775807
6	-9223372036854775808	9223372036854775807
\.


--
-- Data for Name: continuous_aggs_materialization_ranges; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.continuous_aggs_materialization_ranges (materialization_id, lowest_modified_value, greatest_modified_value) FROM stdin;
\.


--
-- Data for Name: continuous_aggs_watermark; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.continuous_aggs_watermark (mat_hypertable_id, watermark) FROM stdin;
2	-210866803200000000
3	-210866803200000000
4	-210866803200000000
5	-210866803200000000
6	-210866803200000000
\.


--
-- Data for Name: metadata; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.metadata (key, value, include_in_telemetry) FROM stdin;
install_timestamp	2025-09-05 03:25:38.429266+00	t
timescaledb_version	2.22.0	f
\.


--
-- Data for Name: tablespace; Type: TABLE DATA; Schema: _timescaledb_catalog; Owner: -
--

COPY _timescaledb_catalog.tablespace (id, hypertable_id, tablespace_name) FROM stdin;
\.


--
-- Data for Name: bgw_job; Type: TABLE DATA; Schema: _timescaledb_config; Owner: -
--

COPY _timescaledb_config.bgw_job (id, application_name, schedule_interval, max_runtime, max_retries, retry_period, proc_schema, proc_name, owner, scheduled, fixed_schedule, initial_start, hypertable_id, config, check_schema, check_name, timezone) FROM stdin;
1000	Retention Policy [1000]	1 day	00:05:00	-1	00:05:00	_timescaledb_functions	policy_retention	ecoanp_user	t	f	\N	1	{"drop_after": "365 days", "hypertable_id": 1}	_timescaledb_functions	policy_retention_check	\N
1005	Refresh Continuous Aggregate Policy [1005]	00:01:00	00:00:00	-1	00:01:00	_timescaledb_functions	policy_refresh_continuous_aggregate	ecoanp_user	t	f	\N	2	{"end_offset": "00:01:00", "start_offset": "02:00:00", "mat_hypertable_id": 2}	_timescaledb_functions	policy_refresh_continuous_aggregate_check	\N
1006	Refresh Continuous Aggregate Policy [1006]	00:05:00	00:00:00	-1	00:05:00	_timescaledb_functions	policy_refresh_continuous_aggregate	ecoanp_user	t	f	\N	3	{"end_offset": "00:05:00", "start_offset": "1 day", "mat_hypertable_id": 3}	_timescaledb_functions	policy_refresh_continuous_aggregate_check	\N
1007	Refresh Continuous Aggregate Policy [1007]	00:10:00	00:00:00	-1	00:10:00	_timescaledb_functions	policy_refresh_continuous_aggregate	ecoanp_user	t	f	\N	6	{"end_offset": "00:10:00", "start_offset": "1 day", "mat_hypertable_id": 6}	_timescaledb_functions	policy_refresh_continuous_aggregate_check	\N
1008	Refresh Continuous Aggregate Policy [1008]	01:00:00	00:00:00	-1	01:00:00	_timescaledb_functions	policy_refresh_continuous_aggregate	ecoanp_user	t	f	\N	4	{"end_offset": "01:00:00", "start_offset": "7 days", "mat_hypertable_id": 4}	_timescaledb_functions	policy_refresh_continuous_aggregate_check	\N
1009	Refresh Continuous Aggregate Policy [1009]	1 day	00:00:00	-1	1 day	_timescaledb_functions	policy_refresh_continuous_aggregate	ecoanp_user	t	f	\N	5	{"end_offset": "1 day", "start_offset": "30 days", "mat_hypertable_id": 5}	_timescaledb_functions	policy_refresh_continuous_aggregate_check	\N
\.


--
-- Data for Name: _materialized_hypertable_2; Type: TABLE DATA; Schema: _timescaledb_internal; Owner: -
--

COPY _timescaledb_internal._materialized_hypertable_2 (bucket, tag_name, n, avg, sum, min, max, last, first, diff) FROM stdin;
\.


--
-- Data for Name: _materialized_hypertable_3; Type: TABLE DATA; Schema: _timescaledb_internal; Owner: -
--

COPY _timescaledb_internal._materialized_hypertable_3 (bucket, tag_name, n, avg, sum, min, max, last, first, diff) FROM stdin;
\.


--
-- Data for Name: _materialized_hypertable_4; Type: TABLE DATA; Schema: _timescaledb_internal; Owner: -
--

COPY _timescaledb_internal._materialized_hypertable_4 (bucket, tag_name, n, avg, sum, min, max, last, first, diff) FROM stdin;
\.


--
-- Data for Name: _materialized_hypertable_5; Type: TABLE DATA; Schema: _timescaledb_internal; Owner: -
--

COPY _timescaledb_internal._materialized_hypertable_5 (bucket, tag_name, n, avg, sum, min, max, last, first, diff) FROM stdin;
\.


--
-- Data for Name: _materialized_hypertable_6; Type: TABLE DATA; Schema: _timescaledb_internal; Owner: -
--

COPY _timescaledb_internal._materialized_hypertable_6 (bucket, tag_name, n, avg, sum, min, max, last, first, diff) FROM stdin;
\.


--
-- Data for Name: dagster_vec; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dagster_vec (id, embedding) FROM stdin;
3	[1,2,3]
4	[0,0,0]
\.


--
-- Data for Name: influx_hist; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.influx_hist (ts, tag_name, value, qc, meta) FROM stdin;
\.


--
-- Data for Name: influx_qc_rule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.influx_qc_rule (tag_name, min_val, max_val, max_step, max_gap_seconds, allow_negative, enabled, meta, warn_min, warn_max, crit_min, crit_max, roc_max_per_min, spike_zscore, deadband_pct) FROM stdin;
\.


--
-- Data for Name: influx_tag; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.influx_tag (key, tag_id, tag_name, tag_type, unit, meta, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: vec_smoke; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vec_smoke (id, embedding) FROM stdin;
5	[1,2,3]
6	[2,2,2]
\.


--
-- Name: chunk_column_stats_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: -
--

SELECT pg_catalog.setval('_timescaledb_catalog.chunk_column_stats_id_seq', 1, false);


--
-- Name: chunk_constraint_name; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: -
--

SELECT pg_catalog.setval('_timescaledb_catalog.chunk_constraint_name', 2, true);


--
-- Name: chunk_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: -
--

SELECT pg_catalog.setval('_timescaledb_catalog.chunk_id_seq', 2, true);


--
-- Name: continuous_agg_migrate_plan_step_step_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: -
--

SELECT pg_catalog.setval('_timescaledb_catalog.continuous_agg_migrate_plan_step_step_id_seq', 1, false);


--
-- Name: dimension_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: -
--

SELECT pg_catalog.setval('_timescaledb_catalog.dimension_id_seq', 6, true);


--
-- Name: dimension_slice_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: -
--

SELECT pg_catalog.setval('_timescaledb_catalog.dimension_slice_id_seq', 2, true);


--
-- Name: hypertable_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_catalog; Owner: -
--

SELECT pg_catalog.setval('_timescaledb_catalog.hypertable_id_seq', 6, true);


--
-- Name: bgw_job_id_seq; Type: SEQUENCE SET; Schema: _timescaledb_config; Owner: -
--

SELECT pg_catalog.setval('_timescaledb_config.bgw_job_id_seq', 1009, true);


--
-- Name: dagster_vec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.dagster_vec_id_seq', 4, true);


--
-- Name: vec_smoke_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vec_smoke_id_seq', 6, true);


--
-- Name: dagster_vec dagster_vec_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dagster_vec
    ADD CONSTRAINT dagster_vec_pkey PRIMARY KEY (id);


--
-- Name: influx_hist influx_hist_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.influx_hist
    ADD CONSTRAINT influx_hist_pkey PRIMARY KEY (ts, tag_name);


--
-- Name: influx_qc_rule influx_qc_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.influx_qc_rule
    ADD CONSTRAINT influx_qc_rule_pkey PRIMARY KEY (tag_name);


--
-- Name: influx_tag influx_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.influx_tag
    ADD CONSTRAINT influx_tag_pkey PRIMARY KEY (key);


--
-- Name: influx_tag influx_tag_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.influx_tag
    ADD CONSTRAINT influx_tag_tag_name_key UNIQUE (tag_name);


--
-- Name: vec_smoke vec_smoke_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vec_smoke
    ADD CONSTRAINT vec_smoke_pkey PRIMARY KEY (id);


--
-- Name: _materialized_hypertable_2_bucket_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_2_bucket_idx ON _timescaledb_internal._materialized_hypertable_2 USING btree (bucket DESC);


--
-- Name: _materialized_hypertable_2_tag_name_bucket_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_2_tag_name_bucket_idx ON _timescaledb_internal._materialized_hypertable_2 USING btree (tag_name, bucket DESC);


--
-- Name: _materialized_hypertable_3_bucket_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_3_bucket_idx ON _timescaledb_internal._materialized_hypertable_3 USING btree (bucket DESC);


--
-- Name: _materialized_hypertable_3_tag_name_bucket_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_3_tag_name_bucket_idx ON _timescaledb_internal._materialized_hypertable_3 USING btree (tag_name, bucket DESC);


--
-- Name: _materialized_hypertable_4_bucket_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_4_bucket_idx ON _timescaledb_internal._materialized_hypertable_4 USING btree (bucket DESC);


--
-- Name: _materialized_hypertable_4_tag_name_bucket_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_4_tag_name_bucket_idx ON _timescaledb_internal._materialized_hypertable_4 USING btree (tag_name, bucket DESC);


--
-- Name: _materialized_hypertable_5_bucket_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_5_bucket_idx ON _timescaledb_internal._materialized_hypertable_5 USING btree (bucket DESC);


--
-- Name: _materialized_hypertable_5_tag_name_bucket_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_5_tag_name_bucket_idx ON _timescaledb_internal._materialized_hypertable_5 USING btree (tag_name, bucket DESC);


--
-- Name: _materialized_hypertable_6_bucket_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_6_bucket_idx ON _timescaledb_internal._materialized_hypertable_6 USING btree (bucket DESC);


--
-- Name: _materialized_hypertable_6_tag_name_bucket_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_6_tag_name_bucket_idx ON _timescaledb_internal._materialized_hypertable_6 USING btree (tag_name, bucket DESC);


--
-- Name: idx_influx_hist_tag_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_influx_hist_tag_time ON public.influx_hist USING btree (tag_name, ts DESC);


--
-- Name: idx_influx_hist_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_influx_hist_time ON public.influx_hist USING btree (ts DESC);


--
-- Name: influx_hist_ts_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX influx_hist_ts_idx ON public.influx_hist USING btree (ts DESC);


--
-- Name: _materialized_hypertable_2 ts_insert_blocker; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON _timescaledb_internal._materialized_hypertable_2 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- Name: _materialized_hypertable_3 ts_insert_blocker; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON _timescaledb_internal._materialized_hypertable_3 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- Name: _materialized_hypertable_4 ts_insert_blocker; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON _timescaledb_internal._materialized_hypertable_4 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- Name: _materialized_hypertable_5 ts_insert_blocker; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON _timescaledb_internal._materialized_hypertable_5 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- Name: _materialized_hypertable_6 ts_insert_blocker; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON _timescaledb_internal._materialized_hypertable_6 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- Name: influx_hist ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON public.influx_hist FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: influx_hist ts_insert_blocker; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON public.influx_hist FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- PostgreSQL database dump complete
--

\unrestrict hOUxAX1QJViCalhPQQ7CCfgihwrZw0GmJyp1KdjQghb1qzRdRUz5eRRsQFwfIbX

