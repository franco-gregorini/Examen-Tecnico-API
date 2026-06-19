Feature: Escenarios de Pruebas API Auth - CreateToken 

    @Api_Test
    Scenario: Creacion de un token de autenticación HP status 200 flujo correcto
        Given url "https://restful-booker.herokuapp.com/auth"
        And header Content-Type = "application/json"
        And request { "username": "admin", "password": "password123" }
        When method POST
        Then status 200
        And match response.token == '#notnull'
        And print 'Response:', response


    @Api_Test
    Scenario: Validacion de un token de autenticación HP status 200 con credenciales incorrectas
        Given url "https://restful-booker.herokuapp.com/auth"
        And header Content-Type = "application/json"
        And request { "username": "adm1n", "password": "password321" }
        When method POST
        Then status 200
        And match response.reason == '#notnull'
        And print 'Response:', response

    @Api_Test
    Scenario: Validacion de un token de autenticación UNHP status 404 URL Incorrecto
        Given url "https://restful-booker.herokuapp.com/au"
        And header Content-Type = "application/json"
        And request { "username": "admin", "password": "password123" }
        When method POST
        Then status 404
        And match response == '#notnull'
        And print 'Response:', response
