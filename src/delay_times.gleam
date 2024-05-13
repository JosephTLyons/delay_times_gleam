// TODO: Change order of composition to: new(120) |> triplet |> in_ms
// TODO: Make private, but testable
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

pub fn new(beats_per_minute: Float) -> DelayTimesNoteModifier {
  DelayTimesNoteModifier(beats_per_minute)
}

pub opaque type DelayTimesNoteModifier {
  DelayTimesNoteModifier(beats_per_minute: Float)
}

fn get_delay_times_instance(
  quarter_note_delay_value: Float,
  multiplier: Float,
) -> DelayTimes {
  DelayTimes(
    v_whole: { quarter_note_delay_value *. 4.0 } *. multiplier,
    v_half: { quarter_note_delay_value *. 2.0 } *. multiplier,
    v_quarter: { quarter_note_delay_value } *. multiplier,
    v_8th: { quarter_note_delay_value /. 2.0 } *. multiplier,
    v_16th: { quarter_note_delay_value /. 4.0 } *. multiplier,
    v_32nd: { quarter_note_delay_value /. 8.0 } *. multiplier,
    v_64th: { quarter_note_delay_value /. 16.0 } *. multiplier,
    v_128th: { quarter_note_delay_value /. 32.0 } *. multiplier,
  )
}

pub fn normal(
  delay_times_note_modifier: DelayTimesNoteModifier,
) -> DelayTimesPeriodicUnit {
  DelayTimesPeriodicUnit(delay_times_note_modifier, 1.0)
}

pub fn dotted(
  delay_times_note_modifier: DelayTimesNoteModifier,
) -> DelayTimesPeriodicUnit {
  DelayTimesPeriodicUnit(delay_times_note_modifier, 1.5)
}

pub fn triplet(
  delay_times_note_modifier: DelayTimesNoteModifier,
) -> DelayTimesPeriodicUnit {
  DelayTimesPeriodicUnit(delay_times_note_modifier, 2.0 /. 3.0)
}

pub opaque type DelayTimesPeriodicUnit {
  DelayTimesPeriodicUnit(
    delay_times_note_modifier: DelayTimesNoteModifier,
    multiplier: Float,
  )
}

pub fn in_ms(unit: DelayTimesPeriodicUnit) -> DelayTimes {
  let quarter_note_in_ms: Float =
    60_000.0 /. unit.delay_times_note_modifier.beats_per_minute
  get_delay_times_instance(quarter_note_in_ms, unit.multiplier)
}

pub fn in_hz(unit: DelayTimesPeriodicUnit) -> DelayTimes {
  let quarter_note_in_hz: Float =
    unit.delay_times_note_modifier.beats_per_minute /. 60.0
  get_delay_times_instance(quarter_note_in_hz, unit.multiplier)
}
