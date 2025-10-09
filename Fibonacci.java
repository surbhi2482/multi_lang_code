class Fibonacci {
    public int compute(int n) {
        if (n <= 1) return n;
        return compute(n - 1) + compute(n - 2);
    }
}

public class Main {
    public static void main(String[] args) {
        Fibonacci fib = new Fibonacci();
        for (int i = 0; i < 10; i++) {
            System.out.print(fib.compute(i) + " ");
        }
    }
}
