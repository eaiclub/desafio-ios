# Desafio iOS

Abaixo segue a demo do app construído, assim como algumas issues relacionadas ainda não endereçadas. Logo após, segue a descrição original do desafio.

## Demonstração do app

| Apod list  | Infinite Scroll | Exploring Apod |
|:---|:---:|---:|
| <img alt="all apods demo" src="https://user-images.githubusercontent.com/13206745/135726399-56a9618b-f89d-40b6-a63f-383dfbc2cdd9.gif" height="420" /> | <img alt="infinite scrolling demo" src="https://user-images.githubusercontent.com/13206745/135726520-134dc13f-18b0-485e-9bb3-3ecf6096b2e1.gif" height="420" /> | <img alt="exploring apod demo" src="https://user-images.githubusercontent.com/13206745/135726870-f0e3a498-8c45-426d-8cd3-b0e28c33696f.gif" height="420" /> |

## Criando um App de Scroll Infinito pra NASA

### **Descrição do aplicativo**
O desafio é criar um aplicativo para mostrar as fotos de um dos conteúdos mais populares da NASA, o que queremos é que você construa um aplicativo de Scroll Infinito para que possamos apreciar este maravilhoso conteúdo.

### **Recursos**
-   **Visuais**: Optamos  por não dar uma linha de design e fica a critério do candidato qual design escolher.
-   **API**. Exemplo de chamada na API:  `https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY`

|Parameter  |Type 		|Default 	| Description |
|-----------|-----------|-----------|-----------------------------------------------|
|date		|YYY-MM-DD	|today 		|The date of the APOD image to retrieve			|
|hd			|bool		|False      |Retrieve the URL for the high resolution image |
|api_key	|string		|DEMO_KEY	|api.nasa.gov key for expanded usage			|

-   **Ref. conteúdo**: [https://apod.nasa.gov/apod/](https://apod.nasa.gov/apod/ "https://apod.nasa.gov/apod/")

### **Não pode faltar**
-   Linguagem Swift
-   Gerenciamento de dependências "Cocoapods/Carthage"
-   Mapeamento JSON utilizando protocolo Codable


### **Plus**

-   Tela com gestos para ampliar a foto do dia
-   Apresentar os vídeos
-   Testes unitários
-   Testes de Interface
-   Testes funcionais
-   Cache de imagens e da API
-   Suporte a mudanças de orientação das telas sem perder estado


### **Como enviar?**

A solução precisa ser enviada via pull request para este repositório.

1.  Faça o fork desse repositório
2.  Desenvolva
3.  Execute os commits, de forma "organizada e semântica"
4.  Use Github, para realizar Pull Request.

Se possível deixe o fork público para facilitar a inspeção do código.


### **O que será avaliado?**

- Qualidade do código  
• Comentários  
• Organização  
• Semântica  
• Código idiomático com base na linguagem  
• Descrição dos commits  

- Arquitetura  
• Qual a arquitetura escolhida  
• Implementação  

- Otimização de recursos  
• Cache de API  
• Cache de Imagens  

- UX  
• Fluidez na utilização do app  


### **Dica**
Não existe uma api para trazer mais de um conteúdo por vez, como fazer?
