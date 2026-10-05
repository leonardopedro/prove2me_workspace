-- Generated from ChapterWallDeficiencyObstruction.lean — solution of BookProof.WallDeficiencyObstruction.not_deficiencyTrivialAt_of_l2_solution
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
import Theorems.Thm_BookProof_WallDeficiencyObstruction_inner_eq_of_ode
open BookProof.WallDeficiencyObstruction




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ) {W : ℝ → ℂ}
    (hsol : IsL2Ode V z W) (hne : ∃ x, W x ≠ 0) :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z := by

  obtain ⟨W', hW, hW'', hmem⟩ := hsol
  intro hdef
  have hzero : hmem.toLp W = 0 := hdef _ (inner_eq_of_ode V hV z hW hW'' hmem)
  have hae : W =ᵐ[volume] 0 := by
    have h1 : (hmem.toLp W : ℝ → ℂ) =ᵐ[volume] W := hmem.coeFn_toLp
    have h2 : (hmem.toLp W : ℝ → ℂ) =ᵐ[volume] 0 := by
      rw [hzero]; exact Lp.coeFn_zero ℂ 2 (volume : Measure ℝ)
    exact h1.symm.trans h2
  have hWcont : Continuous W := continuous_iff_continuousAt.2 fun x => (hW x).continuousAt
  have : W = 0 := (hWcont.ae_eq_iff_eq volume continuous_const).mp hae
  obtain ⟨x, hx⟩ := hne
  exact hx (by rw [this]; rfl)
