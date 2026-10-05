-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.exists_repr_of_mem_span_image
import Mathlib
import Definitions.Def_ChapterSchurGershgorinGap
open BookProof.SchurGershgorin



noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (T : Set ℕ) {v : F}
    (hv : v ∈ Submodule.span ℂ (b '' T)) :
    ∃ (S : Finset ℕ) (c : ℕ → ℂ), (↑S : Set ℕ) ⊆ T ∧ v = ∑ i ∈ S, c i • b i := by

  rw [Finsupp.mem_span_image_iff_linearCombination] at hv
  obtain ⟨l, hl, rfl⟩ := hv
  refine ⟨l.support, fun i => l i, (Finsupp.mem_supported ℂ l).mp hl, ?_⟩
  simp [Finsupp.linearCombination_apply, Finsupp.sum]
