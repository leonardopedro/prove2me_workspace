-- Generated from ChapterLorentzTranslation.lean — solution of BookProof.ChapterLorentzTranslation.gamma_nonneg
import Mathlib
import Definitions.Def_ChapterLorentzTranslation
open BookProof.ChapterLorentzTranslation




open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (w : Fin 3 → ℝ) : 0 ≤ gamma w := Real.sqrt_nonneg _
