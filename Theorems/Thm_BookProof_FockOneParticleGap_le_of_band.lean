-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.le_of_band
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.le_of_band {lo hi : ℕ → ℝ} {lam mu : ℝ} (hmem : ∀ m, lam ∈ Set.Icc (lo m) (hi m))
    {m : ℕ} (hlo : mu ≤ lo m) : mu ≤ lam := by sorry
