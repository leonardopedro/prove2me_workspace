-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.le_of_band
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {lo hi : ℕ → ℝ} {lam mu : ℝ} (hmem : ∀ m, lam ∈ Set.Icc (lo m) (hi m))
    {m : ℕ} (hlo : mu ≤ lo m) : mu ≤ lam := le_trans hlo (hmem m).1
