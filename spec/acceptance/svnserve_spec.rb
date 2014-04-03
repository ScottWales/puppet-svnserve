require 'spec_helper_acceptance'

describe "svnserve" do
    it "applies the module cleanly" do
        pp = <<-EOS.unindent
            class {'svnserve':}
        EOS

        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes  => true)
    end

    context "with a custom user set" do
        it "creates the needed users" do
            pp = <<-EOS.unindent
                class {'svnserve':
                    user  => 'foo',
                    group => 'bar',
                }
            EOS

            apply_manifest(pp, :catch_failures => true)
            apply_manifest(pp, :catch_changes  => true)

        end

        describe user('foo') do
            it {should exist}
            it {should belong_to_group 'bar'}
        end
    end

    it "cleans up after itself" do
        pp = <<-EOS.unindent
            class {'svnserve':
                ensure => absent
            }
        EOS

        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes  => true)
    end

    after :all do
        pp = "class {'svnserve': ensure => absent }"

        apply_manifest(pp, :catch_failures => true)
    end
end
