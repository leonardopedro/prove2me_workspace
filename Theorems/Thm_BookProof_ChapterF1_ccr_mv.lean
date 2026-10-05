-- Generated from ChapterF1.lean — theorem BookProof.ChapterF1.ccr_mv
import Mathlib
import Definitions.Def_ChapterF1
open BookProof.ChapterF1


open Polynomial Finset
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF1.ccr_mv {n : ℕ} (i j : Fin n) (p : MvPolynomial (Fin n) ℂ) :
    (MvPolynomial.pderiv i) (MvPolynomial.X j * p)
      - MvPolynomial.X j * (MvPolynomial.pderiv i) p
      = (if i = j then p else 0) := by sorry
