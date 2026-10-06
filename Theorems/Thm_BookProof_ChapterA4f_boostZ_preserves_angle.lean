-- Generated from ChapterA4f.lean — theorem BookProof.ChapterA4f.boostZ_preserves_angle
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA5
import Mathlib
import Definitions.Def_ChapterA4f
open BookProof.ChapterA4f


open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3 BookProof.ChapterA5

theorem BookProof.ChapterA4f.boostZ_preserves_angle {l : ℂ} (hl : l ≠ 0) (T : Matrix (Fin 2) (Fin 2) ℂ) :
    (boostZ l * T * boostZ l⁻¹) 0 0 = T 0 0 := by sorry
