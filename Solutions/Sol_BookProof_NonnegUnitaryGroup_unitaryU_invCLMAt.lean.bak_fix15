-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.unitaryU_invCLMAt
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_commute_yosidaCLM_invCLMAt
open BookProof.NonnegUnitaryGroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (ha : 0 < a) (t : ℝ) (y : F) :
    unitaryU hT hsv t (invCLMAt hT ha y) = invCLMAt hT ha (unitaryU hT hsv t y) := by

  have hcomm : ∀ n : ℕ,
      approxU hT n t (invCLMAt hT ha y) = invCLMAt hT ha (approxU hT n t y) := by
    intro n
    have hc : Commute (yosidaAt hT n) (invCLMAt hT ha) := commute_yosidaCLM_invCLMAt hT _ ha
    have hexp : Commute (approxU hT n t) (invCLMAt hT ha) :=
      ((hc.smul_left (-Complex.I)).smul_left t).exp_left
    have h := congrArg (fun S : F →L[ℂ] F => S y) hexp.eq
    simpa using h
  refine tendsto_nhds_unique (tendsto_unitaryU hT hsv t (invCLMAt hT ha y)) ?_
  have h2 : Tendsto (fun n : ℕ => invCLMAt hT ha (approxU hT n t y)) atTop
      (𝓝 (invCLMAt hT ha (unitaryU hT hsv t y))) :=
    ((invCLMAt hT ha).continuous.tendsto _).comp (tendsto_unitaryU hT hsv t y)
  have heq : (fun n : ℕ => approxU hT n t (invCLMAt hT ha y))
      = fun n : ℕ => invCLMAt hT ha (approxU hT n t y) := funext hcomm
  rw [heq]
  exact h2
