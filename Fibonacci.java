import java.util.HashMap;
import java.util.Map;

class Fibonacci {
    private static final Map<Integer, Integer> memo = new HashMap<>();

    public static int compute(int n) {
        if (n <= 1) return n;
        if (memo.containsKey(n)) return memo.get(n);
        int result = compute(n - 1) + compute(n - 2);
        memo.put(n, result);
        return result;
    }
}

public class Main {
    public static void main(String[] args) {
        for (int i = 0; i < 10; i++) {
            System.out.print(Fibonacci.compute(i) + " ");
        }
    }
}

