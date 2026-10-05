-- Generated from ChapterF1.lean — solution of BookProof.ChapterF1.field_ccr
import Mathlib
import Definitions.Def_ChapterF1
open BookProof.ChapterF1



open Polynomial Finset
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    fieldPhi ∘ₗ fieldPi - fieldPi ∘ₗ fieldPhi = (2 * Complex.I) • LinearMap.id := by

  ext p
  unfold fieldPhi fieldPi
  simp [← mul_assoc, ← Polynomial.C_mul_X_pow_eq_monomial,
    Polynomial.coeff_X_pow, mul_sub, mul_add,
    mul_comm, LinearMap.comp_apply, LinearMap.smul_apply,
    LinearMap.add_apply, LinearMap.sub_apply]
  split_ifs <;> ring
