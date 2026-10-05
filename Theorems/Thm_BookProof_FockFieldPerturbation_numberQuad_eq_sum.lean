-- Generated from ChapterFockFieldPerturbation.lean — theorem BookProof.FockFieldPerturbation.numberQuad_eq_sum
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockInteractionStability
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.FockFieldPerturbation


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

theorem BookProof.FockFieldPerturbation.numberQuad_eq_sum {u : FockAlg} {K : Finset ℕ} (hK : modes u ⊆ K) :
    numberQuad u = ∑ k ∈ K, ‖toLp (annA k u)‖ ^ 2 := by sorry
