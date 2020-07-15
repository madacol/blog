[//]: # "Ctrl+K,V o Ctrl+Shift+V - Para ver vista previa en VSCode"

# Comandos principales

- `START TRANSACTION` se utiliza para abrir una transacción (desactiva temporalmente el modo `autocommit`).
- `COMMIT` se utiliza para que los cambios que están pendientes de la transacción actual, se vuelvan permanentes en la BD y cierra la transacción.
- `ROLLBACK` para deshechar cualquier cambio pendiente que se haya hecho en la transacción actual y cierra la transacción.

MYSQL por defecto funciona con el modo `autocommit` activado, eso quiere decir que cualquier consulta es una transacción implicitamente, osea, si hacen un `UPDATE ...` en el fondo InnoDB ejecuta algo parecido a esto:

```sql
START TRANSACTION;
    UPDATE ...
COMMIT;
```

Si ese `UPDATE ...` falla estando el modo `autocommit` activado, entonces automáticamente se ejecuta un `ROLLBACK`

# Usos

## Ejecutar todo o nada

Supongamos que queremos ejecutar una serie de consultas que modifican la BD, pero queremos que se ejecuten todas, y que si cualquiera falla que se deshagan los cambios.

Podemos hacer algo así:

```sql
BEGIN

    START TRANSACTION;
        .. Consulta 1 ..
        .. Consulta 2 ..    # Esta consulta siempre falla
        .. Consulta 3 ..
    COMMIT;

END
```

Al ejecutar ese procedimiento almacenado, se abre una transacción, se ejecuta la **Consulta 1**, y al intentar la **Consulta 2** falla.

Hay un problema aquí, la transacción no se deshace, sino que queda abierta, osea, tiene cambios hechos de la **Consulta 1**, pero no se han hecho permanentes en la BD (`COMMIT`), ni tampoco se han devuelto los cambios (`ROLLBACK`). Y puede ocurrir cualquiera de los dos escenarios. Por ejemplo si se cierra la conexión, la BD ejecuta un `ROLLBACK` y si se ejecuta cualquiera de estas consultas <https://dev.mysql.com/doc/refman/8.0/en/implicit-commit.html> se genera un `COMMIT` implicitamente.

Si en este estado de la BD se hace un `SELECT` para verificar si en la BD se hicieron los cambios de la **Consulta 1**, se va a obtener distintas respuestas dependiendo de si el `SELECT` se ejecuta desde la misma conexión/sesión o no.

Cuando se abre una transacción y se hace un cambio, ese cambio solamente es visible para esa misma sesión que abrió la transacción.

### Solución

Explicitamente hacer `ROLLBACK` cuando ocurra un error.

Para eso definimos un *HANDLER* para los errores, es como el equivalente a un `try ... catch` pero afecta a todo el procedimeinto almacenado

```sql
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    START TRANSACTION;
        .. Consulta 1 ..
        .. Consulta 2 ..    # Esta consulta siempre falla
        .. Consulta 3 ..
    COMMIT;

END
```

Ahora cuando la **Consulta 2** falle, se dispara el handler, y se ejecutan los comandos `ROLLBACK` y `RESIGNAL`. *RESIGNAL* sirve para que se vuelva a lanzar el error, ya que de lo contrario el procedimiento almacenado termina *"exitosamente"* a pesar de que hubo un error.

## Bloquear tablas

Luego de abrir una transaccion con `START TRANSACTION` las consultas como el `INSERT`, `UPDATE` o `DELETE` bloquean las tablas, registros o índices que afecten, hasta que dicha transacción se cierre ya sea con un `COMMIT` o un `ROLLBACK`.

Esto sirve para que cualquier otra consulta que quiera leer o modificar los elementos bloqueados, deban esperar hasta que la transacción que los bloquea se cierre y los libere.

Los `SELECT` normales no generan ningun bloqueo, para eso existen el `SELECT ... FOR SHARE` y el `SELECT ... FOR UPDATE`.

En términos simples el **FOR SHARE** bloquea los elementos seleccionados para que otra consulta no pueda escribir sobre ellos hasta que se cierre la transacción, y el **FOR UPDATE** adicionalmente impide que tampoco puedan leerlos (igual que los `INSERT`, `UPDATE` o `DELETE`). Mas información <https://dev.mysql.com/doc/refman/8.0/en/innodb-locking-reads.html>

### Recomendaciones

Hay que analizar detalladamente todo lo que se mete dentro de una transacción, y reducirlo a lo mas mínimo posible, para evitar [Deadlocks](https://dev.mysql.com/doc/refman/5.7/en/innodb-deadlocks.html) o retrasos debido a bloqueos innecesarios.

Usar índices en todos los `WHERE` de las consultas que bloquean, para que dichos bloqueos sean lo mas óptimos posibles, y se bloquee solo lo que hace falta bloquear.
