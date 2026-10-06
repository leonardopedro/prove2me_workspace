-- Generated from ChapterA3e.lean — theorem BookProof.ChapterA3.spinLie_traceless
import Mathlib
import Definitions.Def_ChapterA3e
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.spinLie_traceless {G : Matrix (Fin 4) (Fin 4) ℝ} (hG : IsSpinLie G) :
    G.trace = 0 := by sorry
