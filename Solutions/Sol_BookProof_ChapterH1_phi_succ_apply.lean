-- Generated from ChapterH1.lean — solution of BookProof.ChapterH1.phi_succ_apply
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1







open scoped BigOperators
open intervalIntegral


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (z : ℂ) :
    phi (k + 1) z = ∫ s in (0 : ℝ)..1, Complex.exp (s * z) * (1 - s) ^ k / k.factorial := rfl
