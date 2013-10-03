#LolCrudGenerator#
Create __CRUD__ structure for your __mongoid models__.

##Getting Start##
---------------------------------------

* Add to Gemfile:

`gem 'lol_crud_generator', git: 'git@github.com:loldesign/lol_crud_generator.git'`

* Create your model:

`rails g model project name:string description:string`

* Create your __CRUD__ structure:

`rails g lol_crud_generator:resources project`

* Now just access [http://localhost:3000/projects](http://localhost:3000/projects) and that's it :)


##Using NameSpace##
---------------------------------------
First of all you must create a namespace structure, in my case it will be created at /publisher/resources

* Create Namespace Structure:

`rails g lol_crud_generator:namespace_structure publisher`

* Create your __CRUD__ inside of namespace:

`rails g lol_crud_generator:crud --namespace=publisher`

* Now just access [http://localhost:3000/publisher/projects](http://localhost:3000/publisher/projects) and that's it :)

* Enjoy it :)

##Translate your fields##
---------------------------------------
Create a regular models translation:
```
pt-BR:
  layout:
    'true': 'Sim'
    'false': 'Não'
  mongoid:
    models:
      project:     'Projeto'
    attributes:
      project:
        name:        "Nome:"
        description: "Descrição:"
```

Now the Model __name__ and __attributes__ will be translated.
