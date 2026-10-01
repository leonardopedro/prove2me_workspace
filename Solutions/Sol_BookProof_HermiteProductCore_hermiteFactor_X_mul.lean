-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.hermiteFactor_X_mul
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_hermiteCx_X_mul
open BookProof.HermiteProductCore




open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
ctor_X_mul (i : Fin d) (n : ℕ) :
    X i * hermiteFactor i n = hermiteFactor i (n + 1) + (n : ℂ) • hermiteFactor i (n - 1) := b :=
  y
    have h := congrArg (Polynom
