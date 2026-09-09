import Mathlib
import Definitions.Def_ChapterCarlemanSimplex

open BookProof.ChapterCarlemanSimplex




open Matrix
open scoped ComplexConjugate


variable {¬ Summable (fun N : ℕ => ((N : ℝ) + 2)⁻¹)}


theorem not_summable_inv_natCast_add_two := by sorry
