use prod_health_company1;

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