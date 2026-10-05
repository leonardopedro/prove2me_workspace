-- Generated from ChapterFockInteractionStability.lean — theorem BookProof.FockInteractionStability.gap_persists_of_relative_form_bound
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterFockInteractionStability
open BookProof.FockInteractionStability

variable {E : Type*} [NormedAddCommGroup E]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap
open BookProof.FarisLavine BookProof.NavierStokesFlow




theorem BookProof.FockInteractionStability.gap_persists_of_relative_form_bound
    {q v : E → ℝ} {S : Set E} {mu a b : ℝ} (ha : a ≤ 1)
    (hq : ∀ x ∈ S, mu * ‖x‖ ^ 2 ≤ q x)
    (hv : ∀ x, |v x| ≤ a * q x + b * ‖x‖ ^ 2) :
    ∀ x ∈ S, ((1 - a) * mu - b) * ‖x‖ ^ 2 ≤ q x + v x := by sorry
