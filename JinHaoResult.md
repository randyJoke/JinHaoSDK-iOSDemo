# JinHaoResultError Enum

### Overview
The `JinHaoResultError` enum defines the different types of errors that may occur during operations with the JinHao accessory. These errors cover a range of issues from timeout and write errors to Bluetooth connectivity problems.

| Error Case      | Description                                            |
|-----------------|--------------------------------------------------------|
| `timeout`       | The operation timed out.                               |
| `writeError`    | An error occurred while writing data.                  |
| `readError`     | An error occurred while reading data.                  |
| `controlError`  | An error occurred during control operation.            |
| `btError`       | An error occurred related to Bluetooth connectivity.   |
| `unknown`       | An unknown error occurred.                             |
| `disconnected`  | The device was disconnected.                           |

---

# JinHaoResponse Enum

### Overview
The `JinHaoResponse` enum represents the possible responses received from a JinHao accessory after a request is made. It includes responses for reading program volumes, DSP data, global data, and hearing test information, as well as notifications about program changes.

| Response Case                        | Parameters                                          | Description                                          |
|--------------------------------------|-----------------------------------------------------|------------------------------------------------------|
| `didReadProgram`                     | `program: Int`, `volume: Int?`                      | Response for reading the program and volume.         |
| `didReadDsp`                         | `program: Int`, `data: Data`                        | Response for reading DSP data for a program.         |
| `didReadGlobal`                      | `data: Data`                                        | Response for reading global data.                    |
| `didReadProfile`                     | `data: Data`, `type: JinHaoProfileType`             | Response for reading profile data.                   |
| `didReadTransparency`                | `level: Int`                                        | Response for reading the transparency level.         |
| `didReadHearingTest`                 | `supported: Bool`                                   | Response for reading whether the hearing test is supported. |
| `didReadPairCode`                    | `code: Data`                                        | Response for reading the pair code.                  |
| `didNotify`                          | `program: Int`, `volume: Int`                       | Notification with program and volume information.     |
| `didRequest`                         | None                                                | A generic response indicating a request was made.    |
| `unknown`                            | `data: JinHaoRawData`                               | A response for unknown data.                         |

---

# JinHaoResult Enum

### Overview
The `JinHaoResult` enum represents the outcome of an operation. It can either be a success, with accompanying response data, or an error, with the associated error details.

| Result Case        | Parameters                                | Description                                           |
|--------------------|-------------------------------------------|-------------------------------------------------------|
| `success`          | `data: JinHaoResponse`                    | The operation was successful, and contains a response. |
| `error`            | `error: JinHaoResultError`                | The operation encountered an error.                   |
