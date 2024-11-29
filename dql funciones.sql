-- 1. Calcula el total de créditos cursados por un alumno en un año específico.
delimiter //
create function TotalCreditosAlumno(AlumnoID int, Anio varchar(10))
returns int deterministic
begin
	declare total int;
    set total= (select count(asignatura.creditos) from alumno_se_matricula_asignatura
    inner join asignatura on alumno_se_matricula_asignatura.id_asignatura=asignatura.id
    inner join alumno on alumno_se_matricula_asignatura.id_alumno=alumno.id
    inner join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar=curso_escolar.id
    where AlumnoID= alumno.id and curso_escolar.anyo_inicio=Anio);
    return total;
end;
// delimiter ;
select TotalCreditosAlumno(2,'2014');

delimiter //
create function total_asignatura(id_profe int)
returns int deterministic
begin
declare total int;
set total= (select count(asignatura.id_profesor) from asignatura
inner join profesor on asignatura.id_profesor=profesor.id
where profesor.id=id_profe);
return total;
end;
// delimiter ;



