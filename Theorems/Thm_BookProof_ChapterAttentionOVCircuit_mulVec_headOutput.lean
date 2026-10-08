-- Generated from ChapterAttentionOVCircuit.lean — theorem BookProof.ChapterAttentionOVCircuit.mulVec_headOutput
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionOVCircuit
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterAttentionOutput
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionOVCircuit


open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterAttentionOutput

variable {d n p m : ℕ}


theorem BookProof.ChapterAttentionOVCircuit.mulVec_headOutput (A : Matrix (Fin p) (Fin n) ℝ) (beta : ℝ) (s : Fin m → ℝ)
    (v : Fin m → (Fin n → ℝ)) :
    A *ᵥ headOutput beta s v = headOutput beta s (fun j => A *ᵥ v j) := by sorry
