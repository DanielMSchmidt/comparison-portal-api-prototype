Getting Started:
================

     $ rvm use ruby 1.9.3
     $ bundle install
     $ bundle exec foreman start


API
===

All routes should be understood as RESTful routes & your response is allways in JSON:

![](http://www.wobblini.net/images/routes.png "REST")

Additionally you will get meaningful [http status codes](http://suso.suso.org/docs/infosheets/HTTP_status_codes.gif) back! Errors will be rendered in JSON.

/
-----

The root is for searching and it only takes GET-Requests. The pattern is like this:

    {
      "isbn": "978-3453146976"
    }

or

    {
      "text": "Per Anhalter durch die Galaxis! DVD"
    }

And you will get the item back like this:

    {
      "id": 4,
      "type": "Disk",
      "identifier": "978-3453146976",
      "price": [
        {
          "provider": "ebay",
          "price": "12.5"
        },
        {
          "provider": "buecher.de",
          "price": "13.7"
        }
      ]
    }

/users
------

  - GET

    Send a GET-Request with header

        {
          "authentication":
          {
            "username": "valid-user",
            "password": "valid-password"
          }
        }

    and you will get a 202 status code. <br>
    If you send an invalid user password combination or no authentication string you will get an 406 error code.


  - POST

    Send a POST-Request with body

        {
            "username": "valid-user",
            "password": "valid-password"
        }

    you will get a 201 status code if the user is created.

    If the user already exists or the password is too short / long you will get a 406 status code with the header <br>

        {
          "errors": [
            {
              "username": "This username already exists"
            },
            {
              "password": "This password is too short"
            }
          ]
        }


  - PUT

    Send a PUT-Request with the header <br>

        {
          "authentication":
          {
            "username": "valid-user",
            "password": "valid-password"
          }
        }

    and the body like this (with only the changed attribute)

        {
          "username": "new-valid-user"
        }

    you will get a 202 status code, if the authentication goes wrong a 401 as always and if the username is taken or the password is too short / long you will get the same respnose like in the POST-Request

  - DELETE

    Send a DELETE-Request with the header

        {
          "authentication":
          {
            "username": "valid-user",
            "password": "valid-password"
          }
        }

    and you will get a 202 status code if the user was found. If it wasn't found (e.g. 2 parallel requests for the same user) you will get a 410 status code


/carts
------

  - GET

    Send a GET-Request with header

        {
          "authentication":
          {
            "username": "valid-user",
            "password": "valid-password"
          }
        }

    and you will get a 200 status code, the body will look like this:

        [
          {
            "id": 12,
            "items": [
              {
                "id": 4,
                "type": "Disk",
                "identifier": "978-3453146976",
                "price": [
                  {
                    "provider": "ebay",
                    "price": 12.5
                  },
                  {
                    "provider": "buecher.de",
                    "price": 13.7
                  }
                ]
              },
              {
                "id": 9,
                "type": "Book",
                "identifier": "978-3446237360",
                "price": [
                  {
                    "provider": "ebay",
                    "price": 32.5
                  }
                ]
              }
            ],
            "total": [
              {
                "ebay": 50
              }
            ]
          },
          {
            "id": 42,
            "items": [
              {
                "id": 1,
                "type": "E-Book",
                "identifier": "978-3453446976",
                "price": [
                  {
                    "provider": "ebay",
                    "price": 12.5
                  },
                  {
                    "provider": "buecher.de",
                    "price": 13.7
                  }
                ]
              },
              {
                "id": 2,
                "type": "Book",
                "identifier": "978-3455237360",
                "price": [
                  {
                    "provider": "ebay",
                    "price": 322.5
                  } ,
                  {
                    "provider": "buecher.de",
                    "price": 123.7
                  }
                ]
              }
            ],
            "total": [
              {
                "ebay": 500
              },
              {
                "buecher.de": 600
              }
            ]
          }
        ]

    If you send an invalid user password combination you will get an 401 error code.

    In the array of cart you will get their unique identifier, a list of their items (with ids and prices at providers which have them) and the total amount (only by the providers which have all the searched products)


  - POST

    Send a POST-Request with header

        {
          "authentication":
          {
            "username": "valid-user",
            "password": "valid-password"
          }
        }

    you will get a 201 status code if the cart is created and you will get the empty cart:

        {
          "id": 1337,
          "items": [],
          "total": []
        }

  - PUT

    Send a PUT-Request with the header <br>

        {
          "authentication":
          {
            "username": "valid-user",
            "password": "valid-password"
          }
        }

     and the body like this:

        {
          "item_id": 137
        }

    you will get a 202 status code and the new cart and if the authenticationentication goes wrong a 401 as always.

  - DELETE

    Send a DELETE-Request with the header

        {
          "authentication":
          {
            "username": "valid-user",
            "password": "valid-password"
          },
          "id": 34
        }

    and you will get a 202 status code if the cart was found. If it wasn't found you will get a 404 status code.


/providers
----------

 - GET

     Send a GET-Request with header

         {
           "authentication":
           {
             "username": "valid-user",
             "password": "valid-password"
           }
         }

     and you will get a 202 status code and a body like this:

         [
           {
             "ebay": "active"
           },
           {
             "buecher.de": "inactive"
           }
         ]


 - POST

     Send a POST-Request and you will get a 400 status code


 - PUT

     Send a PUT-Request with the header

         {
           "authentication":
           {
             "username": "valid-user",
             "password": "valid-password"
           }
         }

     and the body (the rating in percentage)

         {
           "comment": "Ich fand e-Bay klasse!",
           "rating": 99
         }

     you will get a 202 status code as the comment and / or rating is created and if the authentication goes wrong a 401 as always

 - DELETE

    Send a DELETE-Request and you will get a 400 status code