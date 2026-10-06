-- Generated from ChapterA4f.lean — theorem BookProof.ChapterA4f.boostZ_conj_mem
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA5
import Mathlib
import Definitions.Def_ChapterA4f
import Definitions.Def_ChapterA4d
open BookProof.ChapterA4f


open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3 BookProof.ChapterA5

theorem BookProof.ChapterA4f.boostZ_conj_mem {l : ℂ} (hl : l ≠ 0) {T : Matrix (Fin 2) (Fin 2) ℂ}
    (hT : T ∈ SEtwo) : boostZ l * T * boostZ l⁻¹ ∈ SEtwo := by sorry
