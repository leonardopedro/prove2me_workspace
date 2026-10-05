-- Generated from ChapterFockNumberPreservingGap.lean — theorem BookProof.FockNumberPreservingGap.shiftCol_apply
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

theorem BookProof.FockNumberPreservingGap.shiftCol_apply (col : ℕ → (ℕ →₀ ℂ)) (mu : ℝ) (k : ℕ) :
    shiftCol col mu k = col k - ((mu : ℝ) : ℂ) • numberCol k := by sorry
