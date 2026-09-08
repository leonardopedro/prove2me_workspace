-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.pgMap_apply
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin d) ℂ) : pgMap p = pgLp p := rfl
