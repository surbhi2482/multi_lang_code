using System;

class StringReverser {
    public string Reverse(string input) {
        char[] chars = input.ToCharArray();
        Array.Reverse(chars);
        return new string(chars);
    }
}

class Program {
    static void Main() {
        StringReverser reverser = new StringReverser();
        Console.WriteLine(reverser.Reverse("Surbhi"));
    }
}
