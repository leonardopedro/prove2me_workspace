-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.entry_conj
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
theorem solution (b : HilbertBasis ℕ ℂ F) (H : finiteModeDomain b →ₗ[ℂ] F)
    (hsym : SymmetricOn _ H) (i j : ℕ) :
    (starRingEnd ℂ) (entry b H i j) = entry b H j i := by

  simp only [entry]
  rw [inner_conj_symm]
  simpa using hsym (bvec b j) (bvec b i)
