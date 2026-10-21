-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.commute_yosidaAt_invCLMAt
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
import Theorems.Thm_BookProof_NonnegResolvent_invCLMAt_comm
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (n : ℕ) {b : ℝ} (hb : 0 < b) :
    Commute (yosidaAt hT n) (invCLMAt hT hb) := by

  have ha : (0 : ℝ) < (n : ℝ) + 1 := by positivity
  have hcomm : Commute (invCLMAt hT ha) (invCLMAt hT hb) := by
    change invCLMAt hT ha * invCLMAt hT hb = invCLMAt hT hb * invCLMAt hT ha
    ext y
    simpa [ContinuousLinearMap.mul_apply] using invCLMAt_comm hT ha hb y
  have hfin := ((Commute.one_left (invCLMAt hT hb)).sub_left
    (hcomm.smul_left ((((n : ℝ) + 1 : ℝ) : ℂ)))).smul_left ((((n : ℝ) + 1 : ℝ) : ℂ))
  simpa [yosidaAt, yosidaCLM] using hfin
