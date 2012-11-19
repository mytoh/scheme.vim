
function! scheme#syntax#srfi#srfi_19#define_srfi_19()
  syntax keyword schemeFunc time make-time time? time-type time-nanosecond time-second
  syntax keyword schemeFunc date make-date date? date-nanosecond date-second date-minute 
  syntax keyword schemeFunc date-hour date-day date-month date-year date-zone-offset
  syntax keyword schemeFunc time-tai time-utc time-monotonic
  syntax keyword schemeFunc #|time-thread time-process|# time-duration
  syntax keyword schemeFunc read-leap-second-table copy-time current-time
  syntax keyword schemeFunc time-resolution time=? time>? time<? time>=? time<=?
  syntax keyword schemeFunc time-difference time-difference! add-duration
  syntax keyword schemeFunc add-duration! subtract-duration subtract-duration!
  syntax keyword schemeFunc time-tai->time-utc time-tai->time-utc! time-utc->time-tai
  syntax keyword schemeFunc time-utc->time-tai! time-monotonic->time-utc
  syntax keyword schemeFunc time-monotonic->time-utc! time-monotonic->time-tai
  syntax keyword schemeFunc time-monotonic->time-tai! time-utc->time-monotonic
  syntax keyword schemeFunc time-utc->time-monotonic! time-tai->time-monotonic
  syntax keyword schemeFunc time-tai->time-monotonic! time-tai->date time-utc->date
  syntax keyword schemeFunc time-monotonic->date date->time-utc date->time-tai
  syntax keyword schemeFunc date->time-monotonic leap-year? date-year-day
  syntax keyword schemeFunc date-week-day date-week-number current-date
  syntax keyword schemeFunc date->julian-day date->modified-julian-day
  syntax keyword schemeFunc time-utc->julian-day time-utc->modified-julian-day
  syntax keyword schemeFunc time-tai->julian-day time-tai->modified-julian-day
  syntax keyword schemeFunc time-monotonic->julian-day
  syntax keyword schemeFunc time-monotonic->modified-julian-day julian-day->time-utc
  syntax keyword schemeFunc julian-day->time-tai julian-day->time-monotonic
  syntax keyword schemeFunc julian-day->date modified-julian-day->date
  syntax keyword schemeFunc modified-julian-day->time-utc
  syntax keyword schemeFunc modified-julian-day->time-tai
  syntax keyword schemeFunc modified-julian-day->time-monotonic current-julian-day
  syntax keyword schemeFunc current-modified-julian-day date->string string->date
endfunction
