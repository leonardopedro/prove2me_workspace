-- Generated from ChapterNavierStokesHashimoto.lean — solution of BookProof.NavierStokesFlow.NSHashimoto.ns_selfAdjoint_extension
import Mathlib
import Definitions.Def_ChapterNavierStokesHashimoto
import Theorems.Thm_BookProof_NavierStokesFlow_NSHashimoto_velCore_symmetricOn
import Theorems.Thm_BookProof_NavierStokesFlow_NSHashimoto_velCore_esa
import Theorems.Thm_BookProof_NavierStokesFlow_NSHashimoto_velCore_dense
import Theorems.Thm_BookProof_EsaClosure_exists_isSelfAdjointExtension_of_esa
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
theorem solution :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (G : Dom →ₗ[ℂ] L2I Vel),
      IsSelfAdjointExtension (velCore A c) G :=
  exists_isSelfAdjointExtension_of_esa (velCore A c) velCore_dense
      (velCore_symmetricOn A c) (velCore_esa A c)
