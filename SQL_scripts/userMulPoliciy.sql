use prod_health_company1;

# Selection of data from the mapping table (Assignment 1)
select u.userid,u.cssn, '4811' as Dummy_1, '10-ENT'as Dummy_2, u.cfname,u.cmname, u.clname, u.phone1, u.cemail,
case 
	when u.cgender = '0' then 'M' 
    when u.cgender = '1' then 'F' else 'NULL' 
    END AS cgender,
date_format(u.cdob, '%m/%d/%Y') as cdob,
 adr.address1, adr.address2,adr.city,adr.state, adr.zip, 'EM' as Dummy_3,
 p.policy_id, p.edate, pl.plan_name_system,
 date_format(pp.peffective_date,'%m/%d/%Y')as peffective_date,
 case 
	when pt.tier = 'IO' then 'EM' 
    when pt.tier = 'IS' then 'ES' 
    when pt.tier = 'IC' then 'EC' 
    else 'FA' end as tier
 from userinfo as u join cust_addresses as adr
 on u.home_address = adr.address_id
 join policies as p on u.userid = p.policy_userid
 join plan_policies as pp on pp.policy_num = p.policy_id
 join plans as pl on pl.pid = pp.plan_id
 join plan_tier as pt on pt.pid_tier = pl.pid;

# List of userIds with multiple policies
select policy_userid,count(policy_id) as count_policy from policies
group by policy_userid
having count_policy>1
order by count_policy Desc
limit 100;

# User information with multiple policies
select u.userid,u.cfname,u.clname from (
select policy_userid,count(policy_id) as count_policy from policies
group by policy_userid
having count_policy>1
order by count_policy Desc) as result inner join userinfo as u
on u.userid=result.policy_userid
limit 100;