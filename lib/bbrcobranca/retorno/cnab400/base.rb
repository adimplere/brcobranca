# -*- encoding: utf-8 -*-
require 'parseline'

module Bbrcobranca
  module Retorno
    module Cnab400
      class Base < Bbrcobranca::Retorno::Base

        # Load lines
        def self.load_lines(file, options={})
          return nil if file.blank?

          codigo_banco = codigo_banco_do_arquivo(file)

          case codigo_banco
          when '001'
            Bbrcobranca::Retorno::Cnab400::BancoBrasil.load_lines(file, options)
          when "004"
            Bbrcobranca::Retorno::Cnab400::BancoNordeste.load_lines(file, options)
          when "041"
            Bbrcobranca::Retorno::Cnab400::Banrisul.load_lines(file, options)
          when "070"
            Bbrcobranca::Retorno::Cnab400::BancoBrasilia.load_lines(file, options)
          when "097"
            Bbrcobranca::Retorno::Cnab400::Credisis.load_lines(file, options)
          when "237"
            Bbrcobranca::Retorno::Cnab400::Bradesco.load_lines(file, options)
          when "341"
            Bbrcobranca::Retorno::Cnab400::Itau.load_lines(file, options)
          when "033", "353"
            Bbrcobranca::Retorno::Cnab400::Santander.load_lines(file, options)
          else
            Bbrcobranca::Retorno::RetornoCnab400.load_lines(file, options)
          end
        end

        # Codigo do banco lido do arquivo.
        # Registro Header [76..78]
        def self.codigo_banco_do_arquivo(file)
          arquivo = File.open(file, "r")
          header = arquivo.gets
          codigo_banco = header.blank? ? nil : header[76..78]
          arquivo.close
          codigo_banco
        end

      end
    end
  end
end
