require File.expand_path '../../test_helper', __dir__

# Storage Blob Class
class TestListBlobs < Minitest::Test
  # This class posesses the test cases for the requests of comparing blobs.
  def setup
    @service = Fog::Storage::AzureRM.new(storage_account_credentials)
    @blob_client = @service.instance_variable_get(:@blob_client)
    @compare_blob_response = ApiStub::Requests::Storage::File.list_blobs
  end

  def test_compare_blob_success
    @blob_client.stub :list_blobs, @compare_blob_response do
      blob_properties_response = ApiStub::Requests::Storage::File.get_blob_properties
      @blob_client.stub :get_blob_properties, blob_properties_response do
        assert @service.compare_blob('container1', 'container2'), @compare_blob_response
      end
    end
  end
end
