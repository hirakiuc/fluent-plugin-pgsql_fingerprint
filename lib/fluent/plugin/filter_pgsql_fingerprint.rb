require 'fluent/plugin/filter'

module Fluent
  module Plugin
    class PgsqlFingerprintFilter < Filter
      Plugin.register_filter('pgsql_fingerprint', self)

      def initialize
        super
        require 'pg_query'
      end

      config_param :target_key, :string, default: 'sql'
      config_param :added_key, :string, default: 'fingerprint'

      def configure(conf)
        super
      end

      def start
        super
      end

      def shutdown
        super
      end

      def filter(tag, time, record)
        sql = hash_get(record, @target_key)
        if !sql.nil? && !sql.empty?
          record[@added_key] = fingerprint(sql)
        end
        record
      end

      private

      def fingerprint(sql)
        return sql if sql.empty?
        PgQuery.normalize(sql).encode!(Encoding::UTF_8)
      rescue => err
        log.error "filter_pgsql_fingerprint:", error: err.to_s, error_class: e.class.to_s
        log.warn_backtrace err.backtrace
        return sql
      end

      def hash_get(hash, key)
        return hash[key.to_sym] if hash.key?(key.to_sym)
        return hash[key] if hash.key?(key)
        nil
      end
    end
  end
end
