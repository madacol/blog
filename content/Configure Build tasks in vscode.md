---
title: Configure Build tasks in vscode
tags: english, tutorial, vscode
date: 2022-07-27
---

**Menu > Terminal > Configure Tasks...**

or create the file **.vscode/tasks.json** with the following template:

```json
{
  // See https://go.microsoft.com/fwlink/?LinkId=733558
  // for the documentation about the tasks.json format
  "version": "2.0.0",
  "tasks": [
    {
      "label": "task's name",
      "type": "shell",
      "command": "./build.sh '${file}'",
      
      // Optional
      "problemMatcher": [],
      "group": {
        "kind": "build",
        "isDefault": true
      }
    }
  ]
}
```

Now you can press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>B</kbd> to run that task and execute the `command` attribute (`./build.sh '${file}'`).
