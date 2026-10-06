-- Generated from ChapterH3.lean — theorem BookProof.ChapterH3.duhamel_scalar
import Mathlib
import Definitions.Def_ChapterH3
import Definitions.Def_ChapterH1
open BookProof.ChapterH1
open BookProof.ChapterH3


open scoped BigOperators
open intervalIntegral


noncomputable section

theorem BookProof.ChapterH3.duhamel_scalar (z : ℂ) (δ : ℝ) :
    (∫ s in (0:ℝ)..δ, Complex.exp ((↑(δ - s)) * z))
      = δ * BookProof.ChapterH1.phi 1 (δ * z) := by sorry
