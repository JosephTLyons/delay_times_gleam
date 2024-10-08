pub type DelayTimes {
  DelayTimes(
    v_whole: Float,
    v_half: Float,
    v_quarter: Float,
    v_8th: Float,
    v_16th: Float,
    v_32nd: Float,
    v_64th: Float,
    v_128th: Float,
  )
}

/// The note modifier.
pub type NoteModifier {
  Normal
  Dotted
  Triplet
}

/// The unit of the delay times.
pub type Unit {
  Ms
  Hz
}

/// Constructs a new `DelayTimes` struct.
pub fn new(
  beats_per_minute: Float,
  modifier: NoteModifier,
  unit: Unit,
) -> DelayTimes {
  let quarter_note_delay_value = case unit {
    Ms -> 60_000.0 /. beats_per_minute
    Hz -> beats_per_minute /. 60.0
  }

  let multiplier = case modifier {
    Normal -> 1.0
    Dotted -> 1.5
    Triplet -> 2.0 /. 3.0
  }

  DelayTimes(
    v_whole: { quarter_note_delay_value *. 4.0 } *. multiplier,
    v_half: { quarter_note_delay_value *. 2.0 } *. multiplier,
    v_quarter: quarter_note_delay_value *. multiplier,
    v_8th: { quarter_note_delay_value /. 2.0 } *. multiplier,
    v_16th: { quarter_note_delay_value /. 4.0 } *. multiplier,
    v_32nd: { quarter_note_delay_value /. 8.0 } *. multiplier,
    v_64th: { quarter_note_delay_value /. 16.0 } *. multiplier,
    v_128th: { quarter_note_delay_value /. 32.0 } *. multiplier,
  )
}

/// Converts a `DelayTimes` struct to a list of name-value tuples.
pub fn to_list(delay_times: DelayTimes) -> List(#(String, Float)) {
  [
    #("v_whole", delay_times.v_whole),
    #("v_half", delay_times.v_half),
    #("v_quarter", delay_times.v_quarter),
    #("v_8th", delay_times.v_8th),
    #("v_16th", delay_times.v_16th),
    #("v_32nd", delay_times.v_32nd),
    #("v_64th", delay_times.v_64th),
    #("v_128th", delay_times.v_128th),
  ]
}
