create table {SCHEMA}.time_dim
(
    t_time_sk                 integer               not null,
    t_time_id                 char(16)              not null,
    t_time                    integer               not null,
    t_hour                    integer               not null,
    t_minute                  integer               not null,
    t_second                  integer               not null,
    t_am_pm                   char(2)               not null,
    t_shift                   char(20)              not null,
    t_sub_shift               char(20)              not null,
    t_meal_time               char(20)
);