pragma Singleton

import Quickshell

Singleton {
  function format(format: string): string {
    return Qt.formatDateTime(clock.date, format)
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
