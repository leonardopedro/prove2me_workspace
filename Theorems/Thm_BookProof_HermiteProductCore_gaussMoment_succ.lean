-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.gaussMoment_succ
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore







open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

theorem BookProof.HermiteProductCore.gaussMoment_succ (k : ℕ) : gaussMoment (k + 1) = (k : ℝ) * gaussMoment (k - 1) := by sorry
