#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
ARG PROJECT_NAME
WORKDIR /src
COPY . .
RUN dotnet restore
WORKDIR "/src/${PROJECT_NAME}"
RUN dotnet build "${PROJECT_NAME}.csproj" -c Release -o /app/build

FROM build AS publish
ARG PROJECT_NAME
RUN dotnet publish "${PROJECT_NAME}.csproj" -c Release -o /app/publish

FROM base AS final
ARG PROJECT_NAME
ENV PROJECT_NAME=$PROJECT_NAME
WORKDIR /app
COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "${PROJECT_NAME:.dll}"]
CMD dotnet ${PROJECT_NAME}.dll