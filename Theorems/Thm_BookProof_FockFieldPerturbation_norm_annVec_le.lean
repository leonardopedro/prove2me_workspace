-- Generated from ChapterFockFieldPerturbation.lean — theorem BookProof.FockFieldPerturbation.norm_annVec_le
import Definitions.Def_ChapterFockOneParticleGap
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterA4
open BookProof.FockSecondQuantization
open BookProof.FockFieldPerturbation


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap

theorem BookProof.FockFieldPerturbation.norm_annVec_le (f : ℕ →₀ ℂ) (u : FockAlg) :
    ‖toLp (annVec f u)‖ ≤ l2norm f * Real.sqrt (numberQuad u) := by sorry
