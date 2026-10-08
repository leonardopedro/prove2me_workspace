-- Generated from ChapterFockInteractionStability.lean — theorem BookProof.FockInteractionStability.interaction_form_bound
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterFockInteractionStability
open BookProof.FockInteractionStability


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap
open BookProof.FarisLavine BookProof.NavierStokesFlow



variable {E : Type*} [NormedAddCommGroup E]


theorem BookProof.FockInteractionStability.interaction_form_bound [InnerProductSpace ℂ E] (V : E →L[ℂ] E) (x : E) :
    |(inner ℂ x (V x) : ℂ).re| ≤ ‖V‖ * ‖x‖ ^ 2 := by sorry
