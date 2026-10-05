-- Generated from ChapterSmGaugeRepresentation.lean — solution of BookProof.SmGaugeRep.smGenP_col_iso_comm
import Mathlib
import Definitions.Def_ChapterSmGaugeRepresentation
open BookProof.SmGaugeRep




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.SmBrstGhost

noncomputable section

variable {S3 : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ} {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin 3) (Fin 3) ℂ) (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (A ⊗ₖ (1 : Matrix (Fin 2) (Fin 2) ℂ)) * ((1 : Matrix (Fin 3) (Fin 3) ℂ) ⊗ₖ B)
      = ((1 : Matrix (Fin 3) (Fin 3) ℂ) ⊗ₖ B) * (A ⊗ₖ (1 : Matrix (Fin 2) (Fin 2) ℂ)) := by

  rw [← Matrix.mul_kronecker_mul, ← Matrix.mul_kronecker_mul, Matrix.mul_one, Matrix.one_mul,
    Matrix.mul_one, Matrix.one_mul]
