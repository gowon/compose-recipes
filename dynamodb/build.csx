#r "nuget: Bullseye, 4.0.0"
#r "nuget: SimpleExec, 10.0.0"
#r "nuget: AWSSDK.DynamoDBv2, 3.7.3.22"

using System.Runtime.CompilerServices;
using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DocumentModel;
using Amazon.DynamoDBv2.Model;
using Amazon.Runtime;
using static Bullseye.Targets;

// https://github.com/filipw/dotnet-script#script-location
public static string GetScriptPath([CallerFilePath] string path = null) => path;
public static string GetScriptFolder([CallerFilePath] string path = null) => Path.GetDirectoryName(path);

Target("default", () => Console.WriteLine("Hello, world!"));

Target("create-tables", async () =>
{
    var clientConfig = new AmazonDynamoDBConfig()
    {
        ServiceURL = "http://localhost:8000",
    };

    var client = new AmazonDynamoDBClient("local", "local", clientConfig);
    var tableName = "ProductCatalog";

    Console.WriteLine("\n*** Creating table ***");
    var request = new CreateTableRequest
    {
        TableName = tableName,
        AttributeDefinitions = new List<AttributeDefinition>
            {
                new AttributeDefinition
                {
                    AttributeName = "Id",
                    AttributeType = ScalarAttributeType.N
                }
            },
        KeySchema = new List<KeySchemaElement>
            {
                new KeySchemaElement
                {
                    AttributeName = "Id",
                    KeyType = KeyType.HASH
                }
            },
        ProvisionedThroughput = new ProvisionedThroughput(1, 1)
    };

    var response = await client.CreateTableAsync(request);

    var tableDescription = response.TableDescription;
    Console.WriteLine("{1}: {0} \t ReadsPerSec: {2} \t WritesPerSec: {3}",
              tableDescription.TableStatus,
              tableDescription.TableName,
              tableDescription.ProvisionedThroughput.ReadCapacityUnits,
              tableDescription.ProvisionedThroughput.WriteCapacityUnits);

    string status = tableDescription.TableStatus;
    Console.WriteLine(tableName + " - " + status);
});

Target("seed-data", DependsOn("create-tables"),
async () =>
{
    var clientConfig = new AmazonDynamoDBConfig()
    {
        ServiceURL = "http://localhost:8000",
    };

    var client = new AmazonDynamoDBClient("local", "local", clientConfig);
    var tableName = "ProductCatalog";
    var table = Table.LoadTable(client, tableName);
    var json = File.ReadAllText(Path.Combine(GetScriptFolder(), "seed-data", $"{tableName}.json"));
    var items = Document.FromJsonArray(json);

    foreach (var item in items)
    {
        await table.PutItemAsync(item);
    }
});

await RunTargetsAndExitAsync(Args);
