# Análise de Séries Temporais no Mercado Financeiro

# Referencia: http://www.quantmod.com

# Instalar e carregar os pacotes necessários
install.packages("quantmod")
install.packages("xts")
install.packages("moments")
library(quantmod)
library(xts)
library(moments)


# Seleção do período de análise
startDate = as.Date("2019-01-01")
endDate = as.Date("2019-12-31")


# Download dos dados do período
# Obs: O Yahoo Finance está passando por mudanças 
# e o serviço de cotações online pode estar instável
getSymbols("PETR4.SA", src = "yahoo", from = startDate, to = endDate, auto.assign = T)
# PETR4.SA = readRDS("PETR4.SA.rds")


# Checando o tipo de dado retornado
class(PETR4.SA)
is.xts(PETR4.SA)


# Mostra os primeiros registros para as ações da Petrobras
head(PETR4.SA)
View(PETR4.SA)


# Analisando os dados de fechamento 
PETR4.SA.Close <- PETR4.SA[, "PETR4.SA.Close"]
is.xts(PETR4.SA.Close)
head(Cl(PETR4.SA),5)


# Agora, vamos plotar o gráfico da Petrobras
# Gráfico de candlestick da Petrobras
candleChart(PETR4.SA)


# Plot do fechamento
plot(PETR4.SA.Close, main = "Fechamento Diário Ações Petrobras",
     col = "red", xlab = "Data", ylab = "Preço", major.ticks = 'months',
     minor.ticks = FALSE)


# Adicionado as bandas de bollinger ao gráfico, com média de 20 períodos e 2 desvios
# Bollinger Band
# Como o desvio padrão é uma medida de volatilidade, 
# Bollinger Bands ajustam-se às condições de mercado. Mercados mais voláteis, 
# possuem as bandas mais distantes da média, enquanto mercados menso voláteis possuem as
# bancas mais próximas da média
addBBands(n = 20, sd = 2)


# Adicionando o indicador ADX, média 11 do tipo exponencial
addADX(n = 11, maType = "EMA")


# Calculando logs diários
PETR4.SA.ret <- diff(log(PETR4.SA.Close), lag = 1)


# Remove valores NA na prosição 1
PETR4.SA.ret <- PETR4.SA.ret[-1] 


# Plotar a taxa de retorno
plot(PETR4.SA.ret, main = "Fechamento Diário das Ações da Petrobras",
     col = "red", xlab = "Data", ylab = "Retorno", major.ticks = 'months',
     minor.ticks = FALSE)


# Calculando algumas medidas estatísticas
statNames <- c("Mean", "Standard Deviation", "Skewness", "Kurtosis")
PETR4.SA.stats <- c(mean(PETR4.SA.ret), sd(PETR4.SA.ret), skewness(PETR4.SA.ret), kurtosis(PETR4.SA.ret))
names(PETR4.SA.stats) <- statNames
PETR4.SA.stats


# Salvando os dados em um arquivo .rds (arquivo em formato binário do R)
# getSymbols("PETR4.SA", src = 'yahoo')
saveRDS(PETR4.SA, file = "PETR4.SA.rds") # Salva os dados em formato binário
Ptr = readRDS("PETR4.SA.rds")
dir()
head(Ptr)