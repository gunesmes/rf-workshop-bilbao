# Example 1: Autonomous testing based on status in the browser console

This example shows how to use the `console` object to check the status of the test
in the browser console.

- Intro to [Robot Framework](https://robotframework.org/)
- System under test: [Dronjo](https://dronjo.wopee.io/)
- Browser library and its [Crawler](https://marketsquare.github.io/robotframework-browser/Browser.html#Crawl%20Site)
- Example 1: Status from console testing

## Robot Framework Intro

A generic open source automation framework for acceptance testing, acceptance
test driven development (ATDD), and robotic process automation (RPA). It has
simple plain text syntax and it can be extended easily with libraries implemented
using Python (or Java).

- Test Automation Framework
- Cross-platform (Windows, Linux, Mac)
- Easy to automate (almost) any test: web, API, mobile, desktop, db, etc.
- Designed in 2005 by Pekka Klärck in his master's thesis
- Built-in Python
- Open source
- Free (Apache 2.0 License)

```robotframework
*** Test Cases ***
eBay search – Porsche
    Search for term  Porsche
    Search results should contain  Porsche


*** Keywords ***
Search for term
    [Arguments]  ${search_term}
    Input text  id=gh-ac  ${search_term}
    Click element  id=gh-btn

Search results should contain
    [Arguments]  ${search_term}
    Element should contain  css=h3  ${search_term}
```

## Browser library

Browser library is a Robot Framework library for driving web browsers. It utilizes
the [Playwright](https://playwright.dev/) project to communicate with the browsers.

Playwright is a Node library to automate Chromium, Firefox and WebKit with a
single API. Playwright is built to enable cross-browser web automation that is
ever-green, capable, reliable and fast.

```robotframework
*** Settings ***
Library  Browser
Suite Setup  Open available browser

*** Test Cases ***
Example test
    New page  https://dronjo.com/
    Click link  text=Buy now
    Page should contain  h1 >> text=DJI Phantom
    Close page
```

## Dronjo

[Demo app](https://dronjo.com/) build for the purpose of this workshop. It is a simple
web application that allows you to purchase drones.

## Using status from console for testing

This example utilizes the `Crawl Site` keyword from the Browser library. It will
crawl the site and check the status of the test in the browser console. If the
page console contains `error` or `warning` it will count it and print out the
error into terminal and continue crawling.

Useful keywords:

- `Crawl Site` - Crawl a site and execute a keyword on every page.

  - `url` - is the page to start crawling from.page_crawl_keyword
  - `take_screenshot` - is the keyword that will be executed on every page. By
    default, it will take a screenshot on every page.
  - `max_number_of_page_to_crawl`, w. default `1000`, is the upper limit of pages
    to crawl. Crawling will stop if the number of crawled pages goes over this.
  - `max_depth_to_crawl`, w. default `50`, is the upper limit of consecutive links
    followed from the start page. Crawling will stop if there are no more links
    under this depth.

- `Get Console Log` - Returns the browser console log of active page.

Example of error output:

```shell
5 / 16 : Crawling url https://dronjo.wopee.io/sign-up.html
[ ERROR ] ERROR FOUND: {'type': 'error', 'text': 'Failed to load resource: the server responded with a status of 404 ()', 'location': {'url': 'https://dronjo.wopee.io/sign-up.html', 'lineNumber': 0, 'columnNumber': 0}, 'time': '2023-10-15T07:39:08.871Z'}
```

Example of summary output:

```shell
==============================================================================
WOPEE SIMPLE BOT * 🤖 🙈 🙉 🙊 🐵 🐒 🦍 🦧
==============================================================================
[ ERROR ] TOTAL ERRORS FOUND: 2
[ WARN ] TOTAL WARNINGS FOUND: 0
TOTAL TESTS: 10
Crawl a website                                                       .
==============================================================================
Crawl a website                                                       | PASS |
------------------------------------------------------------------------------
01 Bot W Console Validation                                           | PASS |
1 test, 1 passed, 0 failed
==============================================================================
```

## Tasks for you

Goals:

- Get familiar with GitHub (Code and Actions)
- Learn how the crawling works
- Find out what could be found from the browser console
- Explore GitHub Actions artifacts

Steps:

1. Clone this repository
2. Try it run

- Navigate to Actions > 01 🤖 Browser Console Testing
- Click Run Workflow > click Run Workflow (the green button)

3. Run it for your own URL

   - Navigate to Actions > 01 🤖 Browser Console Testing
   - Click Run Workflow > set your own URL to test > click Run Workflow
     (the green button)

4. Enhance the test to run 15 tests instead of 10 tests
   - Navigate to Code > examples/01-Console/01_bot_w_console_validation.robot
   - Click on the pen icon to edit the file
   - Modify the `max_number_of_page_to_crawl` to `15`
   - Click on Commit changes button
   - Run the action again to check it works
