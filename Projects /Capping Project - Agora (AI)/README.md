# AI Intergration of Agora

### Objective
Build a Middleware that utilizes OpenAI’s API to assist scholars in writing academic papers by suggesting academic literature to the user based on the abstract, keywords, and existing sources of the paper they are writing.

### Features
- Give users articles based on what they’re writing
- Validate suggestions provided by AI using semantic scholar
- A button that triggers a panel with the suggestions
- Users can choose if they’re writing a paper or just taking notes, changing the preciseness when calling the OpenAI API 
- Ability to clipboard copy the returned sources with a click
- Users can click the link on each citation card to see the source
- Users choose the citation style: APA, MLA, Harvard, Chicago
- Ability to delete suggested citations or regenerate the full list of citations

### System Architecture
- NodeJS/Express
- EJS
- Postgres (Database)
- Figma (UI design)

### How to Use

Go to [freeagora.com](freeagora.com), create/login to an account.

You can find Agnus in the bottom right corner of individual workspaces. The Agnus icon is a dark gray circle with a robot image. 

Once you click on the Agnus icon, you are asked to select the document type that you are using. Select either paper or notes depending on your usage. To determine your current document, you are shown the document choice on the second line of the modal for Agnus. 

To learn more information about Agnus please hover over the information icon on the first line. 

After selecting the document type, you are shown the suggested articles in APA format. To change this selection, please choose another format from the list of choices under “Citation Type”. 

The suggested articles are linked to the Semantic Scholar links. To get the semantic scholar link, click on the text of the suggested article. 

To cite the article, click the “copy” button found in the bottom left corner of the individual suggestions. This button will copy the citation to your clipboard. You then need to paste the citation where needed in your document. 

To remove a suggested article from the list of articles, click on the “x” button on the top left corner of the individual suggestions. This button removes the article from the list of suggested articles. 

To regenerate the suggested articles, click on the “regenerate” button found on the bottom right of the Agnus modal. Once it is done loading, you will see your new suggested articles. Articles removed through the “x” button in earlier sessions will not be shown. 

To close Agnus click on the “x” button on the top right of the Agnus modal, or click on the Agnus icon used to originally open Agnus. To reopen Agnus, click on the circle Agnus icon found on the bottom right of the screen. 



