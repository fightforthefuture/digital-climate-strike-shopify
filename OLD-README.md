# Digital Climate Strike

This September, millions of us will walk out of our workplaces and homes to join young climate strikers on the streets and demand an end to the age of fossil fuels.

This is the source code for the Digital Climate Strike's widget, that will allow anyone with a website to join the digital climate strike in solidarity. [Click here to learn more.](https://globalclimatestrike.net)

This project was inspired by the [Fight for the Future Red Alert widget](https://github.com/fightforthefuture/redalert-widget).

## How it works
This is a Shopify app. When you installed, it creates two [script tags](https://help.shopify.com/en/api/reference/online-store/scripttag):

1. It will contain the customization variables for the widget.
2. It will contain the widget itself.

The shopify app allows the user to modify the customization as many times as he or she wants keeping just two script tags.

## Development

If you wish to modify it or to run it, you follow the basic way of running a rails app. If you are not familiar with rails, you can follow the [official tutorial](https://guides.rubyonrails.org/getting_started.html).
An easy way to start coding is using docker and I left the setup for it.
Just start by compiling the docker image:

```
$ docker-compose build
```

then run the db setup

```
$ docker-compose run --rm backend bundle exec rails db:setup
```

and finally start the app

```
$ docker-compose up -d backend
```

## Bugs

If you wish to report a bug or request a feature, please go to [here](https://github.com/fightforthefuture/digital-climate-strike-shopify/issues/new/choose)
