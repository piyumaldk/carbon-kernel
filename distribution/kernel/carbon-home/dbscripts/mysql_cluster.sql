CREATE TABLE IF NOT EXISTS REG_CLUSTER_LOCK (
             REG_LOCK_NAME VARCHAR (20),
             REG_LOCK_STATUS VARCHAR (20),
             REG_LOCKED_TIME TIMESTAMP,
             REG_TENANT_ID INTEGER DEFAULT 0,
             PRIMARY KEY (REG_LOCK_NAME)
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS REG_LOG (
             REG_LOG_ID INTEGER AUTO_INCREMENT,
             REG_PATH VARCHAR (750),
             REG_USER_ID VARCHAR (255) NOT NULL,
             REG_LOGGED_TIME TIMESTAMP NOT NULL,
             REG_ACTION INTEGER NOT NULL,
             REG_ACTION_DATA VARCHAR (500),
             REG_TENANT_ID INTEGER DEFAULT 0,
             PRIMARY KEY (REG_LOG_ID, REG_TENANT_ID)
)ENGINE NDB;

-- The REG_PATH_VALUE should be less than 767 bytes, and hence was fixed at 750.
-- See CARBON-5917.

CREATE TABLE IF NOT EXISTS REG_PATH(
             REG_PATH_ID INTEGER NOT NULL AUTO_INCREMENT,
             REG_PATH_VALUE VARCHAR(750) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
             REG_PATH_PARENT_ID INTEGER,
             REG_TENANT_ID INTEGER DEFAULT 0,
             CONSTRAINT PK_REG_PATH PRIMARY KEY(REG_PATH_ID, REG_TENANT_ID),
             CONSTRAINT UNIQUE_REG_PATH_TENANT_ID UNIQUE (REG_PATH_VALUE,REG_TENANT_ID)
)ENGINE NDB;


CREATE TABLE IF NOT EXISTS REG_CONTENT (
             REG_CONTENT_ID INTEGER NOT NULL AUTO_INCREMENT,
             REG_CONTENT_DATA LONGBLOB,
             REG_TENANT_ID INTEGER DEFAULT 0,
             CONSTRAINT PK_REG_CONTENT PRIMARY KEY(REG_CONTENT_ID, REG_TENANT_ID)
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS REG_CONTENT_HISTORY (
             REG_CONTENT_ID INTEGER NOT NULL,
             REG_CONTENT_DATA LONGBLOB,
             REG_DELETED   SMALLINT,
             REG_TENANT_ID INTEGER DEFAULT 0,
             CONSTRAINT PK_REG_CONTENT_HISTORY PRIMARY KEY(REG_CONTENT_ID, REG_TENANT_ID)
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS REG_RESOURCE (
            REG_PATH_ID         INTEGER NOT NULL,
            REG_NAME            VARCHAR(256) CHARACTER SET latin1 COLLATE latin1_bin,
            REG_VERSION         INTEGER NOT NULL AUTO_INCREMENT,
            REG_MEDIA_TYPE      VARCHAR(500),
            REG_CREATOR         VARCHAR(255) NOT NULL,
            REG_CREATED_TIME    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            REG_LAST_UPDATOR    VARCHAR(255),
            REG_LAST_UPDATED_TIME    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            REG_DESCRIPTION     VARCHAR(1000),
            REG_CONTENT_ID      INTEGER,
            REG_TENANT_ID INTEGER DEFAULT 0,
            REG_UUID VARCHAR(100) NOT NULL,
            CONSTRAINT PK_REG_RESOURCE PRIMARY KEY(REG_VERSION, REG_TENANT_ID)
)ENGINE NDB;


CREATE TABLE IF NOT EXISTS REG_RESOURCE_HISTORY (
            REG_PATH_ID         INTEGER NOT NULL,
            REG_NAME            VARCHAR(256),
            REG_VERSION         INTEGER NOT NULL,
            REG_MEDIA_TYPE      VARCHAR(500),
            REG_CREATOR         VARCHAR(255) NOT NULL,
            REG_CREATED_TIME    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            REG_LAST_UPDATOR    VARCHAR(255),
            REG_LAST_UPDATED_TIME    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            REG_DESCRIPTION     VARCHAR(1000),
            REG_CONTENT_ID      INTEGER,
            REG_DELETED         SMALLINT,
            REG_TENANT_ID INTEGER DEFAULT 0,
            REG_UUID VARCHAR(100) NOT NULL,
            CONSTRAINT PK_REG_RESOURCE_HISTORY PRIMARY KEY(REG_VERSION, REG_TENANT_ID)
)ENGINE NDB;


CREATE TABLE IF NOT EXISTS REG_COMMENT (
            REG_ID        INTEGER NOT NULL AUTO_INCREMENT,
            REG_COMMENT_TEXT      VARCHAR(500) NOT NULL,
            REG_USER_ID           VARCHAR(255) NOT NULL,
            REG_COMMENTED_TIME    TIMESTAMP NOT NULL,
            REG_TENANT_ID INTEGER DEFAULT 0,
            CONSTRAINT PK_REG_COMMENT PRIMARY KEY(REG_ID, REG_TENANT_ID)
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS REG_RESOURCE_COMMENT (
            ID                      INTEGER NOT NULL AUTO_INCREMENT,
            REG_COMMENT_ID          INTEGER NOT NULL,
            REG_VERSION             INTEGER,
            REG_PATH_ID             INTEGER,
            REG_RESOURCE_NAME       VARCHAR(256),
            REG_TENANT_ID INTEGER DEFAULT 0,
            PRIMARY KEY(ID)
)ENGINE NDB;


CREATE TABLE IF NOT EXISTS REG_RATING (
            REG_ID     INTEGER NOT NULL AUTO_INCREMENT,
            REG_RATING        INTEGER NOT NULL,
            REG_USER_ID       VARCHAR(255) NOT NULL,
            REG_RATED_TIME    TIMESTAMP NOT NULL,
            REG_TENANT_ID INTEGER DEFAULT 0,
            CONSTRAINT PK_REG_RATING PRIMARY KEY(REG_ID, REG_TENANT_ID)
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS REG_RESOURCE_RATING (
            ID                      INTEGER NOT NULL AUTO_INCREMENT,
            REG_RATING_ID           INTEGER NOT NULL,
            REG_VERSION             INTEGER,
            REG_PATH_ID             INTEGER,
            REG_RESOURCE_NAME       VARCHAR(256),
            REG_TENANT_ID INTEGER DEFAULT 0,
            PRIMARY KEY(ID)
)ENGINE NDB;



CREATE TABLE IF NOT EXISTS REG_TAG (
            REG_ID         INTEGER NOT NULL AUTO_INCREMENT,
            REG_TAG_NAME       VARCHAR(500) NOT NULL,
            REG_USER_ID        VARCHAR(255) NOT NULL,
            REG_TAGGED_TIME    TIMESTAMP NOT NULL,
            REG_TENANT_ID INTEGER DEFAULT 0,
            CONSTRAINT PK_REG_TAG PRIMARY KEY(REG_ID, REG_TENANT_ID)
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS REG_RESOURCE_TAG (
            ID                      INTEGER NOT NULL AUTO_INCREMENT,
            REG_TAG_ID              INTEGER NOT NULL,
            REG_VERSION             INTEGER,
            REG_PATH_ID             INTEGER,
            REG_RESOURCE_NAME       VARCHAR(256),
            REG_TENANT_ID INTEGER DEFAULT 0,
            PRIMARY KEY(ID)
)ENGINE NDB;


CREATE TABLE IF NOT EXISTS REG_PROPERTY (
            REG_ID         INTEGER NOT NULL AUTO_INCREMENT,
            REG_NAME       VARCHAR(100) NOT NULL,
            REG_VALUE        VARCHAR(1000),
            REG_TENANT_ID INTEGER DEFAULT 0,
            CONSTRAINT PK_REG_PROPERTY PRIMARY KEY(REG_ID, REG_TENANT_ID)
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS REG_RESOURCE_PROPERTY (
            ID                      INTEGER NOT NULL AUTO_INCREMENT,
            REG_PROPERTY_ID         INTEGER NOT NULL,
            REG_VERSION             INTEGER,
            REG_PATH_ID             INTEGER,
            REG_RESOURCE_NAME       VARCHAR(256),
            REG_TENANT_ID INTEGER DEFAULT 0,
            PRIMARY KEY(ID)
)ENGINE NDB;


-- CREATE TABLE IF NOT EXISTS REG_ASSOCIATIONS (
-- SRC_PATH_ID     INTEGER,
-- SRC_RESOURCE_NAME    VARCHAR(256),
-- SRC_VERSION     INTEGER,
-- TGT_PATH_ID     INTEGER,
-- TGT_RESOURCE_NAME    VARCHAR(256),
-- TGT_VERSION     INTEGER
-- )ENGINE NDB;
-- 



CREATE TABLE IF NOT EXISTS REG_ASSOCIATION (
            REG_ASSOCIATION_ID INTEGER AUTO_INCREMENT,
            REG_SOURCEPATH VARCHAR (750) NOT NULL,
            REG_TARGETPATH VARCHAR (750) NOT NULL,
            REG_ASSOCIATION_TYPE VARCHAR (2000) NOT NULL,
            REG_TENANT_ID INTEGER DEFAULT 0,
            PRIMARY KEY (REG_ASSOCIATION_ID, REG_TENANT_ID)
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS REG_SNAPSHOT (
            REG_SNAPSHOT_ID     INTEGER NOT NULL AUTO_INCREMENT,
            REG_PATH_ID            INTEGER NOT NULL,
            REG_RESOURCE_NAME      VARCHAR(255),
            REG_RESOURCE_VIDS     LONGBLOB NOT NULL,
            REG_TENANT_ID INTEGER DEFAULT 0,
            CONSTRAINT PK_REG_SNAPSHOT PRIMARY KEY(REG_SNAPSHOT_ID, REG_TENANT_ID)
)ENGINE NDB;




-- ################################
-- USER MANAGER TABLES
-- ################################

CREATE TABLE UM_TENANT (
			UM_ID INTEGER NOT NULL AUTO_INCREMENT,
			UM_TENANT_UUID VARCHAR(36) NOT NULL,
	        UM_DOMAIN_NAME VARCHAR(255) NOT NULL,
            UM_EMAIL VARCHAR(255),
            UM_ACTIVE BOOLEAN DEFAULT FALSE,
	        UM_CREATED_DATE TIMESTAMP NOT NULL,
	        UM_USER_CONFIG LONGBLOB,
	        UM_ORG_UUID VARCHAR(36) DEFAULT NULL,
			PRIMARY KEY (UM_ID),
			UNIQUE(UM_DOMAIN_NAME),
			UNIQUE(UM_TENANT_UUID)
)ENGINE NDB;

CREATE TABLE UM_DOMAIN(
            UM_DOMAIN_ID INTEGER NOT NULL AUTO_INCREMENT,
            UM_DOMAIN_NAME VARCHAR(255) NOT NULL,
            UM_TENANT_ID INTEGER DEFAULT 0,
            PRIMARY KEY (UM_DOMAIN_ID, UM_TENANT_ID),
            UNIQUE(UM_DOMAIN_NAME,UM_TENANT_ID)
)ENGINE NDB;

CREATE TABLE UM_USER ( 
             UM_ID INTEGER NOT NULL AUTO_INCREMENT, 
             UM_USER_ID VARCHAR(255) NOT NULL,
             UM_USER_NAME VARCHAR(255) NOT NULL,
             UM_USER_PASSWORD VARCHAR(255) NOT NULL,
             UM_SALT_VALUE VARCHAR(31),
             UM_REQUIRE_CHANGE BOOLEAN DEFAULT FALSE,
             UM_CHANGED_TIME TIMESTAMP NOT NULL,
             UM_TENANT_ID INTEGER DEFAULT 0, 
             PRIMARY KEY (UM_ID, UM_TENANT_ID), 
             UNIQUE(UM_USER_ID),
             UNIQUE(UM_USER_NAME, UM_TENANT_ID)
)ENGINE NDB; 

CREATE UNIQUE INDEX INDEX_UM_USERNAME_UM_TENANT_ID ON UM_USER(UM_USER_NAME, UM_TENANT_ID);

CREATE TABLE UM_SYSTEM_USER ( 
             UM_ID INTEGER NOT NULL AUTO_INCREMENT, 
             UM_USER_NAME VARCHAR(255) NOT NULL, 
             UM_USER_PASSWORD VARCHAR(255) NOT NULL,
             UM_SALT_VALUE VARCHAR(31),
             UM_REQUIRE_CHANGE BOOLEAN DEFAULT FALSE,
             UM_CHANGED_TIME TIMESTAMP NOT NULL,
             UM_TENANT_ID INTEGER DEFAULT 0, 
             PRIMARY KEY (UM_ID, UM_TENANT_ID), 
             UNIQUE(UM_USER_NAME, UM_TENANT_ID)
)ENGINE NDB;

CREATE TABLE UM_ROLE ( 
             UM_ID INTEGER NOT NULL AUTO_INCREMENT, 
             UM_ROLE_NAME VARCHAR(255) NOT NULL,
             UM_TENANT_ID INTEGER DEFAULT 0, 
			 UM_SHARED_ROLE BOOLEAN DEFAULT FALSE, 
             PRIMARY KEY (UM_ID, UM_TENANT_ID),
             UNIQUE(UM_ROLE_NAME, UM_TENANT_ID) 
)ENGINE NDB;

CREATE TABLE UM_MODULE(
	UM_ID INTEGER  NOT NULL AUTO_INCREMENT,
	UM_MODULE_NAME VARCHAR(100),
	UNIQUE(UM_MODULE_NAME),
	PRIMARY KEY(UM_ID)
)ENGINE NDB;

CREATE TABLE UM_MODULE_ACTIONS(
	UM_ACTION VARCHAR(255) NOT NULL,
	UM_MODULE_ID INTEGER NOT NULL,
	PRIMARY KEY(UM_ACTION, UM_MODULE_ID)
)ENGINE NDB;

CREATE TABLE UM_PERMISSION ( 
             UM_ID INTEGER NOT NULL AUTO_INCREMENT, 
             UM_RESOURCE_ID VARCHAR(255) NOT NULL, 
             UM_ACTION VARCHAR(255) NOT NULL, 
             UM_TENANT_ID INTEGER DEFAULT 0, 
		     UM_MODULE_ID INTEGER DEFAULT 0,
		     		 UNIQUE(UM_RESOURCE_ID,UM_ACTION, UM_TENANT_ID),
             PRIMARY KEY (UM_ID, UM_TENANT_ID)
)ENGINE NDB; 


CREATE TABLE UM_ROLE_PERMISSION ( 
             UM_ID INTEGER NOT NULL AUTO_INCREMENT, 
             UM_PERMISSION_ID INTEGER NOT NULL, 
             UM_ROLE_NAME VARCHAR(255) NOT NULL,
             UM_IS_ALLOWED SMALLINT NOT NULL, 
             UM_TENANT_ID INTEGER DEFAULT 0,
			 UM_DOMAIN_ID INTEGER, 
             UNIQUE (UM_ID, UM_PERMISSION_ID, UM_ROLE_NAME, UM_TENANT_ID, UM_DOMAIN_ID),
			 PRIMARY KEY (UM_ID, UM_TENANT_ID, UM_DOMAIN_ID)
)ENGINE NDB; 

-- REMOVED UNIQUE (UM_PERMISSION_ID, UM_ROLE_ID) 
CREATE TABLE UM_USER_PERMISSION ( 
             UM_ID INTEGER NOT NULL AUTO_INCREMENT, 
             UM_PERMISSION_ID INTEGER NOT NULL, 
             UM_USER_NAME VARCHAR(255) NOT NULL,
             UM_IS_ALLOWED SMALLINT NOT NULL,          
             UM_TENANT_ID INTEGER DEFAULT 0, 
             PRIMARY KEY (UM_ID, UM_TENANT_ID)
)ENGINE NDB;

-- REMOVED UNIQUE (UM_PERMISSION_ID, UM_USER_ID) 
CREATE TABLE UM_USER_ROLE ( 
             UM_ID INTEGER NOT NULL AUTO_INCREMENT, 
             UM_ROLE_ID INTEGER NOT NULL, 
             UM_USER_ID INTEGER NOT NULL,
             UM_TENANT_ID INTEGER DEFAULT 0,  
             UNIQUE (UM_USER_ID, UM_ROLE_ID, UM_TENANT_ID), 
             PRIMARY KEY (UM_ID, UM_TENANT_ID)
)ENGINE NDB; 

CREATE TABLE UM_SHARED_USER_ROLE(
    ID         INTEGER NOT NULL AUTO_INCREMENT,
    UM_ROLE_ID INTEGER NOT NULL,
    UM_USER_ID INTEGER NOT NULL,
    UM_USER_TENANT_ID INTEGER NOT NULL,
    UM_ROLE_TENANT_ID INTEGER NOT NULL,
    UNIQUE(UM_USER_ID,UM_ROLE_ID,UM_USER_TENANT_ID, UM_ROLE_TENANT_ID),
    PRIMARY KEY(ID)
)ENGINE NDB;

CREATE TABLE UM_ACCOUNT_MAPPING(
	UM_ID INTEGER NOT NULL AUTO_INCREMENT,
	UM_USER_NAME VARCHAR(255) NOT NULL,
	UM_TENANT_ID INTEGER NOT NULL,
	UM_USER_STORE_DOMAIN VARCHAR(100),
	UM_ACC_LINK_ID INTEGER NOT NULL,
	UNIQUE(UM_USER_NAME, UM_TENANT_ID, UM_USER_STORE_DOMAIN, UM_ACC_LINK_ID),
	PRIMARY KEY (UM_ID)
)ENGINE NDB;

CREATE TABLE UM_USER_ATTRIBUTE ( 
            UM_ID INTEGER NOT NULL AUTO_INCREMENT, 
            UM_ATTR_NAME VARCHAR(255) NOT NULL, 
            UM_ATTR_VALUE VARCHAR(1024), 
            UM_PROFILE_ID VARCHAR(255), 
            UM_USER_ID INTEGER, 
            UM_TENANT_ID INTEGER DEFAULT 0, 
            PRIMARY KEY (UM_ID, UM_TENANT_ID)
)ENGINE NDB; 



CREATE TABLE UM_DIALECT( 
            UM_ID INTEGER NOT NULL AUTO_INCREMENT, 
            UM_DIALECT_URI VARCHAR(255) NOT NULL, 
            UM_TENANT_ID INTEGER DEFAULT 0, 
            UNIQUE(UM_DIALECT_URI, UM_TENANT_ID), 
            PRIMARY KEY (UM_ID, UM_TENANT_ID)
)ENGINE NDB; 

CREATE TABLE UM_CLAIM( 
            UM_ID INTEGER NOT NULL AUTO_INCREMENT, 
            UM_DIALECT_ID INTEGER NOT NULL, 
            UM_CLAIM_URI VARCHAR(255) NOT NULL, 
            UM_DISPLAY_TAG VARCHAR(255), 
            UM_DESCRIPTION VARCHAR(255), 
			UM_MAPPED_ATTRIBUTE_DOMAIN VARCHAR(255),
            UM_MAPPED_ATTRIBUTE VARCHAR(255), 
            UM_REG_EX VARCHAR(255), 
            UM_SUPPORTED SMALLINT, 
            UM_REQUIRED SMALLINT, 
            UM_DISPLAY_ORDER INTEGER,
	        UM_CHECKED_ATTRIBUTE SMALLINT,
	        UM_READ_ONLY SMALLINT,
            UM_TENANT_ID INTEGER DEFAULT 0, 
            UNIQUE(UM_DIALECT_ID, UM_CLAIM_URI, UM_TENANT_ID), 
            PRIMARY KEY (UM_ID, UM_TENANT_ID)
)ENGINE NDB; 

CREATE TABLE UM_PROFILE_CONFIG( 
            UM_ID INTEGER NOT NULL AUTO_INCREMENT, 
            UM_DIALECT_ID INTEGER NOT NULL, 
            UM_PROFILE_NAME VARCHAR(255), 
            UM_TENANT_ID INTEGER DEFAULT 0, 
            PRIMARY KEY (UM_ID, UM_TENANT_ID)
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS UM_CLAIM_BEHAVIOR(
    UM_ID INTEGER NOT NULL AUTO_INCREMENT,
    UM_PROFILE_ID INTEGER,
    UM_CLAIM_ID INTEGER,
    UM_BEHAVIOUR SMALLINT,
    UM_TENANT_ID INTEGER DEFAULT 0,
    FOREIGN KEY(UM_PROFILE_ID, UM_TENANT_ID) REFERENCES UM_PROFILE_CONFIG(UM_ID,UM_TENANT_ID),
    FOREIGN KEY(UM_CLAIM_ID, UM_TENANT_ID) REFERENCES UM_CLAIM(UM_ID,UM_TENANT_ID),
    PRIMARY KEY(UM_ID, UM_TENANT_ID)
)ENGINE NDB;

CREATE TABLE UM_HYBRID_ROLE(
            UM_ID INTEGER NOT NULL AUTO_INCREMENT,
            UM_ROLE_NAME VARCHAR(255) NOT NULL,
            UM_TENANT_ID INTEGER DEFAULT 0,
            PRIMARY KEY (UM_ID, UM_TENANT_ID),
            UNIQUE (UM_ROLE_NAME, UM_TENANT_ID)
)ENGINE NDB;

CREATE TABLE UM_HYBRID_USER_ROLE(
            UM_ID INTEGER NOT NULL AUTO_INCREMENT,
            UM_USER_NAME VARCHAR(255),
            UM_ROLE_ID INTEGER NOT NULL,
            UM_TENANT_ID INTEGER DEFAULT 0,
            UM_DOMAIN_ID INTEGER,
            UNIQUE (UM_USER_NAME, UM_ROLE_ID, UM_TENANT_ID, UM_DOMAIN_ID),
            FOREIGN KEY (UM_ROLE_ID, UM_TENANT_ID) REFERENCES UM_HYBRID_ROLE(UM_ID, UM_TENANT_ID) ON DELETE CASCADE,
            FOREIGN KEY (UM_DOMAIN_ID, UM_TENANT_ID) REFERENCES UM_DOMAIN(UM_DOMAIN_ID, UM_TENANT_ID) ON DELETE CASCADE,
            PRIMARY KEY (UM_ID, UM_TENANT_ID)
)ENGINE NDB;

CREATE TABLE UM_HYBRID_GROUP_ROLE(
            UM_ID INTEGER NOT NULL AUTO_INCREMENT,
            UM_GROUP_NAME VARCHAR(255),
            UM_ROLE_ID INTEGER NOT NULL,
            UM_TENANT_ID INTEGER DEFAULT 0,
            UM_DOMAIN_ID INTEGER,
            UNIQUE (UM_GROUP_NAME, UM_ROLE_ID, UM_TENANT_ID, UM_DOMAIN_ID),
            FOREIGN KEY (UM_ROLE_ID, UM_TENANT_ID) REFERENCES UM_HYBRID_ROLE(UM_ID, UM_TENANT_ID) ON DELETE CASCADE,
            FOREIGN KEY (UM_DOMAIN_ID, UM_TENANT_ID) REFERENCES UM_DOMAIN(UM_DOMAIN_ID, UM_TENANT_ID) ON DELETE CASCADE,
            PRIMARY KEY (UM_ID, UM_TENANT_ID)
)ENGINE NDB;

CREATE TABLE UM_SYSTEM_ROLE(
            UM_ID INTEGER NOT NULL AUTO_INCREMENT,
            UM_ROLE_NAME VARCHAR(255) NOT NULL,
            UM_TENANT_ID INTEGER DEFAULT 0,
            PRIMARY KEY (UM_ID, UM_TENANT_ID),
            UNIQUE(UM_ROLE_NAME,UM_TENANT_ID)
)ENGINE NDB;

CREATE TABLE UM_SYSTEM_USER_ROLE(
            UM_ID INTEGER NOT NULL AUTO_INCREMENT,
            UM_USER_NAME VARCHAR(255),
            UM_ROLE_ID INTEGER NOT NULL,
            UM_TENANT_ID INTEGER DEFAULT 0,
            UNIQUE (UM_USER_NAME, UM_ROLE_ID, UM_TENANT_ID),
            PRIMARY KEY (UM_ID, UM_TENANT_ID)
)ENGINE NDB;

CREATE TABLE UM_HYBRID_REMEMBER_ME(
            UM_ID INTEGER NOT NULL AUTO_INCREMENT,
            UM_USER_NAME VARCHAR(255) NOT NULL,
            UM_COOKIE_VALUE VARCHAR(1024),
            UM_CREATED_TIME TIMESTAMP,
            UM_TENANT_ID INTEGER DEFAULT 0,
            PRIMARY KEY (UM_ID, UM_TENANT_ID)
)ENGINE NDB;

CREATE TABLE UM_CUSTOM_USERSTORE(
            UM_ID INTEGER NOT NULL AUTO_INCREMENT,
            UM_USERSTORE_PROPERTY VARCHAR(255) NOT NULL,
            UM_USERSTORE_VALUE VARCHAR(500) NOT NULL,
            UM_TENANT_ID INTEGER DEFAULT 0,
            PRIMARY KEY (UM_ID, UM_TENANT_ID)
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS UM_UUID_DOMAIN_MAPPER (
            UM_ID INTEGER NOT NULL AUTO_INCREMENT,
            UM_USER_ID VARCHAR(255) NOT NULL,
            UM_DOMAIN_ID INTEGER NOT NULL,
            UM_TENANT_ID INTEGER DEFAULT 0,
            PRIMARY KEY (UM_ID),
            UNIQUE (UM_USER_ID),
            FOREIGN KEY (UM_DOMAIN_ID, UM_TENANT_ID) REFERENCES UM_DOMAIN(UM_DOMAIN_ID, UM_TENANT_ID)
)ENGINE NDB;

CREATE INDEX UUID_DM_UID_TID ON UM_UUID_DOMAIN_MAPPER(UM_USER_ID, UM_TENANT_ID);

CREATE TABLE IF NOT EXISTS UM_GROUP_UUID_DOMAIN_MAPPER (
            UM_ID INTEGER NOT NULL AUTO_INCREMENT,
            UM_GROUP_ID VARCHAR(255) NOT NULL,
            UM_DOMAIN_ID INTEGER NOT NULL,
            UM_TENANT_ID INTEGER DEFAULT 0,
            PRIMARY KEY (UM_ID),
            UNIQUE (UM_GROUP_ID),
            FOREIGN KEY (UM_DOMAIN_ID, UM_TENANT_ID) REFERENCES UM_DOMAIN(UM_DOMAIN_ID, UM_TENANT_ID)
)ENGINE NDB;

CREATE INDEX GRP_UUID_DM_GRP_ID_TID ON UM_GROUP_UUID_DOMAIN_MAPPER(UM_GROUP_ID, UM_TENANT_ID);

-- ################################
-- ORGANIZATION MANAGEMENT TABLES
-- ################################

CREATE TABLE IF NOT EXISTS UM_ORG (
            UM_ID VARCHAR(36) NOT NULL,
            UM_ORG_NAME VARCHAR(255) NOT NULL,
            UM_ORG_DESCRIPTION VARCHAR(1024),
            UM_CREATED_TIME TIMESTAMP NOT NULL,
            UM_LAST_MODIFIED TIMESTAMP NOT NULL,
            UM_STATUS VARCHAR(255) DEFAULT 'ACTIVE' NOT NULL,
            UM_PARENT_ID VARCHAR(36),
            UM_ORG_TYPE VARCHAR(100) NOT NULL,
            PRIMARY KEY (UM_ID),
            UNIQUE(UM_ORG_NAME),
            FOREIGN KEY (UM_PARENT_ID) REFERENCES UM_ORG(UM_ID) ON DELETE CASCADE
)ENGINE NDB;

INSERT IGNORE INTO UM_ORG (UM_ID, UM_ORG_NAME, UM_ORG_DESCRIPTION, UM_CREATED_TIME, UM_LAST_MODIFIED, UM_STATUS, UM_ORG_TYPE)
VALUES ('root4a8d-113f-4211-a0d5-efe36b082211', 'ROOT', 'This is the root organization.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'ACTIVE', 'TENANT');

CREATE TABLE IF NOT EXISTS UM_ORG_ATTRIBUTE (
            UM_ID INTEGER NOT NULL AUTO_INCREMENT,
            UM_ORG_ID VARCHAR(36) NOT NULL,
            UM_ATTRIBUTE_KEY VARCHAR(255) NOT NULL,
            UM_ATTRIBUTE_VALUE VARCHAR(512),
            PRIMARY KEY (UM_ID),
            UNIQUE (UM_ORG_ID, UM_ATTRIBUTE_KEY),
            FOREIGN KEY (UM_ORG_ID) REFERENCES UM_ORG(UM_ID) ON DELETE CASCADE
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS UM_ORG_ROLE (
            UM_ROLE_ID VARCHAR(255) NOT NULL,
            UM_ROLE_NAME VARCHAR(255) NOT NULL,
            UM_ORG_ID VARCHAR(36) NOT NULL,
            PRIMARY KEY(UM_ROLE_ID),
            CONSTRAINT FK_UM_ORG_ROLE_UM_ORG FOREIGN KEY (UM_ORG_ID) REFERENCES UM_ORG (UM_ID) ON DELETE CASCADE
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS UM_ORG_PERMISSION(
            UM_ID INTEGER NOT NULL AUTO_INCREMENT,
            UM_RESOURCE_ID VARCHAR(255) NOT NULL,
            UM_ACTION VARCHAR(255) NOT NULL,
            UM_TENANT_ID INTEGER DEFAULT 0,
            PRIMARY KEY (UM_ID)
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS UM_ORG_ROLE_USER (
            UM_USER_ID VARCHAR(255) NOT NULL,
            UM_ROLE_ID VARCHAR(255) NOT NULL,
            CONSTRAINT FK_UM_ORG_ROLE_USER_UM_ORG_ROLE FOREIGN KEY (UM_ROLE_ID) REFERENCES UM_ORG_ROLE(UM_ROLE_ID) ON DELETE CASCADE
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS UM_ORG_ROLE_GROUP(
            UM_GROUP_ID VARCHAR(255) NOT NULL,
            UM_ROLE_ID VARCHAR(255) NOT NULL,
            CONSTRAINT FK_UM_ORG_ROLE_GROUP_UM_ORG_ROLE FOREIGN KEY (UM_ROLE_ID) REFERENCES UM_ORG_ROLE(UM_ROLE_ID) ON DELETE CASCADE
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS UM_ORG_ROLE_PERMISSION(
            UM_PERMISSION_ID INTEGER NOT NULL,
            UM_ROLE_ID VARCHAR(255) NOT NULL,
            CONSTRAINT FK_UM_ORG_ROLE_PERMISSION_UM_ORG_ROLE FOREIGN KEY (UM_ROLE_ID) REFERENCES UM_ORG_ROLE(UM_ROLE_ID) ON DELETE CASCADE,
            CONSTRAINT FK_UM_ORG_ROLE_PERMISSION_UM_ORG_PERMISSION FOREIGN KEY (UM_PERMISSION_ID) REFERENCES UM_ORG_PERMISSION(UM_ID) ON DELETE CASCADE
)ENGINE NDB;

CREATE TABLE IF NOT EXISTS UM_ORG_HIERARCHY (
            UM_PARENT_ID VARCHAR(36) NOT NULL,
            UM_ID VARCHAR(36) NOT NULL,
            DEPTH INTEGER,
            PRIMARY KEY (UM_PARENT_ID, UM_ID),
            FOREIGN KEY (UM_PARENT_ID) REFERENCES UM_ORG(UM_ID) ON DELETE CASCADE,
            FOREIGN KEY (UM_ID) REFERENCES UM_ORG(UM_ID) ON DELETE CASCADE
)ENGINE NDB;

INSERT IGNORE INTO UM_ORG_HIERARCHY (UM_PARENT_ID, UM_ID, DEPTH)
VALUES ('root4a8d-113f-4211-a0d5-efe36b082211', 'root4a8d-113f-4211-a0d5-efe36b082211', 0);
