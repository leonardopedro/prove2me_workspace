-- Generated from ChapterA4d.lean — theorem BookProof.ChapterA3.upsilon_massless_lorentz
import Mathlib
import Definitions.Def_ChapterA4d
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.upsilon_massless_lorentz (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T ∈ SEtwo) :
    Upsilon T ∈ LorentzO ∧ FixesNullAxis (Upsilon T) := by sorry
