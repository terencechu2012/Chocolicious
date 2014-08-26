insert into users values('terence', 'password', null, null, 'S123E');
insert into users values('normal', 'password', null, null, 'S123E');
insert into users values('clubfinsec', 'password', null, null, 'S123E');
insert into users values('cbdfinsec', 'password', null, null, 'S123E');

insert into clubs values('fcp', 'clubfinsec', 'terence', 'ICON', 'francophiles', null, null);
insert into clubs values('tm', 'clubfinsec', 'terence', 'ICON', 'truly malaysia', null, null);
insert into clubs values('icon', 'cbdfinsec', 'terence', 'cbd', 'icon', null, null);

insert into clubusers values(1, 'terence', 'fcp', 'president', null,null);
insert into clubusers values(2, 'terence', 'tm', 'president', null,null);
insert into clubusers values(3, 'clubfinsec', 'fcp', 'clubfinsec', null,null);
insert into clubusers values(4, 'clubfinsec', 'tm', 'clubfinsec', null,null);
insert into clubusers values(5, 'normal', 'fcp', 'normal', null,null);
insert into clubusers values(6, 'cbdfinsec', 'icon', 'cbdfinsec', null,null);

select * from users;

select * from clubusers;

select * from claims;

