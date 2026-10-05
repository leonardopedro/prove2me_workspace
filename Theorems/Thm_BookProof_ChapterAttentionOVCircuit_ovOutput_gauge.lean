-- Generated from ChapterAttentionOVCircuit.lean — theorem BookProof.ChapterAttentionOVCircuit.ovOutput_gauge
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionOVCircuit
open BookProof.ChapterAttentionOVCircuit

variable {d n p m : ℕ}


open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionOVCircuit.ovOutput_gauge (beta : ℝ) (s : Fin m → ℝ) {A B : Matrix (Fin d) (Fin d) ℝ}
    (hAB : A * B = 1) (WO : Matrix (Fin n) (Fin d) ℝ) (WV : Matrix (Fin d) (Fin n) ℝ)
    (x : Fin m → (Fin n → ℝ)) :
    ovOutput beta s (WO * A) (B * WV) x = ovOutput beta s WO WV x := by sorry
