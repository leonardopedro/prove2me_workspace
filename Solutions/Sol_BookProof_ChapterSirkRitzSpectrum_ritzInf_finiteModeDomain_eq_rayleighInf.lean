-- Generated from ChapterSirkRitzSpectrum.lean — solution of BookProof.ChapterSirkRitzSpectrum.ritzInf_finiteModeDomain_eq_rayleighInf
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_rayleighSet_nonempty
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_rayleighSet_bddBelow
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_ritzSet_subset_rayleighSet
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_ritzInf_finiteModeDomain_le
open BookProof.ChapterSirkRitzSpectrum








noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin
open BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial F] (A : F →L[ℂ] F)
    (b : HilbertBasis ℕ ℂ F) :
    ritzInf (finiteModeRestrict A b) (finiteModeDomain b) = rayleighInf A := by

  refine le_antisymm ?_ ?_
  · refine le_csInf (rayleighSet_nonempty A) ?_
    rintro t ⟨x, hx1, rfl⟩
    exact ritzInf_finiteModeDomain_le A b hx1
  · refine csInf_le_csInf (rayleighSet_bddBelow A) ?_ (ritzSet_subset_rayleighSet A b)
    exact ⟨(inner ℂ (b 0) (A (b 0)) : ℂ).re, ⟨⟨b 0, Submodule.subset_span ⟨0, rfl⟩⟩,
      Submodule.subset_span ⟨0, rfl⟩, b.orthonormal.1 0, rfl⟩⟩
