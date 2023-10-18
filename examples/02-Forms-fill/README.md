# Example 2: Filling forms on the fly w. Gen AI

This example shows how to use Gen AI (like OpenAI) to fill forms on the fly.

- Example 2: Filling forms on the fly w. Gen AI

## Vercel AI SDK

We will use Vercel AI SDK to generate instructions for our testing bot.

Start exepriment with https://sdk.vercel.ai/

Try this prompt example (!!! do not forget replace the `${HTML}` ):

````markdown
I am a test engineer writing tests in Robot Framework using the Browser library.
I have opened a web page and I want to fill in and submit (click on button as a last step) the form on this page.
Use real test data (consider defined and typical validations) and use only locators from this HTML:

```html
$$$HTML$$$
```

Provide me steps to accomplish it in json format. Example:

```json
[
  { "step": 1, "locator": "#name", "value": "Marcel", "action": "fill" },
  { "step": 2, "locator": "#pswd", "value": "abc123", "action": "fill" }
]
```
````

For hosting your owno model you can try [Fireworks.ai](https://fireworks.ai/)

## Trace viewer

Analyze your result in [Trace viewer](https://trace.playwright.dev/)

Try it with one of the following HTML:

## Video from test execution

There is a video stored withing GitHub repo under the GitHub actions tab in artifacts.
Navigate in repository to Actions > select the latest run > select the latest job >
select the latest artifact > download the zip log.

<details>
  <summary>Check out page</summary>

```html
<form
  action="/"
  name="sign_in"
  onsubmit="login(document.sign_in.user.value, document.sign_in.password.value);"
>
  <!-- Username -->
  <input
    name="user"
    class="form-control main"
    type="email"
    pattern=".+@tesena.com"
    placeholder="Username"
    required=""
  />
  <!-- Password -->
  <input
    name="password"
    class="form-control main"
    type="password"
    placeholder="Password"
    required=""
  />
  <!-- Submit Button -->
  <button class="btn btn-main-sm">sign in</button>
</form>
```

</details>

<details>
  <summary>Check out page</summary>

```html
<form class="card-details" action="" id="checkout" data-form="">
  <fieldset class="card-details__fieldset">
    <span class="card-details__heading">Card Type</span>

    <div class="card-details__cards" data-card-types="">
      <div class="card-details__cards-item">
        <input
          class="card-details__card-input"
          type="radio"
          name="cardType"
          id="visa"
          data-card-type="visa"
          checked=""
        />
        <label class="card-details__card-label" for="visa">Visa</label>
        <img
          class="card-details__cards-image"
          src="https://svgshare.com/i/7h2.svg"
          alt="Visa Card"
          aria-hidden="true"
        />
      </div>

      <div class="card-details__cards-item">
        <input
          class="card-details__card-input"
          type="radio"
          name="cardType"
          id="mastercard"
          data-card-type="mastercard"
        />
        <label class="card-details__card-label" for="mastercard"
          >MasterCard</label
        >
        <img
          class="card-details__cards-image"
          src="https://svgshare.com/i/7fu.svg"
          alt="MasterCard"
          aria-hidden="true"
        />
      </div>

      <div class="card-details__cards-item">
        <input
          class="card-details__card-input"
          type="radio"
          name="cardType"
          id="discover"
          data-card-type="discover"
        />
        <label class="card-details__card-label" for="discover">Discover</label>
        <img
          class="card-details__cards-image"
          src="https://svgshare.com/i/7hP.svg"
          alt="Discover Card"
          aria-hidden="true"
        />
      </div>

      <div class="card-details__cards-item">
        <input
          class="card-details__card-input"
          type="radio"
          name="cardType"
          id="express"
          data-card-type="express"
        />
        <label class="card-details__card-label" for="express"
          >American Express</label
        >
        <img
          class="card-details__cards-image"
          src="https://svgshare.com/i/7gD.svg"
          alt="Amercican Express Card"
          aria-hidden="true"
        />
      </div>
    </div>
  </fieldset>

  <fieldset class="card-details__fieldset">
    <span class="card-details__heading">Card Number</span>

    <div class="card-details__number">
      <div class="card-details__number-field">
        <label for="cardNumberFirstFour" class="card-details__number-label"
          >First Four Digits</label
        >
        <input
          class="card-details__number-input"
          type="text"
          maxlength="4"
          name="card-number"
          value="0000"
          required=""
          pattern="^((?!0000).)*$"
          id="cardNumberFirstFour"
          data-input=""
        />
      </div>

      <div class="card-details__number-field">
        <label for="cardNumberSecondFour" class="card-details__number-label"
          >Second Four Digits</label
        >
        <input
          class="card-details__number-input"
          type="text"
          maxlength="4"
          name="card-number"
          value="0000"
          required=""
          pattern="^((?!0000).)*$"
          id="cardNumberSecondFour"
          data-input=""
        />
      </div>

      <div class="card-details__number-field">
        <label for="cardNumberThirdFour" class="card-details__number-label"
          >Third Four Digits</label
        >
        <input
          class="card-details__number-input"
          type="text"
          maxlength="4"
          name="card-number"
          value="0000"
          required=""
          pattern="^((?!0000).)*$"
          id="cardNumberThirdFour"
          data-input=""
        />
      </div>

      <div class="card-details__number-field">
        <label for="cardNumberFirstFour" class="card-details__number-label"
          >Last Four Digits</label
        >
        <input
          class="card-details__number-input"
          type="text"
          maxlength="4"
          name="card-number"
          value="0000"
          required=""
          pattern="^((?!0000).)*$"
          id="cardNumberLastFour"
          data-input=""
        />
      </div>

      <div class="card-details__number-card">
        <img
          class="card-details__number-card-image"
          src="https://svgshare.com/i/7h2.svg"
          alt="Visa Card"
          data-card-image=""
        />
      </div>
    </div>
  </fieldset>

  <fieldset class="card-details__fieldset">
    <span class="card-details__heading" aria-hidden="true"
      >Card Holder Name</span
    >
    <div class="card-details__holder">
      <label class="card-details__holder-label" for="cardHolderName"
        >Card Holder Name</label
      >
      <input
        class="card-details__holder-input"
        type="text"
        id="cardHolderName"
        data-input=""
        required=""
      />
    </div>
  </fieldset>

  <fieldset class="card-details__fieldset">
    <div class="card-details__expiration">
      <span class="card-details__heading" aria-hidden="true"
        >Expiration Date</span
      >
      <div class="card-details__expiration-date">
        <label class="card-details__expiration-date-label" for="expirationDate"
          >Expiration Date</label
        >
        <input
          class="card-details__expiration-date-input"
          type="text"
          maxlength="7"
          value="MM / YY"
          pattern="^((?!MM / YY).)*$"
          id="expirationDate"
          data-input=""
          required=""
        />
      </div>
    </div>

    <div class="card-details__security">
      <span class="card-details__heading" aria-hidden="true">CVV</span>
      <div class="card-details__details__security-code">
        <label class="card-details__security-code-label" for="expirationDate"
          >CVC</label
        >
        <input
          class="card-details__security-code-input"
          type="text"
          maxlength="3"
          value="000"
          pattern="^((?!000).)*$"
          id="cvc"
          data-input=""
          required=""
        />
      </div>
    </div>
  </fieldset>

  <button class="card-details__submit" form="checkout" data-submit-button="">
    Purchase
  </button>
</form>
```

</details>

## Tasks for you

Goals:

- Get familiar with Gen AI models
- Learn how to implement simple autonomous interaction (submit form)
- Explore what was generated (video, trace, logs)

Steps:

1. Start exepriment with https://sdk.vercel.ai/

- Prompt the propose 10 tests to test CRM (or any app you typically test)
- Prompt the tool to fill the form (provide HTML form - e.g. the ones above)
- Prompt the tool to provide 3 potential locators to use for the form submit button
- ... share with coleagues your ideas what else to try?

2. Try it run

- Navigate to Actions > 02 🎹 Filling Forms Bot
- Click Run Workflow > click Run Workflow (the green button)

3. Run it for your own URL

   - Navigate to Actions > 02 🎹 Filling Forms Bot
   - Click Run Workflow > set your own URL to test > click Run Workflow
     (the green button)

4. Advanced debugging

- Check out video
- Check out trace viewer
