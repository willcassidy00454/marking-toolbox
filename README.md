# Marking Toolbox

This toolbox represents my peak OCD for perfectly formatted and no-time-wasted feedback for student coursework/exams. The toolbox runs on Excel, Matlab and Latex (yes..). You input the marks and comments via a tab-separated text file on Excel. This can include macros, tags to add penalty points, and invoke a pre-formatted solution. Then, through Matlab you can (a) parse the file, (b) generate PDFs with the feedback through latex, and finally (c) automatically send emails to students with the PDF as attachment.

### Example of the PDF output
<img src="docs/pdfoutput.png" width="600"/>

### Example of email to student with attachment
<img src="docs/email.png" width="600"/>

### Example of Excel spreadsheet that produced the PDF and email above
<img src="docs/excel.png" width="600"/>


## Getting Started

These instructions will get you a copy of the project up and running on your  machine.

### Prerequisites

You need Matlab. The automatic email sender works through an AppleScript, so it only runs on Mac. 


### Installing

Within matlab, run ```addpath your-path-to/marking-toolbox/src``` and you are ready to go! This only needs to be done once. 


### How to use


## Contributing

Pull requests are welcome.

## Authors

* **Enzo De Sena** - [desena.org](https://www.desena.org) (enzodesena AT gmail DOT com)


## License

This project is licensed under the MIT License.

