# A little background information

This code exercise is intended to evaluate your software engineering skills. Your solution will be evaluated based on the ability to produce intended results, cleanliness, adherence to best practices, maintainability, and readability. You should write code like you would if this were an actual assignment. You do not need to gold plate your solution, but we are looking for something more than a script. Ideally your solution would demonstrate your understand of object-oriented principles and best practices.

# The Agent Matching problem
There are 2 important entities that work together in commercial insurance.

**Carriers** create commercial insurance products. Commercial insurance carriers selectively choose which industries they sell commercial insurance policies to. That is to say, depending on the industry a business is in, you may find that some commercial insurance carriers won’t sell you a policy. For example, FarmInsure will underwrite a policy if the business’s industry is peanut farming, but will not sell a policy if the industry is building construction.

**Agents** work with the carriers in order to sell & service commercial insurance policies. Agents are licensed at the state level and have special agreements with any carriers they work with. So for example, Frank Farmer can be licensed in Kentucky and Ohio and has an agreement with FarmInsure. This means Frank Farmer can sell you a FarmInsure policy if your business operates in Ohio, but not if your business operates in Florida. Because Frank Farmer only has an agreement with FarmInsure, he can’t sell products for Homestate or Statewide.

## Getting Started

**Please DO NOT push your work to a public fork on GitHub!**

Clone **this** repo, please DO NOT make a fork of it.

```bash
$ git clone https://github.com/KnightPointSystems/code_challenge.git
```

You'll need to setup your development environment with Ruby. This step is platform dependent, so you'll need to figure it out yourself.

```bash
$ bundle install        # Install dependencies
$ rails db:reset        # Create the local database with test data
```

## Your Assignment

**After completing each of the steps below, commit your changes to your local clone with a meaningful commit message.**


1. Implement a controller endpoint such that a GET request to `/api/agents/:id` would display a JSON-representation of the agent with that id.

For example:

```bash
$ curl http://localhost:3000/api/agents/1
```
```json
{
   "id":1,
   "name":"Elliot Schimmel DVM",
   "phone_number":"1-214-496-5089",
   "created_at":"2018-11-28T20:04:09.493Z",
   "updated_at":"2018-11-28T20:04:09.493Z"
}
```

2. Implement a controller endpoint such that a GET request to `/api/agents?state=OH&industry=Professional%20Beer%20Taste-Tester` displays agents licensed in the state of `OH` that work with a carrier that will sell a policy for `Professional Beer Taste-Tester`.

For example:
```bash
$ curl -X GET http://localhost:3000/api/agents -d state=OH -d industry="Professional Beer Taste-Tester"
```
```json
[
   {
      "id":14,
      "name":"Gemma Ritchie",
      "phone_number":"594.170.4795",
      "created_at":"2018-11-28T20:04:09.532Z",
      "updated_at":"2018-11-28T20:04:09.532Z"
   },
   {
      "id":66,
      "name":"Hobert Ryan DDS",
      "phone_number":"1-501-950-6320",
      "created_at":"2018-11-28T20:04:09.661Z",
      "updated_at":"2018-11-28T20:04:09.661Z"
   },
   {
      "id":89,
      "name":"Ericka Yost",
      "phone_number":"1.563.874.2068",
      "created_at":"2018-11-28T20:04:09.723Z",
      "updated_at":"2018-11-28T20:04:09.723Z"
   },
   {
      "id":106,
      "name":"Whitney Treutel",
      "phone_number":"(662) 928-5292",
      "created_at":"2018-11-28T20:04:09.766Z",
      "updated_at":"2018-11-28T20:04:09.766Z"
   }
]
```

3. Expand the previous endpoint such that a GET request to `/api/agents?phone_number=<numerics-only-phone-number>` displays details of the agents whose phone number was supplied.

**HINT**: You'll notice the phone numbers that have been supplied are in multiple different formats. Assume that this is an existing production database with at least 1,000,000 records, and that you can not simply change the initial seed file with the corrected format!

For example:

```bash
$ curl http://localhost:3000/api/agents?phone_number=2625296931

OR

$ curl http://localhost:3000/api/agents?phone_number=12625296931
```

Should return the same record.


```json
[
   {
      "id":97,
      "name":"Xuan Schiller",
      "phone_number":"1-262-529-6931",
      "created_at":"2018-11-28T20:35:52.169Z",
      "updated_at":"2018-11-28T20:35:52.169Z"
   }
]
```

1. Implement a **Policy** model & requisite database tables. This **Policy** model will be sold by an **Agent** and be serviced through a **Carrier**. Additionally, each **Policy** will have the name of the policy holder, the premium amount, and the **Industry** that the policy covers.

Implement an endpoint such that a POST request to `/api/policies` creates a _valid_ **Policy** in the database. For example:

```bash
$ curl -X POST http://localhost:3000/api/policies \
-H 'Content-Type: application/json' \
-d '{
  "policy_holder": "Bob Stevens",
  "premium_amount": 424.23,
  "industry_id": 1,
  "carrier_id": 9,
  "agent_id": 2
}'
```
```json
{
  "id":1,
  "policy_holder":"Bob Stevens",
  "premium_amount": 424.23,
  "industry": {
    "id": 1,
    "name": "Underwater Electrical Wiring"
  },
  "carrier": {
    "id": 9,
    "name": "Prestige Worldwide"
  },
  "agent": {
    "id": 2,
    "name": "Nelia Graham"
  },
 "updated_at": "2018-11-28T20:35:52.169Z"
}
```

5. Complete the questions in `QUESTIONS.md`.

## How this will be evaluated

For clarity, this is how your code sample will be evaluated:

| Criteria | Percentage |
|----------|-----|
| Object-Oriented Design Principles | 30% |
| Readability & Maintainability | 30% |
| Best Practices & Naming Convention | 20% |
| Ease of Testing Solution & Correctness | 20% |

## Submission guideliness

Be sure that all existing tests pass, and any new classes added have meaningful unit tests.
The use of Minitest is intentional, please do not change the testing framework.

`rails test`

Ensure that you have at least 80% code coverage

`open coverage/index.html`

Ensure that you adhere to the rails_best_practices

`rails_best_practices`

Ensure that you run brakeman to find any security-related issues

`brakeman`

**Please DO NOT push your work to a public fork on GitHub!**

Using the command below, create a git bundle of your changes and send it to daniel.brooking@perspecta.com and sebastian.caso@perspecta.com with the subject line `[AGENT_MATCH] <your name>`.

```bash
$ git bundle create your_name.bundle master
```
