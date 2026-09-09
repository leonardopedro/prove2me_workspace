-- Generated from ChapterH1.lean — theorem BookProof.ChapterH1.resolvent_identity
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1






open scoped BigOperators
open intervalIntegral


noncomputable section














variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]








variable {A : Type*} [Ring A] [Algebra ℂ A]

theorem BookProof.ChapterH1.resolvent_identity (a : A) (gj gm : ℂ) (Xj Xm : A)
    (_hjl : (algebraMap ℂ A gj - a) * Xj = 1) (hjr : Xj * (algebraMap ℂ A gj - a) = 1)
    (hml : (algebraMap ℂ A gm - a) * Xm = 1) (_hmr : Xm * (algebraMap ℂ A gm - a) = 1) :
    Xj - Xm = (gm - gj) • (Xj * Xm) := by sorry
