-- Generated from ChapterSmGaugeRepresentation.lean — solution of BookProof.SmGaugeRep.sub_kronecker
import Mathlib
import Definitions.Def_ChapterSmGaugeRepresentation
open BookProof.SmGaugeRep




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.SmBrstGhost

noncomputable section

variable {S3 : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ} {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (A B : Matrix (Fin 3) (Fin 3) ℂ) (C : Matrix (Fin 2) (Fin 2) ℂ) :
    (A - B) ⊗ₖ C = A ⊗ₖ C - B ⊗ₖ C := by

  ext i j; simp [Matrix.kroneckerMap_apply, sub_mul]
