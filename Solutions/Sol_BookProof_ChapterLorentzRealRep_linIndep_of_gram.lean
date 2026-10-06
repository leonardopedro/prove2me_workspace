-- Generated from ChapterLorentzRealRep.lean — solution of BookProof.ChapterLorentzRealRep.linIndep_of_gram
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (v : Fin n → Matrix (Fin 4) (Fin 4) ℝ)
    (h : ∀ i j, ((v i)ᵀ * v j).trace = if i = j then (4 : ℝ) else 0) :
    LinearIndependent ℝ v := by

  rw [Fintype.linearIndependent_iff]
  intro g hg i
  have h_trace : ((∑ j, g j • v j)ᵀ * v i).trace = ∑ j, g j * ((v j)ᵀ * v i).trace := by
    simp [Matrix.transpose_sum, Matrix.sum_mul, Matrix.trace_sum, Matrix.trace_smul]
  simp_all
