# Use the official image as a parent image
FROM cgr.dev/chainguard/dotnet-sdk:latest-dev

###################################
# Prerequisites
ENV PWSH_VERSION=7.3.8
# ENV ASPNETCORE_HTTP_PORTS="8080"
# ENV ASPNET_VERSION="8.0.0"
# ENV DOTNET_GENERATE_ASPNET_CERTIFICATE="false"
# ENV DOTNET_NOLOGO="true"
# ENV DOTNET_RUNNING_IN_CONTAINER="true"
# ENV DOTNET_SDK_VERSION="8.0.100"
# ENV DOTNET_USE_POLLING_FILE_WATCHER="true"
# ENV DOTNET_VERSION="8.0.0"

# # Set the DOTNET_ROOT environment variable
# ENV DOTNET_ROOT=/root/.dotnet

# # Add the DOTNET_ROOT and DOTNET_ROOT/tools directories to the PATH environment variable
# ENV PATH="${PATH}:${DOTNET_ROOT}:${DOTNET_ROOT}/tools"

# # Update the list of packages
# RUN apt update && apt-get install -y wget libc6 libicu-dev

# RUN     cd "$(mktemp -d)" \
#         &&  wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh \
#         &&  chmod +x ./dotnet-install.sh \
#         && ./dotnet-install.sh --version latest \
#         && dotnet --version


RUN     cd "$(mktemp -d)" \
        && wget https://github.com/PowerShell/PowerShell/releases/download/v${PWSH_VERSION}/powershell-${PWSH_VERSION}-linux-x64.tar.gz \
        && tar zxvf powershell-${PWSH_VERSION}-linux-x64.tar.gz -C /usr/bin \
        && chmod +x /usr/bin/pwsh \
        && pwsh --version



# Create a new .NET console application
RUN dotnet new console \
    && dotnet add package RabbitMQ.Client \
    && dotnet restore

CMD ["pwsh"]
