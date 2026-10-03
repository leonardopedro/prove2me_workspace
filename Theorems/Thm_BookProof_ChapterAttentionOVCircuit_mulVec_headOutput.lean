-- Generated from ChapterAttentionOVCircuit.lean — theorem BookProof.ChapterAttentionOVCircuit.mulVec_headOutput
import Mathlib
import Definitions.Def_ChapterAttentionOVCircuit
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness

variable {d n p m : ℕ}


open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionOVCircuit.mulVec_headOutput (A : Matrix (Fin p) (Fin n) ℝ) (beta : ℝ) (s : Fin m → ℝ)
    (v : Fin m → (Fin n → ℝ)) :
    A *ᵥ headOutput beta s v = headOutput beta s (fun j => A *ᵥ v j) := by sorry
