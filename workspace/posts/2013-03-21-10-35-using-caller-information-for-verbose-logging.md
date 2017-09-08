---

You simply prefix an *optional* parameter with one of the three attributes:

`[CallerMemberName]` provides the method or property name of the caller as a `string`.  
`[CallerFilePath]` provides the full path of the source file that contains the caller as a `string`.  
`[CallerLineNumber]` provides the line number in the source file at which the method is called as an `int`.  

Learn by example. Here I've made a simple logging method, we pass to it a string, and the compiler will fill in the rest. Make sure to including `System.Runtime.CompilerServices` in your `using` statements.

    static void VerboseLog(string value,
        [CallerMemberName] string callerMemberName = "",
        [CallerFilePath] string callerFilePath = "",
        [CallerLineNumber] int callerLineNumber = -1)
    {
        int index = callerFilePath.LastIndexOf(Path.DirectorySeparatorChar);
        string localPath = callerFilePath.Substring(index + 1);
        Debug.WriteLine("{0} {1}:{2} {3}",
            localPath, callerMemberName, callerLineNumber, value);
    }

Let's test it with a simple Console Application. Notice in the above method that I remove the full path to make it more readable. Not necessarily needed but pleasant nonetheless.

    static void Main(string[] args)
    {
        VerboseLog("this is a test");
        DoSomething();
    }

    static void DoSomething()
    {
        for (int i = 0; i < 5; i++)
        {
            VerboseLog(string.Format("something {0}", i));
        }
    }

This outputs:

    Program.cs Main:16 this is a test
    Program.cs DoSomething:24 something 0
    Program.cs DoSomething:24 something 1
    Program.cs DoSomething:24 something 2
    Program.cs DoSomething:24 something 3
    Program.cs DoSomething:24 something 4

So very simple, and yet very, very useful.