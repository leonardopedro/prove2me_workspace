-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.nsDiffH_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_intertwined_canH
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_canH_not_bounded
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_embedCore_coe
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
rIsometryEquiv velUnitary velUnitary_mem_core hint ?_
  exact (essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn _ _).1
    (canH_essentiallySelfAdjointOn_core A (fun j => c j / Real.sqrt 2))

/-- **The differentially written operator is unbounded**: essential self-adjointness above
is not a boundedness phenomenon. :=
   -/
  theorem nsDiffH_not_bounded (hA : A 0 0 ≠ 0) (K : ℝ) :
      ∃ f : polyGaussCore (d := 3), ‖(f : L2d 3)‖ = 1
        ∧ K < ‖((nsDiffH A c f : polyGaussCore (d := 3)) : L2d 3)‖ := by
    have hc : (fun j => Real.sqrt 2 * (c j / Real.sqrt 2)) = c := by
      funext j
      field_simp
    obtain ⟨x, hx1, hx2⟩ := canH_not_bounded A (fun j => c j / Real.sqrt 2) hA K
    refine ⟨embedCore x, ?_, ?_⟩
