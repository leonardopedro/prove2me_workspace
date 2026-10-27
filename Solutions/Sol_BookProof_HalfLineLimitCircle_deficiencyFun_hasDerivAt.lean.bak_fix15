-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.deficiencyFun_hasDerivAt
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) :
    HasDerivAt deficiencyFun (-lam * deficiencyFun x) x := by

  have h1 : HasDerivAt (fun y : ℝ => (y : ℂ)) 1 x := Complex.ofRealCLM.hasDerivAt
  have h2 : HasDerivAt (fun y : ℝ => -(lam * (y : ℂ))) (-lam) x := by
    have h3 := (h1.const_mul lam).neg
    rw [mul_one] at h3
    exact h3
  have h6 := h2.cexp
  rw [mul_neg, mul_comm (Complex.exp (-(lam * (x : ℂ)))) lam] at h6
  rw [show deficiencyFun = fun y : ℝ => Complex.exp (-(lam * (y : ℂ))) from rfl, neg_mul]
  exact h6
