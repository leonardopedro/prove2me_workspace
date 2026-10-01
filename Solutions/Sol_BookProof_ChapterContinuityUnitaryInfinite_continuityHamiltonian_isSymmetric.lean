-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.continuityHamiltonian_isSymmetric
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_momentum_isSymmetric
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_velocityOp_isSymmetric
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace

set_option maxHeartbeats 1000000 in
(ℤ)`: a bounded operator, self-adjoint precisely because of the
symmetrization. -/
noncomputable def continuityHamilto :=
  nian (v : LinfZ) : L2Z →L[ℂ] L2Z :=
    (1 / 2 : ℂ) • (momentum.comp (velocityOp v) + (velocityOp v).comp momentum)
  
  theorem continuityHamiltonian_isSymmetric (v : LinfZ) :
      (continuityHamiltonian v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
    intro f g
    have hp1 : ⟪momentum ((velocityOp v) f), g⟫_ℂ = ⟪(velocityOp v) f, momentum g⟫_ℂ :=
      momentum_isSymmetric _ _
    have hv1 : ⟪(velocityOp v) f, momentum g⟫_ℂ = ⟪f, (velocityOp v) (momentum g)⟫_ℂ :=
      velocityOp_isSymmetric v _ _
    have hv2 : ⟪(velocityOp v) (momentum f), g⟫_ℂ = ⟪momentum f, (velocityOp v) g⟫_ℂ :=
      velocityOp_isSymmetric v _ _
    have hp2 : ⟪momentum f, (velocityOp v) g⟫_ℂ = ⟪f, momentum ((velocityOp v) g)⟫_ℂ :=
      momentum_isSymmetric _ _
    simp only [continuityHamiltonian, ContinuousLinearMap.coe_coe,
      ContinuousLinearMap.smul_apply, Co
