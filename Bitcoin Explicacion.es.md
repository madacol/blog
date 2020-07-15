# Como funcionan los fees

Cada ~10m (varia mucho, muchas veces hasta se tarda mas de 30m) se genera un bloque que como máximo puede pesar hasta 1Mb de informacion.

La transaccion mas común y simple es de 2 entradas y 2 salidas, y esa pesa mas de 100 bytes, eso quiere decir que en un bloque caben menos de 10.000 transacciones.

Lo mineros son los encargados de decidir cuales transacciones entran o no en un bloque, y por lo general, ellos le dan prioridad a las que tengan mejor fee (la que tenga la mayor densidad de BTC, osea la mayor **BTC/vbyte**)

En esta pagina https://bitcoinfees.earn.com puedes ver estimaciones de los fees actuales. Ahorita están absurdamente bajos, osea una transaccion normal te puede estar costando menos de 300 satoshis(0.025$) menos de 2,5 centavos de dolar. Con una wallet en la que tu tengas el control, tú decides cuantos fees vas a pagar. Si no pagas comision, corres el riesgo de que ni uno de los mineros meta tu transaccion en la blockchain y nunca se confirme. En la práctica los fees dependen principalmente de 2 cosas:
- Congestión de la red, cuantas transacciones tienes haciendote competencia en el valor del fee (BTC/vbyte)
- Cuanto estás dispuesto a esperar

Fijate en la página, cada fila es un rango de fee/byte medido en **satoshis/byte**, el tamaño de la barra indica cuantas transacciones hay/habido en ese rango, y a la derecha, al final, hay una estimacion de minutos de espera (En la práctica varía)

El peso de una transaccion no solo depende de la cantidad de entradas y salidas, tambien depende del tipo de direcciones de las salidas (y quizas tambien de las entradas, not sure). Y existen 3 tipos de direcciones:
- 1...  (clásica)
- 3...  (Segwit envuelto en un script, para hacerlo compatible con la clásica)
- bc1...    (Segwit nativo)

El primero es el mas ineficiente (el que pesa mas en una transaccion), y el último es el mas eficiente.
Ya todos los servicios se han adaptado al mas eficiente, asi que asegurate de que la wallet que uses tenga direcciones que empiecen por **bc1...**


# Wallets centralizadas vs descentralizadas

Las wallet descentralizadas modernas al momento de creacion generan un número aleatorio, que es básicamente el alma de tu wallet, de hecho, ese número **es** tu wallet, y quien lo tenga puede gastar tus BTC. Ese número te lo muestran en el formato **seed/semilla**, que es una lista de 12-24 palabras, es simplemente una forma mas presentable de mostrar el numero, ya que es mas facil de memorizar, y de transcribir.
Y muchas wallet van un paso mas allá e implementan el estandar **BIP39**, para encriptar esa **seed** con un **password** que tú escojas, y en estos casos para recuperar tu wallet vas a necesitar tanto la seed, como el password. Esta opcion es la que uso yo, porque entonces yo guardo tranquilamente mi **seed** en todos lados, sin preocuparme si alguien la llega a obtener, y solo me preocupo de guardar bien la clave, que es mas corta y aún mas fácil de memorizar y de guardar. (Es importante escoger una buena clave, mas q todo q sea larga, o te le pueden hacer bruteforce)

La necesidad de guardar bien esa clave es la desventaja que tienen las wallet descentralizadas vs las centralizadas/custodeadas, es muy facil cagarla, desde dejar muy a la vista la clave secreta a guardarla tan bien que se te pierde. O tambien si tienes muchos ahorros, tambien tienes que pensar en tener backups que tu familia pueda recuperar si te llega a pasar algo.


# lightning

Está construido encima de Bitcoin. Y está basado en una especie de contrato entre 2 partes, y cada parte puede decidir meter X cantidad de BTC para usarlos dentro de ese canal, y mientras ese canal está abierto ambas partes pueden tranzar sin comision alguna, porque no son transacciones que se guardan en la blockchain, son transacciones totalmente privadas.
Y aquí es donde entra lightning como tal, porque bajo ciertas condiciones, se pueden conectar los canales entre sí para así poder transferirle a entidades con las que no tengas canales abierto directamente.

Ventajas:
- Transacciones son casi instantáneas.
- Fees son aún mas bajos. Gratis si con quien abriste el canal de lightning es el mismo a quien le vas a pagar.

Desventajas:
- No es suficiente con guardar la **seed** y **password**, tu aplicacion tambien necesita guardar cada cambio que se haga en tus canales abiertos. (La única aplicacion que probé creo que tenia para configurar Google Drive para guardar todos esos cambios).
- Tu aplicacion tiene que estar pendiente de la red cada cierto tiempo (dependiendo de cuando tiempo se le configuró al canal, por lo general varios días)
- Capacidad limitada de cantidad de Bitcoins que puedes enviar, depende de la capacidad de los canales de la ruta que atraviesa la transacción.

Lightning sigue en desarrollo activo, y algunas de las desventajas son mejorables sacrificando decentralizacion, como hace Phoenix Wallet, que me parece un muy buen tradeoff para noobs.