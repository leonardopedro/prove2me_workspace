-- Generated from ChapterAttentionOVCircuit.lean — solution of BookProof.ChapterAttentionOVCircuit.ovOutput_mem_range
import Mathlib
import Definitions.Def_ChapterAttentionOVCircuit
import Definitions.Def_ChapterAttentionOutput
open BookProof.ChapterAttentionOutput
open BookProof.ChapterAttentionOVCircuit



open scoped BigOperators

noncomputable section


open Matrix BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d n p m : ℕ}

variable {d n p m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (WO : Matrix (Fin n) (Fin d) ℝ)
    (WV : Matrix (Fin d) (Fin n) ℝ) (x : Fin m → (Fin n → ℝ)) :
    ovOutput beta s WO WV x ∈ LinearMap.range (Matrix.mulVecLin WO) := ⟨headOutput beta s (fun j => WV *ᵥ x j), rfl⟩
