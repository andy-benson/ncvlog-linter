'use babel';

import {
  exec,
} from 'atom-linter';

export function activate() {
  // Fill something here, optional
}

export function deactivate() {
  // Fill something here, optional
}

NamedRegexp=null;

function parse(data, regex) {

  if (NamedRegexp === null) {
    NamedRegexp = require('named-js-regexp');
  }
  

  var tmp;
  var messages = [];
  var compiledRegexp = new NamedRegexp(regex, 'gm');
  var rawMatch = compiledRegexp.exec(data);

  while (rawMatch !== null) {
    var match = rawMatch.groups();
    var severity = match.severity;
    var excerpt = match.excerpt;
    var file = match.file || null;

    var lineStart = parseInt(match.lineStart || match.line || 0);
    var colStart = parseInt(match.colStart || match.col || 0);
    var lineEnd = parseInt(match.lineEnd || match.line || 0);
    var colEnd = parseInt(match.colEnd || match.col || 1000);

    messages.push({
      severity: severity.toLowerCase(),
      excerpt: excerpt,
      location:{
        file:file,
        position: [[lineStart-1, colStart], [lineEnd-1, colEnd]]
      }
    });

    rawMatch = compiledRegexp.exec(data);
  }

  return messages;
}

export function provideLinter() {
  return {
    name: 'ncvlog-linter',
    scope: 'file', // or 'project'
    lintsOnChange: true,
    grammarScopes: ['source.verilog', 'source.systemverilog'],
    lint(textEditor) {
      const editorPath = textEditor.getPath()


      return exec(
        'python3',
        [__dirname+'/core_ncvlog.py', textEditor.getPath()],
        {
          stream: 'both',
          throwOnStderr: false,
        }
      ).then((output) => {
        
          // diable error checks - seems very sensitive , as ehn running core_ncvlog.py directly do not get any errors returned
          // if (output.exitCode != 0) {
          //   atom.notifications.addError(
          //     'atom-ncvlog-linter: error from core_ncvlog.py \n\n'+ output.stderr + '\n\n' + output.exitCode,
          //     {
          //       detail: output.exitCode,
          //       dismissable: true,
          //       icon: 'alert',
          //     }
          //   );
          // }
        
          // console.log("###atom-ncvlog-linter.js###")
          // console.log(output.stdout)
          // console.log("---- end---------")
         return parse(output.stdout+'\n\n',
                      '(?<file>.+?):(?<line>[0-9]+):(?<severity>.+?):(?<excerpt>(?:.|[\n\r])+?)\n\n');


      });
    }
  }
}


// standard template when clicking generate-> package 
// import NcvlogLinterView from './ncvlog-linter-view';
// import { CompositeDisposable } from 'atom';
// 
// export default {
// 
//   ncvlogLinterView: null,
//   modalPanel: null,
//   subscriptions: null,
// 
//   activate(state) {
//     this.ncvlogLinterView = new NcvlogLinterView(state.ncvlogLinterViewState);
//     this.modalPanel = atom.workspace.addModalPanel({
//       item: this.ncvlogLinterView.getElement(),
//       visible: false
//     });
// 
//     // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
//     this.subscriptions = new CompositeDisposable();
// 
//     // Register command that toggles this view
//     this.subscriptions.add(atom.commands.add('atom-workspace', {
//       'ncvlog-linter:toggle': () => this.toggle()
//     }));
//   },
// 
//   deactivate() {
//     this.modalPanel.destroy();
//     this.subscriptions.dispose();
//     this.ncvlogLinterView.destroy();
//   },
// 
//   serialize() {
//     return {
//       ncvlogLinterViewState: this.ncvlogLinterView.serialize()
//     };
//   },
// 
//   toggle() {
//     console.log('NcvlogLinter was toggled!');
//     return (
//       this.modalPanel.isVisible() ?
//       this.modalPanel.hide() :
//       this.modalPanel.show()
//     );
//   }
// 
// };
