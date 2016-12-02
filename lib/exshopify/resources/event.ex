defmodule ExShopify.Event do
  @moduledoc """
  Generated by specific Shopify resources when specific things happen, such as
  the creation of an article, the placement or fulfillment of an order, the
  addition or deletion of a product,
  """

  import ExShopify.API
  import ExShopify.Resource

  @type event_plural :: {:ok, [%ExShopify.Event{}], %ExShopify.Meta{}}
  @type event_singular :: {:ok, %ExShopify.Event{}, %ExShopify.Meta{}}

  @plural "events"
  @singular "event"

  defstruct [:arguments, :body, :created_at, :description, :id, :message, :path,
             :subject_id, :subject_type, :verb]

  @doc """
  Receive a count of all events.

  ## Examples

      iex> ExShopify.Event.count(session)
      {:ok, count, meta}
  """
  @spec count(%ExShopify.Session{}, map) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session, params) do
    request(:get, "/events/count.json", params, session)
    |> decode(decoder("count"))
  end

  @spec count(%ExShopify.Session{}) :: ExShopify.Resource.count | ExShopify.Resource.error
  def count(session) do
    count(session, %{})
  end

  @doc """
  Receive a single event.

  ## Examples

      iex> ExShopify.Event.find(session, 677313116)
      {:ok, event, meta}
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: event_singular | ExShopify.Resource.error
  def find(session, id, params) do
    request(:get, "/events/#{id}.json", params, session)
    |> decode(decoder(@singular, response_mapping))
  end

  @spec find(%ExShopify.Session{}, integer | String.t) :: event_singular | ExShopify.Resource.error
  def find(session, id) do
    find(session, id, %{})
  end

  @doc """
  Receive a list of all events.

  ## Examples

  ### List all events

      iex> ExShopify.Event.list(session)
      {:ok, events, meta}

  ### Only get events related to Products or Orders

    iex> ExShopify.Event.list(session, %{filter: "Product,Order"})
    {:ok, events, meta}

  ### Only get events related to Products that were deleted

      iex> ExShopify.Event.list(session, %{filter: "Product", verb: "destroy"})
      {:ok, events, meta}

  ### The created_at_min and created_at_max parameters are interpreted using the shop's timezone

      iex> ExShopify.Event.list(session, %{created_at_min: "2008-01-10 08:00:00"})
      {:ok, events, meta}

  ### Get all the events after the specified ID

      iex> ExShopify.Event.list(session, %{since_id: 164748010})
      {:ok, events, meta}
  """
  @spec list(%ExShopify.Session{}, map) :: event_plural | ExShopify.Resource.error
  def list(session, params) do
    request(:get, "/events.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list(%ExShopify.Session{}) :: event_plural | ExShopify.Resource.error
  def list(session) do
    list(session, %{})
  end

  @doc """
  Get all the events from a particular order.

  ## Examples

      iex> ExShopify.Event.list_from_order(session, 164748010)
      {:ok, events, meta}
  """
  @spec list_from_order(%ExShopify.Session{}, integer | String.t, map) :: event_plural | ExShopify.Resource.error
  def list_from_order(session, order_id, params) do
    request(:get, "/orders/#{order_id}/events.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list_from_order(%ExShopify.Session{}, integer | String.t) :: event_plural | ExShopify.Resource.error
  def list_from_order(session, order_id) do
    list_from_order(session, order_id, %{})
  end

  @doc """
  Get all the events from a particular product.

  ## Examples

      iex> ExShopify.Event.list_from_product(session, 164748010)
      {:ok, events, meta}
  """
  @spec list_from_product(%ExShopify.Session{}, integer | String.t, map) :: event_plural | ExShopify.Resource.error
  def list_from_product(session, product_id, params) do
    request(:get, "/products/#{product_id}/events.json", params, session)
    |> decode(decoder(@plural, [response_mapping]))
  end

  @spec list_from_product(%ExShopify.Session{}, integer | String.t) :: event_plural | ExShopify.Resource.error
  def list_from_product(session, product_id) do
    list_from_product(session, product_id, %{})
  end

  @doc false
  def response_mapping do
    %__MODULE__{}
  end
end
