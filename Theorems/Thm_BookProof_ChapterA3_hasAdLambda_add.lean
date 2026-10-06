-- Generated from ChapterA3e.lean — theorem BookProof.ChapterA3.hasAdLambda_add
import Mathlib
import Definitions.Def_ChapterA3e
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.hasAdLambda_add {G₁ G₂ A₁ A₂ : Matrix (Fin 4) (Fin 4) ℝ}
    (h1 : HasAdLambda G₁ A₁) (h2 : HasAdLambda G₂ A₂) :
    HasAdLambda (G₁ + G₂) (A₁ + A₂) := by sorry
