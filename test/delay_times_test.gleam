import delay_times
import gleam/list
import startest
import startest/expect

pub fn main() {
  startest.run(startest.default_config())
}

fn delay_times_instances_are_equal(
  actual_delay_times: delay_times.DelayTimes,
  expected_delay_times: delay_times.DelayTimes,
) {
  let tolerance = 0.0001

  expect.to_loosely_equal(
    actual_delay_times.v_whole,
    expected_delay_times.v_whole,
    tolerance,
  )

  expect.to_loosely_equal(
    actual_delay_times.v_half,
    expected_delay_times.v_half,
    tolerance,
  )

  expect.to_loosely_equal(
    actual_delay_times.v_quarter,
    expected_delay_times.v_quarter,
    tolerance,
  )

  expect.to_loosely_equal(
    actual_delay_times.v_8th,
    expected_delay_times.v_8th,
    tolerance,
  )

  expect.to_loosely_equal(
    actual_delay_times.v_16th,
    expected_delay_times.v_16th,
    tolerance,
  )

  expect.to_loosely_equal(
    actual_delay_times.v_32nd,
    expected_delay_times.v_32nd,
    tolerance,
  )

  expect.to_loosely_equal(
    actual_delay_times.v_64th,
    expected_delay_times.v_64th,
    tolerance,
  )

  expect.to_loosely_equal(
    actual_delay_times.v_128th,
    expected_delay_times.v_128th,
    tolerance,
  )
}

// ms tests (move to its own module?)

pub fn ms_normal_test() {
  let actual_delay_times =
    delay_times.new(120.0, delay_times.Normal, delay_times.Ms)

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

  delay_times_instances_are_equal(actual_delay_times, expected_delay_times)
}

pub fn ms_dotted_test() {
  let actual_delay_times =
    delay_times.new(120.0, delay_times.Dotted, delay_times.Ms)

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

  delay_times_instances_are_equal(actual_delay_times, expected_delay_times)
}

pub fn ms_triplet_test() {
  let actual_delay_times =
    delay_times.new(120.0, delay_times.Triplet, delay_times.Ms)

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

  delay_times_instances_are_equal(actual_delay_times, expected_delay_times)
}

// hz tests (move to its own module?)

pub fn hz_normal_test() {
  let actual_delay_times =
    delay_times.new(120.0, delay_times.Normal, delay_times.Hz)

  let expected_delay_times =
    delay_times.DelayTimes(8.0, 4.0, 2.0, 1.0, 0.5, 0.25, 0.125, 0.0625)

  delay_times_instances_are_equal(actual_delay_times, expected_delay_times)
}

pub fn hz_dotted_test() {
  let actual_delay_times =
    delay_times.new(120.0, delay_times.Dotted, delay_times.Hz)

  let expected_delay_times =
    delay_times.DelayTimes(12.0, 6.0, 3.0, 1.5, 0.75, 0.375, 0.1875, 0.0937)

  delay_times_instances_are_equal(actual_delay_times, expected_delay_times)
}

pub fn hz_triplet_test() {
  let actual_delay_times =
    delay_times.new(120.0, delay_times.Triplet, delay_times.Hz)

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

  delay_times_instances_are_equal(actual_delay_times, expected_delay_times)
}

// to_list tests (move to its own module?)

pub fn to_list_test() {
  let delay_times = delay_times.new(120.0, delay_times.Triplet, delay_times.Hz)
  let actual_delay_times_list = delay_times |> delay_times.to_list
  let expected_delay_times_list = [
    #("v_whole", 5.3333),
    #("v_half", 2.6666),
    #("v_quarter", 1.3333),
    #("v_8th", 0.6666),
    #("v_16th", 0.3333),
    #("v_32nd", 0.1666),
    #("v_64th", 0.0833),
    #("v_128th", 0.0416),
  ]

  actual_delay_times_list
  |> list.zip(expected_delay_times_list)
  |> list.each(fn(pair) {
    let #(actual_delay_time, expected_delay_time) = pair
    expect.to_equal(actual_delay_time.0, expected_delay_time.0)
    expect.to_loosely_equal(actual_delay_time.1, expected_delay_time.1, 0.0001)
  })
}
