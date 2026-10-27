-- Generated from ChapterSmGaugeRepresentation.lean — solution of BookProof.SmGaugeRep.sum_kronecker_left
import Mathlib
import Definitions.Def_ChapterSmGaugeRepresentation
open BookProof.SmGaugeRep




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.SmBrstGhost

noncomputable section

variable {S3 : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ} {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (s : Finset ι) (A : ι → Matrix (Fin 3) (Fin 3) ℂ)
    (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (∑ i ∈ s, A i) ⊗ₖ B = ∑ i ∈ s, (A i ⊗ₖ B) := by

  classical
  induction s using Finset.induction with
  | empty => simp
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, Matrix.add_kronecker, ih]
