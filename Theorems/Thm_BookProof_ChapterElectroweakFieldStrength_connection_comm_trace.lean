-- Generated from ChapterElectroweakFieldStrength.lean — theorem BookProof.ChapterElectroweakFieldStrength.connection_comm_trace
import Definitions.Def_ChapterParity
import Mathlib
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterParitySU2
open BookProof.ChapterParitySU2
open BookProof.ChapterElectroweakFieldStrength


open Matrix


open BookProof.ChapterParity BookProof.ChapterParitySU2

theorem BookProof.ChapterElectroweakFieldStrength.connection_comm_trace (Wμ Wν : Fin 3 → ℂ) (j : Fin 3) :
    ((connection Wμ * connection Wν - connection Wν * connection Wμ) * pauliV j).trace
      = Complex.I * ∑ k, ∑ l, eps k l j * Wμ k * Wν l := by sorry
