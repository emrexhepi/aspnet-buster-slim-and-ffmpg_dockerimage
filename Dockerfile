# See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
# EXPOSE 80
# EXPOSE 443
# EXPOSE 5432

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y ffmpeg

# Build the app
WORKDIR /src
COPY . .
WORKDIR "/src/Visualyst.Core.API"
RUN dotnet restore "Visualyst.Core.API.csproj"
RUN dotnet build "Visualyst.Core.API.csproj" -c Release -o /app/build


# FROM build AS publish
RUN dotnet publish "Visualyst.Core.API.csproj" -c Release -o /app/publish
RUN ls -la
RUN ffmpeg -v
WORKDIR /app/publish
ENTRYPOINT ["dotnet", "Visualyst.Core.API.dll"]

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app/publish .
