-- Generated from ChapterAttentionOVCircuit.lean — theorem BookProof.ChapterAttentionOVCircuit.ovOutput_mem_range
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionOVCircuit
import Definitions.Def_ChapterA4

variable {d n p m : ℕ}


open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionOVCircuit.ovOutput_mem_range (beta : ℝ) (s : Fin m → ℝ) (WO : Matrix (Fin n) (Fin d) ℝ)
    (WV : Matrix (Fin d) (Fin n) ℝ) (x : Fin m → (Fin n → ℝ)) :
    ovOutput beta s WO WV x ∈ LinearMap.range (Matrix.mulVecLin WO) := by sorry
