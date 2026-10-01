-- Generated from ChapterFockOneParticleGap.lean — theorem BookProof.FockOneParticleGap.le_eigenvalue_of_le_spectrum
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

theorem BookProof.FockOneParticleGap.le_eigenvalue_of_le_spectrum {A : F →L[ℂ] F} (hA : IsSelfAdjoint A)
    {b : HilbertBasis ℕ ℂ F} {e : ℕ → ℝ}
    (heig : ∀ k, A (b k) = ((e k : ℝ) : ℂ) • b k) {mu : ℝ}
    (hspec : ∀ lam ∈ spectrum ℝ A, mu ≤ lam) : ∀ k, mu ≤ e k := by sorry
