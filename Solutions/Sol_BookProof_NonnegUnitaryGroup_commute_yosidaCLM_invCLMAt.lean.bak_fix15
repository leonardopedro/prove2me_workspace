-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.commute_yosidaCLM_invCLMAt
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
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
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (hb : 0 < b) :
    Commute (yosidaCLM hT ha) (invCLMAt hT hb) := by

  have hc := commute_invCLMAt hT ha hb
  have h1 : Commute ((a : ℂ) • invCLMAt hT ha) (invCLMAt hT hb) := hc.smul_left (a : ℂ)
  have h2 : Commute (1 - (a : ℂ) • invCLMAt hT ha) (invCLMAt hT hb) :=
    (Commute.one_left _).sub_left h1
  simpa only [yosidaCLM] using h2.smul_left (a : ℂ)
