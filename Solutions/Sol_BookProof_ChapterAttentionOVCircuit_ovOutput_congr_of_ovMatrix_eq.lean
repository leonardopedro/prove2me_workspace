-- Generated from ChapterAttentionOVCircuit.lean — solution of BookProof.ChapterAttentionOVCircuit.ovOutput_congr_of_ovMatrix_eq
import Mathlib
import Definitions.Def_ChapterAttentionOVCircuit
import Theorems.Thm_BookProof_ChapterAttentionOVCircuit_ovOutput_eq_headOutput
open BookProof.ChapterAttentionOVCircuit



open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d n p m : ℕ}

variable {d n p m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ)
    {WO₁ WO₂ : Matrix (Fin n) (Fin d) ℝ} {WV₁ WV₂ : Matrix (Fin d) (Fin n) ℝ}
    (h : ovMatrix WO₁ WV₁ = ovMatrix WO₂ WV₂) (x : Fin m → (Fin n → ℝ)) :
    ovOutput beta s WO₁ WV₁ x = ovOutput beta s WO₂ WV₂ x := by

  rw [ovOutput_eq_headOutput, ovOutput_eq_headOutput, h]
