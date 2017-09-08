Oracle ACL Configuration on 11g for using Network packages
For HR SCHEMA >>>>>>>>>>>>>>

BEGIN
   DBMS_NETWORK_ACL_ADMIN.CREATE_ACL (
        acl          =>'HR.xml',
        description  => 'ACL for users to send mail.',
        principal    => 'HR', --HR is SCHema Name
        is_grant     => TRUE, --grant true/false
        privilege    => 'connect', --grant privilege
        start_date   => null, --connect start_date null
        end_date     => null
    );
END;
/

BEGIN
  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(
        acl         => 'HR.xml',
        principal   => 'HR',
        is_grant    =>  TRUE,
        privilege   => 'connect');
END;
/

BEGIN
   DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(
     acl         => 'HR.xml',
     host        => '127.0.0.1',
     lower_port => 80);
END;
/

BEGIN
  DBMS_NETWORK_ACL_ADMIN.delete_privilege ( 
    acl         => 'HR.xml', 
    principal   => 'MN',
    is_grant    => TRUE, 
    privilege   => 'connect');
  COMMIT;
END;
/

select grantee , table_name , privilege from dba_tab_privs where table_name = 'UTL_MAIL' and   grantee = 'PUBLIC';


select acl,host,lower_port,upper_port from DBA_NETWORK_ACLS;

select acl,principal,privilege,is_grant from DBA_NETWORK_ACL_PRIVILEGES; 


SELECT HOST, LOWER_PORT, UPPER_PORT, ACL,
   DECODE(
     DBMS_NETWORK_ACL_ADMIN.CHECK_PRIVILEGE_ACLID(aclid,  'SCOTT', 'connect'),
     1, 'GRANTED', 0, 'DENIED', null) PRIVILEGE
FROM DBA_NETWORK_ACLS
WHERE host IN
  (SELECT * FROM      TABLE(DBMS_NETWORK_ACL_UTILITY.DOMAINS('msxsmtp.server.bosch.com')))
 ORDER BY 
  DBMS_NETWORK_ACL_UTILITY.DOMAIN_LEVEL(host) DESC, LOWER_PORT, UPPER_PORT;
  
  BEGIN
  DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(
        acl         => 'HR.xml',
        principal   => 'MN',
        is_grant    =>  TRUE,
        privilege   => 'connect');
END;
/

commit;

BEGIN
   DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(
     acl         => 'HR.xml',
     host        => 'Mail Server name',
     lower_port => 25);
END;
/
commit;


