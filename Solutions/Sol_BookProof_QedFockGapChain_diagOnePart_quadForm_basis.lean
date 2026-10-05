-- Generated from ChapterQedFockGapChain.lean — solution of BookProof.QedFockGapChain.diagOnePart_quadForm_basis
import Mathlib
import Definitions.Def_ChapterQedFockGapChain
import Theorems.Thm_BookProof_FockDiagonalGapChain_inner_self_ofReal
open BookProof.QedFockGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FarisLavine
open BookProof.HermiteGalerkin BookProof.HermiteCore
open BookProof.FockDiagonalGapChain BookProof.YangMillsFriedrichs
open MeasureTheory


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) (k : ℕ) :
    quadForm ((finiteModeDomain b).subtype.comp (diagOnePart b w)) (modeBasis b k) = w k := by

  have hnorm : ‖b k‖ = 1 := b.orthonormal.1 k
  have hq : quadForm ((finiteModeDomain b).subtype.comp (diagOnePart b w)) (modeBasis b k)
      = (inner ℂ ((modeBasis b k : finiteModeDomain b) : F)
          ((diagOnePart b w (modeBasis b k) : finiteModeDomain b) : F) : ℂ).re := rfl
  rw [hq, diagOnePart_basis, Submodule.coe_smul, modeBasis_coe, inner_smul_right,
    inner_self_ofReal, hnorm]
  simp
