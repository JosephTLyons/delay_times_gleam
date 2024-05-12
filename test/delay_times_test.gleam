import delay_times
import gleam/float
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn delay_times_instances_are_equal_test(
  expected_delay_times: delay_times.DelayTimes,
  actual_delay_times: delay_times.DelayTimes,
) {
  let expected_and_actual_values = [
    #(expected_delay_times.v_whole, actual_delay_times.v_whole),
    #(expected_delay_times.v_half, actual_delay_times.v_half),
    #(expected_delay_times.v_quarter, actual_delay_times.v_quarter),
    #(expected_delay_times.v_8th, actual_delay_times.v_8th),
    #(expected_delay_times.v_16th, actual_delay_times.v_16th),
    #(expected_delay_times.v_32nd, actual_delay_times.v_32nd),
    #(expected_delay_times.v_64th, actual_delay_times.v_64th),
    #(expected_delay_times.v_128th, actual_delay_times.v_128th),
  ]

  expected_and_actual_values
  |> list.each(fn(a) {
    float.loosely_equals(a.0, a.1, 0.0001)
    |> should.be_true
  })
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
    delay_times.new(120.0)
    |> delay_times.in_ms()
    |> delay_times.normal()

  delay_times_instances_are_equal_test(expected_delay_times, actual_delay_times)
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
    delay_times.new(120.0)
    |> delay_times.in_ms()
    |> delay_times.dotted()

  delay_times_instances_are_equal_test(expected_delay_times, actual_delay_times)
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
    delay_times.new(120.0)
    |> delay_times.in_ms()
    |> delay_times.triplet()

  delay_times_instances_are_equal_test(expected_delay_times, actual_delay_times)
}

// hz tests (move to its own module?)

pub fn hz_normal_test() {
  let expected_delay_times =
    delay_times.DelayTimes(8.0, 4.0, 2.0, 1.0, 0.5, 0.25, 0.125, 0.0625)

  let actual_delay_times =
    delay_times.new(120.0)
    |> delay_times.in_hz()
    |> delay_times.normal()

  delay_times_instances_are_equal_test(expected_delay_times, actual_delay_times)
}

pub fn hz_dotted_test() {
  let expected_delay_times =
    delay_times.DelayTimes(12.0, 6.0, 3.0, 1.5, 0.75, 0.375, 0.1875, 0.0937)

  let actual_delay_times =
    delay_times.new(120.0)
    |> delay_times.in_hz()
    |> delay_times.dotted()

  delay_times_instances_are_equal_test(expected_delay_times, actual_delay_times)
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
    delay_times.new(120.0)
    |> delay_times.in_hz()
    |> delay_times.triplet()

  delay_times_instances_are_equal_test(expected_delay_times, actual_delay_times)
}

// inteface tests (probably not necessary)

// Here are a couple of weird tests that just ensure we don't break the interface
// They can't fail, but at least the code won't compile if something about the inferface changes

pub fn single_shot_test() {
  delay_times.new(120.0)
  |> delay_times.in_ms()
  |> delay_times.normal()

  True
  |> should.be_true
}

pub fn reusability_test() {
  let dt = delay_times.new(120.0)

  dt
  |> delay_times.in_ms()
  |> delay_times.normal()

  dt
  |> delay_times.in_ms()
  |> delay_times.dotted()

  dt
  |> delay_times.in_ms()
  |> delay_times.triplet()

  dt
  |> delay_times.in_hz()
  |> delay_times.normal()

  dt
  |> delay_times.in_hz()
  |> delay_times.dotted()

  dt
  |> delay_times.in_hz()
  |> delay_times.triplet()

  True
  |> should.be_true
}
