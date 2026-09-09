import Mathlib
import Definitions.Def_ChapterYangMillsBandBounds

open BookProof.ChapterYangMillsBandBounds




open Matrix
open scoped ComplexConjugate


variable {(fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) : IsBandDeg 4 (ymPoly fabc)}


theorem isBandDeg4_ymPoly := by sorry
