-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.nsDiffH_relative_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_embedCore_surjective
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_nsDiffH_embedCore
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_nsDiffN_embedCore
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_canH_coe_velH
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine














open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

















variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
theorem solution :
    ∃ a b : ℝ, 0 ≤ a ∧ 0 ≤ b ∧ ∀ f : polyGaussCore (d := 3),
      ‖((nsDiffH A c f : polyGaussCore (d := 3)) : L2d 3)‖ ^ 2
        ≤ a * ‖((nsDiffN (diffMu A c) f : polyGaussCore (d := 3)) : L2d 3)‖ ^ 2
          + b * ‖(f : L2d 3)‖ ^ 2 := by

  obtain ⟨a, b, ha, hb, hbound⟩ :=
    SignedShift.listH_relative_bound (hopList A (seqConst c))
  refine ⟨a, b, ha, hb, fun f => ?_⟩
  obtain ⟨x, rfl⟩ := embedCore_surjective f
  have hx := hbound (Submodule.inclusion (finiteModes_le_maxDom (velSym (diffMu A c))) x)
  rw [nsDiffH_embedCore, nsDiffN_embedCore, canH_coe_velH, embedCore_coe,
    velUnitary.norm_map, velUnitary.norm_map, velUnitary.norm_map]
  exact hx
