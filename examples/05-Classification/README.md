# Example 5: Visual validation with AI (classification)

For some useceses it is usefull to use AI to validate the visual output of the application.
In that case model is trained to recognize the expected output and the test is run
against.

Example: [Amazon 404 page](https://www.amazon.com/asdf) - after each refress it
is different.

## Sample pictures
Pictures for training and testing are available in the repo 
(`examples/05-Classification/screenshots`) and also here:
[Google drive](https://drive.google.com/drive/folders/1bKuOL7TtU4-zdYSDlLwxs_ep__48hvc5?usp=share_link)

## Building models

See more

- [Teachable Machine](https://teachablemachine.withgoogle.com/train/image)
- [Teachable Machine - GitHub](https://github.com/googlecreativelab/teachablemachine-community/tree/master/libraries/image)

## Tasks for you

Goals:

- Get familiar clasification models idea
- Try to build own model

Steps:

1. Train model

- Navigate to [Image model - Teachable Machine](https://teachablemachine.withgoogle.com/train/image) app
- Upload 10 images (pictures prepared in repo) of the
  - 404 page and name the class `Error 404`
  - product page and name the class `Product page`
  - search page and name the class `Search page`
- Train the model
- Test the model with the prepared images (from the testing folder)

2. Explore export options

- Navigate to Export Model button
- Could be imported into our automation framework (python and javascript available)

3. Ask trainer for explanation: How this could be advanced more?
   ... he has slide prepared for you ;)
