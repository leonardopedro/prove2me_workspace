-- Generated from ChapterSmGaugeRepresentation.lean — theorem BookProof.SmGaugeRep.kronecker_sub
import Definitions.Def_ChapterYangMillsSU3
import Definitions.Def_ChapterSmBrstGhost
import Mathlib
import Definitions.Def_ChapterSmGaugeRepresentation
open BookProof.SmGaugeRep



open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.SmBrstGhost

noncomputable section

variable {S3 : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ} {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}

theorem BookProof.SmGaugeRep.kronecker_sub (C : Matrix (Fin 3) (Fin 3) ℂ) (A B : Matrix (Fin 2) (Fin 2) ℂ) :
    C ⊗ₖ (A - B) = C ⊗ₖ A - C ⊗ₖ B := by sorry
