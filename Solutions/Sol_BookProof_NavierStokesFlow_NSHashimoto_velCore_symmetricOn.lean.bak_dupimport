-- Generated from ChapterNavierStokesHashimoto.lean — solution of BookProof.NavierStokesFlow.NSHashimoto.velCore_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesHashimoto
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.NSHashimoto



open Filter Topology



open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn (lpFiniteModes Vel) (velCore A c) :=
  fun x y =>
    velH_symmetricOn A c (Submodule.inclusion (finiteModes_le_maxDom (velSym (velMu A c))) x)
      (Submodule.inclusion (finiteModes_le_maxDom (velSym (velMu A c))) y)
