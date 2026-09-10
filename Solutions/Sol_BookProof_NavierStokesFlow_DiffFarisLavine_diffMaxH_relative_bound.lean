-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.diffMaxH_relative_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxEquiv_coe
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxN_apply
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxH_apply
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
    ∃ a b : ℝ, 0 ≤ a ∧ 0 ≤ b ∧ ∀ z : diffMaxDom (velMu A (seqConst c)),
      ‖diffMaxH A c z‖ ^ 2
        ≤ a * ‖diffMaxN (velMu A (seqConst c)) z‖ ^ 2 + b * ‖(z : L2d 3)‖ ^ 2 := by

  obtain ⟨a, b, ha, hb, hbound⟩ :=
    SignedShift.listH_relative_bound (hopList A (seqConst c))
  refine ⟨a, b, ha, hb, fun z => ?_⟩
  obtain ⟨z', rfl⟩ := (diffMaxEquiv (velMu A (seqConst c))).surjective z
  rw [diffMaxH_apply, diffMaxN_apply, diffMaxEquiv_coe, velUnitary.norm_map,
    velUnitary.norm_map, velUnitary.norm_map]
  exact hbound z'
