(NeoConsoleTranscript onFileNamed: 'server-{1}.log') install.

Transcript
  cr;
  show: 'Starting '; show: (NeoConsoleTelnetServer startOn: 42001); cr;
  show: 'Starting '; show: (NeoConsoleMetricDelegate startOn: 42002); cr;
  flush.

NeoConsoleEnvironment current loadOSEnvironment.

(ZnServer defaultOn: (NeoConsoleEnvironment current at: #'PHARO_HTTP_PORT' ifAbsent: [ 8080 ]))
  logToTranscript;
  logLevel: 2;
  start.
