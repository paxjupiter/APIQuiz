# Project 4 - APITrivia

Submitted by: **Pax Montoro**

**APITrivia** is an app that challenges users with real trivia questions fetched from the Open Trivia Database API. Users can answer multiple-choice or true/false questions. The app dynamically updates scores and allows users to reset the game for a fresh set of questions.

Time spent: **3** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] User can view and answer at least 5 trivia questions.
- [x] App retrieves question data from the Open Trivia Database API.
- [x] Fetch a different set of questions if the user indicates they would like to reset the game.
- [x] Users can see score after submitting all questions.
- [x] True or False questions only have two options.

The following **optional** features are implemented:

- [ ] Allow the user to choose a specific category of questions.
- [ ] Provide the user feedback on whether each question was correct before navigating to the next.

The following **additional** features are implemented:

- [x] HTML entity decoding for clear and readable questions and answers.

## Video Walkthrough

<div>
    <a href="https://www.loom.com/share/eb081743587c4c24bf232a1398d34fd5">
    </a>
    <a href="https://www.loom.com/share/eb081743587c4c24bf232a1398d34fd5">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/eb081743587c4c24bf232a1398d34fd5-a6ab35d6ac167c22-full-play.gif">
    </a>
  </div>

## Notes

Some challenges encountered during development included:

- Handling both multiple-choice and true/false questions within the same UI.
- Adjusting the layout so that long question texts do not get cut off (removing fixed height constraints).
- Decoding HTML entities (like `&quot;`) in the question and answer text.
- Ensuring that the app correctly resets and fetches new questions when requested.

These challenges provided great learning experiences with networking in iOS and dynamic UI updates using Swift.

## License

    Copyright [2025] [Pax Montoro]
    
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
        http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
