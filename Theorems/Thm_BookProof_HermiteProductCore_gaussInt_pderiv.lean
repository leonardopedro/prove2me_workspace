-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.gaussInt_pderiv
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

prod_coord (fun i t => (((t ^ (a i) * Real.exp (-t ^ 2 / 2) : ℝ)) : ℂ))]
  refine Finset.prod_congr rfl fun i _ => ?_
  rw [gaussMoment, gint]
  rw [← integral_complex_ofReal]
  refine integral_congr_ae (Filter.Eventually.of_forall fun := by sorry
