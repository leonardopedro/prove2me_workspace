-- Generated from ChapterFockNumberPreservingGap.lean — theorem BookProof.FockNumberPreservingGap.creVec_eq_sum_of_subset
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockNumberPreservingGap


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

theorem BookProof.FockNumberPreservingGap.creVec_eq_sum_of_subset (v : ℕ →₀ ℂ) (x : FockAlg) {s : Finset ℕ}
    (h : v.support ⊆ s) : creVec v x = ∑ j ∈ s, v j • creA j x := by sorry
