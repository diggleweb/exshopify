defmodule ExShopify.Country do
  @moduledoc """
  Reader's response to an article in a blog.
  """

  use ExShopify.Resource
  import ExShopify.API

  @type country_count :: {:ok, integer, %ExShopify.Meta{}}
  @type country_plural :: {:ok, [%ExShopify.Country{}], %ExShopify.Meta{}}
  @type country_singular :: {:ok, %ExShopify.Country{}, %ExShopify.Meta{}}

  @plural "countries"
  @singular "country"

  defstruct [:code, :id, :name, :provinces, :tax]

  @doc """
  Get a count of all countries.

  ## Examples

      iex> ExShopify.Country.count(session)
      {:ok, country, meta}
  """
  @spec count(%ExShopify.Session{}) :: country_count | error
  def count(session) do
    request(:get, "/countries/count.json", %{}, session)
    |> decode(&decode_count/1)
  end

  @doc """
  Create a country

  ## Examples

  ### Create a country using Shopify's tax rate for the country

      iex> params = %ExShopify.Country{
      ...>   code: "FR"
      ...> }

  ### Create a country using a custom tax rate

      iex> params = %ExShopify.Country{
      ...>   code: "FR",
      ...>   tax: 0.25
      ...> }

      iex> ExShopify.Country.create(session, params)
      {:ok, country, meta}
  """
  @spec create(%ExShopify.Session{}, map) :: country_singular | error
  def create(session, params) do
    request(:post, "/countries.json", wrap_in_object(params, @singular), session)
    |> decode(&decode_singular/1)
  end

  @doc """
  Delete a country.

      iex> ExShopify.Country.delete(session, 879921427)
      {:ok, nil, meta}
  """
  @spec delete(%ExShopify.Session{}, integer | String.t) :: country_singular | error
  def delete(session, id) do
    request(:delete, "/countries/#{id}.json", %{}, session)
    |> decode(&decode_nothing/1)
  end

  @doc """
  Show country.

  ## Examples

      iex> ExShopify.Country.find(session, 879921427)
      {:ok, country, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: country_singular | error
  def find(session, id, params) do
    request(:get, "/countries/#{id}.json", params, session)
    |> decode(&decode_singular/1)
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: country_singular | error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Get a list of all countries

  ## Examples

  ### Get all countries

      iex> ExShopify.Country.list(session)
      {:ok, countries, meta}

  ### Get all countries after the specified ID

      iex> ExShopify.Country.list(session, %{since_id: 359115488})
      {:ok, countries, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: country_plural | error
  def list(session, params) do
    request(:get, "/countries.json", params, session)
    |> decode(&decode_plural/1)
  end

  @spec list(%ExShopify.Session{}) :: country_plural | error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Update a country.

  ## Examples

      iex> ExShopify.Country.update(session, 879921427, %{tax: 0.1})
      {:ok, country, meta}
  """
  @spec update(%ExShopify.Session{}, integer | String.t, map) :: country_singular | error
  def update(session, id, params) do
    request(:put, "/countries/#{id}.json", wrap_in_object(params, @singular), session)
    |> decode(&decode_singular/1)
  end

  @doc false
  def response_mapping do
    %ExShopify.Country{
      provinces: [%ExShopify.Province{}]
    }
  end
end