-- Generated from ChapterA3e.lean — theorem BookProof.ChapterA3.lorentzLie_add
import Mathlib
import Definitions.Def_ChapterA3e
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.lorentzLie_add {A₁ A₂ : Matrix (Fin 4) (Fin 4) ℝ}
    (h1 : A₁ ∈ LorentzLie) (h2 : A₂ ∈ LorentzLie) : A₁ + A₂ ∈ LorentzLie := by sorry
