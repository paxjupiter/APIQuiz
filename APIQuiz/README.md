# Project 3 - *Space Trivia*

Submitted by: **Pax Montoro**

**Space Trivia** is an app that presents users with a series of space-related multiple-choice questions. Users can select an answer, progress through the quiz, and receive a final score at the end. The app allows users to restart the quiz after completion.

Time spent: **approx. 4** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] User can view the current question and 4 different answers
- [x] User can view the next question after tapping an answer
- [x] User can answer at least 3 different questions

The following **optional** features are implemented:

- [x] User can use the vertical orientation of the app on any device
- [x] User can track the question they are on and how many questions are left
- [x] User can see how many questions they got correct after answering all questions
- [x] User should be able to restart the game after they've finished answering all questions

The following **additional** features are implemented:

- [x] Trivia questions are **space-themed**.
- [x] Console logs show **"Correct!" or "Wrong!"** feedback for each answer.
- [x] Quiz has 5 total questions.

## Video Walkthrough

<div>
    <a href="https://www.loom.com/share/f10b3726b6614d038d84dd3df46b8205">
    </a>
    <a href="https://www.loom.com/share/f10b3726b6614d038d84dd3df46b8205">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/f10b3726b6614d038d84dd3df46b8205-a9d72ce8d8a36ee6-full-play.gif">
    </a>
  </div>

## Notes

One challenge encountered was ensuring that long questions wrapped properly inside the `questionLabel`. This was resolved by enabling **multi-line support** in Storyboard and adjusting AutoLayout constraints. It also took me a while to get IBOutlet connections just right.

## License

    Copyright 2025 Pax Montoro

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
