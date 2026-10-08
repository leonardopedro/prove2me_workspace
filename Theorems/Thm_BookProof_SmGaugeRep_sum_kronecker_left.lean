-- Generated from ChapterSmGaugeRepresentation.lean — theorem BookProof.SmGaugeRep.sum_kronecker_left
import Definitions.Def_ChapterYangMillsSU3
import Definitions.Def_ChapterSmBrstGhost
import Mathlib
import Definitions.Def_ChapterSmGaugeRepresentation
open BookProof.SmGaugeRep



open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.SmBrstGhost

noncomputable section

variable {S3 : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ} {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}

theorem BookProof.SmGaugeRep.sum_kronecker_left {ι : Type*} (s : Finset ι) (A : ι → Matrix (Fin 3) (Fin 3) ℂ)
    (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (∑ i ∈ s, A i) ⊗ₖ B = ∑ i ∈ s, (A i ⊗ₖ B) := by sorry
