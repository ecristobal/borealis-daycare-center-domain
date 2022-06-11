-- Table to store addresses

create table addresses
(
    address_id serial
        constraint addresses_pk
            primary key,
    line_1     varchar(200) not null,
    line_2     varchar(200),
    zip_code   int          not null check (zip_code > 0 and zip_code <= 99999),
    city       varchar(100) not null
);

comment on table addresses is 'Table to store addresses for other Borealis tables';

comment on column addresses.address_id is 'Address ID';

comment on column addresses.line_1 is 'Address line 1';

comment on column addresses.line_2 is 'Address line 2';

comment on column addresses.zip_code is 'Address zip code';

comment on column addresses.city is 'Address city';

create unique index addresses_address_id_uindex
    on addresses (address_id);

-- Table to store contact details

create table contacts
(
    contact_id varchar(9)   not null
        constraint contacts_pk
            primary key,
    name       varchar(50)  not null,
    surname    varchar(50)  not null,
    email      varchar(100) not null,
    phone      varchar(20)  not null,
    address    int          not null
        constraint contacts_address_fk
            references addresses
            on update restrict on delete restrict
);

comment on table contacts is 'Table to store contacts for Borealis domains';

comment on column contacts.contact_id is 'Contact ID (in Spain should be the national ID card number)';

comment on column contacts.name is 'Contact name';

comment on column contacts.surname is 'Contact surname';

comment on column contacts.email is 'Contact e-mail address';

comment on column contacts.phone is 'Contact phone number';

comment on column contacts.address is 'Contact address';

create unique index contacts_contact_id_uindex
    on contacts (contact_id);

-- Table to store companies (day care centers' owners)

create table companies
(
    company_id varchar(9) not null
        constraint companies_pk
            primary key
        constraint companies_contacts_fk
            references contacts
            on update restrict on delete restrict,
    contact    varchar(9) not null,
    address    int        not null
        constraint companies_addresses_fk
            references addresses
            on update restrict on delete restrict
);

comment on table companies is 'Table used to store company (i.e. owners of centers) details';

comment on column companies.company_id is 'Company identifier (in Spain it should be the fiscal code identifier)';

comment on column companies.contact is 'Company contact';

comment on column companies.address is 'Company address';

create unique index companies_id_uindex
    on companies (company_id);

-- Table to store day care centers

create table centers
(
    center_id     serial
        constraint centers_pk
            primary key,
    owner_company varchar(9)  not null
        constraint centers_companies_fk
            references companies
            on update restrict on delete restrict,
    center_name   varchar(50) not null,
    address       int         not null
        constraint centers_addresses_fk
            references addresses,
    contact       varchar(9)
        constraint centers_contacts_fk
            references contacts
            on update restrict on delete restrict
);

comment on table centers is 'Table to store day care center details';

comment on column centers.center_id is 'Day care center unique ID';

comment on column centers.owner_company is 'Company owning the day care center';

comment on column centers.center_name is 'Day care center name';

comment on column centers.address is 'Day care center address';

comment on column centers.contact is 'Day care center contact';