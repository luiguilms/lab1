FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /src
COPY lab1.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /publish
COPY --from=build-env /publish .
EXPOSE 8080
ENTRYPOINT [ "dotnet", "lab1.dll" ]