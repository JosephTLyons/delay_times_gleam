import delay_times
import gleam/float
import gleam/io
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

fn delay_times_instances_are_equal(
  expected_delay_times: delay_times.DelayTimes,
  actual_delay_times: delay_times.DelayTimes,
) {
  compare_floats(
    expected_delay_times.v_whole,
    actual_delay_times.v_whole,
    "v_whole",
  )

  compare_floats(
    expected_delay_times.v_half,
    actual_delay_times.v_half,
    "v_half",
  )

  compare_floats(
    expected_delay_times.v_quarter,
    actual_delay_times.v_quarter,
    "v_quarter",
  )

  compare_floats(expected_delay_times.v_8th, actual_delay_times.v_8th, "v_8th")

  compare_floats(
    expected_delay_times.v_16th,
    actual_delay_times.v_16th,
    "v_16th",
  )

  compare_floats(
    expected_delay_times.v_32nd,
    actual_delay_times.v_32nd,
    "v_32nd",
  )

  compare_floats(
    expected_delay_times.v_64th,
    actual_delay_times.v_64th,
    "v_64th",
  )

  compare_floats(
    expected_delay_times.v_128th,
    actual_delay_times.v_128th,
    "v_128th",
  )
}

fn compare_floats(expected: Float, got: Float, error_identifer: String) {
  let error_message =
    error_identifer
    <> ": Expected: "
    <> float.to_string(expected)
    <> ", Got: "
    <> float.to_string(got)
  io.println(error_message)
  float.loosely_equals(expected, got, 0.0001)
  |> should.be_true
}

// ms tests (move to its own module?)

pub fn ms_normal_test() {
  let expected_delay_times =
    delay_times.DelayTimes(
      2000.0,
      1000.0,
      500.0,
      250.0,
      125.0,
      62.5,
      31.25,
      15.625,
    )

  let actual_delay_times =
    delay_times.new(120.0, delay_times.Normal, delay_times.Ms)

  delay_times_instances_are_equal(expected_delay_times, actual_delay_times)
}

pub fn ms_dotted_test() {
  let expected_delay_times =
    delay_times.DelayTimes(
      3000.0,
      1500.0,
      750.0,
      375.0,
      187.5,
      93.75,
      46.875,
      23.4375,
    )

  let actual_delay_times =
    delay_times.new(120.0, delay_times.Dotted, delay_times.Ms)

  delay_times_instances_are_equal(expected_delay_times, actual_delay_times)
}

pub fn ms_triplet_test() {
  let expected_delay_times =
    delay_times.DelayTimes(
      1333.3333,
      666.6666,
      333.3333,
      166.6666,
      83.3333,
      41.6666,
      20.8333,
      10.4166,
    )

  let actual_delay_times =
    delay_times.new(120.0, delay_times.Triplet, delay_times.Ms)

  delay_times_instances_are_equal(expected_delay_times, actual_delay_times)
}

// hz tests (move to its own module?)

pub fn hz_normal_test() {
  let expected_delay_times =
    delay_times.DelayTimes(8.0, 4.0, 2.0, 1.0, 0.5, 0.25, 0.125, 0.0625)

  let actual_delay_times =
    delay_times.new(120.0, delay_times.Normal, delay_times.Hz)

  delay_times_instances_are_equal(expected_delay_times, actual_delay_times)
}

pub fn hz_dotted_test() {
  let expected_delay_times =
    delay_times.DelayTimes(12.0, 6.0, 3.0, 1.5, 0.75, 0.375, 0.1875, 0.0937)

  let actual_delay_times =
    delay_times.new(120.0, delay_times.Dotted, delay_times.Hz)

  delay_times_instances_are_equal(expected_delay_times, actual_delay_times)
}

pub fn hz_triplet_test() {
  let expected_delay_times =
    delay_times.DelayTimes(
      5.3333,
      2.6666,
      1.3333,
      0.6666,
      0.3333,
      0.1666,
      0.0833,
      0.0416,
    )

  let actual_delay_times =
    delay_times.new(120.0, delay_times.Triplet, delay_times.Hz)

  delay_times_instances_are_equal(expected_delay_times, actual_delay_times)
}

// inteface tests (probably not necessary)

// Here are a couple of weird tests that just ensure we don't break the interface
// They can't fail, but at least the code won't compile if something about the inferface changes

pub fn single_shot_test() {
  delay_times.new(120.0, delay_times.Normal, delay_times.Ms)

  True
  |> should.be_true
}
