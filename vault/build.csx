#r "nuget: Bullseye, 4.0.0"
#r "nuget: SimpleExec, 10.0.0"
#r "nuget: VaultSharp, 1.7.0.4"

using System.Runtime.CompilerServices;
using Newtonsoft.Json;
using VaultSharp;
using VaultSharp.V1.AuthMethods;
using VaultSharp.V1.AuthMethods.Token;
using static Bullseye.Targets;

// https://github.com/filipw/dotnet-script#script-location
public static string GetScriptPath([CallerFilePath] string path = null) => path;
public static string GetScriptFolder([CallerFilePath] string path = null) => Path.GetDirectoryName(path);

const string API_KEY = "fab5978b6ed44026a76bd0616fc2223e";
const string SECRETS_PATH = "907e91f8be1644a39607470446dfd659";

Target("default", () => Console.WriteLine("Run 'create-secrets'"));

Target("create-secrets", async () =>
{
    IAuthMethodInfo authMethod = new TokenAuthMethodInfo(API_KEY);

    // Initialize settings. You can also set proxies, custom delegates etc. here.
    var vaultClientSettings = new VaultClientSettings("http://localhost:8200", authMethod);

    IVaultClient vaultClient = new VaultClient(vaultClientSettings);

    var value = new Dictionary<string, object> {
        { "key1", "val1" },
        { "key2", 2 }
    };

    var writtenValue = await vaultClient.V1.Secrets.KeyValue.V2.WriteSecretAsync(SECRETS_PATH, value, mountPoint: "secret");

    var kv2Secret = await vaultClient.V1.Secrets.KeyValue.V2.ReadSecretAsync(SECRETS_PATH, mountPoint: "secret");
    var json = JsonConvert.SerializeObject(kv2Secret.Data.Data, Formatting.Indented);
    Console.WriteLine(json);
});

await RunTargetsAndExitAsync(Args);
