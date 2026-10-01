-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.orthonormal_hermiteLp
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

fine (memLp_congr_ae (Filter.Eventually.of_forall fun x => ?_)).mp h
  simp only [hermiteC, hermiteFun, Polynomial.eval_mu := by sorry
