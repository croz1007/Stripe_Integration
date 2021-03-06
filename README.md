[![Coverage Status](https://coveralls.io/repos/github/croz1007/Stripe_Integration/badge.svg?branch=master)](https://coveralls.io/github/croz1007/Stripe_Integration?branch=master)

# Spike: Stripe Integration

## Spec Details

Build a disposable Rails app and integrate with Stripe. Ideally, with a flow that supports subscriptions.

_____

### Deliverables
* Written analysis of what's confusing/ challenging about the Stripe integration process.
    * What would you expect / wish / like Stripe to just handle for you but they don't?
    * What made you feel dumb?
    * Did it feel like Stripe expects you to just know stuff about credit card processing that you didn't?
* A daily demo of progress to an interested stakeholder.
* A publicly deployed, server-rendered Rails "subscription" app.
    * URL: https://floating-harbor-5447.herokuapp.com/

_____

### Spec
* Public landing page at */*.
* User registration page at /signup
* A subscription signup at */subscribe* page that gives users the option of using a credit card to pay
    * $1.99/ day
    * $9.99/month
    * $99/ year
    * *This page should only be available to registered users. It'll make life a touch easier.*
* A subscription cancellation page at */cancel* that gives subscribed users a pro-rated refund based on the time left in the subscription period
    * *Note the monthly and annual payment options*
* A settings page at /settings that
    * redirects users that aren't subscribed to */subscribe* and redirects logged out users to */*
    * Allows subscribed users to change which card gets billed.
      * *Stripe can update some basic card information (exp month, exp year, etc.), but a new card must be added to change the card.*
* A "limbo" notification if a card is accepted at the time of subscription, but declined upon a recurring charge.
* The ability to update a limbo account with a good cart to make the notification go away.
    * *Don't forget to charge the user appropriately.*

_____

### Some Potential Challenges
* Staying productive with loose requirements. (Try not to take more than 2-3 weeks because the total time available for spike might not be much more than that.)
* Testing the "limbo" notifications.
    * Sign a user up with a good card from https://stripe.com/docs/testing
    * Change it to a bad card right before the charge recurs.
* Pro rated refunds for multiple subscription types.

#### Contributions by
Rachel Slaby: https://github.com/belongstorachel

Aly Fluckey: https://github.com/wtfluckey

_____
*Stripe API Testing Dashboard: https://dashboard.stripe.com/test/dashboard*

*Stripe API Documentation: https://stripe.com/docs/api/ruby#authentication*
