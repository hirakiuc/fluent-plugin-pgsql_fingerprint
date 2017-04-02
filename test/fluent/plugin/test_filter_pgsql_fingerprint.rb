require_relative '../../helper.rb'

require 'fluent/test/driver/filter'
require 'fluent/plugin/filter_pgsql_fingerprint'

class PgsqlFingerprintFilterTest < Test::Unit::TestCase
  include Fluent

  setup do
    Fluent::Test.setup
    @time = Time.now.to_i
  end

  def create_driver(conf = '')
    Fluent::Test::Driver::Filter.new(
      Fluent::Plugin::PgsqlFingerprintFilter
    ).configure(conf)
  end

  sub_test_case 'configure' do
    test 'check default' do
      d = create_driver
      assert_equal 'sql', d.instance.target_key
      assert_equal 'fingerprint', d.instance.added_key
    end

    test 'check custom config' do
      d = create_driver(%[target_key my_target\nadded_key my_added])

      assert_equal 'my_target', d.instance.target_key
      assert_equal 'my_added', d.instance.added_key
    end
  end

  sub_test_case 'filter_stream' do
    def messages(key = 'sql')
      [
        {key => %|SELECT * FROM weather WHERE city = 'San Francisco' AND prcp > 0.0;|},
        {key => %|SELECT city, max(temp_lo) FROM weather WHERE city LIKE 'S%' GROUP BY city HAVING max(temp_lo) < 40;|}
      ]
    end

    def filter(config, msgs)
      d = create_driver(config)
      d.run {
        msgs.each { |msg|
          d.feed("filter.test", @time, msg)
        }
      }
      d.filtered_records
    end

    test 'empty config' do
      records = filter('', messages)
      assert_equal(2, records.size)

      assert_equal %|SELECT * FROM weather WHERE city = ? AND prcp > ?;|, records[0]['fingerprint']
      assert_equal %|SELECT city, max(temp_lo) FROM weather WHERE city LIKE ? GROUP BY city HAVING max(temp_lo) < ?;|, records[1]['fingerprint']
    end

    test 'custom config' do
      configs = %|
        target_key target
        added_key  normalized_query
      |
      records = filter(configs, messages('target'))
      assert_equal(2, records.size)

      assert_equal %|SELECT * FROM weather WHERE city = ? AND prcp > ?;|, records[0]['normalized_query']
      assert_equal %|SELECT city, max(temp_lo) FROM weather WHERE city LIKE ? GROUP BY city HAVING max(temp_lo) < ?;|, records[1]['normalized_query']
    end
  end
end
