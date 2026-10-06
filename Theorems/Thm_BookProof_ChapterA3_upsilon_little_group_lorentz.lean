-- Generated from ChapterA4c.lean — theorem BookProof.ChapterA3.upsilon_little_group_lorentz
import Mathlib
import Definitions.Def_ChapterA4c
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.upsilon_little_group_lorentz (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T ∈ SUtwo) :
    Upsilon T ∈ LorentzO ∧ FixesTimeAxis (Upsilon T) := by sorry
