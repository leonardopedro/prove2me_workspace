-- Generated from ChapterAttentionOVCircuit.lean — theorem BookProof.ChapterAttentionOVCircuit.ovMatrix_gauge
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionOVCircuit
open BookProof.ChapterAttentionOVCircuit


open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d n p m : ℕ}


theorem BookProof.ChapterAttentionOVCircuit.ovMatrix_gauge {A B : Matrix (Fin d) (Fin d) ℝ} (hAB : A * B = 1)
    (WO : Matrix (Fin n) (Fin d) ℝ) (WV : Matrix (Fin d) (Fin n) ℝ) :
    ovMatrix (WO * A) (B * WV) = ovMatrix WO WV := by sorry
