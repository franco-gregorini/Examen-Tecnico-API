Feature: Escenarios de Pruebas API Booking - UpdateBooking

    @Api_Test
    Scenario: Actualización de una reserva HP status 200 flujo correcto
        # Obtener token
        Given url "https://restful-booker.herokuapp.com/auth"
        And request { username: 'admin', password: 'password123' }
        When method POST
        Then status 200
        * def token = response.token

        # Actualizar con el token
        * def bookingId = 3
        * def jsonBody = { firstname: 'John', lastname: 'Doe', totalprice: 402, depositpaid: true, bookingdates: { checkin: '2026-01-01', checkout: '2026-01-04' }, additionalneeds: 'Breakfast' }
     
        Given url "https://restful-booker.herokuapp.com"
        And path 'booking', bookingId
        And header Content-Type = "application/json"
        And header Accept = "application/json"
        And header Cookie = 'token=' + token
        And request jsonBody
        When method PUT
        Then status 200
        And match response.firstname == jsonBody.firstname
        And match response.lastname == jsonBody.lastname
        And match response.totalprice == jsonBody.totalprice
        And match response.depositpaid == jsonBody.depositpaid
        And match response.bookingdates.checkin == jsonBody.bookingdates.checkin
        And match response.bookingdates.checkout == jsonBody.bookingdates.checkout
        And match response.additionalneeds == jsonBody.additionalneeds
        And print 'Response:', response

    @Api_Test
    Scenario: Validación de la Actualización de una reserva UNHP status 400 solicitud mal formada
        # Obtener token
        Given url "https://restful-booker.herokuapp.com/auth"
        And request { username: 'admin', password: 'password123' }
        When method POST
        Then status 200
        * def token = response.token

        # Actualizar con el token
        * def bookingId = 3
        * def jsonBody = { firstname: 'John', lastname: 'Doe', depositpaid: true, bookingdates: { checkin: '2026-01-01', checkout: '2026-01-04' }, additionalneeds: 'Dinner' }
        Given url "https://restful-booker.herokuapp.com"
        And path 'booking', bookingId
        And header Content-Type = "application/json"
        And header Accept = "application/json"
        And header Cookie = 'token=' + token
        And request jsonBody
        When method PUT
        Then status 400
        And match response == '#notnull'
        And print 'Response:', response


    @Api_Test
    Scenario: Validación de la Actualización de una reserva UNHP status 403 Token Invalido o vencido
        # Obtener token
        Given url "https://restful-booker.herokuapp.com/auth"
        And request { username: 'admin', password: 'password123' }
        When method POST
        Then status 200
        * def token = response.token

        # Actualizar con el token
        * def bookingId = 2
        * def jsonBody = { firstname: 'John', lastname: 'Doe', totalprice: 402, depositpaid: true, bookingdates: { checkin: '2026-01-01', checkout: '2026-01-04' }, additionalneeds: 'Dinner' }
        Given url "https://restful-booker.herokuapp.com"
        And path 'booking', bookingId
        And header Content-Type = "application/json"
        And header Accept = "application/json"
        And header Cookie = 'token=12345'
        And request jsonBody
        When method PUT
        Then status 403
        And match response == '#notnull'
        And print 'Response:', response

    @Api_Test
    Scenario: Validación de la Actualización de una reserva UNHP status 404 URL Incorrecta
        # Obtener token
        Given url "https://restful-booker.herokuapp.com/auth"
        And request { username: 'admin', password: 'password123' }
        When method POST
        Then status 200
        * def token = response.token

        # Actualizar con el token
        * def bookingId = 3
        * def jsonBody = { firstname: 'John', lastname: 'Doe', totalprice: 402, depositpaid: true, bookingdates: { checkin: '2026-01-01', checkout: '2026-01-04' }, additionalneeds: 'Dinner' }
        Given url "https://restful-booker.herokuapp.com"
        And path 'book', bookingId
        And header Content-Type = "application/json"
        And header Accept = "application/json"
        And header Cookie = 'token=' + token
        And request jsonBody
        When method PUT
        Then status 404
        And match response == '#notnull'
        And print 'Response:', response


    @Api_Test
    Scenario: Validación de la Actualización de una reserva UNHP status 405 ID Incorrecto en la URL
        # Obtener token
        Given url "https://restful-booker.herokuapp.com/auth"
        And request { username: 'admin', password: 'password123' }
        When method POST
        Then status 200
        * def token = response.token

        # Actualizar con el token
        * def bookingId = 'a'
        * def jsonBody = { firstname: 'John', lastname: 'Doe', totalprice: 402, depositpaid: true, bookingdates: { checkin: '2026-01-01', checkout: '2026-01-04' }, additionalneeds: 'Dinner' }
        Given url "https://restful-booker.herokuapp.com"
        And path 'booking', bookingId
        And header Content-Type = "application/json"
        And header Accept = "application/json"
        And header Cookie = 'token=' + token
        And request jsonBody
        When method PUT
        Then status 405
        And match response == '#notnull'
        And print 'Response:', response