# Etapa 1: Imagem base do .NET SDK para build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

# Etapa 2: Configure o diretório de trabalho
WORKDIR /App

# Etapa 3: Copie o projeto para a imagem
COPY . ./

# Etapa 4: Restaure as dependências
RUN dotnet restore

# Etapa 5: Copie o restante dos arquivos e compile
RUN dotnet publish -c Release -o out

# Etapa 6: Imagem runtime para execução
FROM mcr.microsoft.com/dotnet/aspnet:8.0 
WORKDIR /App
COPY --from=build-env /App/out .

# Etapa 7: Comando de execução
ENTRYPOINT ["dotnet", "FirstImageDocker.dll"]
