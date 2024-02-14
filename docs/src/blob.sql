create table images (
    name text not null,
    content blob
);

insert into images (name, content) values
('biohazard', readfile('res/img/biohazard.png')),
('crush', readfile('res/img/crush.png')),
('fire', readfile('res/img/fire.png')),
('radioactive', readfile('res/img/radioactive.png')),
('tripping', readfile('res/img/tripping.png'));

select
    name,
    length(content)
from images;
