-- Generated from ChapterH1.lean — theorem BookProof.ChapterH1.phi_succ_apply
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1






open scoped BigOperators
open intervalIntegral


noncomputable section

theorem BookProof.ChapterH1.phi_succ_apply (k : ℕ) (z : ℂ) :
    phi (k + 1) z = ∫ s in (0 : ℝ)..1, Complex.exp (s * z) * (1 - s) ^ k / k.factorial := by sorry
