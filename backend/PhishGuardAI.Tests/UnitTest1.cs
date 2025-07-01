namespace PhishGuardAI.Tests;

public class UnitTest1
{
    [Fact]
    public void Test_BasicAssertions_ShouldPass()
    {
        // Arrange
        var expected = "PhishGuardAI";
        var actual = "PhishGuardAI";

        // Act & Assert
        Assert.Equal(expected, actual);
        Assert.True(expected.Length > 0);
        Assert.NotNull(actual);
    }

    [Fact]
    public void Test_MathOperations_ShouldWork()
    {
        // Arrange
        int a = 5;
        int b = 3;

        // Act
        int sum = a + b;
        int product = a * b;

        // Assert
        Assert.Equal(8, sum);
        Assert.Equal(15, product);
        Assert.True(sum > b);
    }
}