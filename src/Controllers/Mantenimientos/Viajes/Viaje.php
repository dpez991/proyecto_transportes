<?php

namespace Controllers\Mantenimientos\Viajes;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\ViajeDAO;
use Dao\RutaDAO;
use Dao\BusDAO;
use Utilities\Site;

class Viaje extends PrivateController
{
    private $mode = "DSP";
    private $viajeId = 0;
    private $rutaId = 0;
    private $busId = 0;
    private $fecha = "";
    private $hora = "";
    private $asientosDisponibles = 45;
    private $estado = "ACT";
    private $error = "";

    private array $viewData = [];

    public function run(): void
    {
        $this->mode = $_GET["mode"] ?? "DSP";
        $this->viajeId = intval($_GET["id"] ?? 0);

        if ($this->isPostBack()) {
            $this->mode = $_POST["mode"] ?? "DSP";
            $this->viajeId = intval($_POST["viajeId"] ?? 0);
            $this->rutaId = intval($_POST["rutaId"] ?? 0);
            $this->busId = intval($_POST["busId"] ?? 0);
            $this->fecha = $_POST["fecha"] ?? "";
            $this->hora = $_POST["hora"] ?? "";
            $this->estado = $_POST["estado"] ?? "ACT";

            $capacidadBus = 45;
            if ($this->busId > 0) {
                $bus = BusDAO::getById($this->busId);
                if ($bus) {
                    $capacidadBus = intval($bus["capacidad"]);
                }
            }

            if ($this->mode === "INS") {
                if ($this->rutaId <= 0 || $this->fecha === "" || $this->hora === "") {
                    $this->error = "Ruta, fecha y hora son obligatorios.";
                } else {
                    ViajeDAO::insert(
                        $this->rutaId,
                        $this->busId > 0 ? $this->busId : null,
                        $this->fecha,
                        $this->hora,
                        $capacidadBus,
                        $this->estado
                    );
                    Site::redirectTo("index.php?page=Mantenimientos_Viajes_Listado");
                }
            } elseif ($this->mode === "UPD") {
                $this->asientosDisponibles = intval($_POST["asientosDisponibles"] ?? $capacidadBus);

                if ($this->rutaId <= 0 || $this->fecha === "" || $this->hora === "") {
                    $this->error = "Ruta, fecha y hora son obligatorios.";
                } else {
                    ViajeDAO::update(
                        $this->viajeId,
                        $this->rutaId,
                        $this->busId > 0 ? $this->busId : null,
                        $this->fecha,
                        $this->hora,
                        $this->asientosDisponibles,
                        $this->estado
                    );
                    Site::redirectTo("index.php?page=Mantenimientos_Viajes_Listado");
                }
            } elseif ($this->mode === "DEL") {
                ViajeDAO::inactivate($this->viajeId);
                Site::redirectToWithMsg("index.php?page=Mantenimientos_Viajes_Listado", "Viaje inactivado correctamente");
            }
        } else {
            if (in_array($this->mode, ["UPD", "DEL", "DSP"])) {
                $viaje = ViajeDAO::getById($this->viajeId);
                if ($viaje) {
                    $this->viajeId = $viaje["viajeId"];
                    $this->rutaId = $viaje["rutaId"];
                    $this->busId = intval($viaje["busId"] ?? 0);
                    $this->fecha = $viaje["fecha"];
                    $this->hora = $viaje["hora"];
                    $this->asientosDisponibles = $viaje["asientosDisponibles"];
                    $this->estado = $viaje["estado"];
                } else {
                    Site::redirectToWithMsg("index.php?page=Mantenimientos_Viajes_Listado", "No se encontró el viaje");
                }
            }
        }

        $this->prepareViewData();
        Renderer::render("mantenimientos/viajes/viaje", $this->viewData);
    }

    private function prepareViewData()
    {
        $rutas = RutaDAO::getActivas();
        $buses = BusDAO::getAll();

        foreach ($rutas as $index => $ruta) {
            $rutas[$index]["selected"] = ($ruta["rutaId"] == $this->rutaId);
        }

        foreach ($buses as $index => $bus) {
            $buses[$index]["selected"] = ($bus["busId"] == $this->busId);
        }

        $this->viewData = [
            "mode" => $this->mode,
            "viajeId" => $this->viajeId,
            "rutaId" => $this->rutaId,
            "busId" => $this->busId,
            "fecha" => $this->fecha,
            "hora" => $this->hora,
            "asientosDisponibles" => $this->asientosDisponibles,
            "estado" => $this->estado,
            "error" => $this->error,
            "rutas" => $rutas,
            "buses" => $buses,
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
        if ($this->mode === "INS") return "Nuevo Viaje";
        if ($this->mode === "UPD") return "Editar Viaje";
        if ($this->mode === "DEL") return "Inactivar Viaje";
        return "Detalle de Viaje";
    }
}