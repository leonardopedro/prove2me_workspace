-- Generated from ChapterFockCubicQuarticStability.lean — solution of BookProof.FockCubicQuarticStability.quart_form_nonneg
import Mathlib
import Definitions.Def_ChapterFockCubicQuarticStability
import Theorems.Thm_BookProof_FockCubicQuarticStability_quart_form_eq
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockCubicUnbounded
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockCubicQuarticStability



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicUnbounded
open BookProof.FockSecondQuantization

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (u : FockAlg) :
    0 ≤ (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re := by

  rw [quart_form_eq]; positivity
