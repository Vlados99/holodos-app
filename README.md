# Holodos app

The application is written using Flutter/Dart technologies. </br>
"Bloc" and "Cubit" were used to manage states. When writing the project, "Clean architecture" was followed. </br>
The Firebase Firestore database is used.

## Login page

On the login page there are two fields for mail and password. Both fields are validated and if the data is incorrect, the user will receive a message about this. If the data is correct, the user will be redirected to the main page. From this page, you can go to the registration page, the password reset page, and you can also go to the main page without logging in.

<img src="https://user-images.githubusercontent.com/39212835/210564540-82c1a9b3-f710-4646-b972-4b65b5ce92f3.jpg" width=25%>

## Registration page

On the registration page there are three fields for input, the first for the username, the second for the email and the last for the password. All fields are validated and in case of errors, the user will receive a message about this. If all data is correct, the user will be registered in the system. From this page you can go to the login page and also go to the main page without registration.

<img src="https://user-images.githubusercontent.com/39212835/210565993-2d40bde6-34df-4c94-8b88-f0ea74cc7f58.jpg" width=25%>

## Password reset page

There is only one field for entering mail on this page. If the data is incorrect or does not exist in the system, the user will receive a message about this. If successful, the user will receive an email with a link to change the password.

<img src="https://user-images.githubusercontent.com/39212835/210568105-11f0bb4c-39f5-4426-b334-d2a8cdb448a4.jpg" width=25%>

## Application menu

There are 5 buttons in the side menu.</br>
 - "Recipes" is the main page, upon clicking the user will be transferred to the page with recipes. </br>
 - Clicking on the "Products" button will take the user to a page with all products.</br>
 - Clicking on the "Favorite recipes" button will take the user to the page with favorite recipes. If the user is not logged in, he cannot view the recipes.</br>
 - Clicking on the "My products" button will take the user to a page with a list of their own products. If the user is not logged in, he cannot view his products and interact with them.</br>
 - The bottom button changes depending on whether the user is logged in or not. If the user is not logged in, the button will be called "Sign in", if logged in - "Sign out". The "Sign in" button will take the user to the login page. The "Sign out" button logs out the user and takes him to the login page.

<img src="https://user-images.githubusercontent.com/39212835/210570929-02a3d035-f5ce-4d81-a66b-f8b8ccb76802.jpg" width=25%>

## Main page

The main page represents all the recipes. </br>
A user who is not logged in can search for a recipe by name and selected products, filter recipes, and go to a page with a specific recipe by clicking on it. </br>
Additionally, a logged in user can search for recipes based on their own products and add or remove recipes from their favorites.

<table>
  <tr>
    <td><em>Main page, the user is not logged in</em></td>
    <td><em>Main page with selected products to search</em></td>
    <td><em>Main page, the user is logged in</em></td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/39212835/210575989-d97afb97-176e-4f9b-987a-c4669f7f5191.jpg"></td>
    <td><img src="https://user-images.githubusercontent.com/39212835/210576037-d05df751-2dd0-4178-9fd4-e774c0ffc7aa.jpg"></td>
    <td><img src="https://user-images.githubusercontent.com/39212835/210576151-35614307-991b-4297-aade-4a7ae00e02ba.jpg"></td>
  </tr>
</table>

When you click on the "Filter" button, a dialog box will appear where you can select the recipe category, cooking time, complexity, number of servings, and cuisine.

<img src="https://user-images.githubusercontent.com/39212835/210599524-2df42050-dc01-407c-8c74-31314ae6ed77.jpg" width=25%>

When you click on the search icon on the appbar, a search text field appears, hints, and after the search is performed, recipes appear below.

<img src="https://user-images.githubusercontent.com/39212835/210600298-15246d03-b9d2-44f5-a011-5b9323c758e1.jpg" width=25%>

## Products page

The products page contains a list of all products, it is also possible to search for a product by name.

<img src="https://user-images.githubusercontent.com/39212835/210601608-c88437a0-7aef-4491-9d19-50758dca0d5b.jpg" width=25%>

After clicking on the product, the logged in user will be able to add the selected product to their product list. A dialog box will open to him where he can enter the quantity of the product and add it. A user who is not logged in will receive a message that he does not have this option and must log in.

<img src="https://user-images.githubusercontent.com/39212835/210602682-38c1d409-db44-43cb-bcb3-012989478f0e.jpg" width=25%>

When you click on the search icon on the appbar, a search text field appears, hints, and after the search is performed, products appear below.

<img src="https://user-images.githubusercontent.com/39212835/210602669-d00d607a-1306-4a10-bd4b-b1ae6fd8a67b.jpg" width=25%>

## Favorite recipes page

A logged-in user will see all favorite recipes on the page with favorite recipes. On it, the user can also remove a recipe from favorites or go to detailed recipe information. A user who is not logged in will see a message in the middle with a button that will take the user to the login page.

<table>
  <tr>
    <td><em>Page with favorite recipes, logged in user</em></td>
    <td><em>Page with favorite recipes, not logged in user</em></td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/39212835/210605211-c9c04c04-1bca-4a48-9e49-f2567fef8548.jpg" width=50%></td>
    <td><img src="https://user-images.githubusercontent.com/39212835/210605142-61971b36-fc1e-4f9e-9dda-2f59bb56b11f.jpg" width=50%></td>
  </tr>
</table>

## My products page

A logged in user will see a list of their own products on the My Products page. By clicking on the product, the user can change its quantity. By clicking on the icon on the right, the user can remove the product from his product list. A user who is not logged in will see a message in the middle with a button that will take the user to the login page.

<table>
  <tr>
    <td><em>My products page, logged in user</em></td>
    <td><em>My products page, not logged in user</em></td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/39212835/210611991-a65550a3-d94a-4a35-ac82-718ca59e9a0c.jpg" width=50%></td>
    <td><img src="https://user-images.githubusercontent.com/39212835/210611962-7b1859a2-d67f-4a71-85a8-02cccd0f704e.jpg" width=50%></td>
  </tr>
</table>

## A page with a specific recipe

On a specific recipe page, the user will see detailed information about the recipe, such as complexity, cooking time, number of servings, cuisine, short description, ingredient list, and step-by-step cooking instructions. At the bottom there is a section with comments. A user who is not logged in cannot add a comment to a recipe.

<table>
  <tr>
    <td><em>Specific recipe page, logged in user</em></td>
    <td><em>Specific recipe page, not logged in user</em></td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/39212835/210613373-a8bcf42a-c1cc-458b-9bd9-9558b0ea3af8.jpg" width=50%></td>
    <td><img src="https://user-images.githubusercontent.com/39212835/210613288-2a4e2b7d-7933-46ee-ab73-599f20ab6894.jpg" width=50%></td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/39212835/210613388-e78ed909-e291-4ad0-9f1e-b7e74bad196c.jpg" width=50%></td>
    <td><img src="https://user-images.githubusercontent.com/39212835/210613305-203b9af4-0c50-421f-946b-52bbbedf542e.jpg" width=50%></td>
  </tr>
</table>
