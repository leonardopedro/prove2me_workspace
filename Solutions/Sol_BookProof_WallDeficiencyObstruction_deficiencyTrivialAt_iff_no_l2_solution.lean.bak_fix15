-- Generated from ChapterWallDeficiencyObstruction.lean — solution of BookProof.WallDeficiencyObstruction.deficiencyTrivialAt_iff_no_l2_solution
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
import Theorems.Thm_BookProof_WallDeficiencyObstruction_not_deficiencyTrivialAt_of_l2_solution
import Theorems.Thm_BookProof_ScalaronWallEsa_wallHam_weak_eq
open BookProof.WallDeficiencyObstruction




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ) :
    DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z
      ↔ ∀ W : ℝ → ℂ, IsL2Ode V z W → ∀ x, W x = 0 := by

  constructor
  · intro hdef W hsol x
    by_contra hx
    exact not_deficiencyTrivialAt_of_l2_solution V hV z hsol ⟨x, hx⟩ hdef
  · intro hno u hu
    have hloc : LocallyIntegrable (fun x => (u x : ℂ)) (volume : Measure ℝ) :=
      (Lp.memLp u).locallyIntegrable (by norm_num)
    have hc : Continuous fun x : ℝ => ((V x : ℝ) : ℂ) - z :=
      (Complex.continuous_ofReal.comp hV.continuous).sub continuous_const
    obtain ⟨W, W', hW, hW', hWae⟩ :=
      exists_deriv2_of_weak_eq hloc hc (fun g hg => wallHam_weak_eq V hV z u hu hg)
    have hmem : MemLp W 2 (volume : Measure ℝ) := (Lp.memLp u).ae_eq hWae
    have hzero := hno W ⟨W', hW, hW', hmem⟩
    refine Lp.eq_zero_iff_ae_eq_zero.mpr ?_
    filter_upwards [hWae] with x hx
    simp [hx, hzero x]
