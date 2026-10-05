-- Generated from ChapterFockFieldPerturbation.lean — theorem BookProof.FockFieldPerturbation.sum_sq_annA_le
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockInteractionStability
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockFieldPerturbation


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

theorem BookProof.FockFieldPerturbation.sum_sq_annA_le (u : FockAlg) (S : Finset ℕ) :
    ∑ k ∈ S, ‖toLp (annA k u)‖ ^ 2 ≤ numberQuad u := by sorry
