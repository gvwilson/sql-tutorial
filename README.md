# SQL Tutorial

## Schema and Data

### Machines

```sql
CREATE TABLE machines(
       mach_id text not null,   -- unique ID
       mach_name text not null, -- machine's name
       acquired text            -- purchase date (if known)
);
```

| mach_id |     mach_name      |  acquired  |
|---------|--------------------|------------|
| mach153 | collimating laser  | 2022-05-09 |
| mac9    | Poynting collector | 1998-11-30 |
| mach781 | spin condensor     | 2022-05-08 |
| mach227 | photozygometer     | 2023-02-06 |

### Scientists

```sql
CREATE TABLE scientists(
       sci_id text not null,    -- unique ID
       personal text not null,  -- personal name
       family text not null,    -- family name
       hired text               -- hire date (if known)
);
```

| sci_id  | personal |  family   |   hired    |
|---------|----------|-----------|------------|
| sci9091 | Grace    | Barshan   |            |
| sci4411 | Norbu    | Pilaratan | 2021-07-12 |
| sci4212 | Nica     | Berbelos  | 2021-07-12 |
| sci1729 | Alain    | Berbelos  | 2022-03-01 |

### Experiments

```sql
CREATE TABLE experiments(
       exp_id text not null,    -- unique ID
       exp_name text not null,  -- experiment's name
       exp_date text not null   -- date of experiment
);
```

|  exp_id  |       exp_name        |  exp_date  |
|----------|-----------------------|------------|
| exp-1832 | calibration           | 2018-10-24 |
| exp-4198 | calibration           | 2019-06-20 |
| exp-5283 | calibration           | 2019-07-17 |
| exp-7818 | interferometry        | 2022-08-17 |
| exp-7821 | calibration           | 2022-08-23 |
| exp-7822 | reductive collimation | 2022-09-12 |

### Performed

```sql
CREATE TABLE performed(
       sci_id text not null,    -- scientist key
       exp_id text not null     -- experiment key
);
```
| sci_id  |  exp_id  |
|---------|----------|
| sci9091 | exp-1832 |
| sci9091 | exp-4198 |
| sci9091 | exp-5283 |
| sci1729 | exp-5283 |
| sci1729 | exp-7818 |
| sci9091 | exp-7821 |
| sci1729 | exp-7821 |
| sci4411 | exp-7822 |
| sci4411 | exp-7822 |
| sci4411 | exp-7822 |

### Used

```sql
CREATE TABLE used(
       exp_id text not null,    -- experiment key
       mach_id text not null    -- machine key
);
```

|  exp_id  | mach_id |
|----------|---------|
| exp-1832 | mach153 |
| exp-4198 | mach153 |
| exp-5283 | mach153 |
| exp-7818 | mac9    |
| exp-7821 | mach153 |
| exp-7821 | mach781 |
| exp-7822 | mach781 |
| exp-7822 | mach227 |

### Notes

```sql
CREATE TABLE notes(
       exp_id text not null,    -- experiment key
       note text not null       -- comment about experiment
);
```

|  exp_id  |               note                |
|----------|-----------------------------------|
| exp-7818 | Laser overheated at 21.2 sec.     |
| exp-7821 | Recalibration after laser repair. |

### Calibration Readings

```sql
CREATE TABLE readings(
       exp_id text not null,    -- experiment key
       quantity text not null,  -- what was measured
       measured real not null   -- measurement
);
```

|  exp_id  | quantity | measured |
|----------|----------|----------|
| exp-1832 | alpha    | 0.75     |
| exp-1832 | beta     | 0.72     |
| exp-4198 | alpha    | 0.76     |
| exp-4198 | beta     | 0.74     |
| exp-5283 | alpha    | 0.71     |
| exp-5283 | beta     | 0.71     |
| exp-7821 | alpha    | 0.79     |
| exp-7821 | beta     | 0.77     |
