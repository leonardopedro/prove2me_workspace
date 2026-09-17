-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.nsDiffH_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_embedCore_coe
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_intertwined_canH
open BookProof.NavierStokesFlow.DifferentialL2




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (hA : A 0 0 ≠ 0) (K : ℝ) :
    ∃ f : polyGaussCore (d := 3), ‖(f : L2d 3)‖ = 1
      ∧ K < ‖((nsDiffH A c f : polyGaussCore (d := 3)) : L2d 3)‖ := by

  have hc : (fun j => Real.sqrt 2 * (c j / Real.sqrt 2)) = c := by
    funext j
    field_simp
  obtain ⟨x, hx1, hx2⟩ := canH_not_bounded A (fun j => c j / Real.sqrt 2) hA K
  refine ⟨embedCore x, ?_, ?_⟩
  · rw [embedCore_coe, velUnitary.norm_map, hx1]
  · have h := intertwined_canH A (fun j => c j / Real.sqrt 2) x
    rw [hc] at h
    rw [h, embedCore_coe, velUnitary.norm_map]
    exact hx2
