-- Generated from ChapterA3e.lean — theorem BookProof.ChapterA3.hasAdLambda_smul
import Mathlib
import Definitions.Def_ChapterA3e
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.hasAdLambda_smul {G A : Matrix (Fin 4) (Fin 4) ℝ} (c : ℝ)
    (h : HasAdLambda G A) : HasAdLambda (c • G) (c • A) := by sorry
