-- Generated from ChapterSmGaugeRepresentation.lean — solution of BookProof.SmGaugeRep.kronecker_sub
import Mathlib
import Definitions.Def_ChapterSmGaugeRepresentation
open BookProof.SmGaugeRep




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.SmBrstGhost

noncomputable section

variable {S3 : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ} {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (C : Matrix (Fin 3) (Fin 3) ℂ) (A B : Matrix (Fin 2) (Fin 2) ℂ) :
    C ⊗ₖ (A - B) = C ⊗ₖ A - C ⊗ₖ B := by

  ext i j; simp [Matrix.kroneckerMap_apply, mul_sub]
