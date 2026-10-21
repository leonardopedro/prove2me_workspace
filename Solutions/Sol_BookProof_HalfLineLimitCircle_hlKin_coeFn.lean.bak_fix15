-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.hlKin_coeFn
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Theorems.Thm_BookProof_HalfLineLimitCircle_hlKin_apply
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution (f : testSpace) :
    ((hlKin (hlEquiv f) : HL) : ℝ → ℂ) =ᵐ[hlMeasure] fun x => -deriv (deriv (f : ℝ → ℂ)) x := by

  rw [hlKin_apply]
  filter_upwards [Lp.coeFn_neg (testIncl (deriv2LM f)), testIncl_coeFn (deriv2LM f)]
    with x h1 h2
  rw [h1, Pi.neg_apply, h2]
  rfl
