-- Generated from ChapterEulerGenericDensity.lean — theorem BookProof.ChapterEulerGenericDensity.product_probability
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
open BookProof.ChapterEulerGenericDensity


open scoped Matrix
open Matrix


variable {d : ℕ}


theorem BookProof.ChapterEulerGenericDensity.product_probability (θs : Fin n → ℝ) : (∏ k : Fin n, Real.cos (θs k) ^ 2) =
    (∏ k : Fin n, Real.cos (θs k) ^ 2) := by sorry
