-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.observable_matrix_identity
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4

variable {d k : ℕ}


open scoped BigOperators Matrix

theorem BookProof.ChapterF4.observable_matrix_identity {dd kk : ℕ} (W : Matrix (Fin dd) (Fin kk) ℂ)
    (a : Fin dd) (r s : Fin kk) :
    Matrix.trace ((Matrix.single r s (1 : ℂ) : Matrix (Fin kk) (Fin kk) ℂ)ᴴ * Wᴴ
        * (Matrix.single a a (1 : ℂ) : Matrix (Fin dd) (Fin dd) ℂ) * W)
      = (starRingEnd ℂ) (W a r) * W a s := by sorry
