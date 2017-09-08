---

I was attempting to post `{Username:"testuser", Password:"testpass"}` to an API controller which received a ViewModel like so:

    public class UserViewModel
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }

    public HttpResponseMessage Post(UserViewModel value)
    {
        // do something
    }

The only problem was that it just wasn't finding the controller action. Spitting out error messages and generally being counter-productive.

After going through lots of StackOverflow posts and dismissing them, it turned out the first one was actually relevant. I was using a Chrome extension (Postman) to help with REST calls and even though I had selected JSON, it was still sending requests as `plain/text`, and not `application/json`.

I set the `Content-type` header to `application/json` and it started working.