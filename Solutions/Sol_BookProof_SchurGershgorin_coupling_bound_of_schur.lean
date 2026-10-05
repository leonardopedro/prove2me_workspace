-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.coupling_bound_of_schur
import Mathlib
import Definitions.Def_ChapterSchurGershgorinGap
import Theorems.Thm_BookProof_SchurGershgorin_abs_inner_block_le
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
    {m : ℕ} {eps : ℝ}
    (hrow : ∀ i, i < m → ∀ S : Finset ℕ, (∀ j ∈ S, m ≤ j) →
      ∑ j ∈ S, ‖entry b H i j‖ ≤ eps)
    (hcol : ∀ j, m ≤ j → ∀ S : Finset ℕ, (∀ i ∈ S, i < m) →
      ∑ i ∈ S, ‖entry b H i j‖ ≤ eps)
    (x w : finiteModeDomain b) (hx : (x : F) ∈ galerkinSpan b m)
    (hw : (w : F) ∈ tailSpan b m) :
    |(inner ℂ (x : F) (H w) : ℂ).re| ≤ eps * ‖(x : F)‖ * ‖(w : F)‖ := (Complex.abs_re_le_norm _).trans (abs_inner_block_le b H hrow hcol x w hx hw)
