<?php

namespace Controllers\Mantenimientos\Rutas;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\RutaDAO;
use Utilities\Site;

class Ruta extends PrivateController
{
    private $mode = "DSP";
    private $rutaId = 0;
    private $origen = "";
    private $destino = "";
    private $estado = "ACT";
    private $error = "";

    private array $viewData = [];

    public function run(): void
    {
        $this->mode = $_GET["mode"] ?? "DSP";
        $this->rutaId = intval($_GET["id"] ?? 0);

        if ($this->isPostBack()) {
            $this->mode = $_POST["mode"] ?? "DSP";
            $this->rutaId = intval($_POST["rutaId"] ?? 0);
            $this->origen = $_POST["origen"] ?? "";
            $this->destino = $_POST["destino"] ?? "";
            $this->estado = $_POST["estado"] ?? "ACT";

            if ($this->mode === "INS") {
                if ($this->origen === "" || $this->destino === "") {
                    $this->error = "Origen y destino son obligatorios.";
                } else {
                    RutaDAO::insert($this->origen, $this->destino, $this->estado);
                    Site::redirectTo("index.php?page=Mantenimientos_Rutas_Listado");
                }
            } elseif ($this->mode === "UPD") {
                if ($this->origen === "" || $this->destino === "") {
                    $this->error = "Origen y destino son obligatorios.";
                } else {
                    RutaDAO::update($this->rutaId, $this->origen, $this->destino, $this->estado);
                    Site::redirectTo("index.php?page=Mantenimientos_Rutas_Listado");
                }
            } elseif ($this->mode === "DEL") {
                RutaDAO::inactivate($this->rutaId);
                Site::redirectToWithMsg("index.php?page=Mantenimientos_Rutas_Listado", "Ruta inactivada correctamente");
            }
        } else {
            if (in_array($this->mode, ["UPD", "DEL", "DSP"])) {
                $ruta = RutaDAO::getById($this->rutaId);
                if ($ruta) {
                    $this->rutaId = $ruta["rutaId"];
                    $this->origen = $ruta["origen"];
                    $this->destino = $ruta["destino"];
                    $this->estado = $ruta["estado"];
                } else {
                    Site::redirectToWithMsg("index.php?page=Mantenimientos_Rutas_Listado", "No se encontró la ruta");
                }
            }
        }

        $this->prepareViewData();
        Renderer::render("mantenimientos/rutas/ruta", $this->viewData);
    }

    private function prepareViewData()
    {
        $this->viewData = [
            "mode" => $this->mode,
            "rutaId" => $this->rutaId,
            "origen" => $this->origen,
            "destino" => $this->destino,
            "estado" => $this->estado,
            "error" => $this->error,
            "isReadonly" => ($this->mode === "DEL" || $this->mode === "DSP"),
            "isINS" => ($this->mode === "INS"),
            "isUPD" => ($this->mode === "UPD"),
            "isDEL" => ($this->mode === "DEL"),
            "isDSP" => ($this->mode === "DSP"),
            "isAct" => ($this->estado === "ACT"),
            "isIna" => ($this->estado === "INA"),
            "title" => $this->getTitle()
        ];
    }

    private function getTitle()
    {
        if ($this->mode === "INS") return "Nueva Ruta";
        if ($this->mode === "UPD") return "Editar Ruta";
        if ($this->mode === "DEL") return "Inactivar Ruta";
        return "Detalle de Ruta";
    }
}