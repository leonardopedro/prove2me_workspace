-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.nsDiffN_quadForm_ge_norm_sq
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_embedCore_surjective
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_quadForm_nsDiffN_embedCore
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_embedCore_coe
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_quadForm_ge_norm_sq
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
theorem solution (mu : ℝ) (hmu : 0 ≤ mu) (f : polyGaussCore (d := 3)) :
    ‖(f : L2d 3)‖ ^ 2
      ≤ quadForm ((polyGaussCore (d := 3)).subtype.comp (nsDiffN mu)) f := by

  obtain ⟨x, rfl⟩ := embedCore_surjective f
  rw [quadForm_nsDiffN_embedCore, embedCore_coe, velUnitary.norm_map]
  exact diagMax_quadForm_ge_norm_sq (velSym mu) (fun β => velSym_ge_one hmu β)
    (Submodule.inclusion (finiteModes_le_maxDom (velSym mu)) x)
