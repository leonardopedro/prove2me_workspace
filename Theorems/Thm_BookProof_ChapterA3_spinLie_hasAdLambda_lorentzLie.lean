-- Generated from ChapterA3e.lean — theorem BookProof.ChapterA3.spinLie_hasAdLambda_lorentzLie
import Mathlib
import Definitions.Def_ChapterA3e
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.spinLie_hasAdLambda_lorentzLie {G : Matrix (Fin 4) (Fin 4) ℝ}
    (hG : IsSpinLie G) : ∃ A, HasAdLambda G A ∧ A ∈ LorentzLie := by sorry
