-- consultas 
-- 1. Encuentra el profesor que ha impartido más asignaturas en el último año académico.
select profesor.nombre, apellido1, count(id_profesor) from asignatura
inner join profesor on asignatura.id_profesor= profesor.id
group by 1,2 order by 3 desc limit 1;

-- 2. Lista los cinco departamentos con mayor cantidad de asignaturas asignadas.
select departamento.nombre, profesor.nombre, count(profesor.id) as asignaturas from profesor
inner join asignatura on profesor.id=asignatura.id_profesor
right join departamento on profesor.id_departamento=departamento.id
group by 1,2 order by 3 desc limit 5;

-- 3. Obtén el total de alumnos y docentes por departamento.
select departamento.nombre, count(alumno_se_matricula_asignatura.id_alumno), count(asignatura.id_profesor) from alumno_se_matricula_asignatura
inner join alumno on alumno_se_matricula_asignatura.id_alumno= alumno.id
INNER join asignatura on alumno_se_matricula_asignatura.id_asignatura= asignatura.id
inner join profesor on asignatura.id_profesor=profesor.id
right join departamento on profesor.id_departamento=departamento.id
group by 1;

select asignatura.nombre,count(alumno_se_matricula_asignatura.id_alumno) from alumno_se_matricula_asignatura
right join asignatura on alumno_se_matricula_asignatura.id_asignatura=asignatura.id
group by 1;

-- 4 Calcula el número total de alumnos matriculados en asignaturas de un género específico en un semestre determinado.
select asignatura.nombre, asignatura.cuatrimestre,count(alumno_se_matricula_asignatura.id_alumno)as num_alumnos from alumno_se_matricula_asignatura
inner join asignatura on alumno_se_matricula_asignatura.id_asignatura=asignatura.id
group by 1,2;

-- 5. Encuentra los alumnos que han cursado todas las asignaturas de un grado específico.
select alumno.nombre, apellido1, count(alumno_se_matricula_asignatura.id_asignatura) from alumno_se_matricula_asignatura 
inner join alumno on alumno_se_matricula_asignatura.id_alumno= alumno.id
inner join asignatura on alumno_se_matricula_asignatura.id_asignatura=asignatura.id
inner join grado on asignatura.id_grado= grado.id
where grado.id=4
group by 1,2;

-- 6. Lista los tres grados con mayor número de asignaturas cursadas en el último semestre.
select grado.nombre,asignatura.cuatrimestre, count(asignatura.id) from grado
inner join asignatura on grado.id=asignatura.id_grado
group by 1,2 order by 2 desc ;

-- 7. Muestra los cinco profesores con menos asignaturas impartidas en el último año académico.
select profesor.nombre, count(asignatura.id_profesor) from asignatura 
right join profesor on asignatura.id_profesor= profesor.id
group by 1 order by 2 asc;

-- 8. Calcula el promedio de edad de los alumnos al momento de su primera matrícula.
select avg(timestampdiff(year,fecha_nacimiento, now()))as edad from alumno
inner join alumno_se_matricula_asignatura on alumno.id=alumno_se_matricula_asignatura.id_alumno;

-- 9 Encuentra los cinco profesores que han impartido más clases de un mismo grado.
select distinct grado.nombre, profesor.nombre, count(asignatura.id_profesor)as num_asignatura from profesor
inner join asignatura on profesor.id= asignatura.id_profesor
inner join grado on asignatura.id_grado=grado.id
group by 1,2 order by 3 desc limit 5;

-- 10. Genera un informe con los alumnos que han cursado más de 10 asignaturas en el último año.
select distinct alumno.nombre, alumno.apellido1, asignatura.nombre,curso_escolar.anyo_inicio, 
curso_escolar.anyo_fin as nombre_asignatura, asignatura.cuatrimestre, 
count(alumno_se_matricula_asignatura.id_asignatura)as numero_asignatura from alumno
inner join alumno_se_matricula_asignatura on alumno.id=alumno_se_matricula_asignatura.id_alumno
inner join asignatura on alumno_se_matricula_asignatura.id_asignatura=asignatura.id
inner join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar=curso_escolar.id
where curso_escolar.id=4
group by 1,2,3,4,5,6
having count(alumno_se_matricula_asignatura.id_asignatura)>10;


-- 11 Calcula el promedio de créditos de las asignaturas por grado.
select grado.nombre, avg(asignatura.creditos) from asignatura
right join grado on asignatura.id_grado= grado.id
group by 1 order by 2 desc;

-- 13. Muestra los alumnos que han cursado más asignaturas de un género específico.
select alumno.nombre, alumno.apellido1, count(alumno_se_matricula_asignatura.id_asignatura) from alumno_se_matricula_asignatura
inner join asignatura on alumno_se_matricula_asignatura.id_asignatura= asignatura.id
right join alumno on alumno_se_matricula_asignatura.id_alumno= alumno.id
where alumno.sexo=1
group by 1,2 order by 3 desc;

-- 17. Encuentra al alumno con la matrícula más reciente.
select distinct alumno.nombre, alumno.apellido1 from alumno_se_matricula_asignatura
inner join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar=curso_escolar.id
right join alumno on alumno_se_matricula_asignatura.id_alumno= alumno.id
where curso_escolar.id=4;

-- 19. Obtén la cantidad de asignaturas cursadas por cada alumno en el último semestre.
select alumno.nombre, alumno.apellido1, count(alumno_se_matricula_asignatura.id_asignatura)as num_asignaturas
from alumno_se_matricula_asignatura
inner join asignatura on alumno_se_matricula_asignatura.id_asignatura= asignatura.id
inner join alumno on alumno_se_matricula_asignatura.id_alumno= alumno.id
where asignatura.cuatrimestre=2
group by 1,2;

-- 20. Lista los profesores que no han impartido clases en el último año académico.
select distinct profesor.nombre, profesor.apellido1, count(asignatura.id_profesor) from profesor
left join asignatura on profesor.id= asignatura.id_profesor 
where asignatura.id_profesor is null
group by 1,2;

