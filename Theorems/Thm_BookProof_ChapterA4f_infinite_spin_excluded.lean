-- Generated from ChapterA4f.lean — theorem BookProof.ChapterA4f.infinite_spin_excluded
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA5
import Mathlib
import Definitions.Def_ChapterA4f
import Definitions.Def_ChapterA4d
open BookProof.ChapterA4f


open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3 BookProof.ChapterA5

theorem BookProof.ChapterA4f.infinite_spin_excluded {T : Matrix (Fin 2) (Fin 2) ℂ} (hT : T ∈ SEtwo)
    (hc : T 1 0 ≠ 0) :
    ∀ c : ℂ, c ≠ 0 → ∃ l : ℂ, l ≠ 0 ∧ boostZ l * T * boostZ l⁻¹ ∈ SEtwo ∧
      (boostZ l * T * boostZ l⁻¹) 1 0 = c := by sorry
