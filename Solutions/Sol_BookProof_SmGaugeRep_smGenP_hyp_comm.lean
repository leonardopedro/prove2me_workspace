-- Generated from ChapterSmGaugeRepresentation.lean — solution of BookProof.SmGaugeRep.smGenP_hyp_comm
import Mathlib
import Definitions.Def_ChapterSmGaugeRepresentation
open BookProof.SmGaugeRep




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.SmBrstGhost

noncomputable section

variable {S3 : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ} {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) (M : Matrix (Fin 3 × Fin 2) (Fin 3 × Fin 2) ℂ) :
    ((y : ℂ)) • (1 : Matrix (Fin 3 × Fin 2) (Fin 3 × Fin 2) ℂ) * M
      = M * ((y : ℂ)) • (1 : Matrix (Fin 3 × Fin 2) (Fin 3 × Fin 2) ℂ) := by

  rw [Matrix.smul_mul, Matrix.mul_smul, Matrix.one_mul, Matrix.mul_one]
