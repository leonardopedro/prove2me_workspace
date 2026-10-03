-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.continuityUnitary_add
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace

set_option maxHeartbeats 1000000 in
1 ∧
      continuityUnitary v t * star (continuityUnitary v t) = 1 :=
  exp_smul_I_unitary _ (continuityHamiltonian_isSelfAdjoint v) t

theorem solution (v : LinfZ) : continuityUnitary v 0 = 1 :=
   v 0 = 1 := by
    simp [continuityUnitary]
  
  /-- `U` is a one-parameter group: `U (s + t) = U s ∘ U t`. -/
  theorem continuityUnitary_add (v : LinfZ) (s t : ℝ) :
      continuityUnitary v (s + t) = continuityUnitary v s * continuityUnitary v t := by
    let +nondep : NormedAlgebra ℚ (L2Z →L[ℂ] L2Z) := .restrictScalars ℚ ℂ _
    have hcomm : Commute (((s : ℂ) * Complex.I) • continuityHamiltonian v)
        (((t : ℂ) * Complex.I) • continuityHamiltonian v) := by
      simp [Commute, SemiconjBy, smul_smul, mul_comm]
    have hsum : (((s + t : ℝ) : ℂ) * Complex.I) • continuityHamiltonian v
        =
