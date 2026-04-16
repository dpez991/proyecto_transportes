<?php

namespace Controllers\Mantenimientos\Buses;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\BusDAO;
use Utilities\Site;

class Bus extends PrivateController
{
    private $mode = "DSP";
    private $busId = 0;
    private $numeroBus = "";
    private $placa = "";
    private $capacidad = 45;
    private $busest = "ACT";
    private $error = "";

    private array $viewData = [];

    public function run(): void
    {
        $this->mode = $_GET["mode"] ?? "DSP";
        $this->busId = intval($_GET["id"] ?? 0);

        if ($this->isPostBack()) {
            $this->mode = $_POST["mode"] ?? "DSP";
            $this->busId = intval($_POST["busId"] ?? 0);
            $this->numeroBus = $_POST["numeroBus"] ?? "";
            $this->placa = $_POST["placa"] ?? "";
            $this->capacidad = intval($_POST["capacidad"] ?? 45);
            $this->busest = $_POST["busest"] ?? "ACT";

            if ($this->mode === "INS") {
                if ($this->numeroBus === "" || $this->placa === "") {
                    $this->error = "Número de bus y placa son obligatorios.";
                } else {
                    BusDAO::insert($this->numeroBus, $this->placa, $this->capacidad, $this->busest);
                    Site::redirectTo("index.php?page=Mantenimientos_Buses_Listado");
                }
            } elseif ($this->mode === "UPD") {
                if ($this->numeroBus === "" || $this->placa === "") {
                    $this->error = "Número de bus y placa son obligatorios.";
                } else {
                    BusDAO::update($this->busId, $this->numeroBus, $this->placa, $this->capacidad, $this->busest);
                    Site::redirectTo("index.php?page=Mantenimientos_Buses_Listado");
                }
            } elseif ($this->mode === "DEL") {
                BusDAO::delete($this->busId);
                Site::redirectTo("index.php?page=Mantenimientos_Buses_Listado");
            }
        } else {
            if (in_array($this->mode, ["UPD", "DEL", "DSP"])) {
                $bus = BusDAO::getById($this->busId);
                if ($bus) {
                    $this->busId = $bus["busId"];
                    $this->numeroBus = $bus["numeroBus"];
                    $this->placa = $bus["placa"];
                    $this->capacidad = $bus["capacidad"];
                    $this->busest = $bus["busest"];
                } else {
                    Site::redirectToWithMsg("index.php?page=Mantenimientos_Buses_Listado", "No se encontró el bus");
                }
            }
        }

        $this->prepareViewData();
        Renderer::render("mantenimientos/buses/bus", $this->viewData);
    }

    private function prepareViewData()
    {
        $this->viewData = [
            "mode" => $this->mode,
            "busId" => $this->busId,
            "numeroBus" => $this->numeroBus,
            "placa" => $this->placa,
            "capacidad" => $this->capacidad,
            "busest" => $this->busest,
            "error" => $this->error,
            "isReadonly" => ($this->mode === "DEL" || $this->mode === "DSP"),
            "isINS" => ($this->mode === "INS"),
            "isUPD" => ($this->mode === "UPD"),
            "isDEL" => ($this->mode === "DEL"),
            "isDSP" => ($this->mode === "DSP"),
            "isAct" => ($this->busest === "ACT"),
            "isIna" => ($this->busest === "INA"),
            "title" => $this->getTitle()
        ];
    }

    private function getTitle()
    {
        if ($this->mode === "INS") return "Nuevo Bus";
        if ($this->mode === "UPD") return "Editar Bus";
        if ($this->mode === "DEL") return "Eliminar Bus";
        return "Detalle de Bus";
    }
}