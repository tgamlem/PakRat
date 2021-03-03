# **PakRat**

## **High level to Low level**

Break down your application from a high level to some specific parts. The more detail you can give here, the better. Hang on to this document (GitHub?), since it will change throughout the semester.

### **General**

- Make the app easy to understand
  - Enough detail that users know how to use it, but not so much that the pages get cluttered
  - Smooth navigation between the pages
- Determine a color scheme that fits the feel of our app

### **Create a Pak**

### Define the pak

- Pak Title (Ex. "US Quarters")
- Provide Metadata Categories (Ex. "State, Year,...")
- Attatch a representative image (Ex. Snap a picture of a coin binder)
  - Code includes: Create a class which includes the basic members of 'Title' and 'Elements.' A user may create an unlimited amount of discriptive elements, partaining to their pak.
    - In user experience, this may entail the following prompts:
      - 1.  [User presses _Create New Pak_]
      - 2.  What do you want to call this Pak?"
      - 3.  [User fills the corresponding field]
      - 4.  "Time to add some Pak Elements!"
      - 5.  [User presses _Add an Element_]
      - 6.  [User fills the corresponding field]
      - 7.  [User repeats steps 5 and 6 until _done_ is pressed.]

### **Fill the pak**

- Create an item within the pak
  - Create a form for users to input their data
    - Make this customizable for users to have unique experiences
      - Allow for extra text boxes, photos, etc.
    - (Be sure to cleanse user data so we don't crash)
  - Get permissions to access the device camera
    - Users should be able to easily snap a photo of their item to put in the app
    - Find a Flutter package that allows camera access if needed
  - Store new items in the pak within the Firebase
    - Connect the app to Firebase
    - Have users sign in with Google/Facebook? to store their data under their account
    - Write code to push and pull from the database (maybe a package?)

### **Display the Paks**

- Once items in a Pak are created, display them nicely
  - Likely using a Flutter ListView so that users can scroll and see all items in the Pak
  - Make a search bar(?) for users to easily see find a specific item

## **Brainstorming**

Start brainstorming ideas on how to solve the problem you’re working on. No idea is off limits. Once you have enough ideas, come up with a plan to test them (e.g. How will you test? In what order?).

```
Problem: Create the flow of the app, determine the best way to navigate between pages, test to ensure there are no bugs for users to exploit

We're choosing to focus on this problem since it will be the first piece we implement.
```

Solutions

- Create a side menu to navigate between screens on the app
  - Use a Drawer that opens from the side of the app to offer navigation options
- Create a bottom app bar for navigation
  - Create small icons (or use icons from Google/Apple's libraries) that symbolize different pages
- Use a tab system to move between pages
  - Pages may include 'Paks,' 'Chat,' 'Home'
- Create multiple individual pages and navigate between them with created buttons
  - Use Routes for this: https://flutter.dev/docs/cookbook/navigation/navigation-basics

Useful tests:

- Come up with various logical workflows that would accomplish the functionality of Pakrat. Use either a simple 'mock app,' a written simmulation, or an online survey to gain a pool of input as to which workflow is most desirable to users.
- Create visual representations of the app's pages. Pitch them to a sample group to learn of their preferences.
- Do some UI testing to ensure that navigation works the way we intend. Either do this by having a user physically mess with the app or make use of Flutter Integration Testing (Flutter's automated UI testing)
