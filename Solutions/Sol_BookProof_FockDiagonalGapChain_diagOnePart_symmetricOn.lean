-- Generated from ChapterFockDiagonalGapChain.lean — solution of BookProof.FockDiagonalGapChain.diagOnePart_symmetricOn
import Mathlib
import Definitions.Def_ChapterFockDiagonalGapChain
import Theorems.Thm_BookProof_FockDiagonalGapChain_diagOnePart_inner
open BookProof.FockDiagonalGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore BookProof.ScalaronFockGapChain
open Module


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) :
    SymmetricOn (finiteModeDomain b)
      ((finiteModeDomain b).subtype.comp (diagOnePart b w)) := by

  classical
  intro x y
  have hDx : ((finiteModeDomain b).subtype.comp (diagOnePart b w)) x
      = ((diagOnePart b w x : finiteModeDomain b) : F) := rfl
  have hDy : ((finiteModeDomain b).subtype.comp (diagOnePart b w)) y
      = ((diagOnePart b w y : finiteModeDomain b) : F) := rfl
  have hswap : (inner ℂ ((diagOnePart b w x : finiteModeDomain b) : F) (y : F) : ℂ)
      = (starRingEnd ℂ)
          (inner ℂ (y : F) ((diagOnePart b w x : finiteModeDomain b) : F) : ℂ) :=
    (inner_conj_symm (𝕜 := ℂ) ((diagOnePart b w x : finiteModeDomain b) : F) (y : F)).symm
  rw [hDx, hDy, hswap, diagOnePart_inner b w y x, diagOnePart_inner b w x y, map_sum]
  set lx := (modeBasis b).repr x with hlx
  set ly := (modeBasis b).repr y with hly
  have key : ∀ i : ℕ,
      (starRingEnd ℂ) (((w i : ℝ) : ℂ) * (starRingEnd ℂ) (ly i) * lx i)
        = ((w i : ℝ) : ℂ) * (starRingEnd ℂ) (lx i) * ly i := by
    intro i
    simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal]
    ring
  calc ∑ i ∈ lx.support, (starRingEnd ℂ) (((w i : ℝ) : ℂ) * (starRingEnd ℂ) (ly i) * lx i)
      = ∑ i ∈ lx.support ∪ ly.support,
          (starRingEnd ℂ) (((w i : ℝ) : ℂ) * (starRingEnd ℂ) (ly i) * lx i) := by
        refine Finset.sum_subset
          (Finset.subset_union_left (s₁ := lx.support) (s₂ := ly.support)) ?_
        intro i _ hi
        simp [Finsupp.notMem_support_iff.mp hi]
    _ = ∑ i ∈ lx.support ∪ ly.support,
          ((w i : ℝ) : ℂ) * (starRingEnd ℂ) (lx i) * ly i :=
        Finset.sum_congr rfl fun i _ => key i
    _ = ∑ i ∈ ly.support, ((w i : ℝ) : ℂ) * (starRingEnd ℂ) (lx i) * ly i := by
        refine (Finset.sum_subset
          (Finset.subset_union_right (s₁ := lx.support) (s₂ := ly.support)) ?_).symm
        intro i _ hi
        simp [Finsupp.notMem_support_iff.mp hi]
