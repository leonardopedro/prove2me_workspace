-- Generated from ChapterH1.lean — solution of BookProof.ChapterH1.resolvent_identity
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1







open scoped BigOperators
open intervalIntegral


noncomputable section














variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]








variable {A : Type*} [Ring A] [Algebra ℂ A]

set_option maxHeartbeats 1000000 in
theorem solution (a : A) (gj gm : ℂ) (Xj Xm : A)
    (_hjl : (algebraMap ℂ A gj - a) * Xj = 1) (hjr : Xj * (algebraMap ℂ A gj - a) = 1)
    (hml : (algebraMap ℂ A gm - a) * Xm = 1) (_hmr : Xm * (algebraMap ℂ A gm - a) = 1) :
    Xj - Xm = (gm - gj) • (Xj * Xm) := by

  -- Using the fact that $Xj * (γ_m - a) = 1$ and $Xm * (γ_m - a) = 1$, we can simplify the
  -- expression.
  have h_simp : Xj * (gm - gj) • 1 * Xm = Xj * (algebraMap ℂ A gm - a) * Xm - Xj * (algebraMap ℂ A
      gj - a) * Xm := by
    simp [ sub_mul, mul_sub, Algebra.smul_def ];
  convert h_simp.symm using 1 <;> simp [ mul_assoc, hjr, hml ]
