#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["aspnetapp7/aspnetapp7.csproj", "aspnetapp7/"]
RUN dotnet restore "aspnetapp7/aspnetapp7.csproj"
COPY . .
WORKDIR "/src/aspnetapp7"
RUN dotnet build "aspnetapp7.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "aspnetapp7.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "aspnetapp7.dll"]