-- Generated from ChapterA3e.lean — theorem BookProof.ChapterA3.lorentzLie_smul
import Mathlib
import Definitions.Def_ChapterA3e
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.lorentzLie_smul {A : Matrix (Fin 4) (Fin 4) ℝ} (c : ℝ)
    (h : A ∈ LorentzLie) : c • A ∈ LorentzLie := by sorry
