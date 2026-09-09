import Mathlib
import Definitions.Def_ChapterStoneUnitary

open BookProof.ChapterStoneUnitary




open Matrix
open scoped ComplexConjugate


variable {(x : H) : Tendsto (fun t : ℝ => T.stoneU t x) (𝓝 0) (𝓝 x)}


theorem tendsto_stoneU_zero := by sorry
