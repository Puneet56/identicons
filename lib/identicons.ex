defmodule Identicons do
  def main(input) do
    input
    |> hash_input()
    |> pick_color()
    |> build_grid()
    |> build_pixel_map()
    |> draw_image()
    |> save_image(input)
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicons.Image{hex: hex}
  end

  def pick_color(%Identicons.Image{hex: [r, g, b | _tail]} = image) do
    %Identicons.Image{image | color: {r, g, b}}
  end

  def mirror_row([a, b | _tail] = row) do
    row ++ [b, a]
  end

  def filter_out_odd({code, _}) do
    rem(code, 2) == 0
  end

  def build_grid(%Identicons.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()
      |> Enum.filter(&filter_out_odd/1)

    %Identicons.Image{image | grid: grid}
  end

  def build_pixel_map(%Identicons.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_, index} ->
        x = rem(index, 5) * 50
        y = div(index, 5) * 50

        top_left = {x, y}
        bottom_right = {x + 50, y + 50}

        {top_left, bottom_right}
      end)

    %Identicons.Image{image | pixel_map: pixel_map}
  end

  def draw_image(%Identicons.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
  end

  def save_image(image, file) do
    :egd.save(image, "#{file}.png")
  end
end
