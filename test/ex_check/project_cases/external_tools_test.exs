defmodule ExCheck.ProjectCases.ExternalToolsTest do
  use ExCheck.ProjectCase, async: true

  test "external tools (except dialyzer)", %{project_dir: project_dir} do
    set_mix_deps(project_dir, [:ex_check, :credo, :ex_doc, :sobelow])

    assert {output, 0} = System.cmd("mix", ~w[check], cd: project_dir, env: %{"MIX_ENV" => "dev"})

    assert output =~ "compiler success"
    assert output =~ "formatter success"
    assert output =~ "ex_unit success"
    assert output =~ "credo success"
    assert output =~ "sobelow success"
    assert output =~ "dialyzer skipped due to missing package dialyxir"
    assert output =~ "ex_doc success"
  end
end
