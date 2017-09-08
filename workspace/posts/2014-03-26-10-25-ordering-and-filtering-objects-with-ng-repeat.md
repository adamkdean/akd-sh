---

The solution to this is to push the contents of the object into an array using a `filter`. By keeping the references intact, we are still able to bind to the objects, as they are essentially the same object.

    .filter('objectAsArray', function() {
        return function(object) {
            var array = []; 
            for (item in object) {
                array.push(object[item]);
            }
            return array;
        }
    });

Let's look at what we'd need if we wanted to order and/or filter an array:

    <p ng-repeat="item in itemArray | orderBy: 'order' | filter: {visible: true}">
        {{item}}
    </p>

But what if that was an object? Well, we just pop the `objectAsArray` filter in:

    <p ng-repeat="item in itemObj | objectAsArray | orderBy: 'order' | filter: {visible: true}">
        {{item}}
    </p>

This is indeed a very useful little filter. 

View the [live plunkr example here](http://plnkr.co/edit/RObsrXoSSkRA271w9WJr?p=preview).