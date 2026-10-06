-- Generated from ChapterPinOmega.lean — solution of BookProof.ChapterPinOmega.qjC_eq_dirac
import Mathlib
import Definitions.Def_ChapterPinOmega
open BookProof.ChapterPinOmega



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : dgamma 0 * ((-Complex.I) • mgamma5) = qjC := by

  rw [dgamma, qjC, Matrix.smul_mul, Matrix.mul_smul, smul_smul, neg_mul_neg,
    Complex.I_mul_I, neg_one_smul]
