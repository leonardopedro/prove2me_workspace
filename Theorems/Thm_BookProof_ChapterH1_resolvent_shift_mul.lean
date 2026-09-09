-- Generated from ChapterH1.lean — theorem BookProof.ChapterH1.resolvent_shift_mul
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1






open scoped BigOperators
open intervalIntegral


noncomputable section














variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]








variable {A : Type*} [Ring A] [Algebra ℂ A]

theorem BookProof.ChapterH1.resolvent_shift_mul (a : A) (N h : ℂ) (j m : ℂ)
    (Xj Xm : A)
    (_hjl : (algebraMap ℂ A (N - h * j) - a) * Xj = 1)
    (hjr : Xj * (algebraMap ℂ A (N - h * j) - a) = 1)
    (hml : (algebraMap ℂ A (N - h * m) - a) * Xm = 1)
    (_hmr : Xm * (algebraMap ℂ A (N - h * m) - a) = 1) :
    Xj * (1 + (h * (m - j)) • Xm) = Xm := by sorry
