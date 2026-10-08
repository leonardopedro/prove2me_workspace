-- Generated from ChapterAttentionOVCircuit.lean — theorem BookProof.ChapterAttentionOVCircuit.ovOutput_congr_of_ovMatrix_eq
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionOVCircuit
open BookProof.ChapterAttentionOVCircuit


open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d n p m : ℕ}


theorem BookProof.ChapterAttentionOVCircuit.ovOutput_congr_of_ovMatrix_eq (beta : ℝ) (s : Fin m → ℝ)
    {WO₁ WO₂ : Matrix (Fin n) (Fin d) ℝ} {WV₁ WV₂ : Matrix (Fin d) (Fin n) ℝ}
    (h : ovMatrix WO₁ WV₁ = ovMatrix WO₂ WV₂) (x : Fin m → (Fin n → ℝ)) :
    ovOutput beta s WO₁ WV₁ x = ovOutput beta s WO₂ WV₂ x := by sorry
