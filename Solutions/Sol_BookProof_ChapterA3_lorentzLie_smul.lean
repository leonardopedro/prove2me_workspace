-- Generated from ChapterA3e.lean — solution of BookProof.ChapterA3.lorentzLie_smul
import Mathlib
import Definitions.Def_ChapterA3e
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution {A : Matrix (Fin 4) (Fin 4) ℝ} (c : ℝ)
    (h : A ∈ LorentzLie) : c • A ∈ LorentzLie := by

  simp only [LorentzLie, Set.mem_setOf_eq] at *
  rw [Matrix.smul_mul, Matrix.transpose_smul, Matrix.mul_smul, ← smul_add, h,
    smul_zero]
