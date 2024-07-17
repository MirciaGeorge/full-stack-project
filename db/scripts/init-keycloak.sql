--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Debian 14.9-1.pgdg120+1)
-- Dumped by pg_dump version 14.9 (Debian 14.9-1.pgdg120+1)

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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO "user";

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO "user";

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO "user";

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO "user";

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO "user";

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO "user";

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO "user";

--
-- Name: client; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO "user";

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO "user";

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO "user";

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO "user";

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO "user";

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO "user";

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO "user";

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO "user";

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO "user";

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO "user";

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO "user";

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO "user";

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO "user";

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO "user";

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO "user";

--
-- Name: component; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO "user";

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO "user";

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO "user";

--
-- Name: credential; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO "user";

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO "user";

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO "user";

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO "user";

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO "user";

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO "user";

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO "user";

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO "user";

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO "user";

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO "user";

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO "user";

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO "user";

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO "user";

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO "user";

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO "user";

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO "user";

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO "user";

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO "user";

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO "user";

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO "user";

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO "user";

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO "user";

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO "user";

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO "user";

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO "user";

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO "user";

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO "user";

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO "user";

--
-- Name: realm; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO "user";

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO "user";

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO "user";

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO "user";

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO "user";

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO "user";

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO "user";

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO "user";

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO "user";

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO "user";

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO "user";

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO "user";

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO "user";

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO "user";

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO "user";

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO "user";

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO "user";

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO "user";

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO "user";

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO "user";

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO "user";

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO "user";

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO "user";

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO "user";

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO "user";

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO "user";

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO "user";

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO "user";

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO "user";

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO "user";

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO "user";

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO "user";

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO "user";

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO "user";

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO "user";

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO "user";

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO "user";

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO "user";

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO "user";

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('fdbab3d9-5a0e-41aa-99ac-a6997e414573', NULL, 'auth-cookie', '5ebb9076-4db1-482d-9e07-c56acd16b969', '3652e908-ea1e-42cf-b479-b4865418d51b', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('86a15348-da7f-4a01-80e3-918deff1f5d0', NULL, 'auth-spnego', '5ebb9076-4db1-482d-9e07-c56acd16b969', '3652e908-ea1e-42cf-b479-b4865418d51b', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('19044472-a0f4-4e99-a3b3-e1704d6b038e', NULL, 'identity-provider-redirector', '5ebb9076-4db1-482d-9e07-c56acd16b969', '3652e908-ea1e-42cf-b479-b4865418d51b', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e994a2a8-7a28-4145-9c3d-a16e673ba94f', NULL, NULL, '5ebb9076-4db1-482d-9e07-c56acd16b969', '3652e908-ea1e-42cf-b479-b4865418d51b', 2, 30, true, 'd93f2530-ec05-429d-992d-7f5eba4f27ee', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('fcf4bf08-cfd8-406a-b118-4d8edde25fb8', NULL, 'auth-username-password-form', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'd93f2530-ec05-429d-992d-7f5eba4f27ee', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('04ae40ee-4218-425b-a8a1-539c5db6195d', NULL, NULL, '5ebb9076-4db1-482d-9e07-c56acd16b969', 'd93f2530-ec05-429d-992d-7f5eba4f27ee', 1, 20, true, '86202770-48a9-47c0-9f40-17279f8bd94f', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('8691197e-d8a2-4640-b09d-72f72fbbc495', NULL, 'conditional-user-configured', '5ebb9076-4db1-482d-9e07-c56acd16b969', '86202770-48a9-47c0-9f40-17279f8bd94f', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('1c05cb03-843c-49c5-a299-7ce21ba8f9dc', NULL, 'auth-otp-form', '5ebb9076-4db1-482d-9e07-c56acd16b969', '86202770-48a9-47c0-9f40-17279f8bd94f', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2083db8f-6413-4f01-afb9-81cbbe27aa5c', NULL, 'direct-grant-validate-username', '5ebb9076-4db1-482d-9e07-c56acd16b969', '58143a22-fcaf-4443-83e4-f5a9e6eb5e57', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0017f4f4-fb1d-4bb7-8b6d-afc008ad65c9', NULL, 'direct-grant-validate-password', '5ebb9076-4db1-482d-9e07-c56acd16b969', '58143a22-fcaf-4443-83e4-f5a9e6eb5e57', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('a6a85166-2341-46c9-8143-d32388791ffd', NULL, NULL, '5ebb9076-4db1-482d-9e07-c56acd16b969', '58143a22-fcaf-4443-83e4-f5a9e6eb5e57', 1, 30, true, '3de222d6-2d29-4ec9-a682-1facfd80ee8b', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('cf3b7b34-d90f-4318-8e5c-36db7eaa1224', NULL, 'conditional-user-configured', '5ebb9076-4db1-482d-9e07-c56acd16b969', '3de222d6-2d29-4ec9-a682-1facfd80ee8b', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('02230524-ebea-45e2-a9f0-8f2821c837bb', NULL, 'direct-grant-validate-otp', '5ebb9076-4db1-482d-9e07-c56acd16b969', '3de222d6-2d29-4ec9-a682-1facfd80ee8b', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('793c1e04-08e6-4be9-91c6-7cbc93ed7432', NULL, 'registration-page-form', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'c8416e49-d2c0-4fe9-8a33-d90489d296b6', 0, 10, true, '56a81fea-ba2b-4ec3-80eb-b69d376399d1', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('cddaa777-db98-4aa1-8056-8d3dddb708fd', NULL, 'registration-user-creation', '5ebb9076-4db1-482d-9e07-c56acd16b969', '56a81fea-ba2b-4ec3-80eb-b69d376399d1', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e65374f6-a7ca-475a-a0ba-19eafb01da82', NULL, 'registration-password-action', '5ebb9076-4db1-482d-9e07-c56acd16b969', '56a81fea-ba2b-4ec3-80eb-b69d376399d1', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('55d876b6-4cc5-44ad-9b26-2b792610b0dc', NULL, 'registration-recaptcha-action', '5ebb9076-4db1-482d-9e07-c56acd16b969', '56a81fea-ba2b-4ec3-80eb-b69d376399d1', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('ec02250c-0957-444a-9b9a-9658b96ede74', NULL, 'registration-terms-and-conditions', '5ebb9076-4db1-482d-9e07-c56acd16b969', '56a81fea-ba2b-4ec3-80eb-b69d376399d1', 3, 70, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('8473a5d1-d982-4d45-bb83-dca7015511a7', NULL, 'reset-credentials-choose-user', '5ebb9076-4db1-482d-9e07-c56acd16b969', '76f8f2be-cfb6-4867-ae24-6a840c9a7de0', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('3c9a67b5-a80a-49ca-9202-4b5060412144', NULL, 'reset-credential-email', '5ebb9076-4db1-482d-9e07-c56acd16b969', '76f8f2be-cfb6-4867-ae24-6a840c9a7de0', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('3821de94-6dd9-4a89-b4a8-709e43b996a4', NULL, 'reset-password', '5ebb9076-4db1-482d-9e07-c56acd16b969', '76f8f2be-cfb6-4867-ae24-6a840c9a7de0', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9624d931-dceb-486e-bc8d-90c83ab81179', NULL, NULL, '5ebb9076-4db1-482d-9e07-c56acd16b969', '76f8f2be-cfb6-4867-ae24-6a840c9a7de0', 1, 40, true, '11ff989c-9828-4fe3-b521-4a0ad7c5aee1', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('3cb53edc-b872-4d7d-b391-a1647b615a63', NULL, 'conditional-user-configured', '5ebb9076-4db1-482d-9e07-c56acd16b969', '11ff989c-9828-4fe3-b521-4a0ad7c5aee1', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('8a789d19-4515-486b-9617-3f50e697a001', NULL, 'reset-otp', '5ebb9076-4db1-482d-9e07-c56acd16b969', '11ff989c-9828-4fe3-b521-4a0ad7c5aee1', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2559aa3c-7cd0-406c-830b-96001f87ef0c', NULL, 'client-secret', '5ebb9076-4db1-482d-9e07-c56acd16b969', '320d1295-2201-405e-b579-282c9873cdec', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f967407a-56c1-47df-bdfd-c89b8b4c9958', NULL, 'client-jwt', '5ebb9076-4db1-482d-9e07-c56acd16b969', '320d1295-2201-405e-b579-282c9873cdec', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9c3962c0-fa4f-492e-ba32-5ebfd6a10032', NULL, 'client-secret-jwt', '5ebb9076-4db1-482d-9e07-c56acd16b969', '320d1295-2201-405e-b579-282c9873cdec', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('fb823b27-6ec4-4c73-a229-fa9b52415d0c', NULL, 'client-x509', '5ebb9076-4db1-482d-9e07-c56acd16b969', '320d1295-2201-405e-b579-282c9873cdec', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('228def5e-e32b-4366-b9e7-b3ff8b873764', NULL, 'idp-review-profile', '5ebb9076-4db1-482d-9e07-c56acd16b969', '4723fabb-87c7-4ce0-93ab-f36dbf7744be', 0, 10, false, NULL, '947b4405-4e71-4f66-8bfb-3a202f4d67ee');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2eec01d0-5dad-49ed-83c1-8d636223bafc', NULL, NULL, '5ebb9076-4db1-482d-9e07-c56acd16b969', '4723fabb-87c7-4ce0-93ab-f36dbf7744be', 0, 20, true, '723b6a28-d9e4-44d0-8765-1ff73998649b', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('6c28f32a-e029-47d3-b05d-3c7e6dbef44a', NULL, 'idp-create-user-if-unique', '5ebb9076-4db1-482d-9e07-c56acd16b969', '723b6a28-d9e4-44d0-8765-1ff73998649b', 2, 10, false, NULL, '5fcd5939-9243-4c9b-b499-9b6cdce1097b');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('827bddee-7271-4883-9b92-791bb7770358', NULL, NULL, '5ebb9076-4db1-482d-9e07-c56acd16b969', '723b6a28-d9e4-44d0-8765-1ff73998649b', 2, 20, true, 'f0a0a847-b595-4cf6-8287-607e4cb5a8cb', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e7e635ef-2dd1-4168-80c4-e4640c2737ee', NULL, 'idp-confirm-link', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'f0a0a847-b595-4cf6-8287-607e4cb5a8cb', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('73c8d3c2-31a4-4452-a7cc-3d6db5bcdbdf', NULL, NULL, '5ebb9076-4db1-482d-9e07-c56acd16b969', 'f0a0a847-b595-4cf6-8287-607e4cb5a8cb', 0, 20, true, '737bf08c-cdc3-4cb4-8725-f620cfe0b3b4', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('a2d0506c-b897-45eb-bc78-0057de07e106', NULL, 'idp-email-verification', '5ebb9076-4db1-482d-9e07-c56acd16b969', '737bf08c-cdc3-4cb4-8725-f620cfe0b3b4', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f77c5fae-1c72-4c94-a9ec-8822b35e0800', NULL, NULL, '5ebb9076-4db1-482d-9e07-c56acd16b969', '737bf08c-cdc3-4cb4-8725-f620cfe0b3b4', 2, 20, true, '046f89a9-dd71-49dc-b2ae-79343f828783', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e8343c70-dabe-4217-94b5-c8f1f4f5c8c2', NULL, 'idp-username-password-form', '5ebb9076-4db1-482d-9e07-c56acd16b969', '046f89a9-dd71-49dc-b2ae-79343f828783', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c43821db-3394-4ac3-8de4-a1ed7b79eb74', NULL, NULL, '5ebb9076-4db1-482d-9e07-c56acd16b969', '046f89a9-dd71-49dc-b2ae-79343f828783', 1, 20, true, '9b1bc705-a152-4d32-be07-9d7563a8abae', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('af509821-f671-4eb4-94c2-761a183ceef5', NULL, 'conditional-user-configured', '5ebb9076-4db1-482d-9e07-c56acd16b969', '9b1bc705-a152-4d32-be07-9d7563a8abae', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2eb76402-f8d1-46de-8266-22c224b13608', NULL, 'auth-otp-form', '5ebb9076-4db1-482d-9e07-c56acd16b969', '9b1bc705-a152-4d32-be07-9d7563a8abae', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('98755759-b983-4fc2-8230-c84061c959f8', NULL, 'http-basic-authenticator', '5ebb9076-4db1-482d-9e07-c56acd16b969', '1347e1de-09d5-427e-9013-374029061add', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d817fd55-fc71-43cd-a4e8-c9cbc489b799', NULL, 'docker-http-basic-authenticator', '5ebb9076-4db1-482d-9e07-c56acd16b969', '6d2f0e18-4502-43a0-9c70-f40c14948488', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d71e91e4-7f58-4502-a62d-10b20552ebdc', NULL, 'auth-cookie', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'efbdddc5-5e69-41ff-8f1c-30d8a3b1efac', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('88aa1c74-811d-4197-96bc-0b91b947bbb3', NULL, 'auth-spnego', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'efbdddc5-5e69-41ff-8f1c-30d8a3b1efac', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('752ec903-bf61-4e35-a301-c4aed1a3f17d', NULL, 'identity-provider-redirector', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'efbdddc5-5e69-41ff-8f1c-30d8a3b1efac', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('6a9d0286-7d49-4c1b-a582-d45b120a1b7c', NULL, NULL, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'efbdddc5-5e69-41ff-8f1c-30d8a3b1efac', 2, 30, true, 'a3b928b5-30ad-4311-bf54-42aa1ef19ada', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c760a5b8-5658-40b4-a735-5e60d7111bf1', NULL, 'auth-username-password-form', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'a3b928b5-30ad-4311-bf54-42aa1ef19ada', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('dc6b99b3-0e4e-4f7d-8b50-685fad920ced', NULL, NULL, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'a3b928b5-30ad-4311-bf54-42aa1ef19ada', 1, 20, true, 'a54ee55d-5985-4a05-88f6-3f28270d2ae7', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('a1ab490d-db2f-44da-81d7-648f37d5e35b', NULL, 'conditional-user-configured', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'a54ee55d-5985-4a05-88f6-3f28270d2ae7', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b8a7b6bc-f9c1-4c15-853f-74fd93e7d5a9', NULL, 'auth-otp-form', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'a54ee55d-5985-4a05-88f6-3f28270d2ae7', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('83300237-3a32-4507-90cf-285da65e49dc', NULL, 'direct-grant-validate-username', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '7ff94ec7-ac91-4b17-83f7-a23279f2d8a3', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('a87db7fe-4776-404a-b6b0-e610865a976e', NULL, 'direct-grant-validate-password', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '7ff94ec7-ac91-4b17-83f7-a23279f2d8a3', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('054f3bd1-710c-43cd-a4fd-995b924bde31', NULL, NULL, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '7ff94ec7-ac91-4b17-83f7-a23279f2d8a3', 1, 30, true, 'ffc1cc40-9361-48f0-8e77-7cd8ef12b1f9', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('3571c2d8-9f9d-4252-938b-1724da03e85a', NULL, 'conditional-user-configured', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'ffc1cc40-9361-48f0-8e77-7cd8ef12b1f9', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('fe5be610-f902-493c-826d-f53f6e0bc410', NULL, 'direct-grant-validate-otp', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'ffc1cc40-9361-48f0-8e77-7cd8ef12b1f9', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('77f5c5ab-f31e-481f-b76b-74b0cc0e0a57', NULL, 'registration-page-form', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'd93f4b4c-8b4e-4b13-9971-cc9f277c6b66', 0, 10, true, '5648f338-74ca-47cf-bb00-740c63700ebe', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0f55c77c-5fc7-4e81-9519-b3a59c6d39cc', NULL, 'registration-user-creation', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '5648f338-74ca-47cf-bb00-740c63700ebe', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b89b7b3c-4119-49b9-a044-3892740da317', NULL, 'registration-password-action', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '5648f338-74ca-47cf-bb00-740c63700ebe', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('314e29c7-934f-4226-add8-45dff7b983ca', NULL, 'registration-recaptcha-action', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '5648f338-74ca-47cf-bb00-740c63700ebe', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c980bb2b-2c5e-4613-8634-bf3cc511a9fb', NULL, 'registration-terms-and-conditions', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '5648f338-74ca-47cf-bb00-740c63700ebe', 3, 70, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('05483ddd-f300-433f-b233-9f4a5a6e7485', NULL, 'reset-credentials-choose-user', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'b91109f8-1911-44e0-8dea-9c7b8407ae1b', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('5acb2231-6e1a-41a1-a8a6-cd06d0abc18e', NULL, 'reset-credential-email', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'b91109f8-1911-44e0-8dea-9c7b8407ae1b', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e51a9746-df90-4993-a42a-08c41fd96b6f', NULL, 'reset-password', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'b91109f8-1911-44e0-8dea-9c7b8407ae1b', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('fa027b11-88b6-4878-b01c-f8cd86eaa353', NULL, NULL, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'b91109f8-1911-44e0-8dea-9c7b8407ae1b', 1, 40, true, '5a2bda90-57b6-4a76-b6c6-b49acc6ca8a1', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('649ed771-540f-4f04-9a32-c5393eaf87d4', NULL, 'conditional-user-configured', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '5a2bda90-57b6-4a76-b6c6-b49acc6ca8a1', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('db7a0616-0a16-490b-921e-00daa40eedd1', NULL, 'reset-otp', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '5a2bda90-57b6-4a76-b6c6-b49acc6ca8a1', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('45d61fc9-5904-4d2f-8a05-160cecc4f365', NULL, 'client-secret', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '0bc82491-5be9-4596-9264-c1b14efeffb4', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('715ae24a-986e-426c-b8cb-2ceddb88ec92', NULL, 'client-jwt', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '0bc82491-5be9-4596-9264-c1b14efeffb4', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('fefdc7b0-43a1-4490-a74d-04cacdddfd01', NULL, 'client-secret-jwt', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '0bc82491-5be9-4596-9264-c1b14efeffb4', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('6babfd75-82ac-473c-9ba5-8bc3a0d24dd7', NULL, 'client-x509', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '0bc82491-5be9-4596-9264-c1b14efeffb4', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e3f1d233-1877-40c7-a5da-0123137734c2', NULL, 'idp-review-profile', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'dca0f4f3-d3a2-428e-9bc0-ab6af572ec2a', 0, 10, false, NULL, 'd5b66463-cbb2-4058-9235-1d9c06c8172e');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c810044a-b62f-4886-8314-653fbf6f4c77', NULL, NULL, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'dca0f4f3-d3a2-428e-9bc0-ab6af572ec2a', 0, 20, true, 'be7020b3-d4d5-45ab-be0e-f0e0f3ecafb6', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('57347434-5d0a-450b-bed4-726e69f56553', NULL, 'idp-create-user-if-unique', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'be7020b3-d4d5-45ab-be0e-f0e0f3ecafb6', 2, 10, false, NULL, '9af6a60f-b735-4c87-b5ee-cfe3604ab138');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('cdeb0d1c-3087-4cbe-a410-a40152875239', NULL, NULL, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'be7020b3-d4d5-45ab-be0e-f0e0f3ecafb6', 2, 20, true, 'e9db27a0-e40a-4535-8527-658933fa26db', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('57f7c7ad-2849-4b59-af42-7b375b9333f3', NULL, 'idp-confirm-link', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e9db27a0-e40a-4535-8527-658933fa26db', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b05c3612-8abe-4da8-a06e-7a1322ba32a1', NULL, NULL, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e9db27a0-e40a-4535-8527-658933fa26db', 0, 20, true, '1448a932-5347-42b1-979a-fa8cc54f2f68', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('8db4def6-b7b4-4f0f-8ecb-f557eedde706', NULL, 'idp-email-verification', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '1448a932-5347-42b1-979a-fa8cc54f2f68', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('3ff0ff17-b39e-4859-9edf-b53ab2df3652', NULL, NULL, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '1448a932-5347-42b1-979a-fa8cc54f2f68', 2, 20, true, 'accbf804-6cbe-4ec7-abbf-7b02989f6336', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c32f7e11-9d53-427e-a76b-e43f140e831e', NULL, 'idp-username-password-form', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'accbf804-6cbe-4ec7-abbf-7b02989f6336', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('104af3df-8d24-443f-8cab-1be8634d5ea2', NULL, NULL, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'accbf804-6cbe-4ec7-abbf-7b02989f6336', 1, 20, true, 'e779d2bb-2d09-44a8-981d-005fab89faab', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('abf6afc4-4bcc-44f9-bf6c-59a48e7b965f', NULL, 'conditional-user-configured', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e779d2bb-2d09-44a8-981d-005fab89faab', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f7f60fde-da9e-4ae8-99c6-02a4ba1a6744', NULL, 'auth-otp-form', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e779d2bb-2d09-44a8-981d-005fab89faab', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('28649977-704c-4115-af20-bdcdec943ed3', NULL, 'http-basic-authenticator', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '582c4a97-96a2-422e-89af-c1834765f934', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('fce74524-b950-456e-80e8-e8367ff45a25', NULL, 'docker-http-basic-authenticator', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '0c636876-3cac-4960-82b1-064d665274ee', 0, 10, false, NULL, NULL);


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('3652e908-ea1e-42cf-b479-b4865418d51b', 'browser', 'browser based authentication', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('d93f2530-ec05-429d-992d-7f5eba4f27ee', 'forms', 'Username, password, otp and other auth forms.', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('86202770-48a9-47c0-9f40-17279f8bd94f', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('58143a22-fcaf-4443-83e4-f5a9e6eb5e57', 'direct grant', 'OpenID Connect Resource Owner Grant', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('3de222d6-2d29-4ec9-a682-1facfd80ee8b', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('c8416e49-d2c0-4fe9-8a33-d90489d296b6', 'registration', 'registration flow', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('56a81fea-ba2b-4ec3-80eb-b69d376399d1', 'registration form', 'registration form', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'form-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('76f8f2be-cfb6-4867-ae24-6a840c9a7de0', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('11ff989c-9828-4fe3-b521-4a0ad7c5aee1', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('320d1295-2201-405e-b579-282c9873cdec', 'clients', 'Base authentication for clients', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'client-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('4723fabb-87c7-4ce0-93ab-f36dbf7744be', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('723b6a28-d9e4-44d0-8765-1ff73998649b', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('f0a0a847-b595-4cf6-8287-607e4cb5a8cb', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('737bf08c-cdc3-4cb4-8725-f620cfe0b3b4', 'Account verification options', 'Method with which to verity the existing account', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('046f89a9-dd71-49dc-b2ae-79343f828783', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('9b1bc705-a152-4d32-be07-9d7563a8abae', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('1347e1de-09d5-427e-9013-374029061add', 'saml ecp', 'SAML ECP Profile Authentication Flow', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('6d2f0e18-4502-43a0-9c70-f40c14948488', 'docker auth', 'Used by Docker clients to authenticate against the IDP', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('efbdddc5-5e69-41ff-8f1c-30d8a3b1efac', 'browser', 'browser based authentication', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('a3b928b5-30ad-4311-bf54-42aa1ef19ada', 'forms', 'Username, password, otp and other auth forms.', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('a54ee55d-5985-4a05-88f6-3f28270d2ae7', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('7ff94ec7-ac91-4b17-83f7-a23279f2d8a3', 'direct grant', 'OpenID Connect Resource Owner Grant', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('ffc1cc40-9361-48f0-8e77-7cd8ef12b1f9', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('d93f4b4c-8b4e-4b13-9971-cc9f277c6b66', 'registration', 'registration flow', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('5648f338-74ca-47cf-bb00-740c63700ebe', 'registration form', 'registration form', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'form-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('b91109f8-1911-44e0-8dea-9c7b8407ae1b', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('5a2bda90-57b6-4a76-b6c6-b49acc6ca8a1', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('0bc82491-5be9-4596-9264-c1b14efeffb4', 'clients', 'Base authentication for clients', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'client-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('dca0f4f3-d3a2-428e-9bc0-ab6af572ec2a', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('be7020b3-d4d5-45ab-be0e-f0e0f3ecafb6', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('e9db27a0-e40a-4535-8527-658933fa26db', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('1448a932-5347-42b1-979a-fa8cc54f2f68', 'Account verification options', 'Method with which to verity the existing account', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('accbf804-6cbe-4ec7-abbf-7b02989f6336', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('e779d2bb-2d09-44a8-981d-005fab89faab', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('582c4a97-96a2-422e-89af-c1834765f934', 'saml ecp', 'SAML ECP Profile Authentication Flow', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('0c636876-3cac-4960-82b1-064d665274ee', 'docker auth', 'Used by Docker clients to authenticate against the IDP', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'basic-flow', true, true);


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('947b4405-4e71-4f66-8bfb-3a202f4d67ee', 'review profile config', '5ebb9076-4db1-482d-9e07-c56acd16b969');
INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('5fcd5939-9243-4c9b-b499-9b6cdce1097b', 'create unique user config', '5ebb9076-4db1-482d-9e07-c56acd16b969');
INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('d5b66463-cbb2-4058-9235-1d9c06c8172e', 'review profile config', '99df8a6f-6238-421f-a213-77c5c1ca6a2b');
INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('9af6a60f-b735-4c87-b5ee-cfe3604ab138', 'create unique user config', '99df8a6f-6238-421f-a213-77c5c1ca6a2b');


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('5fcd5939-9243-4c9b-b499-9b6cdce1097b', 'false', 'require.password.update.after.registration');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('947b4405-4e71-4f66-8bfb-3a202f4d67ee', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('9af6a60f-b735-4c87-b5ee-cfe3604ab138', 'false', 'require.password.update.after.registration');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('d5b66463-cbb2-4058-9235-1d9c06c8172e', 'missing', 'update.profile.on.first.login');


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('895ba852-18c4-4275-9582-a9b97240d710', true, false, 'master-realm', 0, false, NULL, NULL, true, NULL, false, '5ebb9076-4db1-482d-9e07-c56acd16b969', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('19677387-4876-4acd-8fda-69899b89f956', true, false, 'account', 0, true, NULL, '/realms/master/account/', false, NULL, false, '5ebb9076-4db1-482d-9e07-c56acd16b969', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', true, false, 'account-console', 0, true, NULL, '/realms/master/account/', false, NULL, false, '5ebb9076-4db1-482d-9e07-c56acd16b969', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('47948543-4a1a-454e-94ea-83747f157c0f', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, '5ebb9076-4db1-482d-9e07-c56acd16b969', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', true, false, 'security-admin-console', 0, true, NULL, '/admin/master/console/', false, NULL, false, '5ebb9076-4db1-482d-9e07-c56acd16b969', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('ceeb235e-461d-400e-b13b-9778fa793b6a', true, false, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, '5ebb9076-4db1-482d-9e07-c56acd16b969', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('41663dc7-1a06-4376-82f2-108fd894234c', true, false, 'app-realm', 0, false, NULL, NULL, true, NULL, false, '5ebb9076-4db1-482d-9e07-c56acd16b969', NULL, 0, false, false, 'app Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, false, 'realm-management', 0, false, NULL, NULL, true, NULL, false, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'openid-connect', 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('1f26f5af-8b3b-4816-b67e-66de6cff07d5', true, false, 'account', 0, true, NULL, '/realms/app/account/', false, NULL, false, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', true, false, 'account-console', 0, true, NULL, '/realms/app/account/', false, NULL, false, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('e7647f61-df77-4cba-bcd1-1cb339c3d4e5', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', true, false, 'security-admin-console', 0, true, NULL, '/admin/app/console/', false, NULL, false, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('f83bc7a5-20bd-451c-9439-4fe626dbdfbf', true, false, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', true, true, 'app-server-dev', 0, false, 's5LFc7yMF8txhhCTOtoaACzeAGzQgL2j', 'http://localhost:3000', false, 'http://localhost:3000', false, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'openid-connect', -1, true, false, 'App dev - server', true, 'client-secret', 'http://localhost:3000', '', NULL, true, false, true, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', true, true, 'app-client-dev', 0, true, NULL, 'http://localhost:3000', false, 'http://localhost:3000', false, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'openid-connect', -1, true, false, 'App dev - client', false, 'client-secret', 'http://localhost:3000', '', NULL, true, false, true, false);


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.client_attributes (client_id, name, value) VALUES ('19677387-4876-4acd-8fda-69899b89f956', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('1f26f5af-8b3b-4816-b67e-66de6cff07d5', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', 'oauth2.device.authorization.grant.enabled', 'false');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', 'oidc.ciba.grant.enabled', 'false');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', 'backchannel.logout.session.required', 'true');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', 'backchannel.logout.revoke.offline.tokens', 'false');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', 'client.secret.creation.time', '1720442859');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', 'oauth2.device.authorization.grant.enabled', 'false');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', 'oidc.ciba.grant.enabled', 'false');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', 'backchannel.logout.session.required', 'true');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', 'backchannel.logout.revoke.offline.tokens', 'false');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', 'display.on.consent.screen', 'false');
INSERT INTO public.client_attributes (client_id, name, value) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', 'display.on.consent.screen', 'false');


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('d0b78d07-8f09-4a84-ae95-b13370239a5c', 'offline_access', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('d6cdf084-0135-4b77-852c-34a834557f83', 'role_list', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'SAML role list', 'saml');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('25ab9eda-4627-4029-ae6c-cf4aac769e2c', 'profile', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('14232ad5-4ba0-49a1-9bec-7a5b4f6cf7c5', 'email', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('37d29ca8-7a65-4cc7-83d3-0d299f9c7707', 'address', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('8f72dba6-7050-4a38-9655-025b06f90978', 'phone', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('248d2c7d-0baf-4f45-9cd1-96e5acc857f6', 'roles', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('de09dc39-a565-44de-9ee6-e83a90f96044', 'web-origins', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('abdc5ee1-1a7c-45be-93c3-5d9d1af90cf2', 'microprofile-jwt', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('038442a2-20d9-4c93-8614-099a6db0a90d', 'acr', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('ddd54f97-f1ea-46c1-be49-7fd3093d08aa', 'offline_access', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('248c4ce7-9225-4e16-85ec-d57a7d8bb8f1', 'role_list', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'SAML role list', 'saml');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('14851311-7732-49b8-bf33-69b6b2f82994', 'profile', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('82e449c3-b62f-40ea-86bf-9e81d248c36d', 'email', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('68a79385-0696-4ebc-a1f5-2a20889ee1a9', 'address', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('b63fa870-75bf-476f-ad39-88710fbbf852', 'phone', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('fa88c0dc-4dd2-48b1-810e-36d7f8232de8', 'roles', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('76290814-e2c8-4785-90ac-a46c8d5546b0', 'web-origins', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('54c3f42e-36e1-4405-bf2c-0bed35efd5b8', 'microprofile-jwt', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('178d8a05-3929-472b-ad1b-096ba509f670', 'acr', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('d0b78d07-8f09-4a84-ae95-b13370239a5c', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('d0b78d07-8f09-4a84-ae95-b13370239a5c', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('d6cdf084-0135-4b77-852c-34a834557f83', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('d6cdf084-0135-4b77-852c-34a834557f83', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('25ab9eda-4627-4029-ae6c-cf4aac769e2c', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('25ab9eda-4627-4029-ae6c-cf4aac769e2c', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('25ab9eda-4627-4029-ae6c-cf4aac769e2c', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('14232ad5-4ba0-49a1-9bec-7a5b4f6cf7c5', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('14232ad5-4ba0-49a1-9bec-7a5b4f6cf7c5', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('14232ad5-4ba0-49a1-9bec-7a5b4f6cf7c5', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('37d29ca8-7a65-4cc7-83d3-0d299f9c7707', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('37d29ca8-7a65-4cc7-83d3-0d299f9c7707', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('37d29ca8-7a65-4cc7-83d3-0d299f9c7707', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('8f72dba6-7050-4a38-9655-025b06f90978', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('8f72dba6-7050-4a38-9655-025b06f90978', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('8f72dba6-7050-4a38-9655-025b06f90978', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('248d2c7d-0baf-4f45-9cd1-96e5acc857f6', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('248d2c7d-0baf-4f45-9cd1-96e5acc857f6', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('248d2c7d-0baf-4f45-9cd1-96e5acc857f6', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('de09dc39-a565-44de-9ee6-e83a90f96044', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('de09dc39-a565-44de-9ee6-e83a90f96044', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('de09dc39-a565-44de-9ee6-e83a90f96044', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('abdc5ee1-1a7c-45be-93c3-5d9d1af90cf2', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('abdc5ee1-1a7c-45be-93c3-5d9d1af90cf2', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('038442a2-20d9-4c93-8614-099a6db0a90d', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('038442a2-20d9-4c93-8614-099a6db0a90d', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('ddd54f97-f1ea-46c1-be49-7fd3093d08aa', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('ddd54f97-f1ea-46c1-be49-7fd3093d08aa', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('248c4ce7-9225-4e16-85ec-d57a7d8bb8f1', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('248c4ce7-9225-4e16-85ec-d57a7d8bb8f1', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('14851311-7732-49b8-bf33-69b6b2f82994', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('14851311-7732-49b8-bf33-69b6b2f82994', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('14851311-7732-49b8-bf33-69b6b2f82994', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('82e449c3-b62f-40ea-86bf-9e81d248c36d', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('82e449c3-b62f-40ea-86bf-9e81d248c36d', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('82e449c3-b62f-40ea-86bf-9e81d248c36d', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('68a79385-0696-4ebc-a1f5-2a20889ee1a9', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('68a79385-0696-4ebc-a1f5-2a20889ee1a9', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('68a79385-0696-4ebc-a1f5-2a20889ee1a9', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('b63fa870-75bf-476f-ad39-88710fbbf852', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('b63fa870-75bf-476f-ad39-88710fbbf852', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('b63fa870-75bf-476f-ad39-88710fbbf852', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('fa88c0dc-4dd2-48b1-810e-36d7f8232de8', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('fa88c0dc-4dd2-48b1-810e-36d7f8232de8', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('fa88c0dc-4dd2-48b1-810e-36d7f8232de8', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('76290814-e2c8-4785-90ac-a46c8d5546b0', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('76290814-e2c8-4785-90ac-a46c8d5546b0', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('76290814-e2c8-4785-90ac-a46c8d5546b0', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('54c3f42e-36e1-4405-bf2c-0bed35efd5b8', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('54c3f42e-36e1-4405-bf2c-0bed35efd5b8', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('178d8a05-3929-472b-ad1b-096ba509f670', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('178d8a05-3929-472b-ad1b-096ba509f670', 'false', 'include.in.token.scope');


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('19677387-4876-4acd-8fda-69899b89f956', 'de09dc39-a565-44de-9ee6-e83a90f96044', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('19677387-4876-4acd-8fda-69899b89f956', '038442a2-20d9-4c93-8614-099a6db0a90d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('19677387-4876-4acd-8fda-69899b89f956', '25ab9eda-4627-4029-ae6c-cf4aac769e2c', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('19677387-4876-4acd-8fda-69899b89f956', '14232ad5-4ba0-49a1-9bec-7a5b4f6cf7c5', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('19677387-4876-4acd-8fda-69899b89f956', '248d2c7d-0baf-4f45-9cd1-96e5acc857f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('19677387-4876-4acd-8fda-69899b89f956', '8f72dba6-7050-4a38-9655-025b06f90978', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('19677387-4876-4acd-8fda-69899b89f956', 'd0b78d07-8f09-4a84-ae95-b13370239a5c', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('19677387-4876-4acd-8fda-69899b89f956', '37d29ca8-7a65-4cc7-83d3-0d299f9c7707', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('19677387-4876-4acd-8fda-69899b89f956', 'abdc5ee1-1a7c-45be-93c3-5d9d1af90cf2', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', 'de09dc39-a565-44de-9ee6-e83a90f96044', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', '038442a2-20d9-4c93-8614-099a6db0a90d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', '25ab9eda-4627-4029-ae6c-cf4aac769e2c', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', '14232ad5-4ba0-49a1-9bec-7a5b4f6cf7c5', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', '248d2c7d-0baf-4f45-9cd1-96e5acc857f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', '8f72dba6-7050-4a38-9655-025b06f90978', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', 'd0b78d07-8f09-4a84-ae95-b13370239a5c', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', '37d29ca8-7a65-4cc7-83d3-0d299f9c7707', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', 'abdc5ee1-1a7c-45be-93c3-5d9d1af90cf2', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ceeb235e-461d-400e-b13b-9778fa793b6a', 'de09dc39-a565-44de-9ee6-e83a90f96044', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ceeb235e-461d-400e-b13b-9778fa793b6a', '038442a2-20d9-4c93-8614-099a6db0a90d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ceeb235e-461d-400e-b13b-9778fa793b6a', '25ab9eda-4627-4029-ae6c-cf4aac769e2c', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ceeb235e-461d-400e-b13b-9778fa793b6a', '14232ad5-4ba0-49a1-9bec-7a5b4f6cf7c5', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ceeb235e-461d-400e-b13b-9778fa793b6a', '248d2c7d-0baf-4f45-9cd1-96e5acc857f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ceeb235e-461d-400e-b13b-9778fa793b6a', '8f72dba6-7050-4a38-9655-025b06f90978', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ceeb235e-461d-400e-b13b-9778fa793b6a', 'd0b78d07-8f09-4a84-ae95-b13370239a5c', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ceeb235e-461d-400e-b13b-9778fa793b6a', '37d29ca8-7a65-4cc7-83d3-0d299f9c7707', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('ceeb235e-461d-400e-b13b-9778fa793b6a', 'abdc5ee1-1a7c-45be-93c3-5d9d1af90cf2', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('47948543-4a1a-454e-94ea-83747f157c0f', 'de09dc39-a565-44de-9ee6-e83a90f96044', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('47948543-4a1a-454e-94ea-83747f157c0f', '038442a2-20d9-4c93-8614-099a6db0a90d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('47948543-4a1a-454e-94ea-83747f157c0f', '25ab9eda-4627-4029-ae6c-cf4aac769e2c', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('47948543-4a1a-454e-94ea-83747f157c0f', '14232ad5-4ba0-49a1-9bec-7a5b4f6cf7c5', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('47948543-4a1a-454e-94ea-83747f157c0f', '248d2c7d-0baf-4f45-9cd1-96e5acc857f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('47948543-4a1a-454e-94ea-83747f157c0f', '8f72dba6-7050-4a38-9655-025b06f90978', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('47948543-4a1a-454e-94ea-83747f157c0f', 'd0b78d07-8f09-4a84-ae95-b13370239a5c', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('47948543-4a1a-454e-94ea-83747f157c0f', '37d29ca8-7a65-4cc7-83d3-0d299f9c7707', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('47948543-4a1a-454e-94ea-83747f157c0f', 'abdc5ee1-1a7c-45be-93c3-5d9d1af90cf2', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('895ba852-18c4-4275-9582-a9b97240d710', 'de09dc39-a565-44de-9ee6-e83a90f96044', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('895ba852-18c4-4275-9582-a9b97240d710', '038442a2-20d9-4c93-8614-099a6db0a90d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('895ba852-18c4-4275-9582-a9b97240d710', '25ab9eda-4627-4029-ae6c-cf4aac769e2c', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('895ba852-18c4-4275-9582-a9b97240d710', '14232ad5-4ba0-49a1-9bec-7a5b4f6cf7c5', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('895ba852-18c4-4275-9582-a9b97240d710', '248d2c7d-0baf-4f45-9cd1-96e5acc857f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('895ba852-18c4-4275-9582-a9b97240d710', '8f72dba6-7050-4a38-9655-025b06f90978', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('895ba852-18c4-4275-9582-a9b97240d710', 'd0b78d07-8f09-4a84-ae95-b13370239a5c', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('895ba852-18c4-4275-9582-a9b97240d710', '37d29ca8-7a65-4cc7-83d3-0d299f9c7707', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('895ba852-18c4-4275-9582-a9b97240d710', 'abdc5ee1-1a7c-45be-93c3-5d9d1af90cf2', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', 'de09dc39-a565-44de-9ee6-e83a90f96044', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', '038442a2-20d9-4c93-8614-099a6db0a90d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', '25ab9eda-4627-4029-ae6c-cf4aac769e2c', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', '14232ad5-4ba0-49a1-9bec-7a5b4f6cf7c5', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', '248d2c7d-0baf-4f45-9cd1-96e5acc857f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', '8f72dba6-7050-4a38-9655-025b06f90978', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', 'd0b78d07-8f09-4a84-ae95-b13370239a5c', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', '37d29ca8-7a65-4cc7-83d3-0d299f9c7707', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', 'abdc5ee1-1a7c-45be-93c3-5d9d1af90cf2', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('1f26f5af-8b3b-4816-b67e-66de6cff07d5', '82e449c3-b62f-40ea-86bf-9e81d248c36d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('1f26f5af-8b3b-4816-b67e-66de6cff07d5', '14851311-7732-49b8-bf33-69b6b2f82994', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('1f26f5af-8b3b-4816-b67e-66de6cff07d5', '76290814-e2c8-4785-90ac-a46c8d5546b0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('1f26f5af-8b3b-4816-b67e-66de6cff07d5', '178d8a05-3929-472b-ad1b-096ba509f670', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('1f26f5af-8b3b-4816-b67e-66de6cff07d5', 'fa88c0dc-4dd2-48b1-810e-36d7f8232de8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('1f26f5af-8b3b-4816-b67e-66de6cff07d5', '54c3f42e-36e1-4405-bf2c-0bed35efd5b8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('1f26f5af-8b3b-4816-b67e-66de6cff07d5', 'ddd54f97-f1ea-46c1-be49-7fd3093d08aa', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('1f26f5af-8b3b-4816-b67e-66de6cff07d5', 'b63fa870-75bf-476f-ad39-88710fbbf852', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('1f26f5af-8b3b-4816-b67e-66de6cff07d5', '68a79385-0696-4ebc-a1f5-2a20889ee1a9', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', '82e449c3-b62f-40ea-86bf-9e81d248c36d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', '14851311-7732-49b8-bf33-69b6b2f82994', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', '76290814-e2c8-4785-90ac-a46c8d5546b0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', '178d8a05-3929-472b-ad1b-096ba509f670', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', 'fa88c0dc-4dd2-48b1-810e-36d7f8232de8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', '54c3f42e-36e1-4405-bf2c-0bed35efd5b8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', 'ddd54f97-f1ea-46c1-be49-7fd3093d08aa', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', 'b63fa870-75bf-476f-ad39-88710fbbf852', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', '68a79385-0696-4ebc-a1f5-2a20889ee1a9', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f83bc7a5-20bd-451c-9439-4fe626dbdfbf', '82e449c3-b62f-40ea-86bf-9e81d248c36d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f83bc7a5-20bd-451c-9439-4fe626dbdfbf', '14851311-7732-49b8-bf33-69b6b2f82994', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f83bc7a5-20bd-451c-9439-4fe626dbdfbf', '76290814-e2c8-4785-90ac-a46c8d5546b0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f83bc7a5-20bd-451c-9439-4fe626dbdfbf', '178d8a05-3929-472b-ad1b-096ba509f670', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f83bc7a5-20bd-451c-9439-4fe626dbdfbf', 'fa88c0dc-4dd2-48b1-810e-36d7f8232de8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f83bc7a5-20bd-451c-9439-4fe626dbdfbf', '54c3f42e-36e1-4405-bf2c-0bed35efd5b8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f83bc7a5-20bd-451c-9439-4fe626dbdfbf', 'ddd54f97-f1ea-46c1-be49-7fd3093d08aa', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f83bc7a5-20bd-451c-9439-4fe626dbdfbf', 'b63fa870-75bf-476f-ad39-88710fbbf852', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('f83bc7a5-20bd-451c-9439-4fe626dbdfbf', '68a79385-0696-4ebc-a1f5-2a20889ee1a9', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e7647f61-df77-4cba-bcd1-1cb339c3d4e5', '82e449c3-b62f-40ea-86bf-9e81d248c36d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e7647f61-df77-4cba-bcd1-1cb339c3d4e5', '14851311-7732-49b8-bf33-69b6b2f82994', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e7647f61-df77-4cba-bcd1-1cb339c3d4e5', '76290814-e2c8-4785-90ac-a46c8d5546b0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e7647f61-df77-4cba-bcd1-1cb339c3d4e5', '178d8a05-3929-472b-ad1b-096ba509f670', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e7647f61-df77-4cba-bcd1-1cb339c3d4e5', 'fa88c0dc-4dd2-48b1-810e-36d7f8232de8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e7647f61-df77-4cba-bcd1-1cb339c3d4e5', '54c3f42e-36e1-4405-bf2c-0bed35efd5b8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e7647f61-df77-4cba-bcd1-1cb339c3d4e5', 'ddd54f97-f1ea-46c1-be49-7fd3093d08aa', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e7647f61-df77-4cba-bcd1-1cb339c3d4e5', 'b63fa870-75bf-476f-ad39-88710fbbf852', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e7647f61-df77-4cba-bcd1-1cb339c3d4e5', '68a79385-0696-4ebc-a1f5-2a20889ee1a9', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', '82e449c3-b62f-40ea-86bf-9e81d248c36d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', '14851311-7732-49b8-bf33-69b6b2f82994', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', '76290814-e2c8-4785-90ac-a46c8d5546b0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', '178d8a05-3929-472b-ad1b-096ba509f670', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', 'fa88c0dc-4dd2-48b1-810e-36d7f8232de8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', '54c3f42e-36e1-4405-bf2c-0bed35efd5b8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', 'ddd54f97-f1ea-46c1-be49-7fd3093d08aa', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', 'b63fa870-75bf-476f-ad39-88710fbbf852', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', '68a79385-0696-4ebc-a1f5-2a20889ee1a9', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', '82e449c3-b62f-40ea-86bf-9e81d248c36d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', '14851311-7732-49b8-bf33-69b6b2f82994', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', '76290814-e2c8-4785-90ac-a46c8d5546b0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', '178d8a05-3929-472b-ad1b-096ba509f670', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', 'fa88c0dc-4dd2-48b1-810e-36d7f8232de8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', '54c3f42e-36e1-4405-bf2c-0bed35efd5b8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', 'ddd54f97-f1ea-46c1-be49-7fd3093d08aa', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', 'b63fa870-75bf-476f-ad39-88710fbbf852', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', '68a79385-0696-4ebc-a1f5-2a20889ee1a9', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', '82e449c3-b62f-40ea-86bf-9e81d248c36d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', '14851311-7732-49b8-bf33-69b6b2f82994', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', '76290814-e2c8-4785-90ac-a46c8d5546b0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', '178d8a05-3929-472b-ad1b-096ba509f670', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', 'fa88c0dc-4dd2-48b1-810e-36d7f8232de8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', '54c3f42e-36e1-4405-bf2c-0bed35efd5b8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', 'ddd54f97-f1ea-46c1-be49-7fd3093d08aa', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', 'b63fa870-75bf-476f-ad39-88710fbbf852', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', '68a79385-0696-4ebc-a1f5-2a20889ee1a9', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', '82e449c3-b62f-40ea-86bf-9e81d248c36d', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', '14851311-7732-49b8-bf33-69b6b2f82994', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', '76290814-e2c8-4785-90ac-a46c8d5546b0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', '178d8a05-3929-472b-ad1b-096ba509f670', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', 'fa88c0dc-4dd2-48b1-810e-36d7f8232de8', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', '54c3f42e-36e1-4405-bf2c-0bed35efd5b8', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', 'ddd54f97-f1ea-46c1-be49-7fd3093d08aa', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', 'b63fa870-75bf-476f-ad39-88710fbbf852', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', '68a79385-0696-4ebc-a1f5-2a20889ee1a9', false);


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.client_scope_role_mapping (scope_id, role_id) VALUES ('d0b78d07-8f09-4a84-ae95-b13370239a5c', 'cb1dba1d-f358-4a7d-a8cf-3ed7578e2c36');
INSERT INTO public.client_scope_role_mapping (scope_id, role_id) VALUES ('ddd54f97-f1ea-46c1-be49-7fd3093d08aa', 'b6aa342b-c5e1-4d1d-a96a-4f2d2b779b5c');


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('80c5921e-e5e8-4280-9064-d574bccdb249', 'Trusted Hosts', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('e6acdab3-4b1c-435b-813e-6f39254b8d8d', 'Consent Required', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('f4ada978-0bcb-4b58-9591-81fd8eb8212e', 'Full Scope Disabled', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('e7e9d2f8-980d-4a0b-81e8-57cf033c49e2', 'Max Clients Limit', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('14e05d24-e115-40e3-acf2-3f27d0b2cc34', 'Allowed Protocol Mapper Types', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('1ee6aa13-7bd3-4a72-a0a5-a8d8a576d554', 'Allowed Client Scopes', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('e85a18c7-fc5a-4a3a-a068-907eca670483', 'Allowed Protocol Mapper Types', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('46bb6626-879f-4dd0-9bf4-ab3a9222da44', 'Allowed Client Scopes', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('6747a13e-4bef-4343-97c9-f941271ef79b', 'rsa-generated', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'rsa-generated', 'org.keycloak.keys.KeyProvider', '5ebb9076-4db1-482d-9e07-c56acd16b969', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('4c3a9c69-62fd-48c1-a35b-1ae692b42a5b', 'rsa-enc-generated', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', '5ebb9076-4db1-482d-9e07-c56acd16b969', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('9c2ddf6d-ef56-48c9-b80c-eb7951f0f8f2', 'hmac-generated-hs512', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'hmac-generated', 'org.keycloak.keys.KeyProvider', '5ebb9076-4db1-482d-9e07-c56acd16b969', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('dc7bf955-6dbe-4423-999d-f1498d7e1ba8', 'aes-generated', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'aes-generated', 'org.keycloak.keys.KeyProvider', '5ebb9076-4db1-482d-9e07-c56acd16b969', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('8ca422d3-1614-467f-a230-b9f8c04f9edd', NULL, '5ebb9076-4db1-482d-9e07-c56acd16b969', 'declarative-user-profile', 'org.keycloak.userprofile.UserProfileProvider', '5ebb9076-4db1-482d-9e07-c56acd16b969', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('5b72ee9c-2fea-4acc-baeb-ed9c0a8b44dc', 'rsa-generated', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'rsa-generated', 'org.keycloak.keys.KeyProvider', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('25a8527d-63f0-4b22-9669-fcaeb4e05316', 'rsa-enc-generated', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('7eff9031-5e04-42cd-8457-785c102ab405', 'hmac-generated-hs512', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'hmac-generated', 'org.keycloak.keys.KeyProvider', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('b65a7503-9a41-4775-8746-9cfc73dada17', 'aes-generated', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'aes-generated', 'org.keycloak.keys.KeyProvider', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('c435bc55-4529-4b73-b772-3c3ffda595e8', 'Trusted Hosts', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('335c93d8-bb2c-42af-acd6-64691dba2e29', 'Consent Required', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('2565bf80-fe8e-4925-a541-d4799728c578', 'Full Scope Disabled', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('3056cc47-a7b0-493a-ba5a-6481d76e7d00', 'Max Clients Limit', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('371ebf11-ef89-422f-8b1a-3841b4a081a9', 'Allowed Protocol Mapper Types', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('e020f479-3624-4ae8-bde5-0b510a1cc765', 'Allowed Client Scopes', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('e99b432a-43c6-4962-9eea-24556ff352ff', 'Allowed Protocol Mapper Types', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('a59992a2-773f-4a77-a699-40cec1dfd847', 'Allowed Client Scopes', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('409b675e-9002-415d-b1b7-19a45b04246e', NULL, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'declarative-user-profile', 'org.keycloak.userprofile.UserProfileProvider', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', NULL);


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.component_config (id, component_id, name, value) VALUES ('081638a2-412c-435c-a1da-93e3f762ab7f', '80c5921e-e5e8-4280-9064-d574bccdb249', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('2545bca8-4060-454b-8690-174dc652571f', '80c5921e-e5e8-4280-9064-d574bccdb249', 'client-uris-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('237aa070-bb0c-48e4-b499-abf0de172941', 'e7e9d2f8-980d-4a0b-81e8-57cf033c49e2', 'max-clients', '200');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('7948676e-4115-4ac8-b527-3226e4fc35a5', '14e05d24-e115-40e3-acf2-3f27d0b2cc34', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('3b816c93-a81b-48c6-aa3b-f75e10e20b42', '14e05d24-e115-40e3-acf2-3f27d0b2cc34', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('19481c22-afe9-490f-b37f-ac64897c7eea', '14e05d24-e115-40e3-acf2-3f27d0b2cc34', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('bdfbd015-e059-434b-ac7f-de20f32a9803', '14e05d24-e115-40e3-acf2-3f27d0b2cc34', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('849f85f9-3d72-4627-82d9-a0fbc7c84f32', '14e05d24-e115-40e3-acf2-3f27d0b2cc34', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a07dc97c-535a-46cd-854e-a5646097a024', '14e05d24-e115-40e3-acf2-3f27d0b2cc34', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('20d5ab38-ef17-426e-a089-ab149dbe4fec', '14e05d24-e115-40e3-acf2-3f27d0b2cc34', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('ba812625-8732-4753-b881-99a413960eff', '14e05d24-e115-40e3-acf2-3f27d0b2cc34', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('f47699da-1f45-4a4b-8715-59df008ab691', '1ee6aa13-7bd3-4a72-a0a5-a8d8a576d554', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('48de75f2-1998-4234-9ef7-2af428448a04', '46bb6626-879f-4dd0-9bf4-ab3a9222da44', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('82d4a317-40a3-406f-9369-2b62035d7a9a', 'e85a18c7-fc5a-4a3a-a068-907eca670483', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('4116362e-1f6a-4f2c-bac2-30bd22b0a261', 'e85a18c7-fc5a-4a3a-a068-907eca670483', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('13c92d4c-7b3a-4c12-abee-9eba365caf96', 'e85a18c7-fc5a-4a3a-a068-907eca670483', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('455ea1bc-1989-4344-8b7d-0bbef1a071bb', 'e85a18c7-fc5a-4a3a-a068-907eca670483', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('f4ecfadb-addd-4b5c-9b25-38243f089394', 'e85a18c7-fc5a-4a3a-a068-907eca670483', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('150a6179-8aab-4575-948e-939feb0bb1b0', 'e85a18c7-fc5a-4a3a-a068-907eca670483', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('8df450e5-bdba-4eb1-b9c7-1a82e01f53bc', 'e85a18c7-fc5a-4a3a-a068-907eca670483', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a3434e0b-a281-4173-8c88-00cf6c844611', 'e85a18c7-fc5a-4a3a-a068-907eca670483', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('00262c8c-0bd9-4291-ad03-7228a6c4d441', '4c3a9c69-62fd-48c1-a35b-1ae692b42a5b', 'keyUse', 'ENC');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('20ef0b05-ccb2-48ae-b8bb-0794b5aac3d9', '4c3a9c69-62fd-48c1-a35b-1ae692b42a5b', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('5deb9433-00e7-4861-b2ee-38496615c1d9', '4c3a9c69-62fd-48c1-a35b-1ae692b42a5b', 'privateKey', 'MIIEowIBAAKCAQEAz95I27TOU/r4XeCjpZKRqp/Dkrkgw0ByFOquUvovvuLKtI9kY2Hm47kiwfwktQrgLGaHTk9MiDHd8Do6bXq8SYmpOP5i9DlITsZKdsXdQPmYOgJWfR9/X1GiMwK4cCsPPO31YLlrYqDVh22B2HgsBMhLgrWKnl8C5ee0ECexXFV60pYRgejWOi+YPun9JGm0eK3KtiL/iNcqPEVgnXghofPOSx97lBnSgWDYFjLqdRMrdKqLfD0UeIcy+3sc6X8eP9VtJIl6TdTprUq5Y1BpyggCaOZ7pv0jC5c5+2dPj/73+Ed4raNjFHTgXfnvUnNfZ/Yi+iMc/yFX+bRvbOw6dQIDAQABAoIBAEK4QuN+W9GZ1xluzqgI7Qd6o1AXatww9c0f7JdGpYecDNs6wUqi9HS4il8AWxnfJUgrGpf4nQSEGQwP7IwSXpgt/uqDwGhKcJqUS/dmmBdQZduMv40GzJ/gOHMuFtwt/gSdDmse6Mht/kurSwebvulEDvSj55vgvDHmFqYuz19mneHp+9s45fkbFuAygvgEHHf6RPtE1xUNjc0N3Si4nW2CHdTdR1WDwC8AmBOJKT5lnJ62cgKfN7CRoocZ4jF2rMFgJYWRiBsu1IxqZxfmnUYRDG6Up/vMy8V5K1XbwI1pXN4eAAYpT8pIEbnSJokQJmI0U93hlYHjhZxEf1MWtqsCgYEA+lqmug17oDUQKtO+Ffbg9P790hyXcwX4jthUhAtLa2quRlCOFPFh5gy9c5xRZFH6SA1Cn3qcSS43RUCRZ2W7Mw+8JIV5bS9wIt+pb2gYIHoRGHjdhPZBHPzo7DJRdurhFiS5fS+kNVR6KsDlKjZJR8z9aUMZ7dg028XlNK1QXkcCgYEA1I5agBsYrr1DypNk9zertMhytuHAVm9/30XWK6AqrXbYvYIiHe3WDc3dVqljrXzeyfogIQFmcqKYRwxa4SVKvYULvvPpHhr02N9f1UMd/C7zIQXr6D7HNohqyZ0pwFC7TXHxAdY5eR+COjASG0OlvTP4EtB71pRvLYIdjDsjk2MCgYEAxGlKVL0vOElpHbBxeRnu80b6K1VzHDKbBraB1/ZkfSl9AH1CevvFKo7kM0d4M5R9HvoIQsYWxvMTOammadBORYkauixdT2PgPfvrGhQ4mYIq12A7qozoGK3yrxvq/bjYTl8Rhz1RPuW/0rrzD2L3qvUP+v1B4m+1SJbBc8plOxECgYB2cf0sde0DMqScNhaFTJh6XVjPYG11vRxcpuX52X7uutN8hw/L7cTiXF2C9VF+U58ynhdZTRZxuvlwXgomfElx4rnw5qp5BDx8vb0Bci07Yk5JkKss+A667LnVL6cca+Bz/5J1m5LbVBuVoUP1vXSWQmdy1IqtwHlTurYMdsgUUQKBgDjfPyY2Mu8YoyH3k8VpsMzWmpW2hmiCQLB7TfHUieGZIfh64NH4BvksLyHuQUnw0nMKydweEOvf4PBqJqpxGAzhedaUnK16dZ1KunO2HTsJshuE83hvRWH+gqqwWlwlOozaMEh1LUFkfGA/iXks5q5heAM5MA64FbONmaHR4yX/');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('8cc0320f-2716-420a-9e18-42ac6d65dfcd', '4c3a9c69-62fd-48c1-a35b-1ae692b42a5b', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('912cbc81-8a0a-4a0a-b88c-78c35ad3e55c', '4c3a9c69-62fd-48c1-a35b-1ae692b42a5b', 'certificate', 'MIICmzCCAYMCBgGQkb4eszANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwNzA4MDk0NjE0WhcNMzQwNzA4MDk0NzU0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDP3kjbtM5T+vhd4KOlkpGqn8OSuSDDQHIU6q5S+i++4sq0j2RjYebjuSLB/CS1CuAsZodOT0yIMd3wOjpterxJiak4/mL0OUhOxkp2xd1A+Zg6AlZ9H39fUaIzArhwKw887fVguWtioNWHbYHYeCwEyEuCtYqeXwLl57QQJ7FcVXrSlhGB6NY6L5g+6f0kabR4rcq2Iv+I1yo8RWCdeCGh885LH3uUGdKBYNgWMup1Eyt0qot8PRR4hzL7exzpfx4/1W0kiXpN1OmtSrljUGnKCAJo5num/SMLlzn7Z0+P/vf4R3ito2MUdOBd+e9Sc19n9iL6Ixz/IVf5tG9s7Dp1AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIM6pZshYKnORT0TPRVcW580hbb0w+RuJQ+o8+2jSDLxaSEYpBdTNduoWrRNmqDvBeoXsOCCUu9TodVrG69CRMz+xlp4BvPIXyE2lRgp69W8nLheQwHQhiJPsDTIM0wRACq/B7hzFgINslO7pd/3+Y3JxM3vGvpeYviyE1P1RYfaDGfuPLNcUi5go75Uan87XHyg8UKyK1kg4M/iOgDFp9LZS6V3QzF2igCU8Zw5yA9CAQqn47P6L2x99lsv4bxHeKwHO7i/8We1C6tIS1i7NBJz29cIIEUEtqIiMohGB5kA/75yRIwoKENdiWzB6lBQ7XQ5KOBylBg8RhTObItm1ww=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('853b3158-2acb-44cf-84af-4d24ec88e424', '9c2ddf6d-ef56-48c9-b80c-eb7951f0f8f2', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('f2c12865-1d27-4e83-afcd-c689a74832e6', '9c2ddf6d-ef56-48c9-b80c-eb7951f0f8f2', 'secret', 'EMrjNaLWt6h2buHLuv-WVNnWcuPB1FgHwC71mQcMhr8wr-EkpFe03C_IB1Os7cpTVpLuRfI5H2iCvS8jONDRgFTgxzm2A-7FC0xnpXf2jGbNwDwI6uhbYUtiWPVJK12D-CAu-uyZjUqa6-9-WUInd7VyQiH7HrZChmvVrlyujA8');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('973e9a23-3316-4457-b902-a8744ae72f3d', '9c2ddf6d-ef56-48c9-b80c-eb7951f0f8f2', 'kid', '12d9ec6a-a7a0-46ae-9086-177a3b2a3565');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('5c770df3-5e5a-4de3-8a1c-3d93de246616', '9c2ddf6d-ef56-48c9-b80c-eb7951f0f8f2', 'algorithm', 'HS512');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('67538007-27e7-4404-8491-4f2d8e52ad5c', 'dc7bf955-6dbe-4423-999d-f1498d7e1ba8', 'secret', 'iNpt6T9wScIklqYF1lv9Eg');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a04622f7-142e-4a70-a8d4-7443539b63b7', 'dc7bf955-6dbe-4423-999d-f1498d7e1ba8', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('57b2c661-7fca-4e3a-b0b0-af39550bd03e', 'dc7bf955-6dbe-4423-999d-f1498d7e1ba8', 'kid', 'ac410e71-aeb2-4d00-902a-b5a2677cd2d7');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('7ac99de9-11c1-41e0-b23c-3a723c643ec3', '6747a13e-4bef-4343-97c9-f941271ef79b', 'keyUse', 'SIG');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('2da591b8-e5eb-4607-9881-226011e68e1d', '5b72ee9c-2fea-4acc-baeb-ed9c0a8b44dc', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('1c287c31-5df4-4f09-8820-2ec222847f4a', '6747a13e-4bef-4343-97c9-f941271ef79b', 'privateKey', 'MIIEogIBAAKCAQEArZekYl8IJHUujdLvr8ytho+A/viYEHlkssDav0rAtkiaR4JAWwiAHQovQVLsWkfNYZQ+INw/mFcqmUEXHaVeTaeavp9iBnHlZbqAHTHwI9zpjAM2pZucdL2cR25fcGnhKm2oLW8cVsdLAxaED1pxsD6OvssAQf9oUU9Ap5yE8BynVWW5HMd+h3xSp3VKAtoNj3myNheZU9TcDFSwfacTfSs0D+Vj4hXZ1YfkH0y+YKbggQRXYBbNbautkru/L3YZsnqrIaLLCJTFq69vTwde61bd2lU6f4sCYAwjIhVXc3FGIwDI91tGooVzBsA/jSAvCrDlmrmV6Km3EiCLUpvldwIDAQABAoIBABwFHq0cPtG3soCE/FhpltbiAgXl9ZGvLpBl7ckz1UB3HqQNQ7sN97P4SWFnc6ws69tk1NR0CLXb2A3twj/wSfUJ6UH8sxNsPgV6IaTUwzjetzn46NC5efskAf5LtA8OoCA7nApdZXsiZxrD/yQFStWSe3MTjGKayelZ/AsyCglBqrAyRg1seladbR98C+ss/tVLS02/2MuNsVZ5lcmayItT7xSbyS5uj51AcyktRzSl2GFQG71bGnZ3lPhQh0Ih0tDdG31fznX0sxfsCEp9GgNN9LzkfmTUydGB5IQefak3KHai86NbICyvoF8Wj2rYm8DN2Vtcvjf2/Dxun7sZ0m0CgYEA2ZGoTNDmlO7OuwKDpalqbh/IHoBDno3uozWRLB4Y8VvpJS/vdJO5NOz3jmscvMqZFJResLCfeHCCpZMN7Y+TjvY8o2G2gk77fL8C1p6QL/7OYKpZX/xmtemIIqq0x2RPBAl5uFlS5lqRNB+6hFXP7mmeEALe+k0294xyq1C0f/0CgYEAzEFjLNO5hUXfDSyFPYSfgJk0qoq8evNulGhjp4gEFKXWourgzRgWY++XpTKoiYsv1U9oXP9IGRFj8p7azhAx/exE5P+4HOFbBFnNGqGAHPITYlEk80weXbXdvz84ioxyKZDcKFy4+Z30JcP4ZZ9yEdD8ti0qauZOW8ik4XprM4MCgYBCv2cMugIjqugNg4Xz6vfV9TYl9V/JYu3VcHerO0iXs4ThfcVO1Is7a3+/V6knWliAccxjFKy3/Hx4Y5cgTK4ObAjKbw3ZCHYrHUa3pUnDD78s9NYalorEQHMdf5WannGHYYjQP8cpGJv3i8xjERiLoid17guOauX0KEh9unLF2QKBgEkbakTkLzXdcV2Evtfq/TAJJgmYiKe1M7IYvvp6u4MsbGt5iCbAZVs1qWBuhlZcpC1EM8V9da/LQqvXYdd5gnsxMuOIB70GiA5BmiDbB0DVAE0jYAdZClFeQ9Us6q7kYAQyniowLeDiQT23K9QrwqdP1vPZrKIAdrFxWlp995rDAoGACY+YXe8QPu3dFT66T+CZKzUAY/sZOmxjZTKcqzhJdpMZZcUpy/Xi7H/bm56VX8ogJb8OUYFDJ/h8Uz/brTn4Ic7qJzw1H1Y4Myhf/UJzVs5kRQDP5e16T2XOfHuiTY5/uxEUSDk4AHjLpYjay9kmrN12In3eiwSI3E6HU2pyDgw=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('de11ccbf-7d34-4e35-9be9-331ba5632022', '6747a13e-4bef-4343-97c9-f941271ef79b', 'certificate', 'MIICmzCCAYMCBgGQkb4d5TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwNzA4MDk0NjE0WhcNMzQwNzA4MDk0NzU0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCtl6RiXwgkdS6N0u+vzK2Gj4D++JgQeWSywNq/SsC2SJpHgkBbCIAdCi9BUuxaR81hlD4g3D+YVyqZQRcdpV5Np5q+n2IGceVluoAdMfAj3OmMAzalm5x0vZxHbl9waeEqbagtbxxWx0sDFoQPWnGwPo6+ywBB/2hRT0CnnITwHKdVZbkcx36HfFKndUoC2g2PebI2F5lT1NwMVLB9pxN9KzQP5WPiFdnVh+QfTL5gpuCBBFdgFs1tq62Su78vdhmyeqshossIlMWrr29PB17rVt3aVTp/iwJgDCMiFVdzcUYjAMj3W0aihXMGwD+NIC8KsOWauZXoqbcSIItSm+V3AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEiAt/fMDWs15xk7joFx1gXLXf+YGjKh+kn8kV2KKZvNYOxU/MEWoaeVXXCHAapKNHRzBpuil73a85hpUF1B8lS5nnsRLW5SBGZBUcntxbtkT7Bq4qQCWD8hlYp7pI4enTNoMthNPBqSKE2253MAjhj78bsliWhVq41Gz1btsh++zr3/la575XdFDv4TbaSpV8I9IYWon25WLpGuJtyRF6Z3erseZz7vG345tJebD/b0ZFIascaVxUrlemtGFOa9kD3it3QFKzGYW9xlhhTGKtmdHvrTrpqIRxM+cq2jbCTLddFKIQhDYxYOKyQbirvo6QSOa3uhH/6UN+4TI7uh9qA=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a8ce2800-0be8-4d18-8484-38b986f7990a', '6747a13e-4bef-4343-97c9-f941271ef79b', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d88dbe68-dd2a-4fea-b516-87d46748065b', '8ca422d3-1614-467f-a230-b9f8c04f9edd', 'kc.user.profile.config', '{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('4fc47372-3101-441c-8931-94dbb481bd6a', '25a8527d-63f0-4b22-9669-fcaeb4e05316', 'keyUse', 'ENC');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('9fa6cd46-7f10-4a5c-84e3-eed599917ffe', '25a8527d-63f0-4b22-9669-fcaeb4e05316', 'privateKey', 'MIIEowIBAAKCAQEAnNEI6OyHEtGcf1xW0N5vik6vYRvt3Ddym/e2DgRwOucL6/447ybCTKrNQGOZV2G1GInfbU1hjb7hlScJt3lSWg5WYiXmNlCgHgjZDcHGNiKLpw/z1yuWrV+Om0zm37e+zAj2Qi8lAy+lLNpYuijaskxj79NohB8kHxJRVZ1NZfBEMBwcUIcMkJBUpfQyYZApvaQhkHL6SVXRnvkj6Ogh/jiG4QBOsAPH15YBquhkRLzGeuHQ7XSoD8pk8ZjO3p3vA4CM6oVDq2CXtFSHKkjhHU/m+5KEHt3p5o2OEOcRoOwSBZ3xR663GOD+O0p1us+jKVgWzJK/BIc3+jbnT79CyQIDAQABAoIBAA0nmWNdrRaKbCIAc11t3WY5I8vmAYHwyk3UXaqnG2mLhnPfZXQFWLUA+nsRZ9R9UylZ7nrPLBTti2OdTNq95Ac/Luaolntdr9LZK+kUJV4W74deBpbZFpiYXKCBNthTQ/9+bHcAmK6f3W+p6NnD8dWVZChDACBeMuPi390KVyrq9zbo66MK3Sk1QrmYaL3rc12Dr8RXWtfUHGMrdvvW2G8FtqVzgCH3NvhRL5b32i7SCjoHxfoUtAFyYqgcYKzQ9HSPZUfPvmdR9EgoTNgWIgAFRWh86fRRf27XdhcOtxipTW5KUg5j4+d9oma+3BKZExG5PuXVxHRnrhvGeRtC6GECgYEA2hEfierXVIzFul29PCCB+OAB2zLY/psmtu6lgKfH8mB2jP8HLWAhYblv5Sqzb1V5YUmiNiZXdJeqoNhXMCLfBsjigq2WX0fINwpr9zgEFpuIlHnJzrpwkJty726YvTI9oZr5aXiC0A5eXaqUlPez9SdbjCg2xubo5ICbhQLrQWECgYEAuBhVRXGLCfkA5Tlz9u505To6IqYHT3vrKqvFKckd5D6QpkW7qOCrbOi2pL6VidHpJ6QdMrjhQWicdrltukSUEldMCiWaSjsUAp6N5Kv/HQCZUxylZafJVUvUpvrh+2edLS1qLG0Z4SruAy3kWmG4lhOew7dMRNkD6f6VMMFMsmkCgYB4y0lsLXFQPZZ98NUVTHCSuwtsL9Nx3eHpLXLyPH6OrY6d9ds08G4tYvovuKKixncxRAed9Uk2pZj39j79xCNE79xBRQTqDKpEivpZfGcPWuKiVIBMiow2HlXheaMUEpN/RIhqOz5DH+J4AjjB+CBwaXfVwKTvMxPJF9COMpq8oQKBgQCNEyiVVNOFyumiv4pcWpP97ccLMkw73uxyALvQr6xWcpOKt7l9St5TUWpViS8zNEcF97/gVMlZxH7ShHrP2SnXfEprJDG+XNOSxkpaSGvxn7nfdP5Sjme9E6VcaLmwXNCYBEtuzBSe9rT6frqVgHlhmJt7xAWQZPWY5V0Sxa6usQKBgE6xK9hINxvjagGXI78kgFk2M3GiZBR4AKcTV1Y9LkslKlojP1aWH6WEoZrs7uOGc/qNA8kQzX9Bg+nCcZQTTmfCIuVQZwiQLw4AYHtufIQmnct0KvfIHkVn9MDag9l4yUxuBWCQDFtTGD4qdudih7EgPZLPfZkkBaJ01/TZ4Zi7');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('e9ff0806-1dbc-48f5-9011-632e410eb0ef', '25a8527d-63f0-4b22-9669-fcaeb4e05316', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('30984a01-533a-48de-9764-9c1f1e9ea126', '25a8527d-63f0-4b22-9669-fcaeb4e05316', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b81a94e2-fe92-4567-afd4-ad930ae93a61', '25a8527d-63f0-4b22-9669-fcaeb4e05316', 'certificate', 'MIIClTCCAX0CBgGQklaEsTANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANhcHAwHhcNMjQwNzA4MTIzMjQyWhcNMzQwNzA4MTIzNDIyWjAOMQwwCgYDVQQDDANhcHAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCc0Qjo7IcS0Zx/XFbQ3m+KTq9hG+3cN3Kb97YOBHA65wvr/jjvJsJMqs1AY5lXYbUYid9tTWGNvuGVJwm3eVJaDlZiJeY2UKAeCNkNwcY2IounD/PXK5atX46bTObft77MCPZCLyUDL6Us2li6KNqyTGPv02iEHyQfElFVnU1l8EQwHBxQhwyQkFSl9DJhkCm9pCGQcvpJVdGe+SPo6CH+OIbhAE6wA8fXlgGq6GREvMZ64dDtdKgPymTxmM7ene8DgIzqhUOrYJe0VIcqSOEdT+b7koQe3enmjY4Q5xGg7BIFnfFHrrcY4P47SnW6z6MpWBbMkr8Ehzf6NudPv0LJAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAF6mhjZOrCHn9y3ZuIapU1vNEN/G9WKnmwfbu97kJzaKCDb5iIgIN0/+gbaaEkPW4ZOmfnO0pQEEZE/KCLVq7fWyCst1t/VfnAJGU/koSm36aloToWM8Qcmv9j6zAAWs5Z1obKD4EFK5iY+wsSiO2DY0mNffBE2kDo+pXDik/b+CXi2mhhDtdNb1CJBKI5dnlGvPCPIqt7JnwMvkr1mIJ8LmDn06Z7UnJZje2fxbRSy8+wNmGTTLRyCeTRNLGkAC9bN1MXEkHCVHoGeiSoOL5+5m67XYXXY5gSo4BiQ0Zfg0rhj6OVhJTbxo6rMLvHU6lxeh21lD4h+Dd4PlPTKq6N4=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('bcf86ce4-9d81-4728-a5ec-14b31e48a210', '7eff9031-5e04-42cd-8457-785c102ab405', 'kid', 'e2ce2d35-9dbc-466e-a3b4-b7bbb010d428');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('7c006624-db2e-479c-a23c-07f22c78f274', '7eff9031-5e04-42cd-8457-785c102ab405', 'algorithm', 'HS512');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('956e1767-0855-4d75-ab23-24462e0eb371', '7eff9031-5e04-42cd-8457-785c102ab405', 'secret', 'IU5CtmrlySbY5f4nRHaAGx_9KkcX7Nv81ZeFyxIQZ_7mk_Eoh2e5gAx-8OYRceegpdpIEu8PORj_H_81G6-GoeDqxxQDEvpj7pZpQhhKYrVKfzCOnvAWKcrIbHhsJ1IZ8OFdbMhvy8tcxnaXVTIGakzl9QnwqXBljOUeGrl-LuM');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('f414935d-936d-415c-aa65-c7303e3705a1', '7eff9031-5e04-42cd-8457-785c102ab405', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('2445e186-1831-4a63-b818-419bb48851b0', 'b65a7503-9a41-4775-8746-9cfc73dada17', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('7c6c1da2-3a4f-4b5d-904e-9da243ffecda', 'b65a7503-9a41-4775-8746-9cfc73dada17', 'kid', '960bacd5-66d3-4400-9bec-d7ad9eb068c0');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('2037f07e-ac75-4fc5-bd8f-f7c7f1d237c0', 'b65a7503-9a41-4775-8746-9cfc73dada17', 'secret', '3mRUYm5pEsgJX3Kvp3MIEg');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('694213c1-98d0-4c69-addc-09b92eefea35', '5b72ee9c-2fea-4acc-baeb-ed9c0a8b44dc', 'privateKey', 'MIIEpAIBAAKCAQEAuM5O8ckgtFr0H6mTHNvCor5pnnt27hwd5BBaay0qEkqazACfPm5A8+bxTKN2LDkbtgauSkuxtICNbNGLtFAXdbXZbU7IIe3Jw/CUPmCMTEo84MqL4egdmGW3FZvkOszLRyZaKRVUwxeP0QTgcNAV6BernRC2OgzaDkUQra2LneBBTCJxu6/oyuRY0qGTG+c0wStGxAX8yT8Vqe9UxSPskjE5rG549pfxsoIo20wDhUzARIzlPdWY7h+vaaGXz8BS2Rv3+Xd0VEqDk5EyGoHSVhdK/chnaofh6BXGoeRvogdjLh5HO4ArInZJrD8UXcSZk0bK1A4Gtm06/W8dueGgmQIDAQABAoIBACPQJTfRWnNhCdyF6+Kkir4niMfD1NsVW0yKR79rz/Kd/wwIFdQPISqy5zGLHtg4k/BtMILo0s3wOJftLrXZbIZs4G8AnKOIlXhRa6T/6EhTfaMxVTTI2s1g7r8zB+JGNCF8Yu4BunyZGQ9wMr9h79Dbn2/vYGT0/x/TTgVeM4d7LE1faKg/sdliwcX1+1DEt6fc9Gs4gmFO0zEg0NDRqKiUT1I5Y5M2EBODgXC62aDp2P5ZxA2sfsjVzS5rR1IIlnY8glZuirivWpCbCRkET6lhMsgrCSBWYKwWruvQnC7TdottmI7Xyacuk/18eReGoMNAeU7N0nlE2vS7on6lGvUCgYEA83uCTPW/hdYYNnN33EtWnInLISCz750enVz6PdcKRKZPbBCfa1SZzOmyx9h817+GsFMaP+BEIArkDGyEs8O+MeihhBUXQOn4WC4UBctRdyGLqjzZ7PKghkQs1+vF3t3MEQxR459IKN+MdjZCktPQu/n9Y3juLQHIoxRqtNwN9M0CgYEAwk6NfNdjULKEziLMI62WKh3f6DIVojPRUrlFdP2Kgsg//8yQhmWauSEBeGDchJBxjPAyqg2hGtkh7Q0tyaZjYv4dfJsuzDtO37POqgC4HZyHT6JXgYfsas3aysV36CI3WjzEB3vHcRINkOvKReJOhr/WYZSUXi0YVLHUkTchev0CgYEAtX6Xfm6hOU6B9fTUn+24vi8or6UE+9QPAhZQotAs40dlZJRvgT4q90gs8DM7vEcUS1Nm+b5eidQUcf5iXO3IVMOnwiFGmCjP6ktOuZL5QuhKh7ecarfhWLRxCPLDKIIEn6CjWh1dWLpqpaOEtJYXvkd2zjNSt1HhEU8iy3ZNIPECgYEAmB068uMD4yb+hQoE2mGIz4v3wCWFfigm1SYp0/6xMtVmFPGmqzBbwlauefkKadVSr81TPIHS/9vAjX3lvJm/8L2Tg/tQ1Z4Qj1yKi9hoSvZBj/w9mTA5yxtBD8Err9UplEFCDcG/Tyuc5zlQbwlOBHumb1oMFPYkuBlHmi+YzFkCgYA8TT6umv3U1zLKYbzUViENVcwNEg5ANUsF+hYDUsGpYd1/dXVxlJbtZoE3HP+fmTBlK+3QR4OSUs5UQLpb4QoYoK1h/v3X4f52SH7R295HlEYKp1i/CghkGRx7SwGwCv4zQwLsMaR4E4sjEemu75mWJH1rwFxo28bdC63pauHc2Q==');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('7b2cb343-08c5-4b6f-a0b4-00f1ee8243dd', '5b72ee9c-2fea-4acc-baeb-ed9c0a8b44dc', 'keyUse', 'SIG');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b4a6b151-f203-43b9-b67a-d82cac1cac20', '5b72ee9c-2fea-4acc-baeb-ed9c0a8b44dc', 'certificate', 'MIIClTCCAX0CBgGQklaD2TANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANhcHAwHhcNMjQwNzA4MTIzMjQxWhcNMzQwNzA4MTIzNDIxWjAOMQwwCgYDVQQDDANhcHAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC4zk7xySC0WvQfqZMc28Kivmmee3buHB3kEFprLSoSSprMAJ8+bkDz5vFMo3YsORu2Bq5KS7G0gI1s0Yu0UBd1tdltTsgh7cnD8JQ+YIxMSjzgyovh6B2YZbcVm+Q6zMtHJlopFVTDF4/RBOBw0BXoF6udELY6DNoORRCtrYud4EFMInG7r+jK5FjSoZMb5zTBK0bEBfzJPxWp71TFI+ySMTmsbnj2l/GygijbTAOFTMBEjOU91ZjuH69poZfPwFLZG/f5d3RUSoOTkTIagdJWF0r9yGdqh+HoFcah5G+iB2MuHkc7gCsidkmsPxRdxJmTRsrUDga2bTr9bx254aCZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABH0sA2wQXZbRwD7AGKKvyV3RpnNVRwoL14qBtklPixXEdqmcO9MrKKIR8bY0B5tXiTw6mVGem7jbL3rVnTxQbiAC19XJOZrsTMvT+ppjbCAy+K2ck+Yh3BrzKzW2mVDjpL/XkXRLfVjtN1dYnsXnxxH02sbK+bJyq2XUqPllDUUmn1nCtKks1a+hpoLpe2Ox7JGkg5JNw7MgVIcIElQMfZbxnpt5eS0dzPAamLCtVyC1fDSL1ehEBzNyQJKhSbSJoQOF7UnSRpBDXhj9RCutPkXuts2Lh/strrKnoi7H4KV7kGuBLPDSovwUKRLZVKZWwP+Y7jC3/LZtN8Vxxod4k4=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('606a260e-52d0-409b-b46c-ea34e19e3116', '371ebf11-ef89-422f-8b1a-3841b4a081a9', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('3eddf532-12e9-4e94-9aa3-d40c1da24051', '371ebf11-ef89-422f-8b1a-3841b4a081a9', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('2429348f-4328-4399-8e1d-d3943ab31c49', '371ebf11-ef89-422f-8b1a-3841b4a081a9', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('0c661b72-10cf-4cc1-af4a-c0a2924e0bd6', '371ebf11-ef89-422f-8b1a-3841b4a081a9', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('8bfa018b-6b6d-4ffe-b390-dd9096b2d294', '371ebf11-ef89-422f-8b1a-3841b4a081a9', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('214a1225-77ad-473d-a32e-1b4d6cddd4ad', '371ebf11-ef89-422f-8b1a-3841b4a081a9', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('55cdd537-0f3d-47d7-a48a-1847b10c3017', '371ebf11-ef89-422f-8b1a-3841b4a081a9', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('2cf4a766-7e13-4242-bca5-fca3a74e0236', '371ebf11-ef89-422f-8b1a-3841b4a081a9', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('149b94ca-0fe9-4804-a9eb-5b8cdb3e442e', '3056cc47-a7b0-493a-ba5a-6481d76e7d00', 'max-clients', '200');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d5c282a4-b054-4b40-87f9-0a3448780622', 'a59992a2-773f-4a77-a699-40cec1dfd847', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('73d0fe53-03bb-449c-b7ff-682da3c0e246', 'c435bc55-4529-4b73-b772-3c3ffda595e8', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('597dd51c-5dd4-40cf-ac4a-48a4e0fdff86', 'c435bc55-4529-4b73-b772-3c3ffda595e8', 'client-uris-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('c89a266c-65e7-4b1f-93ae-359124d0de09', 'e020f479-3624-4ae8-bde5-0b510a1cc765', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('5d90e081-1a4a-461a-a981-2d917da7dc7b', 'e99b432a-43c6-4962-9eea-24556ff352ff', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('601c73ac-31d8-440e-b05a-b443a9468b29', 'e99b432a-43c6-4962-9eea-24556ff352ff', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('c11991dc-ca2f-4ddc-b0e1-b2e8a02355cf', 'e99b432a-43c6-4962-9eea-24556ff352ff', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('076bc7ba-0a39-4be7-b3a4-1389b621132c', 'e99b432a-43c6-4962-9eea-24556ff352ff', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('fb4b54fc-f958-410a-9e47-b0a3ecab482d', 'e99b432a-43c6-4962-9eea-24556ff352ff', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('78290fa5-b706-43d1-be32-0b49742967a6', 'e99b432a-43c6-4962-9eea-24556ff352ff', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('66d9e351-4d99-4a38-87d8-1617d736e80e', 'e99b432a-43c6-4962-9eea-24556ff352ff', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('ed5f5335-8c7d-4d18-9db3-4d8c3e705ebe', 'e99b432a-43c6-4962-9eea-24556ff352ff', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b73a5793-8cc2-4947-b006-5a2da87bcca1', '409b675e-9002-415d-b1b7-19a45b04246e', 'kc.user.profile.config', '{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}');


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'ac915b80-4504-4e66-ada8-b719c85d9a97');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'e69b322c-1a3b-4ab4-8717-5089fefcb3b3');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '5e32c472-2079-472b-981a-88091a240aa9');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '6e4ae26a-5322-4d8f-9b12-b9599627aa57');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'cf9e0dd6-a527-4f34-8d97-ac352f480213');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '40dc7891-7dfc-4d40-9ddd-8ca970239f02');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'fb28083a-72ea-4bb2-b286-998d649cf616');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'adf48263-b18a-4d4a-8d12-3f8c65981bef');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '7bf6dda5-4624-4914-8a2a-c1efdd609bb1');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '3fef1f81-f7fc-445f-8e97-d3c4c772091b');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'b40ce2ad-ffb0-4dea-833c-ba9700f94463');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '98fdadcf-d0d7-46fc-8f5d-2b2f4cc5b2ac');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '4a6eb794-fe2d-4145-b2c8-82941f438dff');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '987e2870-a091-4935-a12f-3f003b21fdd4');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '3599bad4-bab3-417e-a345-9b86c28d5af9');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '223a13b8-384e-494c-8ea6-234822d2c2ce');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '2891fc6e-2c08-4a53-b49c-e439ada98c9c');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '8603eaa7-7f48-4e33-af13-d5f1d753cc7d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('6e4ae26a-5322-4d8f-9b12-b9599627aa57', '8603eaa7-7f48-4e33-af13-d5f1d753cc7d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('6e4ae26a-5322-4d8f-9b12-b9599627aa57', '3599bad4-bab3-417e-a345-9b86c28d5af9');
INSERT INTO public.composite_role (composite, child_role) VALUES ('7e2f0283-751d-4a2e-bc21-7726beffc34e', 'c2006714-2dad-4c5c-9052-148930b4d166');
INSERT INTO public.composite_role (composite, child_role) VALUES ('cf9e0dd6-a527-4f34-8d97-ac352f480213', '223a13b8-384e-494c-8ea6-234822d2c2ce');
INSERT INTO public.composite_role (composite, child_role) VALUES ('7e2f0283-751d-4a2e-bc21-7726beffc34e', 'd20d1b7e-be89-40b3-978a-f92b9a49a4df');
INSERT INTO public.composite_role (composite, child_role) VALUES ('d20d1b7e-be89-40b3-978a-f92b9a49a4df', '5e29755e-99d8-4496-929c-c066b11bbec2');
INSERT INTO public.composite_role (composite, child_role) VALUES ('b49c4c65-cf98-495a-a462-61c5c61116bb', 'd826189e-1660-4494-b7fc-2dfb66705308');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '8623f6ab-35a5-48a7-8376-ba1ef2948bcd');
INSERT INTO public.composite_role (composite, child_role) VALUES ('7e2f0283-751d-4a2e-bc21-7726beffc34e', 'cb1dba1d-f358-4a7d-a8cf-3ed7578e2c36');
INSERT INTO public.composite_role (composite, child_role) VALUES ('7e2f0283-751d-4a2e-bc21-7726beffc34e', 'e222ae1b-5d38-4af1-bf81-5d12b4b277e0');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'b594a449-8b15-4223-a698-560f86a16eda');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'b7b75367-19f6-4ff4-97b6-06d7c10a3235');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'ec021be9-50d2-4a57-b295-dce2c10ce220');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'c36177b5-c4ea-4556-b079-d2571178ab12');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'e11ed994-d2cb-40d7-9f54-42370f7e75da');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'f18740c4-70ef-498f-8ba7-cbeb1b665696');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '738b8dff-3a59-449a-8247-fbe5d572bf4d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'a8bf7fd1-7b62-42a6-a73c-b799e4660cc5');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '8f7554bb-b099-47a4-83a9-75dec22c5f89');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '9aa232f7-7ef6-4404-8d16-4fb5875987b2');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '45f501ef-38e8-4190-abde-1f2f56a9dab5');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '16c3bb3b-111c-4808-a113-f6b9a00f54a3');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '83d531ff-af1d-4b08-b517-6d959f4f840c');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '3e4bb3b7-05e0-4998-a5b3-1ce558a0ecbb');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'e1524005-7a12-4eaa-a449-a8b42b71ff91');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '7e8fd0ae-3a6d-429f-8196-717bae270e3a');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'e9786630-4eb2-4989-a593-1c9c674c62d2');
INSERT INTO public.composite_role (composite, child_role) VALUES ('c36177b5-c4ea-4556-b079-d2571178ab12', 'e1524005-7a12-4eaa-a449-a8b42b71ff91');
INSERT INTO public.composite_role (composite, child_role) VALUES ('ec021be9-50d2-4a57-b295-dce2c10ce220', 'e9786630-4eb2-4989-a593-1c9c674c62d2');
INSERT INTO public.composite_role (composite, child_role) VALUES ('ec021be9-50d2-4a57-b295-dce2c10ce220', '3e4bb3b7-05e0-4998-a5b3-1ce558a0ecbb');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', '578eba18-9ada-48a5-939b-3d62aaa98198');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', 'a68d55a8-a849-4c27-b9d6-f403901be4c2');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', '0f1345f7-7dde-42dc-a18b-9973749012e3');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', '7767e378-3cf1-4bc9-ab71-c9ae36dc1eae');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', '89439fb3-fb30-4b3e-a0da-360b30629011');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', 'a488d8c7-29ab-4034-acdc-44e0b55f3164');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', '3de5809c-06f5-452f-bd4d-97b531621054');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', 'b8d50b1e-67e9-4a31-957d-3804176eed8a');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', 'a5d713de-2938-4dcc-bacd-68e65cdf1398');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', 'b8217610-6295-4b40-ab19-ff04cc57271c');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', '4e08d7a5-d1ae-449b-92ae-ea4809acf22f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', 'd8a0accc-0de2-4b7e-90a3-e23ced8635aa');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', '38e3e8e6-e211-4a46-8e46-1b0bc3581f9b');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', 'acd027b6-cafa-405c-8970-9920796fc7df');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', '4f12aeb9-f524-47ac-a31a-88bbd16b8c2f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', '4d0f2530-1bfd-4688-ad99-1dd2a7cf6180');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', '85163b5e-282d-4ce1-b5f2-ffc68e2952c5');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0f1345f7-7dde-42dc-a18b-9973749012e3', 'acd027b6-cafa-405c-8970-9920796fc7df');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0f1345f7-7dde-42dc-a18b-9973749012e3', '85163b5e-282d-4ce1-b5f2-ffc68e2952c5');
INSERT INTO public.composite_role (composite, child_role) VALUES ('26d286ff-9c63-499e-9b66-56e55b7105d3', 'f0c05913-2365-4baa-9a72-17aece68382a');
INSERT INTO public.composite_role (composite, child_role) VALUES ('7767e378-3cf1-4bc9-ab71-c9ae36dc1eae', '4f12aeb9-f524-47ac-a31a-88bbd16b8c2f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('26d286ff-9c63-499e-9b66-56e55b7105d3', 'd00bb70a-48e1-4e60-8792-279582db4801');
INSERT INTO public.composite_role (composite, child_role) VALUES ('d00bb70a-48e1-4e60-8792-279582db4801', '582023f5-b0d7-4ed2-a296-fdd11ad70fed');
INSERT INTO public.composite_role (composite, child_role) VALUES ('329f34ac-4907-4d78-8029-d5611cdb599a', '778c6c16-512e-4115-82ce-ce90499c530e');
INSERT INTO public.composite_role (composite, child_role) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', 'd6769e7f-ecb6-4681-a2b5-5a3ada22d10c');
INSERT INTO public.composite_role (composite, child_role) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', '8439fbff-fdc3-43ad-b850-3d8c2005d9d3');
INSERT INTO public.composite_role (composite, child_role) VALUES ('26d286ff-9c63-499e-9b66-56e55b7105d3', 'b6aa342b-c5e1-4d1d-a96a-4f2d2b779b5c');
INSERT INTO public.composite_role (composite, child_role) VALUES ('26d286ff-9c63-499e-9b66-56e55b7105d3', '0e01e159-05e4-463a-b6e0-6a33ab037e4b');


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('5e6a9036-7bb3-4333-8767-8428a82a29f8', NULL, 'password', '261552d5-3a9f-4f55-9858-e926850d40f1', 1720432075266, NULL, '{"value":"xBvlgcHMPr/gwF0rFHU6FgHVGZ/ec3G2Q9muXvNMwPI3OT54qSmqflGr/QCTP+cXQTHWk9oR4f19Pl4GuiYgvQ==","salt":"tmEuL9DMGOG3pvohQFdL/w==","additionalParameters":{}}', '{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}', 10);
INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('f8455d77-27c0-4347-82bf-e08980ab45b9', NULL, 'password', 'c2f50965-b151-4b33-acec-9d7a5e51c2c5', 1720443465971, NULL, '{"value":"3EUCvXJ2Gvi9gbvE2pTATA9Ap8T+4a4QVsOJb1EM6LUL4oB0/JiQ5kd1M+dWE1LnzU/dbBf+jPNJtwZjhmeaKg==","salt":"TKEst0JBzQlOrMnDXQbRTg==","additionalParameters":{}}', '{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}', 10);


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2024-07-08 09:47:50.836361', 1, 'EXECUTED', '9:6f1016664e21e16d26517a4418f5e3df', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2024-07-08 09:47:50.846468', 2, 'MARK_RAN', '9:828775b1596a07d1200ba1d49e5e3941', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2024-07-08 09:47:50.902155', 3, 'EXECUTED', '9:5f090e44a7d595883c1fb61f4b41fd38', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2024-07-08 09:47:50.909394', 4, 'EXECUTED', '9:c07e577387a3d2c04d1adc9aaad8730e', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2024-07-08 09:47:51.052577', 5, 'EXECUTED', '9:b68ce996c655922dbcd2fe6b6ae72686', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2024-07-08 09:47:51.059633', 6, 'MARK_RAN', '9:543b5c9989f024fe35c6f6c5a97de88e', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2024-07-08 09:47:51.167994', 7, 'EXECUTED', '9:765afebbe21cf5bbca048e632df38336', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2024-07-08 09:47:51.174797', 8, 'MARK_RAN', '9:db4a145ba11a6fdaefb397f6dbf829a1', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2024-07-08 09:47:51.180643', 9, 'EXECUTED', '9:9d05c7be10cdb873f8bcb41bc3a8ab23', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2024-07-08 09:47:51.317496', 10, 'EXECUTED', '9:18593702353128d53111f9b1ff0b82b8', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2024-07-08 09:47:51.383985', 11, 'EXECUTED', '9:6122efe5f090e41a85c0f1c9e52cbb62', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2024-07-08 09:47:51.388402', 12, 'MARK_RAN', '9:e1ff28bf7568451453f844c5d54bb0b5', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2024-07-08 09:47:51.404449', 13, 'EXECUTED', '9:7af32cd8957fbc069f796b61217483fd', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2024-07-08 09:47:51.433335', 14, 'EXECUTED', '9:6005e15e84714cd83226bf7879f54190', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2024-07-08 09:47:51.436203', 15, 'MARK_RAN', '9:bf656f5a2b055d07f314431cae76f06c', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2024-07-08 09:47:51.439434', 16, 'MARK_RAN', '9:f8dadc9284440469dcf71e25ca6ab99b', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2024-07-08 09:47:51.442871', 17, 'EXECUTED', '9:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2024-07-08 09:47:51.511376', 18, 'EXECUTED', '9:3368ff0be4c2855ee2dd9ca813b38d8e', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2024-07-08 09:47:51.576531', 19, 'EXECUTED', '9:8ac2fb5dd030b24c0570a763ed75ed20', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2024-07-08 09:47:51.584993', 20, 'EXECUTED', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('24.0.0-9758-2', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2024-07-08 09:47:53.277396', 119, 'EXECUTED', '9:bf0fdee10afdf597a987adbf291db7b2', 'customChange', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2024-07-08 09:47:51.588495', 21, 'MARK_RAN', '9:831e82914316dc8a57dc09d755f23c51', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2024-07-08 09:47:51.593304', 22, 'MARK_RAN', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2024-07-08 09:47:51.619325', 23, 'EXECUTED', '9:bc3d0f9e823a69dc21e23e94c7a94bb1', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2024-07-08 09:47:51.633031', 24, 'EXECUTED', '9:c9999da42f543575ab790e76439a2679', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2024-07-08 09:47:51.635969', 25, 'MARK_RAN', '9:0d6c65c6f58732d81569e77b10ba301d', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2024-07-08 09:47:51.685191', 26, 'EXECUTED', '9:fc576660fc016ae53d2d4778d84d86d0', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2024-07-08 09:47:51.817085', 27, 'EXECUTED', '9:43ed6b0da89ff77206289e87eaa9c024', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2024-07-08 09:47:51.824521', 28, 'EXECUTED', '9:44bae577f551b3738740281eceb4ea70', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2024-07-08 09:47:51.924403', 29, 'EXECUTED', '9:bd88e1f833df0420b01e114533aee5e8', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2024-07-08 09:47:51.947028', 30, 'EXECUTED', '9:a7022af5267f019d020edfe316ef4371', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2024-07-08 09:47:51.968848', 31, 'EXECUTED', '9:fc155c394040654d6a79227e56f5e25a', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2024-07-08 09:47:51.975187', 32, 'EXECUTED', '9:eac4ffb2a14795e5dc7b426063e54d88', 'customChange', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2024-07-08 09:47:51.982683', 33, 'EXECUTED', '9:54937c05672568c4c64fc9524c1e9462', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2024-07-08 09:47:51.985612', 34, 'MARK_RAN', '9:3a32bace77c84d7678d035a7f5a8084e', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2024-07-08 09:47:52.018888', 35, 'EXECUTED', '9:33d72168746f81f98ae3a1e8e0ca3554', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2024-07-08 09:47:52.025244', 36, 'EXECUTED', '9:61b6d3d7a4c0e0024b0c839da283da0c', 'addColumn tableName=REALM', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2024-07-08 09:47:52.034488', 37, 'EXECUTED', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2024-07-08 09:47:52.04062', 38, 'EXECUTED', '9:a2b870802540cb3faa72098db5388af3', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2024-07-08 09:47:52.046242', 39, 'EXECUTED', '9:132a67499ba24bcc54fb5cbdcfe7e4c0', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2024-07-08 09:47:52.048883', 40, 'MARK_RAN', '9:938f894c032f5430f2b0fafb1a243462', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2024-07-08 09:47:52.05189', 41, 'MARK_RAN', '9:845c332ff1874dc5d35974b0babf3006', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2024-07-08 09:47:52.057871', 42, 'EXECUTED', '9:fc86359c079781adc577c5a217e4d04c', 'customChange', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2024-07-08 09:47:52.265915', 43, 'EXECUTED', '9:59a64800e3c0d09b825f8a3b444fa8f4', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2024-07-08 09:47:52.271999', 44, 'EXECUTED', '9:d48d6da5c6ccf667807f633fe489ce88', 'addColumn tableName=USER_ENTITY', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2024-07-08 09:47:52.278261', 45, 'EXECUTED', '9:dde36f7973e80d71fceee683bc5d2951', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2024-07-08 09:47:52.284559', 46, 'EXECUTED', '9:b855e9b0a406b34fa323235a0cf4f640', 'customChange', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2024-07-08 09:47:52.287349', 47, 'MARK_RAN', '9:51abbacd7b416c50c4421a8cabf7927e', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2024-07-08 09:47:52.345131', 48, 'EXECUTED', '9:bdc99e567b3398bac83263d375aad143', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2024-07-08 09:47:52.352977', 49, 'EXECUTED', '9:d198654156881c46bfba39abd7769e69', 'addColumn tableName=REALM', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2024-07-08 09:47:52.419233', 50, 'EXECUTED', '9:cfdd8736332ccdd72c5256ccb42335db', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2024-07-08 09:47:52.469355', 51, 'EXECUTED', '9:7c84de3d9bd84d7f077607c1a4dcb714', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2024-07-08 09:47:52.474882', 52, 'EXECUTED', '9:5a6bb36cbefb6a9d6928452c0852af2d', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2024-07-08 09:47:52.478827', 53, 'EXECUTED', '9:8f23e334dbc59f82e0a328373ca6ced0', 'update tableName=REALM', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2024-07-08 09:47:52.482642', 54, 'EXECUTED', '9:9156214268f09d970cdf0e1564d866af', 'update tableName=CLIENT', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2024-07-08 09:47:52.493883', 55, 'EXECUTED', '9:db806613b1ed154826c02610b7dbdf74', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2024-07-08 09:47:52.50428', 56, 'EXECUTED', '9:229a041fb72d5beac76bb94a5fa709de', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2024-07-08 09:47:52.537393', 57, 'EXECUTED', '9:079899dade9c1e683f26b2aa9ca6ff04', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2024-07-08 09:47:52.686935', 58, 'EXECUTED', '9:139b79bcbbfe903bb1c2d2a4dbf001d9', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2024-07-08 09:47:52.729541', 59, 'EXECUTED', '9:b55738ad889860c625ba2bf483495a04', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2024-07-08 09:47:52.738661', 60, 'EXECUTED', '9:e0057eac39aa8fc8e09ac6cfa4ae15fe', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2024-07-08 09:47:52.750298', 61, 'EXECUTED', '9:42a33806f3a0443fe0e7feeec821326c', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2024-07-08 09:47:52.759309', 62, 'EXECUTED', '9:9968206fca46eecc1f51db9c024bfe56', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2024-07-08 09:47:52.764672', 63, 'EXECUTED', '9:92143a6daea0a3f3b8f598c97ce55c3d', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2024-07-08 09:47:52.76911', 64, 'EXECUTED', '9:82bab26a27195d889fb0429003b18f40', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2024-07-08 09:47:52.772772', 65, 'EXECUTED', '9:e590c88ddc0b38b0ae4249bbfcb5abc3', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2024-07-08 09:47:52.796877', 66, 'EXECUTED', '9:5c1f475536118dbdc38d5d7977950cc0', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2024-07-08 09:47:52.806383', 67, 'EXECUTED', '9:e7c9f5f9c4d67ccbbcc215440c718a17', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2024-07-08 09:47:52.812511', 68, 'EXECUTED', '9:88e0bfdda924690d6f4e430c53447dd5', 'addColumn tableName=REALM', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2024-07-08 09:47:52.827165', 69, 'EXECUTED', '9:f53177f137e1c46b6a88c59ec1cb5218', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2024-07-08 09:47:52.834809', 70, 'EXECUTED', '9:a74d33da4dc42a37ec27121580d1459f', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2024-07-08 09:47:52.840644', 71, 'EXECUTED', '9:fd4ade7b90c3b67fae0bfcfcb42dfb5f', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2024-07-08 09:47:52.848124', 72, 'EXECUTED', '9:aa072ad090bbba210d8f18781b8cebf4', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2024-07-08 09:47:52.855701', 73, 'EXECUTED', '9:1ae6be29bab7c2aa376f6983b932be37', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2024-07-08 09:47:52.858501', 74, 'MARK_RAN', '9:14706f286953fc9a25286dbd8fb30d97', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2024-07-08 09:47:52.879808', 75, 'EXECUTED', '9:2b9cc12779be32c5b40e2e67711a218b', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2024-07-08 09:47:52.889678', 76, 'EXECUTED', '9:91fa186ce7a5af127a2d7a91ee083cc5', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2024-07-08 09:47:52.895276', 77, 'EXECUTED', '9:6335e5c94e83a2639ccd68dd24e2e5ad', 'addColumn tableName=CLIENT', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2024-07-08 09:47:52.897819', 78, 'MARK_RAN', '9:6bdb5658951e028bfe16fa0a8228b530', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2024-07-08 09:47:52.919081', 79, 'EXECUTED', '9:d5bc15a64117ccad481ce8792d4c608f', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2024-07-08 09:47:52.921843', 80, 'MARK_RAN', '9:077cba51999515f4d3e7ad5619ab592c', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2024-07-08 09:47:52.930949', 81, 'EXECUTED', '9:be969f08a163bf47c6b9e9ead8ac2afb', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2024-07-08 09:47:52.933419', 82, 'MARK_RAN', '9:6d3bb4408ba5a72f39bd8a0b301ec6e3', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2024-07-08 09:47:52.940577', 83, 'EXECUTED', '9:966bda61e46bebf3cc39518fbed52fa7', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2024-07-08 09:47:52.943232', 84, 'MARK_RAN', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2024-07-08 09:47:52.954502', 85, 'EXECUTED', '9:7d93d602352a30c0c317e6a609b56599', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2024-07-08 09:47:52.960836', 86, 'EXECUTED', '9:71c5969e6cdd8d7b6f47cebc86d37627', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2024-07-08 09:47:52.967573', 87, 'EXECUTED', '9:a9ba7d47f065f041b7da856a81762021', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2024-07-08 09:47:52.982697', 88, 'EXECUTED', '9:fffabce2bc01e1a8f5110d5278500065', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2024-07-08 09:47:52.990561', 89, 'EXECUTED', '9:fa8a5b5445e3857f4b010bafb5009957', 'addColumn tableName=REALM; customChange', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2024-07-08 09:47:53.004292', 90, 'EXECUTED', '9:67ac3241df9a8582d591c5ed87125f39', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2024-07-08 09:47:53.013658', 91, 'EXECUTED', '9:ad1194d66c937e3ffc82386c050ba089', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2024-07-08 09:47:53.020678', 92, 'EXECUTED', '9:d9be619d94af5a2f5d07b9f003543b91', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2024-07-08 09:47:53.023222', 93, 'MARK_RAN', '9:544d201116a0fcc5a5da0925fbbc3bde', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2024-07-08 09:47:53.035016', 94, 'EXECUTED', '9:43c0c1055b6761b4b3e89de76d612ccf', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2024-07-08 09:47:53.037696', 95, 'MARK_RAN', '9:8bd711fd0330f4fe980494ca43ab1139', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2024-07-08 09:47:53.045442', 96, 'EXECUTED', '9:e07d2bc0970c348bb06fb63b1f82ddbf', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2024-07-08 09:47:53.062635', 97, 'EXECUTED', '9:24fb8611e97f29989bea412aa38d12b7', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2024-07-08 09:47:53.065202', 98, 'MARK_RAN', '9:259f89014ce2506ee84740cbf7163aa7', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2024-07-08 09:47:53.076386', 99, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2024-07-08 09:47:53.085867', 100, 'EXECUTED', '9:60ca84a0f8c94ec8c3504a5a3bc88ee8', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2024-07-08 09:47:53.088475', 101, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2024-07-08 09:47:53.097428', 102, 'EXECUTED', '9:0b305d8d1277f3a89a0a53a659ad274c', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2024-07-08 09:47:53.103474', 103, 'EXECUTED', '9:2c374ad2cdfe20e2905a84c8fac48460', 'customChange', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2024-07-08 09:47:53.111267', 104, 'EXECUTED', '9:47a760639ac597360a8219f5b768b4de', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2024-07-08 09:47:53.120369', 105, 'EXECUTED', '9:a6272f0576727dd8cad2522335f5d99e', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', '2024-07-08 09:47:53.129241', 106, 'EXECUTED', '9:015479dbd691d9cc8669282f4828c41d', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2024-07-08 09:47:53.134549', 107, 'EXECUTED', '9:9518e495fdd22f78ad6425cc30630221', 'customChange', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('20.0.0-12964-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2024-07-08 09:47:53.143856', 108, 'EXECUTED', '9:e5f243877199fd96bcc842f27a1656ac', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('20.0.0-12964-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2024-07-08 09:47:53.146423', 109, 'MARK_RAN', '9:1a6fcaa85e20bdeae0a9ce49b41946a5', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('client-attributes-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2024-07-08 09:47:53.156048', 110, 'EXECUTED', '9:3f332e13e90739ed0c35b0b25b7822ca', 'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('21.0.2-17277', 'keycloak', 'META-INF/jpa-changelog-21.0.2.xml', '2024-07-08 09:47:53.160766', 111, 'EXECUTED', '9:7ee1f7a3fb8f5588f171fb9a6ab623c0', 'customChange', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('21.1.0-19404', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2024-07-08 09:47:53.224104', 112, 'EXECUTED', '9:3d7e830b52f33676b9d64f7f2b2ea634', 'modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('21.1.0-19404-2', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2024-07-08 09:47:53.227329', 113, 'MARK_RAN', '9:627d032e3ef2c06c0e1f73d2ae25c26c', 'addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('22.0.0-17484-updated', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2024-07-08 09:47:53.233164', 114, 'EXECUTED', '9:90af0bfd30cafc17b9f4d6eccd92b8b3', 'customChange', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('22.0.5-24031', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2024-07-08 09:47:53.236159', 115, 'MARK_RAN', '9:a60d2d7b315ec2d3eba9e2f145f9df28', 'customChange', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('23.0.0-12062', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2024-07-08 09:47:53.243836', 116, 'EXECUTED', '9:2168fbe728fec46ae9baf15bf80927b8', 'addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('23.0.0-17258', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2024-07-08 09:47:53.249107', 117, 'EXECUTED', '9:36506d679a83bbfda85a27ea1864dca8', 'addColumn tableName=EVENT_ENTITY', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('24.0.0-9758', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2024-07-08 09:47:53.271678', 118, 'EXECUTED', '9:502c557a5189f600f0f445a9b49ebbce', 'addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('24.0.0-26618-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2024-07-08 09:47:53.281958', 120, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('24.0.0-26618-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2024-07-08 09:47:53.29181', 121, 'EXECUTED', '9:08707c0f0db1cef6b352db03a60edc7f', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('24.0.2-27228', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2024-07-08 09:47:53.296446', 122, 'EXECUTED', '9:eaee11f6b8aa25d2cc6a84fb86fc6238', 'customChange', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('24.0.2-27967-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2024-07-08 09:47:53.298951', 123, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '0432070312');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('24.0.2-27967-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2024-07-08 09:47:53.301906', 124, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '0432070312');


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);
INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1000, false, NULL, NULL);
INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1001, false, NULL, NULL);


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('5ebb9076-4db1-482d-9e07-c56acd16b969', 'd0b78d07-8f09-4a84-ae95-b13370239a5c', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('5ebb9076-4db1-482d-9e07-c56acd16b969', 'd6cdf084-0135-4b77-852c-34a834557f83', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('5ebb9076-4db1-482d-9e07-c56acd16b969', '25ab9eda-4627-4029-ae6c-cf4aac769e2c', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('5ebb9076-4db1-482d-9e07-c56acd16b969', '14232ad5-4ba0-49a1-9bec-7a5b4f6cf7c5', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('5ebb9076-4db1-482d-9e07-c56acd16b969', '37d29ca8-7a65-4cc7-83d3-0d299f9c7707', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('5ebb9076-4db1-482d-9e07-c56acd16b969', '8f72dba6-7050-4a38-9655-025b06f90978', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('5ebb9076-4db1-482d-9e07-c56acd16b969', '248d2c7d-0baf-4f45-9cd1-96e5acc857f6', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('5ebb9076-4db1-482d-9e07-c56acd16b969', 'de09dc39-a565-44de-9ee6-e83a90f96044', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('5ebb9076-4db1-482d-9e07-c56acd16b969', 'abdc5ee1-1a7c-45be-93c3-5d9d1af90cf2', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('5ebb9076-4db1-482d-9e07-c56acd16b969', '038442a2-20d9-4c93-8614-099a6db0a90d', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'ddd54f97-f1ea-46c1-be49-7fd3093d08aa', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('99df8a6f-6238-421f-a213-77c5c1ca6a2b', '248c4ce7-9225-4e16-85ec-d57a7d8bb8f1', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('99df8a6f-6238-421f-a213-77c5c1ca6a2b', '14851311-7732-49b8-bf33-69b6b2f82994', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('99df8a6f-6238-421f-a213-77c5c1ca6a2b', '82e449c3-b62f-40ea-86bf-9e81d248c36d', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('99df8a6f-6238-421f-a213-77c5c1ca6a2b', '68a79385-0696-4ebc-a1f5-2a20889ee1a9', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'b63fa870-75bf-476f-ad39-88710fbbf852', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'fa88c0dc-4dd2-48b1-810e-36d7f8232de8', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('99df8a6f-6238-421f-a213-77c5c1ca6a2b', '76290814-e2c8-4785-90ac-a46c8d5546b0', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('99df8a6f-6238-421f-a213-77c5c1ca6a2b', '54c3f42e-36e1-4405-bf2c-0bed35efd5b8', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('99df8a6f-6238-421f-a213-77c5c1ca6a2b', '178d8a05-3929-472b-ad1b-096ba509f670', true);


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('7e2f0283-751d-4a2e-bc21-7726beffc34e', '5ebb9076-4db1-482d-9e07-c56acd16b969', false, '${role_default-roles}', 'default-roles-master', '5ebb9076-4db1-482d-9e07-c56acd16b969', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '5ebb9076-4db1-482d-9e07-c56acd16b969', false, '${role_admin}', 'admin', '5ebb9076-4db1-482d-9e07-c56acd16b969', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('ac915b80-4504-4e66-ada8-b719c85d9a97', '5ebb9076-4db1-482d-9e07-c56acd16b969', false, '${role_create-realm}', 'create-realm', '5ebb9076-4db1-482d-9e07-c56acd16b969', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e69b322c-1a3b-4ab4-8717-5089fefcb3b3', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_create-client}', 'create-client', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('5e32c472-2079-472b-981a-88091a240aa9', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_view-realm}', 'view-realm', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('6e4ae26a-5322-4d8f-9b12-b9599627aa57', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_view-users}', 'view-users', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('cf9e0dd6-a527-4f34-8d97-ac352f480213', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_view-clients}', 'view-clients', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('40dc7891-7dfc-4d40-9ddd-8ca970239f02', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_view-events}', 'view-events', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('fb28083a-72ea-4bb2-b286-998d649cf616', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_view-identity-providers}', 'view-identity-providers', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('adf48263-b18a-4d4a-8d12-3f8c65981bef', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_view-authorization}', 'view-authorization', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('7bf6dda5-4624-4914-8a2a-c1efdd609bb1', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_manage-realm}', 'manage-realm', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('3fef1f81-f7fc-445f-8e97-d3c4c772091b', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_manage-users}', 'manage-users', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b40ce2ad-ffb0-4dea-833c-ba9700f94463', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_manage-clients}', 'manage-clients', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('98fdadcf-d0d7-46fc-8f5d-2b2f4cc5b2ac', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_manage-events}', 'manage-events', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4a6eb794-fe2d-4145-b2c8-82941f438dff', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_manage-identity-providers}', 'manage-identity-providers', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('987e2870-a091-4935-a12f-3f003b21fdd4', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_manage-authorization}', 'manage-authorization', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('3599bad4-bab3-417e-a345-9b86c28d5af9', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_query-users}', 'query-users', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('223a13b8-384e-494c-8ea6-234822d2c2ce', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_query-clients}', 'query-clients', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('2891fc6e-2c08-4a53-b49c-e439ada98c9c', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_query-realms}', 'query-realms', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8603eaa7-7f48-4e33-af13-d5f1d753cc7d', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_query-groups}', 'query-groups', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c2006714-2dad-4c5c-9052-148930b4d166', '19677387-4876-4acd-8fda-69899b89f956', true, '${role_view-profile}', 'view-profile', '5ebb9076-4db1-482d-9e07-c56acd16b969', '19677387-4876-4acd-8fda-69899b89f956', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d20d1b7e-be89-40b3-978a-f92b9a49a4df', '19677387-4876-4acd-8fda-69899b89f956', true, '${role_manage-account}', 'manage-account', '5ebb9076-4db1-482d-9e07-c56acd16b969', '19677387-4876-4acd-8fda-69899b89f956', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('5e29755e-99d8-4496-929c-c066b11bbec2', '19677387-4876-4acd-8fda-69899b89f956', true, '${role_manage-account-links}', 'manage-account-links', '5ebb9076-4db1-482d-9e07-c56acd16b969', '19677387-4876-4acd-8fda-69899b89f956', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c6fd7177-7b52-4c05-825f-85a03672fd6e', '19677387-4876-4acd-8fda-69899b89f956', true, '${role_view-applications}', 'view-applications', '5ebb9076-4db1-482d-9e07-c56acd16b969', '19677387-4876-4acd-8fda-69899b89f956', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d826189e-1660-4494-b7fc-2dfb66705308', '19677387-4876-4acd-8fda-69899b89f956', true, '${role_view-consent}', 'view-consent', '5ebb9076-4db1-482d-9e07-c56acd16b969', '19677387-4876-4acd-8fda-69899b89f956', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b49c4c65-cf98-495a-a462-61c5c61116bb', '19677387-4876-4acd-8fda-69899b89f956', true, '${role_manage-consent}', 'manage-consent', '5ebb9076-4db1-482d-9e07-c56acd16b969', '19677387-4876-4acd-8fda-69899b89f956', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('97f7b4b2-02c4-45b4-bb65-898c57ebe598', '19677387-4876-4acd-8fda-69899b89f956', true, '${role_view-groups}', 'view-groups', '5ebb9076-4db1-482d-9e07-c56acd16b969', '19677387-4876-4acd-8fda-69899b89f956', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('301b103d-af16-48ef-b6d9-8cc46defe0d2', '19677387-4876-4acd-8fda-69899b89f956', true, '${role_delete-account}', 'delete-account', '5ebb9076-4db1-482d-9e07-c56acd16b969', '19677387-4876-4acd-8fda-69899b89f956', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b8fddc63-2f91-4aa3-877c-1a3adaec85b9', '47948543-4a1a-454e-94ea-83747f157c0f', true, '${role_read-token}', 'read-token', '5ebb9076-4db1-482d-9e07-c56acd16b969', '47948543-4a1a-454e-94ea-83747f157c0f', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8623f6ab-35a5-48a7-8376-ba1ef2948bcd', '895ba852-18c4-4275-9582-a9b97240d710', true, '${role_impersonation}', 'impersonation', '5ebb9076-4db1-482d-9e07-c56acd16b969', '895ba852-18c4-4275-9582-a9b97240d710', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('cb1dba1d-f358-4a7d-a8cf-3ed7578e2c36', '5ebb9076-4db1-482d-9e07-c56acd16b969', false, '${role_offline-access}', 'offline_access', '5ebb9076-4db1-482d-9e07-c56acd16b969', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e222ae1b-5d38-4af1-bf81-5d12b4b277e0', '5ebb9076-4db1-482d-9e07-c56acd16b969', false, '${role_uma_authorization}', 'uma_authorization', '5ebb9076-4db1-482d-9e07-c56acd16b969', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('26d286ff-9c63-499e-9b66-56e55b7105d3', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', false, '${role_default-roles}', 'default-roles-app', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b594a449-8b15-4223-a698-560f86a16eda', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_create-client}', 'create-client', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b7b75367-19f6-4ff4-97b6-06d7c10a3235', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_view-realm}', 'view-realm', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('ec021be9-50d2-4a57-b295-dce2c10ce220', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_view-users}', 'view-users', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c36177b5-c4ea-4556-b079-d2571178ab12', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_view-clients}', 'view-clients', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e11ed994-d2cb-40d7-9f54-42370f7e75da', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_view-events}', 'view-events', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f18740c4-70ef-498f-8ba7-cbeb1b665696', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_view-identity-providers}', 'view-identity-providers', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('738b8dff-3a59-449a-8247-fbe5d572bf4d', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_view-authorization}', 'view-authorization', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a8bf7fd1-7b62-42a6-a73c-b799e4660cc5', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_manage-realm}', 'manage-realm', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8f7554bb-b099-47a4-83a9-75dec22c5f89', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_manage-users}', 'manage-users', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9aa232f7-7ef6-4404-8d16-4fb5875987b2', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_manage-clients}', 'manage-clients', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('45f501ef-38e8-4190-abde-1f2f56a9dab5', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_manage-events}', 'manage-events', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('16c3bb3b-111c-4808-a113-f6b9a00f54a3', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_manage-identity-providers}', 'manage-identity-providers', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('83d531ff-af1d-4b08-b517-6d959f4f840c', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_manage-authorization}', 'manage-authorization', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('3e4bb3b7-05e0-4998-a5b3-1ce558a0ecbb', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_query-users}', 'query-users', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e1524005-7a12-4eaa-a449-a8b42b71ff91', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_query-clients}', 'query-clients', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('7e8fd0ae-3a6d-429f-8196-717bae270e3a', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_query-realms}', 'query-realms', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e9786630-4eb2-4989-a593-1c9c674c62d2', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_query-groups}', 'query-groups', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('859ab212-f5b3-48a4-b724-cd43054dd53c', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_realm-admin}', 'realm-admin', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('578eba18-9ada-48a5-939b-3d62aaa98198', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_create-client}', 'create-client', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a68d55a8-a849-4c27-b9d6-f403901be4c2', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_view-realm}', 'view-realm', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0f1345f7-7dde-42dc-a18b-9973749012e3', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_view-users}', 'view-users', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('7767e378-3cf1-4bc9-ab71-c9ae36dc1eae', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_view-clients}', 'view-clients', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('89439fb3-fb30-4b3e-a0da-360b30629011', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_view-events}', 'view-events', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a488d8c7-29ab-4034-acdc-44e0b55f3164', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_view-identity-providers}', 'view-identity-providers', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('3de5809c-06f5-452f-bd4d-97b531621054', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_view-authorization}', 'view-authorization', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b8d50b1e-67e9-4a31-957d-3804176eed8a', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_manage-realm}', 'manage-realm', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a5d713de-2938-4dcc-bacd-68e65cdf1398', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_manage-users}', 'manage-users', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b8217610-6295-4b40-ab19-ff04cc57271c', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_manage-clients}', 'manage-clients', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4e08d7a5-d1ae-449b-92ae-ea4809acf22f', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_manage-events}', 'manage-events', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d8a0accc-0de2-4b7e-90a3-e23ced8635aa', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_manage-identity-providers}', 'manage-identity-providers', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('38e3e8e6-e211-4a46-8e46-1b0bc3581f9b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_manage-authorization}', 'manage-authorization', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('acd027b6-cafa-405c-8970-9920796fc7df', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_query-users}', 'query-users', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4f12aeb9-f524-47ac-a31a-88bbd16b8c2f', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_query-clients}', 'query-clients', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4d0f2530-1bfd-4688-ad99-1dd2a7cf6180', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_query-realms}', 'query-realms', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('85163b5e-282d-4ce1-b5f2-ffc68e2952c5', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_query-groups}', 'query-groups', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f0c05913-2365-4baa-9a72-17aece68382a', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', true, '${role_view-profile}', 'view-profile', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d00bb70a-48e1-4e60-8792-279582db4801', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', true, '${role_manage-account}', 'manage-account', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('582023f5-b0d7-4ed2-a296-fdd11ad70fed', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', true, '${role_manage-account-links}', 'manage-account-links', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('93c22dfe-a571-4842-a9c6-097147a07f1a', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', true, '${role_view-applications}', 'view-applications', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('778c6c16-512e-4115-82ce-ce90499c530e', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', true, '${role_view-consent}', 'view-consent', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('329f34ac-4907-4d78-8029-d5611cdb599a', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', true, '${role_manage-consent}', 'manage-consent', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('251a204f-7763-409d-b3b3-1db236fd0bbd', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', true, '${role_view-groups}', 'view-groups', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('12f50c89-0896-44ef-97f0-21036a26e434', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', true, '${role_delete-account}', 'delete-account', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '1f26f5af-8b3b-4816-b67e-66de6cff07d5', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d6769e7f-ecb6-4681-a2b5-5a3ada22d10c', '41663dc7-1a06-4376-82f2-108fd894234c', true, '${role_impersonation}', 'impersonation', '5ebb9076-4db1-482d-9e07-c56acd16b969', '41663dc7-1a06-4376-82f2-108fd894234c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8439fbff-fdc3-43ad-b850-3d8c2005d9d3', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', true, '${role_impersonation}', 'impersonation', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e35c7d93-9aa3-4344-bed5-ba4eefe7d17e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('936d3e0a-8585-4633-80da-9e6d034f2a17', 'e7647f61-df77-4cba-bcd1-1cb339c3d4e5', true, '${role_read-token}', 'read-token', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'e7647f61-df77-4cba-bcd1-1cb339c3d4e5', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b6aa342b-c5e1-4d1d-a96a-4f2d2b779b5c', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', false, '${role_offline-access}', 'offline_access', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0e01e159-05e4-463a-b6e0-6a33ab037e4b', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', false, '${role_uma_authorization}', 'uma_authorization', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('85d2c08c-fc30-4a01-9a9e-d6c1507c9500', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', false, '', 'admin', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('856e8352-ad0b-42a0-b1e1-a53cb9858145', 'a814b9f6-db6e-4dd2-91be-ee4f76696fd6', true, '', 'admin', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'a814b9f6-db6e-4dd2-91be-ee4f76696fd6', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8ae9fb1e-0de3-4d4d-b5b2-bd95b2f35db9', '3461d02f-8577-4d1f-8a10-761f7d545fa7', true, '', 'admin', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '3461d02f-8577-4d1f-8a10-761f7d545fa7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('3ab8ba52-a0be-43ea-be27-ef225fb1515b', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', false, '', 'user', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', NULL, NULL);


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.migration_model (id, version, update_time) VALUES ('1yjg1', '24.0.5', 1720432073);


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('ff29e9ea-02b1-45ff-91e0-3359fdc61faf', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', 'cb52ede1-9b0c-4b7f-8b21-1349568b79d6', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b185d20f-1269-4a51-8e5b-11ceea4b4b33', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '3b93c3b5-76f5-4ec2-a887-5057c218e2ee', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('279a5d4e-b143-4ad8-853a-8903b9b693c2', 'role list', 'saml', 'saml-role-list-mapper', NULL, 'd6cdf084-0135-4b77-852c-34a834557f83');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('362f49b5-de8f-4653-bcc0-42d0318f2f4e', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('dfe6abea-e70e-46f1-a2bf-e5a2a305d733', 'family name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3ed88795-c90a-40d3-8b0b-e51d65b2bb7c', 'given name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f42d8f73-6a63-41ff-ade3-819676fbec68', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('1a2381ec-be56-41e7-bc72-b80ef08e0f81', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('c1a64d46-ee2c-43ef-926f-233cb923922f', 'username', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('789d0ff1-36f7-4f02-89f2-342463c62f03', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('86e0457d-581a-41dc-b0f0-9b20496d3f4a', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('eb730698-b4cf-4594-a51e-1f275d686763', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('e28ee371-148c-4c07-a98f-1618f23d4b58', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('23008349-3d58-4a34-80b6-0de5477cb5d5', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b338702f-3ad1-4469-a61b-6eb2f8e38eee', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('bc1575ed-53ac-4a65-a9f7-79214fcd0bf8', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('9adc42b6-d261-4820-a35f-a71ec193691c', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '25ab9eda-4627-4029-ae6c-cf4aac769e2c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('aeeb207a-bd3e-433d-b161-12a7d9106309', 'email', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14232ad5-4ba0-49a1-9bec-7a5b4f6cf7c5');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f2491897-c979-4127-a1fe-bd2ab8d35ed8', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '14232ad5-4ba0-49a1-9bec-7a5b4f6cf7c5');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3b257ead-7718-4d6a-b473-3ba56713f4aa', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '37d29ca8-7a65-4cc7-83d3-0d299f9c7707');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('5f147d70-625a-4020-9608-bb9ade94a815', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '8f72dba6-7050-4a38-9655-025b06f90978');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('0e691067-71b9-44a9-a137-b9e46e0f2cf1', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '8f72dba6-7050-4a38-9655-025b06f90978');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('c7e1b9af-1ae6-4947-9f5f-b2e376708077', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '248d2c7d-0baf-4f45-9cd1-96e5acc857f6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('70c8635e-9322-4d59-89fa-9e5d14886c0d', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '248d2c7d-0baf-4f45-9cd1-96e5acc857f6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f39f3e46-1e4f-40a2-8046-b1876d531b73', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '248d2c7d-0baf-4f45-9cd1-96e5acc857f6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('ef95d590-885a-477d-aa9a-fbdaff2eaf61', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, 'de09dc39-a565-44de-9ee6-e83a90f96044');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b7b34451-b33d-401d-96d4-4b556bd40d63', 'upn', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'abdc5ee1-1a7c-45be-93c3-5d9d1af90cf2');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('42c6e272-3034-47f2-84a4-4954c57d3fcc', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'abdc5ee1-1a7c-45be-93c3-5d9d1af90cf2');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('a15b9f07-83fb-4dea-a61d-b18ccfc4c726', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, '038442a2-20d9-4c93-8614-099a6db0a90d');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('cde7a251-b327-4445-a225-988decf9372c', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', 'cd19c842-e87d-4aa2-91b4-dfe5159c1421', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('7ccea626-b7ca-41ea-b30e-32885106b142', 'role list', 'saml', 'saml-role-list-mapper', NULL, '248c4ce7-9225-4e16-85ec-d57a7d8bb8f1');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('23ec0d6e-c0c5-463d-b688-ec6f89ecdf92', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('a7b3f886-65af-4079-a339-4fd491f3f3e8', 'family name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('a4ace7f1-b8ca-478f-be5c-3e60cf47879e', 'given name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('64c64f1a-ee78-4984-8954-8db9d26a092e', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('685674d4-3a7a-4f23-a550-21a14547f5d2', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('52fe961e-31a9-41fc-ba21-b41e4e50a975', 'username', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('a0571bbf-ad1a-45d6-908c-1272eaaf71a0', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('ec03d3f7-4681-4a10-8386-18c310ece468', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('5d3ccc9c-944e-491e-900c-89469b8bb6e0', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('735da9b1-9eb4-46ec-bec7-d1e509a81403', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('99623687-dcc0-475d-ade1-1705049fba5f', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('e71da90a-7f49-4aa5-8afb-e8b3eb130b58', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('da881097-0513-458f-9a51-a6d377d8ae91', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('372900bb-14cb-4ce3-a3b6-21347c4c7a6c', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '14851311-7732-49b8-bf33-69b6b2f82994');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('1051d52d-21bf-4574-b4a4-47c8987bf6fa', 'email', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '82e449c3-b62f-40ea-86bf-9e81d248c36d');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b870f8a6-6369-47ef-8603-7fe373d9c203', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '82e449c3-b62f-40ea-86bf-9e81d248c36d');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('339c977c-48d8-4c92-9bad-e9b13016acf1', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '68a79385-0696-4ebc-a1f5-2a20889ee1a9');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('5763582c-ca09-4687-b635-e4d41298be4b', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'b63fa870-75bf-476f-ad39-88710fbbf852');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('9f9b7172-75c5-4bf5-98c3-78f76f6abbd9', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'b63fa870-75bf-476f-ad39-88710fbbf852');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('9eb71d18-3f7b-44ee-bed1-1d652273a3fe', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'fa88c0dc-4dd2-48b1-810e-36d7f8232de8');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('185986a6-3ff6-4851-9bfe-dbb6c31d16d4', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, 'fa88c0dc-4dd2-48b1-810e-36d7f8232de8');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('18dbc7d3-6972-410b-9e5d-29f014d4440d', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, 'fa88c0dc-4dd2-48b1-810e-36d7f8232de8');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('62b76e62-2238-4fcf-ad5e-bfa6cf57800a', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '76290814-e2c8-4785-90ac-a46c8d5546b0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('25a848f1-65fb-4e50-a23b-47da1d76a50c', 'upn', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '54c3f42e-36e1-4405-bf2c-0bed35efd5b8');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('929a7ab6-4f1d-4efe-a710-9bf835dd7526', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '54c3f42e-36e1-4405-bf2c-0bed35efd5b8');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('4945f6a5-b2a4-4ff8-a640-4ad09d01457c', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, '178d8a05-3929-472b-ad1b-096ba509f670');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('1121d8bf-f8c1-42a5-82ee-5959969dcefb', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '5d7f64c6-3613-4d41-8826-0a9df34f1bac', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b358799f-f839-42c5-808c-1c796e00c832', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '3461d02f-8577-4d1f-8a10-761f7d545fa7', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('92aa3fea-033c-4304-9f55-b0e3c44aa293', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '3461d02f-8577-4d1f-8a10-761f7d545fa7', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('67024566-c4b3-46d3-98be-c6356d988372', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '3461d02f-8577-4d1f-8a10-761f7d545fa7', NULL);


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b185d20f-1269-4a51-8e5b-11ceea4b4b33', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b185d20f-1269-4a51-8e5b-11ceea4b4b33', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b185d20f-1269-4a51-8e5b-11ceea4b4b33', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b185d20f-1269-4a51-8e5b-11ceea4b4b33', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b185d20f-1269-4a51-8e5b-11ceea4b4b33', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b185d20f-1269-4a51-8e5b-11ceea4b4b33', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b185d20f-1269-4a51-8e5b-11ceea4b4b33', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('279a5d4e-b143-4ad8-853a-8903b9b693c2', 'false', 'single');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('279a5d4e-b143-4ad8-853a-8903b9b693c2', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('279a5d4e-b143-4ad8-853a-8903b9b693c2', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1a2381ec-be56-41e7-bc72-b80ef08e0f81', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1a2381ec-be56-41e7-bc72-b80ef08e0f81', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1a2381ec-be56-41e7-bc72-b80ef08e0f81', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1a2381ec-be56-41e7-bc72-b80ef08e0f81', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1a2381ec-be56-41e7-bc72-b80ef08e0f81', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1a2381ec-be56-41e7-bc72-b80ef08e0f81', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1a2381ec-be56-41e7-bc72-b80ef08e0f81', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23008349-3d58-4a34-80b6-0de5477cb5d5', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23008349-3d58-4a34-80b6-0de5477cb5d5', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23008349-3d58-4a34-80b6-0de5477cb5d5', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23008349-3d58-4a34-80b6-0de5477cb5d5', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23008349-3d58-4a34-80b6-0de5477cb5d5', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23008349-3d58-4a34-80b6-0de5477cb5d5', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23008349-3d58-4a34-80b6-0de5477cb5d5', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('362f49b5-de8f-4653-bcc0-42d0318f2f4e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('362f49b5-de8f-4653-bcc0-42d0318f2f4e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('362f49b5-de8f-4653-bcc0-42d0318f2f4e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('362f49b5-de8f-4653-bcc0-42d0318f2f4e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3ed88795-c90a-40d3-8b0b-e51d65b2bb7c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3ed88795-c90a-40d3-8b0b-e51d65b2bb7c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3ed88795-c90a-40d3-8b0b-e51d65b2bb7c', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3ed88795-c90a-40d3-8b0b-e51d65b2bb7c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3ed88795-c90a-40d3-8b0b-e51d65b2bb7c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3ed88795-c90a-40d3-8b0b-e51d65b2bb7c', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3ed88795-c90a-40d3-8b0b-e51d65b2bb7c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('789d0ff1-36f7-4f02-89f2-342463c62f03', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('789d0ff1-36f7-4f02-89f2-342463c62f03', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('789d0ff1-36f7-4f02-89f2-342463c62f03', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('789d0ff1-36f7-4f02-89f2-342463c62f03', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('789d0ff1-36f7-4f02-89f2-342463c62f03', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('789d0ff1-36f7-4f02-89f2-342463c62f03', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('789d0ff1-36f7-4f02-89f2-342463c62f03', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('86e0457d-581a-41dc-b0f0-9b20496d3f4a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('86e0457d-581a-41dc-b0f0-9b20496d3f4a', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('86e0457d-581a-41dc-b0f0-9b20496d3f4a', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('86e0457d-581a-41dc-b0f0-9b20496d3f4a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('86e0457d-581a-41dc-b0f0-9b20496d3f4a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('86e0457d-581a-41dc-b0f0-9b20496d3f4a', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('86e0457d-581a-41dc-b0f0-9b20496d3f4a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9adc42b6-d261-4820-a35f-a71ec193691c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9adc42b6-d261-4820-a35f-a71ec193691c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9adc42b6-d261-4820-a35f-a71ec193691c', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9adc42b6-d261-4820-a35f-a71ec193691c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9adc42b6-d261-4820-a35f-a71ec193691c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9adc42b6-d261-4820-a35f-a71ec193691c', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9adc42b6-d261-4820-a35f-a71ec193691c', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b338702f-3ad1-4469-a61b-6eb2f8e38eee', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b338702f-3ad1-4469-a61b-6eb2f8e38eee', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b338702f-3ad1-4469-a61b-6eb2f8e38eee', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b338702f-3ad1-4469-a61b-6eb2f8e38eee', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b338702f-3ad1-4469-a61b-6eb2f8e38eee', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b338702f-3ad1-4469-a61b-6eb2f8e38eee', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b338702f-3ad1-4469-a61b-6eb2f8e38eee', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bc1575ed-53ac-4a65-a9f7-79214fcd0bf8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bc1575ed-53ac-4a65-a9f7-79214fcd0bf8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bc1575ed-53ac-4a65-a9f7-79214fcd0bf8', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bc1575ed-53ac-4a65-a9f7-79214fcd0bf8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bc1575ed-53ac-4a65-a9f7-79214fcd0bf8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bc1575ed-53ac-4a65-a9f7-79214fcd0bf8', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bc1575ed-53ac-4a65-a9f7-79214fcd0bf8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c1a64d46-ee2c-43ef-926f-233cb923922f', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c1a64d46-ee2c-43ef-926f-233cb923922f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c1a64d46-ee2c-43ef-926f-233cb923922f', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c1a64d46-ee2c-43ef-926f-233cb923922f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c1a64d46-ee2c-43ef-926f-233cb923922f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c1a64d46-ee2c-43ef-926f-233cb923922f', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c1a64d46-ee2c-43ef-926f-233cb923922f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('dfe6abea-e70e-46f1-a2bf-e5a2a305d733', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('dfe6abea-e70e-46f1-a2bf-e5a2a305d733', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('dfe6abea-e70e-46f1-a2bf-e5a2a305d733', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('dfe6abea-e70e-46f1-a2bf-e5a2a305d733', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('dfe6abea-e70e-46f1-a2bf-e5a2a305d733', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('dfe6abea-e70e-46f1-a2bf-e5a2a305d733', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('dfe6abea-e70e-46f1-a2bf-e5a2a305d733', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e28ee371-148c-4c07-a98f-1618f23d4b58', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e28ee371-148c-4c07-a98f-1618f23d4b58', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e28ee371-148c-4c07-a98f-1618f23d4b58', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e28ee371-148c-4c07-a98f-1618f23d4b58', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e28ee371-148c-4c07-a98f-1618f23d4b58', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e28ee371-148c-4c07-a98f-1618f23d4b58', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e28ee371-148c-4c07-a98f-1618f23d4b58', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eb730698-b4cf-4594-a51e-1f275d686763', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eb730698-b4cf-4594-a51e-1f275d686763', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eb730698-b4cf-4594-a51e-1f275d686763', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eb730698-b4cf-4594-a51e-1f275d686763', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eb730698-b4cf-4594-a51e-1f275d686763', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eb730698-b4cf-4594-a51e-1f275d686763', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eb730698-b4cf-4594-a51e-1f275d686763', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f42d8f73-6a63-41ff-ade3-819676fbec68', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f42d8f73-6a63-41ff-ade3-819676fbec68', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f42d8f73-6a63-41ff-ade3-819676fbec68', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f42d8f73-6a63-41ff-ade3-819676fbec68', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f42d8f73-6a63-41ff-ade3-819676fbec68', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f42d8f73-6a63-41ff-ade3-819676fbec68', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f42d8f73-6a63-41ff-ade3-819676fbec68', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aeeb207a-bd3e-433d-b161-12a7d9106309', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aeeb207a-bd3e-433d-b161-12a7d9106309', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aeeb207a-bd3e-433d-b161-12a7d9106309', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aeeb207a-bd3e-433d-b161-12a7d9106309', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aeeb207a-bd3e-433d-b161-12a7d9106309', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aeeb207a-bd3e-433d-b161-12a7d9106309', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aeeb207a-bd3e-433d-b161-12a7d9106309', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f2491897-c979-4127-a1fe-bd2ab8d35ed8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f2491897-c979-4127-a1fe-bd2ab8d35ed8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f2491897-c979-4127-a1fe-bd2ab8d35ed8', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f2491897-c979-4127-a1fe-bd2ab8d35ed8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f2491897-c979-4127-a1fe-bd2ab8d35ed8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f2491897-c979-4127-a1fe-bd2ab8d35ed8', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f2491897-c979-4127-a1fe-bd2ab8d35ed8', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3b257ead-7718-4d6a-b473-3ba56713f4aa', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3b257ead-7718-4d6a-b473-3ba56713f4aa', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3b257ead-7718-4d6a-b473-3ba56713f4aa', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3b257ead-7718-4d6a-b473-3ba56713f4aa', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3b257ead-7718-4d6a-b473-3ba56713f4aa', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3b257ead-7718-4d6a-b473-3ba56713f4aa', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3b257ead-7718-4d6a-b473-3ba56713f4aa', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3b257ead-7718-4d6a-b473-3ba56713f4aa', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3b257ead-7718-4d6a-b473-3ba56713f4aa', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3b257ead-7718-4d6a-b473-3ba56713f4aa', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0e691067-71b9-44a9-a137-b9e46e0f2cf1', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0e691067-71b9-44a9-a137-b9e46e0f2cf1', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0e691067-71b9-44a9-a137-b9e46e0f2cf1', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0e691067-71b9-44a9-a137-b9e46e0f2cf1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0e691067-71b9-44a9-a137-b9e46e0f2cf1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0e691067-71b9-44a9-a137-b9e46e0f2cf1', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0e691067-71b9-44a9-a137-b9e46e0f2cf1', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5f147d70-625a-4020-9608-bb9ade94a815', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5f147d70-625a-4020-9608-bb9ade94a815', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5f147d70-625a-4020-9608-bb9ade94a815', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5f147d70-625a-4020-9608-bb9ade94a815', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5f147d70-625a-4020-9608-bb9ade94a815', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5f147d70-625a-4020-9608-bb9ade94a815', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5f147d70-625a-4020-9608-bb9ade94a815', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('70c8635e-9322-4d59-89fa-9e5d14886c0d', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('70c8635e-9322-4d59-89fa-9e5d14886c0d', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('70c8635e-9322-4d59-89fa-9e5d14886c0d', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('70c8635e-9322-4d59-89fa-9e5d14886c0d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('70c8635e-9322-4d59-89fa-9e5d14886c0d', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('70c8635e-9322-4d59-89fa-9e5d14886c0d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c7e1b9af-1ae6-4947-9f5f-b2e376708077', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c7e1b9af-1ae6-4947-9f5f-b2e376708077', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c7e1b9af-1ae6-4947-9f5f-b2e376708077', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c7e1b9af-1ae6-4947-9f5f-b2e376708077', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c7e1b9af-1ae6-4947-9f5f-b2e376708077', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c7e1b9af-1ae6-4947-9f5f-b2e376708077', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f39f3e46-1e4f-40a2-8046-b1876d531b73', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f39f3e46-1e4f-40a2-8046-b1876d531b73', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ef95d590-885a-477d-aa9a-fbdaff2eaf61', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ef95d590-885a-477d-aa9a-fbdaff2eaf61', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('42c6e272-3034-47f2-84a4-4954c57d3fcc', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('42c6e272-3034-47f2-84a4-4954c57d3fcc', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('42c6e272-3034-47f2-84a4-4954c57d3fcc', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('42c6e272-3034-47f2-84a4-4954c57d3fcc', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('42c6e272-3034-47f2-84a4-4954c57d3fcc', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('42c6e272-3034-47f2-84a4-4954c57d3fcc', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('42c6e272-3034-47f2-84a4-4954c57d3fcc', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b7b34451-b33d-401d-96d4-4b556bd40d63', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b7b34451-b33d-401d-96d4-4b556bd40d63', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b7b34451-b33d-401d-96d4-4b556bd40d63', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b7b34451-b33d-401d-96d4-4b556bd40d63', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b7b34451-b33d-401d-96d4-4b556bd40d63', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b7b34451-b33d-401d-96d4-4b556bd40d63', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b7b34451-b33d-401d-96d4-4b556bd40d63', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a15b9f07-83fb-4dea-a61d-b18ccfc4c726', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a15b9f07-83fb-4dea-a61d-b18ccfc4c726', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a15b9f07-83fb-4dea-a61d-b18ccfc4c726', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7ccea626-b7ca-41ea-b30e-32885106b142', 'false', 'single');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7ccea626-b7ca-41ea-b30e-32885106b142', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7ccea626-b7ca-41ea-b30e-32885106b142', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23ec0d6e-c0c5-463d-b688-ec6f89ecdf92', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23ec0d6e-c0c5-463d-b688-ec6f89ecdf92', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23ec0d6e-c0c5-463d-b688-ec6f89ecdf92', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('23ec0d6e-c0c5-463d-b688-ec6f89ecdf92', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('372900bb-14cb-4ce3-a3b6-21347c4c7a6c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('372900bb-14cb-4ce3-a3b6-21347c4c7a6c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('372900bb-14cb-4ce3-a3b6-21347c4c7a6c', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('372900bb-14cb-4ce3-a3b6-21347c4c7a6c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('372900bb-14cb-4ce3-a3b6-21347c4c7a6c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('372900bb-14cb-4ce3-a3b6-21347c4c7a6c', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('372900bb-14cb-4ce3-a3b6-21347c4c7a6c', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('52fe961e-31a9-41fc-ba21-b41e4e50a975', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('52fe961e-31a9-41fc-ba21-b41e4e50a975', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('52fe961e-31a9-41fc-ba21-b41e4e50a975', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('52fe961e-31a9-41fc-ba21-b41e4e50a975', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('52fe961e-31a9-41fc-ba21-b41e4e50a975', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('52fe961e-31a9-41fc-ba21-b41e4e50a975', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('52fe961e-31a9-41fc-ba21-b41e4e50a975', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5d3ccc9c-944e-491e-900c-89469b8bb6e0', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5d3ccc9c-944e-491e-900c-89469b8bb6e0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5d3ccc9c-944e-491e-900c-89469b8bb6e0', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5d3ccc9c-944e-491e-900c-89469b8bb6e0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5d3ccc9c-944e-491e-900c-89469b8bb6e0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5d3ccc9c-944e-491e-900c-89469b8bb6e0', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5d3ccc9c-944e-491e-900c-89469b8bb6e0', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('64c64f1a-ee78-4984-8954-8db9d26a092e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('64c64f1a-ee78-4984-8954-8db9d26a092e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('64c64f1a-ee78-4984-8954-8db9d26a092e', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('64c64f1a-ee78-4984-8954-8db9d26a092e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('64c64f1a-ee78-4984-8954-8db9d26a092e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('64c64f1a-ee78-4984-8954-8db9d26a092e', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('64c64f1a-ee78-4984-8954-8db9d26a092e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('685674d4-3a7a-4f23-a550-21a14547f5d2', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('685674d4-3a7a-4f23-a550-21a14547f5d2', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('685674d4-3a7a-4f23-a550-21a14547f5d2', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('685674d4-3a7a-4f23-a550-21a14547f5d2', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('685674d4-3a7a-4f23-a550-21a14547f5d2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('685674d4-3a7a-4f23-a550-21a14547f5d2', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('685674d4-3a7a-4f23-a550-21a14547f5d2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('735da9b1-9eb4-46ec-bec7-d1e509a81403', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('735da9b1-9eb4-46ec-bec7-d1e509a81403', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('735da9b1-9eb4-46ec-bec7-d1e509a81403', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('735da9b1-9eb4-46ec-bec7-d1e509a81403', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('735da9b1-9eb4-46ec-bec7-d1e509a81403', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('735da9b1-9eb4-46ec-bec7-d1e509a81403', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('735da9b1-9eb4-46ec-bec7-d1e509a81403', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('99623687-dcc0-475d-ade1-1705049fba5f', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('99623687-dcc0-475d-ade1-1705049fba5f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('99623687-dcc0-475d-ade1-1705049fba5f', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('99623687-dcc0-475d-ade1-1705049fba5f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('99623687-dcc0-475d-ade1-1705049fba5f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('99623687-dcc0-475d-ade1-1705049fba5f', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('99623687-dcc0-475d-ade1-1705049fba5f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a0571bbf-ad1a-45d6-908c-1272eaaf71a0', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a0571bbf-ad1a-45d6-908c-1272eaaf71a0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a0571bbf-ad1a-45d6-908c-1272eaaf71a0', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a0571bbf-ad1a-45d6-908c-1272eaaf71a0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a0571bbf-ad1a-45d6-908c-1272eaaf71a0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a0571bbf-ad1a-45d6-908c-1272eaaf71a0', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a0571bbf-ad1a-45d6-908c-1272eaaf71a0', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a4ace7f1-b8ca-478f-be5c-3e60cf47879e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a4ace7f1-b8ca-478f-be5c-3e60cf47879e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a4ace7f1-b8ca-478f-be5c-3e60cf47879e', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a4ace7f1-b8ca-478f-be5c-3e60cf47879e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a4ace7f1-b8ca-478f-be5c-3e60cf47879e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a4ace7f1-b8ca-478f-be5c-3e60cf47879e', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a4ace7f1-b8ca-478f-be5c-3e60cf47879e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a7b3f886-65af-4079-a339-4fd491f3f3e8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a7b3f886-65af-4079-a339-4fd491f3f3e8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a7b3f886-65af-4079-a339-4fd491f3f3e8', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a7b3f886-65af-4079-a339-4fd491f3f3e8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a7b3f886-65af-4079-a339-4fd491f3f3e8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a7b3f886-65af-4079-a339-4fd491f3f3e8', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a7b3f886-65af-4079-a339-4fd491f3f3e8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('da881097-0513-458f-9a51-a6d377d8ae91', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('da881097-0513-458f-9a51-a6d377d8ae91', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('da881097-0513-458f-9a51-a6d377d8ae91', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('da881097-0513-458f-9a51-a6d377d8ae91', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('da881097-0513-458f-9a51-a6d377d8ae91', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('da881097-0513-458f-9a51-a6d377d8ae91', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('da881097-0513-458f-9a51-a6d377d8ae91', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e71da90a-7f49-4aa5-8afb-e8b3eb130b58', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e71da90a-7f49-4aa5-8afb-e8b3eb130b58', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e71da90a-7f49-4aa5-8afb-e8b3eb130b58', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e71da90a-7f49-4aa5-8afb-e8b3eb130b58', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e71da90a-7f49-4aa5-8afb-e8b3eb130b58', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e71da90a-7f49-4aa5-8afb-e8b3eb130b58', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e71da90a-7f49-4aa5-8afb-e8b3eb130b58', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ec03d3f7-4681-4a10-8386-18c310ece468', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ec03d3f7-4681-4a10-8386-18c310ece468', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ec03d3f7-4681-4a10-8386-18c310ece468', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ec03d3f7-4681-4a10-8386-18c310ece468', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ec03d3f7-4681-4a10-8386-18c310ece468', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ec03d3f7-4681-4a10-8386-18c310ece468', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ec03d3f7-4681-4a10-8386-18c310ece468', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1051d52d-21bf-4574-b4a4-47c8987bf6fa', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1051d52d-21bf-4574-b4a4-47c8987bf6fa', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1051d52d-21bf-4574-b4a4-47c8987bf6fa', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1051d52d-21bf-4574-b4a4-47c8987bf6fa', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1051d52d-21bf-4574-b4a4-47c8987bf6fa', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1051d52d-21bf-4574-b4a4-47c8987bf6fa', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1051d52d-21bf-4574-b4a4-47c8987bf6fa', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b870f8a6-6369-47ef-8603-7fe373d9c203', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b870f8a6-6369-47ef-8603-7fe373d9c203', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b870f8a6-6369-47ef-8603-7fe373d9c203', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b870f8a6-6369-47ef-8603-7fe373d9c203', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b870f8a6-6369-47ef-8603-7fe373d9c203', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b870f8a6-6369-47ef-8603-7fe373d9c203', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b870f8a6-6369-47ef-8603-7fe373d9c203', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('339c977c-48d8-4c92-9bad-e9b13016acf1', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('339c977c-48d8-4c92-9bad-e9b13016acf1', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('339c977c-48d8-4c92-9bad-e9b13016acf1', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('339c977c-48d8-4c92-9bad-e9b13016acf1', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('339c977c-48d8-4c92-9bad-e9b13016acf1', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('339c977c-48d8-4c92-9bad-e9b13016acf1', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('339c977c-48d8-4c92-9bad-e9b13016acf1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('339c977c-48d8-4c92-9bad-e9b13016acf1', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('339c977c-48d8-4c92-9bad-e9b13016acf1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('339c977c-48d8-4c92-9bad-e9b13016acf1', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5763582c-ca09-4687-b635-e4d41298be4b', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5763582c-ca09-4687-b635-e4d41298be4b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5763582c-ca09-4687-b635-e4d41298be4b', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5763582c-ca09-4687-b635-e4d41298be4b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5763582c-ca09-4687-b635-e4d41298be4b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5763582c-ca09-4687-b635-e4d41298be4b', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('5763582c-ca09-4687-b635-e4d41298be4b', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9f9b7172-75c5-4bf5-98c3-78f76f6abbd9', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9f9b7172-75c5-4bf5-98c3-78f76f6abbd9', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9f9b7172-75c5-4bf5-98c3-78f76f6abbd9', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9f9b7172-75c5-4bf5-98c3-78f76f6abbd9', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9f9b7172-75c5-4bf5-98c3-78f76f6abbd9', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9f9b7172-75c5-4bf5-98c3-78f76f6abbd9', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9f9b7172-75c5-4bf5-98c3-78f76f6abbd9', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('185986a6-3ff6-4851-9bfe-dbb6c31d16d4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('185986a6-3ff6-4851-9bfe-dbb6c31d16d4', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('185986a6-3ff6-4851-9bfe-dbb6c31d16d4', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('185986a6-3ff6-4851-9bfe-dbb6c31d16d4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('185986a6-3ff6-4851-9bfe-dbb6c31d16d4', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('185986a6-3ff6-4851-9bfe-dbb6c31d16d4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('18dbc7d3-6972-410b-9e5d-29f014d4440d', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('18dbc7d3-6972-410b-9e5d-29f014d4440d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9eb71d18-3f7b-44ee-bed1-1d652273a3fe', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9eb71d18-3f7b-44ee-bed1-1d652273a3fe', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9eb71d18-3f7b-44ee-bed1-1d652273a3fe', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9eb71d18-3f7b-44ee-bed1-1d652273a3fe', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9eb71d18-3f7b-44ee-bed1-1d652273a3fe', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9eb71d18-3f7b-44ee-bed1-1d652273a3fe', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('62b76e62-2238-4fcf-ad5e-bfa6cf57800a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('62b76e62-2238-4fcf-ad5e-bfa6cf57800a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('25a848f1-65fb-4e50-a23b-47da1d76a50c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('25a848f1-65fb-4e50-a23b-47da1d76a50c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('25a848f1-65fb-4e50-a23b-47da1d76a50c', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('25a848f1-65fb-4e50-a23b-47da1d76a50c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('25a848f1-65fb-4e50-a23b-47da1d76a50c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('25a848f1-65fb-4e50-a23b-47da1d76a50c', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('25a848f1-65fb-4e50-a23b-47da1d76a50c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('929a7ab6-4f1d-4efe-a710-9bf835dd7526', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('929a7ab6-4f1d-4efe-a710-9bf835dd7526', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('929a7ab6-4f1d-4efe-a710-9bf835dd7526', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('929a7ab6-4f1d-4efe-a710-9bf835dd7526', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('929a7ab6-4f1d-4efe-a710-9bf835dd7526', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('929a7ab6-4f1d-4efe-a710-9bf835dd7526', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('929a7ab6-4f1d-4efe-a710-9bf835dd7526', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4945f6a5-b2a4-4ff8-a640-4ad09d01457c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4945f6a5-b2a4-4ff8-a640-4ad09d01457c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4945f6a5-b2a4-4ff8-a640-4ad09d01457c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1121d8bf-f8c1-42a5-82ee-5959969dcefb', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1121d8bf-f8c1-42a5-82ee-5959969dcefb', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1121d8bf-f8c1-42a5-82ee-5959969dcefb', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1121d8bf-f8c1-42a5-82ee-5959969dcefb', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1121d8bf-f8c1-42a5-82ee-5959969dcefb', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1121d8bf-f8c1-42a5-82ee-5959969dcefb', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1121d8bf-f8c1-42a5-82ee-5959969dcefb', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('67024566-c4b3-46d3-98be-c6356d988372', 'clientAddress', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('67024566-c4b3-46d3-98be-c6356d988372', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('67024566-c4b3-46d3-98be-c6356d988372', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('67024566-c4b3-46d3-98be-c6356d988372', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('67024566-c4b3-46d3-98be-c6356d988372', 'clientAddress', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('67024566-c4b3-46d3-98be-c6356d988372', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('92aa3fea-033c-4304-9f55-b0e3c44aa293', 'clientHost', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('92aa3fea-033c-4304-9f55-b0e3c44aa293', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('92aa3fea-033c-4304-9f55-b0e3c44aa293', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('92aa3fea-033c-4304-9f55-b0e3c44aa293', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('92aa3fea-033c-4304-9f55-b0e3c44aa293', 'clientHost', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('92aa3fea-033c-4304-9f55-b0e3c44aa293', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b358799f-f839-42c5-808c-1c796e00c832', 'client_id', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b358799f-f839-42c5-808c-1c796e00c832', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b358799f-f839-42c5-808c-1c796e00c832', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b358799f-f839-42c5-808c-1c796e00c832', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b358799f-f839-42c5-808c-1c796e00c832', 'client_id', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b358799f-f839-42c5-808c-1c796e00c832', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9eb71d18-3f7b-44ee-bed1-1d652273a3fe', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9eb71d18-3f7b-44ee-bed1-1d652273a3fe', 'false', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('9eb71d18-3f7b-44ee-bed1-1d652273a3fe', 'false', 'lightweight.claim');


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) VALUES ('99df8a6f-6238-421f-a213-77c5c1ca6a2b', 60, 300, 300, NULL, NULL, NULL, true, false, 0, NULL, 'app', 0, NULL, false, false, true, false, 'EXTERNAL', 1800, 36000, false, false, '41663dc7-1a06-4376-82f2-108fd894234c', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', 'efbdddc5-5e69-41ff-8f1c-30d8a3b1efac', 'd93f4b4c-8b4e-4b13-9971-cc9f277c6b66', '7ff94ec7-ac91-4b17-83f7-a23279f2d8a3', 'b91109f8-1911-44e0-8dea-9c7b8407ae1b', '0bc82491-5be9-4596-9264-c1b14efeffb4', 2592000, false, 900, true, false, '0c636876-3cac-4960-82b1-064d665274ee', 0, false, 0, 0, '26d286ff-9c63-499e-9b66-56e55b7105d3');
INSERT INTO public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) VALUES ('5ebb9076-4db1-482d-9e07-c56acd16b969', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, '895ba852-18c4-4275-9582-a9b97240d710', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '3652e908-ea1e-42cf-b479-b4865418d51b', 'c8416e49-d2c0-4fe9-8a33-d90489d296b6', '58143a22-fcaf-4443-83e4-f5a9e6eb5e57', '76f8f2be-cfb6-4867-ae24-6a840c9a7de0', '320d1295-2201-405e-b579-282c9873cdec', 2592000, false, 900, true, false, '6d2f0e18-4502-43a0-9c70-f40c14948488', 0, false, 0, 0, '7e2f0283-751d-4a2e-bc21-7726beffc34e');


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicyReportOnly', '5ebb9076-4db1-482d-9e07-c56acd16b969', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xContentTypeOptions', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'nosniff');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.referrerPolicy', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'no-referrer');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xRobotsTag', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'none');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xFrameOptions', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'SAMEORIGIN');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicy', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xXSSProtection', '5ebb9076-4db1-482d-9e07-c56acd16b969', '1; mode=block');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.strictTransportSecurity', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'max-age=31536000; includeSubDomains');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('bruteForceProtected', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('permanentLockout', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxTemporaryLockouts', '5ebb9076-4db1-482d-9e07-c56acd16b969', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxFailureWaitSeconds', '5ebb9076-4db1-482d-9e07-c56acd16b969', '900');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('minimumQuickLoginWaitSeconds', '5ebb9076-4db1-482d-9e07-c56acd16b969', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('waitIncrementSeconds', '5ebb9076-4db1-482d-9e07-c56acd16b969', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('quickLoginCheckMilliSeconds', '5ebb9076-4db1-482d-9e07-c56acd16b969', '1000');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxDeltaTimeSeconds', '5ebb9076-4db1-482d-9e07-c56acd16b969', '43200');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('failureFactor', '5ebb9076-4db1-482d-9e07-c56acd16b969', '30');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('realmReusableOtpCode', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('firstBrokerLoginFlowId', '5ebb9076-4db1-482d-9e07-c56acd16b969', '4723fabb-87c7-4ce0-93ab-f36dbf7744be');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('displayName', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'Keycloak');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('displayNameHtml', '5ebb9076-4db1-482d-9e07-c56acd16b969', '<div class="kc-logo-text"><span>Keycloak</span></div>');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('defaultSignatureAlgorithm', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'RS256');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespanEnabled', '5ebb9076-4db1-482d-9e07-c56acd16b969', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespan', '5ebb9076-4db1-482d-9e07-c56acd16b969', '5184000');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('bruteForceProtected', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('permanentLockout', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxTemporaryLockouts', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxFailureWaitSeconds', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '900');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('minimumQuickLoginWaitSeconds', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('waitIncrementSeconds', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('quickLoginCheckMilliSeconds', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '1000');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxDeltaTimeSeconds', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '43200');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('failureFactor', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '30');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('realmReusableOtpCode', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('defaultSignatureAlgorithm', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'RS256');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespanEnabled', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespan', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '5184000');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('actionTokenGeneratedByAdminLifespan', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '43200');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('actionTokenGeneratedByUserLifespan', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '300');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('oauth2DeviceCodeLifespan', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '600');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('oauth2DevicePollingInterval', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '5');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpEntityName', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'keycloak');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicySignatureAlgorithms', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'ES256');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpId', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAttestationConveyancePreference', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAuthenticatorAttachment', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRequireResidentKey', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyUserVerificationRequirement', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyCreateTimeout', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegister', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpEntityNamePasswordless', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'keycloak');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicySignatureAlgorithmsPasswordless', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'ES256');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpIdPasswordless', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAttestationConveyancePreferencePasswordless', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAuthenticatorAttachmentPasswordless', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRequireResidentKeyPasswordless', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyUserVerificationRequirementPasswordless', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyCreateTimeoutPasswordless', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('cibaBackchannelTokenDeliveryMode', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'poll');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('cibaExpiresIn', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '120');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('cibaInterval', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '5');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('cibaAuthRequestedUserHint', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'login_hint');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('parRequestUriLifespan', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('firstBrokerLoginFlowId', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'dca0f4f3-d3a2-428e-9bc0-ab6af572ec2a');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('frontendUrl', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('acr.loa.map', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '{}');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('displayName', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('displayNameHtml', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('clientSessionIdleTimeout', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('clientSessionMaxLifespan', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('clientOfflineSessionIdleTimeout', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('clientOfflineSessionMaxLifespan', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('client-policies.profiles', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '{"profiles":[]}');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('client-policies.policies', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '{"policies":[]}');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicyReportOnly', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xContentTypeOptions', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'nosniff');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.referrerPolicy', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'no-referrer');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xRobotsTag', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'none');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xFrameOptions', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'SAMEORIGIN');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicy', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xXSSProtection', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', '1; mode=block');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.strictTransportSecurity', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'max-age=31536000; includeSubDomains');


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.realm_events_listeners (realm_id, value) VALUES ('5ebb9076-4db1-482d-9e07-c56acd16b969', 'jboss-logging');
INSERT INTO public.realm_events_listeners (realm_id, value) VALUES ('99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'jboss-logging');


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.realm_required_credential (type, form_label, input, secret, realm_id) VALUES ('password', 'password', true, true, '5ebb9076-4db1-482d-9e07-c56acd16b969');
INSERT INTO public.realm_required_credential (type, form_label, input, secret, realm_id) VALUES ('password', 'password', true, true, '99df8a6f-6238-421f-a213-77c5c1ca6a2b');


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.redirect_uris (client_id, value) VALUES ('19677387-4876-4acd-8fda-69899b89f956', '/realms/master/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', '/realms/master/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', '/admin/master/console/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('1f26f5af-8b3b-4816-b67e-66de6cff07d5', '/realms/app/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', '/realms/app/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', '/admin/app/console/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', 'http://localhost:3000');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', 'http://localhost:3000/*');


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('51c44be0-ec82-4b10-a973-813981c30372', 'VERIFY_EMAIL', 'Verify Email', '5ebb9076-4db1-482d-9e07-c56acd16b969', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('a43ac044-874f-4da2-a90a-db2c87aeb209', 'UPDATE_PROFILE', 'Update Profile', '5ebb9076-4db1-482d-9e07-c56acd16b969', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('181ed344-16fe-41cd-b4d0-9f402d736fd0', 'CONFIGURE_TOTP', 'Configure OTP', '5ebb9076-4db1-482d-9e07-c56acd16b969', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('ed4b7362-283d-4ac3-8b60-eaa13c9efd2e', 'UPDATE_PASSWORD', 'Update Password', '5ebb9076-4db1-482d-9e07-c56acd16b969', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('46598ad1-56b2-4928-b101-ac6c41344f8e', 'TERMS_AND_CONDITIONS', 'Terms and Conditions', '5ebb9076-4db1-482d-9e07-c56acd16b969', false, false, 'TERMS_AND_CONDITIONS', 20);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('6a3036b6-f924-46e5-aff1-162fd2f1ab5d', 'delete_account', 'Delete Account', '5ebb9076-4db1-482d-9e07-c56acd16b969', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('d335db14-e2da-47ca-aea2-d6250dc61991', 'delete_credential', 'Delete Credential', '5ebb9076-4db1-482d-9e07-c56acd16b969', true, false, 'delete_credential', 100);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('4b2b5119-e091-4397-a3dd-4bc0facc788f', 'update_user_locale', 'Update User Locale', '5ebb9076-4db1-482d-9e07-c56acd16b969', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('615b7e4e-21ed-4de8-9cf6-de587740466b', 'webauthn-register', 'Webauthn Register', '5ebb9076-4db1-482d-9e07-c56acd16b969', true, false, 'webauthn-register', 70);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('7efe2ce9-4e9e-4313-8413-b30a5ae22bb1', 'webauthn-register-passwordless', 'Webauthn Register Passwordless', '5ebb9076-4db1-482d-9e07-c56acd16b969', true, false, 'webauthn-register-passwordless', 80);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('285ff7d6-6f61-4c23-8939-e5ba27d0dadb', 'VERIFY_PROFILE', 'Verify Profile', '5ebb9076-4db1-482d-9e07-c56acd16b969', true, false, 'VERIFY_PROFILE', 90);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('9ec6dda7-22e5-47bc-92e3-3bba11b00c10', 'VERIFY_EMAIL', 'Verify Email', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('7eb503a0-06f3-4e40-abe6-d2ee154547b2', 'UPDATE_PROFILE', 'Update Profile', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('0d7c6384-a136-4346-b8ad-62f72a316e44', 'CONFIGURE_TOTP', 'Configure OTP', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('1e38a88d-8ec6-458e-bb91-07c33084f748', 'UPDATE_PASSWORD', 'Update Password', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('265f1614-51d3-407c-bc61-6f97ad30b250', 'TERMS_AND_CONDITIONS', 'Terms and Conditions', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', false, false, 'TERMS_AND_CONDITIONS', 20);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('3c12c600-f4e4-4a89-9b91-346311d29f8c', 'delete_account', 'Delete Account', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('abef1a02-18d1-4f5a-af16-d1c2995cc12a', 'delete_credential', 'Delete Credential', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', true, false, 'delete_credential', 100);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('f85f7ee0-9b0b-4279-a2e2-4a88aabc5ac2', 'update_user_locale', 'Update User Locale', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('dca4a9de-e89e-4f78-9658-8ab637a32fda', 'webauthn-register', 'Webauthn Register', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', true, false, 'webauthn-register', 70);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('3183919c-7892-4767-a508-6424c1812200', 'webauthn-register-passwordless', 'Webauthn Register Passwordless', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', true, false, 'webauthn-register-passwordless', 80);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('7a7ff15c-b7b9-4ed8-9edd-c970f48f1153', 'VERIFY_PROFILE', 'Verify Profile', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', true, false, 'VERIFY_PROFILE', 90);


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', '97f7b4b2-02c4-45b4-bb65-898c57ebe598');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('cb52ede1-9b0c-4b7f-8b21-1349568b79d6', 'd20d1b7e-be89-40b3-978a-f92b9a49a4df');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', '251a204f-7763-409d-b3b3-1db236fd0bbd');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('cd19c842-e87d-4aa2-91b4-dfe5159c1421', 'd00bb70a-48e1-4e60-8792-279582db4801');


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('261552d5-3a9f-4f55-9858-e926850d40f1', NULL, '16b5fd70-693d-4cb6-b530-90c9076e3d56', false, true, NULL, NULL, NULL, '5ebb9076-4db1-482d-9e07-c56acd16b969', 'admin', 1720432075002, NULL, 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('ff9dc811-eac6-4291-806c-18a7467bbb4e', NULL, '0cfe5cae-b3b3-4f12-91bf-5c731a020862', false, true, NULL, NULL, NULL, '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'service-account-app-server-dev', 1720442881793, '3461d02f-8577-4d1f-8a10-761f7d545fa7', 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('c2f50965-b151-4b33-acec-9d7a5e51c2c5', 'user@app.com', 'user@app.com', true, true, NULL, 'Astarion', 'Ancunin', '99df8a6f-6238-421f-a213-77c5c1ca6a2b', 'username', 1720443390262, NULL, 0);


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('7e2f0283-751d-4a2e-bc21-7726beffc34e', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('99a3e5f0-7a83-400d-acee-80a4a99016a9', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('b594a449-8b15-4223-a698-560f86a16eda', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('b7b75367-19f6-4ff4-97b6-06d7c10a3235', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('ec021be9-50d2-4a57-b295-dce2c10ce220', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('c36177b5-c4ea-4556-b079-d2571178ab12', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('e11ed994-d2cb-40d7-9f54-42370f7e75da', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('f18740c4-70ef-498f-8ba7-cbeb1b665696', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('738b8dff-3a59-449a-8247-fbe5d572bf4d', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('a8bf7fd1-7b62-42a6-a73c-b799e4660cc5', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8f7554bb-b099-47a4-83a9-75dec22c5f89', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('9aa232f7-7ef6-4404-8d16-4fb5875987b2', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('45f501ef-38e8-4190-abde-1f2f56a9dab5', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('16c3bb3b-111c-4808-a113-f6b9a00f54a3', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('83d531ff-af1d-4b08-b517-6d959f4f840c', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('3e4bb3b7-05e0-4998-a5b3-1ce558a0ecbb', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('e1524005-7a12-4eaa-a449-a8b42b71ff91', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('7e8fd0ae-3a6d-429f-8196-717bae270e3a', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('e9786630-4eb2-4989-a593-1c9c674c62d2', '261552d5-3a9f-4f55-9858-e926850d40f1');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('26d286ff-9c63-499e-9b66-56e55b7105d3', 'ff9dc811-eac6-4291-806c-18a7467bbb4e');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('26d286ff-9c63-499e-9b66-56e55b7105d3', 'c2f50965-b151-4b33-acec-9d7a5e51c2c5');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('85d2c08c-fc30-4a01-9a9e-d6c1507c9500', 'c2f50965-b151-4b33-acec-9d7a5e51c2c5');


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: user
--



--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.web_origins (client_id, value) VALUES ('3b93c3b5-76f5-4ec2-a887-5057c218e2ee', '+');
INSERT INTO public.web_origins (client_id, value) VALUES ('5d7f64c6-3613-4d41-8826-0a9df34f1bac', '+');
INSERT INTO public.web_origins (client_id, value) VALUES ('3461d02f-8577-4d1f-8a10-761f7d545fa7', '+');
INSERT INTO public.web_origins (client_id, value) VALUES ('a814b9f6-db6e-4dd2-91be-ee4f76696fd6', '+');


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

