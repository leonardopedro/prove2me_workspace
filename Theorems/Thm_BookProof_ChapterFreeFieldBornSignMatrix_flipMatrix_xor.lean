-- Generated from ChapterFreeFieldBornSignMatrix.lean — theorem BookProof.ChapterFreeFieldBornSignMatrix.flipMatrix_xor
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBornSignMatrix

variable {n : ℕ}


open BookProof.ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignHom



theorem BookProof.ChapterFreeFieldBornSignMatrix.flipMatrix_xor (b₁ b₂ : Fin n → Bool) :
    flipMatrix (fun k => xor (b₁ k) (b₂ k)) = flipMatrix b₁ * flipMatrix b₂ := by sorry
