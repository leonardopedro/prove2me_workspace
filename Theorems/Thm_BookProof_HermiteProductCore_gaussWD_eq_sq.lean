-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.gaussWD_eq_sq
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

theorem BookProof.HermiteProductCore.gaussWD_eq_sq (x : Vd d) : gaussWD x = gaussD x * gaussD x := by sorry
