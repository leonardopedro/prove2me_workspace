-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.gaussWD_eq_sq
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (x : Vd d) : gaussWD x = gaussD x * gaussD x := by

  rw [gaussWD, gaussD, ← Real.exp_add]
  ring_nf
