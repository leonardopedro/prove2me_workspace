-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.diffMaxN_core_approx
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxEquiv_coe
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_diffMaxN_apply
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
theorem solution (mu : ℝ) (z : diffMaxDom mu) (ε : ℝ) (hε : 0 < ε) :
    ∃ y : diffMaxDom mu, (y : L2d 3) ∈ (polyGaussCore (d := 3)) ∧
      ‖(y : L2d 3) - (z : L2d 3)‖ < ε ∧ ‖diffMaxN mu y - diffMaxN mu z‖ < ε := by

  obtain ⟨z', rfl⟩ := (diffMaxEquiv mu).surjective z
  obtain ⟨y', hy1, hy2, hy3⟩ := exists_finiteModes_graph_approx (velSym mu) z' ε hε
  refine ⟨diffMaxEquiv mu y', ?_, ?_, ?_⟩
  · rw [diffMaxEquiv_coe]
    exact velUnitary_mem_core ⟨(y' : L2I Vel), hy1⟩
  · rw [diffMaxEquiv_coe, diffMaxEquiv_coe, ← map_sub, velUnitary.norm_map]
    exact hy2
  · rw [diffMaxN_apply, diffMaxN_apply, ← map_sub, velUnitary.norm_map]
    exact hy3
