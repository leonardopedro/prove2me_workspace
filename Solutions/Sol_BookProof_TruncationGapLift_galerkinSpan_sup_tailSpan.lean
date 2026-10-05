-- Generated from ChapterTruncationGapLift.lean — solution of BookProof.TruncationGapLift.galerkinSpan_sup_tailSpan
import Mathlib
import Definitions.Def_ChapterTruncationGapLift
open BookProof.TruncationGapLift



noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.BandEnclosure
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (m : ℕ) :
    galerkinSpan b m ⊔ tailSpan b m = finiteModeDomain b := by

  have hset : ({i | i < m} ∪ {i | m ≤ i} : Set ℕ) = Set.univ := by
    ext i
    simp only [Set.mem_union, Set.mem_setOf_eq, Set.mem_univ, iff_true]
    omega
  rw [galerkinSpan, tailSpan, ← Submodule.span_union, ← Set.image_union, hset,
    Set.image_univ, finiteModeDomain]
