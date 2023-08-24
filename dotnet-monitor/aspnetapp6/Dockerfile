#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["aspnetapp6/aspnetapp6.csproj", "aspnetapp6/"]
RUN dotnet restore "aspnetapp6/aspnetapp6.csproj"
COPY . .
WORKDIR "/src/aspnetapp6"
RUN dotnet build "aspnetapp6.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "aspnetapp6.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "aspnetapp6.dll"]